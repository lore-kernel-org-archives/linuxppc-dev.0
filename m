Return-Path: <glikely@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.200])
	by ozlabs.org (Postfix) with ESMTP id 5A4B167D60
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 24 Jul 2005 00:07:39 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id i28so611850wra
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 23 Jul 2005 07:07:38 -0700 (PDT)
Message-ID: <528646bc05072307074e8fce3e@mail.gmail.com>
Date: Sat, 23 Jul 2005 10:07:38 -0400
From: Grant Likely <glikely@gmail.com>
To: linuxppc-embedded@ozlabs.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [PATCH 1/3] SPI bus core infrastructure
Reply-To: Grant Likely <glikely@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Patch to add support for SPI busses.  SPI bus master drivers and SPI
slave drivers register with the SPI infrastructure.

Signed-off-by: Grant Likely <grant.likely@gdcanada.com>

diff -ruNp linux/drivers/Kconfig linux-spi/drivers/Kconfig
--- linux/drivers/Kconfig=092005-06-17 15:48:29.000000000 -0400
+++ linux-spi/drivers/Kconfig=092005-07-22 17:08:00.000000000 -0400
@@ -58,4 +58,6 @@ source "drivers/mmc/Kconfig"
=20
 source "drivers/infiniband/Kconfig"
=20
+source "drivers/spi/Kconfig"
+
 endmenu
diff -ruNp linux/drivers/Makefile linux-spi/drivers/Makefile
--- linux/drivers/Makefile=092005-06-17 15:48:29.000000000 -0400
+++ linux-spi/drivers/Makefile=092005-07-22 17:08:00.000000000 -0400
@@ -61,6 +61,7 @@ obj-$(CONFIG_EISA)=09=09+=3D eisa/
 obj-$(CONFIG_CPU_FREQ)=09=09+=3D cpufreq/
 obj-$(CONFIG_MMC)=09=09+=3D mmc/
 obj-$(CONFIG_INFINIBAND)=09+=3D infiniband/
+obj-$(CONFIG_SPI)=09=09+=3D spi/
 obj-$(CONFIG_BLK_DEV_SGIIOC4)=09+=3D sn/
 obj-y=09=09=09=09+=3D firmware/
 obj-$(CONFIG_CRYPTO)=09=09+=3D crypto/
diff -ruNp linux/drivers/spi/Kconfig linux-spi/drivers/spi/Kconfig
--- linux/drivers/spi/Kconfig=091969-12-31 19:00:00.000000000 -0500
+++ linux-spi/drivers/spi/Kconfig=092005-07-22 17:08:00.000000000 -0400
@@ -0,0 +1,27 @@
+#
+# SPI bus configuration
+#
+
+menu "SPI support"
+
+config SPI
+=09tristate "SPI support"
+=09---help---
+=09  SPI is a serial bus protocol for connecting between ICs.  SPI
+=09  support requires two components; a bus driver plus drivers for
+=09  each SPI slave device.
+
+=09  Enabling SPI support will only cause SPI device drivers to be
compiled=09  into the kernel.  You also need to make sure the platform
setup code
+=09  takes care of mapping SPI slaves onto each SPI bus.
+
+=09  Typically you will only need this for embedded systems.
+=09  Say N if unsure.
+
+comment "SPI Bus Drivers"
+=09depends on SPI
+
+comment "SPI slaves"
+=09depends on SPI
+
+endmenu
+
diff -ruNp linux/drivers/spi/Makefile linux-spi/drivers/spi/Makefile
--- linux/drivers/spi/Makefile=091969-12-31 19:00:00.000000000 -0500
+++ linux-spi/drivers/spi/Makefile=092005-07-22 17:08:00.000000000 -0400
@@ -0,0 +1,5 @@
+#
+# Makefile for the spi core.
+#
+
+obj-$(CONFIG_SPI)=09=09=09+=3D spi-core.o
diff -ruNp linux/drivers/spi/spi-core.c linux-spi/drivers/spi/spi-core.c
--- linux/drivers/spi/spi-core.c=091969-12-31 19:00:00.000000000 -0500
+++ linux-spi/drivers/spi/spi-core.c=092005-07-22 17:08:00.000000000 -0400
@@ -0,0 +1,156 @@
+/*
+ * drivers/spi/spi-core.c
+ *
+ * Core Serial Peripheral Interface (SPI) bus infrastructure
+ *
+ * Adds support for SPI busses.  SPI master devices and SPI device drivers
+ * register with spi core.  SPI slave devices get attached to SPI masters
+ * and are matched with an SPI device driver using the facillities of the
+ * linux device model.
+ *
+ * SPI is oriented around 'transfers' initiated by the SPI master.  A tran=
sfer
+ * begins when the master asserts the 'slave select (SS)' signal.  It then
+ * clocks out data one bit at a time on the "Master Out/Slave In (MOSI)" l=
ine
+ * and samples one bit at a time on the "Master In/Slave Out (MISO)" line.
+ * Clocking out and sampling are syncronized with the clock signal which i=
s
+ * driven by the master.  Exactly the same amount of data is transmitted a=
s
+ * is received for each transfer.  The transfer if finished when the maste=
r
+ * deasserts the SS signal.
+ *
+ * SPI bus drivers provide a 'transfer' method which accepts an input buff=
er,
+ * an output buffer and a count.  Slave device drivers use the transfer me=
thod
+ * to communicate with the slave device.  It is up to the slave device dri=
ver
+ * to decide what to do with the transfered data.
+ *
+ * This infrastructure is for SPI master devices only.  Linux cannot be an
+ * SPI slave with this module.  Theoretically multi-master busses will wor=
k
+ * as long as the other master doesn't try to use us as a slave
+ *
+ * Maintainer : Grant Likely <glikely@gmail.com>
+ *=20
+ * This file is in the public domain.
+ *
+ */
+=20
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/fs.h>
+#include <linux/spi.h>
+#include <asm/uaccess.h>
+
+MODULE_AUTHOR("Grant Likely <glikely@gmail.com>");
+MODULE_DESCRIPTION("Freescale MPC52xx PSC in SPI mode");
+MODULE_LICENSE("Dual BSD/GPL");
+
+/* Simple enumeration scheme for assigning bus ids */
+static int spi_next_bus_id =3D 0;
+
+/* Forward Declarations */
+static int spi_match (struct device *dev, struct device_driver *drv);
+static void spi_bus_release(struct device *dev);
+
+/* Linux device model stuff (for registering a new bus type) */
+struct bus_type spi_bus_type =3D {
+=09.name =3D "spi",
+=09.match =3D spi_match,
+};
+
+static struct sysfs_ops spi_driver_sysfs_ops =3D {
+};
+
+static struct kobj_type spi_driver_kobj_type =3D {
+=09.sysfs_ops =3D &spi_driver_sysfs_ops,
+};
+
+/* Called by device model to match devices to device drivers
+ *
+ * Devices are matched to devices based on the name fields in the spi_dev
+ * and device_driver structures.  If the names match, then the device and
+ * driver can possibly be connected
+ */
+static int spi_match (struct device *dev, struct device_driver *drv)
+{
+=09struct spi_device *spi_device =3D to_spi_dev(dev);
+=09return !strncmp(spi_device->name, drv->name, strlen(drv->name));
+}
+
+static void spi_bus_release(struct device *dev)
+{
+}
+
+/* Initialize common SPI bus fields before registering the bus device with=
 the
+ * device model
+ */
+int spi_bus_register(struct spi_bus *spi)
+{
+=09snprintf(spi->dev.bus_id, BUS_ID_SIZE, "spi%i", spi_next_bus_id++);
+=09spi->dev.release =3D spi_bus_release;
+
+=09return device_register(&spi->dev);
+}
+
+void spi_bus_unregister(struct spi_bus *spi)
+{
+=09device_unregister(&spi->dev);
+}
+
+/* Helper function for attaching SPI slave devices to an SPI bus.  Slave
+ * devices should get matched to slave device drivers
+ */
+int spi_device_create(struct spi_bus *bus, char *name, int id)
+{
+=09struct spi_device *dev;
+
+=09dev =3D kmalloc(sizeof (struct spi_device), GFP_KERNEL);
+=09if (!dev) {
+=09=09return -ENOMEM;
+=09}
+=09memset(dev, 0, sizeof(struct spi_device));
+
+=09strlcpy(dev->name, name, SPI_NAME_SIZE);
+=09dev->id =3D id;
+=09snprintf(dev->dev.bus_id, BUS_ID_SIZE, "%s.%i", name, id);
+=09dev->dev.parent =3D &bus->dev;
+=09dev->dev.bus =3D &spi_bus_type;
+
+=09return device_register(&dev->dev);
+}
+
+/* Register an SPI slave device driver with the SPI infrastructure */
+int spi_driver_register(struct spi_driver *drv)
+{
+=09int err;
+
+=09drv->driver.name =3D drv->name;
+=09drv->driver.bus =3D &spi_bus_type;
+=09drv->driver.kobj.ktype =3D &spi_driver_kobj_type;
+=09err =3D driver_register(&drv->driver);
+=09return err;
+}
+
+void spi_driver_unregister(struct spi_driver *drv)
+{
+=09driver_unregister(&drv->driver);
+}
+
+static int __init spi_init(void)
+{
+=09printk(KERN_INFO "spi-core: initializing\n");
+
+=09return bus_register(&spi_bus_type);
+}
+
+static void __exit spi_exit(void)
+{
+=09bus_unregister(&spi_bus_type);
+}
+
+module_init(spi_init);
+module_exit(spi_exit);
+EXPORT_SYMBOL(spi_bus_register);
+EXPORT_SYMBOL(spi_bus_unregister);
+EXPORT_SYMBOL(spi_device_create);
+EXPORT_SYMBOL(spi_driver_register);
+EXPORT_SYMBOL(spi_driver_unregister);
+
diff -ruNp linux/include/linux/spi.h linux-spi/include/linux/spi.h
--- linux/include/linux/spi.h=091969-12-31 19:00:00.000000000 -0500
+++ linux-spi/include/linux/spi.h=092005-07-22 17:08:00.000000000 -0400
@@ -0,0 +1,72 @@
+/*
+ * drivers/spi/spi.h
+ *
+ * Core Serial Peripheral Interface (SPI) bus infrastructure
+ *
+ * Adds support for SPI busses.  SPI master devices and SPI device drivers
+ * register with spi core.  SPI slave devices get attached to SPI masters
+ * and are matched with an SPI device driver using the facillities of the
+ * linux device model.
+ *
+ * SPI is oriented around 'transfers' initiated by the SPI master.  A tran=
sfer
+ * begins when the master asserts the 'slave select (SS)' signal.  It then
+ * clocks out data one bit at a time on the "Master Out/Slave In (MOSI)" l=
ine
+ * and samples one bit at a time on the "Master In/Slave Out (MISO)" line.
+ * Clocking out and sampling are syncronized with the clock signal which i=
s
+ * driven by the master.  Exactly the same amount of data is transmitted a=
s
+ * is received for each transfer.  The transfer if finished when the maste=
r
+ * deasserts the SS signal.
+ *
+ * SPI bus drivers provide a 'transfer' method which accepts an input buff=
er,
+ * an output buffer and a count.  Slave device drivers use the transfer me=
thod
+ * to communicate with the slave device.  It is up to the slave device dri=
ver
+ * to decide what to do with the transfered data.
+ *
+ * This infrastructure is for SPI master devices only.  Linux cannot be an
+ * SPI slave with this module.  Multi-master SPI busses aren't supported
+ * either.
+ *
+ * Maintainer : Grant Likely <glikely@gmail.com>
+ *=20
+ * This file is in the public domain
+ */
+
+struct spi_bus {
+=09struct spi_bus_ops *ops;
+=09struct device dev;
+=09void *input_buff;
+=09int   input_len;
+};
+#define to_spi_bus(d) container_of(d, struct spi_bus, dev);
+
+#define SPI_CLKEDGE_RISING=090
+#define SPI_CLKEDGE_FALLING=091
+struct spi_bus_ops {
+=09int (*transfer) (struct spi_bus *bus, int id, int clkedge,
+=09                 uint8_t *in, const uint8_t *out, size_t count);
+};
+
+struct spi_driver {
+=09char *name;
+=09struct module *module;
+=09struct device_driver driver;
+};
+
+#define SPI_NAME_SIZE=09KOBJ_NAME_LEN
+struct spi_device {
+=09char name[SPI_NAME_SIZE];
+=09int id;
+=09struct spi_driver *driver;
+=09struct device dev;
+};
+#define to_spi_dev(d) container_of(d, struct spi_device, dev);
+
+
+extern int spi_device_create(struct spi_bus *bus, char *name, int id);
+
+/* Interface functions for registering and unregistering SPI busses */
+extern int spi_bus_register(struct spi_bus *bus);
+extern void spi_bus_unregister(struct spi_bus *bus);
+
+extern int spi_driver_register(struct spi_driver *driver);
+extern void spi_driver_unregister(struct spi_driver *driver);
