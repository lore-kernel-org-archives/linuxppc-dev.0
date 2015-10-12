Return-Path: <boqun.feng@gmail.com>
Received: from mail-ob0-x235.google.com (mail-ob0-x235.google.com
 [IPv6:2607:f8b0:4003:c01::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 093751A0B93
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2015 01:23:40 +1100 (AEDT)
Received: by obbzf10 with SMTP id zf10so107333744obb.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2015 07:23:38 -0700 (PDT)
Date: Mon, 12 Oct 2015 22:23:18 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will.deacon@arm.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Waiman Long <waiman.long@hp.com>,
 Davidlohr Bueso <dave@stgolabs.net>, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/6] powerpc: atomic: Make *xchg and *cmpxchg a full
 barrier
Message-ID: <20151012142317.GI27351@fixme-laptop.cn.ibm.com>
References: <1444659246-24769-1-git-send-email-boqun.feng@gmail.com>
 <1444659246-24769-2-git-send-email-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1444659246-24769-2-git-send-email-boqun.feng@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Oops.. sorry. I will resend this one with correct address list.

On Mon, Oct 12, 2015 at 10:14:01PM +0800, Boqun Feng wrote:
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
> Cc: stable@vger.kernel.org # 3.4.y-
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
> 2.5.3
> 
