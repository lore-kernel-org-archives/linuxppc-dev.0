Date: Fri, 9 Aug 2002 14:26:05 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: linuxppc-embedded@lists.linuxppc.org
Subject: First steps to OCP device model integration
Message-ID: <20020809042605.GC23642@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


THe patch below implements the first steps in transitioning the
handling of 4xx OCP devices to the unfied device model (in 2.5).  So
far the code just registers an ocp bus and registers each device
described in core_ocp on that bus.  The next step is to convert the
actual device drivers so that that they register with the unified
driver tree rather than through the old ocp_register() mechanism.

I will commit this shortly unless there are serious objections.

diff -urN /home/dgibson/kernel/linuxppc-2.5/drivers/ocp/ocp.c linux-bluefish/drivers/ocp/ocp.c
--- /home/dgibson/kernel/linuxppc-2.5/drivers/ocp/ocp.c	2002-08-09 11:28:27.000000000 +1000
+++ linux-bluefish/drivers/ocp/ocp.c	2002-08-09 13:55:08.000000000 +1000
@@ -69,6 +69,8 @@
 #include <linux/miscdevice.h>
 #include <linux/slab.h>
 #include <linux/types.h>
+#include <linux/device.h>
+#include <linux/init.h>
 #include <asm/io.h>
 #include <asm/ocp.h>
 #include <asm/errno.h>
@@ -388,3 +390,58 @@
 EXPORT_SYMBOL(ocp_free_dev);
 EXPORT_SYMBOL(ocp_register);
 EXPORT_SYMBOL(ocp_unregister);
+
+/* Unified device model OCP interface */
+
+static int ocp_bus_match(struct device * dev, struct device_driver * drv)
+{
+	struct ocp_device *odev = to_ocp_dev(dev);
+	struct ocp_driver *odrv = to_ocp_driver(drv);
+
+	return (odrv->type == odev->def.type);
+}
+
+struct bus_type ocp_bus_type = {
+	name:	"ocp",
+	match:	ocp_bus_match,
+};
+
+static struct device ocp_bus = {
+       name:           "IBM4xx On-Chip Peripheral Bus",
+       bus_id:         "ocp",
+};
+
+static int __init ocp_bus_init(void)
+{
+	int i;
+
+	printk(KERN_DEBUG "OCP: Registering OCP bus and devices\n");
+
+	if (bus_register(&ocp_bus_type) != 0)
+		panic("Couldn't register OCP bus type\n");
+	if (device_register(&ocp_bus) != 0)
+		panic("Couldn't register OCP bus\n");
+
+	for (i = 0; core_ocp[i].type != OCP_NULL_TYPE; i++) {
+		enum ocp_type type = core_ocp[i].type;
+		struct ocp_device *odev;
+
+		odev = kmalloc(sizeof(*odev), GFP_KERNEL);
+		if (! odev)
+			panic("unable to allocate memory for ocp_device\n");
+		memset(odev, 0, sizeof(*odev));
+
+		memcpy(&odev->def, &core_ocp[i], sizeof(struct ocp_def));
+
+		odev->dev.bus = &ocp_bus_type;
+		odev->dev.parent = &ocp_bus;
+		strcpy(odev->dev.name, ocp_type_info[type].desc);
+		sprintf(odev->dev.bus_id, "%d:%s", i, ocp_type_info[type].name);
+
+		device_register(&odev->dev);
+	}
+
+	return 0;
+}
+
+postcore_initcall(ocp_bus_init);
diff -urN /home/dgibson/kernel/linuxppc-2.5/include/asm-ppc/ocp.h linux-bluefish/include/asm-ppc/ocp.h
--- /home/dgibson/kernel/linuxppc-2.5/include/asm-ppc/ocp.h	2002-08-08 11:20:50.000000000 +1000
+++ linux-bluefish/include/asm-ppc/ocp.h	2002-08-09 14:00:46.000000000 +1000
@@ -51,6 +51,7 @@

 #include <linux/list.h>
 #include <linux/config.h>
+#include <linux/device.h>

 #include <asm/mmu.h>		/* For phys_addr_t */

@@ -158,5 +159,21 @@
 extern int ocp_get_irq(int type, int dev_num);
 extern int ocp_get_pm(int type, int dev_num);

+/* Unified device model OCP interface */
+
+struct ocp_device {
+	struct ocp_def def;
+	struct device dev;
+};
+
+struct ocp_driver {
+	enum ocp_type type;
+	struct device_driver driver;
+};
+
+#define	to_ocp_dev(n) container_of(n, struct ocp_device, dev)
+#define	to_ocp_driver(n) container_of(n, struct ocp_driver, driver)
+
+
 #endif				/* __OCP_H__ */
 #endif				/* __KERNEL__ */


--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
