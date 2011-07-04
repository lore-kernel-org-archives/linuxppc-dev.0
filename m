Return-Path: <fweisbec@gmail.com>
Received: from mail-vx0-f179.google.com (mail-vx0-f179.google.com
	[209.85.220.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B12141007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  4 Jul 2011 23:38:01 +1000 (EST)
Received: by vxb40 with SMTP id 40so4018946vxb.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 04 Jul 2011 06:37:58 -0700 (PDT)
Date: Mon, 4 Jul 2011 15:37:54 +0200
From: Frederic Weisbecker <fweisbec@gmail.com>
To: "K.Prasad" <prasad@linux.vnet.ibm.com>
Subject: Re: [PATCH 4/6] hw_breakpoints: Breakpoints arch ability don't need
	perf events
Message-ID: <20110704133752.GC5551@somewhere>
References: <1306273947-8410-1-git-send-email-fweisbec@gmail.com>
	<1306273947-8410-5-git-send-email-fweisbec@gmail.com>
	<20110704133223.GB2963@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110704133223.GB2963@in.ibm.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Will Deacon <will.deacon@arm.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Paul Mundt <lethal@linux-sh.org>, Ingo Molnar <mingo@elte.hu>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 04, 2011 at 07:02:23PM +0530, K.Prasad wrote:
> On Tue, May 24, 2011 at 11:52:25PM +0200, Frederic Weisbecker wrote:
> > The breakpoint support ability in an arch is not related
> > to the fact perf events is built or not. HAVE_HW_BREAKPOINT
> > only shows an ability so this dependency makes no sense
> > anymore. Archs that select HAVE_HW_BREAKPOINT already
> > ensure that perf event is built.
> > 
> > Remove that dependency.
> > 
> > Signed-off-by: Frederic Weisbecker <fweisbec@gmail.com>
> > Cc: Ingo Molnar <mingo@elte.hu>
> > Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: Prasad <prasad@linux.vnet.ibm.com>
> > Cc: Paul Mundt <lethal@linux-sh.org>
> > ---
> >  arch/Kconfig |    1 -
> >  1 files changed, 0 insertions(+), 1 deletions(-)
> > 
> > diff --git a/arch/Kconfig b/arch/Kconfig
> > index f78c2be..ce4be89 100644
> > --- a/arch/Kconfig
> > +++ b/arch/Kconfig
> > @@ -149,7 +149,6 @@ config HAVE_DEFAULT_NO_SPIN_MUTEXES
> > 
> >  config HAVE_HW_BREAKPOINT
> >  	bool
> > -	depends on PERF_EVENTS
> > 
> >  config HAVE_MIXED_BREAKPOINTS_REGS
> >  	bool
> > -- 
> 
> Just a thought you might want to consider...
> 
> The need to keep the ability (HAVE_HW_BREAKPOINT) and the user-choice to
> enable hardware breakpoints (through HW_BREAKPOINT) in separate config
> options isn't very clear to me (and is a bit confusing with very similar
> names).
> 
> Why not make HAVE_HW_BREAKPOINT selectable by the user (which in turn
> would turn on PERF_EVENTS) for a given architecture?

But then how kconfig knows if the allows that? You need to know if the
arch has the ability to support breakpoints.

This is a commin pattern in Linux Kconfig. Things are often seperated between
ability (some constant value provided by the arch) and the user choice that
depends on that ability.
The advantage of doing this is that you can centralize the generic dependencies,
help menu, etc... into a single place.
 
> Thanks,
> K.Prasad
> 
