Return-Path: <khali@linux-fr.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 47DB8DDE0A
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jul 2008 16:53:03 +1000 (EST)
Date: Fri, 11 Jul 2008 08:52:46 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Milton Miller <miltonm@bga.com>
Subject: Re: [RFC] (almost) booting allyesconfig -- please  don't poke
	super-io without request_region
Message-ID: <20080711085246.1ead773b@hyperion.delvare>
In-Reply-To: <acca8e14e769b2feadee19f1f7448438@bga.com>
References: <for-27-patch1-0@bga.com> <48768018.2070704@hhs.nl>
	<acca8e14e769b2feadee19f1f7448438@bga.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Ortiz <samuel@sortiz.org>, Samuel, linux-kernel@vger.kernel.org,
	lm-sensors@lm-sensors.org, linuxppc-dev@ozlabs.org,
	Hans de Goede <j.w.r.degoede@hhs.nl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Hans, hi Milton,

On Thu, 10 Jul 2008 16:51:33 -0500, Milton Miller wrote:
> 
> On Jul 10, 2008, at 4:33 PM, Hans de Goede wrote:
> 
> > Milton Miller wrote:
> >> After the following patch to mark the isa region busy and applying a 
> >> few
> >> patches[1], I was able to kexec boot into an all-yes-config kernel 
> >> from linux-next, with the following KCONFIG_ALLCONFIG file:
> ...
> >> While the first two might not be required, and the third is just
> >> selecting the right platform, it would be nice to get the drivers
> >> to play as well as the rest of the kernel.
> >> The drivers all are for super-io chips, either irda/FIR drivers or 
> >> hwmon,
> >> and poke at isa ports without checking request_region.
> >
> > Erm,
> >
> > The superio sensor drivers only poke the superio chip registers 
> > without request region during the probe phase, iow they try to detect 
> > the chip, using a widely document and standardized (part of isa pnp 
> > AFAIK) procedure on standardized ports.
> >
> > Let me try to explain a bit about superio chips, they have 2 superio 
> > control registers (an index and data register) with which things like 
> > a manufacturer and device id can be read, besides these id registers 
> > they also have a set of registers with config for different logical 
> > devices. Once the id is matched, the driver knows which logical device 
> > config to read, reads a (different) isa base address + range from the 
> > logical device config, and then does a request_region on the region 
> > actually used by the logical device.
> >
> > The superio control registers are thus a sort of pci configuration 
> > space if you want, doing a request_region on these is not such a good 
> > idea, as multiple drivers (for different logical devices within the 
> > superio device) may use these, so trying to gain exclusive access will 
> > lead to troubles.
> >
> > I hope with this info about the problem space, that you maybe have a 
> > suggestion on howto fix this?
> 
> My point is that they are probing without even knowing that a such a IO 
> range exists.
> 
> These are the only drivers left in the tree that still do this.  (At 
> least that are not
> blocked on a powerpc allyesconfig for 64-bit, !CONFIG_VIRT_TO_BUS).

I guess we could make all these drivers depend on X86, I suspect that
these chips are only used in PCs?

> One could make a superio driver, and create sub-devices for the IR, 
> I2C, floppy, parallel, etc
> nodes.

There have been proposals to do this, and this would indeed be a very
good idea, but unfortunately nobody took the time to implement this
properly, push it upstream and volunteer to maintain it. The problem is
that you don't need just a "driver", but a new subsystem, that needs to
be designed and maintained.

> I would even accept a check_region (horrors!), it would impove the 
> situation.
> 
> But most other drivers do this by request_region, probe, then release 
> the region afterwards.

I agree that the hwmon drivers should do this, as long as no superio
subsystem exist. This should solve the problem at hand and might even
help spot bad drivers which use the configuration space for longer than
initialization time.

> Besides, one could argue the superio region should be requested while 
> probing, to prevent other cpus from poking at the super io chip at the 
> same time.   Think of it as missing locking.

Agreed.

Milton, care to submit a patch fixing the affected hwmon drivers?

Thanks,
-- 
Jean Delvare
