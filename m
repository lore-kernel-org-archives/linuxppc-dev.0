Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qgzht0YJGzDq6b
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Apr 2016 09:44:45 +1000 (AEST)
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 8 Apr 2016 09:44:44 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id DB1F83578052
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Apr 2016 09:44:41 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u37NiXYZ9109778
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Apr 2016 09:44:41 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u37Ni8lR020644
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Apr 2016 09:44:09 +1000
Date: Fri, 8 Apr 2016 09:43:44 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Russell Currey <ruscur@russell.cc>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V3 2/2] pseries/eeh: Refactor the configure_bridge RTAS
 tokens
Message-ID: <20160407234344.GA6644@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1460010507-24777-1-git-send-email-ruscur@russell.cc>
 <1460010507-24777-2-git-send-email-ruscur@russell.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1460010507-24777-2-git-send-email-ruscur@russell.cc>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Apr 07, 2016 at 04:28:27PM +1000, Russell Currey wrote:
>The RTAS calls "ibm,configure-pe" and "ibm,configure-bridge" perform the
>same actions, however the former can skip configuration if unnecessary.
>The existing code treats them as different tokens even though only one
>will ever be called.  Refactor this by making a single token that is
>assigned during init.
>
>Signed-off-by: Russell Currey <ruscur@russell.cc>

Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

>---
>V3: Reorder commits so the previous patch doesn't depend on this
>
>I had a look at doing the same with some other duplicated tokens but
>they had slight differences in semantics so it wasn't helping clarity.
>---
> arch/powerpc/platforms/pseries/eeh_pseries.c | 28 ++++++++++++----------------
> 1 file changed, 12 insertions(+), 16 deletions(-)
>
>diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
>index 405baaf..3998e0f 100644
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
>@@ -81,7 +80,14 @@ static int pseries_eeh_init(void)
> 	ibm_get_config_addr_info2	= rtas_token("ibm,get-config-addr-info2");
> 	ibm_get_config_addr_info	= rtas_token("ibm,get-config-addr-info");
> 	ibm_configure_pe		= rtas_token("ibm,configure-pe");
>-	ibm_configure_bridge		= rtas_token("ibm,configure-bridge");
>+
>+	/*
>+	 * ibm,configure-pe and ibm,configure-bridge have the same semantics,
>+	 * however ibm,configure-pe can be faster.  If we can't find
>+	 * ibm,configure-pe then fall back to using ibm,configure-bridge.
>+	 */
>+	if (ibm_configure_pe == RTAS_UNKNOWN_SERVICE)
>+		ibm_configure_pe 	= rtas_token("ibm,configure-bridge");
> 
> 	/*
> 	 * Necessary sanity check. We needn't check "get-config-addr-info"
>@@ -93,8 +99,7 @@ static int pseries_eeh_init(void)
> 	    (ibm_read_slot_reset_state2 == RTAS_UNKNOWN_SERVICE &&
> 	     ibm_read_slot_reset_state == RTAS_UNKNOWN_SERVICE)	||
> 	    ibm_slot_error_detail == RTAS_UNKNOWN_SERVICE	||
>-	    (ibm_configure_pe == RTAS_UNKNOWN_SERVICE		&&
>-	     ibm_configure_bridge == RTAS_UNKNOWN_SERVICE)) {
>+	    ibm_configure_pe == RTAS_UNKNOWN_SERVICE) {
> 		pr_info("EEH functionality not supported\n");
> 		return -EINVAL;
> 	}
>@@ -624,18 +629,9 @@ static int pseries_eeh_configure_bridge(struct eeh_pe *pe)
> 		config_addr = pe->addr;
> 
> 	while (max_wait > 0) {
>-		/* Use new configure-pe function, if supported */
>-		if (ibm_configure_pe != RTAS_UNKNOWN_SERVICE) {
>-			ret = rtas_call(ibm_configure_pe, 3, 1, NULL,
>-					config_addr, BUID_HI(pe->phb->buid),
>-					BUID_LO(pe->phb->buid));
>-		} else if (ibm_configure_bridge != RTAS_UNKNOWN_SERVICE) {
>-			ret = rtas_call(ibm_configure_bridge, 3, 1, NULL,
>-					config_addr, BUID_HI(pe->phb->buid),
>-					BUID_LO(pe->phb->buid));
>-		} else {
>-			return -EFAULT;
>-		}
>+		ret = rtas_call(ibm_configure_pe, 3, 1, NULL,
>+				config_addr, BUID_HI(pe->phb->buid),
>+				BUID_LO(pe->phb->buid));
> 
> 		if (!ret)
> 			return ret;
>-- 
>2.8.0
>
>_______________________________________________
>Linuxppc-dev mailing list
>Linuxppc-dev@lists.ozlabs.org
>https://lists.ozlabs.org/listinfo/linuxppc-dev
