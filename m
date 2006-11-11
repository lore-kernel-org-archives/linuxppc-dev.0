Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Sat, 11 Nov 2006 17:24:49 +1100
Subject: [PATCH 6/32] Change ACPI to use dev_archdata instead of firmware_data
In-Reply-To: <1163226282.72526.823314634857.qpush@butch>
Message-Id: <20061111062520.DB35668104@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch changes ACPI to use the new dev_archdata on i386, x86_64
and ia64 (is there any other arch using ACPI ?) to store it's
acpi_handle.

It also removes the firmware_data field from struct device as this
was the only user.

Only build-tested on x86

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

 drivers/acpi/glue.c         |   20 +++++++++++---------
 include/acpi/acpi_bus.h     |    2 +-
 include/asm-i386/device.h   |   10 +++++++++-
 include/asm-ia64/device.h   |   10 +++++++++-
 include/asm-x86_64/device.h |   10 +++++++++-
 include/linux/device.h      |    2 --
 6 files changed, 39 insertions(+), 15 deletions(-)

Index: linux-cell/drivers/acpi/glue.c
===================================================================
--- linux-cell.orig/drivers/acpi/glue.c	2006-11-11 14:34:25.000000000 +1100
+++ linux-cell/drivers/acpi/glue.c	2006-11-11 14:35:42.000000000 +1100
@@ -267,9 +267,9 @@
 {
 	acpi_status status;
 
-	if (dev->firmware_data) {
+	if (dev->archdata.acpi_handle) {
 		printk(KERN_WARNING PREFIX
-		       "Drivers changed 'firmware_data' for %s\n", dev->bus_id);
+		       "Drivers changed 'acpi_handle' for %s\n", dev->bus_id);
 		return -EINVAL;
 	}
 	get_device(dev);
@@ -278,25 +278,26 @@
 		put_device(dev);
 		return -EINVAL;
 	}
-	dev->firmware_data = handle;
+	dev->archdata.acpi_handle = handle;
 
 	return 0;
 }
 
 static int acpi_unbind_one(struct device *dev)
 {
-	if (!dev->firmware_data)
+	if (!dev->archdata.acpi_handle)
 		return 0;
-	if (dev == acpi_get_physical_device(dev->firmware_data)) {
+	if (dev == acpi_get_physical_device(dev->archdata.acpi_handle)) {
 		/* acpi_get_physical_device increase refcnt by one */
 		put_device(dev);
-		acpi_detach_data(dev->firmware_data, acpi_glue_data_handler);
-		dev->firmware_data = NULL;
+		acpi_detach_data(dev->archdata.acpi_handle,
+				 acpi_glue_data_handler);
+		dev->archdata.acpi_handle = NULL;
 		/* acpi_bind_one increase refcnt by one */
 		put_device(dev);
 	} else {
 		printk(KERN_ERR PREFIX
-		       "Oops, 'firmware_data' corrupt for %s\n", dev->bus_id);
+		       "Oops, 'acpi_handle' corrupt for %s\n", dev->bus_id);
 	}
 	return 0;
 }
@@ -328,7 +329,8 @@
 	if (!ret) {
 		struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 
-		acpi_get_name(dev->firmware_data, ACPI_FULL_PATHNAME, &buffer);
+		acpi_get_name(dev->archdata.acpi_handle,
+			      ACPI_FULL_PATHNAME, &buffer);
 		DBG("Device %s -> %s\n", dev->bus_id, (char *)buffer.pointer);
 		kfree(buffer.pointer);
 	} else
Index: linux-cell/include/acpi/acpi_bus.h
===================================================================
--- linux-cell.orig/include/acpi/acpi_bus.h	2006-11-11 14:34:25.000000000 +1100
+++ linux-cell/include/acpi/acpi_bus.h	2006-11-11 14:35:42.000000000 +1100
@@ -357,7 +357,7 @@
 /* helper */
 acpi_handle acpi_get_child(acpi_handle, acpi_integer);
 acpi_handle acpi_get_pci_rootbridge_handle(unsigned int, unsigned int);
-#define DEVICE_ACPI_HANDLE(dev) ((acpi_handle)((dev)->firmware_data))
+#define DEVICE_ACPI_HANDLE(dev) ((acpi_handle)((dev)->archdata.acpi_handle))
 
 #endif /* CONFIG_ACPI */
 
Index: linux-cell/include/asm-i386/device.h
===================================================================
--- linux-cell.orig/include/asm-i386/device.h	2006-11-11 14:34:25.000000000 +1100
+++ linux-cell/include/asm-i386/device.h	2006-11-11 14:35:42.000000000 +1100
@@ -3,5 +3,13 @@
  *
  * This file is released under the GPLv2
  */
-#include <asm-generic/device.h>
+#ifndef _ASM_I386_DEVICE_H
+#define _ASM_I386_DEVICE_H
 
+struct dev_archdata {
+#ifdef CONFIG_ACPI
+	void	*acpi_handle;
+#endif
+};
+
+#endif /* _ASM_I386_DEVICE_H */
Index: linux-cell/include/linux/device.h
===================================================================
--- linux-cell.orig/include/linux/device.h	2006-11-11 14:34:25.000000000 +1100
+++ linux-cell/include/linux/device.h	2006-11-11 14:35:42.000000000 +1100
@@ -368,8 +368,6 @@
 	void		*driver_data;	/* data private to the driver */
 	void		*platform_data;	/* Platform specific data, device
 					   core doesn't touch it */
-	void		*firmware_data; /* Firmware specific data (e.g. ACPI,
-					   BIOS data),reserved for device core*/
 	struct dev_pm_info	power;
 
 	u64		*dma_mask;	/* dma mask (if dma'able device) */
Index: linux-cell/include/asm-x86_64/device.h
===================================================================
--- linux-cell.orig/include/asm-x86_64/device.h	2006-11-11 14:34:25.000000000 +1100
+++ linux-cell/include/asm-x86_64/device.h	2006-11-11 14:35:42.000000000 +1100
@@ -3,5 +3,13 @@
  *
  * This file is released under the GPLv2
  */
-#include <asm-generic/device.h>
+#ifndef _ASM_X86_64_DEVICE_H
+#define _ASM_X86_64_DEVICE_H
 
+struct dev_archdata {
+#ifdef CONFIG_ACPI
+	void	*acpi_handle;
+#endif
+};
+
+#endif /* _ASM_X86_64_DEVICE_H */
Index: linux-cell/include/asm-ia64/device.h
===================================================================
--- linux-cell.orig/include/asm-ia64/device.h	2006-11-11 14:34:25.000000000 +1100
+++ linux-cell/include/asm-ia64/device.h	2006-11-11 14:35:42.000000000 +1100
@@ -3,5 +3,13 @@
  *
  * This file is released under the GPLv2
  */
-#include <asm-generic/device.h>
+#ifndef _ASM_IA64_DEVICE_H
+#define _ASM_IA64_DEVICE_H
 
+struct dev_archdata {
+#ifdef CONFIG_ACPI
+	void	*acpi_handle;
+#endif
+};
+
+#endif /* _ASM_IA64_DEVICE_H */
