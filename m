Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qgzkp0smxzDq6b
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Apr 2016 09:46:26 +1000 (AEST)
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 8 Apr 2016 09:46:24 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 700313578053
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Apr 2016 09:46:18 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u37Nk6c662193732
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Apr 2016 09:46:18 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u37NjgQx002780
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Apr 2016 09:45:42 +1000
Date: Fri, 8 Apr 2016 09:45:18 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Russell Currey <ruscur@russell.cc>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V3 1/2] pseries/eeh: Handle RTAS delay requests in
 configure_bridge
Message-ID: <20160407234517.GB6644@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1460010507-24777-1-git-send-email-ruscur@russell.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1460010507-24777-1-git-send-email-ruscur@russell.cc>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Apr 07, 2016 at 04:28:26PM +1000, Russell Currey wrote:
>In the "ibm,configure-pe" and "ibm,configure-bridge" RTAS calls, the
>spec states that values of 9900-9905 can be returned, indicating that
>software should delay for 10^x (where x is the last digit, i.e. 990x)
>milliseconds and attempt the call again. Currently, the kernel doesn't
>know about this, and respecting it fixes some PCI failures when the
>hypervisor is busy.
>
>The delay is capped at 0.2 seconds.
>
>Cc: <stable@vger.kernel.org> # 3.10+
>Signed-off-by: Russell Currey <ruscur@russell.cc>

Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

>---
>V3 changelog:
> - Refactorings and rewordings thanks to Gavin
> - Treat return values >9902 as 9902 thanks to Tyrel
>---
> arch/powerpc/platforms/pseries/eeh_pseries.c | 51 ++++++++++++++++++++--------
> 1 file changed, 36 insertions(+), 15 deletions(-)
>
>diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
>index ac3ffd9..405baaf 100644
>--- a/arch/powerpc/platforms/pseries/eeh_pseries.c
>+++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
>@@ -615,29 +615,50 @@ static int pseries_eeh_configure_bridge(struct eeh_pe *pe)
> {
> 	int config_addr;
> 	int ret;
>+	/* Waiting 0.2s maximum before skipping configuration */
>+	int max_wait = 200;
> 
> 	/* Figure out the PE address */
> 	config_addr = pe->config_addr;
> 	if (pe->addr)
> 		config_addr = pe->addr;
> 
>-	/* Use new configure-pe function, if supported */
>-	if (ibm_configure_pe != RTAS_UNKNOWN_SERVICE) {
>-		ret = rtas_call(ibm_configure_pe, 3, 1, NULL,
>-				config_addr, BUID_HI(pe->phb->buid),
>-				BUID_LO(pe->phb->buid));
>-	} else if (ibm_configure_bridge != RTAS_UNKNOWN_SERVICE) {
>-		ret = rtas_call(ibm_configure_bridge, 3, 1, NULL,
>-				config_addr, BUID_HI(pe->phb->buid),
>-				BUID_LO(pe->phb->buid));
>-	} else {
>-		return -EFAULT;
>-	}
>+	while (max_wait > 0) {
>+		/* Use new configure-pe function, if supported */
>+		if (ibm_configure_pe != RTAS_UNKNOWN_SERVICE) {
>+			ret = rtas_call(ibm_configure_pe, 3, 1, NULL,
>+					config_addr, BUID_HI(pe->phb->buid),
>+					BUID_LO(pe->phb->buid));
>+		} else if (ibm_configure_bridge != RTAS_UNKNOWN_SERVICE) {
>+			ret = rtas_call(ibm_configure_bridge, 3, 1, NULL,
>+					config_addr, BUID_HI(pe->phb->buid),
>+					BUID_LO(pe->phb->buid));
>+		} else {
>+			return -EFAULT;
>+		}
> 
>-	if (ret)
>-		pr_warn("%s: Unable to configure bridge PHB#%d-PE#%x (%d)\n",
>-			__func__, pe->phb->global_number, pe->addr, ret);
>+		if (!ret)
>+			return ret;
>+
>+		/*
>+		 * If RTAS returns a delay value that's above 100ms, cut it
>+		 * down to 100ms in case firmware made a mistake.  For more
>+		 * on how these delay values work see rtas_busy_delay_time
>+		 */
>+		if (ret > RTAS_EXTENDED_DELAY_MIN+2 &&
>+		    ret <= RTAS_EXTENDED_DELAY_MAX)
>+			ret = RTAS_EXTENDED_DELAY_MIN+2;
>+
>+		max_wait -= rtas_busy_delay_time(ret);
>+
>+		if (max_wait < 0)
>+			break;
>+
>+		rtas_busy_delay(ret);
>+	}
> 
>+	pr_warn("%s: Unable to configure bridge PHB#%d-PE#%x (%d)\n",
>+		__func__, pe->phb->global_number, pe->addr, ret);
> 	return ret;
> }
> 
>-- 
>2.8.0
>
>_______________________________________________
>Linuxppc-dev mailing list
>Linuxppc-dev@lists.ozlabs.org
>https://lists.ozlabs.org/listinfo/linuxppc-dev
