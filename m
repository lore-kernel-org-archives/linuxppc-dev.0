Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9A409DDDEE
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Jan 2008 00:39:30 +1100 (EST)
Date: Fri, 4 Jan 2008 13:39:22 +0000
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Timur Tabi <timur@freescale.com>,
	Grant Likely <grant.likely@secretlab.ca>, linuxppc-dev@ozlabs.org,
	alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] [PATCH] ASoC drivers for the Freescale MPC8610 SoC
Message-ID: <20080104133921.GA17174@sirena.org.uk>
References: <11981089894052-git-send-email-timur@freescale.com>
	<9e4733910801012027p4be16b92r43af773f4e5ae531@mail.gmail.com>
	<477BADF5.9060003@freescale.com>
	<fa686aa40801020828u5103d09cn2aa5eab7dda2fcff@mail.gmail.com>
	<20080102184957.GB2007@sirena.org.uk>
	<477D2673.5090203@freescale.com>
	<20080103234725.GD12883@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080103234725.GD12883@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jan 04, 2008 at 10:47:25AM +1100, David Gibson wrote:
> On Thu, Jan 03, 2008 at 12:16:19PM -0600, Timur Tabi wrote:

> > I'm no expert on this, but I think from the PowerPC point-of-view,
> > the *ideal* situation would be if the ASoC fabric driver were
> > generic, maybe even part of ASoC itself, and everything it needed
> > could be obtained from the device tree.

> Nice idea in principle, and may be the way to go ultimately, but very
> tricky in practice.  The whole reason the fabric driver concept exists
> (from other archs) is that there are an awful lot of variants on how
> to wire the sound components together.  Devising a way of expressing
> those connections in the device tree that's sufficient will be very
> curly.  Then we'd have to build the fabric driver that can parse and
> process them all.

Yes, there's an issue with complexity here.  Some of the individual
components are going to have quite a lot of different things to
configure by themselves even for static use and the choices made may
depend on the usage at run time rather than being a static property of
the hardware.  It's also more than just connections - many machine
drivers will provide control for components like analogue switches or
simple amplifiers controlled through GPIO lines or memory mapped
registers (these are generally specific to the board).

As a result I would expect that you will always have systems using
platform based drivers.  I don't think that this is a bad thing -
something that can completely replace them would be able to do anything
that can be done in C in the kernel.

>                    And then, people will no doubt produce device trees
> with errors in the connection information, so we'll still need
> platform-specific workarounds.

The other concern with this is that it risks turning the interface to
the codec and controller drivers into an ABI which isn't expected at the
minute and might cause problems in the future.  At the minute the
drivers export constants to their users defining the parameters they
can configure and (for things like source selection) the possible
values.  These can currently be changed at will and there's no great
consistency in their values between drivers.

There would also be difficulties in writing the device tree - without
the symbolic names you're going to end up with strings of numeric
constants in the device tree which are not going to be terribly readable
and will be error prone.

> If we want sound working any time soon, we'll want to stick with the
> platform based fabric drivers for the time being.

Like I say, I would expect that you're always going to want to have
platform based drivers.  Even if a given board can be represented in a
device tree some users will find it more straightforward or convenient
to write C code for their platform and have the device tree specify more
basic configuration options that correspond to the things they want to
vary between boards.
