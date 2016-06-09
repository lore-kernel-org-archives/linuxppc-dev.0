Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rQPbr1ZJRzDq9y
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jun 2016 22:23:36 +1000 (AEST)
Message-ID: <1465475008.16363.1.camel@ellerman.id.au>
Subject: Re: [PATCH v3] powerpc: spinlock: Fix spin_unlock_wait()
From: Michael Ellerman <mpe@ellerman.id.au>
To: Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, "Paul E.
 McKenney" <paulmck@linux.vnet.ibm.com>, Will Deacon <will.deacon@arm.com>
Date: Thu, 09 Jun 2016 22:23:28 +1000
In-Reply-To: <20160608135903.GT30154@twins.programming.kicks-ass.net>
References: <1465213340.2658.1.camel@ellerman.id.au>
 <20160606115655.GD30909@twins.programming.kicks-ass.net>
 <1465215445.2658.4.camel@ellerman.id.au>
 <20160606144659.GG30909@twins.programming.kicks-ass.net>
 <1465384845.13854.7.camel@ellerman.id.au>
 <20160608123507.GR30154@twins.programming.kicks-ass.net>
 <1465393760.10567.4.camel@ellerman.id.au>
 <20160608135903.GT30154@twins.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-06-08 at 15:59 +0200, Peter Zijlstra wrote:
> On Wed, Jun 08, 2016 at 11:49:20PM +1000, Michael Ellerman wrote:
>
> > > Ok; what tree does this go in? I have this dependent series which I'd
> > > like to get sorted and merged somewhere.
> > 
> > Ah sorry, I didn't realise. I was going to put it in my next (which doesn't
> > exist yet but hopefully will early next week).
> > 
> > I'll make a topic branch with just that commit based on rc2 or rc3?
> 
> Works for me; thanks!
 
Unfortunately the patch isn't 100%.

It's causing some of my machines to lock up hard, which isn't surprising when
you look at the generated code for the non-atomic spin loop:

  c00000000009af48:	7c 21 0b 78 	mr      r1,r1					# HMT_LOW
  c00000000009af4c:	40 9e ff fc 	bne     cr7,c00000000009af48 <.do_exit+0x6d8>

Which is a spin loop waiting for a result in cr7, but with no comparison.

The problem seems to be that we did:

@@ -184,7 +184,7 @@ static inline void arch_spin_unlock_wait(arch_spinlock_t *lock)
 	if (arch_spin_value_unlocked(lock_val))
 		goto out;
 
-	while (lock->slock) {
+	while (!arch_spin_value_unlocked(*lock)) {
 		HMT_low();
 		if (SHARED_PROCESSOR)
 			__spin_yield(lock);

Which seems to be hiding the fact that lock->slock is volatile from the
compiler, even though arch_spin_value_unlocked() is inline. Not sure if that's
our bug or gcc's.

Will sleep on it.

cheers
