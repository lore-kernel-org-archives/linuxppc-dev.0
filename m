Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xLYZM0LknzDsRR
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Jul 2017 19:10:19 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Matt Brown <matthew.brown.dev@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] powerpc/powernv: Use darn instr for random_seed on p9
In-Reply-To: <20170707070249.15773-1-matthew.brown.dev@gmail.com>
References: <20170707070249.15773-1-matthew.brown.dev@gmail.com>
Date: Mon, 31 Jul 2017 19:10:15 +1000
Message-ID: <87lgn555vs.fsf@concordia.ellerman.id.au>
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

A few comments inline ...

Matt Brown <matthew.brown.dev@gmail.com> writes:
> Currently ppc_md.get_random_seed uses the powernv_get_random_long function.
> A guest calling this function would have to go through the hypervisor. The

This is not quite right. The powernv routine is only ever used on bare
metal. In a guest we use pseries_get_random_long(), which does go via
they hypervisor.

On both Power8 and Power9 there is a hardware RNG per chip. The
difference is that on Power8 we had to go and find it in the device tree
and read from it via MMIO. On Power9 that is all done transparently for
us by the DARN instruction.

> 'darn' instruction, introduced in POWER9, allows us to bypass this by
> directly obtaining a value from the mmio region.
>
> This patch adds a function for ppc_md.get_random_seed on p9,
> utilising the darn instruction.
>
> Signed-off-by: Matt Brown <matthew.brown.dev@gmail.com>
> ---
> v2:
> 	- remove repeat darn attempts
> 	- move hook to rng_init
> ---
>  arch/powerpc/include/asm/ppc-opcode.h |  4 ++++
>  arch/powerpc/platforms/powernv/rng.c  | 22 ++++++++++++++++++++++
>  2 files changed, 26 insertions(+)
>
> diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
> index c4ced1d..d5f7082 100644
> --- a/arch/powerpc/include/asm/ppc-opcode.h
> +++ b/arch/powerpc/include/asm/ppc-opcode.h
> @@ -134,6 +134,7 @@
>  #define PPC_INST_COPY			0x7c00060c
>  #define PPC_INST_COPY_FIRST		0x7c20060c
>  #define PPC_INST_CP_ABORT		0x7c00068c
> +#define PPC_INST_DARN			0x7c0005e6

That looks right to me.

> @@ -325,6 +326,9 @@
>  
>  /* Deal with instructions that older assemblers aren't aware of */
>  #define	PPC_CP_ABORT		stringify_in_c(.long PPC_INST_CP_ABORT)
> +#define PPC_DARN(t, l)		stringify_in_c(.long PPC_INST_DARN |  \
> +						___PPC_RT(t)	   |  \
> +						___PPC_RA(l))

But this is not quite.

The macros are:

#define ___PPC_RA(a)	(((a) & 0x1f) << 16)
#define ___PPC_RS(s)	(((s) & 0x1f) << 21)
#define ___PPC_RT(t)	___PPC_RS(t)

But the definition of darn is:

 +---------+---------+---------+---------+---------+---------+----+
 |    31   |    RT   |    /    |    L    |    /    |   755   | /  |
 | 31 - 26 | 25 - 21 | 20 - 18 | 17 - 16 | 15 - 11 |  10 - 1 | 0  |
 +---------+---------+---------+---------+---------+---------+----+

Using ___PPC_RT() gets you the right shift and mask, but because it's
the triple underscore verison, it doesn't check that you pass a register
number to it. You should use __PPC_RT() instead.

And ___PPC_RA() is not quite right. The L field is only 2 bits wide, not
the 5 that ___PPC_RA() allows.

We don't have a __PPC_L() macro, because L fields vary in size and
location. So I think you're best of open coding it, eg:

+#define PPC_DARN(t, l)		stringify_in_c(.long PPC_INST_DARN |  \
+						__PPC_RT(t)	   |  \
+						(((l) & 0x3) << 16))

> diff --git a/arch/powerpc/platforms/powernv/rng.c b/arch/powerpc/platforms/powernv/rng.c
> index 5dcbdea..ab6f411 100644
> --- a/arch/powerpc/platforms/powernv/rng.c
> +++ b/arch/powerpc/platforms/powernv/rng.c
> @@ -8,6 +8,7 @@
>   */
>  
>  #define pr_fmt(fmt)	"powernv-rng: " fmt
> +#define DARN_ERR 0xFFFFFFFFFFFFFFFFul

Usual place for constants is after all the includes, before the first
code or variables.

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
> +{
> +	unsigned long val;
> +
> +	/* Using DARN with L=1 - conditioned random number */

Actually L=1 is a 64-bit conditioned random number, vs L=0 for 32-bit.

> +	asm (PPC_DARN(%0, 1)"\n" : "=r"(val) :);
> +
> +	if (val == DARN_ERR)
> +		return 0;
> +
> +	*v = val;
> +
> +	return 1;
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

Buy yourself a vowel! ;)

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

I know we took the loop out of powernv_get_random_darn(), but we might
want to put it back in this case. ie. we don't want to skip registering
it just because we happened to get one error.

So perhaps 10 iterations and if they all fail then you don't register.
Also it's probably worth a pr_warn() if you can't get any good values,
because that shouldn't happen and we shouldn't silently continue.

cheers
