Return-Path: <dale@farnsworth.org>
Received: from farnsworth.org (xyzzy.farnsworth.org [65.39.95.219])
	by ozlabs.org (Postfix) with SMTP id 12E49DDFDB
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Apr 2007 09:50:43 +1000 (EST)
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Fri, 27 Apr 2007 16:50:41 -0700
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 9/13] powerpc: Add arch/powerpc mv64x60 I2C platform data
	setup
Message-ID: <20070427235040.GA29498@xyzzy.farnsworth.org>
References: <20070425234630.GA4046@mag.az.mvista.com>
	<200704261100.25650.arnd@arndb.de>
	<20070426141902.GB29241@xyzzy.farnsworth.org>
	<200704261704.06790.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200704261704.06790.arnd@arndb.de>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 26, 2007 at 05:04:06PM +0200, Arnd Bergmann wrote:
> Maybe you still haven't understood the difference of an of_platform_driver
> compared to the platform_driver glue which you are adding here.
> 
> I don't want you to move the glue code into the device driver -- I really
> think the glue code should not be there in the first place.
> 
> As you probably understand, the Linux driver model represents every piece
> of hardware as a 'struct device' which can be embedded in things like
> of_device, pci_device or platform_device. Then there are 'struct
> device_driver's than handle all devices of a given bus_type/device_id
> combination.
> 
> With the of device tree, you automatically get an of_device for everything
> that is connected to an internal (soc, plb, ssb, ...) bus on the chip
> or on the board. According to the driver model, they should be driven
> by an of_platform_driver.

Well, since our platform hasn't called of_platform_bus_probe() with
a device id for the mv64x60 device node, we don't create an of_device
for each of its sub-devices.  Instead, we scan separately and create
platform_devices that the existing drivers require, and for the
benefit of those who join this discussion late, which we must
maintain for use by MIPS platforms.

> What your glue code does is to find a backdoor into the device tree
> (through of_find_compatible_node) and create a second struct device
> for the same hardware, in an unrelated location in the linux device tree.
> This is very confusing if you look at sysfs, e.g. trying to find out
> which driver is attached to a given of_device.

No, we don't create the first struct device you mentioned, so we avoid
the duplication and the confusion.

> It also makes you lose the ability to autoload the driver module,
> because autoloading is not supported for a platform_driver (there
> is no MODULE_DEVICE_TABLE()).
> 
> As you made clear, we will need the platform_driver for the forseeable
> future, but I really think that we also need an of_platform_driver
> to drive them on powerpc instead of adding another pile of junk like
> fsl_soc.c.

Heh, I was going to ask if you made these points when fsl_soc.c went in.  :)

> I can see multiple ways for you to get there:

I find each of these methods lacking.

> 1. have a driver that binds to all of_devices supported by mv64x60
> and then creates the platform_device for them the way you do in your
> glue, but without adding code that manually iterates through
> the device tree. Make the platform_device a child of the of_device.
> This approach is the closest to what you have right now and would
> at least get the sysfs representation right, but not allow module
> autoloading and it still duplicates all the devices.

Like you, I dislike the resulting dev duplication.  Also, having
the platform_device be a child of a superfluous of_device seems weird.

> 2. remove the dependencies on platform_device data structures from
> the current driver code, and add them to a separate file, so you
> can link the module either with the platform_driver or with the
> of_platform_driver, as I suggested in a previous mail.
> I think this would be the best solution.

This is a very OF-centric proposal.  IMHO it's a mistake for drivers
to call of_get_property().  There should be a firmware-independent
way of passing parameters to drivers.  I'm not a big fan of the
details of platform_device, but at least it's firmware independent.
I think it's a layering violation even when ppc-only drivers
query for parameters via of_get_property().

> 3. Have a small of_device_driver part that gets added to each
> of the device drivers, and that adds the platform_device internally.
> This would be like 1., but also allow autoloading.

Again, I'd like to keep arch-specific code out of drivers, as much
as possible.

Since you now recognize our need for platform_devices, I'd like to
understand your primary objection to our not creating of_devices.
Is it because it violates the assumption that of_devices be created
for all devices on the platform?  Is that a hard requirement?

BTW Arnd, thank you for taking the time to comment on this code.

-Dale
