Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id E9406B7090
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  8 Jul 2009 12:55:17 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 078A6DDD0C
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Jul 2009 12:55:16 +1000 (EST)
Subject: Re: [PATCH v2] powerpc: expose the multi-bit ops that underlie
	single-bit ops.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geoff Thorpe <geoff@geoffthorpe.net>
In-Reply-To: <1247016236-3520-1-git-send-email-geoff@geoffthorpe.net>
References: <1247016236-3520-1-git-send-email-geoff@geoffthorpe.net>
Content-Type: text/plain
Date: Wed, 08 Jul 2009 12:55:04 +1000
Message-Id: <1247021704.6066.62.camel@pasglop>
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

On Tue, 2009-07-07 at 21:23 -0400, Geoff Thorpe wrote:
> The bitops.h functions that operate on a single bit in a bitfield are
> implemented by operating on the corresponding word location. In all
> cases the inner logic is valid if the mask being applied has more than
> one bit set, so this patch exposes those inner operations. Indeed,
> set_bits() was already available, but it duplicated code from
> set_bit() (rather than making the latter a wrapper) - it was also
> missing the PPC405_ERR77() workaround and the "volatile" address
> qualifier present in other APIs. This corrects that, and exposes the
> other multi-bit equivalents.
> 
> One advantage of these multi-bit forms is that they allow word-sized
> variables to essentially be their own spinlocks, eg. very useful for
> state machines where an atomic "flags" variable can obviate the need
> for any additional locking.

Ack. I'll stick that into my -next branch as soon as it's ready.

Cheers,
Ben.

> Signed-off-by: Geoff Thorpe <geoff@geoffthorpe.net>
> ---
>  arch/powerpc/include/asm/bitops.h |  194 ++++++++++++-------------------------
>  1 files changed, 61 insertions(+), 133 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/bitops.h b/arch/powerpc/include/asm/bitops.h
> index 897eade..56f2f2e 100644
> --- a/arch/powerpc/include/asm/bitops.h
> +++ b/arch/powerpc/include/asm/bitops.h
> @@ -56,174 +56,102 @@
>  #define BITOP_WORD(nr)		((nr) / BITS_PER_LONG)
>  #define BITOP_LE_SWIZZLE	((BITS_PER_LONG-1) & ~0x7)
>  
> +/* Macro for generating the ***_bits() functions */
> +#define DEFINE_BITOP(fn, op, prefix, postfix)	\
> +static __inline__ void fn(unsigned long mask,	\
> +		volatile unsigned long *_p)	\
> +{						\
> +	unsigned long old;			\
> +	unsigned long *p = (unsigned long *)_p;	\
> +	__asm__ __volatile__ (			\
> +	prefix					\
> +"1:"	PPC_LLARX "%0,0,%3\n"			\
> +	stringify_in_c(op) "%0,%0,%2\n"		\
> +	PPC405_ERR77(0,%3)			\
> +	PPC_STLCX "%0,0,%3\n"			\
> +	"bne- 1b\n"				\
> +	postfix					\
> +	: "=&r" (old), "+m" (*p)		\
> +	: "r" (mask), "r" (p)			\
> +	: "cc", "memory");			\
> +}
> +
> +DEFINE_BITOP(set_bits, or, "", "")
> +DEFINE_BITOP(clear_bits, andc, "", "")
> +DEFINE_BITOP(clear_bits_unlock, andc, LWSYNC_ON_SMP, "")
> +DEFINE_BITOP(change_bits, xor, "", "")
> +
>  static __inline__ void set_bit(int nr, volatile unsigned long *addr)
>  {
> -	unsigned long old;
> -	unsigned long mask = BITOP_MASK(nr);
> -	unsigned long *p = ((unsigned long *)addr) + BITOP_WORD(nr);
> -
> -	__asm__ __volatile__(
> -"1:"	PPC_LLARX "%0,0,%3	# set_bit\n"
> -	"or	%0,%0,%2\n"
> -	PPC405_ERR77(0,%3)
> -	PPC_STLCX "%0,0,%3\n"
> -	"bne-	1b"
> -	: "=&r" (old), "+m" (*p)
> -	: "r" (mask), "r" (p)
> -	: "cc" );
> +	set_bits(BITOP_MASK(nr), addr + BITOP_WORD(nr));
>  }
>  
>  static __inline__ void clear_bit(int nr, volatile unsigned long *addr)
>  {
> -	unsigned long old;
> -	unsigned long mask = BITOP_MASK(nr);
> -	unsigned long *p = ((unsigned long *)addr) + BITOP_WORD(nr);
> -
> -	__asm__ __volatile__(
> -"1:"	PPC_LLARX "%0,0,%3	# clear_bit\n"
> -	"andc	%0,%0,%2\n"
> -	PPC405_ERR77(0,%3)
> -	PPC_STLCX "%0,0,%3\n"
> -	"bne-	1b"
> -	: "=&r" (old), "+m" (*p)
> -	: "r" (mask), "r" (p)
> -	: "cc" );
> +	clear_bits(BITOP_MASK(nr), addr + BITOP_WORD(nr));
>  }
>  
>  static __inline__ void clear_bit_unlock(int nr, volatile unsigned long *addr)
>  {
> -	unsigned long old;
> -	unsigned long mask = BITOP_MASK(nr);
> -	unsigned long *p = ((unsigned long *)addr) + BITOP_WORD(nr);
> -
> -	__asm__ __volatile__(
> -	LWSYNC_ON_SMP
> -"1:"	PPC_LLARX "%0,0,%3	# clear_bit_unlock\n"
> -	"andc	%0,%0,%2\n"
> -	PPC405_ERR77(0,%3)
> -	PPC_STLCX "%0,0,%3\n"
> -	"bne-	1b"
> -	: "=&r" (old), "+m" (*p)
> -	: "r" (mask), "r" (p)
> -	: "cc", "memory");
> +	clear_bits_unlock(BITOP_MASK(nr), addr + BITOP_WORD(nr));
>  }
>  
>  static __inline__ void change_bit(int nr, volatile unsigned long *addr)
>  {
> -	unsigned long old;
> -	unsigned long mask = BITOP_MASK(nr);
> -	unsigned long *p = ((unsigned long *)addr) + BITOP_WORD(nr);
> -
> -	__asm__ __volatile__(
> -"1:"	PPC_LLARX "%0,0,%3	# change_bit\n"
> -	"xor	%0,%0,%2\n"
> -	PPC405_ERR77(0,%3)
> -	PPC_STLCX "%0,0,%3\n"
> -	"bne-	1b"
> -	: "=&r" (old), "+m" (*p)
> -	: "r" (mask), "r" (p)
> -	: "cc" );
> +	change_bits(BITOP_MASK(nr), addr + BITOP_WORD(nr));
> +}
> +
> +/* Like DEFINE_BITOP(), with changes to the arguments to 'op' and the output
> + * operands. */
> +#define DEFINE_TESTOP(fn, op, prefix, postfix)	\
> +static __inline__ unsigned long fn(		\
> +		unsigned long mask,		\
> +		volatile unsigned long *_p)	\
> +{						\
> +	unsigned long old, t;			\
> +	unsigned long *p = (unsigned long *)_p;	\
> +	__asm__ __volatile__ (			\
> +	prefix					\
> +"1:"	PPC_LLARX "%0,0,%3\n"			\
> +	stringify_in_c(op) "%1,%0,%2\n"		\
> +	PPC405_ERR77(0,%3)			\
> +	PPC_STLCX "%1,0,%3\n"			\
> +	"bne- 1b\n"				\
> +	postfix					\
> +	: "=&r" (old), "=&r" (t)		\
> +	: "r" (mask), "r" (p)			\
> +	: "cc", "memory");			\
> +	return (old & mask);			\
>  }
>  
> +DEFINE_TESTOP(test_and_set_bits, or, LWSYNC_ON_SMP, ISYNC_ON_SMP)
> +DEFINE_TESTOP(test_and_set_bits_lock, or, "", ISYNC_ON_SMP)
> +DEFINE_TESTOP(test_and_clear_bits, andc, LWSYNC_ON_SMP, ISYNC_ON_SMP)
> +DEFINE_TESTOP(test_and_change_bits, xor, LWSYNC_ON_SMP, ISYNC_ON_SMP)
> +
>  static __inline__ int test_and_set_bit(unsigned long nr,
>  				       volatile unsigned long *addr)
>  {
> -	unsigned long old, t;
> -	unsigned long mask = BITOP_MASK(nr);
> -	unsigned long *p = ((unsigned long *)addr) + BITOP_WORD(nr);
> -
> -	__asm__ __volatile__(
> -	LWSYNC_ON_SMP
> -"1:"	PPC_LLARX "%0,0,%3		# test_and_set_bit\n"
> -	"or	%1,%0,%2 \n"
> -	PPC405_ERR77(0,%3)
> -	PPC_STLCX "%1,0,%3 \n"
> -	"bne-	1b"
> -	ISYNC_ON_SMP
> -	: "=&r" (old), "=&r" (t)
> -	: "r" (mask), "r" (p)
> -	: "cc", "memory");
> -
> -	return (old & mask) != 0;
> +	return test_and_set_bits(BITOP_MASK(nr), addr + BITOP_WORD(nr)) != 0;
>  }
>  
>  static __inline__ int test_and_set_bit_lock(unsigned long nr,
>  				       volatile unsigned long *addr)
>  {
> -	unsigned long old, t;
> -	unsigned long mask = BITOP_MASK(nr);
> -	unsigned long *p = ((unsigned long *)addr) + BITOP_WORD(nr);
> -
> -	__asm__ __volatile__(
> -"1:"	PPC_LLARX "%0,0,%3		# test_and_set_bit_lock\n"
> -	"or	%1,%0,%2 \n"
> -	PPC405_ERR77(0,%3)
> -	PPC_STLCX "%1,0,%3 \n"
> -	"bne-	1b"
> -	ISYNC_ON_SMP
> -	: "=&r" (old), "=&r" (t)
> -	: "r" (mask), "r" (p)
> -	: "cc", "memory");
> -
> -	return (old & mask) != 0;
> +	return test_and_set_bits_lock(BITOP_MASK(nr),
> +				addr + BITOP_WORD(nr)) != 0;
>  }
>  
>  static __inline__ int test_and_clear_bit(unsigned long nr,
>  					 volatile unsigned long *addr)
>  {
> -	unsigned long old, t;
> -	unsigned long mask = BITOP_MASK(nr);
> -	unsigned long *p = ((unsigned long *)addr) + BITOP_WORD(nr);
> -
> -	__asm__ __volatile__(
> -	LWSYNC_ON_SMP
> -"1:"	PPC_LLARX "%0,0,%3		# test_and_clear_bit\n"
> -	"andc	%1,%0,%2 \n"
> -	PPC405_ERR77(0,%3)
> -	PPC_STLCX "%1,0,%3 \n"
> -	"bne-	1b"
> -	ISYNC_ON_SMP
> -	: "=&r" (old), "=&r" (t)
> -	: "r" (mask), "r" (p)
> -	: "cc", "memory");
> -
> -	return (old & mask) != 0;
> +	return test_and_clear_bits(BITOP_MASK(nr), addr + BITOP_WORD(nr)) != 0;
>  }
>  
>  static __inline__ int test_and_change_bit(unsigned long nr,
>  					  volatile unsigned long *addr)
>  {
> -	unsigned long old, t;
> -	unsigned long mask = BITOP_MASK(nr);
> -	unsigned long *p = ((unsigned long *)addr) + BITOP_WORD(nr);
> -
> -	__asm__ __volatile__(
> -	LWSYNC_ON_SMP
> -"1:"	PPC_LLARX "%0,0,%3		# test_and_change_bit\n"
> -	"xor	%1,%0,%2 \n"
> -	PPC405_ERR77(0,%3)
> -	PPC_STLCX "%1,0,%3 \n"
> -	"bne-	1b"
> -	ISYNC_ON_SMP
> -	: "=&r" (old), "=&r" (t)
> -	: "r" (mask), "r" (p)
> -	: "cc", "memory");
> -
> -	return (old & mask) != 0;
> -}
> -
> -static __inline__ void set_bits(unsigned long mask, unsigned long *addr)
> -{
> -        unsigned long old;
> -
> -	__asm__ __volatile__(
> -"1:"	PPC_LLARX "%0,0,%3         # set_bits\n"
> -	"or	%0,%0,%2\n"
> -	PPC_STLCX "%0,0,%3\n"
> -	"bne-	1b"
> -	: "=&r" (old), "+m" (*addr)
> -	: "r" (mask), "r" (addr)
> -	: "cc");
> +	return test_and_change_bits(BITOP_MASK(nr), addr + BITOP_WORD(nr)) != 0;
>  }
>  
>  #include <asm-generic/bitops/non-atomic.h>
