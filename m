Return-Path: <oss@buserror.net>
Received: from baldur.buserror.net (baldur.buserror.net [165.227.176.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40r7lG1X5PzDqrN
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2018 07:17:30 +1000 (AEST)
Message-ID: <1527020969.30674.13.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Diana Craciun <diana.craciun@nxp.com>, linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, leoyang.li@nxp.com
Date: Tue, 22 May 2018 15:29:29 -0500
In-Reply-To: <1526973031-9543-1-git-send-email-diana.craciun@nxp.com>
References: <1526973031-9543-1-git-send-email-diana.craciun@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [RFC PATCH] powerpc/fsl: Add barrier_nospec implementation for
 NXP PowerPC Book E
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-05-22 at 10:10 +0300, Diana Craciun wrote:
> Implement the barrier_nospec as a isync;sync instruction sequence.
> The implementation uses the infrastructure built for BOOK3S 64
> with the difference that for NXP platforms there is no firmware involved
> and the need for a speculation barrier is read from the device tree.
> I have used the same name for the property:
> fsl,needs-spec-barrier-for-bounds-check

Using the device tree this way means that anyone without an updated device
tree won't get the protection.  I also don't see any device tree updates --
which chips are affected?  Wouldn't it be more robust to just have the kernel
check the CPU type, especially given that it already does so for a lot of
other purposes?

> +#ifdef CONFIG_PPC_BOOK3S_64
>  void setup_barrier_nospec(void)
>  {
>  	bool enable;
> @@ -44,6 +46,12 @@ void setup_barrier_nospec(void)
>  
>  	enable_barrier_nospec(enable);
>  }
> +#elif CONFIG_PPC_FSL_BOOK3E
> +void setup_barrier_nospec(void)
> +{
> +	enable_barrier_nospec(true);
> +}
> +#endif

The call site is in FSL_BOOK3E-specific code so why not call
enable_barrier_nospec() directly from there?
  
> 
> +#ifdef CONFIG_PPC_BOOK3S_64
>  ssize_t cpu_show_meltdown(struct device *dev, struct device_attribute
> *attr, char *buf)
>  {
>  	bool thread_priv;
> @@ -155,3 +164,4 @@ ssize_t cpu_show_spectre_v2(struct device *dev, struct
> device_attribute *attr, c
>  
>  	return s.len;
>  }
> +#endif

No equivalent of this for FSL?

> +#ifdef CONFIG_PPC_FSL_BOOK3E
> +void do_barrier_nospec_fixups_range(bool enable, void *fixup_start, void
> *fixup_end)
> +{
> +	unsigned int instr[2], *dest;
> +	long *start, *end;
> +	int i;
> +
> +	start = fixup_start;
> +	end = fixup_end;
> +
> +	instr[0] = PPC_INST_NOP; /* nop */
> +	instr[1] = PPC_INST_NOP; /* nop */
> +
> +	if (enable) {
> +		pr_info("barrier_nospec: using isync; sync as a speculation
> barrier\n");
> +		instr[0] = PPC_INST_ISYNC;
> +		instr[1] = PPC_INST_SYNC;
> +	}
> +
> +	for (i = 0; start < end; start++, i++) {
> +		dest = (void *)start + *start;
> +		pr_devel("patching dest %lx\n", (unsigned long)dest);
> +
> +		patch_instruction(dest, instr[0]);
> +		patch_instruction(dest + 1, instr[1]);
> +
> +	}
> +
> +	pr_debug("barrier-nospec: patched %d locations\n", i);

Why patch nops in if not enabled?  Aren't those locations already nops?  For
that matter, how can this function even be called on FSL_BOOK3E with enable !=
true?

> diff --git a/arch/powerpc/platforms/85xx/corenet_generic.c
> b/arch/powerpc/platforms/85xx/corenet_generic.c
> index ac191a7..11bce3d 100644
> --- a/arch/powerpc/platforms/85xx/corenet_generic.c
> +++ b/arch/powerpc/platforms/85xx/corenet_generic.c
> @@ -59,6 +59,21 @@ void __init corenet_gen_pic_init(void)
>  	}
>  }
>  
> +static void setup_spec_barrier(void)
> +{
> +	struct device_node *np = of_find_node_by_name(NULL, "cpus");
> +
> +	if (np) {
> +		struct property *prop;
> +
> +		prop = of_find_property(np,
> +		       "fsl,needs-spec-barrier-for-bounds-check", NULL);
> +		if (prop)
> +			setup_barrier_nospec();
> +		of_node_put(np);
> +	}
> +}

Why is this in board code?

Should there be a way for the user to choose not to enable this (editing the
device tree doesn't count), for a use case that is not sufficiently security
sensitive to justify the performance loss?  What is the performance impact of
this patch?

-Scott
