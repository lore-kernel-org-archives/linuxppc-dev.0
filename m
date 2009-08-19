Return-Path: <scottwood@freescale.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 25A72B6F1E
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 20 Aug 2009 04:50:16 +1000 (EST)
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AAE16DDD01
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Aug 2009 04:50:15 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n7JIoBDY009792
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Aug 2009 11:50:12 -0700 (MST)
Received: from b07421-ec1.am.freescale.net (b07421-ec1.am.freescale.net
	[10.82.121.43])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n7JIp6M1024230
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Aug 2009 13:51:06 -0500 (CDT)
Date: Wed, 19 Aug 2009 13:50:10 -0500
From: Scott Wood <scottwood@freescale.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] spinlock: __raw_spin_is_locked() should return true for UP
Message-ID: <20090819185010.GA12304@b07421-ec1.am.freescale.net>
References: <1250635343-32546-1-git-send-email-galak@kernel.crashing.org>
	<alpine.LFD.2.01.0908181618420.3158@localhost.localdomain>
	<alpine.DEB.2.00.0908181931180.28398@gandalf.stny.rr.com>
	<alpine.LFD.2.01.0908181640120.3158@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LFD.2.01.0908181640120.3158@localhost.localdomain>
Cc: peterz@infradead.org, linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>, linuxppc-dev@ozlabs.org,
	mingo@elte.hu, tglx@linutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 18, 2009 at 04:52:20PM -0700, Linus Torvalds wrote:
> 
> 
> On Tue, 18 Aug 2009, Steven Rostedt wrote:
> >
> > > The thing is, some people may assert that a lock is held, but others could 
> > > easily be looping until it's not held using something like
> > > 
> > > 	while (spin_is_locked(lock))
> > > 		cpu_relax();
> > 
> > Wouldn't something like that be really racey? And anyone doing such a 
> > thing had better have that code within an #ifdef CONFIG_SMP.
> 
> Sure, it's hopefully inside a #ifdef CONFIG_SMP.
> 
> And no, it's not necessarily racy. Sure, it's race in itself if that's all 
> you are doing, but I could imagine writing that kind of code if I knew 
> some lock was likely held, and I wanted to avoid doing a "try_lock()" 
> until it got released.

So you'd basically have the effect of a spin_lock(), except with the
bonus of breaking RT hacks that do something other than spin, and
preventing arch code from doing certain types of relaxation that are only
appropriate when waiting on a lock (such as mdors on powerpc, which
de-emphasizes until a reservation is broken).

Not exactly something we should encourage, IMHO.

-Scott
