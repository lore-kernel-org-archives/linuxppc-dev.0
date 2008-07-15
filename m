Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by ozlabs.org (Postfix) with ESMTP id E0525DE7DD
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jul 2008 00:04:42 +1000 (EST)
Date: Tue, 15 Jul 2008 15:04:30 +0100
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [alsa-devel] [PATCH v2 1/3] ALSA SoC: Add OpenFirmware helper for
	matching bus and codec drivers
Message-ID: <20080715140427.GP25448@sirena.org.uk>
References: <9e4733910807140713r5739efedw81e65632006d101d@mail.gmail.com>
	<20080714150527.GD25448@sirena.org.uk>
	<487B7B71.9060606@freescale.com>
	<20080714165302.GG25448@sirena.org.uk>
	<fa686aa40807141021ka4f84e9ycc4ac78db760726c@mail.gmail.com>
	<20080714183632.GI25448@sirena.org.uk>
	<487B9D98.8010008@freescale.com>
	<9e4733910807141645l404881b0m1d17d88c26792c78@mail.gmail.com>
	<20080715101307.GL25448@sirena.org.uk>
	<9e4733910807150608o41f932c7r7a2321c56b410913@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9e4733910807150608o41f932c7r7a2321c56b410913@mail.gmail.com>
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

On Tue, Jul 15, 2008 at 09:08:28AM -0400, Jon Smirl wrote:
> On 7/15/08, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> > Binding isn't the issue here - it's loading the driver in the first
> >  place.  Once the drivers are loaded they can (hopefully) figure out if
> >  they are running on appropriate hardware.

> In this case we would end up with two core PowerPC machine drivers
> bound, not ALSA ones. We have machine drivers in the PowerPC core,
> that's one reason why it is confusing to call the ALSA drivers machine
> drivers too.

Again, I'm not talking about binding anything.

> > This is what I'm suggesting, modulo the fact that I'm suggesting *not*
> >  creating virtual devices but rather providing a mechanism for drivers to
> >  load without binding to anything.  It strikes me that you're going to

> If you have drivers for four different hardware releases compiled into
> your kernel, the only kernel mechanism I know of  to trigger only one
> of these to initialize is to create a device and then let the probe
> mechanism sort it out. This is even more true when the drivers are on
> initrd and need to be dynamically loaded. The module load code will
> search through the alias lists in the module .ko files.

This can be handled in the module initialisation (rather than driver
probe) - providing something can arrange for the driver to get loaded
then the drivers can check the system they're running on when that
happens and fail if it's inappropriate.  The ARM ASoC drivers and x86
DMI based stuff do things this way, for example (ARM doesn't have the
automatic module load stuff implemented, though).

The infrastructure for automatically loading modules is usable
separately from device registration, though normally the two do go hand
in hand.

> It has been pointed out that a lite5200b-fabric device isn't really a
> virtual devices. It's a device that represents the traces on the PCB
> wiring the generic chip drivers together.

This was brought up very early on when you guys first started working on
it. :/
