Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CF4F51A072A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2015 07:19:14 +1100 (AEDT)
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Wed, 14 Oct 2015 14:19:12 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 688133E4003E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2015 14:19:09 -0600 (MDT)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id t9EKI84U56099024
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2015 13:18:08 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9EKJ74i021905
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2015 14:19:08 -0600
Date: Wed, 14 Oct 2015 13:19:17 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will.deacon@arm.com>, Waiman Long <waiman.long@hp.com>,
 Davidlohr Bueso <dave@stgolabs.net>, stable@vger.kernel.org
Subject: Re: [PATCH tip/locking/core v4 1/6] powerpc: atomic: Make *xchg and
 *cmpxchg a full barrier
Message-ID: <20151014201916.GB3910@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <1444838161-17209-1-git-send-email-boqun.feng@gmail.com>
 <1444838161-17209-2-git-send-email-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1444838161-17209-2-git-send-email-boqun.feng@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 14, 2015 at 11:55:56PM +0800, Boqun Feng wrote:
> According to memory-barriers.txt, xchg, cmpxchg and their atomic{,64}_
> versions all need to imply a full barrier, however they are now just
> RELEASE+ACQUIRE, which is not a full barrier.
> 
> So replace PPC_RELEASE_BARRIER and PPC_ACQUIRE_BARRIER with
> PPC_ATOMIC_ENTRY_BARRIER and PPC_ATOMIC_EXIT_BARRIER in
> __{cmp,}xchg_{u32,u64} respectively to guarantee a full barrier
> semantics of atomic{,64}_{cmp,}xchg() and {cmp,}xchg().
> 
> This patch is a complement of commit b97021f85517 ("powerpc: Fix
> atomic_xxx_return barrier semantics").
> 
> Acked-by: Michael Ellerman <mpe@ellerman.id.au>
> Cc: <stable@vger.kernel.org> # 3.4+
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
>  arch/powerpc/include/asm/cmpxchg.h | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/cmpxchg.h b/arch/powerpc/include/asm/cmpxchg.h
> index ad6263c..d1a8d93 100644
> --- a/arch/powerpc/include/asm/cmpxchg.h
> +++ b/arch/powerpc/include/asm/cmpxchg.h
> @@ -18,12 +18,12 @@ __xchg_u32(volatile void *p, unsigned long val)
>  	unsigned long prev;
> 
>  	__asm__ __volatile__(
> -	PPC_RELEASE_BARRIER
> +	PPC_ATOMIC_ENTRY_BARRIER

This looks to be the lwsync instruction.

>  "1:	lwarx	%0,0,%2 \n"
>  	PPC405_ERR77(0,%2)
>  "	stwcx.	%3,0,%2 \n\
>  	bne-	1b"
> -	PPC_ACQUIRE_BARRIER
> +	PPC_ATOMIC_EXIT_BARRIER

And this looks to be the sync instruction.

>  	: "=&r" (prev), "+m" (*(volatile unsigned int *)p)
>  	: "r" (p), "r" (val)
>  	: "cc", "memory");

Hmmm...

Suppose we have something like the following, where "a" and "x" are both
initially zero:

	CPU 0				CPU 1
	-----				-----

	WRITE_ONCE(x, 1);		WRITE_ONCE(a, 2);
	r3 = xchg(&a, 1);		smp_mb();
					r3 = READ_ONCE(x);

If xchg() is fully ordered, we should never observe both CPUs'
r3 values being zero, correct?

And wouldn't this be represented by the following litmus test?

	PPC SB+lwsync-RMW2-lwsync+st-sync-leading
	""
	{
	0:r1=1; 0:r2=x; 0:r3=3; 0:r10=0 ; 0:r11=0; 0:r12=a;
	1:r1=2; 1:r2=x; 1:r3=3; 1:r10=0 ; 1:r11=0; 1:r12=a;
	}
	 P0                 | P1                 ;
	 stw r1,0(r2)       | stw r1,0(r12)      ;
	 lwsync             | sync               ;
	 lwarx  r11,r10,r12 | lwz r3,0(r2)       ;
	 stwcx. r1,r10,r12  | ;
	 bne Fail0          | ;
	 mr r3,r11          | ;
	 Fail0:             | ;
	exists
	(0:r3=0 /\ a=2 /\ 1:r3=0)

I left off P0's trailing sync because there is nothing for it to order
against in this particular litmus test.  I tried adding it and verified
that it has no effect.

Am I missing something here?  If not, it seems to me that you need
the leading lwsync to instead be a sync.

Of course, if I am not missing something, then this applies also to the
value-returning RMW atomic operations that you pulled this pattern from.
If so, it would seem that I didn't think through all the possibilities
back when PPC_ATOMIC_EXIT_BARRIER moved to sync...  In fact, I believe
that I worried about the RMW atomic operation acting as a barrier,
but not as the load/store itself.  :-/

							Thanx, Paul

> @@ -61,12 +61,12 @@ __xchg_u64(volatile void *p, unsigned long val)
>  	unsigned long prev;
> 
>  	__asm__ __volatile__(
> -	PPC_RELEASE_BARRIER
> +	PPC_ATOMIC_ENTRY_BARRIER
>  "1:	ldarx	%0,0,%2 \n"
>  	PPC405_ERR77(0,%2)
>  "	stdcx.	%3,0,%2 \n\
>  	bne-	1b"
> -	PPC_ACQUIRE_BARRIER
> +	PPC_ATOMIC_EXIT_BARRIER
>  	: "=&r" (prev), "+m" (*(volatile unsigned long *)p)
>  	: "r" (p), "r" (val)
>  	: "cc", "memory");
> @@ -151,14 +151,14 @@ __cmpxchg_u32(volatile unsigned int *p, unsigned long old, unsigned long new)
>  	unsigned int prev;
> 
>  	__asm__ __volatile__ (
> -	PPC_RELEASE_BARRIER
> +	PPC_ATOMIC_ENTRY_BARRIER
>  "1:	lwarx	%0,0,%2		# __cmpxchg_u32\n\
>  	cmpw	0,%0,%3\n\
>  	bne-	2f\n"
>  	PPC405_ERR77(0,%2)
>  "	stwcx.	%4,0,%2\n\
>  	bne-	1b"
> -	PPC_ACQUIRE_BARRIER
> +	PPC_ATOMIC_EXIT_BARRIER
>  	"\n\
>  2:"
>  	: "=&r" (prev), "+m" (*p)
> @@ -197,13 +197,13 @@ __cmpxchg_u64(volatile unsigned long *p, unsigned long old, unsigned long new)
>  	unsigned long prev;
> 
>  	__asm__ __volatile__ (
> -	PPC_RELEASE_BARRIER
> +	PPC_ATOMIC_ENTRY_BARRIER
>  "1:	ldarx	%0,0,%2		# __cmpxchg_u64\n\
>  	cmpd	0,%0,%3\n\
>  	bne-	2f\n\
>  	stdcx.	%4,0,%2\n\
>  	bne-	1b"
> -	PPC_ACQUIRE_BARRIER
> +	PPC_ATOMIC_EXIT_BARRIER
>  	"\n\
>  2:"
>  	: "=&r" (prev), "+m" (*p)
> -- 
> 2.5.3
> 
