Date: Thu, 3 Oct 2002 17:03:33 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@samba.org>, Matt Porter <porter@cox.net>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: OCP probe cleanup
Message-ID: <20021003070333.GB6160@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This patch streamlines the OCP probe logic slightly, abolishing the
pointless id paramter to the OCP probe callback, and the equally
pointless ocp_match_device() with it.

diff -urN linux-bluefish-old/arch/ppc/kernel/4xx/ocp_uart.c linux-bluefish/arch/ppc/kernel/4xx/ocp_uart.c
--- linux-bluefish-old/arch/ppc/kernel/4xx/ocp_uart.c	2002-10-01 12:51:56.000000000 +1000
+++ linux-bluefish/arch/ppc/kernel/4xx/ocp_uart.c	2002-10-03 16:37:32.000000000 +1000
@@ -135,7 +135,7 @@
 }
 #endif

-static int __devinit ocp_uart_probe(struct ocp_device *pdev,const struct ocp_device_id *ent)
+static int __devinit ocp_uart_probe(struct ocp_device *pdev)
 {

 	DBG("Vendor:%x Device:%x.%d @%lx irq:%d\n", pdev->vendor, pdev->device, pdev->num,
diff -urN linux-bluefish-old/drivers/i2c/i2c-adap-ibm_ocp.c linux-bluefish/drivers/i2c/i2c-adap-ibm_ocp.c
--- linux-bluefish-old/drivers/i2c/i2c-adap-ibm_ocp.c	2002-09-19 16:08:30.000000000 +1000
+++ linux-bluefish/drivers/i2c/i2c-adap-ibm_ocp.c	2002-10-03 16:38:26.000000000 +1000
@@ -239,7 +239,7 @@
 }
 #endif

-static int __devinit ocp_iic_probe(struct ocp_device *pdev,const struct ocp_device_id *ent)
+static int __devinit ocp_iic_probe(struct ocp_device *pdev)
 {

 	struct i2c_adapter *adap;
diff -urN linux-bluefish-old/drivers/ide/ibm_ocp_ide.c linux-bluefish/drivers/ide/ibm_ocp_ide.c
--- linux-bluefish-old/drivers/ide/ibm_ocp_ide.c	2002-09-19 16:08:31.000000000 +1000
+++ linux-bluefish/drivers/ide/ibm_ocp_ide.c	2002-10-03 16:38:46.000000000 +1000
@@ -490,7 +490,7 @@
 }
 #endif

-static int __devinit ocp_ide_probe(struct ocp_device *pdev,const struct ocp_device_id *ent)
+static int __devinit ocp_ide_probe(struct ocp_device *pdev)
 {
 	int i;
 	unsigned int index;
diff -urN linux-bluefish-old/drivers/ide/ocp_stbxxxxx.c linux-bluefish/drivers/ide/ocp_stbxxxxx.c
--- linux-bluefish-old/drivers/ide/ocp_stbxxxxx.c	2002-09-19 16:08:31.000000000 +1000
+++ linux-bluefish/drivers/ide/ocp_stbxxxxx.c	2002-10-03 16:39:05.000000000 +1000
@@ -523,7 +523,7 @@
 }
 #endif

-static int __devinit ocp_ide_probe(struct ocp_device *pdev,const struct ocp_device_id *ent)
+static int __devinit ocp_ide_probe(struct ocp_device *pdev)
 {
 	printk("IBM IDE driver version %s\n", IDEVR);

diff -urN linux-bluefish-old/drivers/misc/ibm_ocp_gpio.c linux-bluefish/drivers/misc/ibm_ocp_gpio.c
--- linux-bluefish-old/drivers/misc/ibm_ocp_gpio.c	2002-09-19 16:08:41.000000000 +1000
+++ linux-bluefish/drivers/misc/ibm_ocp_gpio.c	2002-10-03 16:39:17.000000000 +1000
@@ -291,7 +291,7 @@
 	release:ocp_gpio_release,
 };

-static int __devinit ocp_gpio_probe(struct ocp_device *pdev,const struct ocp_device_id *ent)
+static int __devinit ocp_gpio_probe(struct ocp_device *pdev)
 {

 	printk("IBM gpio driver version %s\n", VUFX);
diff -urN linux-bluefish-old/drivers/net/ibm_ocp/ibm_ocp_enet.c linux-bluefish/drivers/net/ibm_ocp/ibm_ocp_enet.c
--- linux-bluefish-old/drivers/net/ibm_ocp/ibm_ocp_enet.c	2002-09-26 12:14:09.000000000 +1000
+++ linux-bluefish/drivers/net/ibm_ocp/ibm_ocp_enet.c	2002-10-03 16:36:42.000000000 +1000
@@ -523,8 +523,7 @@
 	.rxde = &ppc405_eth_rxde_dev,
 };

-static int __devinit ocp_emac_probe(struct ocp_device *pdev,
-				    const struct ocp_device_id *ent)
+static int __devinit ocp_emac_probe(struct ocp_device *pdev)
 {
 	int err = 0;
 	int i;
diff -urN linux-bluefish-old/drivers/ocp/ocp-driver.c linux-bluefish/drivers/ocp/ocp-driver.c
--- linux-bluefish-old/drivers/ocp/ocp-driver.c	2002-09-19 16:09:26.000000000 +1000
+++ linux-bluefish/drivers/ocp/ocp-driver.c	2002-10-03 16:42:13.000000000 +1000
@@ -40,27 +40,6 @@
  *  Registration of OCP drivers and handling of hot-pluggable devices.
  */

-/**
- * ocp_match_device - Tell if a OCP device structure has a matching OCP device id structure
- * @ids: array of OCP device id structures to search in
- * @dev: the OCP device structure to match against
- *
- * Used by a driver to check whether a OCP device present in the
- * system is in its list of supported devices.Returns the matching
- * ocp_device_id structure or %NULL if there is no match.
- */
-const struct ocp_device_id *
-ocp_match_device(const struct ocp_device_id *ids, const struct ocp_device *dev)
-{
-	while (ids->vendor || ids->device) {
-		if ((ids->vendor == OCP_ANY_ID || ids->vendor == dev->vendor) &&
-		    (ids->device == OCP_ANY_ID || ids->device == dev->device))
-			return ids;
-		ids++;
-	}
-	return NULL;
-}
-
 static int
 ocp_device_probe(struct device *dev)
 {
@@ -72,15 +51,8 @@
 	ocp_dev = to_ocp_dev(dev);

 	if (drv->probe) {
-		const struct ocp_device_id *id;
-
-		id = ocp_match_device(drv->id_table, ocp_dev);
-		DBG("MATCH device-vendor:%x device:%x\n", id->vendor,
-		    id->device);
-		if (id) {
-			error = drv->probe(ocp_dev, id);
-			DBG("probe return code %d\n", error);
-		}
+		error = drv->probe(ocp_dev);
+		DBG("probe return code %d\n", error);
 		if (error >= 0) {
 			ocp_dev->driver = drv;
 			error = 0;
@@ -220,7 +192,6 @@

 postcore_initcall(ocp_driver_init);

-EXPORT_SYMBOL(ocp_match_device);
 EXPORT_SYMBOL(ocp_register_driver);
 EXPORT_SYMBOL(ocp_unregister_driver);
 EXPORT_SYMBOL(ocp_bus_type);
diff -urN linux-bluefish-old/include/linux/ocp.h linux-bluefish/include/linux/ocp.h
--- linux-bluefish-old/include/linux/ocp.h	2002-10-03 16:10:40.000000000 +1000
+++ linux-bluefish/include/linux/ocp.h	2002-10-03 16:36:32.000000000 +1000
@@ -127,7 +127,7 @@
 	struct list_head node;
 	char *name;
 	const struct ocp_device_id *id_table;	/* NULL if wants all devices */
-	int  (*probe)  (struct ocp_device *dev,const struct ocp_device_id *ent );	/* New device inserted */
+	int  (*probe)  (struct ocp_device *dev);	/* New device inserted */
 	void (*remove) (struct ocp_device *dev);	/* Device removed (NULL if not a hot-plug capable driver) */
 	int  (*save_state) (struct ocp_device *dev, u32 state);    /* Save Device Context */
 	int  (*suspend) (struct ocp_device *dev, u32 state);	/* Device suspended */


--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
