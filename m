Subject: ibmstb4 fixes
From: Andreas Oberritter <obi@saftware.de>
To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
Content-Type: multipart/mixed; boundary="=-dS+fo+9V5CGLlKB3ATJp"
Message-Id: <1074028643.1526.42.camel@shiva.eth.saftware.de>
Mime-Version: 1.0
Date: Tue, 13 Jan 2004 22:17:23 +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--=-dS+fo+9V5CGLlKB3ATJp
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Tom,

here are three trivial patches for linuxppc-2.4:
- two typo fixes for i2c and the ocp definition
- the ide driver ported to the current ocp api

Now that linuxppc_2_4_devel seems to be rather dead, would you accept a
patch that adds the smc91111 network driver to linuxppc-2.4?

What is the status of the 405 wdt driver?

Regards,
Andreas

--=-dS+fo+9V5CGLlKB3ATJp
Content-Disposition: attachment; filename=ibm_iic_typo.diff
Content-Type: text/plain; name=ibm_iic_typo.diff; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

===== drivers/i2c/i2c-ibm_iic.c 1.5 vs edited =====
--- 1.5/drivers/i2c/i2c-ibm_iic.c	Fri Jan  9 05:38:17 2004
+++ edited/drivers/i2c/i2c-ibm_iic.c	Tue Jan 13 21:36:14 2004
@@ -92,7 +92,7 @@
 #define IBM_IIC_IS_FAST(idx) ({ \
 		BUG_ON((idx) >= sizeof(bd->bi_iic_fast) / sizeof(bd->bi_iic_fast[0])); \
 		bd->bi_iic_fast[(idx)]; \
-	)}
+	})
 #endif /* IBM_IIC_IS_FAST */

 /* Enable/disable interrupt generation */

--=-dS+fo+9V5CGLlKB3ATJp
Content-Disposition: attachment; filename=ibmstb4_typo.diff
Content-Type: text/plain; name=ibmstb4_typo.diff; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

===== arch/ppc/platforms/ibmstb4.c 1.2 vs edited =====
--- 1.2/arch/ppc/platforms/ibmstb4.c	Wed Sep 24 19:16:28 2003
+++ edited/arch/ppc/platforms/ibmstb4.c	Tue Jan 13 16:37:06 2004
@@ -57,7 +57,7 @@
 	  .index	= 1,
 	  .paddr	= UART1_IO_BASE,
 	  .irq		= UART1_INT,
-	  .pm		= IBM_CPM_UART2,
+	  .pm		= IBM_CPM_UART1,
 	},
 	{ .vendor	= OCP_VENDOR_IBM,
 	  .function	= OCP_FUNC_16550,

--=-dS+fo+9V5CGLlKB3ATJp
Content-Disposition: attachment; filename=ocp_ide.diff
Content-Type: text/plain; name=ocp_ide.diff; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

===== drivers/ide/ibm_ocp_ide.c 1.1 vs edited =====
--- 1.1/drivers/ide/ibm_ocp_ide.c	Wed Mar 12 17:39:16 2003
+++ edited/drivers/ide/ibm_ocp_ide.c	Tue Jan 13 16:53:41 2004
@@ -525,14 +525,12 @@
 	return stb04xxx_ide_dma_on(drive);
 }

-static int stb04xxx_ide_dma_begin(ide_drive_t * drive, int writing)
+static int stb04xxx_ide_dma_begin(ide_drive_t * drive)
 {
 	idp->si_c0tb = (unsigned int) prd_phys;
 	idp->si_c0s0 = 0xdc800000;	/* Clear all status */
 	idp->si_c0ie = 0x90000000;	/* Enable all intr */
 	idp->si_c0dcm = 0;
-	idp->si_c0dcm =
-		(writing ? 0x09000000 : 0x01000000);
 	return 0;
 }

@@ -546,7 +544,9 @@
 	ide_set_handler(drive, &ide_dma_intr, WAIT_CMD, NULL);
 	HWIF(drive)->OUTB(writing ? WIN_WRITEDMA : WIN_READDMA,
 		 IDE_COMMAND_REG);
-	return stb04xxx_ide_dma_begin(drive, writing);
+	stb04xxx_ide_dma_begin(drive);
+	idp->si_c0dcm = (writing ? 0x09000000 : 0x01000000);
+	return 0;
 }

 static int stb04xxx_ide_dma_read(ide_drive_t * drive)
@@ -590,7 +590,7 @@
 	unsigned char *ip;
 	unsigned int uicdcr;
 	int i;
-	struct ocp_dev *ide_dev;
+	struct ocp_device *ocp;
 	int curr_ide;
 	ide_hwif_t *hwif;

@@ -605,16 +605,12 @@
 	if (data_port != 0)
 		return;
 	printk("IBM STB04xxx OCP IDE driver version %s\n", OCPVR);
-	if (!(ide_dev = ocp_alloc_dev(0)))
-		return;
-
-	ide_dev->type = IDE;
-	if ((curr_ide = ocp_register(ide_dev)) == -ENXIO) {
-		ocp_free_dev(ide_dev);
+
+	if (!(ocp = ocp_find_device(OCP_VENDOR_IBM, OCP_FUNC_IDE, OCP_ANY_INDEX))) {
 		return;
 	} else {

-		if ((idp = (ide_t *) ioremap(ide_dev->paddr,
+		if ((idp = (ide_t *) ioremap(ocp->def->paddr,
 					     IDE0_SIZE)) == NULL) {
 			printk(KERN_WARNING "ide: failed ioremap\n");
 			return;
@@ -660,7 +656,7 @@
 		hw->io_ports[IDE_CONTROL_OFFSET] = (int) (&(idp->si_c0adc));

 		if (irq)
-			*irq = ide_dev->irq;
+			*irq = ocp->def->irq;

 		pio_mode[0] = pio_mode[1] = -1;

@@ -708,6 +704,6 @@

 		memcpy(hwif->io_ports, hw->io_ports,
 		       sizeof (hw->io_ports));
-		hwif->irq = ide_dev->irq;
+		hwif->irq = ocp->def->irq;
 	}
 }

--=-dS+fo+9V5CGLlKB3ATJp--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
