Return-Path: <rostedt@goodmis.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 22859B7B70
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 19 Aug 2009 09:36:40 +1000 (EST)
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.123]) by ozlabs.org (Postfix) with ESMTP id 8ED2ADDD01
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Aug 2009 09:36:38 +1000 (EST)
Date: Tue, 18 Aug 2009 19:36:35 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] spinlock: __raw_spin_is_locked() should return true for UP
In-Reply-To: <alpine.LFD.2.01.0908181618420.3158@localhost.localdomain>
Message-ID: <alpine.DEB.2.00.0908181931180.28398@gandalf.stny.rr.com>
References: <1250635343-32546-1-git-send-email-galak@kernel.crashing.org>
	<alpine.LFD.2.01.0908181618420.3158@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: peterz@infradead.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	mingo@elte.hu, tglx@linutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Tue, 18 Aug 2009, Linus Torvalds wrote:

> 
> 
> On Tue, 18 Aug 2009, Kumar Gala wrote:
> >
> > For some reason __raw_spin_is_locked() has been returning false for the
> > uni-processor, non-CONFIG_DEBUG_SPINLOCK.  The UP + CONFIG_DEBUG_SPINLOCK
> > handles this correctly.
> > 
> > Found this by enabling CONFIG_DEBUG_VM on PPC and hitting always hitting
> > a BUG_ON that was testing to make sure the pte_lock was held.
> > 
> > Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> > ---
> > 
> > Linus, a fix for 2.6.31
> 
> This really isn't all that clear.
> 
> The thing is, some people may assert that a lock is held, but others could 
> easily be looping until it's not held using something like
> 
> 	while (spin_is_locked(lock))
> 		cpu_relax();

Wouldn't something like that be really racey? And anyone doing such a 
thing had better have that code within an #ifdef CONFIG_SMP.

> 
> so it's hard to tell whether it should return true or false in the case 
> where spin-locking simply doesn't exist.

Actually, I did have a case where I would use it and would expect a return 
of 0. That was in the experimental printk code to see if it was safe to 
wakeup the klogd. I once had a check of the current cpu runqueue lock is 
locked, and if it was, not to wake up klogd. I'm sure there's other cases 
like this as well.

Thinking about it, UP probably should have spin_is_locked always return 
false, but if you want to make sure you are not in a critical section 
with the lock not held, then use assert_spin_locked, which on UP should be 
a nop.

-- Steve
