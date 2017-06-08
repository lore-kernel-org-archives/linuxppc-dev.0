Return-Path: <srs0=sx90=5n=infradead.org=peterz@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wk4sk0VtCzDqGr
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Jun 2017 22:46:02 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3wk4sj6Qmdz8t3p
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Jun 2017 22:46:01 +1000 (AEST)
Date: Thu, 8 Jun 2017 14:45:40 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, torvalds@linux-foundation.org,
 will.deacon@arm.com, oleg@redhat.com, paulmck@linux.vnet.ibm.com,
 benh@kernel.crashing.org, linux-kernel@vger.kernel.org,
 mingo@kernel.org, stern@rowland.harvard.edu,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Re: [RFC][PATCH 5/5] powerpc: Remove SYNC from _switch
Message-ID: <20170608124540.olt2rv3nbnd45pxr@hirez.programming.kicks-ass.net>
References: <20170607161501.819948352@infradead.org>
 <20170607162013.905320602@infradead.org>
 <20170608103244.1b4b24c9@roar.ozlabs.ibm.com>
 <20170608065400.zhfao5lba6i3s7j6@hirez.programming.kicks-ass.net>
 <20170608172938.62b30475@roar.ozlabs.ibm.com>
 <20170608075720.kc2p3tybghzbmrz3@hirez.programming.kicks-ass.net>
 <877f0mere1.fsf@concordia.ellerman.id.au>
 <20170608200015.7f92965a@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170608200015.7f92965a@roar.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 08, 2017 at 08:00:15PM +1000, Nicholas Piggin wrote:

> I have those, I just also would like one in the core scheduler's use
> of smp_mb__after_spinlock(), because it would be easy for core scheduler
> change to miss that quirk. Sure we can say that Peter and scheduler
> maintainers know about powerpc oddities, but then why shouldn't it also
> go into a comment there?

So the core scheduler guarantees smp_mb() or equivalent full transitive
ordering happens at schedule() time.

It has for a fairly long time and I don't think we'll ever get rid of
that, its fairly fundamental.

PPC is special in that smp_mb() ends up being the strongest ordering
primitive there is. But note that PPC is not unique, afaict Alpha is in
the same boat. They rely on the MB from the scheduler core.

IA64 OTOH, while they have smp_mb() == mb() still needs SYNC.I in
__switch_to() to serialize against (instruction) cache flushes.

So while I'm all for adding comments explaining what the core provides,
I don't see immediate reasons to call out PPC.
