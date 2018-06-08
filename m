Return-Path: <paubert@iram.es>
Received: from cica-lavadora-l1mail3.puc.rediris.es
 (ci-l1mail3-out05a.puc.rediris.es [IPv6:2001:720:418:ca02::31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 412LFP68FPzDqJl
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jun 2018 21:45:27 +1000 (AEST)
Date: Fri, 8 Jun 2018 13:45:13 +0200
From: Gabriel Paubert <paubert@iram.es>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, wei.guo.simon@gmail.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/4] powerpc/lib: implement strlen() in assembly
Message-ID: <20180608114513.gtgg7o4ejcqrjiz4@lt-gp.iram.es>
References: <a348f4ffda6349467e4270e754d12150fa773462.1528452373.git.christophe.leroy@c-s.fr>
 <8d65b5876f55efbd2243f6b43c758e452bee3b54.1528452373.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8d65b5876f55efbd2243f6b43c758e452bee3b54.1528452373.git.christophe.leroy@c-s.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 08, 2018 at 10:20:41AM +0000, Christophe Leroy wrote:
> The generic implementation of strlen() reads strings byte per byte.
> 
> This patch implements strlen() in assembly based on a read of entire
> words, in the same spirit as what some other arches and glibc do.
> 
> On a 8xx the time spent in strlen is reduced by 2/3 for long strings.
> 
> strlen() selftest on an 8xx provides the following values:
> 
> Before the patch (ie with the generic strlen() in lib/string.c):
> 
> len 256 : time = 0.803648
> len 16  : time = 0.062989
> len 4   : time = 0.026269
> 
> After the patch:
> 
> len 256 : time = 0.267791  ==>  66% improvment
> len 16  : time = 0.037902  ==>  41% improvment
> len 4   : time = 0.026124  ==>  no degradation
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
> Not tested on PPC64.
> 
> Changes in v4:
>  - Added alignment of the loop
>  - doing the andc only if still not 0 as it happends only for bytes above 0x7f which is pretty rare in a string
> 
> Changes in v3:
>  - Made it common to PPC32 and PPC64
> 
> Changes in v2:
>  - Moved handling of unaligned strings outside of the main path as it is very unlikely.
>  - Removed the verification of the fourth byte in case none of the three first ones are NUL.
> 
> 
>  arch/powerpc/include/asm/asm-compat.h |  4 +++
>  arch/powerpc/include/asm/string.h     |  1 +
>  arch/powerpc/lib/string.S             | 57 +++++++++++++++++++++++++++++++++++
>  3 files changed, 62 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/asm-compat.h b/arch/powerpc/include/asm/asm-compat.h
> index 7f2a7702596c..0e99fe7570c0 100644
> --- a/arch/powerpc/include/asm/asm-compat.h
> +++ b/arch/powerpc/include/asm/asm-compat.h
> @@ -20,8 +20,10 @@
>  
>  /* operations for longs and pointers */
>  #define PPC_LL		stringify_in_c(ld)
> +#define PPC_LLU		stringify_in_c(ldu)
>  #define PPC_STL		stringify_in_c(std)
>  #define PPC_STLU	stringify_in_c(stdu)
> +#define PPC_ROTLI	stringify_in_c(rotldi)
>  #define PPC_LCMPI	stringify_in_c(cmpdi)
>  #define PPC_LCMPLI	stringify_in_c(cmpldi)
>  #define PPC_LCMP	stringify_in_c(cmpd)
> @@ -53,8 +55,10 @@
>  
>  /* operations for longs and pointers */
>  #define PPC_LL		stringify_in_c(lwz)
> +#define PPC_LLU		stringify_in_c(lwzu)
>  #define PPC_STL		stringify_in_c(stw)
>  #define PPC_STLU	stringify_in_c(stwu)
> +#define PPC_ROTLI	stringify_in_c(rotlwi)
>  #define PPC_LCMPI	stringify_in_c(cmpwi)
>  #define PPC_LCMPLI	stringify_in_c(cmplwi)
>  #define PPC_LCMP	stringify_in_c(cmpw)
> diff --git a/arch/powerpc/include/asm/string.h b/arch/powerpc/include/asm/string.h
> index 9b8cedf618f4..8fdcb532de72 100644
> --- a/arch/powerpc/include/asm/string.h
> +++ b/arch/powerpc/include/asm/string.h
> @@ -13,6 +13,7 @@
>  #define __HAVE_ARCH_MEMCHR
>  #define __HAVE_ARCH_MEMSET16
>  #define __HAVE_ARCH_MEMCPY_FLUSHCACHE
> +#define __HAVE_ARCH_STRLEN
>  
>  extern char * strcpy(char *,const char *);
>  extern char * strncpy(char *,const char *, __kernel_size_t);
> diff --git a/arch/powerpc/lib/string.S b/arch/powerpc/lib/string.S
> index 4b41970e9ed8..238f61e2024f 100644
> --- a/arch/powerpc/lib/string.S
> +++ b/arch/powerpc/lib/string.S
> @@ -67,3 +67,60 @@ _GLOBAL(memchr)
>  2:	li	r3,0
>  	blr
>  EXPORT_SYMBOL(memchr)
> +
> +_GLOBAL(strlen)
> +	andi.   r9, r3, (SZL - 1)
> +	addi	r10, r3, -SZL
> +	bne-	1f
> +2:	lis	r6, 0x8080
> +	ori	r6, r6, 0x8080		/* r6 = 0x80808080 (himagic) */
> +#ifdef CONFIG_PPC64
> +	rldimi	r6, r6, 32, 0		/* r6 = 0x8080808080808080 (himagic) */
> +#endif
> +	PPC_ROTLI  r7, r6, 1 		/* r7 = 0x01010101(01010101) (lomagic)*/
> +	.balign IFETCH_ALIGN_BYTES
> +3:	PPC_LLU	r9, SZL(r10)
> +	/* ((x - lomagic) & ~x & himagic) == 0 means no byte in x is NUL */
> +	subf	r8, r7, r9
> +	and.	r8, r8, r6
> +	beq+	3b
> +	andc.	r8, r8, r9
> +	beq+	3b
> +#ifdef CONFIG_PPC64
> +	rldicl.	r8, r9, 8, 56
> +	beq	20f
> +	rldicl.	r8, r9, 16, 56
> +	beq	21f
> +	rldicl.	r8, r9, 24, 56
> +	beq	22f
> +	rldicl.	r8, r9, 32, 56
> +	beq	23f
> +	addi	r10, r10, 4
> +#endif
> +	rlwinm.	r8, r9, 0, 0xff000000
> +	beq	20f
> +	rlwinm.	r8, r9, 0, 0x00ff0000
> +	beq	21f
> +	rlwinm.	r8, r9, 0, 0x0000ff00
> +	beq	22f
> +23:	subf	r3, r3, r10

Actually these rlwinm. can likely be replaced by a single
cntlzw /cntlzd; for 32 bit something like:

	cntlzw  r8,r9
	subf    r3,r3,r10	
	srwi	r8,r8,3
	add	r3,r3,r8
	blr

and similar for 64 bit but with cntlzd.

	Gabriel


> +	addi	r3, r3, 3
> +	blr
> +22:	subf	r3, r3, r10
> +	addi	r3, r3, 2
> +	blr
> +21:	subf	r3, r3, r10
> +	addi	r3, r3, 1
> +	blr
> +19:	addi	r10, r10, (SZL - 1)
> +20:	subf	r3, r3, r10
> +	blr
> +
> +1:	lbz	r9, SZL(r10)
> +	addi	r10, r10, 1
> +	cmpwi	cr1, r9, 0
> +	andi.	r9, r10, (SZL - 1)
> +	beq	cr1, 19b
> +	bne	1b
> +	b	2b
> +EXPORT_SYMBOL(strlen)
> -- 
> 2.13.3
> 
