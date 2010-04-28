Return-Path: <broonie@opensource.wolfsonmicro.com>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 15E7DB7D2B
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Apr 2010 22:07:15 +1000 (EST)
Date: Wed, 28 Apr 2010 13:07:19 +0100
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [alsa-devel] [PATCH 1/2] powerpc: add platform registration
	for ALSA SoC drivers
Message-ID: <20100428120719.GE31400@opensource.wolfsonmicro.com>
References: <1272314980-23679-1-git-send-email-timur@freescale.com>
	<1272350168.24542.6.camel@pasglop> <1272355624.3204.52.camel@odin>
	<g2mfa686aa41004271324g8ff0d67fi3df4336cb25e9acc@mail.gmail.com>
	<20100427222913.GE15083@opensource.wolfsonmicro.com>
	<1272427811.24542.59.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1272427811.24542.59.camel@pasglop>
Cc: alsa-devel@alsa-project.org, kumar.gala@freescale.com,
	linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>,
	Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 28, 2010 at 02:10:11PM +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2010-04-27 at 23:29 +0100, Mark Brown wrote:

> > On the other hand from a pragmatic point of view it's just much less
> > hassle to just only provide the mechanism for instantiating a machine
> > with custom code and use that for everything.

> Right, that's the balance to find. A too descriptive device-tree becomes
> a mess, and attempting to deal with any kind of representation in SW is
> horrible.

Sadly this often seems to be what the device tree folks are pushing
for.  I really want whatever you guys come up with to explicitly say
that it's OK to just write standard code like we have at the minute and
not faff around defining device tree representations for everything so
that we can just point people at that when the discussion gets too
bogged down.

> For example, one could imagine a /sound node with simply a "compatible"
> property that matches what we call in AOA terminology a "fabric" driver.
> IE. The one thing specific to the board that puts bits and pieces
> together.

This is the current ASoC design (someone probably ought to look at
merging AOA into ASoC, it's approximately the same hardware and at least
the CPU driver ought to be useful for other systems).

> Now, the device-tree is still obviously useful to provide things like
> the actual i2c IDs of codecs, GPIOs used for various actions, link to
> from various components to their clock source devices, etc.. All these
> things simplify the code, avoids horrid board specific code in the
> actual drivers (codecs, busses, etc...) and overall help keeping the
> code more maintainable. 

You're preaching to the choir here.  With ASoC all this system specific
code ends up in the machine driver (which you guys are calling the
fabric driver).  All the design stuff you're talking about here is
already dealt with as-is, it's just that the parameterisation is done
with C code and data structures in the kernel (which can deal with
multiple boards if it chooses to) rather than with device tree stuff.
The chip specific drivers do not have any board specific code so there
is no meaningful change that's being proposed to them.

The problems with the device tree have been that people have been
hostile to the idea of there being any board specific code at all in the
kernel (or a board specific device tree node for the audio), and that
people keep wanting to define some OF stuff that is supposed to cover a
wide range of boards but makes unrealistic simplifying assumptions about
what general hardware looks like.

> The device-tree helps keep the platform .c file simple and devoid of too
> horrible hacks, it allows to easily pass various configuration data to
> leaf drivers such as i2c thingies, PHY devices etc... without gross
> hooks between these and the platform, but the platform code still has
> the upper hand for doing ad-hoc bits and pieces (or overwriting the
> device-tree based behaviour) if necessary.

Once again, if you can get the device tree guys to buy into this and
stick with it that sounds good but my experience has been that this
isn't where any of these discussions end up.
