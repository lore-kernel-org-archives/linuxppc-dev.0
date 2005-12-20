Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Kumar Gala <galak@gate.crashing.org>
Date: Tue, 20 Dec 2005 19:58:36 +0100
References: <Pine.LNX.4.44.0512201106280.22417-100000@gate.crashing.org>
In-Reply-To: <Pine.LNX.4.44.0512201106280.22417-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200512201958.37850.arnd@arndb.de>
Cc: linuxppc64-dev <linuxppc64-dev@ozlabs.org>, linuxppc-dev@ozlabs.org
Subject: Re: RFC: Rev 0.5 Booting the Linux/ppc kernel without Open Firmware
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Dinsdag 20 Dezember 2005 18:26, Kumar Gala wrote:
> 
> > AFAICS, that requires at least two things:
> > - The device needs to be created when the bus is probed, i.e.
> >   of_device_register can not be called from inside the driver
> >   module_init() function.
> > 
> 
> This is already handled by the platform device in the kernel.

Ok, i was a bit misinformed about how platform devices currently work,
for some reason I thought that there was only a single entry point
for register_device and register_driver, which is untrue.
Sorry for the confusion here.

> I still dont see what a new bus type get us.  I'm going to have to have 
> specific code to parse and build and register my devices.  If that could 
> ends up registering a platform device or a newflatOF device I dont see any 
> real difference.

After looking into it a bit more, I found that we already have
two different types of platform devices here: the standard struct
platform_device and the of_platform_device that is currently used
only on powermac and (maybe surprisingly) is not based on a
platform_device at all but on of_device.

Using the basic platform_device has the big advantage that you
can't access the device_node information (unless we implement the
device::firmware_data infrastructure for powerpc, which looks 
increasingly appealing).

> > The alternative would be to represent all of the device tree
> > in /sys/devices, but IMHO that should better be part of
> > /sys/firmware with symlinks to the linux internal device tree
> > representation.
> 
> Today I have:
>   /sys/devices/platform/
>                         fsl-gianfar.1
>                         fsl-i2c.1
>                         fsl-i2c.2
>                         fsl-sec2.1
>                         fsl-usb2-dr.1
>                         fsl-usb2-mph.1
>                         serial8250
>                         serial8250.0

The problem I see with these is that currently they are all created
by platform specific code or driver specific code that knows exactly
that these devices exist on the hardware.

When moving to the device tree, you need some criteria to decide
which devices to add and which not. One way to do this would be
to only add devices that are a direct child of an SOC bus. If you
would simply add every single device_node as a platform_device,
you end up with a huge number of entries in /sys/devices/platform/
that are either unused completely or already represented elsewhere
like /sys/devices/pci*/*.

One idea I just had (forgive me if that is bullshit, it's getting late
here) is to really do the /sys/firmware stuff by embedding a kobject
in every device_node. The existing bus types that already know about
device_node (pci, vio, macio, of_platform, ...) get converted to
use that (e.g. pci stores the device_node in pci_dev:dev:firmware_data
instead of pci_dev:sysdata) and create the appropriate symlink in sysfs.
When an of_platform_driver registers, we can still give it all devices
because we can create the of_platform_device on the fly by doing the
match on the device_node first.

	Arnd <><
