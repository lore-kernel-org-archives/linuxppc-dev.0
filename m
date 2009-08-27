Return-Path: <amit.shah@redhat.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 4D124B7B7F
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 27 Aug 2009 16:51:51 +1000 (EST)
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id D14B2DDD01
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Aug 2009 16:51:50 +1000 (EST)
Date: Thu, 27 Aug 2009 12:21:02 +0530
From: Amit Shah <amit.shah@redhat.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [Qemu-devel] Re: Extending virtio_console to support multiple
	ports
Message-ID: <20090827065102.GA3218@amit-x200.redhat.com>
References: <1251181044-3696-1-git-send-email-amit.shah@redhat.com>
	<20090826112718.GA11117@amit-x200.redhat.com>
	<20090826154552.GA31910@amit-x200.redhat.com>
	<1251346023.20467.21.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1251346023.20467.21.camel@pasglop>
Cc: kvm@vger.kernel.org, borntraeger@de.ibm.com, qemu-devel@nongnu.org,
	miltonm@bga.com, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, brueckner@linux.vnet.ibm.com,
	virtualization@lists.linux-foundation.org, alan@linux.intel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On (Thu) Aug 27 2009 [14:07:03], Benjamin Herrenschmidt wrote:
> On Wed, 2009-08-26 at 21:15 +0530, Amit Shah wrote:
> 
> > 
> > > - Convert hvc's usage of spinlocks to mutexes. I've no idea how this
> > >   will play out; I'm no expert here. But I did try doing this and so far
> > >   it all looks OK. No lockups, lockdep warnings, nothing. I have full
> > >   debugging enabled. But this doesn't mean it's right.
> > 
> > So just to test this further I added the capability to have more than
> > one hvc console spawn from virtio_console, created two consoles and did
> > a 'cat' of a file in each of the virtio-consoles. It's been running for
> > half an hour now without any badness. No spew in debug logs too.
> > 
> > I also checked the code in hvc_console.c that takes the spin_locks.
> > Nothing there that runs from (or needs to run from) interrupt context.
> > So the change to mutexes does seem reasonable. Also, the spinlock code
> > was added really long back -- git blame shows Linus' first git commit
> > introduced them in the git history, so it's pure legacy baggage.
> 
> Two things here:
> 
>  - First you seem to have completely missed the fact that hvc_poll() can
> be called from interrupt time :-) Look at hvc_irq.c which is used by

Right! That's the obvious one.

> some backends. Maybe that can be "fixed" by deferring to a work queue,
> though it's nice to have the keyboard input have somewhat of a higher
> priority than anything else here.

Hm, to maintain the current behaviour of poll() returning some
poll_mask, the poll_mask could be made into an atomic variable with
khvcd() updating it. But to have read at a higher priority than the
other stuff, I don't quite see yet how that can be done.

> So unless that's fixed, or I missed something, that's a big NACK for
> now.
> 
>  - Then, are we certain that there's no case where the tty layer will
> call us with some lock held or in an atomic context ? To be honest, I've

The other routines are open(), close(), write(), etc., and other kernel
context (hvc_instantiate() and the khvcd thread).

> totally lost track of the locking rules in tty land lately so it might
> well be ok, but something to verify.

Yes.

Thanks for the response!

		Amit
