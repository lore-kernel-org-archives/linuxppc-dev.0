Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [125.16.236.6])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r46m36w6kzDq64
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 May 2016 04:12:19 +1000 (AEST)
Received: from localhost
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 10 May 2016 23:42:15 +0530
Received: from d28relay06.in.ibm.com (d28relay06.in.ibm.com [9.184.220.150])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 34960125806A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 May 2016 23:44:19 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay06.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4AICBLX51118090
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 May 2016 23:42:11 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4AICAZT014525
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 May 2016 23:42:10 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, Balbir Singh <bsingharora@gmail.com>
Subject: Re: [PATCH 1/2] Fix .long's in mm/tlb-radix.c to more meaningful
In-Reply-To: <1462892262-18066-2-git-send-email-bsingharora@gmail.com>
References: <1462892262-18066-1-git-send-email-bsingharora@gmail.com>
 <1462892262-18066-2-git-send-email-bsingharora@gmail.com>
Date: Tue, 10 May 2016 23:42:09 +0530
Message-ID: <87y47hixza.fsf@skywalker.in.ibm.com>
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

Balbir Singh <bsingharora@gmail.com> writes:

> The .longs with the shifts are harder to read, use more
> meaningful names for the opcodes. PPC_TLBIE_5 is introduced
> for the 5 opcode variation of the instruction due to an existing
> op-code for the 2 opcode variant
>
> Signed-off-by: Balbir Singh <bsingharora@gmail.com>

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

> ---
>  arch/powerpc/include/asm/ppc-opcode.h | 14 ++++++++++++++
>  arch/powerpc/mm/tlb-radix.c           | 13 +++++--------
>  2 files changed, 19 insertions(+), 8 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
> index 1d035c1..c0e9ea4 100644
> --- a/arch/powerpc/include/asm/ppc-opcode.h
> +++ b/arch/powerpc/include/asm/ppc-opcode.h
> @@ -184,6 +184,7 @@
>  #define PPC_INST_STSWX			0x7c00052a
>  #define PPC_INST_STXVD2X		0x7c000798
>  #define PPC_INST_TLBIE			0x7c000264
> +#define PPC_INST_TLBIEL			0x7c000224
>  #define PPC_INST_TLBILX			0x7c000024
>  #define PPC_INST_WAIT			0x7c00007c
>  #define PPC_INST_TLBIVAX		0x7c000624
> @@ -257,6 +258,9 @@
>  #define ___PPC_RB(b)	(((b) & 0x1f) << 11)
>  #define ___PPC_RS(s)	(((s) & 0x1f) << 21)
>  #define ___PPC_RT(t)	___PPC_RS(t)
> +#define ___PPC_R(r)	(((r) & 0x1) << 16)
> +#define ___PPC_PRS(prs)	(((prs) & 0x1) << 17)
> +#define ___PPC_RIC(ric)	(((ric) & 0x3) << 18)
>  #define __PPC_RA(a)	___PPC_RA(__REG_##a)
>  #define __PPC_RA0(a)	___PPC_RA(__REGA0_##a)
>  #define __PPC_RB(b)	___PPC_RB(__REG_##b)
> @@ -321,6 +325,16 @@
>  					__PPC_WC(w))
>  #define PPC_TLBIE(lp,a) 	stringify_in_c(.long PPC_INST_TLBIE | \
>  					       ___PPC_RB(a) | ___PPC_RS(lp))
> +#define	PPC_TLBIE_5(rb,rs,ric,prs,r) \
> +				stringify_in_c(.long PPC_INST_TLBIE | \
> +					___PPC_RB(rb) | ___PPC_RS(rs) | \
> +					___PPC_RIC(ric) | ___PPC_PRS(prs) | \
> +					___PPC_R(r))
> +#define	PPC_TLBIEL(rb,rs,ric,prs,r) \
> +				stringify_in_c(.long PPC_INST_TLBIEL | \
> +					___PPC_RB(rb) | ___PPC_RS(rs) | \
> +					___PPC_RIC(ric) | ___PPC_PRS(prs) | \
> +					___PPC_R(r))
>  #define PPC_TLBSRX_DOT(a,b)	stringify_in_c(.long PPC_INST_TLBSRX_DOT | \
>  					__PPC_RA0(a) | __PPC_RB(b))
>  #define PPC_TLBIVAX(a,b)	stringify_in_c(.long PPC_INST_TLBIVAX | \
> diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
> index 0fdaf93..e6b7487 100644
> --- a/arch/powerpc/mm/tlb-radix.c
> +++ b/arch/powerpc/mm/tlb-radix.c
> @@ -12,6 +12,7 @@
>  #include <linux/mm.h>
>  #include <linux/hugetlb.h>
>  #include <linux/memblock.h>
> +#include <asm/ppc-opcode.h>
>
>  #include <asm/tlb.h>
>  #include <asm/tlbflush.h>
> @@ -30,8 +31,7 @@ static inline void __tlbiel_pid(unsigned long pid, int set)
>  	ric = 2;  /* invalidate all the caches */
>
>  	asm volatile("ptesync": : :"memory");
> -	asm volatile(".long 0x7c000224 | (%0 << 11) | (%1 << 16) |"
> -		     "(%2 << 17) | (%3 << 18) | (%4 << 21)"
> +	asm volatile(PPC_TLBIEL(%0, %4, %3, %2, %1)
>  		     : : "r"(rb), "i"(r), "i"(prs), "i"(ric), "r"(rs) : "memory");
>  	asm volatile("ptesync": : :"memory");
>  }
> @@ -60,8 +60,7 @@ static inline void _tlbie_pid(unsigned long pid)
>  	ric = 2;  /* invalidate all the caches */
>
>  	asm volatile("ptesync": : :"memory");
> -	asm volatile(".long 0x7c000264 | (%0 << 11) | (%1 << 16) |"
> -		     "(%2 << 17) | (%3 << 18) | (%4 << 21)"
> +	asm volatile(PPC_TLBIE_5(%0, %4, %3, %2, %1)
>  		     : : "r"(rb), "i"(r), "i"(prs), "i"(ric), "r"(rs) : "memory");
>  	asm volatile("eieio; tlbsync; ptesync": : :"memory");
>  }
> @@ -79,8 +78,7 @@ static inline void _tlbiel_va(unsigned long va, unsigned long pid,
>  	ric = 0;  /* no cluster flush yet */
>
>  	asm volatile("ptesync": : :"memory");
> -	asm volatile(".long 0x7c000224 | (%0 << 11) | (%1 << 16) |"
> -		     "(%2 << 17) | (%3 << 18) | (%4 << 21)"
> +	asm volatile(PPC_TLBIEL(%0, %4, %3, %2, %1)
>  		     : : "r"(rb), "i"(r), "i"(prs), "i"(ric), "r"(rs) : "memory");
>  	asm volatile("ptesync": : :"memory");
>  }
> @@ -98,8 +96,7 @@ static inline void _tlbie_va(unsigned long va, unsigned long pid,
>  	ric = 0;  /* no cluster flush yet */
>
>  	asm volatile("ptesync": : :"memory");
> -	asm volatile(".long 0x7c000264 | (%0 << 11) | (%1 << 16) |"
> -		     "(%2 << 17) | (%3 << 18) | (%4 << 21)"
> +	asm volatile(PPC_TLBIE_5(%0, %4, %3, %2, %1)
>  		     : : "r"(rb), "i"(r), "i"(prs), "i"(ric), "r"(rs) : "memory");
>  	asm volatile("eieio; tlbsync; ptesync": : :"memory");
>  }
> -- 
> 2.5.5
