Date: Fri, 4 Oct 2002 15:55:17 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Matt Porter <porter@cox.net>, Paul Mackerras <paulus@samba.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Another OCP cleanups
Message-ID: <20021004055517.GN1933@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This patch removes a bunch of unused OCP functions, and the "core_map"
global variable with them.  It also marks several more functions
static.

diff -urN linux-bluefish-old/drivers/ocp/ocp-probe.c linux-bluefish/drivers/ocp/ocp-probe.c
--- linux-bluefish-old/drivers/ocp/ocp-probe.c	2002-09-19 17:02:04.000000000 +1000
+++ linux-bluefish/drivers/ocp/ocp-probe.c	2002-10-04 15:45:11.000000000 +1000
@@ -45,7 +45,7 @@
 static struct ocp_bus *ocp_alloc_bus(void);
 unsigned int ocp_do_scan_bus(struct ocp_bus *bus);

-struct ocp_bus * __devinit ocp_add_new_bus(struct ocp_bus *parent, struct ocp_device *dev, int busnr)
+static struct ocp_bus * __devinit ocp_add_new_bus(struct ocp_bus *parent, struct ocp_device *dev, int busnr)
 {
 	struct ocp_bus *child;

@@ -92,7 +92,7 @@

 }

-struct ocp_device * __devinit ocp_setup_dev(struct ocp_device *temp, unsigned int index)
+static struct ocp_device * __devinit ocp_setup_dev(struct ocp_device *temp, unsigned int index)
 {
 	struct ocp_device *dev;

@@ -126,7 +126,7 @@
 	return dev;
 }

-struct ocp_device * __devinit ocp_scan_device(struct ocp_device *temp, unsigned int func)
+static struct ocp_device * __devinit ocp_scan_device(struct ocp_device *temp, unsigned int func)
 {

 	struct ocp_device *dev;
@@ -139,7 +139,7 @@
 	list_add_tail(&dev->bus_list, &bus->devices);
 	return dev;
 }
-unsigned int __devinit ocp_do_scan_bus(struct ocp_bus *bus)
+static unsigned int __devinit ocp_do_scan_bus(struct ocp_bus *bus)
 {
 	unsigned int max;
 	struct list_head *ln;
@@ -204,7 +204,7 @@
 	return 0;
 }

-struct ocp_bus * __devinit ocp_alloc_primary_bus(int bus)
+static struct ocp_bus * __devinit ocp_alloc_primary_bus(int bus)
 {
 	struct ocp_bus *b;

diff -urN linux-bluefish-old/drivers/ocp/ocp.c linux-bluefish/drivers/ocp/ocp.c
--- linux-bluefish-old/drivers/ocp/ocp.c	2002-09-19 16:09:26.000000000 +1000
+++ linux-bluefish/drivers/ocp/ocp.c	2002-10-04 15:39:27.000000000 +1000
@@ -74,8 +74,6 @@
 #include <linux/ocp.h>
 #include <asm/errno.h>

-struct ocp_def *core_map __initdata = NULL;
-
 /**
  * ocp_get_bus_start - get irq for ocp device and instance of it
  * @device: OCP bus device such as PCI, ZMII, OPB, PLB
@@ -130,20 +128,6 @@
 }

 /**
- * ocp_get_device - get device for ocp type
- * @device: OCP device such as PCI, GPT, UART, OPB, IIC, GPIO, EMAC, ZMII,
- *
- * The routine returns device at the index that a given core supports
- */
-unsigned int
-ocp_get_device(unsigned int index)
-{
-
-	return(core_ocp[index].device);
-}
-
-
-/**
  * ocp_get_max - get max for ocp type
  * @device: OCP device such as PCI, GPT, UART, OPB, IIC, GPIO, EMAC, ZMII,
  *
@@ -206,30 +190,6 @@
 }

 /**
- * get_ocp_vendor - get vendor for ocp device and instance of it
- * @device: OCP device such as PCI, GPT, UART, OPB, IIC, GPIO, EMAC, ZMII,
- * @dev_num: ocp device number whos vendor ID you want
- *
- * The routine returns the valid irq, OCP_IRQ_NA or OCP_IRQ_MUL
- * of device and instance requested
- */
-unsigned int
-ocp_get_vendor(unsigned int device, int dev_num)
-{
-	int a, i;
-
-	for (i = 0, a = 0; core_ocp[i].device != OCP_FUNC_INVALID; i++) {
-		if (device == core_ocp[i].device) {
-			if (a == dev_num)
-				return (core_ocp[i].vendor);
-			a++;
-		}
-	}
-
-	return OCP_VENDOR_INVALID;
-}
-
-/**
  * ocp_get_paddr - get phyical address for ocp device and instance of it
  * @device: OCP device such as PCI, GPT, UART, OPB, IIC, GPIO, EMAC, ZMII
  * @dev_num: ocp device number whos paddr you want
@@ -316,44 +276,8 @@
 	return d;
 }

-int
-ocp_add_device(struct ocp_device *temp)
-{
-	struct ocp_device *dev;
-
-	if((dev = ocp_alloc_device()) == NULL)
-		return 0;
-	list_add_tail(&dev->global_list, &ocp_devices);
-	return 1;
-}
-void
-ocp_map_init(void)
-{
-	struct ocp_device dev;
-	int i;
-
-	if (core_map == NULL)
-		core_map = core_ocp;
-
-	for (i = 0 ;core_map[i].device != OCP_FUNC_INVALID; i++){
-
-	/* Create a device template */
-	memset(&dev, 0, sizeof(dev));
-	dev.vendor	= core_map[i].vendor;
-	dev.device	= core_map[i].device;
-	dev.paddr	= core_map[i].paddr;
-	dev.irq		= core_map[i].irq;
-	dev.pm		= core_map[i].pm;
-
-	ocp_add_device(&dev);
-	}
-
-
-}
-
 EXPORT_SYMBOL(ocp_get_pm);
 EXPORT_SYMBOL(ocp_get_irq);
-EXPORT_SYMBOL(ocp_get_vendor);
 EXPORT_SYMBOL(ocp_get_paddr);
 EXPORT_SYMBOL(ocp_get_max);
 EXPORT_SYMBOL(ocp_get_dev);
diff -urN linux-bluefish-old/include/linux/ocp.h linux-bluefish/include/linux/ocp.h
--- linux-bluefish-old/include/linux/ocp.h	2002-10-04 11:58:36.000000000 +1000
+++ linux-bluefish/include/linux/ocp.h	2002-10-04 15:39:23.000000000 +1000
@@ -238,17 +238,14 @@
 }
 extern void ocp_init(void);
 extern struct ocp_def core_ocp[];
-extern struct ocp_def *core_map;
 extern struct ocp_bus *ocp_scan_bus(int bus, void *sysdata);
 extern struct bus_type ocp_bus_type;
 extern struct ocp_device *ocp_get_dev(unsigned int device, int index);
-extern unsigned int ocp_get_device(unsigned int index);
 extern unsigned long ocp_get_paddr(unsigned int device, int dev_num);
 extern unsigned int ocp_get_max(unsigned int device);
 extern int ocp_get_irq(unsigned int device, int dev_num);
 extern int ocp_get_pm(unsigned int device, int dev_num);
 extern unsigned int ocp_get_num(unsigned int device);
-extern unsigned int ocp_get_vendor(unsigned int device, int dev_num);
 extern unsigned ocp_get_bus_start(unsigned int device, int bus_num);
 extern unsigned ocp_get_bus_end(unsigned int device, int bus_num);



--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
