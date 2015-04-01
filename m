Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 82E9D1A0743
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Apr 2015 02:26:11 +1100 (AEDT)
Received: from /spool/local
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Wed, 1 Apr 2015 09:26:09 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id CF33F1FF0023
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Apr 2015 09:17:17 -0600 (MDT)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id t31FOJnI34734142
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Apr 2015 08:24:19 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t31FQ62m016215
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Apr 2015 09:26:06 -0600
Date: Wed, 1 Apr 2015 08:26:05 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Will Deacon <will.deacon@arm.com>
Subject: Re: [RESEND PATCH] documentation: memory-barriers: fix
 smp_mb__before_spinlock() semantics
Message-ID: <20150401152605.GP9023@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <1427791181-21952-1-git-send-email-will.deacon@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1427791181-21952-1-git-send-email-will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 31, 2015 at 09:39:41AM +0100, Will Deacon wrote:
> Our current documentation claims that, when followed by an ACQUIRE,
> smp_mb__before_spinlock() orders prior loads against subsequent loads
> and stores, which isn't actually true.
> 
> Fix the documentation to state that this sequence orders only prior
> stores against subsequent loads and stores.
> 
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
> 
> Could somebody pick this up please? I guess I could route it via the arm64
> tree with an Ack, but I'd rather it went through Paul or -tip.

Queued for 4.2, along with a separate patch for PowerPC that make it so
that PowerPC actually behaves as described below.  ;-)

							Thanx, Paul

>  Documentation/memory-barriers.txt | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
> index ca2387ef27ab..fa28a0c1e2b1 100644
> --- a/Documentation/memory-barriers.txt
> +++ b/Documentation/memory-barriers.txt
> @@ -1768,10 +1768,9 @@ for each construct.  These operations all imply certain barriers:
> 
>       Memory operations issued before the ACQUIRE may be completed after
>       the ACQUIRE operation has completed.  An smp_mb__before_spinlock(),
> -     combined with a following ACQUIRE, orders prior loads against
> -     subsequent loads and stores and also orders prior stores against
> -     subsequent stores.  Note that this is weaker than smp_mb()!  The
> -     smp_mb__before_spinlock() primitive is free on many architectures.
> +     combined with a following ACQUIRE, orders prior stores against
> +     subsequent loads and stores. Note that this is weaker than smp_mb()!
> +     The smp_mb__before_spinlock() primitive is free on many architectures.
> 
>   (2) RELEASE operation implication:

------------------------------------------------------------------------

    powerpc: Fix smp_mb__before_spinlock()
    
    Currently, smp_mb__before_spinlock() is defined to be smp_wmb()
    in core code, but this is not sufficient on PowerPC.  This patch
    therefore supplies an override for the generic definition to
    strengthen smp_mb__before_spinlock() to smp_mb(), as is needed
    on PowerPC.
    
    Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
    Cc: <linuxppc-dev@lists.ozlabs.org>

diff --git a/arch/powerpc/include/asm/barrier.h b/arch/powerpc/include/asm/barrier.h
index a3bf5be111ff..1124f59b8df4 100644
--- a/arch/powerpc/include/asm/barrier.h
+++ b/arch/powerpc/include/asm/barrier.h
@@ -89,5 +89,6 @@ do {									\
 
 #define smp_mb__before_atomic()     smp_mb()
 #define smp_mb__after_atomic()      smp_mb()
+#define smp_mb__before_spinlock()   smp_mb()
 
 #endif /* _ASM_POWERPC_BARRIER_H */
