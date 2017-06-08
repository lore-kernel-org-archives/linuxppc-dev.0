Return-Path: <srs0=lqgv=5n=gmail.com=npiggin@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wjxry3GX3zDqLD
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Jun 2017 17:29:54 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3wjxry2XhGz8sZm
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Jun 2017 17:29:54 +1000 (AEST)
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3wjxrx6F9mz9s3w
 for <linuxppc-dev@ozlabs.org>; Thu,  8 Jun 2017 17:29:53 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id f127so3737361pgc.2
 for <linuxppc-dev@ozlabs.org>; Thu, 08 Jun 2017 00:29:53 -0700 (PDT)
Date: Thu, 8 Jun 2017 17:29:38 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: torvalds@linux-foundation.org, will.deacon@arm.com, oleg@redhat.com,
 paulmck@linux.vnet.ibm.com, benh@kernel.crashing.org, mpe@ellerman.id.au,
 linux-kernel@vger.kernel.org, mingo@kernel.org, stern@rowland.harvard.edu,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Re: [RFC][PATCH 5/5] powerpc: Remove SYNC from _switch
Message-ID: <20170608172938.62b30475@roar.ozlabs.ibm.com>
In-Reply-To: <20170608065400.zhfao5lba6i3s7j6@hirez.programming.kicks-ass.net>
References: <20170607161501.819948352@infradead.org>
 <20170607162013.905320602@infradead.org>
 <20170608103244.1b4b24c9@roar.ozlabs.ibm.com>
 <20170608065400.zhfao5lba6i3s7j6@hirez.programming.kicks-ass.net>
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

On Thu, 8 Jun 2017 08:54:00 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Thu, Jun 08, 2017 at 10:32:44AM +1000, Nicholas Piggin wrote:
> > On Wed, 07 Jun 2017 18:15:06 +0200
> > Peter Zijlstra <peterz@infradead.org> wrote:
> >   
> > > Now that the scheduler's rq->lock is RCsc and thus provides full
> > > transitivity between scheduling actions. And since we cannot migrate
> > > current, a task needs a switch-out and a switch-in in order to
> > > migrate, in which case the RCsc provides all the ordering we need.  
> > 
> > Hi Peter,
> > 
> > I'm actually just working on removing this right now too, so
> > good timing.
> > 
> > I think we can't "just" remove it, because it is required to order
> > MMIO on powerpc as well.  
> 
> How is MMIO special? That is, there is only MMIO before we call into
> schedule() right? So the rq->lock should be sufficient to order that
> too.

MMIO uses different barriers. spinlock and smp_ type barriers do
not order it.

> > 
> > But what I have done is to comment that some other primitives are
> > already providing the hwsync for other, so we don't have to add
> > another one in _switch.  
> 
> Right, so this patch relies on the smp_mb__before_spinlock ->
> smp_mb__after_spinlock conversion that makes the rq->lock RCsc and
> should thus provide the required SYNC for migrations.

AFAIKS either one will do, so long as there is a hwsync there. The
point is just that I have added some commentary in the generic and
powerpc parts to make it clear we're relying on that behavior of
the primitive. smp_mb* is not guaranteed to order MMIO, it's just
that it does on powerpc.

> That said, I think you can already use the smp_mb__before_spinlock() as
> that is done with IRQs disabled, but its a more difficult argument. The
> rq->lock RCsc property should be more obvious.

This is what I got.

https://patchwork.ozlabs.org/patch/770154/

But I'm not sure if I followed I'm not sure why it's a more
difficult argument: any time a process moves it must first execute
a hwsync on the current CPU after it has performed all its access
there, and then it must execute hwsync on the new CPU before it
performs any new access.
