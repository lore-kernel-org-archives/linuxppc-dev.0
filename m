Return-Path: <peterz@infradead.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id CB61AB7087
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 19 Aug 2009 19:38:38 +1000 (EST)
Received: from casper.infradead.org (casper.infradead.org [85.118.1.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 68CC8DDD1B
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Aug 2009 19:38:38 +1000 (EST)
Subject: Re: [PATCH] spinlock: __raw_spin_is_locked() should return true for UP
From: Peter Zijlstra <peterz@infradead.org>
To: Olivier Galibert <galibert@pobox.com>
In-Reply-To: <20090819093145.GA53298@dspnet.fr.eu.org>
References: <1250635343-32546-1-git-send-email-galak@kernel.crashing.org>
	<alpine.LFD.2.01.0908181618420.3158@localhost.localdomain>
	<alpine.DEB.2.00.0908181931180.28398@gandalf.stny.rr.com>
	<alpine.LFD.2.01.0908181640120.3158@localhost.localdomain>
	<alpine.DEB.2.00.0908182003430.18648@gandalf.stny.rr.com>
	<BB2762BC-C760-4D4C-BDCF-76EFD3E1B18D@kernel.crashing.org>
	<alpine.LFD.2.01.0908181937400.3158@localhost.localdomain>
	<20090819093145.GA53298@dspnet.fr.eu.org>
Content-Type: text/plain
Date: Wed, 19 Aug 2009 11:38:21 +0200
Message-Id: <1250674701.7583.333.camel@twins>
Mime-Version: 1.0
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, tglx@linutronix.de,
	Linus Torvalds <torvalds@linux-foundation.org>, mingo@elte.hu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2009-08-19 at 11:31 +0200, Olivier Galibert wrote:
> On Tue, Aug 18, 2009 at 07:40:16PM -0700, Linus Torvalds wrote:
> > 
> > 
> > On Tue, 18 Aug 2009, Kumar Gala wrote:
> > > 
> > > I agree its a little too easy to abuse spin_is_locked.  However we should be
> > > consistent between spin_is_locked on UP between with and without
> > > CONFIG_DEBUG_SPINLOCK enabled.
> > 
> > No we shouldn't.
> > 
> > With CONFIG_DEBUG_SPINLOCK, you have an actual lock variable for debugging 
> > purposes, so spin_is_locked() can clearly return a _valid_ answer, and 
> > should do so.
> > 
> > Without DEBUG_SPINLOCK, there isn't any answer to return.
> > 
> > So there's no way we can or should be consistent. In one case an answer 
> > exists, in another one the answer is meaningless and doesn't exist.
> 
> I always thought behaviour should be consistent between code with
> debugging on and code without.  Otherwise you may end up with cases of
> "it starts working when I turn on debugging" which are a pain to fix.
> Has something changed?
> 
> Or in other words, do you think lockdep should try solving deadlocks
> instead of just reporting them for instance?

The point is spin_is_locked() is a broken interface in that respect. Its
plain impossible to give the right answer.


Suppose there's code doing:

  /*
   * Ensure we don't have foo lock taken, because that would cause
   * lock inversion under bar lock.
   */
  BUG_ON(spin_is_locked(&foo));
  spin_lock(&bar);

and other code doing:

  /*
   * Ensure we've got foo locked because it protects bar
   */
  BUG_ON(!spin_is_locked(&foo));
  bar = fancy;

What value should you return when locks don't exist (which is the case
for UP)?


There simply is no right answer other than: don't use spin_is_locked().
