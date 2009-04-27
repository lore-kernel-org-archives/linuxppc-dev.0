Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7F119DDED1
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Apr 2009 11:22:14 +1000 (EST)
Subject: Re: [PATCH 2/2] powerpc: Add 2.06 tlbie mnemonics
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Neuling <mikey@neuling.org>
In-Reply-To: <20090424062431.D3803120E7@localhost.localdomain>
References: <20090424062431.D3803120E7@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 27 Apr 2009 11:20:04 +1000
Message-Id: <1240795204.7169.9.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2009-04-24 at 16:24 +1000, Michael Neuling wrote:
> From: Milton Miller <miltonm@bga.com>
> 
> This adds the PowerPC 2.06 tlbie mnemonics and keeps backwards
> compatibilty for CPUs before 2.06.
> 
> Only useful for bare metal systems.  

I'd rather stick that in mmu features rather than cpu features to
save space in the later...

Cheers,
Ben.

> Signed-off-by: Milton Miller <miltonm@bga.com>
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> ---
> As they say, better out than in....
> ---
> 
>  arch/powerpc/include/asm/cputable.h |    3 ++-
>  arch/powerpc/mm/hash_native_64.c    |   13 +++++++++++--
>  2 files changed, 13 insertions(+), 3 deletions(-)
> 
> Index: linux-2.6-ozlabs/arch/powerpc/include/asm/cputable.h
> ===================================================================
> --- linux-2.6-ozlabs.orig/arch/powerpc/include/asm/cputable.h
> +++ linux-2.6-ozlabs/arch/powerpc/include/asm/cputable.h
> @@ -195,6 +195,7 @@ extern const char *powerpc_base_platform
>  #define CPU_FTR_SAO			LONG_ASM_CONST(0x0020000000000000)
>  #define CPU_FTR_CP_USE_DCBTZ		LONG_ASM_CONST(0x0040000000000000)
>  #define CPU_FTR_UNALIGNED_LD_STD	LONG_ASM_CONST(0x0080000000000000)
> +#define CPU_FTR_TLBIE_206		LONG_ASM_CONST(0x0100000000000000)
>  
>  #ifndef __ASSEMBLY__
>  
> @@ -409,7 +410,7 @@ extern const char *powerpc_base_platform
>  	    CPU_FTR_MMCRA | CPU_FTR_SMT | \
>  	    CPU_FTR_COHERENT_ICACHE | CPU_FTR_LOCKLESS_TLBIE | \
>  	    CPU_FTR_PURR | CPU_FTR_SPURR | CPU_FTR_REAL_LE | \
> -	    CPU_FTR_DSCR | CPU_FTR_SAO)
> +	    CPU_FTR_DSCR | CPU_FTR_SAO | CPU_FTR_TLBIE_206)
>  #define CPU_FTRS_CELL	(CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
>  	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
>  	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_MMCRA | CPU_FTR_SMT | \
> Index: linux-2.6-ozlabs/arch/powerpc/mm/hash_native_64.c
> ===================================================================
> --- linux-2.6-ozlabs.orig/arch/powerpc/mm/hash_native_64.c
> +++ linux-2.6-ozlabs/arch/powerpc/mm/hash_native_64.c
> @@ -38,6 +38,9 @@
>  
>  static DEFINE_SPINLOCK(native_tlbie_lock);
>  
> +#define TLBIE(lp,a) \
> +	stringify_in_c(.long 0x7c000264 | ((a) << 11) | ((lp) << 21))
> +
>  static inline void __tlbie(unsigned long va, int psize, int ssize)
>  {
>  	unsigned int penc;
> @@ -49,14 +52,19 @@ static inline void __tlbie(unsigned long
>  	case MMU_PAGE_4K:
>  		va &= ~0xffful;
>  		va |= ssize << 8;
> -		asm volatile("tlbie %0,0" : : "r" (va) : "memory");
> + 		asm volatile(ASM_FTR_IFCLR("tlbie %0,0", TLBIE(%1,%0), %2)
> +			     : : "r" (va), "r"(0), "i" (CPU_FTR_TLBIE_206)
> +			     : "memory");
>  		break;
>  	default:
>  		penc = mmu_psize_defs[psize].penc;
>  		va &= ~((1ul << mmu_psize_defs[psize].shift) - 1);
>  		va |= penc << 12;
>  		va |= ssize << 8;
> -		asm volatile("tlbie %0,1" : : "r" (va) : "memory");
> +		va |= 1; /* L */
> + 		asm volatile(ASM_FTR_IFCLR("tlbie %0,1", TLBIE(%1,%0), %2)
> +			     : : "r" (va), "r"(0), "i" (CPU_FTR_TLBIE_206)
> +			     : "memory");
>  		break;
>  	}
>  }
> @@ -80,6 +88,7 @@ static inline void __tlbiel(unsigned lon
>  		va &= ~((1ul << mmu_psize_defs[psize].shift) - 1);
>  		va |= penc << 12;
>  		va |= ssize << 8;
> +		va |= 1; /* L */
>  		asm volatile(".long 0x7c000224 | (%0 << 11) | (1 << 21)"
>  			     : : "r"(va) : "memory");
>  		break;
