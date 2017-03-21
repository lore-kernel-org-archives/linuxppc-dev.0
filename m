Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vnX6P70FXzDq7c
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 23:23:41 +1100 (AEDT)
Subject: Re: Optimised memset64/memset32 for powerpc
To: Matthew Wilcox <willy@infradead.org>, paulus@samba.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au
References: <20170320211447.GB5073@bombadil.infradead.org>
Cc: linuxppc-dev@lists.ozlabs.org
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <18c572e8-a269-c76e-b3a1-e745ac20e5a7@c-s.fr>
Date: Tue, 21 Mar 2017 13:23:36 +0100
MIME-Version: 1.0
In-Reply-To: <20170320211447.GB5073@bombadil.infradead.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Matthew

Le 20/03/2017 à 22:14, Matthew Wilcox a écrit :
> I recently introduced memset32() / memset64().  I've done implementations
> for x86 & ARM; akpm has agreed to take the patchset through his tree.
> Do you fancy doing a powerpc version?  Minchan Kim got a 7% performance
> increase with zram from switching to the optimised version on x86.
>
> Here's the development git tree:
> http://git.infradead.org/users/willy/linux-dax.git/shortlog/refs/heads/memfill
> (most recent 7 commits)
>
> ARM probably offers the best model for you to work from; it's basically
> just a case of jumping into the middle of your existing memset loop.
> It was only three instructions to add support to ARM, but I don't know
> PowerPC well enough to understand how your existing memset works.
> I'd start with something like this ... note that you don't have to
> implement memset64 on 32-bit; I only did it on ARM because it was free.
> It doesn't look free for you as you only store one register each time
> around the loop in the 32-bit memset implementation:
>
> 1:      stwu    r4,4(r6)
>         bdnz    1b
>
> (wouldn't you get better performance on 32-bit powerpc by unrolling that
> loop like you do on 64-bit?)

In arch/powerpc/lib/copy_32.S, the implementation of memset() is 
optimised when the value to be set is zero. It makes use of the 'dcbz' 
instruction which zeroizes a complete cache line.

Not much effort has been put on optimising non-zero memset() because 
there are almost none.

Unrolling the loop could help a bit on old powerpc32s that don't have 
branch units, but on those processors the main driver is the time spent 
to do the effective write to memory, and the operations necessary to 
unroll the loop are not worth the cycle added by the branch.

On more modern powerpc32s, the branch unit implies that branches have a 
zero cost.

A simple static inline C function would probably do the job, based on 
what I get below:

void memset32(int *p, int v, unsigned int c)
{
	int i;

	for (i = 0; i < c; i++)
		*p++ = v;
}

void memset64(long long *p, long long v, unsigned int c)
{
	int i;

	for (i = 0; i < c; i++)
		*p++ = v;
}

test.o:     file format elf32-powerpc


Disassembly of section .text:

00000000 <memset32>:
    0:	2c 05 00 00 	cmpwi   r5,0
    4:	38 63 ff fc 	addi    r3,r3,-4
    8:	4d 82 00 20 	beqlr
    c:	7c a9 03 a6 	mtctr   r5
   10:	94 83 00 04 	stwu    r4,4(r3)
   14:	42 00 ff fc 	bdnz    10 <memset32+0x10>
   18:	4e 80 00 20 	blr

0000001c <memset64>:
   1c:	2c 07 00 00 	cmpwi   r7,0
   20:	7c cb 33 78 	mr      r11,r6
   24:	7c aa 2b 78 	mr      r10,r5
   28:	38 63 ff f8 	addi    r3,r3,-8
   2c:	4d 82 00 20 	beqlr
   30:	7c e9 03 a6 	mtctr   r7
   34:	95 43 00 08 	stwu    r10,8(r3)
   38:	91 63 00 04 	stw     r11,4(r3)
   3c:	42 00 ff f8 	bdnz    34 <memset64+0x18>
   40:	4e 80 00 20 	blr



Christophe

>
> diff --git a/arch/powerpc/include/asm/string.h b/arch/powerpc/include/asm/string.h
> index da3cdffca440..c02392fced98 100644
> --- a/arch/powerpc/include/asm/string.h
> +++ b/arch/powerpc/include/asm/string.h
> @@ -6,6 +6,7 @@
>  #define __HAVE_ARCH_STRNCPY
>  #define __HAVE_ARCH_STRNCMP
>  #define __HAVE_ARCH_MEMSET
> +#define __HAVE_ARCH_MEMSET_PLUS
>  #define __HAVE_ARCH_MEMCPY
>  #define __HAVE_ARCH_MEMMOVE
>  #define __HAVE_ARCH_MEMCMP
> @@ -23,6 +24,18 @@ extern void * memmove(void *,const void *,__kernel_size_t);
>  extern int memcmp(const void *,const void *,__kernel_size_t);
>  extern void * memchr(const void *,int,__kernel_size_t);
>
> +extern void *__memset32(uint32_t *, uint32_t v, __kernel_size_t);
> +static inline void *memset32(uint32_t *p, uint32_t v, __kernel_size_t n)
> +{
> +	return __memset32(p, v, n * 4);
> +}
> +
> +extern void *__memset64(uint64_t *, uint64_t v, __kernel_size_t);
> +static inline void *memset64(uint64_t *p, uint64_t v, __kernel_size_t n)
> +{
> +	return __memset64(p, v, n * 8);
> +}
> +
>  #endif /* __KERNEL__ */
>
>  #endif	/* _ASM_POWERPC_STRING_H */
>
