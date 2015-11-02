Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 38D941A03C6
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Nov 2015 13:27:53 +1100 (AEDT)
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Sun, 1 Nov 2015 19:27:50 -0700
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 163BD3E40041
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Nov 2015 19:27:48 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id tA22OOde56229960
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 1 Nov 2015 19:24:24 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tA22RkGq022600
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 1 Nov 2015 19:27:47 -0700
Date: Sun, 1 Nov 2015 18:28:00 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will.deacon@arm.com>, stable@vger.kernel.org
Subject: Re: [PATCH powerpc/next 2/2] powerpc: Make {cmp}xchg* and their
 atomic_ versions fully ordered
Message-ID: <20151102022800.GM4122@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <1446427832-8742-1-git-send-email-boqun.feng@gmail.com>
 <1446427832-8742-2-git-send-email-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1446427832-8742-2-git-send-email-boqun.feng@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 02, 2015 at 09:30:32AM +0800, Boqun Feng wrote:
> According to memory-barriers.txt, xchg*, cmpxchg* and their atomic_
> versions all need to be fully ordered, however they are now just
> RELEASE+ACQUIRE, which are not fully ordered.
> 
> So also replace PPC_RELEASE_BARRIER and PPC_ACQUIRE_BARRIER with
> PPC_ATOMIC_ENTRY_BARRIER and PPC_ATOMIC_EXIT_BARRIER in
> __{cmp,}xchg_{u32,u64} respectively to guarantee fully ordered semantics
> of atomic{,64}_{cmp,}xchg() and {cmp,}xchg(), as a complement of commit
> b97021f85517 ("powerpc: Fix atomic_xxx_return barrier semantics")
> 
> This patch depends on patch "powerpc: Make value-returning atomics fully
> ordered" for PPC_ATOMIC_ENTRY_BARRIER definition.
> 
> Cc: <stable@vger.kernel.org> # 3.4+
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>

Reviewed-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

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
>  "1:	lwarx	%0,0,%2 \n"
>  	PPC405_ERR77(0,%2)
>  "	stwcx.	%3,0,%2 \n\
>  	bne-	1b"
> -	PPC_ACQUIRE_BARRIER
> +	PPC_ATOMIC_EXIT_BARRIER
>  	: "=&r" (prev), "+m" (*(volatile unsigned int *)p)
>  	: "r" (p), "r" (val)
>  	: "cc", "memory");
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
> 2.6.2
> 
