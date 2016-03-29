Return-Path: <ruscur@russell.cc>
Received: from russell.cc (russell.cc [IPv6:2404:9400:2:0:216:3eff:fee0:3370])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qYwM64xY0zDq62
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Mar 2016 13:53:22 +1100 (AEDT)
From: Russell Currey <ruscur@russell.cc>
To: linuxppc-dev@lists.ozlabs.org
Cc: Russell Currey <ruscur@russell.cc>
Subject: [PATCH V2 2/2] pseries/eeh: Handle RTAS delay requests in
 configure_bridge
Date: Tue, 29 Mar 2016 12:51:51 +1000
Message-Id: <1459219911-14110-2-git-send-email-ruscur@russell.cc>
In-Reply-To: <1459219911-14110-1-git-send-email-ruscur@russell.cc>
References: <1459219911-14110-1-git-send-email-ruscur@russell.cc>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In the configure_pe and configure_bridge RTAS calls, the spec states
that values of 9900-9905 can be returned, indicating that software
should delay for 10^x (where x is the last digit, i.e. 990x)
milliseconds and attempt the call again. Currently, the kernel doesn't
know about this, and respecting it fixes some PCI failures when the
hypervisor is busy.

The delay is capped at 0.2 seconds.

Cc: <stable@vger.kernel.org> # 3.10-
Signed-off-by: Russell Currey <ruscur@russell.cc>
---
V2: Use rtas_busy_delay and the new ibm_configure_pe token, refactoring
---
 arch/powerpc/platforms/pseries/eeh_pseries.c | 35 +++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
index 231b1df..c442b11 100644
--- a/arch/powerpc/platforms/pseries/eeh_pseries.c
+++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
@@ -619,20 +619,43 @@ static int pseries_eeh_configure_bridge(struct eeh_pe *pe)
 {
 	int config_addr;
 	int ret;
+	/* Waiting 0.2s maximum before skipping configuration */
+	int max_wait = 200;
+	int mwait;
 
 	/* Figure out the PE address */
 	config_addr = pe->config_addr;
 	if (pe->addr)
 		config_addr = pe->addr;
 
-	ret = rtas_call(ibm_configure_pe, 3, 1, NULL,
-			config_addr, BUID_HI(pe->phb->buid),
-			BUID_LO(pe->phb->buid));
+	while (max_wait > 0) {
+		ret = rtas_call(ibm_configure_pe, 3, 1, NULL,
+				config_addr, BUID_HI(pe->phb->buid),
+				BUID_LO(pe->phb->buid));
 
-	if (ret)
-		pr_warn("%s: Unable to configure bridge PHB#%d-PE#%x (%d)\n",
-			__func__, pe->phb->global_number, pe->addr, ret);
+		/*
+		 * RTAS can return a delay value of up to 10^5 milliseconds
+		 * (RTAS_EXTENDED_DELAY_MAX), which is too long.  Only respect
+		 * the delay if it's 100ms or less.
+		 */
 
+		switch (ret) {
+		case 0:
+			return ret;
+		case RTAS_EXTENDED_DELAY_MIN:
+		case RTAS_EXTENDED_DELAY_MIN+1:
+		case RTAS_EXTENDED_DELAY_MIN+2:
+			mwait = rtas_busy_delay(ret);
+			break;
+		default:
+			goto err;
+		}
+
+		max_wait -= mwait;
+	}
+err:
+	pr_warn("%s: Unable to configure bridge PHB#%d-PE#%x (%d)\n",
+		__func__, pe->phb->global_number, pe->addr, ret);
 	return ret;
 }
 
-- 
2.7.4
