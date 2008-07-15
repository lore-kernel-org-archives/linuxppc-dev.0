Return-Path: <jonsmirl@gmail.com>
Received: from el-out-1112.google.com (el-out-1112.google.com [209.85.162.180])
	by ozlabs.org (Postfix) with ESMTP id D97B2DE37B
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jul 2008 23:08:29 +1000 (EST)
Received: by el-out-1112.google.com with SMTP id o28so895993ele.3
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jul 2008 06:08:28 -0700 (PDT)
Message-ID: <9e4733910807150608o41f932c7r7a2321c56b410913@mail.gmail.com>
Date: Tue, 15 Jul 2008 09:08:28 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Timur Tabi" <timur@freescale.com>,
	"Grant Likely" <grant.likely@secretlab.ca>, linuxppc-dev@ozlabs.org,
	alsa-devel@alsa-project.org, liam.girdwood@wolfsonmicro.com
Subject: Re: [alsa-devel] [PATCH v2 1/3] ALSA SoC: Add OpenFirmware helper for
	matching bus and codec drivers
In-Reply-To: <20080715101307.GL25448@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080712083929.15025.47682.stgit@trillian.secretlab.ca>
	<9e4733910807140713r5739efedw81e65632006d101d@mail.gmail.com>
	<20080714150527.GD25448@sirena.org.uk>
	<487B7B71.9060606@freescale.com>
	<20080714165302.GG25448@sirena.org.uk>
	<fa686aa40807141021ka4f84e9ycc4ac78db760726c@mail.gmail.com>
	<20080714183632.GI25448@sirena.org.uk>
	<487B9D98.8010008@freescale.com>
	<9e4733910807141645l404881b0m1d17d88c26792c78@mail.gmail.com>
	<20080715101307.GL25448@sirena.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 7/15/08, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> On Mon, Jul 14, 2008 at 07:45:46PM -0400, Jon Smirl wrote:
>  > On 7/14/08, Timur Tabi <timur@freescale.com> wrote:
>  > > Mark Brown wrote:
>
>
> > >  > chassis - on Linux drivers can be automatically loaded based on these
>  > >  > strings.  See drivers/misc/thinkpad_acpi.c for an example of a driver
>  > >  > that does this.
>
>
> > Allowing multiple binds at the root causes the problem of something
>  > like compatible="lite5200b,mpc5200-simple". Both platforms would bind
>  > and that's not what you want.
>
> Binding isn't the issue here - it's loading the driver in the first
>  place.  Once the drivers are loaded they can (hopefully) figure out if
>  they are running on appropriate hardware.

In this case we would end up with two core PowerPC machine drivers
bound, not ALSA ones. We have machine drivers in the PowerPC core,
that's one reason why it is confusing to call the ALSA drivers machine
drivers too.

If we allow multiple bindings both lite5200b and mpc5200-simple would
bind. The compatible list is a priority list from most specific to
most general. First you check for the specific driver lite5200b, if
it's not found then load the generic one mpc5200-simple.

>  > Another scheme would be to add kernel code to always create virtual OF
>  > devices like "lite5200b-fabric" that are derived off from the machine
>  > name that achieved a bind.
>
>
> This is what I'm suggesting, modulo the fact that I'm suggesting *not*
>  creating virtual devices but rather providing a mechanism for drivers to
>  load without binding to anything.  It strikes me that you're going to

If you have drivers for four different hardware releases compiled into
your kernel, the only kernel mechanism I know of  to trigger only one
of these to initialize is to create a device and then let the probe
mechanism sort it out. This is even more true when the drivers are on
initrd and need to be dynamically loaded. The module load code will
search through the alias lists in the module .ko files.

It has been pointed out that a lite5200b-fabric device isn't really a
virtual devices. It's a device that represents the traces on the PCB
wiring the generic chip drivers together.

>  run into similar situations with other hardware at some point - either
>  for undocumented extras that you happen to know exist on the system
>  (like much of the DMI usage on x86) or for other things where you've got
>  on-board hardware structured like sound hardware tends to be.

This makes sense, it is possible that other areas we aren't familiar
with will need fabric drivers too. The problem is easily exposed in
audio hardware since we use external clock and amp chips.

-- 
Jon Smirl
jonsmirl@gmail.com
