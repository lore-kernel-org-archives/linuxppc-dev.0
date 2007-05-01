Return-Path: <dgibson@ozlabs.org>
Date: Tue, 1 May 2007 15:18:04 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: linuxppc-dev@ozlabs.org
Subject: powerpc_flash_init(), wtf!?
Message-ID: <20070501051804.GB3881@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

powerpc_flash_init(), the only function in arch/powerpc/sysdev/rom.c,
goes through the device tree finding anything with device_type=="rom"
and creating of_platform devices for them, which will be picked up by
the physmap_of mtd driver.  This has two serious conceptual errors and
one bad implementation error which is quite an accomplishment for 15
lines of code.

Most seriously, this "find all roms" approach to probing is
fundamentally incompatible with the normal way of probing for
of_platform devices, to wit, using of_platform_bus_probe().  If a
flash is on a bus probed with of_platform_bus_probe()
powerpc_flash_init() will create a duplicate of_platform device for
it.  powerpc_flash_init() could also mistakenly probe roms which
appear on other random busses which should use their own probe logic
instead of going straight off the device tree (admittedly flash is
unlikely to appear on such a bus).

Also, it uses the device node's name without unit address as the
of_platform device's name.  So if a bus somewhere has two flash
devices named, say "flash@0" and "flash@800000", the device code will
give a stack dump during boot as powerpc_flash_init() attempts to
register them both under the name "flash".


I observe that none of the dts files actually present in the kernel
tree use physmap_of's format for describing flash devices (and
therefore don't use this code).  I'm therefore rather tempted to
simply blow arch/powerpc/sysdev/rom.c away, and anyone out-of-tree
relying on this code will have to fix their platform probing code to
create the flash of_platform devices properly.

Unless someone who actually knows how this code was intended to be
used can suggest a more polite way of fixing it.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
