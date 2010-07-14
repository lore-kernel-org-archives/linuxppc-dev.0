Return-Path: <nico@fluxnic.net>
Received: from relais.videotron.ca (relais.videotron.ca [24.201.245.36])
	by ozlabs.org (Postfix) with ESMTP id 4FD62B6EF1
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 14 Jul 2010 10:07:02 +1000 (EST)
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR003.ip.videotron.ca
	(Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008;
	32bit))
	with ESMTP id <0L5I00LW8TNOKU10@VL-MO-MR003.ip.videotron.ca> for
	linuxppc-dev@lists.ozlabs.org; Tue, 13 Jul 2010 20:07:00 -0400 (EDT)
Date: Tue, 13 Jul 2010 20:07:00 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Daniel Walker <dwalker@codeaurora.org>
Subject: Re: [RFC PATCH] Kconfig: Enable Kconfig fragments to be used for
	defconfig
In-reply-to: <1279064008.4609.48.camel@c-dwalke-linux.qualcomm.com>
Message-id: <alpine.LFD.2.00.1007131941140.10598@xanadu.home>
References: <20100713230352.6781.18644.stgit@angua>
	<1279062881.4609.34.camel@c-dwalke-linux.qualcomm.com>
	<AANLkTin69tN3NQHD2wvkA0G-lj3f9tSZEnhzdyJdTh9m@mail.gmail.com>
	<1279064008.4609.48.camel@c-dwalke-linux.qualcomm.com>
Cc: linux-kbuild@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
	linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Russell King <rmk@arm.linux.org.uk>,
	=?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 13 Jul 2010, Daniel Walker wrote:
> On Tue, 2010-07-13 at 17:21 -0600, Grant Likely wrote:
> > On Tue, Jul 13, 2010 at 5:14 PM, Daniel Walker <dwalker@codeaurora.org> wrote:
> > > It just doesn't feel like Kconfig was meant to do this, it feel like
> > > somewhat of an abuse ..
> > 
> > Why?  It uses the Kconfig language itself to specify additional
> > constraints on the final configuration.  Seems to be the essence of
> > elegance to me.  :-)
> 
> To my mind the only problem with the current defconfig formatting is the
> size of the files. If those files are 5-10 lines instead of 2000 lines,
> then I think the readability problem isn't really an issue any more..

That's one issue indeed.

But there is another issue that is somewhat related, which is to be able 
to categorize config options.

Currently the defconfig files carry information about the proper driver 
to enable in order to support devices soldered on the board and 
therefore which are not "optional".  That might be a particular RTC 
chip, or a particular ethernet block integrated into a SOC, etc.  Of 
course we want to preserve the ability to disable support for those 
things, but by default people want to have all the right drivers 
selected for all the built-in hardware when selecting a target 
machine/board without having to dig into a datasheet for that target.

The defconfig files also carry config options that are totally 
arbitrary.  What type of filesystem, what kind of network protocol, what 
USB device drivers (not host controller driver), what amount of 
debugging options, all those are unrelated to the actual hardware and 
may vary from one user to another.

Furthermore, in order to reduce the number of defconfig files, we tried 
to combine as many targets into a single kernel image.  That increases 
build test coverage with fewer builds which is good, but then the info 
about specific drivers required for a specific target but not for 
another target in the same defconfig is now lost.  It is therefore quite 
hard to produce a highly optimized configuration for a single target 
without doing some digging again.

So it is really in the Kconfig file that all those hardware specific 
options can be expressed in a clear and readable way.  When BOARD_XYZ is 
selected and STD_CONFIG is selected, then automatically select RTC_FOO, 
select ETH_BAR, select LED_BAZ, etc. Of course we would want required 
dependencies to be automatically selected as well.

But all the rest is arbitrary and could be part of common shared 
profiles or the like in defconfig format.


Nicolas
