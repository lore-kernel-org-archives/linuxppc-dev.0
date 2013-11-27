Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B51172C00A1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Nov 2013 13:45:49 +1100 (EST)
Message-ID: <1385520341.9218.89.camel@pasglop>
Subject: Re: [PATCH v2 2/3] powerpc: use the jump label for cpu_has_feature
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kevin Hao <haokexin@gmail.com>
Date: Wed, 27 Nov 2013 13:45:41 +1100
In-Reply-To: <1378100726-32545-3-git-send-email-haokexin@gmail.com>
References: <1378100726-32545-1-git-send-email-haokexin@gmail.com>
 <1378100726-32545-3-git-send-email-haokexin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-09-02 at 13:45 +0800, Kevin Hao wrote:
> The cpu features are fixed once the probe of cpu features are done.
> And the function cpu_has_feature() does be used in some hot path.
> The checking of the cpu features for each time of invoking of
> cpu_has_feature() seems suboptimal. This tries to reduce this
> overhead of this check by using jump label. But we can only use
> the jump label for this check only after the execution of
> jump_label_init(), so we introduce another jump label to
> still do the feature check by default before all the cpu
> feature jump labels are initialized.

So I was looking at these and ...

> +static inline int cpu_has_feature(unsigned long feature)
> +{
> +	if (CPU_FTRS_ALWAYS & feature)
> +		return 1;
> +
> +	if (!(CPU_FTRS_POSSIBLE | feature))
> +		return 0;
> +
> +	if (static_key_false(&cpu_feat_keys_enabled)) {
> +		int i = __builtin_ctzl(feature);
> +
> +		return static_key_false(&cpu_feat_keys[i]);
> +	} else
> +		return !!(cur_cpu_spec->cpu_features & feature);
> +}

This is gross :-)

Have you checked the generated code ? I'm worried that we end up hitting
at least 2 branches every time, which might be enough to defeat the
purposes even if they are unconditional in term of performance and
code size...

Cheers,
Ben.

> +#else
>  static inline int cpu_has_feature(unsigned long feature)
>  {
>  	return (CPU_FTRS_ALWAYS & feature) ||
> @@ -10,5 +36,6 @@ static inline int cpu_has_feature(unsigned long feature)
>  		& cur_cpu_spec->cpu_features
>  		& feature);
>  }
> +#endif
>  
>  #endif /* __ASM_POWERPC_CPUFEATURE_H */
> diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
> index 597d954..50bd216 100644
> --- a/arch/powerpc/kernel/cputable.c
> +++ b/arch/powerpc/kernel/cputable.c
> @@ -21,6 +21,7 @@
>  #include <asm/prom.h>		/* for PTRRELOC on ARCH=ppc */
>  #include <asm/mmu.h>
>  #include <asm/setup.h>
> +#include <asm/cpufeatures.h>
>  
>  struct cpu_spec* cur_cpu_spec = NULL;
>  EXPORT_SYMBOL(cur_cpu_spec);
> @@ -2258,3 +2259,25 @@ struct cpu_spec * __init identify_cpu(unsigned long offset, unsigned int pvr)
>  
>  	return NULL;
>  }
> +
> +#ifdef CONFIG_JUMP_LABEL
> +struct static_key cpu_feat_keys[MAX_CPU_FEATURES];
> +struct static_key cpu_feat_keys_enabled;
> +
> +static __init int cpu_feat_keys_init(void)
> +{
> +	int i;
> +
> +	for (i = 0; i < MAX_CPU_FEATURES; i++) {
> +		unsigned long f = 1 << i;
> +
> +		if (cur_cpu_spec->cpu_features & f)
> +			static_key_slow_inc(&cpu_feat_keys[i]);
> +	}
> +
> +	static_key_slow_inc(&cpu_feat_keys_enabled);
> +
> +	return 0;
> +}
> +early_initcall(cpu_feat_keys_init);
> +#endif
