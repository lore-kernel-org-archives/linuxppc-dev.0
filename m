Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 99DAEDE2A2
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Jun 2008 00:07:44 +1000 (EST)
Message-Id: <B2FEFA8A-8814-44BE-81E5-8E2A873C2A1F@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Michael Neuling <mikey@neuling.org>
In-Reply-To: <20080624105750.2D695702A4@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [PATCH 7/9] powerpc: Add VSX assembler code macros
Date: Tue, 24 Jun 2008 09:06:13 -0500
References: <20080624105750.2D695702A4@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 24, 2008, at 5:57 AM, Michael Neuling wrote:

> This adds the macros for the VSX load/store instruction as most
> binutils are not going to support this for a while.
>
> Also add VSX register save/restore macros and vsr[0-63] register  
> definitions.
>
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> ---
>
> include/asm-powerpc/ppc_asm.h |  127 ++++++++++++++++++++++++++++++++ 
> ++++++++++
> 1 file changed, 127 insertions(+)
>
> Index: linux-2.6-ozlabs/include/asm-powerpc/ppc_asm.h
> ===================================================================
> --- linux-2.6-ozlabs.orig/include/asm-powerpc/ppc_asm.h
> +++ linux-2.6-ozlabs/include/asm-powerpc/ppc_asm.h
> @@ -74,6 +74,15 @@ END_FTR_SECTION_IFCLR(CPU_FTR_PURR);				
> 				REST_10GPRS(22, base)
> #endif
>
> +/*
> + * Define what the VSX XX1 form instructions will look like, then add
> + * the 128 bit load store instructions based on that.
> + */
> +#define VSX_XX1(xs, ra, rb)	(((xs) & 0x1f) << 21 | ((ra) << 16) |  \
> +				 ((rb) << 11) | (((xs) >> 5)))
> +
> +#define STXVD2X(xs, ra, rb)	.long (0x7c000798 | VSX_XX1((xs), (ra),  
> (rb)))
> +#define LXVD2X(xs, ra, rb)	.long (0x7c000698 | VSX_XX1((xs), (ra),  
> (rb)))
>
> #define SAVE_2GPRS(n, base)	SAVE_GPR(n, base); SAVE_GPR(n+1, base)
> #define SAVE_4GPRS(n, base)	SAVE_2GPRS(n, base); SAVE_2GPRS(n+2, base)
> @@ -110,6 +119,57 @@ END_FTR_SECTION_IFCLR(CPU_FTR_PURR);				
> #define REST_16VRS(n,b,base)	REST_8VRS(n,b,base); REST_8VRS(n 
> +8,b,base)
> #define REST_32VRS(n,b,base)	REST_16VRS(n,b,base); REST_16VRS(n 
> +16,b,base)
>
> +/* Save the lower 32 VSRs in the thread VSR region */
> +#define SAVE_VSR(n,b,base)	li b,THREAD_VSR0+(16*(n));   
> STXVD2X(n,b,base)
> +#define SAVE_2VSRS(n,b,base)	SAVE_VSR(n,b,base); SAVE_VSR(n+1,b,base)
> +#define SAVE_4VSRS(n,b,base)	SAVE_2VSRS(n,b,base); SAVE_2VSRS(n 
> +2,b,base)
> +#define SAVE_8VSRS(n,b,base)	SAVE_4VSRS(n,b,base); SAVE_4VSRS(n 
> +4,b,base)
> +#define SAVE_16VSRS(n,b,base)	SAVE_8VSRS(n,b,base); SAVE_8VSRS(n 
> +8,b,base)
> +#define SAVE_32VSRS(n,b,base)	SAVE_16VSRS(n,b,base); SAVE_16VSRS(n 
> +16,b,base)
> +#define REST_VSR(n,b,base)	li b,THREAD_VSR0+(16*(n));  
> LXVD2X(n,b,base)
> +#define REST_2VSRS(n,b,base)	REST_VSR(n,b,base); REST_VSR(n+1,b,base)
> +#define REST_4VSRS(n,b,base)	REST_2VSRS(n,b,base); REST_2VSRS(n 
> +2,b,base)
> +#define REST_8VSRS(n,b,base)	REST_4VSRS(n,b,base); REST_4VSRS(n 
> +4,b,base)
> +#define REST_16VSRS(n,b,base)	REST_8VSRS(n,b,base); REST_8VSRS(n 
> +8,b,base)
> +#define REST_32VSRS(n,b,base)	REST_16VSRS(n,b,base); REST_16VSRS(n 
> +16,b,base)
> +/* Save the upper 32 VSRs (32-63) in the thread VSX region (0-31) */
> +#define SAVE_VSRU(n,b,base)	li b,THREAD_VR0+(16*(n));  STXVD2X(n 
> +32,b,base)
> +#define SAVE_2VSRSU(n,b,base)	SAVE_VSRU(n,b,base); SAVE_VSRU(n 
> +1,b,base)
> +#define SAVE_4VSRSU(n,b,base)	SAVE_2VSRSU(n,b,base); SAVE_2VSRSU(n 
> +2,b,base)
> +#define SAVE_8VSRSU(n,b,base)	SAVE_4VSRSU(n,b,base); SAVE_4VSRSU(n 
> +4,b,base)
> +#define SAVE_16VSRSU(n,b,base)	SAVE_8VSRSU(n,b,base); SAVE_8VSRSU(n 
> +8,b,base)
> +#define SAVE_32VSRSU(n,b,base)	SAVE_16VSRSU(n,b,base);  
> SAVE_16VSRSU(n+16,b,base)
> +#define REST_VSRU(n,b,base)	li b,THREAD_VR0+(16*(n)); LXVD2X(n 
> +32,b,base)
> +#define REST_2VSRSU(n,b,base)	REST_VSRU(n,b,base); REST_VSRU(n 
> +1,b,base)
> +#define REST_4VSRSU(n,b,base)	REST_2VSRSU(n,b,base); REST_2VSRSU(n 
> +2,b,base)
> +#define REST_8VSRSU(n,b,base)	REST_4VSRSU(n,b,base); REST_4VSRSU(n 
> +4,b,base)
> +#define REST_16VSRSU(n,b,base)	REST_8VSRSU(n,b,base); REST_8VSRSU(n 
> +8,b,base)
> +#define REST_32VSRSU(n,b,base)	REST_16VSRSU(n,b,base);  
> REST_16VSRSU(n+16,b,base)
> +
> +#ifdef CONFIG_VSX

I think we should do this in fpu.S so its clearly in the code when  
reading it what's going on.

>
> +#define REST_32FPVSRS(n,c,base)						\
> +BEGIN_FTR_SECTION							\
> +	b	2f;							\
> +END_FTR_SECTION_IFSET(CPU_FTR_VSX);					\
> +	REST_32FPRS(n,base);						\
> +	b	3f;							\
> +2:	REST_32VSRS(n,c,base);						\
> +3:
> +
> +#define SAVE_32FPVSRS(n,c,base)						\
> +BEGIN_FTR_SECTION							\
> +	b	2f;							\
> +END_FTR_SECTION_IFSET(CPU_FTR_VSX);					\
> +	SAVE_32FPRS(n,base);						\
> +	b	3f;							\
> +2:	SAVE_32VSRS(n,c,base);						\
> +3:
> +
> +#else
> +#define REST_32FPVSRS(n,b,base)	REST_32FPRS(n, base)
> +#define SAVE_32FPVSRS(n,b,base)	SAVE_32FPRS(n, base)
> +#endif
