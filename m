Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 293A2B6EDD
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Aug 2010 15:17:53 +1000 (EST)
Subject: Re: [PATCH] powerpc: inline ppc64_runlatch_off
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Anton Blanchard <anton@samba.org>
In-Reply-To: <20100806045315.GR29316@kryten>
References: <20100806045315.GR29316@kryten>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 06 Aug 2010 15:17:45 +1000
Message-ID: <1281071865.2168.28.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2010-08-06 at 14:53 +1000, Anton Blanchard wrote:
> I'm sick of seeing ppc64_runlatch_off in our profiles, so inline the
> heavily used part of it into the callers. To avoid a mess of circular includes
> I didn't add it as an inline function.

Considering that it's just an asm instruction or two, should we make it
inline asm and have it NOPed out instead using the feature sections ?

Cheers,
Ben.

> Signed-off-by: Anton Blanchard <anton@samba.org>
> ---
> 
> Index: powerpc.git/arch/powerpc/include/asm/reg.h
> ===================================================================
> --- powerpc.git.orig/arch/powerpc/include/asm/reg.h	2010-08-04 19:55:38.910793475 +1000
> +++ powerpc.git/arch/powerpc/include/asm/reg.h	2010-08-04 20:20:19.490751850 +1000
> @@ -951,7 +951,14 @@
>  #ifdef CONFIG_PPC64
>  
>  extern void ppc64_runlatch_on(void);
> -extern void ppc64_runlatch_off(void);
> +extern void __ppc64_runlatch_off(void);
> +
> +#define ppc64_runlatch_off()					\
> +	do {							\
> +		if (cpu_has_feature(CPU_FTR_CTRL) &&		\
> +		    test_thread_flag(TIF_RUNLATCH))		\
> +			__ppc64_runlatch_off();			\
> +	} while (0);
>  
>  extern unsigned long scom970_read(unsigned int address);
>  extern void scom970_write(unsigned int address, unsigned long value);
> Index: powerpc.git/arch/powerpc/kernel/process.c
> ===================================================================
> --- powerpc.git.orig/arch/powerpc/kernel/process.c	2010-08-04 19:55:38.890747120 +1000
> +++ powerpc.git/arch/powerpc/kernel/process.c	2010-08-04 20:15:27.573241044 +1000
> @@ -1198,19 +1198,17 @@ void ppc64_runlatch_on(void)
>  	}
>  }
>  
> -void ppc64_runlatch_off(void)
> +void __ppc64_runlatch_off(void)
>  {
>  	unsigned long ctrl;
>  
> -	if (cpu_has_feature(CPU_FTR_CTRL) && test_thread_flag(TIF_RUNLATCH)) {
> -		HMT_medium();
> +	HMT_medium();
>  
> -		clear_thread_flag(TIF_RUNLATCH);
> +	clear_thread_flag(TIF_RUNLATCH);
>  
> -		ctrl = mfspr(SPRN_CTRLF);
> -		ctrl &= ~CTRL_RUNLATCH;
> -		mtspr(SPRN_CTRLT, ctrl);
> -	}
> +	ctrl = mfspr(SPRN_CTRLF);
> +	ctrl &= ~CTRL_RUNLATCH;
> +	mtspr(SPRN_CTRLT, ctrl);
>  }
>  #endif
>  
