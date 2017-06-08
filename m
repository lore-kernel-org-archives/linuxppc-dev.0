Return-Path: <srs0=lqgv=5n=gmail.com=npiggin@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wjz0s4ZZ9zDqCt
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Jun 2017 18:21:49 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3wjz0s3wcVz8snT
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Jun 2017 18:21:49 +1000 (AEST)
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3wjz0r6tYdz9s7t
 for <linuxppc-dev@ozlabs.org>; Thu,  8 Jun 2017 18:21:48 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id u1so4312980pfg.1
 for <linuxppc-dev@ozlabs.org>; Thu, 08 Jun 2017 01:21:48 -0700 (PDT)
Date: Thu, 8 Jun 2017 18:21:34 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: torvalds@linux-foundation.org, will.deacon@arm.com, oleg@redhat.com,
 paulmck@linux.vnet.ibm.com, benh@kernel.crashing.org, mpe@ellerman.id.au,
 linux-kernel@vger.kernel.org, mingo@kernel.org, stern@rowland.harvard.edu,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Re: [RFC][PATCH 5/5] powerpc: Remove SYNC from _switch
Message-ID: <20170608182134.0042716a@roar.ozlabs.ibm.com>
In-Reply-To: <20170608075720.kc2p3tybghzbmrz3@hirez.programming.kicks-ass.net>
References: <20170607161501.819948352@infradead.org>
 <20170607162013.905320602@infradead.org>
 <20170608103244.1b4b24c9@roar.ozlabs.ibm.com>
 <20170608065400.zhfao5lba6i3s7j6@hirez.programming.kicks-ass.net>
 <20170608172938.62b30475@roar.ozlabs.ibm.com>
 <20170608075720.kc2p3tybghzbmrz3@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 8 Jun 2017 09:57:20 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Thu, Jun 08, 2017 at 05:29:38PM +1000, Nicholas Piggin wrote:
> > On Thu, 8 Jun 2017 08:54:00 +0200
> > Peter Zijlstra <peterz@infradead.org> wrote:
> >   
> > > On Thu, Jun 08, 2017 at 10:32:44AM +1000, Nicholas Piggin wrote:  
> > > > On Wed, 07 Jun 2017 18:15:06 +0200
> > > > Peter Zijlstra <peterz@infradead.org> wrote:
> > > >     
> > > > > Now that the scheduler's rq->lock is RCsc and thus provides full
> > > > > transitivity between scheduling actions. And since we cannot migrate
> > > > > current, a task needs a switch-out and a switch-in in order to
> > > > > migrate, in which case the RCsc provides all the ordering we need.    
> > > > 
> > > > Hi Peter,
> > > > 
> > > > I'm actually just working on removing this right now too, so
> > > > good timing.
> > > > 
> > > > I think we can't "just" remove it, because it is required to order
> > > > MMIO on powerpc as well.    
> > > 
> > > How is MMIO special? That is, there is only MMIO before we call into
> > > schedule() right? So the rq->lock should be sufficient to order that
> > > too.  
> > 
> > MMIO uses different barriers. spinlock and smp_ type barriers do
> > not order it.  
> 
> Right, but you only have SYNC, which is what makes it possible at all.

Yeah, but a future CPU in theory could implement some other barrier
which provides hwsync ordering for cacheable memory but not uncacheable.
smp_mb* barriers would be able to use that new type of barrier, except
here.

> Some of the other architectures are not so lucky and need a different
> barrier, ARM for instance needs DSB(ISH) vs the DMB(ISH) provided by
> smp_mb(). IA64, MIPS and a few others are in the same boat as ARM.
> 
> > > > But what I have done is to comment that some other primitives are
> > > > already providing the hwsync for other, so we don't have to add
> > > > another one in _switch.    
> > > 
> > > Right, so this patch relies on the smp_mb__before_spinlock ->
> > > smp_mb__after_spinlock conversion that makes the rq->lock RCsc and
> > > should thus provide the required SYNC for migrations.  
> > 
> > AFAIKS either one will do, so long as there is a hwsync there. The
> > point is just that I have added some commentary in the generic and
> > powerpc parts to make it clear we're relying on that behavior of
> > the primitive. smp_mb* is not guaranteed to order MMIO, it's just
> > that it does on powerpc.  
> 
> I'm not particularly happy with the generic comment; I don't feel we
> should care that PPC is special here.

I think we do though, because its smp_mb happens to also order mmio.

Your patch I think failed to capture that unless I miss something. It's
not that the rq lock is RCsc that we can remove the hwsync, it's that
the smp_mb__before/after_spinlock has a hwsync in it.

As a counter-example: I think you can implement RCsc spinlocks in
powerpc using ll/sc+isync for the acquire, but that would be insufficient
because no hwsync for MMIO.

> > > That said, I think you can already use the smp_mb__before_spinlock() as
> > > that is done with IRQs disabled, but its a more difficult argument. The
> > > rq->lock RCsc property should be more obvious.  
> > 
> > This is what I got.
> > 
> > https://patchwork.ozlabs.org/patch/770154/  
> 
> Your comment isn't fully correct, smp_cond_load_acquire() isn't
> necessarily done by CPUy. It might be easiest to simply refer to the
> "Notes on Program-Order guarantees on SMP systems." comment.

True, thanks.

> > But I'm not sure if I followed I'm not sure why it's a more
> > difficult argument: any time a process moves it must first execute
> > a hwsync on the current CPU after it has performed all its access
> > there, and then it must execute hwsync on the new CPU before it
> > performs any new access.  
> 
> Yeah, its not a terribly difficult argument either way, but I feel the
> RSsc rq->lock on is slightly easier.

It is neater to have the barrier inside the lock, I think.
