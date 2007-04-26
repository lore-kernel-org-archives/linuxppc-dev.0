Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id A438DDDF58
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Apr 2007 01:04:51 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: "Dale Farnsworth" <dale@farnsworth.org>
Subject: Re: [PATCH 9/13] powerpc: Add arch/powerpc mv64x60 I2C platform data
	setup
Date: Thu, 26 Apr 2007 17:04:06 +0200
References: <20070425234630.GA4046@mag.az.mvista.com>
	<200704261100.25650.arnd@arndb.de>
	<20070426141902.GB29241@xyzzy.farnsworth.org>
In-Reply-To: <20070426141902.GB29241@xyzzy.farnsworth.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200704261704.06790.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 26 April 2007, Dale Farnsworth wrote:
>=20
> > The point about the of device tree is that it allows you to probe this
> > kind of device. This means you get automatic module loading based on the
> > device tree, and that the devices show up in sane locations in /sys.
>=20
> I understand the benefits of the DT; that's not the issue.
>
> Here we have platform devices common to MIPS and PowerPC platforms.
> The drivers must continue to support the platform_driver interface
> for MIPS platforms. =A0The question is, where should we put the glue
> that transforms the DT info into the platform_driver format?
>=20
> You seem to suggest putting the ethernet-related glue into
> drivers/net/mv643xx_eth.c. =A0That's bogus, IMHO. The base driver
> shouldn't have to accommodate every arch-specific interface.
> (I know OF isn't strictly arch-specific, but it's far from universal.)
> I put this glue into arch/powerpc/sysdev/mv64x60.c. I still don't see
> the benefit of moving it into the drivers.

Maybe you still haven't understood the difference of an of_platform_driver
compared to the platform_driver glue which you are adding here.

I don't want you to move the glue code into the device driver -- I really
think the glue code should not be there in the first place.

As you probably understand, the Linux driver model represents every piece
of hardware as a 'struct device' which can be embedded in things like
of_device, pci_device or platform_device. Then there are 'struct
device_driver's than handle all devices of a given bus_type/device_id
combination.

With the of device tree, you automatically get an of_device for everything
that is connected to an internal (soc, plb, ssb, ...) bus on the chip
or on the board. According to the driver model, they should be driven
by an of_platform_driver.

What your glue code does is to find a backdoor into the device tree
(through of_find_compatible_node) and create a second struct device
for the same hardware, in an unrelated location in the linux device tree.
This is very confusing if you look at sysfs, e.g. trying to find out
which driver is attached to a given of_device.
It also makes you lose the ability to autoload the driver module,
because autoloading is not supported for a platform_driver (there
is no MODULE_DEVICE_TABLE()).

As you made clear, we will need the platform_driver for the forseeable
future, but I really think that we also need an of_platform_driver
to drive them on powerpc instead of adding another pile of junk like
fsl_soc.c.

I can see multiple ways for you to get there:

1. have a driver that binds to all of_devices supported by mv64x60
and then creates the platform_device for them the way you do in your
glue, but without adding code that manually iterates through
the device tree. Make the platform_device a child of the of_device.
This approach is the closest to what you have right now and would
at least get the sysfs representation right, but not allow module
autoloading and it still duplicates all the devices.

2. remove the dependencies on platform_device data structures from
the current driver code, and add them to a separate file, so you
can link the module either with the platform_driver or with the
of_platform_driver, as I suggested in a previous mail.
I think this would be the best solution.

3. Have a small of_device_driver part that gets added to each
of the device drivers, and that adds the platform_device internally.
This would be like 1., but also allow autoloading.

	Arnd <><
