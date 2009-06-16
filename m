Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id B51CBB7148
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 16 Jun 2009 13:55:53 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C6DF9DDD0B
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Jun 2009 13:55:52 +1000 (EST)
Subject: Re: [PATCH] RFC: powerpc: expose the multi-bit ops that underlie
	single-bit ops.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geoff Thorpe <Geoff.Thorpe@freescale.com>
In-Reply-To: <1243361946-6771-1-git-send-email-Geoff.Thorpe@freescale.com>
References: <1243361946-6771-1-git-send-email-Geoff.Thorpe@freescale.com>
Content-Type: text/plain
Date: Tue, 16 Jun 2009 13:53:38 +1000
Message-Id: <1245124418.12400.67.camel@pasglop>
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

On Tue, 2009-05-26 at 14:19 -0400, Geoff Thorpe wrote:
> NOT FOR COMMIT, THIS IS A REQUEST FOR FEEDBACK.
> 
> The bitops.h functions that operate on a single bit in a bitfield are
> implemented by operating on the corresponding word location. In all cases
> the inner logic appears to be valid if the mask being applied has more
> than one bit set, so this patch exposes those inner operations. Indeed,
> set_bits() was already available, but it duplicated code from set_bit()
> (rather than making the latter a wrapper) - it was also missing the
> PPC405_ERR77() workaround and the "volatile" address qualifier present in
> other APIs. This corrects that, and exposes the other multi-bit
> equivalents.
> 
> One advantage of these multi-bit forms is that they allow word-sized
> variables to essentially be their own spinlocks.

Hi ! Sorry for the delay, that was on my "have a look one of these days,
low priority" list for a bit too long :-)

> NB, the same factoring is possible in asm-generic/bitops/[non-]atomic.h.
> I would be happy to provide corresponding patches if this approach is
> deemed appropriate. Feedback would be most welcome.
> 
> Signed-off-by: Geoff Thorpe <Geoff.Thorpe@freescale.com>
> ---
>  arch/powerpc/include/asm/bitops.h |  111 +++++++++++++++++++++++--------------
>  1 files changed, 69 insertions(+), 42 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/bitops.h b/arch/powerpc/include/asm/bitops.h
> index 897eade..72de28c 100644
> --- a/arch/powerpc/include/asm/bitops.h
> +++ b/arch/powerpc/include/asm/bitops.h
> @@ -56,11 +56,10 @@
>  #define BITOP_WORD(nr)		((nr) / BITS_PER_LONG)
>  #define BITOP_LE_SWIZZLE	((BITS_PER_LONG-1) & ~0x7)
>  
> -static __inline__ void set_bit(int nr, volatile unsigned long *addr)
> +static __inline__ void set_bits(unsigned long mask, volatile unsigned long *_p)
>  {
>  	unsigned long old;
> -	unsigned long mask = BITOP_MASK(nr);
> -	unsigned long *p = ((unsigned long *)addr) + BITOP_WORD(nr);
> +	unsigned long *p = (unsigned long *)_p;
>  
>  	__asm__ __volatile__(
>  "1:"	PPC_LLARX "%0,0,%3	# set_bit\n"
> @@ -73,11 +72,16 @@ static __inline__ void set_bit(int nr, volatile unsigned long *addr)
>  	: "cc" );
>  }
>  
> -static __inline__ void clear_bit(int nr, volatile unsigned long *addr)
> +static __inline__ void set_bit(int nr, volatile unsigned long *addr)
> +{
> +	set_bits(BITOP_MASK(nr), addr + BITOP_WORD(nr));
> +}

No objection with the above.

> +static __inline__ void clear_bits(unsigned long mask,
> +				volatile unsigned long *_p)
>  {
>  	unsigned long old;
> -	unsigned long mask = BITOP_MASK(nr);
> -	unsigned long *p = ((unsigned long *)addr) + BITOP_WORD(nr);
> +	unsigned long *p = (unsigned long *)_p;
>  
>  	__asm__ __volatile__(
>  "1:"	PPC_LLARX "%0,0,%3	# clear_bit\n"
> @@ -90,11 +94,16 @@ static __inline__ void clear_bit(int nr, volatile unsigned long *addr)
>  	: "cc" );
>  }
>  
> -static __inline__ void clear_bit_unlock(int nr, volatile unsigned long *addr)
> +static __inline__ void clear_bit(int nr, volatile unsigned long *addr)
> +{
> +	clear_bits(BITOP_MASK(nr), addr + BITOP_WORD(nr));
> +}

Looks good too.

> +static __inline__ void clear_bits_unlock(unsigned long mask,
> +					volatile unsigned long *_p)
>  {
>  	unsigned long old;
> -	unsigned long mask = BITOP_MASK(nr);
> -	unsigned long *p = ((unsigned long *)addr) + BITOP_WORD(nr);
> +	unsigned long *p = (unsigned long *)_p;
>  
>  	__asm__ __volatile__(
>  	LWSYNC_ON_SMP
> @@ -108,11 +117,16 @@ static __inline__ void clear_bit_unlock(int nr, volatile unsigned long *addr)
>  	: "cc", "memory");
>  }
>  
> -static __inline__ void change_bit(int nr, volatile unsigned long *addr)
> +static __inline__ void clear_bit_unlock(int nr, volatile unsigned long *addr)
> +{
> +	clear_bits_unlock(BITOP_MASK(nr), addr + BITOP_WORD(nr));
> +}

I'm not sure it's useful to provide a multi-bit variant of the
"lock" and "unlock" primitives. Do other archs do ?

> +static __inline__ void change_bits(unsigned long mask,
> +				volatile unsigned long *_p)
>  {
>  	unsigned long old;
> -	unsigned long mask = BITOP_MASK(nr);
> -	unsigned long *p = ((unsigned long *)addr) + BITOP_WORD(nr);
> +	unsigned long *p = (unsigned long *)_p;
>  
>  	__asm__ __volatile__(
>  "1:"	PPC_LLARX "%0,0,%3	# change_bit\n"
> @@ -125,12 +139,16 @@ static __inline__ void change_bit(int nr, volatile unsigned long *addr)
>  	: "cc" );
>  }
>  
> -static __inline__ int test_and_set_bit(unsigned long nr,
> -				       volatile unsigned long *addr)
> +static __inline__ void change_bit(int nr, volatile unsigned long *addr)
> +{
> +	change_bits(BITOP_MASK(nr), addr + BITOP_WORD(nr));
> +}

Ah, patch is getting confused between change_bit and
test_and_set_bit :-)

Now, you know what I'm thinking is ... Those are all the same except
for:

 - Barriers for lock and unlock variants
 - Barriers for "return" (aka test_and_set) variants
 - Actual op done on the mask

Maybe we can shrink that file significantly (and avoid the risk for
typos etc...) by generating them all from a macro.

Something like (typed directly into the mailer :-)

#define DEFINE_BITOP(op, prefix, postfix) \
	asm volatile (			  \
	prefix				  \
"1:"    PPC_LLARX "%0,0,%3\n"		  \
	__stringify(op) "%1,%0,%2\n"	  \
	PPC405_ERR77(0,%3)		  \
	PPC_STLCX "%1,0,%3\n"		  \
	"bne- 1b\n"			  \
	postfix				  \
	 : "=&r" (old), "=&r" (t)
	 : "r" (mask), "r" (p)
	 : "cc", "memory")

and so:

static inline void set_bits(unsigned long mask, volatile unsigned long *addr)
{
	unsigned long old, t;

	DEFINE_BITOP(or, "", "");
}

static inline void test_and_set_bits(unsigned long mask, volatile unsigned long *addr)
{
	unsigned long old, t;

	DEFINE_BITOP(or, LWSYNC_ON_SMP, ISYNC_ON_SMP);

	return (old & mask) != 0;
}

etc...

Cheers,
Ben.
