Return-Path: <clg@kaod.org>
Received: from 9.mo179.mail-out.ovh.net (9.mo179.mail-out.ovh.net
 [46.105.76.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xSkph4vqpzDqs4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Aug 2017 20:27:23 +1000 (AEST)
Received: from player168.ha.ovh.net (b6.ovh.net [213.186.33.56])
 by mo179.mail-out.ovh.net (Postfix) with ESMTP id 46C555B920
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Aug 2017 12:20:29 +0200 (CEST)
Subject: Re: [PATCH 07/10] powerpc/xive: add XIVE exploitation mode to CAS
To: linuxppc-dev@lists.ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 David Gibson <david@gibson.dropbear.id.au>
References: <1502182579-990-1-git-send-email-clg@kaod.org>
 <1502182579-990-8-git-send-email-clg@kaod.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <5548205c-9621-6677-2708-8094b1ac552c@kaod.org>
Date: Thu, 10 Aug 2017 12:20:22 +0200
MIME-Version: 1.0
In-Reply-To: <1502182579-990-8-git-send-email-clg@kaod.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/08/2017 10:56 AM, Cédric Le Goater wrote:
> On POWER9, the Client Architecture Support (CAS) negotiation process
> determines whether the guest operates in XIVE Legacy compatibility or
> in XIVE exploitation mode.
> 
> Now that we have initial guest support for the XIVE interrupt
> controller, let's inform the hypervisor what we can do.
> 
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>  arch/powerpc/kernel/prom_init.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
> index 613f79f03877..25c14f543bd7 100644
> --- a/arch/powerpc/kernel/prom_init.c
> +++ b/arch/powerpc/kernel/prom_init.c
> @@ -177,6 +177,7 @@ struct platform_support {
>  	bool hash_mmu;
>  	bool radix_mmu;
>  	bool radix_gtse;
> +	bool xive;
>  };
>  
>  /* Platforms codes are now obsolete in the kernel. Now only used within this
> @@ -1054,6 +1055,12 @@ static void __init prom_parse_platform_support(u8 index, u8 val,
>  			support->radix_gtse = true;
>  		}
>  		break;
> +	case OV5_INDX(OV5_XIVE_SUPPORT): /* XIVE Exploitation mode */
> +		if (val & OV5_FEAT(OV5_XIVE_SUPPORT)) {

This should be :

+		if (val & OV5_FEAT(OV5_XIVE_EXPLOIT)) {

I will fix it in the next version of the patchset.

C.

> +			prom_debug("XIVE - exploitation mode\n");
> +			support->xive = true;
> +		}
> +		break;
>  	}
>  }
>  
> @@ -1062,7 +1069,8 @@ static void __init prom_check_platform_support(void)
>  	struct platform_support supported = {
>  		.hash_mmu = false,
>  		.radix_mmu = false,
> -		.radix_gtse = false
> +		.radix_gtse = false,
> +		.xive = false
>  	};
>  	int prop_len = prom_getproplen(prom.chosen,
>  				       "ibm,arch-vec-5-platform-support");
> @@ -1095,6 +1103,11 @@ static void __init prom_check_platform_support(void)
>  		/* We're probably on a legacy hypervisor */
>  		prom_debug("Assuming legacy hash support\n");
>  	}
> +
> +	if (supported.xive) {
> +		prom_debug("Asking for XIVE\n");
> +		ibm_architecture_vec.vec5.intarch = OV5_FEAT(OV5_XIVE_EXPLOIT);
> +	}
>  }
>  
>  static void __init prom_send_capabilities(void)
> 
