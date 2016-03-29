Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qYznD1QmmzDq5v
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Mar 2016 16:27:44 +1100 (AEDT)
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 29 Mar 2016 15:27:42 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 913342BB0055
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Mar 2016 16:27:36 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2T5RSSE11534844
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Mar 2016 16:27:36 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2T5R4Bb030324
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Mar 2016 16:27:04 +1100
Date: Tue, 29 Mar 2016 16:26:09 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Russell Currey <ruscur@russell.cc>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V2 1/2] pseries/eeh: Refactor the configure bridge RTAS
 tokens
Message-ID: <20160329052608.GA2614@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1459219911-14110-1-git-send-email-ruscur@russell.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1459219911-14110-1-git-send-email-ruscur@russell.cc>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 29, 2016 at 12:51:50PM +1000, Russell Currey wrote:
>The RTAS calls configure-pe and configure-bridge perform the same
>actions, however the former can skip configuration if unnecessary.  The
>existing code treats them as different tokens even though only one will
>ever be called.  Refactor this by making a single token that is assigned
>during init.
>
>Cc: <stable@vger.kernel.org> # 3.10-
>Signed-off-by: Russell Currey <ruscur@russell.cc>
>---
> arch/powerpc/platforms/pseries/eeh_pseries.c | 27 +++++++++++----------------
> 1 file changed, 11 insertions(+), 16 deletions(-)
>
>diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
>index ac3ffd9..231b1df 100644
>--- a/arch/powerpc/platforms/pseries/eeh_pseries.c
>+++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
>@@ -53,7 +53,6 @@ static int ibm_read_slot_reset_state2;
> static int ibm_slot_error_detail;
> static int ibm_get_config_addr_info;
> static int ibm_get_config_addr_info2;
>-static int ibm_configure_bridge;
> static int ibm_configure_pe;
> 
> /*
>@@ -81,7 +80,13 @@ static int pseries_eeh_init(void)
> 	ibm_get_config_addr_info2	= rtas_token("ibm,get-config-addr-info2");
> 	ibm_get_config_addr_info	= rtas_token("ibm,get-config-addr-info");
> 	ibm_configure_pe		= rtas_token("ibm,configure-pe");
>-	ibm_configure_bridge		= rtas_token("ibm,configure-bridge");
>+
>+	/*
>+	 * configure-pe and configure-bridge perform the same actions, however
>+	 * the former is preferred as it can skip configuration if unnecessary.
>+	 */
>+	if (ibm_configure_pe == RTAS_UNKNOWN_SERVICE)
>+		ibm_configure_pe	= rtas_token("ibm,configure-bridge");
> 
> 	/*
> 	 * Necessary sanity check. We needn't check "get-config-addr-info"
>@@ -93,8 +98,7 @@ static int pseries_eeh_init(void)
> 	    (ibm_read_slot_reset_state2 == RTAS_UNKNOWN_SERVICE &&
> 	     ibm_read_slot_reset_state == RTAS_UNKNOWN_SERVICE)	||
> 	    ibm_slot_error_detail == RTAS_UNKNOWN_SERVICE	||
>-	    (ibm_configure_pe == RTAS_UNKNOWN_SERVICE		&&
>-	     ibm_configure_bridge == RTAS_UNKNOWN_SERVICE)) {
>+	    ibm_configure_pe == RTAS_UNKNOWN_SERVICE) {
> 		pr_info("EEH functionality not supported\n");
> 		return -EINVAL;
> 	}

Since you're here, you can do similar thing to @ibm_read_slot_reset_state
and @ibm_read_slot_reset_state?

>@@ -621,18 +625,9 @@ static int pseries_eeh_configure_bridge(struct eeh_pe *pe)
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
>+	ret = rtas_call(ibm_configure_pe, 3, 1, NULL,
>+			config_addr, BUID_HI(pe->phb->buid),
>+			BUID_LO(pe->phb->buid));
> 

Russell, it seems not working if "ibm,configure-pe" and "ibm,configure-bridge" are all
missed from "/rtas". Also, I don't think we need backport it to 3.10+ as it's not fixing
any bugs if I'm correct enough.

Thanks,
Gavin


> 	if (ret)
> 		pr_warn("%s: Unable to configure bridge PHB#%d-PE#%x (%d)\n",
>-- 
>2.7.4
>
>_______________________________________________
>Linuxppc-dev mailing list
>Linuxppc-dev@lists.ozlabs.org
>https://lists.ozlabs.org/listinfo/linuxppc-dev
