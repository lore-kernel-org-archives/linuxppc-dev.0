Return-Path: <dja@axtens.net>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x6H3J1f84zDqb4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Jul 2017 19:34:19 +1000 (AEST)
Received: by mail-pg0-x241.google.com with SMTP id u62so16138865pgb.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Jul 2017 02:34:19 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: Matt Brown <matthew.brown.dev@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 mpe@ellerman.id.au
Subject: Re: [PATCH v2] powerpc/powernv: Use darn instr for random_seed on p9
In-Reply-To: <20170707070249.15773-1-matthew.brown.dev@gmail.com>
References: <20170707070249.15773-1-matthew.brown.dev@gmail.com>
Date: Tue, 11 Jul 2017 19:34:14 +1000
Message-ID: <8737a3mi5l.fsf@linkitivity.dja.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Matt,

> Currently ppc_md.get_random_seed uses the powernv_get_random_long function.
> A guest calling this function would have to go through the hypervisor. The
> 'darn' instruction, introduced in POWER9, allows us to bypass this by
> directly obtaining a value from the mmio region.
>
> This patch adds a function for ppc_md.get_random_seed on p9,
> utilising the darn instruction.

This patch looks pretty good - I'm not set up to test it but I have one
code-style nit:

> diff --git a/arch/powerpc/platforms/powernv/rng.c b/arch/powerpc/platforms/powernv/rng.c
> index 5dcbdea..ab6f411 100644
> --- a/arch/powerpc/platforms/powernv/rng.c
> +++ b/arch/powerpc/platforms/powernv/rng.c
> @@ -8,6 +8,7 @@
>   */
>  
>  #define pr_fmt(fmt)	"powernv-rng: " fmt
> +#define DARN_ERR 0xFFFFFFFFFFFFFFFFul
>  
>  #include <linux/kernel.h>
>  #include <linux/of.h>
> @@ -16,6 +17,7 @@
>  #include <linux/slab.h>
>  #include <linux/smp.h>
>  #include <asm/archrandom.h>
> +#include <asm/cputable.h>
>  #include <asm/io.h>
>  #include <asm/prom.h>
>  #include <asm/machdep.h>
> @@ -67,6 +69,21 @@ int powernv_get_random_real_mode(unsigned long *v)
>  	return 1;
>  }
>  
> +int powernv_get_random_darn(unsigned long *v)

This is only referenced in this file so it should probably be labelled
as 'static'.

> +{
> +	unsigned long val;
> +
> +	/* Using DARN with L=1 - conditioned random number */
> +	asm (PPC_DARN(%0, 1)"\n" : "=r"(val) :);
> +
> +	if (val == DARN_ERR)
> +		return 0;
> +
> +	*v = val;
> +
> +	return 1;

I was a bit confused to see 1 representing success - I think I have been
in userspace too long. But I checked against pseries_get_random_long and
it is in fact correct, so good for you!

An excellent followup patch would be changing the type of this function
to be bool rather than int, but no pressure :)

Regards,
Daniel

> +}
> +
>  int powernv_get_random_long(unsigned long *v)
>  {
>  	struct powernv_rng *rng;
> @@ -136,6 +153,7 @@ static __init int rng_create(struct device_node *dn)
>  static __init int rng_init(void)
>  {
>  	struct device_node *dn;
> +	unsigned long drn_test;
>  	int rc;
>  
>  	for_each_compatible_node(dn, NULL, "ibm,power-rng") {
> @@ -150,6 +168,10 @@ static __init int rng_init(void)
>  		of_platform_device_create(dn, NULL, NULL);
>  	}
>  
> +	if (cpu_has_feature(CPU_FTR_ARCH_300) &&
> +	    powernv_get_random_darn(&drn_test))
> +		ppc_md.get_random_seed = powernv_get_random_darn;
> +
>  	return 0;
>  }
>  machine_subsys_initcall(powernv, rng_init);
> -- 
> 2.9.3
