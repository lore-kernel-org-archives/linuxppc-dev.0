Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2DC6F1A013E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2015 16:37:54 +1100 (AEDT)
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Fri, 27 Nov 2015 15:37:53 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 2B8B12CE8055
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2015 16:37:50 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tAR5bZjm30408914
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2015 16:37:43 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tAR5bHxZ024547
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2015 16:37:17 +1100
Message-ID: <5657EBF5.2030602@au1.ibm.com>
Date: Fri, 27 Nov 2015 16:36:53 +1100
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
MIME-Version: 1.0
To: Stewart Smith <stewart@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/4] powerpc/powernv: panic() on OPAL < V3
References: <1448599526-31073-1-git-send-email-stewart@linux.vnet.ibm.com>
 <1448599526-31073-2-git-send-email-stewart@linux.vnet.ibm.com>
In-Reply-To: <1448599526-31073-2-git-send-email-stewart@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 27/11/15 15:45, Stewart Smith wrote:
> The OpenPower Abstraction Layer firmware went through a couple
> of iterations in the lab before being released. What we now know
> as OPAL advertises itself as OPALv3.
>
> OPALv2 and OPALv1 never made it outside the lab, and the possibility
> of anyone at all ever building a mainline kernel today and expecting
> it to boot on such hardware is zero.
>
> Signed-off-by: Stewart Smith <stewart@linux.vnet.ibm.com>

Comment below.

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

> ---
>   arch/powerpc/platforms/powernv/opal.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
> index 4296d55e88f3..ad691fc15309 100644
> --- a/arch/powerpc/platforms/powernv/opal.c
> +++ b/arch/powerpc/platforms/powernv/opal.c
> @@ -103,11 +103,8 @@ int __init early_init_dt_scan_opal(unsigned long node,
>   		powerpc_firmware_features |= FW_FEATURE_OPALv2;
>   		powerpc_firmware_features |= FW_FEATURE_OPALv3;
>   		pr_info("OPAL V3 detected !\n");
> -	} else if (of_flat_dt_is_compatible(node, "ibm,opal-v2")) {
> -		powerpc_firmware_features |= FW_FEATURE_OPALv2;
> -		pr_info("OPAL V2 detected !\n");
>   	} else {
> -		pr_info("OPAL V1 detected !\n");
> +		panic("OPAL != V3 detected, no longer supported.\n")

In the event of an OPAL v4 that is for some reason not backwards 
compatible with V3, "*no longer* supported" might not make sense. This 
isn't a huge problem of course.

-- 
Andrew Donnellan              Software Engineer, OzLabs
andrew.donnellan@au1.ibm.com  Australia Development Lab, Canberra
+61 2 6201 8874 (work)        IBM Australia Limited
