Return-Path: <gregkh@suse.de>
Received: from perch.kroah.org (mail.kroah.org [69.55.234.183])
	by ozlabs.org (Postfix) with ESMTP id C7E89689BB
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 10 Jan 2006 17:01:08 +1100 (EST)
To: rmk@arm.linux.org.uk, greg@kroah.com, gregkh@suse.de,
	linuxppc-embedded@ozlabs.org, rmk+kernel@arm.linux.org.uk
From: <gregkh@suse.de>
Date: Mon, 09 Jan 2006 22:00:11 -0800
In-Reply-To: <20060105142951.13.14@flint.arm.linux.org.uk>
Message-ID: <1EwCYF-30q-00@press.kroah.org>
Subject: patch add-vio_bus_type-probe-and-remove-methods.patch added to
	gregkh-2.6 tree
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


This is a note to let you know that I've just added the patch titled

     Subject: [CFT 14/29] Add vio_bus_type probe and remove methods

to my gregkh-2.6 tree.  Its filename is

     add-vio_bus_type-probe-and-remove-methods.patch

This tree can be found at 
    http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/


>From rmk+greg=kroah.com@arm.linux.org.uk Thu Jan  5 06:37:30 2006
From: Russell King <rmk@arm.linux.org.uk>
CC: Greg K-H <greg@kroah.com>, PPC <linuxppc-embedded@ozlabs.org>
Subject: [CFT 14/29] Add vio_bus_type probe and remove methods
Date: Thu, 05 Jan 2006 14:36:47 +0000
Message-ID: <20060105142951.13.14@flint.arm.linux.org.uk>

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 arch/powerpc/kernel/vio.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- gregkh-2.6.orig/arch/powerpc/kernel/vio.c
+++ gregkh-2.6/arch/powerpc/kernel/vio.c
@@ -76,7 +76,7 @@ static void vio_bus_shutdown(struct devi
 	struct vio_dev *viodev = to_vio_dev(dev);
 	struct vio_driver *viodrv = to_vio_driver(dev->driver);
 
-	if (viodrv->shutdown)
+	if (dev->driver && viodrv->shutdown)
 		viodrv->shutdown(viodev);
 }
 
@@ -91,9 +91,6 @@ int vio_register_driver(struct vio_drive
 
 	/* fill in 'struct driver' fields */
 	viodrv->driver.bus = &vio_bus_type;
-	viodrv->driver.probe = vio_bus_probe;
-	viodrv->driver.remove = vio_bus_remove;
-	viodrv->driver.shutdown = vio_bus_shutdown;
 
 	return driver_register(&viodrv->driver);
 }
@@ -295,4 +292,7 @@ struct bus_type vio_bus_type = {
 	.name = "vio",
 	.uevent = vio_hotplug,
 	.match = vio_bus_match,
+	.probe = vio_bus_probe,
+	.remove = vio_bus_remove,
+	.shutdown = vio_bus_shutdown,
 };


Patches currently in gregkh-2.6 which might be from rmk@arm.linux.org.uk are

driver/add-bttv-sub-bus_type-probe-and-remove-methods.patch
driver/add-bus_type-probe-remove-shutdown-methods..patch
driver/add-ccwgroup_bus_type-probe-and-remove-methods.patch
driver/add-dio_bus_type-probe-and-remove-methods.patch
driver/add-ecard_bus_type-probe-remove-shutdown-methods.patch
driver/add-gameport-bus_type-probe-and-remove-methods.patch
driver/add-i2c_bus_type-probe-and-remove-methods.patch
driver/add-ide_bus_type-probe-and-remove-methods.patch
driver/add-locomo-bus_type-probe-remove-methods.patch
driver/add-logic-module-bus_type-probe-remove-methods.patch
driver/add-macio_bus_type-probe-and-remove-methods.patch
driver/add-mcp-bus_type-probe-and-remove-methods.patch
driver/add-mmc_bus_type-probe-and-remove-methods.patch
driver/add-ocp_bus_type-probe-and-remove-methods.patch
driver/add-of_platform_bus_type-probe-and-remove-methods.patch
driver/add-parisc_bus_type-probe-and-remove-methods.patch
driver/add-pci_bus_type-probe-and-remove-methods.patch
driver/add-pcmcia_bus_type-probe-and-remove-methods.patch
driver/add-pnp_bus_type-probe-and-remove-methods.patch
driver/add-pseudo-lld-bus_type-probe-and-remove-methods.patch
driver/add-rio_bus_type-probe-and-remove-methods.patch
driver/add-sa1111-bus_type-probe-remove-methods.patch
driver/add-serio-bus_type-probe-and-remove-methods.patch
driver/add-sh_bus_type-probe-and-remove-methods.patch
driver/add-superhyway_bus_type-probe-and-remove-methods.patch
driver/add-tiocx-bus_type-probe-remove-methods.patch
driver/add-usb_serial_bus_type-probe-and-remove-methods.patch
driver/add-vio_bus_type-probe-and-remove-methods.patch
driver/add-zorro_bus_type-probe-and-remove-methods.patch
driver/remove-usb-gadget-generic-driver-methods.patch
