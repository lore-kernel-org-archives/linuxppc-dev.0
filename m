Return-Path: <galak@kernel.crashing.org>
In-Reply-To: <20061026104338.99e89782.vwool@ru.mvista.com>
References: <20061026104338.99e89782.vwool@ru.mvista.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <4A3EAE00-3647-4B72-8CDF-ED6E0ADEC910@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [1/2] build failure for E500 CPUs w/ CONFIG_OPROFLE=y
Date: Thu, 26 Oct 2006 08:57:59 -0500
To: Vitaly Wool <vwool@ru.mvista.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	oprofile-list@lists.sourceforge.net,
	"linuxppc-embedded \(\(\(\(E-Mail\)\)\)\)" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 26, 2006, at 1:43 AM, Vitaly Wool wrote:

> Below is the patch for the problem described in "[0/2] build  
> failure for 8540 w/ CONFIG_OPROFLE=y" letter representing the first  
> approach. This approach is based on (pretty reasonable) assumption  
> that op_model_7450.c is applicable only to 6XX, so let's compile it  
> only when CONFIG_6XX==y. This results in more #ifdef's in arch/ 
> powerpc/oprofile/common.c, which doesn't look good to me. I'd  
> rather "switch (cur_cpu_spec->oprofile_type) ..." to SoC-dependent  
> header files arranging that one as static inline func...
>
> Anyway, here's the patch.
>
>  arch/powerpc/oprofile/Makefile |    2 +-
>  arch/powerpc/oprofile/common.c |    7 +++----
>  2 files changed, 4 insertions(+), 5 deletions(-)
>
> Signed-off-by: Vitaly Wool <vwool@ru.mvista.com>

This makes sense to me since we are just increasing kernel code size  
for code we would never use for an FSL_BOOKE part if we do it the  
other way.  I dont think its that much more messy with the ifdef's.

If you want to do the other cleanup as well I've got no issue with  
that, but we really should NOT build in support for 7450 into a  
FSL_BOOKE kernel when reasonably avoidable.

- kumar

>
> Index: linux-2.6.18/arch/powerpc/oprofile/Makefile
> ===================================================================
> --- linux-2.6.18.orig/arch/powerpc/oprofile/Makefile
> +++ linux-2.6.18/arch/powerpc/oprofile/Makefile
> @@ -13,4 +13,4 @@ DRIVER_OBJS := $(addprefix ../../../driv
>  oprofile-y := $(DRIVER_OBJS) common.o backtrace.o
>  oprofile-$(CONFIG_PPC64) += op_model_rs64.o op_model_power4.o
>  oprofile-$(CONFIG_FSL_BOOKE) += op_model_fsl_booke.o
> -oprofile-$(CONFIG_PPC32) += op_model_7450.o
> +oprofile-$(CONFIG_6XX) += op_model_7450.o
> Index: linux-2.6.18/arch/powerpc/oprofile/common.c
> ===================================================================
> --- linux-2.6.18.orig/arch/powerpc/oprofile/common.c
> +++ linux-2.6.18/arch/powerpc/oprofile/common.c
> @@ -135,19 +135,18 @@ int __init oprofile_arch_init(struct opr
>  		return -ENODEV;
>
>  	switch (cur_cpu_spec->oprofile_type) {
> -#ifdef CONFIG_PPC64
> +#if defined(CONFIG_PPC64)
>  		case PPC_OPROFILE_RS64:
>  			model = &op_model_rs64;
>  			break;
>  		case PPC_OPROFILE_POWER4:
>  			model = &op_model_power4;
>  			break;
> -#else
> +#elif defined (CONFIG_6XX)
>  		case PPC_OPROFILE_G4:
>  			model = &op_model_7450;
>  			break;
> -#endif
> -#ifdef CONFIG_FSL_BOOKE
> +#elif defined (CONFIG_FSL_BOOKE)
>  		case PPC_OPROFILE_BOOKE:
>  			model = &op_model_fsl_booke;
>  			break;
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
