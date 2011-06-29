Return-Path: <B07421@freescale.com>
Received: from VA3EHSOBE004.bigfish.com (va3ehsobe004.messaging.microsoft.com
	[216.32.180.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C246EB6EDF
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 29 Jun 2011 10:08:28 +1000 (EST)
Date: Tue, 28 Jun 2011 19:08:07 -0500
From: Scott Wood <scottwood@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/timebase_read: don't return time older than
	cycle_last
Message-ID: <20110628190807.53a2c289@schlenkerla.am.freescale.net>
In-Reply-To: <1309303508.32158.473.camel@pasglop>
References: <20110627215613.GA13676@schlenkerla.am.freescale.net>
	<1309221943.32158.412.camel@pasglop>
	<20110628111420.15052d9f@schlenkerla.am.freescale.net>
	<1309303508.32158.473.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 29 Jun 2011 09:25:08 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Tue, 2011-06-28 at 11:14 -0500, Scott Wood wrote:
> > > You are applying a bandage on a wooden leg here .... userspace (vDSO)
> > > will see the time going backward if you aren't well synchronized as
> > > well, so you're stuffed anyways.
> > 
> > Sure -- but we should avoid turning a slight backwards drift into a huge
> > positive offset in the kernel's calculations.  One way to do that is for
> > the generic timekeeping code to be robust against this, for all time
> > sources.  The other is to apply this sort of hack on time sources that are
> > known to possibly go backwards.  The former is the better fix IMHO, but the
> > latter is what was already done for TSC on x86, so I went with the less
> > intrusive change.
> 
> Ok two things. One is first fix the comments then to stop mentioning
> "TSC" :-)

Doh, sorry...

> Second is, I still don't think it's right. There's an expectation on
> powerpc that the timebase works properly. If not, you have a userspace
> visible breakage.

As the changelog notes, this isn't a full enforement of monotonicity, it's
a way to avoid specific problems where the generic kernel timekeeping code
blows up if it goes backwards.  Fixing userspace reads to be fully
monotonic would be nice too, but it's a separate issue from the kernel
throwing a timer into the distant future because the timebase went
backwards one tick.

> There's no such thing as "a small drift". We assume no
> difference is visible to software, period.

On what do we base this assumption, and what does making the assumption
buy us?

Will smp-tbsync.c always converge on perfect sync (it has a limit on how
long it will try, and the only indication it failed is a pr_debug)?  Will
the timebase always increment on all cores at the same time, including on
emulated hardware?

We had a bug in U-Boot's timebase sync where the boot core would sometimes
be one tick faster than the other cores.  It's been fixed, but there are
probably people still running the old U-Boot.  It seems like the kind of
thing where defensive robustness is called for, like timing out instead of
hanging if a hardware register never flips the bit we're waiting for.

> We make hard assumptions here and in various places actually.

Are there any in the kernel that this doesn't cover?
 
> So if you want to do that test, I would require that you also add a
> warning, of the _rate_limited or _once, kind, indicating to the user
> that something's badly wrong.

OK.

-Scott
