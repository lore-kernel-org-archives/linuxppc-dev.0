Return-Path: <ruscur@russell.cc>
Received: from russell.cc (russell.cc [IPv6:2404:9400:2:0:216:3eff:fee0:3370])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qTYct2HM8zDqDJ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Mar 2016 11:35:10 +1100 (AEDT)
From: Russell Currey <ruscur@russell.cc>
To: linuxppc-dev@lists.ozlabs.org
Cc: Russell Currey <ruscur@russell.cc>
Subject: [PATCH] pseries/eeh: Handle RTAS delay requests in configure_bridge
Date: Tue, 22 Mar 2016 11:34:55 +1100
Message-Id: <1458606895-24620-1-git-send-email-ruscur@russell.cc>
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

Signed-off-by: Russell Currey <ruscur@russell.cc>
---
 arch/powerpc/platforms/pseries/eeh_pseries.c | 63 +++++++++++++++++++++-------
 1 file changed, 47 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
index ac3ffd9..c5603185 100644
--- a/arch/powerpc/platforms/pseries/eeh_pseries.c
+++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
@@ -614,30 +614,61 @@ static int pseries_eeh_get_log(struct eeh_pe *pe, int severity, char *drv_log, u
 static int pseries_eeh_configure_bridge(struct eeh_pe *pe)
 {
 	int config_addr;
-	int ret;
+	int ret = -1;
+	/* Waiting 0.2s maximum before skipping configuration */
+	int max_wait = 200;
+	int mwait;
 
 	/* Figure out the PE address */
 	config_addr = pe->config_addr;
 	if (pe->addr)
 		config_addr = pe->addr;
 
-	/* Use new configure-pe function, if supported */
-	if (ibm_configure_pe != RTAS_UNKNOWN_SERVICE) {
-		ret = rtas_call(ibm_configure_pe, 3, 1, NULL,
-				config_addr, BUID_HI(pe->phb->buid),
-				BUID_LO(pe->phb->buid));
-	} else if (ibm_configure_bridge != RTAS_UNKNOWN_SERVICE) {
-		ret = rtas_call(ibm_configure_bridge, 3, 1, NULL,
-				config_addr, BUID_HI(pe->phb->buid),
-				BUID_LO(pe->phb->buid));
-	} else {
-		return -EFAULT;
-	}
+	while (1) {
+		if (max_wait < 0)
+			goto err;
+
+		/* Use new configure-pe function, if supported */
+		if (ibm_configure_pe != RTAS_UNKNOWN_SERVICE) {
+			ret = rtas_call(ibm_configure_pe, 3, 1, NULL,
+					config_addr, BUID_HI(pe->phb->buid),
+					BUID_LO(pe->phb->buid));
+		} else if (ibm_configure_bridge != RTAS_UNKNOWN_SERVICE) {
+			ret = rtas_call(ibm_configure_bridge, 3, 1, NULL,
+					config_addr, BUID_HI(pe->phb->buid),
+					BUID_LO(pe->phb->buid));
+		} else {
+			return -EFAULT;
+		}
 
-	if (ret)
-		pr_warn("%s: Unable to configure bridge PHB#%d-PE#%x (%d)\n",
-			__func__, pe->phb->global_number, pe->addr, ret);
+		/*
+		 * If RTAS returns a delay value, it expects software to sleep
+		 * for 10^x milliseconds.  The max value it can return is thus
+		 * 10^5 (RTAS_EXTENDED_DELAY_MAX), which is way too long.
+		 */
 
+		switch (ret) {
+		case 0:
+			return ret;
+		case RTAS_EXTENDED_DELAY_MIN:
+			mwait = 1;
+			break;
+		case RTAS_EXTENDED_DELAY_MAX:
+			mwait = 10;
+			break;
+		case RTAS_EXTENDED_DELAY_MIN+2:
+			mwait = 100;
+			break;
+		default:
+			goto err;
+		}
+
+		max_wait -= mwait;
+		msleep(mwait);
+	}
+ err:
+	pr_warn("%s: Unable to configure bridge PHB#%d-PE#%x (%d)\n",
+		__func__, pe->phb->global_number, pe->addr, ret);
 	return ret;
 }
 
-- 
2.7.4
