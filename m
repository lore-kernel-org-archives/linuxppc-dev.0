Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by ozlabs.org (Postfix) with ESMTP id A615CDDF6C
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jul 2008 20:13:19 +1000 (EST)
Date: Tue, 15 Jul 2008 11:13:08 +0100
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [alsa-devel] [PATCH v2 1/3] ALSA SoC: Add OpenFirmware helper for
	matching bus and codec drivers
Message-ID: <20080715101307.GL25448@sirena.org.uk>
References: <20080712083929.15025.47682.stgit@trillian.secretlab.ca>
	<20080714134930.GC25448@sirena.org.uk>
	<9e4733910807140713r5739efedw81e65632006d101d@mail.gmail.com>
	<20080714150527.GD25448@sirena.org.uk>
	<487B7B71.9060606@freescale.com>
	<20080714165302.GG25448@sirena.org.uk>
	<fa686aa40807141021ka4f84e9ycc4ac78db760726c@mail.gmail.com>
	<20080714183632.GI25448@sirena.org.uk>
	<487B9D98.8010008@freescale.com>
	<9e4733910807141645l404881b0m1d17d88c26792c78@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9e4733910807141645l404881b0m1d17d88c26792c78@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org,
	Timur Tabi <timur@freescale.com>, liam.girdwood@wolfsonmicro.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jul 14, 2008 at 07:45:46PM -0400, Jon Smirl wrote:
> On 7/14/08, Timur Tabi <timur@freescale.com> wrote:
> > Mark Brown wrote:

> >  > chassis - on Linux drivers can be automatically loaded based on these
> >  > strings.  See drivers/misc/thinkpad_acpi.c for an example of a driver
> >  > that does this.

> Allowing multiple binds at the root causes the problem of something
> like compatible="lite5200b,mpc5200-simple". Both platforms would bind
> and that's not what you want.

Binding isn't the issue here - it's loading the driver in the first
place.  Once the drivers are loaded they can (hopefully) figure out if
they are running on appropriate hardware.

> Another scheme would be to add kernel code to always create virtual OF
> devices like "lite5200b-fabric" that are derived off from the machine
> name that achieved a bind.

This is what I'm suggesting, modulo the fact that I'm suggesting *not*
creating virtual devices but rather providing a mechanism for drivers to
load without binding to anything.  It strikes me that you're going to
run into similar situations with other hardware at some point - either
for undocumented extras that you happen to know exist on the system
(like much of the DMI usage on x86) or for other things where you've got
on-board hardware structured like sound hardware tends to be.
