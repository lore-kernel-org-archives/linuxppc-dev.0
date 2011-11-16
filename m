Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e8.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id EDE60B708F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2011 00:45:40 +1100 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Wed, 16 Nov 2011 08:45:33 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 pAGDjU6o298454
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2011 08:45:30 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 pAGDjTcw011887
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2011 08:45:30 -0500
Date: Wed, 16 Nov 2011 05:45:27 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Fix atomic_xxx_return barrier semantics
Message-ID: <20111116134527.GA2318@linux.vnet.ibm.com>
References: <1321413087.3170.27.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1321413087.3170.27.camel@pasglop>
Cc: Anton Blanchard <anton@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Paul Mackerras <pmac@au1.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 16, 2011 at 02:11:27PM +1100, Benjamin Herrenschmidt wrote:
> The Documentation/memory-barriers.txt document requires that atomic
> operations that return a value act as a memory barrier both before
> and after the actual atomic operation.
> 
> Our current implementation doesn't guarantee this. More specifically,
> while a load following the isync can not be issued before stwcx. has
> completed, that completion doesn't architecturally means that the
> result of stwcx. is visible to other processors (or any previous stores
> for that matter) (typically, the other processors L1 caches can still
> hold the old value).
> 
> This has caused an actual crash in RCU torture testing on Power 7
> 
> This fixes it by changing those atomic ops to use new macros instead
> of RELEASE/ACQUIRE barriers, called ATOMIC_ENTRY and ATMOIC_EXIT barriers,
> which are then defined respectively to lwsync and sync.
> 
> I haven't had a chance to measure the performance impact (or rather
> what I measured with kernel compiles is in the noise, I yet have to
> find a more precise benchmark)
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Acked-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

> ---
> 
> diff --git a/arch/powerpc/include/asm/atomic.h b/arch/powerpc/include/asm/atomic.h
> index e2a4c26..02e41b5 100644
> --- a/arch/powerpc/include/asm/atomic.h
> +++ b/arch/powerpc/include/asm/atomic.h
> @@ -49,13 +49,13 @@ static __inline__ int atomic_add_return(int a, atomic_t *v)
>  	int t;
> 
>  	__asm__ __volatile__(
> -	PPC_RELEASE_BARRIER
> +	PPC_ATOMIC_ENTRY_BARRIER
>  "1:	lwarx	%0,0,%2		# atomic_add_return\n\
>  	add	%0,%1,%0\n"
>  	PPC405_ERR77(0,%2)
>  "	stwcx.	%0,0,%2 \n\
>  	bne-	1b"
> -	PPC_ACQUIRE_BARRIER
> +	PPC_ATOMIC_EXIT_BARRIER
>  	: "=&r" (t)
>  	: "r" (a), "r" (&v->counter)
>  	: "cc", "memory");
> @@ -85,13 +85,13 @@ static __inline__ int atomic_sub_return(int a, atomic_t *v)
>  	int t;
> 
>  	__asm__ __volatile__(
> -	PPC_RELEASE_BARRIER
> +	PPC_ATOMIC_ENTRY_BARRIER
>  "1:	lwarx	%0,0,%2		# atomic_sub_return\n\
>  	subf	%0,%1,%0\n"
>  	PPC405_ERR77(0,%2)
>  "	stwcx.	%0,0,%2 \n\
>  	bne-	1b"
> -	PPC_ACQUIRE_BARRIER
> +	PPC_ATOMIC_EXIT_BARRIER
>  	: "=&r" (t)
>  	: "r" (a), "r" (&v->counter)
>  	: "cc", "memory");
> @@ -119,13 +119,13 @@ static __inline__ int atomic_inc_return(atomic_t *v)
>  	int t;
> 
>  	__asm__ __volatile__(
> -	PPC_RELEASE_BARRIER
> +	PPC_ATOMIC_ENTRY_BARRIER
>  "1:	lwarx	%0,0,%1		# atomic_inc_return\n\
>  	addic	%0,%0,1\n"
>  	PPC405_ERR77(0,%1)
>  "	stwcx.	%0,0,%1 \n\
>  	bne-	1b"
> -	PPC_ACQUIRE_BARRIER
> +	PPC_ATOMIC_EXIT_BARRIER
>  	: "=&r" (t)
>  	: "r" (&v->counter)
>  	: "cc", "xer", "memory");
> @@ -163,13 +163,13 @@ static __inline__ int atomic_dec_return(atomic_t *v)
>  	int t;
> 
>  	__asm__ __volatile__(
> -	PPC_RELEASE_BARRIER
> +	PPC_ATOMIC_ENTRY_BARRIER
>  "1:	lwarx	%0,0,%1		# atomic_dec_return\n\
>  	addic	%0,%0,-1\n"
>  	PPC405_ERR77(0,%1)
>  "	stwcx.	%0,0,%1\n\
>  	bne-	1b"
> -	PPC_ACQUIRE_BARRIER
> +	PPC_ATOMIC_EXIT_BARRIER
>  	: "=&r" (t)
>  	: "r" (&v->counter)
>  	: "cc", "xer", "memory");
> @@ -194,7 +194,7 @@ static __inline__ int __atomic_add_unless(atomic_t *v, int a, int u)
>  	int t;
> 
>  	__asm__ __volatile__ (
> -	PPC_RELEASE_BARRIER
> +	PPC_ATOMIC_ENTRY_BARRIER
>  "1:	lwarx	%0,0,%1		# __atomic_add_unless\n\
>  	cmpw	0,%0,%3 \n\
>  	beq-	2f \n\
> @@ -202,7 +202,7 @@ static __inline__ int __atomic_add_unless(atomic_t *v, int a, int u)
>  	PPC405_ERR77(0,%2)
>  "	stwcx.	%0,0,%1 \n\
>  	bne-	1b \n"
> -	PPC_ACQUIRE_BARRIER
> +	PPC_ATOMIC_EXIT_BARRIER
>  "	subf	%0,%2,%0 \n\
>  2:"
>  	: "=&r" (t)
> @@ -226,7 +226,7 @@ static __inline__ int atomic_dec_if_positive(atomic_t *v)
>  	int t;
> 
>  	__asm__ __volatile__(
> -	PPC_RELEASE_BARRIER
> +	PPC_ATOMIC_ENTRY_BARRIER
>  "1:	lwarx	%0,0,%1		# atomic_dec_if_positive\n\
>  	cmpwi	%0,1\n\
>  	addi	%0,%0,-1\n\
> @@ -234,7 +234,7 @@ static __inline__ int atomic_dec_if_positive(atomic_t *v)
>  	PPC405_ERR77(0,%1)
>  "	stwcx.	%0,0,%1\n\
>  	bne-	1b"
> -	PPC_ACQUIRE_BARRIER
> +	PPC_ATOMIC_EXIT_BARRIER
>  	"\n\
>  2:"	: "=&b" (t)
>  	: "r" (&v->counter)
> @@ -285,12 +285,12 @@ static __inline__ long atomic64_add_return(long a, atomic64_t *v)
>  	long t;
> 
>  	__asm__ __volatile__(
> -	PPC_RELEASE_BARRIER
> +	PPC_ATOMIC_ENTRY_BARRIER
>  "1:	ldarx	%0,0,%2		# atomic64_add_return\n\
>  	add	%0,%1,%0\n\
>  	stdcx.	%0,0,%2 \n\
>  	bne-	1b"
> -	PPC_ACQUIRE_BARRIER
> +	PPC_ATOMIC_EXIT_BARRIER
>  	: "=&r" (t)
>  	: "r" (a), "r" (&v->counter)
>  	: "cc", "memory");
> @@ -319,12 +319,12 @@ static __inline__ long atomic64_sub_return(long a, atomic64_t *v)
>  	long t;
> 
>  	__asm__ __volatile__(
> -	PPC_RELEASE_BARRIER
> +	PPC_ATOMIC_ENTRY_BARRIER
>  "1:	ldarx	%0,0,%2		# atomic64_sub_return\n\
>  	subf	%0,%1,%0\n\
>  	stdcx.	%0,0,%2 \n\
>  	bne-	1b"
> -	PPC_ACQUIRE_BARRIER
> +	PPC_ATOMIC_EXIT_BARRIER
>  	: "=&r" (t)
>  	: "r" (a), "r" (&v->counter)
>  	: "cc", "memory");
> @@ -351,12 +351,12 @@ static __inline__ long atomic64_inc_return(atomic64_t *v)
>  	long t;
> 
>  	__asm__ __volatile__(
> -	PPC_RELEASE_BARRIER
> +	PPC_ATOMIC_ENTRY_BARRIER
>  "1:	ldarx	%0,0,%1		# atomic64_inc_return\n\
>  	addic	%0,%0,1\n\
>  	stdcx.	%0,0,%1 \n\
>  	bne-	1b"
> -	PPC_ACQUIRE_BARRIER
> +	PPC_ATOMIC_EXIT_BARRIER
>  	: "=&r" (t)
>  	: "r" (&v->counter)
>  	: "cc", "xer", "memory");
> @@ -393,12 +393,12 @@ static __inline__ long atomic64_dec_return(atomic64_t *v)
>  	long t;
> 
>  	__asm__ __volatile__(
> -	PPC_RELEASE_BARRIER
> +	PPC_ATOMIC_ENTRY_BARRIER
>  "1:	ldarx	%0,0,%1		# atomic64_dec_return\n\
>  	addic	%0,%0,-1\n\
>  	stdcx.	%0,0,%1\n\
>  	bne-	1b"
> -	PPC_ACQUIRE_BARRIER
> +	PPC_ATOMIC_EXIT_BARRIER
>  	: "=&r" (t)
>  	: "r" (&v->counter)
>  	: "cc", "xer", "memory");
> @@ -418,13 +418,13 @@ static __inline__ long atomic64_dec_if_positive(atomic64_t *v)
>  	long t;
> 
>  	__asm__ __volatile__(
> -	PPC_RELEASE_BARRIER
> +	PPC_ATOMIC_ENTRY_BARRIER
>  "1:	ldarx	%0,0,%1		# atomic64_dec_if_positive\n\
>  	addic.	%0,%0,-1\n\
>  	blt-	2f\n\
>  	stdcx.	%0,0,%1\n\
>  	bne-	1b"
> -	PPC_ACQUIRE_BARRIER
> +	PPC_ATOMIC_EXIT_BARRIER
>  	"\n\
>  2:"	: "=&r" (t)
>  	: "r" (&v->counter)
> @@ -450,14 +450,14 @@ static __inline__ int atomic64_add_unless(atomic64_t *v, long a, long u)
>  	long t;
> 
>  	__asm__ __volatile__ (
> -	PPC_RELEASE_BARRIER
> +	PPC_ATOMIC_ENTRY_BARRIER
>  "1:	ldarx	%0,0,%1		# __atomic_add_unless\n\
>  	cmpd	0,%0,%3 \n\
>  	beq-	2f \n\
>  	add	%0,%2,%0 \n"
>  "	stdcx.	%0,0,%1 \n\
>  	bne-	1b \n"
> -	PPC_ACQUIRE_BARRIER
> +	PPC_ATOMIC_EXIT_BARRIER
>  "	subf	%0,%2,%0 \n\
>  2:"
>  	: "=&r" (t)
> diff --git a/arch/powerpc/include/asm/bitops.h b/arch/powerpc/include/asm/bitops.h
> index e137afc..efdc926 100644
> --- a/arch/powerpc/include/asm/bitops.h
> +++ b/arch/powerpc/include/asm/bitops.h
> @@ -124,14 +124,14 @@ static __inline__ unsigned long fn(			\
>  	return (old & mask);				\
>  }
> 
> -DEFINE_TESTOP(test_and_set_bits, or, PPC_RELEASE_BARRIER,
> -	      PPC_ACQUIRE_BARRIER, 0)
> +DEFINE_TESTOP(test_and_set_bits, or, PPC_ATOMIC_ENTRY_BARRIER,
> +	      PPC_ATOMIC_EXIT_BARRIER, 0)
>  DEFINE_TESTOP(test_and_set_bits_lock, or, "",
>  	      PPC_ACQUIRE_BARRIER, 1)
> -DEFINE_TESTOP(test_and_clear_bits, andc, PPC_RELEASE_BARRIER,
> -	      PPC_ACQUIRE_BARRIER, 0)
> -DEFINE_TESTOP(test_and_change_bits, xor, PPC_RELEASE_BARRIER,
> -	      PPC_ACQUIRE_BARRIER, 0)
> +DEFINE_TESTOP(test_and_clear_bits, andc, PPC_ATOMIC_ENTRY_BARRIER,
> +	      PPC_ATOMIC_EXIT_BARRIER, 0)
> +DEFINE_TESTOP(test_and_change_bits, xor, PPC_ATOMIC_ENTRY_BARRIER,
> +	      PPC_ATOMIC_EXIT_BARRIER, 0)
> 
>  static __inline__ int test_and_set_bit(unsigned long nr,
>  				       volatile unsigned long *addr)
> diff --git a/arch/powerpc/include/asm/futex.h b/arch/powerpc/include/asm/futex.h
> index c94e4a3..2a9cf84 100644
> --- a/arch/powerpc/include/asm/futex.h
> +++ b/arch/powerpc/include/asm/futex.h
> @@ -11,12 +11,13 @@
> 
>  #define __futex_atomic_op(insn, ret, oldval, uaddr, oparg) \
>    __asm__ __volatile ( \
> -	PPC_RELEASE_BARRIER \
> +	PPC_ATOMIC_ENTRY_BARRIER \
>  "1:	lwarx	%0,0,%2\n" \
>  	insn \
>  	PPC405_ERR77(0, %2) \
>  "2:	stwcx.	%1,0,%2\n" \
>  	"bne-	1b\n" \
> +	PPC_ATOMIC_EXIT_BARRIER \
>  	"li	%1,0\n" \
>  "3:	.section .fixup,\"ax\"\n" \
>  "4:	li	%1,%3\n" \
> @@ -92,14 +93,14 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
>  		return -EFAULT;
> 
>          __asm__ __volatile__ (
> -        PPC_RELEASE_BARRIER
> +        PPC_ATOMIC_ENTRY_BARRIER
>  "1:     lwarx   %1,0,%3         # futex_atomic_cmpxchg_inatomic\n\
>          cmpw    0,%1,%4\n\
>          bne-    3f\n"
>          PPC405_ERR77(0,%3)
>  "2:     stwcx.  %5,0,%3\n\
>          bne-    1b\n"
> -        PPC_ACQUIRE_BARRIER
> +        PPC_ATOMIC_EXIT_BARRIER
>  "3:	.section .fixup,\"ax\"\n\
>  4:	li	%0,%6\n\
>  	b	3b\n\
> diff --git a/arch/powerpc/include/asm/synch.h b/arch/powerpc/include/asm/synch.h
> index d7cab44..24fc618 100644
> --- a/arch/powerpc/include/asm/synch.h
> +++ b/arch/powerpc/include/asm/synch.h
> @@ -41,11 +41,15 @@ static inline void isync(void)
>  	START_LWSYNC_SECTION(97);			\
>  	isync;						\
>  	MAKE_LWSYNC_SECTION_ENTRY(97, __lwsync_fixup);
> -#define PPC_ACQUIRE_BARRIER	"\n" stringify_in_c(__PPC_ACQUIRE_BARRIER)
> -#define PPC_RELEASE_BARRIER	stringify_in_c(LWSYNC) "\n"
> +#define PPC_ACQUIRE_BARRIER	 "\n" stringify_in_c(__PPC_ACQUIRE_BARRIER)
> +#define PPC_RELEASE_BARRIER	 stringify_in_c(LWSYNC) "\n"
> +#define PPC_ATOMIC_ENTRY_BARRIER "\n" stringify_in_c(LWSYNC) "\n"
> +#define PPC_ATOMIC_EXIT_BARRIER	 "\n" stringify_in_c(sync) "\n"
>  #else
>  #define PPC_ACQUIRE_BARRIER
>  #define PPC_RELEASE_BARRIER
> +#define PPC_ATOMIC_ENTRY_BARRIER
> +#define PPC_ATOMIC_EXIT_BARRIER
>  #endif
> 
>  #endif /* __KERNEL__ */
> 
> 
