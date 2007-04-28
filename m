Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id CFCF8DDFFE
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Apr 2007 11:05:36 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 9/13] powerpc: Add arch/powerpc mv64x60 I2C platform data
	setup
Date: Sat, 28 Apr 2007 03:05:25 +0200
References: <20070425234630.GA4046@mag.az.mvista.com>
	<200704261704.06790.arnd@arndb.de>
	<20070427235040.GA29498@xyzzy.farnsworth.org>
In-Reply-To: <20070427235040.GA29498@xyzzy.farnsworth.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200704280305.26312.arnd@arndb.de>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Saturday 28 April 2007, Dale Farnsworth wrote:
> On Thu, Apr 26, 2007 at 05:04:06PM +0200, Arnd Bergmann wrote:
> > With the of device tree, you automatically get an of_device for everything
> > that is connected to an internal (soc, plb, ssb, ...) bus on the chip
> > or on the board. According to the driver model, they should be driven
> > by an of_platform_driver.
> 
> Well, since our platform hasn't called of_platform_bus_probe() with
> a device id for the mv64x60 device node, we don't create an of_device
> for each of its sub-devices.  Instead, we scan separately and create
> platform_devices that the existing drivers require, and for the
> benefit of those who join this discussion late, which we must
> maintain for use by MIPS platforms.

We've had discussions about of_platform_bus_probe() on the mailing
lists and on IRC before. My idea of the long-term goal is that we
should not call it from the platform specific code, but instead
globally and add all the devices we find, with exceptions for
stuff that works differently, like PCI.

I think it would be bad to have to add another exception for
mv64x60 just because the drivers work different from the others.

> > 2. remove the dependencies on platform_device data structures from
> > the current driver code, and add them to a separate file, so you
> > can link the module either with the platform_driver or with the
> > of_platform_driver, as I suggested in a previous mail.
> > I think this would be the best solution.
> 
> This is a very OF-centric proposal.  IMHO it's a mistake for drivers
> to call of_get_property().  There should be a firmware-independent
> way of passing parameters to drivers.  I'm not a big fan of the
> details of platform_device, but at least it's firmware independent.
> I think it's a layering violation even when ppc-only drivers
> query for parameters via of_get_property().

Calling of_* functions is the natural thing to do for an 
of_platform_driver, just like a PCI driver calls pci_* functions.

Note that what I'm suggestiong here is that you have one file
that encapsulates all the calls to OF functions (of_iomap,
irq_of_parse_and_map, ...) and passes the raw information down
to the main low-level driver.

I think the main difference between your view and mine is that
you see the OF model as an _architecture_ property, while in my
view it is a _bus_type_ that devices are attached to.

It's like the OHCI driver, which has low-level driver for the
a common register interface, but comes with a number of bus
interfaces that it can attach to (PCI, PS3, OF, ...).
[ don't look at the OHCI implementation, the way they did
  the code is not a good example, but it can be done properly. ]

> Since you now recognize our need for platform_devices, I'd like to
> understand your primary objection to our not creating of_devices.
> Is it because it violates the assumption that of_devices be created
> for all devices on the platform?

That, and the missing ability to do module autoloading.

> Is that a hard requirement? 

Not yet, but I'd like to get there, as I mention above.

	Arnd <><
