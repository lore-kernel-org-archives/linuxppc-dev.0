Return-Path: <srs0=lqgv=5n=gmail.com=npiggin@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wk1Bn21mbzDqFH
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Jun 2017 20:00:33 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3wk1Bn15Wpz8t6D
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Jun 2017 20:00:33 +1000 (AEST)
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3wk1Bm45gCz9sCZ
 for <linuxppc-dev@ozlabs.org>; Thu,  8 Jun 2017 20:00:32 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id f27so4587683pfe.0
 for <linuxppc-dev@ozlabs.org>; Thu, 08 Jun 2017 03:00:32 -0700 (PDT)
Date: Thu, 8 Jun 2017 20:00:15 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Peter Zijlstra <peterz@infradead.org>, torvalds@linux-foundation.org,
 will.deacon@arm.com, oleg@redhat.com, paulmck@linux.vnet.ibm.com,
 benh@kernel.crashing.org, linux-kernel@vger.kernel.org, mingo@kernel.org,
 stern@rowland.harvard.edu, linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Re: [RFC][PATCH 5/5] powerpc: Remove SYNC from _switch
Message-ID: <20170608200015.7f92965a@roar.ozlabs.ibm.com>
In-Reply-To: <877f0mere1.fsf@concordia.ellerman.id.au>
References: <20170607161501.819948352@infradead.org>
 <20170607162013.905320602@infradead.org>
 <20170608103244.1b4b24c9@roar.ozlabs.ibm.com>
 <20170608065400.zhfao5lba6i3s7j6@hirez.programming.kicks-ass.net>
 <20170608172938.62b30475@roar.ozlabs.ibm.com>
 <20170608075720.kc2p3tybghzbmrz3@hirez.programming.kicks-ass.net>
 <877f0mere1.fsf@concordia.ellerman.id.au>
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

On Thu, 08 Jun 2017 19:54:30 +1000
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Peter Zijlstra <peterz@infradead.org> writes:
> > On Thu, Jun 08, 2017 at 05:29:38PM +1000, Nicholas Piggin wrote:  
> >> On Thu, 8 Jun 2017 08:54:00 +0200
> >> Peter Zijlstra <peterz@infradead.org> wrote:  
> >> > 
> >> > Right, so this patch relies on the smp_mb__before_spinlock ->
> >> > smp_mb__after_spinlock conversion that makes the rq->lock RCsc and
> >> > should thus provide the required SYNC for migrations.  
> >> 
> >> AFAIKS either one will do, so long as there is a hwsync there. The
> >> point is just that I have added some commentary in the generic and
> >> powerpc parts to make it clear we're relying on that behavior of
> >> the primitive. smp_mb* is not guaranteed to order MMIO, it's just
> >> that it does on powerpc.  
> >
> > I'm not particularly happy with the generic comment; I don't feel we
> > should care that PPC is special here.  
> 
> I think it'd be nice if there was *some* comment on the two uses of
> smp_mb__after_spinlock(), it's fairly subtle, but I don't think it needs
> to mention PPC specifically.
> 
> 
> If we have:
> 
> arch/powerpc/include/asm/barrier.h:
> +/*
> + * This must resolve to hwsync on SMP for the context switch path. See
> + * _switch.
> + */
>  #define smp_mb__after_spinlock()   smp_mb()
> 
> 
> And then something in _switch() that says "we rely on the
> smp_mb__after_spinlock() in the scheduler core being a hwsync", that
> should probably be sufficient.

I have those, I just also would like one in the core scheduler's use
of smp_mb__after_spinlock(), because it would be easy for core scheduler
change to miss that quirk. Sure we can say that Peter and scheduler
maintainers know about powerpc oddities, but then why shouldn't it also
go into a comment there?

Thanks,
Nick
