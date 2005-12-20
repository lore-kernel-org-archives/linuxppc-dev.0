Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Kumar Gala <galak@gate.crashing.org>
Date: Tue, 20 Dec 2005 11:18:03 +0100
References: <Pine.LNX.4.44.0512191446570.4542-100000@gate.crashing.org>
In-Reply-To: <Pine.LNX.4.44.0512191446570.4542-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200512201118.05404.arnd@arndb.de>
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

On Maandag 19 Dezember 2005 21:49, Kumar Gala wrote:
> I'm still in favor of just leaving these devices as straight platform 
> devices.  Unless there is something that is bus specific that each device 
> on the bus conforms to I dont see any reason to create a new bus type.

How do platform devices work with module autoloading? What I'm interested
in is to have stuff like the Fedora installer or kernels with modular
drivers 'just work' because they can use the same way to load their
modules that is already used for PCI devices.

AFAICS, that requires at least two things:
- The device needs to be created when the bus is probed, i.e.
  of_device_register can not be called from inside the driver
  module_init() function.

- The bus type needs to create a modalias file so user space can
  do the matching with the of device table in the modules.

Both of these should be a lot easier to implement with a special
bus type that creates entries in sysfs for a subset of the OF
device tree.

The alternative would be to represent all of the device tree
in /sys/devices, but IMHO that should better be part of
/sys/firmware with symlinks to the linux internal device tree
representation.

	Arnd <><
