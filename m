Subject: [PATCH] Adding support for LXT971/2 PHYs
To: dan@netx4.com (Dan Malek)
Date: Thu, 4 May 2000 17:01:44 +1000 (EST)
Cc: linuxppc-embedded@lists.linuxppc.org (LinuxPPC Embedded Mailing List)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000504070144.BD6A53C972@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Dan & friends,

The following patch to the Fast Ethernet Controller driver adds support for
the LXT971 and LXT972 PHYs, which have a slightly diffent programming
interface to the LXT970, Thank you Level One. The LXT model number is
autodetected and we've tested the result on an LXT972.

I've also taken the liberty of moving the PHY interrupt definition out so it
can be placed in each board's 'board.h' file, allowing me to replace one of
the #ifdef CONFIG_FADS with a more generic PHY_INTERRUPT definition. This
makes it easier to add new board types which use different interrupt
assignments without a maze of #ifdefs and I think is a good general direction
to take in the 8xx drivers.

I'm pretty sure that the "This version of the driver is specific to the
FADS..." comment in the header is old and incorrect, but I wasn't sure what
it should say about the FADS, so I've left it alone for now.

Comments welcome!

Index: include/asm-ppc/fads.h
===================================================================
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 fads.h
--- include/asm-ppc/fads.h	1999/12/30 06:00:31	1.1.1.1
+++ include/asm-ppc/fads.h	2000/05/03 04:34:14
@@ -36,4 +36,6 @@
 #define PCMCIA_MEM_ADDR		((uint)0x04000000)
 #define PCMCIA_MEM_SIZE		((uint)(64 * 1024))

+#define PHY_INTERRUPT	SIU_IRQ2
+
 #endif
Index: arch/ppc/8xx_io/fec.c
===================================================================
retrieving revision 1.1.1.2
retrieving revision 1.9
diff -u -r1.1.1.2 -r1.9
--- arch/ppc/8xx_io/fec.c	2000/03/10 01:11:06	1.1.1.2
+++ arch/ppc/8xx_io/fec.c	2000/05/04 06:48:35	1.9
@@ -2,6 +2,8 @@
  * Fast Ethernet Controller (FEC) driver for Motorola MPC8xx.
  * Copyright (c) 1997 Dan Malek (dmalek@jlc.net)
  *
+ * Includes support for the following PHYs: QS6612, LXT970, LXT971/2.
+ *
  * This version of the driver is specific to the FADS implementation,
  * since the board contains control registers external to the processor
  * for the control of the LevelOne LXT970 transceiver.  The MPC860T manual
@@ -16,6 +18,7 @@
  * small packets.
  *
  */
+#include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/string.h>
@@ -139,8 +142,23 @@

 static	int	phyaddr;
 static	uint	phytype;
+static  int	lxt970;    /* == 1 if model LXT970, == 0 otherwise. */
+
+/* Level One, in their infinite wisdom, have changed the locations
+   of some of the important bits in the registers of the LXT9xx series.
+   Thanks guys. */
+
+#define CHIP_STATUS_REG		(lxt970 ? 20 : 17)
+#define CHIP_STATUS_SPEED	(lxt970 ? 0x0800 : 0x4000)
+#define CHIP_STATUS_DUPLEX	(lxt970 ? 0x1000 : 0x0200)
+#define INTERRUPT_STATUS_REG	(lxt970 ? 18 : 19)
+#define INTERRUPT_PENDING	(lxt970 ? 0x8000 : 0x0004)
+#define INTERRUPT_ENABLE_REG	(lxt970 ? 17 : 18)
+#define INTERRUPT_ENABLE_VAL	(lxt970 ? 0x0002 : 0x0032)
+#define CONFIG_REG		(lxt970 ? 19 : 16)

 static int	mii_queue(int request, void (*func)(uint, struct device *));
+static void	mii_startup_cmds(void);

 /* Make MII read/write commands for the FEC.
 */
@@ -606,17 +624,17 @@
 			printk(",auto complete");
 		printk("\n");
 	}
-	if (((mii_reg >> 18) & 0x1f) == 0x14) {
+	if (((mii_reg >> 18) & 0x1f) == CHIP_STATUS_REG) {
 		/* Extended chip status register.
 		*/
 		prev_duplex = full_duplex;
 		printk("fec: ");
-		if (mii_reg & 0x0800)
+		if (mii_reg & CHIP_STATUS_SPEED)
 			printk("100 Mbps");
 		else
 			printk("10 Mbps");

-		if (mii_reg & 0x1000) {
+		if (mii_reg & CHIP_STATUS_DUPLEX) {
 			printk(", Full-Duplex\n");
 			full_duplex = 1;
 		}
@@ -663,14 +681,19 @@
 	phytype <<= 16;
 	phytype |= (mii_reg & 0xffff);
 	printk("fec: Phy @ 0x%x, type 0x%08x\n", phyno, phytype);
+
+        /* Strictly speaking we should test the whole of phytype,
+         * but there is confusion about exactly what is in the
+         * OUI part of the Identification registers.
+	 */
+        lxt970 = ((mii_reg & 0xfffc) == 0);
+
 	mii_startup_cmds();
 }

 static void
 mii_discover_phy(uint mii_reg, struct device *dev)
 {
-	volatile uint	prev_duplex;
-
 	if (phyno < 32) {
 		if ((phytype = (mii_reg & 0xffff)) != 0xffff) {
 			phyaddr = phyno;
@@ -729,20 +752,20 @@
 	/* Read status registers to clear any pending interrupt.
 	*/
 	mii_queue(mk_mii_read(1), mii_status);
-	mii_queue(mk_mii_read(18), mii_status);
+	mii_queue(mk_mii_read(INTERRUPT_STATUS_REG), mii_status);

 	/* Read extended chip status register.
 	*/
-	mii_queue(mk_mii_read(0x14), mii_status);
+	mii_queue(mk_mii_read(CHIP_STATUS_REG), mii_status);

 	/* Set default operation of 100-TX....for some reason
 	 * some of these bits are set on power up, which is wrong.
 	 */
-	mii_queue(mk_mii_write(0x13, 0), NULL);
+	mii_queue(mk_mii_write(CONFIG_REG, 0), NULL);

 	/* Enable Link status change interrupts.
 	*/
-	mii_queue(mk_mii_write(0x11, 0x0002), NULL);
+	mii_queue(mk_mii_write(INTERRUPT_ENABLE_REG, INTERRUPT_ENABLE_VAL), NULL);

 	/* Don't advertize Full duplex.
 	mii_queue(mk_mii_write(0x04, 0x0021), NULL);
@@ -753,7 +776,7 @@

 /* This supports the mii_link interrupt below.
  * We should get called three times.  Once for register 1, once for
- * register 18, and once for register 20.
+ * register INTERRUPT_STATUS_REG, and once for register CHIP_STATUS_REG.
  */
 static	uint mii_saved_reg1;

@@ -769,16 +792,16 @@
 		mii_saved_reg1 = mii_reg;
 		return;
 	}
-	if (((mii_reg >> 18) & 0x1f) == 18) {
+	if (((mii_reg >> 18) & 0x1f) == INTERRUPT_STATUS_REG) {
 		/* Not much here, but has to be read to clear the
 		 * interrupt condition.
 		 */
-		if ((mii_reg & 0x8000) == 0)
+		if ((mii_reg & INTERRUPT_PENDING) == 0)
 			printk("fec: re-link and no IRQ?\n");
-		if ((mii_reg & 0x4000) == 0)
+		if (lxt970 && ((mii_reg & 0x4000) == 0))
 			printk("fec: no PHY power?\n");
 	}
-	if (((mii_reg >> 18) & 0x1f) == 20) {
+	if (((mii_reg >> 18) & 0x1f) == CHIP_STATUS_REG) {
 		/* Extended chip status register.
 		 * OK, now we have it all, so figure out what is going on.
 		 */
@@ -794,12 +817,12 @@
 		if (mii_saved_reg1 & 0x0020)
 			printk(", auto complete");

-		if (mii_reg & 0x0800)
+		if (mii_reg & CHIP_STATUS_SPEED)
 			printk(", 100 Mbps");
 		else
 			printk(", 10 Mbps");

-		if (mii_reg & 0x1000) {
+		if (mii_reg & CHIP_STATUS_DUPLEX) {
 			printk(", Full-Duplex\n");
 			full_duplex = 1;
 		}
@@ -871,11 +894,11 @@
 	fep = (struct fec_enet_private *)dev->priv;
 	ep = &(((immap_t *)IMAP_ADDR)->im_cpm.cp_fec);

-	/* We need to sequentially read registers 1 and 18 to clear
+	/* We need to sequentially read registers 1 and INTERRUPT_STATUS_REG to clear
 	 * the interrupt.  We don't need to do that here because this
 	 * is an edge triggered interrupt that has already been acknowledged
 	 * by the top level handler.  We also read the extended status
-	 * register 20.  We just queue the commands and let them happen
+	 * register CHIP_STATUS_REG.  We just queue the commands and let them happen
 	 * as part of the "normal" processing.
 	 */
 #ifdef CONFIG_RPXCLASSIC
@@ -884,8 +907,8 @@
 	mii_queue(mk_mii_read(31), mii_relink);
 #else
 	mii_queue(mk_mii_read(1), mii_relink);
-	mii_queue(mk_mii_read(18), mii_relink);
-	mii_queue(mk_mii_read(20), mii_relink);
+	mii_queue(mk_mii_read(INTERRUPT_STATUS_REG), mii_relink);
+	mii_queue(mk_mii_read(CHIP_STATUS_REG), mii_relink);
 #endif

 }
@@ -1111,9 +1134,8 @@
 	immap->im_ioport.iop_pcso &= ~0x0001;
 	immap->im_ioport.iop_pcint |= 0x0001;
 	cpm_install_handler(CPMVEC_PIO_PC15, mii_link_interrupt, dev);
-#endif
-#ifdef CONFIG_FADS
-	if (request_8xxirq(SIU_IRQ2, mii_link_interrupt, 0, "mii", dev) != 0)
+#elif defined (PHY_INTERRUPT)
+	if (request_8xxirq(PHY_INTERRUPT, mii_link_interrupt, 0, "mii", dev) != 0)
 		panic("Could not allocate MII IRQ!");
 #endif

@@ -1154,7 +1176,7 @@
 	volatile	cbd_t	*bdp;
 	volatile	immap_t	*immap;
 	volatile	fec_t	*fecp;
-	extern		uint	_get_IMMR();
+	extern		uint	_get_IMMR(void);

 	immap = (immap_t *)IMAP_ADDR;	/* pointer to internal registers */

--
Graham Stoney
Principal Hardware/Software Engineer
Canon Information Systems Research Australia
Ph: +61 2 9805 2909  Fax: +61 2 9805 2929

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
