Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 82F512C0097
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Sep 2012 14:30:08 +1000 (EST)
Message-ID: <1347251044.2385.144.camel@pasglop>
Subject: Re: [PATCH 5/6] powerpc: Macros for saving/restore PPR
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Haren Myneni <haren@linux.vnet.ibm.com>
In-Reply-To: <1347191001.3418.19.camel@hbabu-laptop>
References: <1347191001.3418.19.camel@hbabu-laptop>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 10 Sep 2012 14:24:04 +1000
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, mikey@neuling.org, paulus@samba.org,
 anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2012-09-09 at 04:43 -0700, Haren Myneni wrote:
> Several macros are defined for saving and restore user defined PPR value.
> 
> Signed-off-by: Haren Myneni <haren@us.ibm.com>
> ---
>  arch/powerpc/include/asm/exception-64s.h |   35 ++++++++++++++++++++++++++++++
>  arch/powerpc/include/asm/reg.h           |    1 +
>  2 files changed, 36 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
> index bfd3f1f..618fd18 100644
> --- a/arch/powerpc/include/asm/exception-64s.h
> +++ b/arch/powerpc/include/asm/exception-64s.h
> @@ -62,6 +62,41 @@
>  #define EXC_HV	H
>  #define EXC_STD
>  
> +/*
> + * PPR save/restore macros - Used on P7 or later processors
> + */
> +#define SAVE_PPR(area, ra, rb)						\
> +BEGIN_FTR_SECTION_NESTED(940)						\
> +	ld	ra,area+EX_PPR(r13);	/* Read PPR from paca */	\
> +	clrrdi	rb,r1,THREAD_SHIFT;	/* thread_info struct */	\
> +	std	ra,TI_PPR(rb);		/* Save PPR in thread_info */	\
> +END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,CPU_FTR_HAS_PPR,940)

Why the thread info and not the thread struct ?

Cheers,
Ben.

> +#define RESTORE_PPR(ra,rb)						\
> +BEGIN_FTR_SECTION_NESTED(941)						\
> +	clrrdi	ra,r1,THREAD_SHIFT;					\
> +	ld	rb,TI_PPR(ra);		/* Read PPR from thread_info */	\
> +	mtspr	SPRN_PPR,rb;		/* Restore PPR */		\
> +END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,CPU_FTR_HAS_PPR,941)
> +
> +#define RESTORE_PPR_PACA(area,ra)					\
> +BEGIN_FTR_SECTION_NESTED(942)						\
> +	ld	ra,area+EX_PPR(r13);					\
> +	mtspr	SPRN_PPR,ra;						\
> +END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,CPU_FTR_HAS_PPR,942)
> +
> +#define HMT_MEDIUM_NO_PPR						\
> +BEGIN_FTR_SECTION_NESTED(944)						\
> +	HMT_MEDIUM;							\
> +END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,0,944)  /*non P7*/		
> +
> +#define HMT_MEDIUM_HAS_PPR(area, ra)					\
> +BEGIN_FTR_SECTION_NESTED(943)						\
> +	mfspr	ra,SPRN_PPR;						\
> +	std	ra,area+EX_PPR(r13);					\
> +	HMT_MEDIUM;							\
> +END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,CPU_FTR_HAS_PPR,943) /* P7 */
> +
>  #define __EXCEPTION_PROLOG_1(area, extra, vec)				\
>  	GET_PACA(r13);							\
>  	std	r9,area+EX_R9(r13);	/* save r9 - r12 */		\
> diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
> index 6386086..dff2f89 100644
> --- a/arch/powerpc/include/asm/reg.h
> +++ b/arch/powerpc/include/asm/reg.h
> @@ -284,6 +284,7 @@
>  #define SPRN_DBAT6U	0x23C	/* Data BAT 6 Upper Register */
>  #define SPRN_DBAT7L	0x23F	/* Data BAT 7 Lower Register */
>  #define SPRN_DBAT7U	0x23E	/* Data BAT 7 Upper Register */
> +#define SPRN_PPR	0x380	/* SMT Thread status Register */
>  
>  #define SPRN_DEC	0x016		/* Decrement Register */
>  #define SPRN_DER	0x095		/* Debug Enable Regsiter */
