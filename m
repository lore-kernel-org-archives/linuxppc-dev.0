Return-Path: <akpm@osdl.org>
Message-Id: <200510290046.j9T0krpC030023@shell0.pdx.osdl.net>
To: paulus@samba.org
From: akpm@osdl.org
Date: Fri, 28 Oct 2005 17:46:22 -0700
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org
Subject: [patch 12/43] New PowerPC 4xx on-chip ethernet controller driver
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


From: Eugene Surovegin <ebs@ebshome.net>

This patch replaces current PowerPC 4xx EMAC driver with new, re-written
from the scratch version.  This patch is quite big (~234K) because there is
virtualy 0% of common code between old and new version.

New driver uses NAPI, it solves stability problems under heavy packet load
and low memory, corrects chip register access and fixes numerous small bugs
I don't even remember now.

This patch has been tested on all supported in 2.6 PPC 4xx boards.  It's
been used in production for almost a year now on custom 4xx hardware. 
PPC32 specific parts are already upstream.

Patch was acked by the current EMAC driver maintainer (Matt Porter). I
will be maintaining this new version.

Signed-off-by: Eugene Surovegin <ebs@ebshome.net>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/net/Kconfig                   |   72 
 drivers/net/ibm_emac/Makefile         |   11 
 drivers/net/ibm_emac/ibm_emac.h       |  418 ++--
 drivers/net/ibm_emac/ibm_emac_core.c  | 3414 ++++++++++++++++++----------------
 drivers/net/ibm_emac/ibm_emac_core.h  |  313 +--
 drivers/net/ibm_emac/ibm_emac_debug.c |  377 +--
 drivers/net/ibm_emac/ibm_emac_debug.h |   63 
 drivers/net/ibm_emac/ibm_emac_mal.c   |  674 +++---
 drivers/net/ibm_emac/ibm_emac_mal.h   |  336 ++-
 drivers/net/ibm_emac/ibm_emac_phy.c   |  335 +--
 drivers/net/ibm_emac/ibm_emac_phy.h   |  105 -
 drivers/net/ibm_emac/ibm_emac_rgmii.c |  201 ++
 drivers/net/ibm_emac/ibm_emac_rgmii.h |   68 
 drivers/net/ibm_emac/ibm_emac_tah.c   |  111 +
 drivers/net/ibm_emac/ibm_emac_tah.h   |   96 
 drivers/net/ibm_emac/ibm_emac_zmii.c  |  255 ++
 drivers/net/ibm_emac/ibm_emac_zmii.h  |  114 -
 17 files changed, 4113 insertions(+), 2850 deletions(-)

diff -puN drivers/net/ibm_emac/ibm_emac_core.c~new-powerpc-4xx-on-chip-ethernet-controller-driver drivers/net/ibm_emac/ibm_emac_core.c
--- devel/drivers/net/ibm_emac/ibm_emac_core.c~new-powerpc-4xx-on-chip-ethernet-controller-driver	2005-10-28 17:44:03.000000000 -0700
+++ devel-akpm/drivers/net/ibm_emac/ibm_emac_core.c	2005-10-28 17:44:03.000000000 -0700
@@ -1,13 +1,14 @@
 /*
- * ibm_emac_core.c
+ * drivers/net/ibm_emac/ibm_emac_core.c
  *
- * Ethernet driver for the built in ethernet on the IBM 4xx PowerPC
- * processors.
- * 
- * (c) 2003 Benjamin Herrenschmidt <benh@kernel.crashing.org>
+ * Driver for PowerPC 4xx on-chip ethernet controller.
  *
- * Based on original work by
+ * Copyright (c) 2004, 2005 Zultys Technologies.
+ * Eugene Surovegin <eugene.surovegin@zultys.com> or <ebs@ebshome.net>
  *
+ * Based on original work by
+ * 	Matt Porter <mporter@kernel.crashing.org>
+ *	(c) 2003 Benjamin Herrenschmidt <benh@kernel.crashing.org>
  *      Armin Kuster <akuster@mvista.com>
  * 	Johnnie Peters <jpeters@mvista.com>
  *
@@ -15,29 +16,24 @@
  * under  the terms of  the GNU General  Public License as published by the
  * Free Software Foundation;  either version 2 of the  License, or (at your
  * option) any later version.
- * TODO
- *       - Check for races in the "remove" code path
- *       - Add some Power Management to the MAC and the PHY
- *       - Audit remaining of non-rewritten code (--BenH)
- *       - Cleanup message display using msglevel mecanism
- *       - Address all errata
- *       - Audit all register update paths to ensure they
- *         are being written post soft reset if required.
+ *
  */
+
+#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/string.h>
-#include <linux/timer.h>
-#include <linux/ptrace.h>
 #include <linux/errno.h>
-#include <linux/ioport.h>
-#include <linux/slab.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/types.h>
-#include <linux/dma-mapping.h>
+#include <linux/pci.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <linux/skbuff.h>
+#include <linux/crc32.h>
 #include <linux/ethtool.h>
 #include <linux/mii.h>
 #include <linux/bitops.h>
@@ -45,1691 +41,1893 @@
 #include <asm/processor.h>
 #include <asm/io.h>
 #include <asm/dma.h>
-#include <asm/irq.h>
 #include <asm/uaccess.h>
 #include <asm/ocp.h>
 
-#include <linux/netdevice.h>
-#include <linux/etherdevice.h>
-#include <linux/skbuff.h>
-#include <linux/crc32.h>
-
 #include "ibm_emac_core.h"
-
-//#define MDIO_DEBUG(fmt) printk fmt
-#define MDIO_DEBUG(fmt)
-
-//#define LINK_DEBUG(fmt) printk fmt
-#define LINK_DEBUG(fmt)
-
-//#define PKT_DEBUG(fmt) printk fmt
-#define PKT_DEBUG(fmt)
-
-#define DRV_NAME        "emac"
-#define DRV_VERSION     "2.0"
-#define DRV_AUTHOR      "Benjamin Herrenschmidt <benh@kernel.crashing.org>"
-#define DRV_DESC        "IBM EMAC Ethernet driver"
+#include "ibm_emac_debug.h"
 
 /*
- * When mdio_idx >= 0, contains a list of emac ocp_devs
- * that have had their initialization deferred until the
- * common MDIO controller has been initialized.
+ * Lack of dma_unmap_???? calls is intentional.
+ *
+ * API-correct usage requires additional support state information to be
+ * maintained for every RX and TX buffer descriptor (BD). Unfortunately, due to
+ * EMAC design (e.g. TX buffer passed from network stack can be split into
+ * several BDs, dma_map_single/dma_map_page can be used to map particular BD),
+ * maintaining such information will add additional overhead.
+ * Current DMA API implementation for 4xx processors only ensures cache coherency
+ * and dma_unmap_???? routines are empty and are likely to stay this way.
+ * I decided to omit dma_unmap_??? calls because I don't want to add additional
+ * complexity just for the sake of following some abstract API, when it doesn't
+ * add any real benefit to the driver. I understand that this decision maybe
+ * controversial, but I really tried to make code API-correct and efficient
+ * at the same time and didn't come up with code I liked :(.                --ebs
  */
-LIST_HEAD(emac_init_list);
 
-MODULE_AUTHOR(DRV_AUTHOR);
+#define DRV_NAME        "emac"
+#define DRV_VERSION     "3.53"
+#define DRV_DESC        "PPC 4xx OCP EMAC driver"
+
 MODULE_DESCRIPTION(DRV_DESC);
+MODULE_AUTHOR
+    ("Eugene Surovegin <eugene.surovegin@zultys.com> or <ebs@ebshome.net>");
 MODULE_LICENSE("GPL");
 
-static int skb_res = SKB_RES;
-module_param(skb_res, int, 0444);
-MODULE_PARM_DESC(skb_res, "Amount of data to reserve on skb buffs\n"
-		 "The 405 handles a misaligned IP header fine but\n"
-		 "this can help if you are routing to a tunnel or a\n"
-		 "device that needs aligned data. 0..2");
-
-#define RGMII_PRIV(ocpdev) ((struct ibm_ocp_rgmii*)ocp_get_drvdata(ocpdev))
-
-static unsigned int rgmii_enable[] = {
-	RGMII_RTBI,
-	RGMII_RGMII,
-	RGMII_TBI,
-	RGMII_GMII
-};
+/* minimum number of free TX descriptors required to wake up TX process */
+#define EMAC_TX_WAKEUP_THRESH		(NUM_TX_BUFF / 4)
 
-static unsigned int rgmii_speed_mask[] = {
-	RGMII_MII2_SPDMASK,
-	RGMII_MII3_SPDMASK
-};
-
-static unsigned int rgmii_speed100[] = {
-	RGMII_MII2_100MB,
-	RGMII_MII3_100MB
-};
-
-static unsigned int rgmii_speed1000[] = {
-	RGMII_MII2_1000MB,
-	RGMII_MII3_1000MB
-};
-
-#define ZMII_PRIV(ocpdev) ((struct ibm_ocp_zmii*)ocp_get_drvdata(ocpdev))
-
-static unsigned int zmii_enable[][4] = {
-	{ZMII_SMII0, ZMII_RMII0, ZMII_MII0,
-	 ~(ZMII_MDI1 | ZMII_MDI2 | ZMII_MDI3)},
-	{ZMII_SMII1, ZMII_RMII1, ZMII_MII1,
-	 ~(ZMII_MDI0 | ZMII_MDI2 | ZMII_MDI3)},
-	{ZMII_SMII2, ZMII_RMII2, ZMII_MII2,
-	 ~(ZMII_MDI0 | ZMII_MDI1 | ZMII_MDI3)},
-	{ZMII_SMII3, ZMII_RMII3, ZMII_MII3, ~(ZMII_MDI0 | ZMII_MDI1 | ZMII_MDI2)}
-};
-
-static unsigned int mdi_enable[] = {
-	ZMII_MDI0,
-	ZMII_MDI1,
-	ZMII_MDI2,
-	ZMII_MDI3
-};
-
-static unsigned int zmii_speed = 0x0;
-static unsigned int zmii_speed100[] = {
-	ZMII_MII0_100MB,
-	ZMII_MII1_100MB,
-	ZMII_MII2_100MB,
-	ZMII_MII3_100MB
-};
+/* If packet size is less than this number, we allocate small skb and copy packet
+ * contents into it instead of just sending original big skb up
+ */
+#define EMAC_RX_COPY_THRESH		CONFIG_IBM_EMAC_RX_COPY_THRESHOLD
 
 /* Since multiple EMACs share MDIO lines in various ways, we need
  * to avoid re-using the same PHY ID in cases where the arch didn't
  * setup precise phy_map entries
  */
-static u32 busy_phy_map = 0;
+static u32 busy_phy_map;
 
-/* If EMACs share a common MDIO device, this points to it */
-static struct net_device *mdio_ndev = NULL;
-
-struct emac_def_dev {
-	struct list_head link;
-	struct ocp_device *ocpdev;
-	struct ibm_ocp_mal *mal;
-};
-
-static struct net_device_stats *emac_stats(struct net_device *dev)
-{
-	struct ocp_enet_private *fep = dev->priv;
-	return &fep->stats;
-};
-
-static int
-emac_init_rgmii(struct ocp_device *rgmii_dev, int input, int phy_mode)
+#if defined(CONFIG_IBM_EMAC_PHY_RX_CLK_FIX) && (defined(CONFIG_405EP) || defined(CONFIG_440EP))
+/* 405EP has "EMAC to PHY Control Register" (CPC0_EPCTL) which can help us
+ * with PHY RX clock problem.
+ * 440EP has more sane SDR0_MFR register implementation than 440GX, which
+ * also allows controlling each EMAC clock
+ */
+static inline void EMAC_RX_CLK_TX(int idx)
 {
-	struct ibm_ocp_rgmii *rgmii = RGMII_PRIV(rgmii_dev);
-	const char *mode_name[] = { "RTBI", "RGMII", "TBI", "GMII" };
-	int mode = -1;
+	unsigned long flags;
+	local_irq_save(flags);
 
-	if (!rgmii) {
-		rgmii = kmalloc(sizeof(struct ibm_ocp_rgmii), GFP_KERNEL);
+#if defined(CONFIG_405EP)
+	mtdcr(0xf3, mfdcr(0xf3) | (1 << idx));
+#else /* CONFIG_440EP */
+	SDR_WRITE(DCRN_SDR_MFR, SDR_READ(DCRN_SDR_MFR) | (0x08000000 >> idx));
+#endif
 
-		if (rgmii == NULL) {
-			printk(KERN_ERR
-			       "rgmii%d: Out of memory allocating RGMII structure!\n",
-			       rgmii_dev->def->index);
-			return -ENOMEM;
-		}
+	local_irq_restore(flags);
+}
 
-		memset(rgmii, 0, sizeof(*rgmii));
+static inline void EMAC_RX_CLK_DEFAULT(int idx)
+{
+	unsigned long flags;
+	local_irq_save(flags);
 
-		rgmii->base =
-		    (struct rgmii_regs *)ioremap(rgmii_dev->def->paddr,
-						 sizeof(*rgmii->base));
-		if (rgmii->base == NULL) {
-			printk(KERN_ERR
-			       "rgmii%d: Cannot ioremap bridge registers!\n",
-			       rgmii_dev->def->index);
+#if defined(CONFIG_405EP)
+	mtdcr(0xf3, mfdcr(0xf3) & ~(1 << idx));
+#else /* CONFIG_440EP */
+	SDR_WRITE(DCRN_SDR_MFR, SDR_READ(DCRN_SDR_MFR) & ~(0x08000000 >> idx));
+#endif
 
-			kfree(rgmii);
-			return -ENOMEM;
-		}
-		ocp_set_drvdata(rgmii_dev, rgmii);
-	}
+	local_irq_restore(flags);
+}
+#else
+#define EMAC_RX_CLK_TX(idx)		((void)0)
+#define EMAC_RX_CLK_DEFAULT(idx)	((void)0)
+#endif
 
-	if (phy_mode) {
-		switch (phy_mode) {
-		case PHY_MODE_GMII:
-			mode = GMII;
-			break;
-		case PHY_MODE_TBI:
-			mode = TBI;
-			break;
-		case PHY_MODE_RTBI:
-			mode = RTBI;
-			break;
-		case PHY_MODE_RGMII:
-		default:
-			mode = RGMII;
-		}
-		rgmii->base->fer &= ~RGMII_FER_MASK(input);
-		rgmii->base->fer |= rgmii_enable[mode] << (4 * input);
-	} else {
-		switch ((rgmii->base->fer & RGMII_FER_MASK(input)) >> (4 *
-								       input)) {
-		case RGMII_RTBI:
-			mode = RTBI;
-			break;
-		case RGMII_RGMII:
-			mode = RGMII;
-			break;
-		case RGMII_TBI:
-			mode = TBI;
-			break;
-		case RGMII_GMII:
-			mode = GMII;
-		}
-	}
+#if defined(CONFIG_IBM_EMAC_PHY_RX_CLK_FIX) && defined(CONFIG_440GX)
+/* We can switch Ethernet clock to the internal source through SDR0_MFR[ECS],
+ * unfortunately this is less flexible than 440EP case, because it's a global
+ * setting for all EMACs, therefore we do this clock trick only during probe.
+ */
+#define EMAC_CLK_INTERNAL		SDR_WRITE(DCRN_SDR_MFR, \
+					    SDR_READ(DCRN_SDR_MFR) | 0x08000000)
+#define EMAC_CLK_EXTERNAL		SDR_WRITE(DCRN_SDR_MFR, \
+					    SDR_READ(DCRN_SDR_MFR) & ~0x08000000)
+#else
+#define EMAC_CLK_INTERNAL		((void)0)
+#define EMAC_CLK_EXTERNAL		((void)0)
+#endif
 
-	/* Set mode to RGMII if nothing valid is detected */
-	if (mode < 0)
-		mode = RGMII;
+/* I don't want to litter system log with timeout errors
+ * when we have brain-damaged PHY.
+ */
+static inline void emac_report_timeout_error(struct ocp_enet_private *dev,
+					     const char *error)
+{
+#if defined(CONFIG_IBM_EMAC_PHY_RX_CLK_FIX)
+	DBG("%d: %s" NL, dev->def->index, error);
+#else
+	if (net_ratelimit())
+		printk(KERN_ERR "emac%d: %s\n", dev->def->index, error);
+#endif
+}
 
-	printk(KERN_NOTICE "rgmii%d: input %d in %s mode\n",
-	       rgmii_dev->def->index, input, mode_name[mode]);
+/* PHY polling intervals */
+#define PHY_POLL_LINK_ON	HZ
+#define PHY_POLL_LINK_OFF	(HZ / 5)
+
+/* Please, keep in sync with struct ibm_emac_stats/ibm_emac_error_stats */
+static const char emac_stats_keys[EMAC_ETHTOOL_STATS_COUNT][ETH_GSTRING_LEN] = {
+	"rx_packets", "rx_bytes", "tx_packets", "tx_bytes", "rx_packets_csum",
+	"tx_packets_csum", "tx_undo", "rx_dropped_stack", "rx_dropped_oom",
+	"rx_dropped_error", "rx_dropped_resize", "rx_dropped_mtu",
+	"rx_stopped", "rx_bd_errors", "rx_bd_overrun", "rx_bd_bad_packet",
+	"rx_bd_runt_packet", "rx_bd_short_event", "rx_bd_alignment_error",
+	"rx_bd_bad_fcs", "rx_bd_packet_too_long", "rx_bd_out_of_range",
+	"rx_bd_in_range", "rx_parity", "rx_fifo_overrun", "rx_overrun",
+	"rx_bad_packet", "rx_runt_packet", "rx_short_event",
+	"rx_alignment_error", "rx_bad_fcs", "rx_packet_too_long",
+	"rx_out_of_range", "rx_in_range", "tx_dropped", "tx_bd_errors",
+	"tx_bd_bad_fcs", "tx_bd_carrier_loss", "tx_bd_excessive_deferral",
+	"tx_bd_excessive_collisions", "tx_bd_late_collision",
+	"tx_bd_multple_collisions", "tx_bd_single_collision",
+	"tx_bd_underrun", "tx_bd_sqe", "tx_parity", "tx_underrun", "tx_sqe",
+	"tx_errors"
+};
 
-	rgmii->mode[input] = mode;
-	rgmii->users++;
+static irqreturn_t emac_irq(int irq, void *dev_instance, struct pt_regs *regs);
+static void emac_clean_tx_ring(struct ocp_enet_private *dev);
 
-	return 0;
+static inline int emac_phy_supports_gige(int phy_mode)
+{
+	return  phy_mode == PHY_MODE_GMII ||
+		phy_mode == PHY_MODE_RGMII ||
+		phy_mode == PHY_MODE_TBI ||
+		phy_mode == PHY_MODE_RTBI;
 }
 
-static void
-emac_rgmii_port_speed(struct ocp_device *ocpdev, int input, int speed)
+static inline int emac_phy_gpcs(int phy_mode)
 {
-	struct ibm_ocp_rgmii *rgmii = RGMII_PRIV(ocpdev);
-	unsigned int rgmii_speed;
+	return  phy_mode == PHY_MODE_TBI ||
+		phy_mode == PHY_MODE_RTBI;
+}
 
-	rgmii_speed = in_be32(&rgmii->base->ssr);
+static inline void emac_tx_enable(struct ocp_enet_private *dev)
+{
+	struct emac_regs *p = dev->emacp;
+	unsigned long flags;
+	u32 r;
 
-	rgmii_speed &= ~rgmii_speed_mask[input];
+	local_irq_save(flags);
 
-	if (speed == 1000)
-		rgmii_speed |= rgmii_speed1000[input];
-	else if (speed == 100)
-		rgmii_speed |= rgmii_speed100[input];
+	DBG("%d: tx_enable" NL, dev->def->index);
 
-	out_be32(&rgmii->base->ssr, rgmii_speed);
+	r = in_be32(&p->mr0);
+	if (!(r & EMAC_MR0_TXE))
+		out_be32(&p->mr0, r | EMAC_MR0_TXE);
+	local_irq_restore(flags);
 }
 
-static void emac_close_rgmii(struct ocp_device *ocpdev)
+static void emac_tx_disable(struct ocp_enet_private *dev)
 {
-	struct ibm_ocp_rgmii *rgmii = RGMII_PRIV(ocpdev);
-	BUG_ON(!rgmii || rgmii->users == 0);
+	struct emac_regs *p = dev->emacp;
+	unsigned long flags;
+	u32 r;
+
+	local_irq_save(flags);
 
-	if (!--rgmii->users) {
-		ocp_set_drvdata(ocpdev, NULL);
-		iounmap((void *)rgmii->base);
-		kfree(rgmii);
+	DBG("%d: tx_disable" NL, dev->def->index);
+
+	r = in_be32(&p->mr0);
+	if (r & EMAC_MR0_TXE) {
+		int n = 300;
+		out_be32(&p->mr0, r & ~EMAC_MR0_TXE);
+		while (!(in_be32(&p->mr0) & EMAC_MR0_TXI) && n)
+			--n;
+		if (unlikely(!n))
+			emac_report_timeout_error(dev, "TX disable timeout");
 	}
+	local_irq_restore(flags);
 }
 
-static int emac_init_zmii(struct ocp_device *zmii_dev, int input, int phy_mode)
+static void emac_rx_enable(struct ocp_enet_private *dev)
 {
-	struct ibm_ocp_zmii *zmii = ZMII_PRIV(zmii_dev);
-	const char *mode_name[] = { "SMII", "RMII", "MII" };
-	int mode = -1;
+	struct emac_regs *p = dev->emacp;
+	unsigned long flags;
+	u32 r;
 
-	if (!zmii) {
-		zmii = kmalloc(sizeof(struct ibm_ocp_zmii), GFP_KERNEL);
-		if (zmii == NULL) {
-			printk(KERN_ERR
-			       "zmii%d: Out of memory allocating ZMII structure!\n",
-			       zmii_dev->def->index);
-			return -ENOMEM;
-		}
-		memset(zmii, 0, sizeof(*zmii));
-
-		zmii->base =
-		    (struct zmii_regs *)ioremap(zmii_dev->def->paddr,
-						sizeof(*zmii->base));
-		if (zmii->base == NULL) {
-			printk(KERN_ERR
-			       "zmii%d: Cannot ioremap bridge registers!\n",
-			       zmii_dev->def->index);
+	local_irq_save(flags);
+	if (unlikely(dev->commac.rx_stopped))
+		goto out;
 
-			kfree(zmii);
-			return -ENOMEM;
-		}
-		ocp_set_drvdata(zmii_dev, zmii);
-	}
+	DBG("%d: rx_enable" NL, dev->def->index);
 
-	if (phy_mode) {
-		switch (phy_mode) {
-		case PHY_MODE_MII:
-			mode = MII;
-			break;
-		case PHY_MODE_RMII:
-			mode = RMII;
-			break;
-		case PHY_MODE_SMII:
-		default:
-			mode = SMII;
-		}
-		zmii->base->fer &= ~ZMII_FER_MASK(input);
-		zmii->base->fer |= zmii_enable[input][mode];
-	} else {
-		switch ((zmii->base->fer & ZMII_FER_MASK(input)) << (4 * input)) {
-		case ZMII_MII0:
-			mode = MII;
-			break;
-		case ZMII_RMII0:
-			mode = RMII;
-			break;
-		case ZMII_SMII0:
-			mode = SMII;
+	r = in_be32(&p->mr0);
+	if (!(r & EMAC_MR0_RXE)) {
+		if (unlikely(!(r & EMAC_MR0_RXI))) {
+			/* Wait if previous async disable is still in progress */
+			int n = 100;
+			while (!(r = in_be32(&p->mr0) & EMAC_MR0_RXI) && n)
+				--n;
+			if (unlikely(!n))
+				emac_report_timeout_error(dev,
+							  "RX disable timeout");
 		}
+		out_be32(&p->mr0, r | EMAC_MR0_RXE);
 	}
-
-	/* Set mode to SMII if nothing valid is detected */
-	if (mode < 0)
-		mode = SMII;
-
-	printk(KERN_NOTICE "zmii%d: input %d in %s mode\n",
-	       zmii_dev->def->index, input, mode_name[mode]);
-
-	zmii->mode[input] = mode;
-	zmii->users++;
-
-	return 0;
+      out:
+	local_irq_restore(flags);
 }
 
-static void emac_enable_zmii_port(struct ocp_device *ocpdev, int input)
+static void emac_rx_disable(struct ocp_enet_private *dev)
 {
-	u32 mask;
-	struct ibm_ocp_zmii *zmii = ZMII_PRIV(ocpdev);
-
-	mask = in_be32(&zmii->base->fer);
-	mask &= zmii_enable[input][MDI];	/* turn all non enabled MDI's off */
-	mask |= zmii_enable[input][zmii->mode[input]] | mdi_enable[input];
-	out_be32(&zmii->base->fer, mask);
-}
+	struct emac_regs *p = dev->emacp;
+	unsigned long flags;
+	u32 r;
 
-static void
-emac_zmii_port_speed(struct ocp_device *ocpdev, int input, int speed)
-{
-	struct ibm_ocp_zmii *zmii = ZMII_PRIV(ocpdev);
+	local_irq_save(flags);
 
-	if (speed == 100)
-		zmii_speed |= zmii_speed100[input];
-	else
-		zmii_speed &= ~zmii_speed100[input];
+	DBG("%d: rx_disable" NL, dev->def->index);
 
-	out_be32(&zmii->base->ssr, zmii_speed);
+	r = in_be32(&p->mr0);
+	if (r & EMAC_MR0_RXE) {
+		int n = 300;
+		out_be32(&p->mr0, r & ~EMAC_MR0_RXE);
+		while (!(in_be32(&p->mr0) & EMAC_MR0_RXI) && n)
+			--n;
+		if (unlikely(!n))
+			emac_report_timeout_error(dev, "RX disable timeout");
+	}
+	local_irq_restore(flags);
 }
 
-static void emac_close_zmii(struct ocp_device *ocpdev)
+static inline void emac_rx_disable_async(struct ocp_enet_private *dev)
 {
-	struct ibm_ocp_zmii *zmii = ZMII_PRIV(ocpdev);
-	BUG_ON(!zmii || zmii->users == 0);
+	struct emac_regs *p = dev->emacp;
+	unsigned long flags;
+	u32 r;
 
-	if (!--zmii->users) {
-		ocp_set_drvdata(ocpdev, NULL);
-		iounmap((void *)zmii->base);
-		kfree(zmii);
-	}
+	local_irq_save(flags);
+
+	DBG("%d: rx_disable_async" NL, dev->def->index);
+
+	r = in_be32(&p->mr0);
+	if (r & EMAC_MR0_RXE)
+		out_be32(&p->mr0, r & ~EMAC_MR0_RXE);
+	local_irq_restore(flags);
 }
 
-int emac_phy_read(struct net_device *dev, int mii_id, int reg)
+static int emac_reset(struct ocp_enet_private *dev)
 {
-	int count;
-	uint32_t stacr;
-	struct ocp_enet_private *fep = dev->priv;
-	emac_t *emacp = fep->emacp;
+	struct emac_regs *p = dev->emacp;
+	unsigned long flags;
+	int n = 20;
 
-	MDIO_DEBUG(("%s: phy_read, id: 0x%x, reg: 0x%x\n", dev->name, mii_id,
-		    reg));
+	DBG("%d: reset" NL, dev->def->index);
 
-	/* Enable proper ZMII port */
-	if (fep->zmii_dev)
-		emac_enable_zmii_port(fep->zmii_dev, fep->zmii_input);
+	local_irq_save(flags);
 
-	/* Use the EMAC that has the MDIO port */
-	if (fep->mdio_dev) {
-		dev = fep->mdio_dev;
-		fep = dev->priv;
-		emacp = fep->emacp;
+	if (!dev->reset_failed) {
+		/* 40x erratum suggests stopping RX channel before reset,
+		 * we stop TX as well
+		 */
+		emac_rx_disable(dev);
+		emac_tx_disable(dev);
 	}
 
-	count = 0;
-	while ((((stacr = in_be32(&emacp->em0stacr)) & EMAC_STACR_OC) == 0)
-					&& (count++ < MDIO_DELAY))
-		udelay(1);
-	MDIO_DEBUG((" (count was %d)\n", count));
+	out_be32(&p->mr0, EMAC_MR0_SRST);
+	while ((in_be32(&p->mr0) & EMAC_MR0_SRST) && n)
+		--n;
+	local_irq_restore(flags);
 
-	if ((stacr & EMAC_STACR_OC) == 0) {
-		printk(KERN_WARNING "%s: PHY read timeout #1!\n", dev->name);
-		return -1;
+	if (n) {
+		dev->reset_failed = 0;
+		return 0;
+	} else {
+		emac_report_timeout_error(dev, "reset timeout");
+		dev->reset_failed = 1;
+		return -ETIMEDOUT;
 	}
+}
 
-	/* Clear the speed bits and make a read request to the PHY */
-	stacr = ((EMAC_STACR_READ | (reg & 0x1f)) & ~EMAC_STACR_CLK_100MHZ);
-	stacr |= ((mii_id & 0x1F) << 5);
+static void emac_hash_mc(struct ocp_enet_private *dev)
+{
+	struct emac_regs *p = dev->emacp;
+	u16 gaht[4] = { 0 };
+	struct dev_mc_list *dmi;
 
-	out_be32(&emacp->em0stacr, stacr);
+	DBG("%d: hash_mc %d" NL, dev->def->index, dev->ndev->mc_count);
 
-	count = 0;
-	while ((((stacr = in_be32(&emacp->em0stacr)) & EMAC_STACR_OC) == 0)
-					&& (count++ < MDIO_DELAY))
-		udelay(1);
-	MDIO_DEBUG((" (count was %d)\n", count));
+	for (dmi = dev->ndev->mc_list; dmi; dmi = dmi->next) {
+		int bit;
+		DBG2("%d: mc %02x:%02x:%02x:%02x:%02x:%02x" NL,
+		     dev->def->index,
+		     dmi->dmi_addr[0], dmi->dmi_addr[1], dmi->dmi_addr[2],
+		     dmi->dmi_addr[3], dmi->dmi_addr[4], dmi->dmi_addr[5]);
 
-	if ((stacr & EMAC_STACR_OC) == 0) {
-		printk(KERN_WARNING "%s: PHY read timeout #2!\n", dev->name);
-		return -1;
+		bit = 63 - (ether_crc(ETH_ALEN, dmi->dmi_addr) >> 26);
+		gaht[bit >> 4] |= 0x8000 >> (bit & 0x0f);
 	}
+	out_be32(&p->gaht1, gaht[0]);
+	out_be32(&p->gaht2, gaht[1]);
+	out_be32(&p->gaht3, gaht[2]);
+	out_be32(&p->gaht4, gaht[3]);
+}
 
-	/* Check for a read error */
-	if (stacr & EMAC_STACR_PHYE) {
-		MDIO_DEBUG(("EMAC MDIO PHY error !\n"));
-		return -1;
-	}
+static inline u32 emac_iff2rmr(struct net_device *ndev)
+{
+	u32 r = EMAC_RMR_SP | EMAC_RMR_SFCS | EMAC_RMR_IAE | EMAC_RMR_BAE |
+	    EMAC_RMR_BASE;
 
-	MDIO_DEBUG((" -> 0x%x\n", stacr >> 16));
+	if (ndev->flags & IFF_PROMISC)
+		r |= EMAC_RMR_PME;
+	else if (ndev->flags & IFF_ALLMULTI || ndev->mc_count > 32)
+		r |= EMAC_RMR_PMME;
+	else if (ndev->mc_count > 0)
+		r |= EMAC_RMR_MAE;
 
-	return (stacr >> 16);
+	return r;
 }
 
-void emac_phy_write(struct net_device *dev, int mii_id, int reg, int data)
+static inline int emac_opb_mhz(void)
 {
-	int count;
-	uint32_t stacr;
-	struct ocp_enet_private *fep = dev->priv;
-	emac_t *emacp = fep->emacp;
+	return (ocp_sys_info.opb_bus_freq + 500000) / 1000000;
+}
 
-	MDIO_DEBUG(("%s phy_write, id: 0x%x, reg: 0x%x, data: 0x%x\n",
-		    dev->name, mii_id, reg, data));
+/* BHs disabled */
+static int emac_configure(struct ocp_enet_private *dev)
+{
+	struct emac_regs *p = dev->emacp;
+	struct net_device *ndev = dev->ndev;
+	int gige;
+	u32 r;
 
-	/* Enable proper ZMII port */
-	if (fep->zmii_dev)
-		emac_enable_zmii_port(fep->zmii_dev, fep->zmii_input);
+	DBG("%d: configure" NL, dev->def->index);
 
-	/* Use the EMAC that has the MDIO port */
-	if (fep->mdio_dev) {
-		dev = fep->mdio_dev;
-		fep = dev->priv;
-		emacp = fep->emacp;
-	}
+	if (emac_reset(dev) < 0)
+		return -ETIMEDOUT;
 
-	count = 0;
-	while ((((stacr = in_be32(&emacp->em0stacr)) & EMAC_STACR_OC) == 0)
-					&& (count++ < MDIO_DELAY))
-		udelay(1);
-	MDIO_DEBUG((" (count was %d)\n", count));
+	tah_reset(dev->tah_dev);
 
-	if ((stacr & EMAC_STACR_OC) == 0) {
-		printk(KERN_WARNING "%s: PHY write timeout #2!\n", dev->name);
-		return;
-	}
+	/* Mode register */
+	r = EMAC_MR1_BASE(emac_opb_mhz()) | EMAC_MR1_VLE | EMAC_MR1_IST;
+	if (dev->phy.duplex == DUPLEX_FULL)
+		r |= EMAC_MR1_FDE;
+	switch (dev->phy.speed) {
+	case SPEED_1000:
+		if (emac_phy_gpcs(dev->phy.mode)) {
+			r |= EMAC_MR1_MF_1000GPCS |
+			    EMAC_MR1_MF_IPPA(dev->phy.address);
 
-	/* Clear the speed bits and make a read request to the PHY */
+			/* Put some arbitrary OUI, Manuf & Rev IDs so we can
+			 * identify this GPCS PHY later.
+			 */
+			out_be32(&p->ipcr, 0xdeadbeef);
+		} else
+			r |= EMAC_MR1_MF_1000;
+		r |= EMAC_MR1_RFS_16K;
+		gige = 1;
 
-	stacr = ((EMAC_STACR_WRITE | (reg & 0x1f)) & ~EMAC_STACR_CLK_100MHZ);
-	stacr |= ((mii_id & 0x1f) << 5) | ((data & 0xffff) << 16);
+		if (dev->ndev->mtu > ETH_DATA_LEN)
+			r |= EMAC_MR1_JPSM;
+		break;
+	case SPEED_100:
+		r |= EMAC_MR1_MF_100;
+		/* Fall through */
+	default:
+		r |= EMAC_MR1_RFS_4K;
+		gige = 0;
+		break;
+	}
 
-	out_be32(&emacp->em0stacr, stacr);
+	if (dev->rgmii_dev)
+		rgmii_set_speed(dev->rgmii_dev, dev->rgmii_input,
+				dev->phy.speed);
+	else
+		zmii_set_speed(dev->zmii_dev, dev->zmii_input, dev->phy.speed);
 
-	count = 0;
-	while ((((stacr = in_be32(&emacp->em0stacr)) & EMAC_STACR_OC) == 0)
-					&& (count++ < MDIO_DELAY))
-		udelay(1);
-	MDIO_DEBUG((" (count was %d)\n", count));
+#if !defined(CONFIG_40x)
+	/* on 40x erratum forces us to NOT use integrated flow control,
+	 * let's hope it works on 44x ;)
+	 */
+	if (dev->phy.duplex == DUPLEX_FULL) {
+		if (dev->phy.pause)
+			r |= EMAC_MR1_EIFC | EMAC_MR1_APP;
+		else if (dev->phy.asym_pause)
+			r |= EMAC_MR1_APP;
+	}
+#endif
+	out_be32(&p->mr1, r);
 
-	if ((stacr & EMAC_STACR_OC) == 0)
-		printk(KERN_WARNING "%s: PHY write timeout #2!\n", dev->name);
+	/* Set individual MAC address */
+	out_be32(&p->iahr, (ndev->dev_addr[0] << 8) | ndev->dev_addr[1]);
+	out_be32(&p->ialr, (ndev->dev_addr[2] << 24) |
+		 (ndev->dev_addr[3] << 16) | (ndev->dev_addr[4] << 8) |
+		 ndev->dev_addr[5]);
+
+	/* VLAN Tag Protocol ID */
+	out_be32(&p->vtpid, 0x8100);
+
+	/* Receive mode register */
+	r = emac_iff2rmr(ndev);
+	if (r & EMAC_RMR_MAE)
+		emac_hash_mc(dev);
+	out_be32(&p->rmr, r);
+
+	/* FIFOs thresholds */
+	r = EMAC_TMR1((EMAC_MAL_BURST_SIZE / EMAC_FIFO_ENTRY_SIZE) + 1,
+		      EMAC_TX_FIFO_SIZE / 2 / EMAC_FIFO_ENTRY_SIZE);
+	out_be32(&p->tmr1, r);
+	out_be32(&p->trtr, EMAC_TRTR(EMAC_TX_FIFO_SIZE / 2));
+
+	/* PAUSE frame is sent when RX FIFO reaches its high-water mark,
+	   there should be still enough space in FIFO to allow the our link
+	   partner time to process this frame and also time to send PAUSE
+	   frame itself.
+
+	   Here is the worst case scenario for the RX FIFO "headroom"
+	   (from "The Switch Book") (100Mbps, without preamble, inter-frame gap):
+
+	   1) One maximum-length frame on TX                    1522 bytes
+	   2) One PAUSE frame time                                64 bytes
+	   3) PAUSE frame decode time allowance                   64 bytes
+	   4) One maximum-length frame on RX                    1522 bytes
+	   5) Round-trip propagation delay of the link (100Mb)    15 bytes
+	   ----------
+	   3187 bytes
 
-	/* Check for a write error */
-	if ((stacr & EMAC_STACR_PHYE) != 0) {
-		MDIO_DEBUG(("EMAC MDIO PHY error !\n"));
-	}
+	   I chose to set high-water mark to RX_FIFO_SIZE / 4 (1024 bytes)
+	   low-water mark  to RX_FIFO_SIZE / 8 (512 bytes)
+	 */
+	r = EMAC_RWMR(EMAC_RX_FIFO_SIZE(gige) / 8 / EMAC_FIFO_ENTRY_SIZE,
+		      EMAC_RX_FIFO_SIZE(gige) / 4 / EMAC_FIFO_ENTRY_SIZE);
+	out_be32(&p->rwmr, r);
+
+	/* Set PAUSE timer to the maximum */
+	out_be32(&p->ptr, 0xffff);
+
+	/* IRQ sources */
+	out_be32(&p->iser, EMAC_ISR_TXPE | EMAC_ISR_RXPE | /* EMAC_ISR_TXUE |
+		 EMAC_ISR_RXOE | */ EMAC_ISR_OVR | EMAC_ISR_BP | EMAC_ISR_SE |
+		 EMAC_ISR_ALE | EMAC_ISR_BFCS | EMAC_ISR_PTLE | EMAC_ISR_ORE |
+		 EMAC_ISR_IRE | EMAC_ISR_TE);
+
+	/* We need to take GPCS PHY out of isolate mode after EMAC reset */
+	if (emac_phy_gpcs(dev->phy.mode))
+		mii_reset_phy(&dev->phy);
+
+	return 0;
 }
 
-static void emac_txeob_dev(void *param, u32 chanmask)
+/* BHs disabled */
+static void emac_reinitialize(struct ocp_enet_private *dev)
 {
-	struct net_device *dev = param;
-	struct ocp_enet_private *fep = dev->priv;
-	unsigned long flags;
-
-	spin_lock_irqsave(&fep->lock, flags);
-
-	PKT_DEBUG(("emac_txeob_dev() entry, tx_cnt: %d\n", fep->tx_cnt));
+	DBG("%d: reinitialize" NL, dev->def->index);
 
-	while (fep->tx_cnt &&
-	       !(fep->tx_desc[fep->ack_slot].ctrl & MAL_TX_CTRL_READY)) {
+	if (!emac_configure(dev)) {
+		emac_tx_enable(dev);
+		emac_rx_enable(dev);
+	}
+}
 
-		if (fep->tx_desc[fep->ack_slot].ctrl & MAL_TX_CTRL_LAST) {
-			/* Tell the system the transmit completed. */
-			dma_unmap_single(&fep->ocpdev->dev,
-					 fep->tx_desc[fep->ack_slot].data_ptr,
-					 fep->tx_desc[fep->ack_slot].data_len,
-					 DMA_TO_DEVICE);
-			dev_kfree_skb_irq(fep->tx_skb[fep->ack_slot]);
+/* BHs disabled */
+static void emac_full_tx_reset(struct net_device *ndev)
+{
+	struct ocp_enet_private *dev = ndev->priv;
+	struct ocp_func_emac_data *emacdata = dev->def->additions;
 
-			if (fep->tx_desc[fep->ack_slot].ctrl &
-			    (EMAC_TX_ST_EC | EMAC_TX_ST_MC | EMAC_TX_ST_SC))
-				fep->stats.collisions++;
-		}
+	DBG("%d: full_tx_reset" NL, dev->def->index);
 
-		fep->tx_skb[fep->ack_slot] = (struct sk_buff *)NULL;
-		if (++fep->ack_slot == NUM_TX_BUFF)
-			fep->ack_slot = 0;
+	emac_tx_disable(dev);
+	mal_disable_tx_channel(dev->mal, emacdata->mal_tx_chan);
+	emac_clean_tx_ring(dev);
+	dev->tx_cnt = dev->tx_slot = dev->ack_slot = 0;
 
-		fep->tx_cnt--;
-	}
-	if (fep->tx_cnt < NUM_TX_BUFF)
-		netif_wake_queue(dev);
+	emac_configure(dev);
 
-	PKT_DEBUG(("emac_txeob_dev() exit, tx_cnt: %d\n", fep->tx_cnt));
+	mal_enable_tx_channel(dev->mal, emacdata->mal_tx_chan);
+	emac_tx_enable(dev);
+	emac_rx_enable(dev);
 
-	spin_unlock_irqrestore(&fep->lock, flags);
+	netif_wake_queue(ndev);
 }
 
-/*
-  Fill/Re-fill the rx chain with valid ctrl/ptrs.
-  This function will fill from rx_slot up to the parm end.
-  So to completely fill the chain pre-set rx_slot to 0 and
-  pass in an end of 0.
- */
-static void emac_rx_fill(struct net_device *dev, int end)
+static int __emac_mdio_read(struct ocp_enet_private *dev, u8 id, u8 reg)
 {
-	int i;
-	struct ocp_enet_private *fep = dev->priv;
+	struct emac_regs *p = dev->emacp;
+	u32 r;
+	int n;
 
-	i = fep->rx_slot;
-	do {
-		/* We don't want the 16 bytes skb_reserve done by dev_alloc_skb,
-		 * it breaks our cache line alignement. However, we still allocate
-		 * +16 so that we end up allocating the exact same size as
-		 * dev_alloc_skb() would do.
-		 * Also, because of the skb_res, the max DMA size we give to EMAC
-		 * is slighly wrong, causing it to potentially DMA 2 more bytes
-		 * from a broken/oversized packet. These 16 bytes will take care
-		 * that we don't walk on somebody else toes with that.
-		 */
-		fep->rx_skb[i] =
-		    alloc_skb(fep->rx_buffer_size + 16, GFP_ATOMIC);
+	DBG2("%d: mdio_read(%02x,%02x)" NL, dev->def->index, id, reg);
 
-		if (fep->rx_skb[i] == NULL) {
-			/* Keep rx_slot here, the next time clean/fill is called
-			 * we will try again before the MAL wraps back here
-			 * If the MAL tries to use this descriptor with
-			 * the EMPTY bit off it will cause the
-			 * rxde interrupt.  That is where we will
-			 * try again to allocate an sk_buff.
-			 */
-			break;
+	/* Enable proper MDIO port */
+	zmii_enable_mdio(dev->zmii_dev, dev->zmii_input);
 
-		}
-
-		if (skb_res)
-			skb_reserve(fep->rx_skb[i], skb_res);
+	/* Wait for management interface to become idle */
+	n = 10;
+	while (!(in_be32(&p->stacr) & EMAC_STACR_OC)) {
+		udelay(1);
+		if (!--n)
+			goto to;
+	}
 
-		/* We must NOT dma_map_single the cache line right after the
-		 * buffer, so we must crop our sync size to account for the
-		 * reserved space
-		 */
-		fep->rx_desc[i].data_ptr =
-		    (unsigned char *)dma_map_single(&fep->ocpdev->dev,
-						    (void *)fep->rx_skb[i]->
-						    data,
-						    fep->rx_buffer_size -
-						    skb_res, DMA_FROM_DEVICE);
-
-		/*
-		 * Some 4xx implementations use the previously
-		 * reserved bits in data_len to encode the MS
-		 * 4-bits of a 36-bit physical address (ERPN)
-		 * This must be initialized.
-		 */
-		fep->rx_desc[i].data_len = 0;
-		fep->rx_desc[i].ctrl = MAL_RX_CTRL_EMPTY | MAL_RX_CTRL_INTR |
-		    (i == (NUM_RX_BUFF - 1) ? MAL_RX_CTRL_WRAP : 0);
+	/* Issue read command */
+	out_be32(&p->stacr,
+		 EMAC_STACR_BASE(emac_opb_mhz()) | EMAC_STACR_STAC_READ |
+		 (reg & EMAC_STACR_PRA_MASK)
+		 | ((id & EMAC_STACR_PCDA_MASK) << EMAC_STACR_PCDA_SHIFT));
+
+	/* Wait for read to complete */
+	n = 100;
+	while (!((r = in_be32(&p->stacr)) & EMAC_STACR_OC)) {
+		udelay(1);
+		if (!--n)
+			goto to;
+	}
 
-	} while ((i = (i + 1) % NUM_RX_BUFF) != end);
+	if (unlikely(r & EMAC_STACR_PHYE)) {
+		DBG("%d: mdio_read(%02x, %02x) failed" NL, dev->def->index,
+		    id, reg);
+		return -EREMOTEIO;
+	}
 
-	fep->rx_slot = i;
+	r = ((r >> EMAC_STACR_PHYD_SHIFT) & EMAC_STACR_PHYD_MASK);
+	DBG2("%d: mdio_read -> %04x" NL, dev->def->index, r);
+	return r;
+      to:
+	DBG("%d: MII management interface timeout (read)" NL, dev->def->index);
+	return -ETIMEDOUT;
 }
 
-static void
-emac_rx_csum(struct net_device *dev, unsigned short ctrl, struct sk_buff *skb)
+static void __emac_mdio_write(struct ocp_enet_private *dev, u8 id, u8 reg,
+			      u16 val)
 {
-	struct ocp_enet_private *fep = dev->priv;
+	struct emac_regs *p = dev->emacp;
+	int n;
+
+	DBG2("%d: mdio_write(%02x,%02x,%04x)" NL, dev->def->index, id, reg,
+	     val);
+
+	/* Enable proper MDIO port */
+	zmii_enable_mdio(dev->zmii_dev, dev->zmii_input);
 
-	/* Exit if interface has no TAH engine */
-	if (!fep->tah_dev) {
-		skb->ip_summed = CHECKSUM_NONE;
-		return;
+	/* Wait for management interface to be idle */
+	n = 10;
+	while (!(in_be32(&p->stacr) & EMAC_STACR_OC)) {
+		udelay(1);
+		if (!--n)
+			goto to;
 	}
 
-	/* Check for TCP/UDP/IP csum error */
-	if (ctrl & EMAC_CSUM_VER_ERROR) {
-		/* Let the stack verify checksum errors */
-		skb->ip_summed = CHECKSUM_NONE;
-/*		adapter->hw_csum_err++; */
-	} else {
-		/* Csum is good */
-		skb->ip_summed = CHECKSUM_UNNECESSARY;
-/*		adapter->hw_csum_good++; */
+	/* Issue write command */
+	out_be32(&p->stacr,
+		 EMAC_STACR_BASE(emac_opb_mhz()) | EMAC_STACR_STAC_WRITE |
+		 (reg & EMAC_STACR_PRA_MASK) |
+		 ((id & EMAC_STACR_PCDA_MASK) << EMAC_STACR_PCDA_SHIFT) |
+		 (val << EMAC_STACR_PHYD_SHIFT));
+
+	/* Wait for write to complete */
+	n = 100;
+	while (!(in_be32(&p->stacr) & EMAC_STACR_OC)) {
+		udelay(1);
+		if (!--n)
+			goto to;
 	}
+	return;
+      to:
+	DBG("%d: MII management interface timeout (write)" NL, dev->def->index);
 }
 
-static int emac_rx_clean(struct net_device *dev)
+static int emac_mdio_read(struct net_device *ndev, int id, int reg)
 {
-	int i, b, bnum = 0, buf[6];
-	int error, frame_length;
-	struct ocp_enet_private *fep = dev->priv;
-	unsigned short ctrl;
-
-	i = fep->rx_slot;
-
-	PKT_DEBUG(("emac_rx_clean() entry, rx_slot: %d\n", fep->rx_slot));
-
-	do {
-		if (fep->rx_skb[i] == NULL)
-			continue;	/*we have already handled the packet but haved failed to alloc */
-		/* 
-		   since rx_desc is in uncached mem we don't keep reading it directly 
-		   we pull out a local copy of ctrl and do the checks on the copy.
-		 */
-		ctrl = fep->rx_desc[i].ctrl;
-		if (ctrl & MAL_RX_CTRL_EMPTY)
-			break;	/*we don't have any more ready packets */
-
-		if (EMAC_IS_BAD_RX_PACKET(ctrl)) {
-			fep->stats.rx_errors++;
-			fep->stats.rx_dropped++;
-
-			if (ctrl & EMAC_RX_ST_OE)
-				fep->stats.rx_fifo_errors++;
-			if (ctrl & EMAC_RX_ST_AE)
-				fep->stats.rx_frame_errors++;
-			if (ctrl & EMAC_RX_ST_BFCS)
-				fep->stats.rx_crc_errors++;
-			if (ctrl & (EMAC_RX_ST_RP | EMAC_RX_ST_PTL |
-				    EMAC_RX_ST_ORE | EMAC_RX_ST_IRE))
-				fep->stats.rx_length_errors++;
-		} else {
-			if ((ctrl & (MAL_RX_CTRL_FIRST | MAL_RX_CTRL_LAST)) ==
-			    (MAL_RX_CTRL_FIRST | MAL_RX_CTRL_LAST)) {
-				/* Single descriptor packet */
-				emac_rx_csum(dev, ctrl, fep->rx_skb[i]);
-				/* Send the skb up the chain. */
-				frame_length = fep->rx_desc[i].data_len - 4;
-				skb_put(fep->rx_skb[i], frame_length);
-				fep->rx_skb[i]->dev = dev;
-				fep->rx_skb[i]->protocol =
-				    eth_type_trans(fep->rx_skb[i], dev);
-				error = netif_rx(fep->rx_skb[i]);
-
-				if ((error == NET_RX_DROP) ||
-				    (error == NET_RX_BAD)) {
-					fep->stats.rx_dropped++;
-				} else {
-					fep->stats.rx_packets++;
-					fep->stats.rx_bytes += frame_length;
-				}
-				fep->rx_skb[i] = NULL;
-			} else {
-				/* Multiple descriptor packet */
-				if (ctrl & MAL_RX_CTRL_FIRST) {
-					if (fep->rx_desc[(i + 1) % NUM_RX_BUFF].
-					    ctrl & MAL_RX_CTRL_EMPTY)
-						break;
-					bnum = 0;
-					buf[bnum] = i;
-					++bnum;
-					continue;
-				}
-				if (((ctrl & MAL_RX_CTRL_FIRST) !=
-				     MAL_RX_CTRL_FIRST) &&
-				    ((ctrl & MAL_RX_CTRL_LAST) !=
-				     MAL_RX_CTRL_LAST)) {
-					if (fep->rx_desc[(i + 1) %
-							 NUM_RX_BUFF].ctrl &
-					    MAL_RX_CTRL_EMPTY) {
-						i = buf[0];
-						break;
-					}
-					buf[bnum] = i;
-					++bnum;
-					continue;
-				}
-				if (ctrl & MAL_RX_CTRL_LAST) {
-					buf[bnum] = i;
-					++bnum;
-					skb_put(fep->rx_skb[buf[0]],
-						fep->rx_desc[buf[0]].data_len);
-					for (b = 1; b < bnum; b++) {
-						/*
-						 * MAL is braindead, we need
-						 * to copy the remainder
-						 * of the packet from the
-						 * latter descriptor buffers
-						 * to the first skb. Then
-						 * dispose of the source
-						 * skbs.
-						 *
-						 * Once the stack is fixed
-						 * to handle frags on most
-						 * protocols we can generate
-						 * a fragmented skb with
-						 * no copies.
-						 */
-						memcpy(fep->rx_skb[buf[0]]->
-						       data +
-						       fep->rx_skb[buf[0]]->len,
-						       fep->rx_skb[buf[b]]->
-						       data,
-						       fep->rx_desc[buf[b]].
-						       data_len);
-						skb_put(fep->rx_skb[buf[0]],
-							fep->rx_desc[buf[b]].
-							data_len);
-						dma_unmap_single(&fep->ocpdev->
-								 dev,
-								 fep->
-								 rx_desc[buf
-									 [b]].
-								 data_ptr,
-								 fep->
-								 rx_desc[buf
-									 [b]].
-								 data_len,
-								 DMA_FROM_DEVICE);
-						dev_kfree_skb(fep->
-							      rx_skb[buf[b]]);
-					}
-					emac_rx_csum(dev, ctrl,
-						     fep->rx_skb[buf[0]]);
-
-					fep->rx_skb[buf[0]]->dev = dev;
-					fep->rx_skb[buf[0]]->protocol =
-					    eth_type_trans(fep->rx_skb[buf[0]],
-							   dev);
-					error = netif_rx(fep->rx_skb[buf[0]]);
-
-					if ((error == NET_RX_DROP)
-					    || (error == NET_RX_BAD)) {
-						fep->stats.rx_dropped++;
-					} else {
-						fep->stats.rx_packets++;
-						fep->stats.rx_bytes +=
-						    fep->rx_skb[buf[0]]->len;
-					}
-					for (b = 0; b < bnum; b++)
-						fep->rx_skb[buf[b]] = NULL;
-				}
-			}
-		}
-	} while ((i = (i + 1) % NUM_RX_BUFF) != fep->rx_slot);
-
-	PKT_DEBUG(("emac_rx_clean() exit, rx_slot: %d\n", fep->rx_slot));
+	struct ocp_enet_private *dev = ndev->priv;
+	int res;
 
-	return i;
+	local_bh_disable();
+	res = __emac_mdio_read(dev->mdio_dev ? dev->mdio_dev : dev, (u8) id,
+			       (u8) reg);
+	local_bh_enable();
+	return res;
 }
 
-static void emac_rxeob_dev(void *param, u32 chanmask)
+static void emac_mdio_write(struct net_device *ndev, int id, int reg, int val)
 {
-	struct net_device *dev = param;
-	struct ocp_enet_private *fep = dev->priv;
-	unsigned long flags;
-	int n;
+	struct ocp_enet_private *dev = ndev->priv;
 
-	spin_lock_irqsave(&fep->lock, flags);
-	if ((n = emac_rx_clean(dev)) != fep->rx_slot)
-		emac_rx_fill(dev, n);
-	spin_unlock_irqrestore(&fep->lock, flags);
+	local_bh_disable();
+	__emac_mdio_write(dev->mdio_dev ? dev->mdio_dev : dev, (u8) id,
+			  (u8) reg, (u16) val);
+	local_bh_enable();
 }
 
-/*
- * This interrupt should never occurr, we don't program
- * the MAL for contiunous mode.
- */
-static void emac_txde_dev(void *param, u32 chanmask)
+/* BHs disabled */
+static void emac_set_multicast_list(struct net_device *ndev)
 {
-	struct net_device *dev = param;
-	struct ocp_enet_private *fep = dev->priv;
-
-	printk(KERN_WARNING "%s: transmit descriptor error\n", dev->name);
+	struct ocp_enet_private *dev = ndev->priv;
+	struct emac_regs *p = dev->emacp;
+	u32 rmr = emac_iff2rmr(ndev);
 
-	emac_mac_dump(dev);
-	emac_mal_dump(dev);
+	DBG("%d: multicast %08x" NL, dev->def->index, rmr);
+	BUG_ON(!netif_running(dev->ndev));
 
-	/* Reenable the transmit channel */
-	mal_enable_tx_channels(fep->mal, fep->commac.tx_chan_mask);
+	/* I decided to relax register access rules here to avoid
+	 * full EMAC reset.
+	 *
+	 * There is a real problem with EMAC4 core if we use MWSW_001 bit
+	 * in MR1 register and do a full EMAC reset.
+	 * One TX BD status update is delayed and, after EMAC reset, it
+	 * never happens, resulting in TX hung (it'll be recovered by TX
+	 * timeout handler eventually, but this is just gross).
+	 * So we either have to do full TX reset or try to cheat here :)
+	 *
+	 * The only required change is to RX mode register, so I *think* all
+	 * we need is just to stop RX channel. This seems to work on all
+	 * tested SoCs.                                                --ebs
+	 */
+	emac_rx_disable(dev);
+	if (rmr & EMAC_RMR_MAE)
+		emac_hash_mc(dev);
+	out_be32(&p->rmr, rmr);
+	emac_rx_enable(dev);
 }
 
-/*
- * This interrupt should be very rare at best.  This occurs when
- * the hardware has a problem with the receive descriptors.  The manual
- * states that it occurs when the hardware cannot the receive descriptor
- * empty bit is not set.  The recovery mechanism will be to
- * traverse through the descriptors, handle any that are marked to be
- * handled and reinitialize each along the way.  At that point the driver
- * will be restarted.
- */
-static void emac_rxde_dev(void *param, u32 chanmask)
+/* BHs disabled */
+static int emac_resize_rx_ring(struct ocp_enet_private *dev, int new_mtu)
 {
-	struct net_device *dev = param;
-	struct ocp_enet_private *fep = dev->priv;
-	unsigned long flags;
+	struct ocp_func_emac_data *emacdata = dev->def->additions;
+	int rx_sync_size = emac_rx_sync_size(new_mtu);
+	int rx_skb_size = emac_rx_skb_size(new_mtu);
+	int i, ret = 0;
 
-	if (net_ratelimit()) {
-		printk(KERN_WARNING "%s: receive descriptor error\n",
-		       fep->ndev->name);
+	emac_rx_disable(dev);
+	mal_disable_rx_channel(dev->mal, emacdata->mal_rx_chan);
 
-		emac_mac_dump(dev);
-		emac_mal_dump(dev);
-		emac_desc_dump(dev);
+	if (dev->rx_sg_skb) {
+		++dev->estats.rx_dropped_resize;
+		dev_kfree_skb(dev->rx_sg_skb);
+		dev->rx_sg_skb = NULL;
 	}
 
-	/* Disable RX channel */
-	spin_lock_irqsave(&fep->lock, flags);
-	mal_disable_rx_channels(fep->mal, fep->commac.rx_chan_mask);
+	/* Make a first pass over RX ring and mark BDs ready, dropping
+	 * non-processed packets on the way. We need this as a separate pass
+	 * to simplify error recovery in the case of allocation failure later.
+	 */
+	for (i = 0; i < NUM_RX_BUFF; ++i) {
+		if (dev->rx_desc[i].ctrl & MAL_RX_CTRL_FIRST)
+			++dev->estats.rx_dropped_resize;
 
-	/* For now, charge the error against all emacs */
-	fep->stats.rx_errors++;
+		dev->rx_desc[i].data_len = 0;
+		dev->rx_desc[i].ctrl = MAL_RX_CTRL_EMPTY |
+		    (i == (NUM_RX_BUFF - 1) ? MAL_RX_CTRL_WRAP : 0);
+	}
 
-	/* so do we have any good packets still? */
-	emac_rx_clean(dev);
+	/* Reallocate RX ring only if bigger skb buffers are required */
+	if (rx_skb_size <= dev->rx_skb_size)
+		goto skip;
 
-	/* When the interface is restarted it resets processing to the
-	 *  first descriptor in the table.
-	 */
+	/* Second pass, allocate new skbs */
+	for (i = 0; i < NUM_RX_BUFF; ++i) {
+		struct sk_buff *skb = alloc_skb(rx_skb_size, GFP_ATOMIC);
+		if (!skb) {
+			ret = -ENOMEM;
+			goto oom;
+		}
+
+		BUG_ON(!dev->rx_skb[i]);
+		dev_kfree_skb(dev->rx_skb[i]);
+
+		skb_reserve(skb, EMAC_RX_SKB_HEADROOM + 2);
+		dev->rx_desc[i].data_ptr =
+		    dma_map_single(dev->ldev, skb->data - 2, rx_sync_size,
+				   DMA_FROM_DEVICE) + 2;
+		dev->rx_skb[i] = skb;
+	}
+      skip:
+	/* Check if we need to change "Jumbo" bit in MR1 */
+	if ((new_mtu > ETH_DATA_LEN) ^ (dev->ndev->mtu > ETH_DATA_LEN)) {
+		/* This is to prevent starting RX channel in emac_rx_enable() */
+		dev->commac.rx_stopped = 1;
 
-	fep->rx_slot = 0;
-	emac_rx_fill(dev, 0);
+		dev->ndev->mtu = new_mtu;
+		emac_full_tx_reset(dev->ndev);
+	}
 
-	set_mal_dcrn(fep->mal, DCRN_MALRXEOBISR, fep->commac.rx_chan_mask);
-	set_mal_dcrn(fep->mal, DCRN_MALRXDEIR, fep->commac.rx_chan_mask);
+	mal_set_rcbs(dev->mal, emacdata->mal_rx_chan, emac_rx_size(new_mtu));
+      oom:
+	/* Restart RX */
+	dev->commac.rx_stopped = dev->rx_slot = 0;
+	mal_enable_rx_channel(dev->mal, emacdata->mal_rx_chan);
+	emac_rx_enable(dev);
 
-	/* Reenable the receive channels */
-	mal_enable_rx_channels(fep->mal, fep->commac.rx_chan_mask);
-	spin_unlock_irqrestore(&fep->lock, flags);
+	return ret;
 }
 
-static irqreturn_t
-emac_mac_irq(int irq, void *dev_instance, struct pt_regs *regs)
+/* Process ctx, rtnl_lock semaphore */
+static int emac_change_mtu(struct net_device *ndev, int new_mtu)
 {
-	struct net_device *dev = dev_instance;
-	struct ocp_enet_private *fep = dev->priv;
-	emac_t *emacp = fep->emacp;
-	unsigned long tmp_em0isr;
+	struct ocp_enet_private *dev = ndev->priv;
+	int ret = 0;
 
-	/* EMAC interrupt */
-	tmp_em0isr = in_be32(&emacp->em0isr);
-	if (tmp_em0isr & (EMAC_ISR_TE0 | EMAC_ISR_TE1)) {
-		/* This error is a hard transmit error - could retransmit */
-		fep->stats.tx_errors++;
+	if (new_mtu < EMAC_MIN_MTU || new_mtu > EMAC_MAX_MTU)
+		return -EINVAL;
 
-		/* Reenable the transmit channel */
-		mal_enable_tx_channels(fep->mal, fep->commac.tx_chan_mask);
+	DBG("%d: change_mtu(%d)" NL, dev->def->index, new_mtu);
 
-	} else {
-		fep->stats.rx_errors++;
+	local_bh_disable();
+	if (netif_running(ndev)) {
+		/* Check if we really need to reinitalize RX ring */
+		if (emac_rx_skb_size(ndev->mtu) != emac_rx_skb_size(new_mtu))
+			ret = emac_resize_rx_ring(dev, new_mtu);
 	}
 
-	if (tmp_em0isr & EMAC_ISR_RP)
-		fep->stats.rx_length_errors++;
-	if (tmp_em0isr & EMAC_ISR_ALE)
-		fep->stats.rx_frame_errors++;
-	if (tmp_em0isr & EMAC_ISR_BFCS)
-		fep->stats.rx_crc_errors++;
-	if (tmp_em0isr & EMAC_ISR_PTLE)
-		fep->stats.rx_length_errors++;
-	if (tmp_em0isr & EMAC_ISR_ORE)
-		fep->stats.rx_length_errors++;
-	if (tmp_em0isr & EMAC_ISR_TE0)
-		fep->stats.tx_aborted_errors++;
-
-	emac_err_dump(dev, tmp_em0isr);
-
-	out_be32(&emacp->em0isr, tmp_em0isr);
+	if (!ret) {
+		ndev->mtu = new_mtu;
+		dev->rx_skb_size = emac_rx_skb_size(new_mtu);
+		dev->rx_sync_size = emac_rx_sync_size(new_mtu);
+	}
+	local_bh_enable();
 
-	return IRQ_HANDLED;
+	return ret;
 }
 
-static int emac_start_xmit(struct sk_buff *skb, struct net_device *dev)
+static void emac_clean_tx_ring(struct ocp_enet_private *dev)
 {
-	unsigned short ctrl;
-	unsigned long flags;
-	struct ocp_enet_private *fep = dev->priv;
-	emac_t *emacp = fep->emacp;
-	int len = skb->len;
-	unsigned int offset = 0, size, f, tx_slot_first;
-	unsigned int nr_frags = skb_shinfo(skb)->nr_frags;
-
-	spin_lock_irqsave(&fep->lock, flags);
-
-	len -= skb->data_len;
-
-	if ((fep->tx_cnt + nr_frags + len / DESC_BUF_SIZE + 1) > NUM_TX_BUFF) {
-		PKT_DEBUG(("emac_start_xmit() stopping queue\n"));
-		netif_stop_queue(dev);
-		spin_unlock_irqrestore(&fep->lock, flags);
-		return -EBUSY;
-	}
-
-	tx_slot_first = fep->tx_slot;
-
-	while (len) {
-		size = min(len, DESC_BUF_SIZE);
-
-		fep->tx_desc[fep->tx_slot].data_len = (short)size;
-		fep->tx_desc[fep->tx_slot].data_ptr =
-		    (unsigned char *)dma_map_single(&fep->ocpdev->dev,
-						    (void *)((unsigned int)skb->
-							     data + offset),
-						    size, DMA_TO_DEVICE);
-
-		ctrl = EMAC_TX_CTRL_DFLT;
-		if (fep->tx_slot != tx_slot_first)
-			ctrl |= MAL_TX_CTRL_READY;
-		if ((NUM_TX_BUFF - 1) == fep->tx_slot)
-			ctrl |= MAL_TX_CTRL_WRAP;
-		if (!nr_frags && (len == size)) {
-			ctrl |= MAL_TX_CTRL_LAST;
-			fep->tx_skb[fep->tx_slot] = skb;
+	int i;
+	for (i = 0; i < NUM_TX_BUFF; ++i) {
+		if (dev->tx_skb[i]) {
+			dev_kfree_skb(dev->tx_skb[i]);
+			dev->tx_skb[i] = NULL;
+			if (dev->tx_desc[i].ctrl & MAL_TX_CTRL_READY)
+				++dev->estats.tx_dropped;
 		}
-		if (skb->ip_summed == CHECKSUM_HW)
-			ctrl |= EMAC_TX_CTRL_TAH_CSUM;
-
-		fep->tx_desc[fep->tx_slot].ctrl = ctrl;
-
-		len -= size;
-		offset += size;
+		dev->tx_desc[i].ctrl = 0;
+		dev->tx_desc[i].data_ptr = 0;
+	}
+}
 
-		/* Bump tx count */
-		if (++fep->tx_cnt == NUM_TX_BUFF)
-			netif_stop_queue(dev);
+static void emac_clean_rx_ring(struct ocp_enet_private *dev)
+{
+	int i;
+	for (i = 0; i < NUM_RX_BUFF; ++i)
+		if (dev->rx_skb[i]) {
+			dev->rx_desc[i].ctrl = 0;
+			dev_kfree_skb(dev->rx_skb[i]);
+			dev->rx_skb[i] = NULL;
+			dev->rx_desc[i].data_ptr = 0;
+		}
 
-		/* Next descriptor */
-		if (++fep->tx_slot == NUM_TX_BUFF)
-			fep->tx_slot = 0;
+	if (dev->rx_sg_skb) {
+		dev_kfree_skb(dev->rx_sg_skb);
+		dev->rx_sg_skb = NULL;
 	}
+}
 
-	for (f = 0; f < nr_frags; f++) {
-		struct skb_frag_struct *frag;
+static inline int emac_alloc_rx_skb(struct ocp_enet_private *dev, int slot,
+				    int flags)
+{
+	struct sk_buff *skb = alloc_skb(dev->rx_skb_size, flags);
+	if (unlikely(!skb))
+		return -ENOMEM;
 
-		frag = &skb_shinfo(skb)->frags[f];
-		len = frag->size;
-		offset = 0;
+	dev->rx_skb[slot] = skb;
+	dev->rx_desc[slot].data_len = 0;
 
-		while (len) {
-			size = min(len, DESC_BUF_SIZE);
+	skb_reserve(skb, EMAC_RX_SKB_HEADROOM + 2);
+	dev->rx_desc[slot].data_ptr =
+	    dma_map_single(dev->ldev, skb->data - 2, dev->rx_sync_size,
+			   DMA_FROM_DEVICE) + 2;
+	barrier();
+	dev->rx_desc[slot].ctrl = MAL_RX_CTRL_EMPTY |
+	    (slot == (NUM_RX_BUFF - 1) ? MAL_RX_CTRL_WRAP : 0);
 
-			dma_map_page(&fep->ocpdev->dev,
-				     frag->page,
-				     frag->page_offset + offset,
-				     size, DMA_TO_DEVICE);
-
-			ctrl = EMAC_TX_CTRL_DFLT | MAL_TX_CTRL_READY;
-			if ((NUM_TX_BUFF - 1) == fep->tx_slot)
-				ctrl |= MAL_TX_CTRL_WRAP;
-			if ((f == (nr_frags - 1)) && (len == size)) {
-				ctrl |= MAL_TX_CTRL_LAST;
-				fep->tx_skb[fep->tx_slot] = skb;
-			}
+	return 0;
+}
 
-			if (skb->ip_summed == CHECKSUM_HW)
-				ctrl |= EMAC_TX_CTRL_TAH_CSUM;
+static void emac_print_link_status(struct ocp_enet_private *dev)
+{
+	if (netif_carrier_ok(dev->ndev))
+		printk(KERN_INFO "%s: link is up, %d %s%s\n",
+		       dev->ndev->name, dev->phy.speed,
+		       dev->phy.duplex == DUPLEX_FULL ? "FDX" : "HDX",
+		       dev->phy.pause ? ", pause enabled" :
+		       dev->phy.asym_pause ? ", assymetric pause enabled" : "");
+	else
+		printk(KERN_INFO "%s: link is down\n", dev->ndev->name);
+}
 
-			fep->tx_desc[fep->tx_slot].data_len = (short)size;
-			fep->tx_desc[fep->tx_slot].data_ptr =
-			    (char *)((page_to_pfn(frag->page) << PAGE_SHIFT) +
-				     frag->page_offset + offset);
-			fep->tx_desc[fep->tx_slot].ctrl = ctrl;
+/* Process ctx, rtnl_lock semaphore */
+static int emac_open(struct net_device *ndev)
+{
+	struct ocp_enet_private *dev = ndev->priv;
+	struct ocp_func_emac_data *emacdata = dev->def->additions;
+	int err, i;
+
+	DBG("%d: open" NL, dev->def->index);
+
+	/* Setup error IRQ handler */
+	err = request_irq(dev->def->irq, emac_irq, 0, "EMAC", dev);
+	if (err) {
+		printk(KERN_ERR "%s: failed to request IRQ %d\n",
+		       ndev->name, dev->def->irq);
+		return err;
+	}
+
+	/* Allocate RX ring */
+	for (i = 0; i < NUM_RX_BUFF; ++i)
+		if (emac_alloc_rx_skb(dev, i, GFP_KERNEL)) {
+			printk(KERN_ERR "%s: failed to allocate RX ring\n",
+			       ndev->name);
+			goto oom;
+		}
+
+	local_bh_disable();
+	dev->tx_cnt = dev->tx_slot = dev->ack_slot = dev->rx_slot =
+	    dev->commac.rx_stopped = 0;
+	dev->rx_sg_skb = NULL;
+
+	if (dev->phy.address >= 0) {
+		int link_poll_interval;
+		if (dev->phy.def->ops->poll_link(&dev->phy)) {
+			dev->phy.def->ops->read_link(&dev->phy);
+			EMAC_RX_CLK_DEFAULT(dev->def->index);
+			netif_carrier_on(dev->ndev);
+			link_poll_interval = PHY_POLL_LINK_ON;
+		} else {
+			EMAC_RX_CLK_TX(dev->def->index);
+			netif_carrier_off(dev->ndev);
+			link_poll_interval = PHY_POLL_LINK_OFF;
+		}
+		mod_timer(&dev->link_timer, jiffies + link_poll_interval);
+		emac_print_link_status(dev);
+	} else
+		netif_carrier_on(dev->ndev);
+
+	emac_configure(dev);
+	mal_poll_add(dev->mal, &dev->commac);
+	mal_enable_tx_channel(dev->mal, emacdata->mal_tx_chan);
+	mal_set_rcbs(dev->mal, emacdata->mal_rx_chan, emac_rx_size(ndev->mtu));
+	mal_enable_rx_channel(dev->mal, emacdata->mal_rx_chan);
+	emac_tx_enable(dev);
+	emac_rx_enable(dev);
+	netif_start_queue(ndev);
+	local_bh_enable();
 
-			len -= size;
-			offset += size;
+	return 0;
+      oom:
+	emac_clean_rx_ring(dev);
+	free_irq(dev->def->irq, dev);
+	return -ENOMEM;
+}
 
-			/* Bump tx count */
-			if (++fep->tx_cnt == NUM_TX_BUFF)
-				netif_stop_queue(dev);
+/* BHs disabled */
+static int emac_link_differs(struct ocp_enet_private *dev)
+{
+	u32 r = in_be32(&dev->emacp->mr1);
 
-			/* Next descriptor */
-			if (++fep->tx_slot == NUM_TX_BUFF)
-				fep->tx_slot = 0;
-		}
-	}
+	int duplex = r & EMAC_MR1_FDE ? DUPLEX_FULL : DUPLEX_HALF;
+	int speed, pause, asym_pause;
 
-	/*
-	 * Deferred set READY on first descriptor of packet to
-	 * avoid TX MAL race.
-	 */
-	fep->tx_desc[tx_slot_first].ctrl |= MAL_TX_CTRL_READY;
+	if (r & (EMAC_MR1_MF_1000 | EMAC_MR1_MF_1000GPCS))
+		speed = SPEED_1000;
+	else if (r & EMAC_MR1_MF_100)
+		speed = SPEED_100;
+	else
+		speed = SPEED_10;
 
-	/* Send the packet out. */
-	out_be32(&emacp->em0tmr0, EMAC_TMR0_XMIT);
+	switch (r & (EMAC_MR1_EIFC | EMAC_MR1_APP)) {
+	case (EMAC_MR1_EIFC | EMAC_MR1_APP):
+		pause = 1;
+		asym_pause = 0;
+		break;
+	case EMAC_MR1_APP:
+		pause = 0;
+		asym_pause = 1;
+		break;
+	default:
+		pause = asym_pause = 0;
+	}
+	return speed != dev->phy.speed || duplex != dev->phy.duplex ||
+	    pause != dev->phy.pause || asym_pause != dev->phy.asym_pause;
+}
 
-	fep->stats.tx_packets++;
-	fep->stats.tx_bytes += skb->len;
+/* BHs disabled */
+static void emac_link_timer(unsigned long data)
+{
+	struct ocp_enet_private *dev = (struct ocp_enet_private *)data;
+	int link_poll_interval;
 
-	PKT_DEBUG(("emac_start_xmit() exitn"));
+	DBG2("%d: link timer" NL, dev->def->index);
 
-	spin_unlock_irqrestore(&fep->lock, flags);
+	if (dev->phy.def->ops->poll_link(&dev->phy)) {
+		if (!netif_carrier_ok(dev->ndev)) {
+			EMAC_RX_CLK_DEFAULT(dev->def->index);
 
-	return 0;
-}
+			/* Get new link parameters */
+			dev->phy.def->ops->read_link(&dev->phy);
 
-static int emac_adjust_to_link(struct ocp_enet_private *fep)
-{
-	emac_t *emacp = fep->emacp;
-	unsigned long mode_reg;
-	int full_duplex, speed;
+			if (dev->tah_dev || emac_link_differs(dev))
+				emac_full_tx_reset(dev->ndev);
 
-	full_duplex = 0;
-	speed = SPEED_10;
+			netif_carrier_on(dev->ndev);
+			emac_print_link_status(dev);
+		}
+		link_poll_interval = PHY_POLL_LINK_ON;
+	} else {
+		if (netif_carrier_ok(dev->ndev)) {
+			EMAC_RX_CLK_TX(dev->def->index);
+#if defined(CONFIG_IBM_EMAC_PHY_RX_CLK_FIX)
+			emac_reinitialize(dev);
+#endif
+			netif_carrier_off(dev->ndev);
+			emac_print_link_status(dev);
+		}
 
-	/* set mode register 1 defaults */
-	mode_reg = EMAC_M1_DEFAULT;
+		/* Retry reset if the previous attempt failed.
+		 * This is needed mostly for CONFIG_IBM_EMAC_PHY_RX_CLK_FIX
+		 * case, but I left it here because it shouldn't trigger for
+		 * sane PHYs anyway.
+		 */
+		if (unlikely(dev->reset_failed))
+			emac_reinitialize(dev);
 
-	/* Read link mode on PHY */
-	if (fep->phy_mii.def->ops->read_link(&fep->phy_mii) == 0) {
-		/* If an error occurred, we don't deal with it yet */
-		full_duplex = (fep->phy_mii.duplex == DUPLEX_FULL);
-		speed = fep->phy_mii.speed;
+		link_poll_interval = PHY_POLL_LINK_OFF;
 	}
+	mod_timer(&dev->link_timer, jiffies + link_poll_interval);
+}
 
+/* BHs disabled */
+static void emac_force_link_update(struct ocp_enet_private *dev)
+{
+	netif_carrier_off(dev->ndev);
+	if (timer_pending(&dev->link_timer))
+		mod_timer(&dev->link_timer, jiffies + PHY_POLL_LINK_OFF);
+}
 
-	/* set speed (default is 10Mb) */
-	switch (speed) {
-	case SPEED_1000:
-		mode_reg |= EMAC_M1_RFS_16K;
-		if (fep->rgmii_dev) {
-			struct ibm_ocp_rgmii *rgmii = RGMII_PRIV(fep->rgmii_dev);
-
-			if ((rgmii->mode[fep->rgmii_input] == RTBI)
-			    || (rgmii->mode[fep->rgmii_input] == TBI))
-				mode_reg |= EMAC_M1_MF_1000GPCS;
-			else
-				mode_reg |= EMAC_M1_MF_1000MBPS;
+/* Process ctx, rtnl_lock semaphore */
+static int emac_close(struct net_device *ndev)
+{
+	struct ocp_enet_private *dev = ndev->priv;
+	struct ocp_func_emac_data *emacdata = dev->def->additions;
 
-			emac_rgmii_port_speed(fep->rgmii_dev, fep->rgmii_input,
-					      1000);
-		}
-		break;
-	case SPEED_100:
-		mode_reg |= EMAC_M1_MF_100MBPS | EMAC_M1_RFS_4K;
-		if (fep->rgmii_dev)
-			emac_rgmii_port_speed(fep->rgmii_dev, fep->rgmii_input,
-					      100);
-		if (fep->zmii_dev)
-			emac_zmii_port_speed(fep->zmii_dev, fep->zmii_input,
-					     100);
-		break;
-	case SPEED_10:
-	default:
-		mode_reg = (mode_reg & ~EMAC_M1_MF_100MBPS) | EMAC_M1_RFS_4K;
-		if (fep->rgmii_dev)
-			emac_rgmii_port_speed(fep->rgmii_dev, fep->rgmii_input,
-					      10);
-		if (fep->zmii_dev)
-			emac_zmii_port_speed(fep->zmii_dev, fep->zmii_input,
-					     10);
-	}
+	DBG("%d: close" NL, dev->def->index);
+
+	local_bh_disable();
 
-	if (full_duplex)
-		mode_reg |= EMAC_M1_FDE | EMAC_M1_EIFC | EMAC_M1_IST;
-	else
-		mode_reg &= ~(EMAC_M1_FDE | EMAC_M1_EIFC | EMAC_M1_ILE);
+	if (dev->phy.address >= 0)
+		del_timer_sync(&dev->link_timer);
 
-	LINK_DEBUG(("%s: adjust to link, speed: %d, duplex: %d, opened: %d\n",
-		    fep->ndev->name, speed, full_duplex, fep->opened));
+	netif_stop_queue(ndev);
+	emac_rx_disable(dev);
+	emac_tx_disable(dev);
+	mal_disable_rx_channel(dev->mal, emacdata->mal_rx_chan);
+	mal_disable_tx_channel(dev->mal, emacdata->mal_tx_chan);
+	mal_poll_del(dev->mal, &dev->commac);
+	local_bh_enable();
 
-	printk(KERN_INFO "%s: Speed: %d, %s duplex.\n",
-	       fep->ndev->name, speed, full_duplex ? "Full" : "Half");
-	if (fep->opened)
-		out_be32(&emacp->em0mr1, mode_reg);
+	emac_clean_tx_ring(dev);
+	emac_clean_rx_ring(dev);
+	free_irq(dev->def->irq, dev);
 
 	return 0;
 }
 
-static int emac_set_mac_address(struct net_device *ndev, void *p)
+static inline u16 emac_tx_csum(struct ocp_enet_private *dev,
+			       struct sk_buff *skb)
 {
-	struct ocp_enet_private *fep = ndev->priv;
-	emac_t *emacp = fep->emacp;
-	struct sockaddr *addr = p;
+#if defined(CONFIG_IBM_EMAC_TAH)
+	if (skb->ip_summed == CHECKSUM_HW) {
+		++dev->stats.tx_packets_csum;
+		return EMAC_TX_CTRL_TAH_CSUM;
+	}
+#endif
+	return 0;
+}
 
-	if (!is_valid_ether_addr(addr->sa_data))
-		return -EADDRNOTAVAIL;
+static inline int emac_xmit_finish(struct ocp_enet_private *dev, int len)
+{
+	struct emac_regs *p = dev->emacp;
+	struct net_device *ndev = dev->ndev;
 
-	memcpy(ndev->dev_addr, addr->sa_data, ndev->addr_len);
+	/* Send the packet out */
+	out_be32(&p->tmr0, EMAC_TMR0_XMIT);
 
-	/* set the high address */
-	out_be32(&emacp->em0iahr,
-		 (fep->ndev->dev_addr[0] << 8) | fep->ndev->dev_addr[1]);
+	if (unlikely(++dev->tx_cnt == NUM_TX_BUFF)) {
+		netif_stop_queue(ndev);
+		DBG2("%d: stopped TX queue" NL, dev->def->index);
+	}
 
-	/* set the low address */
-	out_be32(&emacp->em0ialr,
-		 (fep->ndev->dev_addr[2] << 24) | (fep->ndev->dev_addr[3] << 16)
-		 | (fep->ndev->dev_addr[4] << 8) | fep->ndev->dev_addr[5]);
+	ndev->trans_start = jiffies;
+	++dev->stats.tx_packets;
+	dev->stats.tx_bytes += len;
 
 	return 0;
 }
 
-static int emac_change_mtu(struct net_device *dev, int new_mtu)
+/* BHs disabled */
+static int emac_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 {
-	struct ocp_enet_private *fep = dev->priv;
-	int old_mtu = dev->mtu;
-	unsigned long mode_reg;
-	emac_t *emacp = fep->emacp;
-	u32 em0mr0;
-	int i, full;
-	unsigned long flags;
+	struct ocp_enet_private *dev = ndev->priv;
+	unsigned int len = skb->len;
+	int slot;
 
-	if ((new_mtu < EMAC_MIN_MTU) || (new_mtu > EMAC_MAX_MTU)) {
-		printk(KERN_ERR
-		       "emac: Invalid MTU setting, MTU must be between %d and %d\n",
-		       EMAC_MIN_MTU, EMAC_MAX_MTU);
-		return -EINVAL;
-	}
-
-	if (old_mtu != new_mtu && netif_running(dev)) {
-		/* Stop rx engine */
-		em0mr0 = in_be32(&emacp->em0mr0);
-		out_be32(&emacp->em0mr0, em0mr0 & ~EMAC_M0_RXE);
-
-		/* Wait for descriptors to be empty */
-		do {
-			full = 0;
-			for (i = 0; i < NUM_RX_BUFF; i++)
-				if (!(fep->rx_desc[i].ctrl & MAL_RX_CTRL_EMPTY)) {
-					printk(KERN_NOTICE
-					       "emac: RX ring is still full\n");
-					full = 1;
-				}
-		} while (full);
-
-		spin_lock_irqsave(&fep->lock, flags);
-
-		mal_disable_rx_channels(fep->mal, fep->commac.rx_chan_mask);
-
-		/* Destroy all old rx skbs */
-		for (i = 0; i < NUM_RX_BUFF; i++) {
-			dma_unmap_single(&fep->ocpdev->dev,
-					 fep->rx_desc[i].data_ptr,
-					 fep->rx_desc[i].data_len,
-					 DMA_FROM_DEVICE);
-			dev_kfree_skb(fep->rx_skb[i]);
-			fep->rx_skb[i] = NULL;
-		}
-
-		/* Set new rx_buffer_size, jumbo cap, and advertise new mtu */
-		mode_reg = in_be32(&emacp->em0mr1);
-		if (new_mtu > ENET_DEF_MTU_SIZE) {
-			mode_reg |= EMAC_M1_JUMBO_ENABLE;
-			fep->rx_buffer_size = EMAC_MAX_FRAME;
-		} else {
-			mode_reg &= ~EMAC_M1_JUMBO_ENABLE;
-			fep->rx_buffer_size = ENET_DEF_BUF_SIZE;
-		}
-		dev->mtu = new_mtu;
-		out_be32(&emacp->em0mr1, mode_reg);
+	u16 ctrl = EMAC_TX_CTRL_GFCS | EMAC_TX_CTRL_GP | MAL_TX_CTRL_READY |
+	    MAL_TX_CTRL_LAST | emac_tx_csum(dev, skb);
 
-		/* Re-init rx skbs */
-		fep->rx_slot = 0;
-		emac_rx_fill(dev, 0);
+	slot = dev->tx_slot++;
+	if (dev->tx_slot == NUM_TX_BUFF) {
+		dev->tx_slot = 0;
+		ctrl |= MAL_TX_CTRL_WRAP;
+	}
 
-		/* Restart the rx engine */
-		mal_enable_rx_channels(fep->mal, fep->commac.rx_chan_mask);
-		out_be32(&emacp->em0mr0, em0mr0 | EMAC_M0_RXE);
+	DBG2("%d: xmit(%u) %d" NL, dev->def->index, len, slot);
 
-		spin_unlock_irqrestore(&fep->lock, flags);
-	}
+	dev->tx_skb[slot] = skb;
+	dev->tx_desc[slot].data_ptr = dma_map_single(dev->ldev, skb->data, len,
+						     DMA_TO_DEVICE);
+	dev->tx_desc[slot].data_len = (u16) len;
+	barrier();
+	dev->tx_desc[slot].ctrl = ctrl;
 
-	return 0;
+	return emac_xmit_finish(dev, len);
 }
 
-static void __emac_set_multicast_list(struct net_device *dev)
+#if defined(CONFIG_IBM_EMAC_TAH)
+static inline int emac_xmit_split(struct ocp_enet_private *dev, int slot,
+				  u32 pd, int len, int last, u16 base_ctrl)
 {
-	struct ocp_enet_private *fep = dev->priv;
-	emac_t *emacp = fep->emacp;
-	u32 rmr = in_be32(&emacp->em0rmr);
-
-	/* First clear all special bits, they can be set later */
-	rmr &= ~(EMAC_RMR_PME | EMAC_RMR_PMME | EMAC_RMR_MAE);
-
-	if (dev->flags & IFF_PROMISC) {
-		rmr |= EMAC_RMR_PME;
-	} else if (dev->flags & IFF_ALLMULTI || 32 < dev->mc_count) {
-		/*
-		 * Must be setting up to use multicast
-		 * Now check for promiscuous multicast
-		 */
-		rmr |= EMAC_RMR_PMME;
-	} else if (dev->flags & IFF_MULTICAST && 0 < dev->mc_count) {
-		unsigned short em0gaht[4] = { 0, 0, 0, 0 };
-		struct dev_mc_list *dmi;
+	while (1) {
+		u16 ctrl = base_ctrl;
+		int chunk = min(len, MAL_MAX_TX_SIZE);
+		len -= chunk;
 
-		/* Need to hash on the multicast address. */
-		for (dmi = dev->mc_list; dmi; dmi = dmi->next) {
-			unsigned long mc_crc;
-			unsigned int bit_number;
+		slot = (slot + 1) % NUM_TX_BUFF;
 
-			mc_crc = ether_crc(6, (char *)dmi->dmi_addr);
-			bit_number = 63 - (mc_crc >> 26);	/* MSB: 0 LSB: 63 */
-			em0gaht[bit_number >> 4] |=
-			    0x8000 >> (bit_number & 0x0f);
-		}
-		emacp->em0gaht1 = em0gaht[0];
-		emacp->em0gaht2 = em0gaht[1];
-		emacp->em0gaht3 = em0gaht[2];
-		emacp->em0gaht4 = em0gaht[3];
+		if (last && !len)
+			ctrl |= MAL_TX_CTRL_LAST;
+		if (slot == NUM_TX_BUFF - 1)
+			ctrl |= MAL_TX_CTRL_WRAP;
 
-		/* Turn on multicast addressing */
-		rmr |= EMAC_RMR_MAE;
+		dev->tx_skb[slot] = NULL;
+		dev->tx_desc[slot].data_ptr = pd;
+		dev->tx_desc[slot].data_len = (u16) chunk;
+		dev->tx_desc[slot].ctrl = ctrl;
+		++dev->tx_cnt;
+
+		if (!len)
+			break;
+
+		pd += chunk;
 	}
-	out_be32(&emacp->em0rmr, rmr);
+	return slot;
 }
 
-static int emac_init_tah(struct ocp_enet_private *fep)
+/* BHs disabled (SG version for TAH equipped EMACs) */
+static int emac_start_xmit_sg(struct sk_buff *skb, struct net_device *ndev)
 {
-	tah_t *tahp;
+	struct ocp_enet_private *dev = ndev->priv;
+	int nr_frags = skb_shinfo(skb)->nr_frags;
+	int len = skb->len, chunk;
+	int slot, i;
+	u16 ctrl;
+	u32 pd;
+
+	/* This is common "fast" path */
+	if (likely(!nr_frags && len <= MAL_MAX_TX_SIZE))
+		return emac_start_xmit(skb, ndev);
 
-	/* Initialize TAH and enable checksum verification */
-	tahp = (tah_t *) ioremap(fep->tah_dev->def->paddr, sizeof(*tahp));
+	len -= skb->data_len;
 
-	if (tahp == NULL) {
-		printk(KERN_ERR "tah%d: Cannot ioremap TAH registers!\n",
-		       fep->tah_dev->def->index);
+	/* Note, this is only an *estimation*, we can still run out of empty
+	 * slots because of the additional fragmentation into
+	 * MAL_MAX_TX_SIZE-sized chunks
+	 */
+	if (unlikely(dev->tx_cnt + nr_frags + mal_tx_chunks(len) > NUM_TX_BUFF))
+		goto stop_queue;
 
-		return -ENOMEM;
+	ctrl = EMAC_TX_CTRL_GFCS | EMAC_TX_CTRL_GP | MAL_TX_CTRL_READY |
+	    emac_tx_csum(dev, skb);
+	slot = dev->tx_slot;
+
+	/* skb data */
+	dev->tx_skb[slot] = NULL;
+	chunk = min(len, MAL_MAX_TX_SIZE);
+	dev->tx_desc[slot].data_ptr = pd =
+	    dma_map_single(dev->ldev, skb->data, len, DMA_TO_DEVICE);
+	dev->tx_desc[slot].data_len = (u16) chunk;
+	len -= chunk;
+	if (unlikely(len))
+		slot = emac_xmit_split(dev, slot, pd + chunk, len, !nr_frags,
+				       ctrl);
+	/* skb fragments */
+	for (i = 0; i < nr_frags; ++i) {
+		struct skb_frag_struct *frag = &skb_shinfo(skb)->frags[i];
+		len = frag->size;
+
+		if (unlikely(dev->tx_cnt + mal_tx_chunks(len) >= NUM_TX_BUFF))
+			goto undo_frame;
+
+		pd = dma_map_page(dev->ldev, frag->page, frag->page_offset, len,
+				  DMA_TO_DEVICE);
+
+		slot = emac_xmit_split(dev, slot, pd, len, i == nr_frags - 1,
+				       ctrl);
 	}
 
-	out_be32(&tahp->tah_mr, TAH_MR_SR);
+	DBG2("%d: xmit_sg(%u) %d - %d" NL, dev->def->index, skb->len,
+	     dev->tx_slot, slot);
 
-	/* wait for reset to complete */
-	while (in_be32(&tahp->tah_mr) & TAH_MR_SR) ;
+	/* Attach skb to the last slot so we don't release it too early */
+	dev->tx_skb[slot] = skb;
 
-	/* 10KB TAH TX FIFO accomodates the max MTU of 9000 */
-	out_be32(&tahp->tah_mr,
-		 TAH_MR_CVR | TAH_MR_ST_768 | TAH_MR_TFS_10KB | TAH_MR_DTFP |
-		 TAH_MR_DIG);
+	/* Send the packet out */
+	if (dev->tx_slot == NUM_TX_BUFF - 1)
+		ctrl |= MAL_TX_CTRL_WRAP;
+	barrier();
+	dev->tx_desc[dev->tx_slot].ctrl = ctrl;
+	dev->tx_slot = (slot + 1) % NUM_TX_BUFF;
 
-	iounmap(tahp);
+	return emac_xmit_finish(dev, skb->len);
 
-	return 0;
+      undo_frame:
+	/* Well, too bad. Our previous estimation was overly optimistic.
+	 * Undo everything.
+	 */
+	while (slot != dev->tx_slot) {
+		dev->tx_desc[slot].ctrl = 0;
+		--dev->tx_cnt;
+		if (--slot < 0)
+			slot = NUM_TX_BUFF - 1;
+	}
+	++dev->estats.tx_undo;
+
+      stop_queue:
+	netif_stop_queue(ndev);
+	DBG2("%d: stopped TX queue" NL, dev->def->index);
+	return 1;
+}
+#else
+# define emac_start_xmit_sg	emac_start_xmit
+#endif	/* !defined(CONFIG_IBM_EMAC_TAH) */
+
+/* BHs disabled */
+static void emac_parse_tx_error(struct ocp_enet_private *dev, u16 ctrl)
+{
+	struct ibm_emac_error_stats *st = &dev->estats;
+	DBG("%d: BD TX error %04x" NL, dev->def->index, ctrl);
+
+	++st->tx_bd_errors;
+	if (ctrl & EMAC_TX_ST_BFCS)
+		++st->tx_bd_bad_fcs;
+	if (ctrl & EMAC_TX_ST_LCS)
+		++st->tx_bd_carrier_loss;
+	if (ctrl & EMAC_TX_ST_ED)
+		++st->tx_bd_excessive_deferral;
+	if (ctrl & EMAC_TX_ST_EC)
+		++st->tx_bd_excessive_collisions;
+	if (ctrl & EMAC_TX_ST_LC)
+		++st->tx_bd_late_collision;
+	if (ctrl & EMAC_TX_ST_MC)
+		++st->tx_bd_multple_collisions;
+	if (ctrl & EMAC_TX_ST_SC)
+		++st->tx_bd_single_collision;
+	if (ctrl & EMAC_TX_ST_UR)
+		++st->tx_bd_underrun;
+	if (ctrl & EMAC_TX_ST_SQE)
+		++st->tx_bd_sqe;
+}
+
+static void emac_poll_tx(void *param)
+{
+	struct ocp_enet_private *dev = param;
+	DBG2("%d: poll_tx, %d %d" NL, dev->def->index, dev->tx_cnt,
+	     dev->ack_slot);
+
+	if (dev->tx_cnt) {
+		u16 ctrl;
+		int slot = dev->ack_slot, n = 0;
+	      again:
+		ctrl = dev->tx_desc[slot].ctrl;
+		if (!(ctrl & MAL_TX_CTRL_READY)) {
+			struct sk_buff *skb = dev->tx_skb[slot];
+			++n;
+
+			if (skb) {
+				dev_kfree_skb(skb);
+				dev->tx_skb[slot] = NULL;
+			}
+			slot = (slot + 1) % NUM_TX_BUFF;
+
+			if (unlikely(EMAC_IS_BAD_TX(ctrl)))
+				emac_parse_tx_error(dev, ctrl);
+
+			if (--dev->tx_cnt)
+				goto again;
+		}
+		if (n) {
+			dev->ack_slot = slot;
+			if (netif_queue_stopped(dev->ndev) &&
+			    dev->tx_cnt < EMAC_TX_WAKEUP_THRESH)
+				netif_wake_queue(dev->ndev);
+
+			DBG2("%d: tx %d pkts" NL, dev->def->index, n);
+		}
+	}
 }
 
-static void emac_init_rings(struct net_device *dev)
+static inline void emac_recycle_rx_skb(struct ocp_enet_private *dev, int slot,
+				       int len)
 {
-	struct ocp_enet_private *ep = dev->priv;
-	int loop;
+	struct sk_buff *skb = dev->rx_skb[slot];
+	DBG2("%d: recycle %d %d" NL, dev->def->index, slot, len);
 
-	ep->tx_desc = (struct mal_descriptor *)((char *)ep->mal->tx_virt_addr +
-						(ep->mal_tx_chan *
-						 MAL_DT_ALIGN));
-	ep->rx_desc =
-	    (struct mal_descriptor *)((char *)ep->mal->rx_virt_addr +
-				      (ep->mal_rx_chan * MAL_DT_ALIGN));
-
-	/* Fill in the transmit descriptor ring. */
-	for (loop = 0; loop < NUM_TX_BUFF; loop++) {
-		if (ep->tx_skb[loop]) {
-			dma_unmap_single(&ep->ocpdev->dev,
-					 ep->tx_desc[loop].data_ptr,
-					 ep->tx_desc[loop].data_len,
-					 DMA_TO_DEVICE);
-			dev_kfree_skb_irq(ep->tx_skb[loop]);
-		}
-		ep->tx_skb[loop] = NULL;
-		ep->tx_desc[loop].ctrl = 0;
-		ep->tx_desc[loop].data_len = 0;
-		ep->tx_desc[loop].data_ptr = NULL;
-	}
-	ep->tx_desc[loop - 1].ctrl |= MAL_TX_CTRL_WRAP;
-
-	/* Format the receive descriptor ring. */
-	ep->rx_slot = 0;
-	/* Default is MTU=1500 + Ethernet overhead */
-	ep->rx_buffer_size = dev->mtu + ENET_HEADER_SIZE + ENET_FCS_SIZE;
-	emac_rx_fill(dev, 0);
-	if (ep->rx_slot != 0) {
-		printk(KERN_ERR
-		       "%s: Not enough mem for RxChain durning Open?\n",
-		       dev->name);
-		/*We couldn't fill the ring at startup?
-		 *We could clean up and fail to open but right now we will try to
-		 *carry on. It may be a sign of a bad NUM_RX_BUFF value
-		 */
-	}
+	if (len)
+		dma_map_single(dev->ldev, skb->data - 2,
+			       EMAC_DMA_ALIGN(len + 2), DMA_FROM_DEVICE);
 
-	ep->tx_cnt = 0;
-	ep->tx_slot = 0;
-	ep->ack_slot = 0;
+	dev->rx_desc[slot].data_len = 0;
+	barrier();
+	dev->rx_desc[slot].ctrl = MAL_RX_CTRL_EMPTY |
+	    (slot == (NUM_RX_BUFF - 1) ? MAL_RX_CTRL_WRAP : 0);
 }
 
-static void emac_reset_configure(struct ocp_enet_private *fep)
+static void emac_parse_rx_error(struct ocp_enet_private *dev, u16 ctrl)
 {
-	emac_t *emacp = fep->emacp;
-	int i;
+	struct ibm_emac_error_stats *st = &dev->estats;
+	DBG("%d: BD RX error %04x" NL, dev->def->index, ctrl);
 
-	mal_disable_tx_channels(fep->mal, fep->commac.tx_chan_mask);
-	mal_disable_rx_channels(fep->mal, fep->commac.rx_chan_mask);
+	++st->rx_bd_errors;
+	if (ctrl & EMAC_RX_ST_OE)
+		++st->rx_bd_overrun;
+	if (ctrl & EMAC_RX_ST_BP)
+		++st->rx_bd_bad_packet;
+	if (ctrl & EMAC_RX_ST_RP)
+		++st->rx_bd_runt_packet;
+	if (ctrl & EMAC_RX_ST_SE)
+		++st->rx_bd_short_event;
+	if (ctrl & EMAC_RX_ST_AE)
+		++st->rx_bd_alignment_error;
+	if (ctrl & EMAC_RX_ST_BFCS)
+		++st->rx_bd_bad_fcs;
+	if (ctrl & EMAC_RX_ST_PTL)
+		++st->rx_bd_packet_too_long;
+	if (ctrl & EMAC_RX_ST_ORE)
+		++st->rx_bd_out_of_range;
+	if (ctrl & EMAC_RX_ST_IRE)
+		++st->rx_bd_in_range;
+}
 
-	/*
-	 * Check for a link, some PHYs don't provide a clock if
-	 * no link is present.  Some EMACs will not come out of
-	 * soft reset without a PHY clock present.
-	 */
-	if (fep->phy_mii.def->ops->poll_link(&fep->phy_mii)) {
-		/* Reset the EMAC */
-		out_be32(&emacp->em0mr0, EMAC_M0_SRST);
-		udelay(20);
-		for (i = 0; i < 100; i++) {
-			if ((in_be32(&emacp->em0mr0) & EMAC_M0_SRST) == 0)
-				break;
-			udelay(10);
-		}
+static inline void emac_rx_csum(struct ocp_enet_private *dev,
+				struct sk_buff *skb, u16 ctrl)
+{
+#if defined(CONFIG_IBM_EMAC_TAH)
+	if (!ctrl && dev->tah_dev) {
+		skb->ip_summed = CHECKSUM_UNNECESSARY;
+		++dev->stats.rx_packets_csum;
+	}
+#endif
+}
 
-		if (i >= 100) {
-			printk(KERN_ERR "%s: Cannot reset EMAC\n",
-			       fep->ndev->name);
-			return;
+static inline int emac_rx_sg_append(struct ocp_enet_private *dev, int slot)
+{
+	if (likely(dev->rx_sg_skb != NULL)) {
+		int len = dev->rx_desc[slot].data_len;
+		int tot_len = dev->rx_sg_skb->len + len;
+
+		if (unlikely(tot_len + 2 > dev->rx_skb_size)) {
+			++dev->estats.rx_dropped_mtu;
+			dev_kfree_skb(dev->rx_sg_skb);
+			dev->rx_sg_skb = NULL;
+		} else {
+			cacheable_memcpy(dev->rx_sg_skb->tail,
+					 dev->rx_skb[slot]->data, len);
+			skb_put(dev->rx_sg_skb, len);
+			emac_recycle_rx_skb(dev, slot, len);
+			return 0;
 		}
 	}
+	emac_recycle_rx_skb(dev, slot, 0);
+	return -1;
+}
+
+/* BHs disabled */
+static int emac_poll_rx(void *param, int budget)
+{
+	struct ocp_enet_private *dev = param;
+	int slot = dev->rx_slot, received = 0;
 
-	/* Switch IRQs off for now */
-	out_be32(&emacp->em0iser, 0);
+	DBG2("%d: poll_rx(%d)" NL, dev->def->index, budget);
 
-	/* Configure MAL rx channel */
-	mal_set_rcbs(fep->mal, fep->mal_rx_chan, DESC_BUF_SIZE_REG);
+      again:
+	while (budget > 0) {
+		int len;
+		struct sk_buff *skb;
+		u16 ctrl = dev->rx_desc[slot].ctrl;
 
-	/* set the high address */
-	out_be32(&emacp->em0iahr,
-		 (fep->ndev->dev_addr[0] << 8) | fep->ndev->dev_addr[1]);
+		if (ctrl & MAL_RX_CTRL_EMPTY)
+			break;
 
-	/* set the low address */
-	out_be32(&emacp->em0ialr,
-		 (fep->ndev->dev_addr[2] << 24) | (fep->ndev->dev_addr[3] << 16)
-		 | (fep->ndev->dev_addr[4] << 8) | fep->ndev->dev_addr[5]);
+		skb = dev->rx_skb[slot];
+		barrier();
+		len = dev->rx_desc[slot].data_len;
+
+		if (unlikely(!MAL_IS_SINGLE_RX(ctrl)))
+			goto sg;
+
+		ctrl &= EMAC_BAD_RX_MASK;
+		if (unlikely(ctrl && ctrl != EMAC_RX_TAH_BAD_CSUM)) {
+			emac_parse_rx_error(dev, ctrl);
+			++dev->estats.rx_dropped_error;
+			emac_recycle_rx_skb(dev, slot, 0);
+			len = 0;
+			goto next;
+		}
+
+		if (len && len < EMAC_RX_COPY_THRESH) {
+			struct sk_buff *copy_skb =
+			    alloc_skb(len + EMAC_RX_SKB_HEADROOM + 2, GFP_ATOMIC);
+			if (unlikely(!copy_skb))
+				goto oom;
+
+			skb_reserve(copy_skb, EMAC_RX_SKB_HEADROOM + 2);
+			cacheable_memcpy(copy_skb->data - 2, skb->data - 2,
+					 len + 2);
+			emac_recycle_rx_skb(dev, slot, len);
+			skb = copy_skb;
+		} else if (unlikely(emac_alloc_rx_skb(dev, slot, GFP_ATOMIC)))
+			goto oom;
+
+		skb_put(skb, len);
+	      push_packet:
+		skb->dev = dev->ndev;
+		skb->protocol = eth_type_trans(skb, dev->ndev);
+		emac_rx_csum(dev, skb, ctrl);
+
+		if (unlikely(netif_receive_skb(skb) == NET_RX_DROP))
+			++dev->estats.rx_dropped_stack;
+	      next:
+		++dev->stats.rx_packets;
+	      skip:
+		dev->stats.rx_bytes += len;
+		slot = (slot + 1) % NUM_RX_BUFF;
+		--budget;
+		++received;
+		continue;
+	      sg:
+		if (ctrl & MAL_RX_CTRL_FIRST) {
+			BUG_ON(dev->rx_sg_skb);
+			if (unlikely(emac_alloc_rx_skb(dev, slot, GFP_ATOMIC))) {
+				DBG("%d: rx OOM %d" NL, dev->def->index, slot);
+				++dev->estats.rx_dropped_oom;
+				emac_recycle_rx_skb(dev, slot, 0);
+			} else {
+				dev->rx_sg_skb = skb;
+				skb_put(skb, len);
+			}
+		} else if (!emac_rx_sg_append(dev, slot) &&
+			   (ctrl & MAL_RX_CTRL_LAST)) {
 
-	/* Adjust to link */
-	if (netif_carrier_ok(fep->ndev))
-		emac_adjust_to_link(fep);
+			skb = dev->rx_sg_skb;
+			dev->rx_sg_skb = NULL;
 
-	/* enable broadcast/individual address and RX FIFO defaults */
-	out_be32(&emacp->em0rmr, EMAC_RMR_DEFAULT);
+			ctrl &= EMAC_BAD_RX_MASK;
+			if (unlikely(ctrl && ctrl != EMAC_RX_TAH_BAD_CSUM)) {
+				emac_parse_rx_error(dev, ctrl);
+				++dev->estats.rx_dropped_error;
+				dev_kfree_skb(skb);
+				len = 0;
+			} else
+				goto push_packet;
+		}
+		goto skip;
+	      oom:
+		DBG("%d: rx OOM %d" NL, dev->def->index, slot);
+		/* Drop the packet and recycle skb */
+		++dev->estats.rx_dropped_oom;
+		emac_recycle_rx_skb(dev, slot, 0);
+		goto next;
+	}
 
-	/* set transmit request threshold register */
-	out_be32(&emacp->em0trtr, EMAC_TRTR_DEFAULT);
+	if (received) {
+		DBG2("%d: rx %d BDs" NL, dev->def->index, received);
+		dev->rx_slot = slot;
+	}
 
-	/* Reconfigure multicast */
-	__emac_set_multicast_list(fep->ndev);
+	if (unlikely(budget && dev->commac.rx_stopped)) {
+		struct ocp_func_emac_data *emacdata = dev->def->additions;
 
-	/* Set receiver/transmitter defaults */
-	out_be32(&emacp->em0rwmr, EMAC_RWMR_DEFAULT);
-	out_be32(&emacp->em0tmr0, EMAC_TMR0_DEFAULT);
-	out_be32(&emacp->em0tmr1, EMAC_TMR1_DEFAULT);
+		barrier();
+		if (!(dev->rx_desc[slot].ctrl & MAL_RX_CTRL_EMPTY)) {
+			DBG2("%d: rx restart" NL, dev->def->index);
+			received = 0;
+			goto again;
+		}
 
-	/* set frame gap */
-	out_be32(&emacp->em0ipgvr, CONFIG_IBM_EMAC_FGAP);
-	
-	/* set VLAN Tag Protocol Identifier */
-	out_be32(&emacp->em0vtpid, 0x8100);
+		if (dev->rx_sg_skb) {
+			DBG2("%d: dropping partial rx packet" NL,
+			     dev->def->index);
+			++dev->estats.rx_dropped_error;
+			dev_kfree_skb(dev->rx_sg_skb);
+			dev->rx_sg_skb = NULL;
+		}
 
-	/* Init ring buffers */
-	emac_init_rings(fep->ndev);
+		dev->commac.rx_stopped = 0;
+		mal_enable_rx_channel(dev->mal, emacdata->mal_rx_chan);
+		emac_rx_enable(dev);
+		dev->rx_slot = 0;
+	}
+	return received;
 }
 
-static void emac_kick(struct ocp_enet_private *fep)
+/* BHs disabled */
+static int emac_peek_rx(void *param)
 {
-	emac_t *emacp = fep->emacp;
-	unsigned long emac_ier;
-
-	emac_ier = EMAC_ISR_PP | EMAC_ISR_BP | EMAC_ISR_RP |
-	    EMAC_ISR_SE | EMAC_ISR_PTLE | EMAC_ISR_ALE |
-	    EMAC_ISR_BFCS | EMAC_ISR_ORE | EMAC_ISR_IRE;
-
-	out_be32(&emacp->em0iser, emac_ier);
-
-	/* enable all MAL transmit and receive channels */
-	mal_enable_tx_channels(fep->mal, fep->commac.tx_chan_mask);
-	mal_enable_rx_channels(fep->mal, fep->commac.rx_chan_mask);
-
-	/* set transmit and receive enable */
-	out_be32(&emacp->em0mr0, EMAC_M0_TXE | EMAC_M0_RXE);
+	struct ocp_enet_private *dev = param;
+	return !(dev->rx_desc[dev->rx_slot].ctrl & MAL_RX_CTRL_EMPTY);
 }
 
-static void
-emac_start_link(struct ocp_enet_private *fep, struct ethtool_cmd *ep)
+/* BHs disabled */
+static int emac_peek_rx_sg(void *param)
 {
-	u32 advertise;
-	int autoneg;
-	int forced_speed;
-	int forced_duplex;
+	struct ocp_enet_private *dev = param;
+	int slot = dev->rx_slot;
+	while (1) {
+		u16 ctrl = dev->rx_desc[slot].ctrl;
+		if (ctrl & MAL_RX_CTRL_EMPTY)
+			return 0;
+		else if (ctrl & MAL_RX_CTRL_LAST)
+			return 1;
+
+		slot = (slot + 1) % NUM_RX_BUFF;
+
+		/* I'm just being paranoid here :) */
+		if (unlikely(slot == dev->rx_slot))
+			return 0;
+	}
+}
 
-	/* Default advertise */
-	advertise = ADVERTISED_10baseT_Half | ADVERTISED_10baseT_Full |
-	    ADVERTISED_100baseT_Half | ADVERTISED_100baseT_Full |
-	    ADVERTISED_1000baseT_Half | ADVERTISED_1000baseT_Full;
-	autoneg = fep->want_autoneg;
-	forced_speed = fep->phy_mii.speed;
-	forced_duplex = fep->phy_mii.duplex;
+/* Hard IRQ */
+static void emac_rxde(void *param)
+{
+	struct ocp_enet_private *dev = param;
+	++dev->estats.rx_stopped;
+	emac_rx_disable_async(dev);
+}
+
+/* Hard IRQ */
+static irqreturn_t emac_irq(int irq, void *dev_instance, struct pt_regs *regs)
+{
+	struct ocp_enet_private *dev = dev_instance;
+	struct emac_regs *p = dev->emacp;
+	struct ibm_emac_error_stats *st = &dev->estats;
+
+	u32 isr = in_be32(&p->isr);
+	out_be32(&p->isr, isr);
+
+	DBG("%d: isr = %08x" NL, dev->def->index, isr);
+
+	if (isr & EMAC_ISR_TXPE)
+		++st->tx_parity;
+	if (isr & EMAC_ISR_RXPE)
+		++st->rx_parity;
+	if (isr & EMAC_ISR_TXUE)
+		++st->tx_underrun;
+	if (isr & EMAC_ISR_RXOE)
+		++st->rx_fifo_overrun;
+	if (isr & EMAC_ISR_OVR)
+		++st->rx_overrun;
+	if (isr & EMAC_ISR_BP)
+		++st->rx_bad_packet;
+	if (isr & EMAC_ISR_RP)
+		++st->rx_runt_packet;
+	if (isr & EMAC_ISR_SE)
+		++st->rx_short_event;
+	if (isr & EMAC_ISR_ALE)
+		++st->rx_alignment_error;
+	if (isr & EMAC_ISR_BFCS)
+		++st->rx_bad_fcs;
+	if (isr & EMAC_ISR_PTLE)
+		++st->rx_packet_too_long;
+	if (isr & EMAC_ISR_ORE)
+		++st->rx_out_of_range;
+	if (isr & EMAC_ISR_IRE)
+		++st->rx_in_range;
+	if (isr & EMAC_ISR_SQE)
+		++st->tx_sqe;
+	if (isr & EMAC_ISR_TE)
+		++st->tx_errors;
 
-	/* Setup link parameters */
-	if (ep) {
-		if (ep->autoneg == AUTONEG_ENABLE) {
-			advertise = ep->advertising;
-			autoneg = 1;
-		} else {
-			autoneg = 0;
-			forced_speed = ep->speed;
-			forced_duplex = ep->duplex;
-		}
-	}
+	return IRQ_HANDLED;
+}
 
-	/* Configure PHY & start aneg */
-	fep->want_autoneg = autoneg;
-	if (autoneg) {
-		LINK_DEBUG(("%s: start link aneg, advertise: 0x%x\n",
-			    fep->ndev->name, advertise));
-		fep->phy_mii.def->ops->setup_aneg(&fep->phy_mii, advertise);
-	} else {
-		LINK_DEBUG(("%s: start link forced, speed: %d, duplex: %d\n",
-			    fep->ndev->name, forced_speed, forced_duplex));
-		fep->phy_mii.def->ops->setup_forced(&fep->phy_mii, forced_speed,
-						    forced_duplex);
-	}
-	fep->timer_ticks = 0;
-	mod_timer(&fep->link_timer, jiffies + HZ);
+static struct net_device_stats *emac_stats(struct net_device *ndev)
+{
+	struct ocp_enet_private *dev = ndev->priv;
+	struct ibm_emac_stats *st = &dev->stats;
+	struct ibm_emac_error_stats *est = &dev->estats;
+	struct net_device_stats *nst = &dev->nstats;
+
+	DBG2("%d: stats" NL, dev->def->index);
+
+	/* Compute "legacy" statistics */
+	local_irq_disable();
+	nst->rx_packets = (unsigned long)st->rx_packets;
+	nst->rx_bytes = (unsigned long)st->rx_bytes;
+	nst->tx_packets = (unsigned long)st->tx_packets;
+	nst->tx_bytes = (unsigned long)st->tx_bytes;
+	nst->rx_dropped = (unsigned long)(est->rx_dropped_oom +
+					  est->rx_dropped_error +
+					  est->rx_dropped_resize +
+					  est->rx_dropped_mtu);
+	nst->tx_dropped = (unsigned long)est->tx_dropped;
+
+	nst->rx_errors = (unsigned long)est->rx_bd_errors;
+	nst->rx_fifo_errors = (unsigned long)(est->rx_bd_overrun +
+					      est->rx_fifo_overrun +
+					      est->rx_overrun);
+	nst->rx_frame_errors = (unsigned long)(est->rx_bd_alignment_error +
+					       est->rx_alignment_error);
+	nst->rx_crc_errors = (unsigned long)(est->rx_bd_bad_fcs +
+					     est->rx_bad_fcs);
+	nst->rx_length_errors = (unsigned long)(est->rx_bd_runt_packet +
+						est->rx_bd_short_event +
+						est->rx_bd_packet_too_long +
+						est->rx_bd_out_of_range +
+						est->rx_bd_in_range +
+						est->rx_runt_packet +
+						est->rx_short_event +
+						est->rx_packet_too_long +
+						est->rx_out_of_range +
+						est->rx_in_range);
+
+	nst->tx_errors = (unsigned long)(est->tx_bd_errors + est->tx_errors);
+	nst->tx_fifo_errors = (unsigned long)(est->tx_bd_underrun +
+					      est->tx_underrun);
+	nst->tx_carrier_errors = (unsigned long)est->tx_bd_carrier_loss;
+	nst->collisions = (unsigned long)(est->tx_bd_excessive_deferral +
+					  est->tx_bd_excessive_collisions +
+					  est->tx_bd_late_collision +
+					  est->tx_bd_multple_collisions);
+	local_irq_enable();
+	return nst;
 }
 
-static void emac_link_timer(unsigned long data)
+static void emac_remove(struct ocp_device *ocpdev)
 {
-	struct ocp_enet_private *fep = (struct ocp_enet_private *)data;
-	int link;
+	struct ocp_enet_private *dev = ocp_get_drvdata(ocpdev);
 
-	if (fep->going_away)
-		return;
+	DBG("%d: remove" NL, dev->def->index);
 
-	spin_lock_irq(&fep->lock);
+	ocp_set_drvdata(ocpdev, 0);
+	unregister_netdev(dev->ndev);
 
-	link = fep->phy_mii.def->ops->poll_link(&fep->phy_mii);
-	LINK_DEBUG(("%s: poll_link: %d\n", fep->ndev->name, link));
+	tah_fini(dev->tah_dev);
+	rgmii_fini(dev->rgmii_dev, dev->rgmii_input);
+	zmii_fini(dev->zmii_dev, dev->zmii_input);
 
-	if (link == netif_carrier_ok(fep->ndev)) {
-		if (!link && fep->want_autoneg && (++fep->timer_ticks) > 10)
-			emac_start_link(fep, NULL);
-		goto out;
-	}
-	printk(KERN_INFO "%s: Link is %s\n", fep->ndev->name,
-	       link ? "Up" : "Down");
-	if (link) {
-		netif_carrier_on(fep->ndev);
-		/* Chip needs a full reset on config change. That sucks, so I
-		 * should ultimately move that to some tasklet to limit
-		 * latency peaks caused by this code
-		 */
-		emac_reset_configure(fep);
-		if (fep->opened)
-			emac_kick(fep);
-	} else {
-		fep->timer_ticks = 0;
-		netif_carrier_off(fep->ndev);
-	}
-      out:
-	mod_timer(&fep->link_timer, jiffies + HZ);
-	spin_unlock_irq(&fep->lock);
+	emac_dbg_register(dev->def->index, 0);
+
+	mal_unregister_commac(dev->mal, &dev->commac);
+	iounmap((void *)dev->emacp);
+	kfree(dev->ndev);
 }
 
-static void emac_set_multicast_list(struct net_device *dev)
-{
-	struct ocp_enet_private *fep = dev->priv;
+static struct mal_commac_ops emac_commac_ops = {
+	.poll_tx = &emac_poll_tx,
+	.poll_rx = &emac_poll_rx,
+	.peek_rx = &emac_peek_rx,
+	.rxde = &emac_rxde,
+};
 
-	spin_lock_irq(&fep->lock);
-	__emac_set_multicast_list(dev);
-	spin_unlock_irq(&fep->lock);
-}
+static struct mal_commac_ops emac_commac_sg_ops = {
+	.poll_tx = &emac_poll_tx,
+	.poll_rx = &emac_poll_rx,
+	.peek_rx = &emac_peek_rx_sg,
+	.rxde = &emac_rxde,
+};
 
-static int emac_get_settings(struct net_device *ndev, struct ethtool_cmd *cmd)
+/* Ethtool support */
+static int emac_ethtool_get_settings(struct net_device *ndev,
+				     struct ethtool_cmd *cmd)
 {
-	struct ocp_enet_private *fep = ndev->priv;
+	struct ocp_enet_private *dev = ndev->priv;
 
-	cmd->supported = fep->phy_mii.def->features;
+	cmd->supported = dev->phy.features;
 	cmd->port = PORT_MII;
-	cmd->transceiver = XCVR_EXTERNAL;
-	cmd->phy_address = fep->mii_phy_addr;
-	spin_lock_irq(&fep->lock);
-	cmd->autoneg = fep->want_autoneg;
-	cmd->speed = fep->phy_mii.speed;
-	cmd->duplex = fep->phy_mii.duplex;
-	spin_unlock_irq(&fep->lock);
+	cmd->phy_address = dev->phy.address;
+	cmd->transceiver =
+	    dev->phy.address >= 0 ? XCVR_EXTERNAL : XCVR_INTERNAL;
+
+	local_bh_disable();
+	cmd->advertising = dev->phy.advertising;
+	cmd->autoneg = dev->phy.autoneg;
+	cmd->speed = dev->phy.speed;
+	cmd->duplex = dev->phy.duplex;
+	local_bh_enable();
+
 	return 0;
 }
 
-static int emac_set_settings(struct net_device *ndev, struct ethtool_cmd *cmd)
+static int emac_ethtool_set_settings(struct net_device *ndev,
+				     struct ethtool_cmd *cmd)
 {
-	struct ocp_enet_private *fep = ndev->priv;
-	unsigned long features = fep->phy_mii.def->features;
+	struct ocp_enet_private *dev = ndev->priv;
+	u32 f = dev->phy.features;
 
-	if (!capable(CAP_NET_ADMIN))
-		return -EPERM;
+	DBG("%d: set_settings(%d, %d, %d, 0x%08x)" NL, dev->def->index,
+	    cmd->autoneg, cmd->speed, cmd->duplex, cmd->advertising);
 
+	/* Basic sanity checks */
+	if (dev->phy.address < 0)
+		return -EOPNOTSUPP;
 	if (cmd->autoneg != AUTONEG_ENABLE && cmd->autoneg != AUTONEG_DISABLE)
 		return -EINVAL;
 	if (cmd->autoneg == AUTONEG_ENABLE && cmd->advertising == 0)
 		return -EINVAL;
 	if (cmd->duplex != DUPLEX_HALF && cmd->duplex != DUPLEX_FULL)
 		return -EINVAL;
-	if (cmd->autoneg == AUTONEG_DISABLE)
+
+	if (cmd->autoneg == AUTONEG_DISABLE) {
 		switch (cmd->speed) {
 		case SPEED_10:
-			if (cmd->duplex == DUPLEX_HALF &&
-			    (features & SUPPORTED_10baseT_Half) == 0)
+			if (cmd->duplex == DUPLEX_HALF
+			    && !(f & SUPPORTED_10baseT_Half))
 				return -EINVAL;
-			if (cmd->duplex == DUPLEX_FULL &&
-			    (features & SUPPORTED_10baseT_Full) == 0)
+			if (cmd->duplex == DUPLEX_FULL
+			    && !(f & SUPPORTED_10baseT_Full))
 				return -EINVAL;
 			break;
 		case SPEED_100:
-			if (cmd->duplex == DUPLEX_HALF &&
-			    (features & SUPPORTED_100baseT_Half) == 0)
+			if (cmd->duplex == DUPLEX_HALF
+			    && !(f & SUPPORTED_100baseT_Half))
 				return -EINVAL;
-			if (cmd->duplex == DUPLEX_FULL &&
-			    (features & SUPPORTED_100baseT_Full) == 0)
+			if (cmd->duplex == DUPLEX_FULL
+			    && !(f & SUPPORTED_100baseT_Full))
 				return -EINVAL;
 			break;
 		case SPEED_1000:
-			if (cmd->duplex == DUPLEX_HALF &&
-			    (features & SUPPORTED_1000baseT_Half) == 0)
+			if (cmd->duplex == DUPLEX_HALF
+			    && !(f & SUPPORTED_1000baseT_Half))
 				return -EINVAL;
-			if (cmd->duplex == DUPLEX_FULL &&
-			    (features & SUPPORTED_1000baseT_Full) == 0)
+			if (cmd->duplex == DUPLEX_FULL
+			    && !(f & SUPPORTED_1000baseT_Full))
 				return -EINVAL;
 			break;
 		default:
 			return -EINVAL;
-	} else if ((features & SUPPORTED_Autoneg) == 0)
-		return -EINVAL;
-	spin_lock_irq(&fep->lock);
-	emac_start_link(fep, cmd);
-	spin_unlock_irq(&fep->lock);
+		}
+
+		local_bh_disable();
+		dev->phy.def->ops->setup_forced(&dev->phy, cmd->speed,
+						cmd->duplex);
+
+	} else {
+		if (!(f & SUPPORTED_Autoneg))
+			return -EINVAL;
+
+		local_bh_disable();
+		dev->phy.def->ops->setup_aneg(&dev->phy,
+					      (cmd->advertising & f) |
+					      (dev->phy.advertising &
+					       (ADVERTISED_Pause |
+						ADVERTISED_Asym_Pause)));
+	}
+	emac_force_link_update(dev);
+	local_bh_enable();
+
 	return 0;
 }
 
-static void
-emac_get_drvinfo(struct net_device *ndev, struct ethtool_drvinfo *info)
+static void emac_ethtool_get_ringparam(struct net_device *ndev,
+				       struct ethtool_ringparam *rp)
 {
-	struct ocp_enet_private *fep = ndev->priv;
+	rp->rx_max_pending = rp->rx_pending = NUM_RX_BUFF;
+	rp->tx_max_pending = rp->tx_pending = NUM_TX_BUFF;
+}
 
-	strcpy(info->driver, DRV_NAME);
-	strcpy(info->version, DRV_VERSION);
-	info->fw_version[0] = '\0';
-	sprintf(info->bus_info, "IBM EMAC %d", fep->ocpdev->def->index);
-	info->regdump_len = 0;
+static void emac_ethtool_get_pauseparam(struct net_device *ndev,
+					struct ethtool_pauseparam *pp)
+{
+	struct ocp_enet_private *dev = ndev->priv;
+
+	local_bh_disable();
+	if ((dev->phy.features & SUPPORTED_Autoneg) &&
+	    (dev->phy.advertising & (ADVERTISED_Pause | ADVERTISED_Asym_Pause)))
+		pp->autoneg = 1;
+
+	if (dev->phy.duplex == DUPLEX_FULL) {
+		if (dev->phy.pause)
+			pp->rx_pause = pp->tx_pause = 1;
+		else if (dev->phy.asym_pause)
+			pp->tx_pause = 1;
+	}
+	local_bh_enable();
 }
 
-static int emac_nway_reset(struct net_device *ndev)
+static u32 emac_ethtool_get_rx_csum(struct net_device *ndev)
 {
-	struct ocp_enet_private *fep = ndev->priv;
+	struct ocp_enet_private *dev = ndev->priv;
+	return dev->tah_dev != 0;
+}
 
-	if (!fep->want_autoneg)
-		return -EINVAL;
-	spin_lock_irq(&fep->lock);
-	emac_start_link(fep, NULL);
-	spin_unlock_irq(&fep->lock);
-	return 0;
+static int emac_get_regs_len(struct ocp_enet_private *dev)
+{
+	return sizeof(struct emac_ethtool_regs_subhdr) + EMAC_ETHTOOL_REGS_SIZE;
 }
 
-static u32 emac_get_link(struct net_device *ndev)
+static int emac_ethtool_get_regs_len(struct net_device *ndev)
 {
-	return netif_carrier_ok(ndev);
+	struct ocp_enet_private *dev = ndev->priv;
+	return sizeof(struct emac_ethtool_regs_hdr) +
+	    emac_get_regs_len(dev) + mal_get_regs_len(dev->mal) +
+	    zmii_get_regs_len(dev->zmii_dev) +
+	    rgmii_get_regs_len(dev->rgmii_dev) +
+	    tah_get_regs_len(dev->tah_dev);
 }
 
-static struct ethtool_ops emac_ethtool_ops = {
-	.get_settings = emac_get_settings,
-	.set_settings = emac_set_settings,
-	.get_drvinfo = emac_get_drvinfo,
-	.nway_reset = emac_nway_reset,
-	.get_link = emac_get_link
-};
+static void *emac_dump_regs(struct ocp_enet_private *dev, void *buf)
+{
+	struct emac_ethtool_regs_subhdr *hdr = buf;
 
-static int emac_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
+	hdr->version = EMAC_ETHTOOL_REGS_VER;
+	hdr->index = dev->def->index;
+	memcpy_fromio(hdr + 1, dev->emacp, EMAC_ETHTOOL_REGS_SIZE);
+	return ((void *)(hdr + 1) + EMAC_ETHTOOL_REGS_SIZE);
+}
+
+static void emac_ethtool_get_regs(struct net_device *ndev,
+				  struct ethtool_regs *regs, void *buf)
 {
-	struct ocp_enet_private *fep = dev->priv;
-	uint16_t *data = (uint16_t *) & rq->ifr_ifru;
+	struct ocp_enet_private *dev = ndev->priv;
+	struct emac_ethtool_regs_hdr *hdr = buf;
 
-	switch (cmd) {
-	case SIOCGMIIPHY:
-		data[0] = fep->mii_phy_addr;
-		/* Fall through */
-	case SIOCGMIIREG:
-		data[3] = emac_phy_read(dev, fep->mii_phy_addr, data[1]);
-		return 0;
-	case SIOCSMIIREG:
-		if (!capable(CAP_NET_ADMIN))
-			return -EPERM;
+	hdr->components = 0;
+	buf = hdr + 1;
 
-		emac_phy_write(dev, fep->mii_phy_addr, data[1], data[2]);
-		return 0;
-	default:
-		return -EOPNOTSUPP;
+	local_irq_disable();
+	buf = mal_dump_regs(dev->mal, buf);
+	buf = emac_dump_regs(dev, buf);
+	if (dev->zmii_dev) {
+		hdr->components |= EMAC_ETHTOOL_REGS_ZMII;
+		buf = zmii_dump_regs(dev->zmii_dev, buf);
+	}
+	if (dev->rgmii_dev) {
+		hdr->components |= EMAC_ETHTOOL_REGS_RGMII;
+		buf = rgmii_dump_regs(dev->rgmii_dev, buf);
+	}
+	if (dev->tah_dev) {
+		hdr->components |= EMAC_ETHTOOL_REGS_TAH;
+		buf = tah_dump_regs(dev->tah_dev, buf);
 	}
+	local_irq_enable();
 }
 
-static int emac_open(struct net_device *dev)
+static int emac_ethtool_nway_reset(struct net_device *ndev)
 {
-	struct ocp_enet_private *fep = dev->priv;
-	int rc;
+	struct ocp_enet_private *dev = ndev->priv;
+	int res = 0;
 
-	spin_lock_irq(&fep->lock);
+	DBG("%d: nway_reset" NL, dev->def->index);
 
-	fep->opened = 1;
-	netif_carrier_off(dev);
+	if (dev->phy.address < 0)
+		return -EOPNOTSUPP;
 
-	/* Reset & configure the chip */
-	emac_reset_configure(fep);
+	local_bh_disable();
+	if (!dev->phy.autoneg) {
+		res = -EINVAL;
+		goto out;
+	}
 
-	spin_unlock_irq(&fep->lock);
+	dev->phy.def->ops->setup_aneg(&dev->phy, dev->phy.advertising);
+	emac_force_link_update(dev);
 
-	/* Request our interrupt lines */
-	rc = request_irq(dev->irq, emac_mac_irq, 0, "IBM EMAC MAC", dev);
-	if (rc != 0) {
-		printk("dev->irq %d failed\n", dev->irq);
-		goto bail;
-	}
-	/* Kick the chip rx & tx channels into life */
-	spin_lock_irq(&fep->lock);
-	emac_kick(fep);
-	spin_unlock_irq(&fep->lock);
+      out:
+	local_bh_enable();
+	return res;
+}
+
+static int emac_ethtool_get_stats_count(struct net_device *ndev)
+{
+	return EMAC_ETHTOOL_STATS_COUNT;
+}
 
-	netif_start_queue(dev);
-      bail:
-	return rc;
+static void emac_ethtool_get_strings(struct net_device *ndev, u32 stringset,
+				     u8 * buf)
+{
+	if (stringset == ETH_SS_STATS)
+		memcpy(buf, &emac_stats_keys, sizeof(emac_stats_keys));
 }
 
-static int emac_close(struct net_device *dev)
+static void emac_ethtool_get_ethtool_stats(struct net_device *ndev,
+					   struct ethtool_stats *estats,
+					   u64 * tmp_stats)
 {
-	struct ocp_enet_private *fep = dev->priv;
-	emac_t *emacp = fep->emacp;
+	struct ocp_enet_private *dev = ndev->priv;
+	local_irq_disable();
+	memcpy(tmp_stats, &dev->stats, sizeof(dev->stats));
+	tmp_stats += sizeof(dev->stats) / sizeof(u64);
+	memcpy(tmp_stats, &dev->estats, sizeof(dev->estats));
+	local_irq_enable();
+}
 
-	/* XXX Stop IRQ emitting here */
-	spin_lock_irq(&fep->lock);
-	fep->opened = 0;
-	mal_disable_tx_channels(fep->mal, fep->commac.tx_chan_mask);
-	mal_disable_rx_channels(fep->mal, fep->commac.rx_chan_mask);
-	netif_carrier_off(dev);
-	netif_stop_queue(dev);
+static void emac_ethtool_get_drvinfo(struct net_device *ndev,
+				     struct ethtool_drvinfo *info)
+{
+	struct ocp_enet_private *dev = ndev->priv;
 
-	/*
-	 * Check for a link, some PHYs don't provide a clock if
-	 * no link is present.  Some EMACs will not come out of
-	 * soft reset without a PHY clock present.
-	 */
-	if (fep->phy_mii.def->ops->poll_link(&fep->phy_mii)) {
-		out_be32(&emacp->em0mr0, EMAC_M0_SRST);
-		udelay(10);
+	strcpy(info->driver, "ibm_emac");
+	strcpy(info->version, DRV_VERSION);
+	info->fw_version[0] = '\0';
+	sprintf(info->bus_info, "PPC 4xx EMAC %d", dev->def->index);
+	info->n_stats = emac_ethtool_get_stats_count(ndev);
+	info->regdump_len = emac_ethtool_get_regs_len(ndev);
+}
 
-		if (emacp->em0mr0 & EMAC_M0_SRST) {
-			/*not sure what to do here hopefully it clears before another open */
-			printk(KERN_ERR
-			       "%s: Phy SoftReset didn't clear, no link?\n",
-			       dev->name);
-		}
-	}
+static struct ethtool_ops emac_ethtool_ops = {
+	.get_settings = emac_ethtool_get_settings,
+	.set_settings = emac_ethtool_set_settings,
+	.get_drvinfo = emac_ethtool_get_drvinfo,
 
-	/* Free the irq's */
-	free_irq(dev->irq, dev);
+	.get_regs_len = emac_ethtool_get_regs_len,
+	.get_regs = emac_ethtool_get_regs,
 
-	spin_unlock_irq(&fep->lock);
+	.nway_reset = emac_ethtool_nway_reset,
 
-	return 0;
-}
+	.get_ringparam = emac_ethtool_get_ringparam,
+	.get_pauseparam = emac_ethtool_get_pauseparam,
 
-static void emac_remove(struct ocp_device *ocpdev)
-{
-	struct net_device *dev = ocp_get_drvdata(ocpdev);
-	struct ocp_enet_private *ep = dev->priv;
+	.get_rx_csum = emac_ethtool_get_rx_csum,
 
-	/* FIXME: locking, races, ... */
-	ep->going_away = 1;
-	ocp_set_drvdata(ocpdev, NULL);
-	if (ep->rgmii_dev)
-		emac_close_rgmii(ep->rgmii_dev);
-	if (ep->zmii_dev)
-		emac_close_zmii(ep->zmii_dev);
-
-	unregister_netdev(dev);
-	del_timer_sync(&ep->link_timer);
-	mal_unregister_commac(ep->mal, &ep->commac);
-	iounmap((void *)ep->emacp);
-	kfree(dev);
-}
-
-struct mal_commac_ops emac_commac_ops = {
-	.txeob = &emac_txeob_dev,
-	.txde = &emac_txde_dev,
-	.rxeob = &emac_rxeob_dev,
-	.rxde = &emac_rxde_dev,
+	.get_strings = emac_ethtool_get_strings,
+	.get_stats_count = emac_ethtool_get_stats_count,
+	.get_ethtool_stats = emac_ethtool_get_ethtool_stats,
+
+	.get_link = ethtool_op_get_link,
+	.get_tx_csum = ethtool_op_get_tx_csum,
+	.get_sg = ethtool_op_get_sg,
 };
 
-#ifdef CONFIG_NET_POLL_CONTROLLER
-static void emac_netpoll(struct net_device *ndev)
+static int emac_ioctl(struct net_device *ndev, struct ifreq *rq, int cmd)
 {
-	emac_rxeob_dev((void *)ndev, 0);
-	emac_txeob_dev((void *)ndev, 0);
+	struct ocp_enet_private *dev = ndev->priv;
+	uint16_t *data = (uint16_t *) & rq->ifr_ifru;
+
+	DBG("%d: ioctl %08x" NL, dev->def->index, cmd);
+
+	if (dev->phy.address < 0)
+		return -EOPNOTSUPP;
+
+	switch (cmd) {
+	case SIOCGMIIPHY:
+	case SIOCDEVPRIVATE:
+		data[0] = dev->phy.address;
+		/* Fall through */
+	case SIOCGMIIREG:
+	case SIOCDEVPRIVATE + 1:
+		data[3] = emac_mdio_read(ndev, dev->phy.address, data[1]);
+		return 0;
+
+	case SIOCSMIIREG:
+	case SIOCDEVPRIVATE + 2:
+		if (!capable(CAP_NET_ADMIN))
+			return -EPERM;
+		emac_mdio_write(ndev, dev->phy.address, data[1], data[2]);
+		return 0;
+	default:
+		return -EOPNOTSUPP;
+	}
 }
-#endif
 
-static int emac_init_device(struct ocp_device *ocpdev, struct ibm_ocp_mal *mal)
+static int __init emac_probe(struct ocp_device *ocpdev)
 {
-	int deferred_init = 0;
-	int rc = 0, i;
+	struct ocp_func_emac_data *emacdata = ocpdev->def->additions;
 	struct net_device *ndev;
-	struct ocp_enet_private *ep;
-	struct ocp_func_emac_data *emacdata;
-	int commac_reg = 0;
-	u32 phy_map;
+	struct ocp_device *maldev;
+	struct ocp_enet_private *dev;
+	int err, i;
+
+	DBG("%d: probe" NL, ocpdev->def->index);
 
-	emacdata = (struct ocp_func_emac_data *)ocpdev->def->additions;
 	if (!emacdata) {
 		printk(KERN_ERR "emac%d: Missing additional data!\n",
 		       ocpdev->def->index);
@@ -1738,304 +1936,312 @@ static int emac_init_device(struct ocp_d
 
 	/* Allocate our net_device structure */
 	ndev = alloc_etherdev(sizeof(struct ocp_enet_private));
-	if (ndev == NULL) {
-		printk(KERN_ERR
-		       "emac%d: Could not allocate ethernet device.\n",
+	if (!ndev) {
+		printk(KERN_ERR "emac%d: could not allocate ethernet device!\n",
 		       ocpdev->def->index);
 		return -ENOMEM;
 	}
-	ep = ndev->priv;
-	ep->ndev = ndev;
-	ep->ocpdev = ocpdev;
-	ndev->irq = ocpdev->def->irq;
-	ep->wol_irq = emacdata->wol_irq;
-	if (emacdata->mdio_idx >= 0) {
-		if (emacdata->mdio_idx == ocpdev->def->index) {
-			/* Set the common MDIO net_device */
-			mdio_ndev = ndev;
-			deferred_init = 1;
+	dev = ndev->priv;
+	dev->ndev = ndev;
+	dev->ldev = &ocpdev->dev;
+	dev->def = ocpdev->def;
+	SET_MODULE_OWNER(ndev);
+
+	/* Find MAL device we are connected to */
+	maldev =
+	    ocp_find_device(OCP_VENDOR_IBM, OCP_FUNC_MAL, emacdata->mal_idx);
+	if (!maldev) {
+		printk(KERN_ERR "emac%d: unknown mal%d device!\n",
+		       dev->def->index, emacdata->mal_idx);
+		err = -ENODEV;
+		goto out;
+	}
+	dev->mal = ocp_get_drvdata(maldev);
+	if (!dev->mal) {
+		printk(KERN_ERR "emac%d: mal%d hasn't been initialized yet!\n",
+		       dev->def->index, emacdata->mal_idx);
+		err = -ENODEV;
+		goto out;
+	}
+
+	/* Register with MAL */
+	dev->commac.ops = &emac_commac_ops;
+	dev->commac.dev = dev;
+	dev->commac.tx_chan_mask = MAL_CHAN_MASK(emacdata->mal_tx_chan);
+	dev->commac.rx_chan_mask = MAL_CHAN_MASK(emacdata->mal_rx_chan);
+	err = mal_register_commac(dev->mal, &dev->commac);
+	if (err) {
+		printk(KERN_ERR "emac%d: failed to register with mal%d!\n",
+		       dev->def->index, emacdata->mal_idx);
+		goto out;
+	}
+	dev->rx_skb_size = emac_rx_skb_size(ndev->mtu);
+	dev->rx_sync_size = emac_rx_sync_size(ndev->mtu);
+
+	/* Get pointers to BD rings */
+	dev->tx_desc =
+	    dev->mal->bd_virt + mal_tx_bd_offset(dev->mal,
+						 emacdata->mal_tx_chan);
+	dev->rx_desc =
+	    dev->mal->bd_virt + mal_rx_bd_offset(dev->mal,
+						 emacdata->mal_rx_chan);
+
+	DBG("%d: tx_desc %p" NL, ocpdev->def->index, dev->tx_desc);
+	DBG("%d: rx_desc %p" NL, ocpdev->def->index, dev->rx_desc);
+
+	/* Clean rings */
+	memset(dev->tx_desc, 0, NUM_TX_BUFF * sizeof(struct mal_descriptor));
+	memset(dev->rx_desc, 0, NUM_RX_BUFF * sizeof(struct mal_descriptor));
+
+	/* If we depend on another EMAC for MDIO, check whether it was probed already */
+	if (emacdata->mdio_idx >= 0 && emacdata->mdio_idx != ocpdev->def->index) {
+		struct ocp_device *mdiodev =
+		    ocp_find_device(OCP_VENDOR_IBM, OCP_FUNC_EMAC,
+				    emacdata->mdio_idx);
+		if (!mdiodev) {
+			printk(KERN_ERR "emac%d: unknown emac%d device!\n",
+			       dev->def->index, emacdata->mdio_idx);
+			err = -ENODEV;
+			goto out2;
 		}
-		ep->mdio_dev = mdio_ndev;
-	} else {
-		ep->mdio_dev = ndev;
+		dev->mdio_dev = ocp_get_drvdata(mdiodev);
+		if (!dev->mdio_dev) {
+			printk(KERN_ERR
+			       "emac%d: emac%d hasn't been initialized yet!\n",
+			       dev->def->index, emacdata->mdio_idx);
+			err = -ENODEV;
+			goto out2;
+		}
+	}
+
+	/* Attach to ZMII, if needed */
+	if ((err = zmii_attach(dev)) != 0)
+		goto out2;
+
+	/* Attach to RGMII, if needed */
+	if ((err = rgmii_attach(dev)) != 0)
+		goto out3;
+
+	/* Attach to TAH, if needed */
+	if ((err = tah_attach(dev)) != 0)
+		goto out4;
+
+	/* Map EMAC regs */
+	dev->emacp =
+	    (struct emac_regs *)ioremap(dev->def->paddr,
+					sizeof(struct emac_regs));
+	if (!dev->emacp) {
+		printk(KERN_ERR "emac%d: could not ioremap device registers!\n",
+		       dev->def->index);
+		err = -ENOMEM;
+		goto out5;
 	}
 
-	ocp_set_drvdata(ocpdev, ndev);
+	/* Fill in MAC address */
+	for (i = 0; i < 6; ++i)
+		ndev->dev_addr[i] = emacdata->mac_addr[i];
+
+	/* Set some link defaults before we can find out real parameters */
+	dev->phy.speed = SPEED_100;
+	dev->phy.duplex = DUPLEX_FULL;
+	dev->phy.autoneg = AUTONEG_DISABLE;
+	dev->phy.pause = dev->phy.asym_pause = 0;
+	init_timer(&dev->link_timer);
+	dev->link_timer.function = emac_link_timer;
+	dev->link_timer.data = (unsigned long)dev;
+
+	/* Find PHY if any */
+	dev->phy.dev = ndev;
+	dev->phy.mode = emacdata->phy_mode;
+	if (emacdata->phy_map != 0xffffffff) {
+		u32 phy_map = emacdata->phy_map | busy_phy_map;
+		u32 adv;
+
+		DBG("%d: PHY maps %08x %08x" NL, dev->def->index,
+		    emacdata->phy_map, busy_phy_map);
 
-	spin_lock_init(&ep->lock);
+		EMAC_RX_CLK_TX(dev->def->index);
 
-	/* Fill out MAL informations and register commac */
-	ep->mal = mal;
-	ep->mal_tx_chan = emacdata->mal_tx_chan;
-	ep->mal_rx_chan = emacdata->mal_rx_chan;
-	ep->commac.ops = &emac_commac_ops;
-	ep->commac.dev = ndev;
-	ep->commac.tx_chan_mask = MAL_CHAN_MASK(ep->mal_tx_chan);
-	ep->commac.rx_chan_mask = MAL_CHAN_MASK(ep->mal_rx_chan);
-	rc = mal_register_commac(ep->mal, &ep->commac);
-	if (rc != 0)
-		goto bail;
-	commac_reg = 1;
-
-	/* Map our MMIOs */
-	ep->emacp = (emac_t *) ioremap(ocpdev->def->paddr, sizeof(emac_t));
-
-	/* Check if we need to attach to a ZMII */
-	if (emacdata->zmii_idx >= 0) {
-		ep->zmii_input = emacdata->zmii_mux;
-		ep->zmii_dev =
-		    ocp_find_device(OCP_ANY_ID, OCP_FUNC_ZMII,
-				    emacdata->zmii_idx);
-		if (ep->zmii_dev == NULL)
-			printk(KERN_WARNING
-			       "emac%d: ZMII %d requested but not found !\n",
-			       ocpdev->def->index, emacdata->zmii_idx);
-		else if ((rc =
-			  emac_init_zmii(ep->zmii_dev, ep->zmii_input,
-					 emacdata->phy_mode)) != 0)
-			goto bail;
-	}
-
-	/* Check if we need to attach to a RGMII */
-	if (emacdata->rgmii_idx >= 0) {
-		ep->rgmii_input = emacdata->rgmii_mux;
-		ep->rgmii_dev =
-		    ocp_find_device(OCP_ANY_ID, OCP_FUNC_RGMII,
-				    emacdata->rgmii_idx);
-		if (ep->rgmii_dev == NULL)
-			printk(KERN_WARNING
-			       "emac%d: RGMII %d requested but not found !\n",
-			       ocpdev->def->index, emacdata->rgmii_idx);
-		else if ((rc =
-			  emac_init_rgmii(ep->rgmii_dev, ep->rgmii_input,
-					  emacdata->phy_mode)) != 0)
-			goto bail;
-	}
-
-	/* Check if we need to attach to a TAH */
-	if (emacdata->tah_idx >= 0) {
-		ep->tah_dev =
-		    ocp_find_device(OCP_ANY_ID, OCP_FUNC_TAH,
-				    emacdata->tah_idx);
-		if (ep->tah_dev == NULL)
-			printk(KERN_WARNING
-			       "emac%d: TAH %d requested but not found !\n",
-			       ocpdev->def->index, emacdata->tah_idx);
-		else if ((rc = emac_init_tah(ep)) != 0)
-			goto bail;
-	}
-
-	if (deferred_init) {
-		if (!list_empty(&emac_init_list)) {
-			struct list_head *entry;
-			struct emac_def_dev *ddev;
-
-			list_for_each(entry, &emac_init_list) {
-				ddev =
-				    list_entry(entry, struct emac_def_dev,
-					       link);
-				emac_init_device(ddev->ocpdev, ddev->mal);
-			}
+		dev->phy.mdio_read = emac_mdio_read;
+		dev->phy.mdio_write = emac_mdio_write;
+
+		/* Configure EMAC with defaults so we can at least use MDIO
+		 * This is needed mostly for 440GX
+		 */
+		if (emac_phy_gpcs(dev->phy.mode)) {
+			/* XXX
+			 * Make GPCS PHY address equal to EMAC index.
+			 * We probably should take into account busy_phy_map
+			 * and/or phy_map here.
+			 */
+			dev->phy.address = dev->def->index;
 		}
-	}
 
-	/* Init link monitoring timer */
-	init_timer(&ep->link_timer);
-	ep->link_timer.function = emac_link_timer;
-	ep->link_timer.data = (unsigned long)ep;
-	ep->timer_ticks = 0;
-
-	/* Fill up the mii_phy structure */
-	ep->phy_mii.dev = ndev;
-	ep->phy_mii.mdio_read = emac_phy_read;
-	ep->phy_mii.mdio_write = emac_phy_write;
-	ep->phy_mii.mode = emacdata->phy_mode;
-
-	/* Find PHY */
-	phy_map = emacdata->phy_map | busy_phy_map;
-	for (i = 0; i <= 0x1f; i++, phy_map >>= 1) {
-		if ((phy_map & 0x1) == 0) {
-			int val = emac_phy_read(ndev, i, MII_BMCR);
-			if (val != 0xffff && val != -1)
-				break;
+		emac_configure(dev);
+
+		for (i = 0; i < 0x20; phy_map >>= 1, ++i)
+			if (!(phy_map & 1)) {
+				int r;
+				busy_phy_map |= 1 << i;
+
+				/* Quick check if there is a PHY at the address */
+				r = emac_mdio_read(dev->ndev, i, MII_BMCR);
+				if (r == 0xffff || r < 0)
+					continue;
+				if (!mii_phy_probe(&dev->phy, i))
+					break;
+			}
+		if (i == 0x20) {
+			printk(KERN_WARNING "emac%d: can't find PHY!\n",
+			       dev->def->index);
+			goto out6;
 		}
-	}
-	if (i == 0x20) {
-		printk(KERN_WARNING "emac%d: Can't find PHY.\n",
-		       ocpdev->def->index);
-		rc = -ENODEV;
-		goto bail;
-	}
-	busy_phy_map |= 1 << i;
-	ep->mii_phy_addr = i;
-	rc = mii_phy_probe(&ep->phy_mii, i);
-	if (rc) {
-		printk(KERN_WARNING "emac%d: Failed to probe PHY type.\n",
-		       ocpdev->def->index);
-		rc = -ENODEV;
-		goto bail;
-	}
-	
-	/* Disable any PHY features not supported by the platform */
-	ep->phy_mii.def->features &= ~emacdata->phy_feat_exc;
-
-	/* Setup initial PHY config & startup aneg */
-	if (ep->phy_mii.def->ops->init)
-		ep->phy_mii.def->ops->init(&ep->phy_mii);
-	netif_carrier_off(ndev);
-	if (ep->phy_mii.def->features & SUPPORTED_Autoneg)
-		ep->want_autoneg = 1;
-	else {
-		ep->want_autoneg = 0;
+
+		/* Init PHY */
+		if (dev->phy.def->ops->init)
+			dev->phy.def->ops->init(&dev->phy);
 		
-		/* Select highest supported speed/duplex */
-		if (ep->phy_mii.def->features & SUPPORTED_1000baseT_Full) {
-			ep->phy_mii.speed = SPEED_1000;
-			ep->phy_mii.duplex = DUPLEX_FULL;
-		} else if (ep->phy_mii.def->features & 
-			   SUPPORTED_1000baseT_Half) {
-			ep->phy_mii.speed = SPEED_1000;
-			ep->phy_mii.duplex = DUPLEX_HALF;
-		} else if (ep->phy_mii.def->features & 
-			   SUPPORTED_100baseT_Full) {
-			ep->phy_mii.speed = SPEED_100;
-			ep->phy_mii.duplex = DUPLEX_FULL;
-		} else if (ep->phy_mii.def->features & 
-			   SUPPORTED_100baseT_Half) {
-			ep->phy_mii.speed = SPEED_100;
-			ep->phy_mii.duplex = DUPLEX_HALF;
-		} else if (ep->phy_mii.def->features & 
-			   SUPPORTED_10baseT_Full) {
-			ep->phy_mii.speed = SPEED_10;
-			ep->phy_mii.duplex = DUPLEX_FULL;
+		/* Disable any PHY features not supported by the platform */
+		dev->phy.def->features &= ~emacdata->phy_feat_exc;
+
+		/* Setup initial link parameters */
+		if (dev->phy.features & SUPPORTED_Autoneg) {
+			adv = dev->phy.features;
+#if !defined(CONFIG_40x)
+			adv |= ADVERTISED_Pause | ADVERTISED_Asym_Pause;
+#endif
+			/* Restart autonegotiation */
+			dev->phy.def->ops->setup_aneg(&dev->phy, adv);
 		} else {
-			ep->phy_mii.speed = SPEED_10;
-			ep->phy_mii.duplex = DUPLEX_HALF;
+			u32 f = dev->phy.def->features;
+			int speed = SPEED_10, fd = DUPLEX_HALF;
+
+			/* Select highest supported speed/duplex */
+			if (f & SUPPORTED_1000baseT_Full) {
+				speed = SPEED_1000;
+				fd = DUPLEX_FULL;
+			} else if (f & SUPPORTED_1000baseT_Half)
+				speed = SPEED_1000;
+			else if (f & SUPPORTED_100baseT_Full) {
+				speed = SPEED_100;
+				fd = DUPLEX_FULL;
+			} else if (f & SUPPORTED_100baseT_Half)
+				speed = SPEED_100;
+			else if (f & SUPPORTED_10baseT_Full)
+				fd = DUPLEX_FULL;
+
+			/* Force link parameters */
+			dev->phy.def->ops->setup_forced(&dev->phy, speed, fd);
 		}
-	}
-	emac_start_link(ep, NULL);
+	} else {
+		emac_reset(dev);
 
-	/* read the MAC Address */
-	for (i = 0; i < 6; i++)
-		ndev->dev_addr[i] = emacdata->mac_addr[i];
+		/* PHY-less configuration.
+		 * XXX I probably should move these settings to emacdata
+		 */
+		dev->phy.address = -1;
+		dev->phy.features = SUPPORTED_100baseT_Full | SUPPORTED_MII;
+		dev->phy.pause = 1;
+	}
 
 	/* Fill in the driver function table */
 	ndev->open = &emac_open;
-	ndev->hard_start_xmit = &emac_start_xmit;
+	if (dev->tah_dev) {
+		ndev->hard_start_xmit = &emac_start_xmit_sg;
+		ndev->features |= NETIF_F_IP_CSUM | NETIF_F_SG;
+	} else
+		ndev->hard_start_xmit = &emac_start_xmit;
+	ndev->tx_timeout = &emac_full_tx_reset;
+	ndev->watchdog_timeo = 5 * HZ;
 	ndev->stop = &emac_close;
 	ndev->get_stats = &emac_stats;
-	if (emacdata->jumbo)
-		ndev->change_mtu = &emac_change_mtu;
-	ndev->set_mac_address = &emac_set_mac_address;
 	ndev->set_multicast_list = &emac_set_multicast_list;
 	ndev->do_ioctl = &emac_ioctl;
+	if (emac_phy_supports_gige(emacdata->phy_mode)) {
+		ndev->change_mtu = &emac_change_mtu;
+		dev->commac.ops = &emac_commac_sg_ops;
+	}
 	SET_ETHTOOL_OPS(ndev, &emac_ethtool_ops);
-	if (emacdata->tah_idx >= 0)
-		ndev->features = NETIF_F_IP_CSUM | NETIF_F_SG;
-#ifdef CONFIG_NET_POLL_CONTROLLER
-	ndev->poll_controller = emac_netpoll;
-#endif
 
-	SET_MODULE_OWNER(ndev);
+	netif_carrier_off(ndev);
+	netif_stop_queue(ndev);
+
+	err = register_netdev(ndev);
+	if (err) {
+		printk(KERN_ERR "emac%d: failed to register net device (%d)!\n",
+		       dev->def->index, err);
+		goto out6;
+	}
 
-	rc = register_netdev(ndev);
-	if (rc != 0)
-		goto bail;
+	ocp_set_drvdata(ocpdev, dev);
 
-	printk("%s: IBM emac, MAC %02x:%02x:%02x:%02x:%02x:%02x\n",
-	       ndev->name,
+	printk("%s: emac%d, MAC %02x:%02x:%02x:%02x:%02x:%02x\n",
+	       ndev->name, dev->def->index,
 	       ndev->dev_addr[0], ndev->dev_addr[1], ndev->dev_addr[2],
 	       ndev->dev_addr[3], ndev->dev_addr[4], ndev->dev_addr[5]);
-	printk(KERN_INFO "%s: Found %s PHY (0x%02x)\n",
-	       ndev->name, ep->phy_mii.def->name, ep->mii_phy_addr);
-
-      bail:
-	if (rc && commac_reg)
-		mal_unregister_commac(ep->mal, &ep->commac);
-	if (rc && ndev)
-		kfree(ndev);
-
-	return rc;
-}
-
-static int emac_probe(struct ocp_device *ocpdev)
-{
-	struct ocp_device *maldev;
-	struct ibm_ocp_mal *mal;
-	struct ocp_func_emac_data *emacdata;
-
-	emacdata = (struct ocp_func_emac_data *)ocpdev->def->additions;
-	if (emacdata == NULL) {
-		printk(KERN_ERR "emac%d: Missing additional datas !\n",
-		       ocpdev->def->index);
-		return -ENODEV;
-	}
 
-	/* Get the MAL device  */
-	maldev = ocp_find_device(OCP_ANY_ID, OCP_FUNC_MAL, emacdata->mal_idx);
-	if (maldev == NULL) {
-		printk("No maldev\n");
-		return -ENODEV;
-	}
-	/*
-	 * Get MAL driver data, it must be here due to link order.
-	 * When the driver is modularized, symbol dependencies will
-	 * ensure the MAL driver is already present if built as a
-	 * module.
-	 */
-	mal = (struct ibm_ocp_mal *)ocp_get_drvdata(maldev);
-	if (mal == NULL) {
-		printk("No maldrv\n");
-		return -ENODEV;
-	}
+	if (dev->phy.address >= 0)
+		printk("%s: found %s PHY (0x%02x)\n", ndev->name,
+		       dev->phy.def->name, dev->phy.address);
 
-	/* If we depend on another EMAC for MDIO, wait for it to show up */
-	if (emacdata->mdio_idx >= 0 &&
-	    (emacdata->mdio_idx != ocpdev->def->index) && !mdio_ndev) {
-		struct emac_def_dev *ddev;
-		/* Add this index to the deferred init table */
-		ddev = kmalloc(sizeof(struct emac_def_dev), GFP_KERNEL);
-		ddev->ocpdev = ocpdev;
-		ddev->mal = mal;
-		list_add_tail(&ddev->link, &emac_init_list);
-	} else {
-		emac_init_device(ocpdev, mal);
-	}
+	emac_dbg_register(dev->def->index, dev);
 
 	return 0;
+      out6:
+	iounmap((void *)dev->emacp);
+      out5:
+	tah_fini(dev->tah_dev);
+      out4:
+	rgmii_fini(dev->rgmii_dev, dev->rgmii_input);
+      out3:
+	zmii_fini(dev->zmii_dev, dev->zmii_input);
+      out2:
+	mal_unregister_commac(dev->mal, &dev->commac);
+      out:
+	kfree(ndev);
+	return err;
 }
 
-/* Structure for a device driver */
 static struct ocp_device_id emac_ids[] = {
-	{.vendor = OCP_ANY_ID,.function = OCP_FUNC_EMAC},
-	{.vendor = OCP_VENDOR_INVALID}
+	{ .vendor = OCP_VENDOR_IBM, .function = OCP_FUNC_EMAC },
+	{ .vendor = OCP_VENDOR_INVALID}
 };
 
 static struct ocp_driver emac_driver = {
 	.name = "emac",
 	.id_table = emac_ids,
-
 	.probe = emac_probe,
 	.remove = emac_remove,
 };
 
 static int __init emac_init(void)
 {
-	printk(KERN_INFO DRV_NAME ": " DRV_DESC ", version " DRV_VERSION "\n");
-	printk(KERN_INFO "Maintained by " DRV_AUTHOR "\n");
+	printk(KERN_INFO DRV_DESC ", version " DRV_VERSION "\n");
+
+	DBG(": init" NL);
 
-	if (skb_res > 2) {
-		printk(KERN_WARNING "Invalid skb_res: %d, cropping to 2\n",
-		       skb_res);
-		skb_res = 2;
+	if (mal_init())
+		return -ENODEV;
+
+	EMAC_CLK_INTERNAL;
+	if (ocp_register_driver(&emac_driver)) {
+		EMAC_CLK_EXTERNAL;
+		ocp_unregister_driver(&emac_driver);
+		mal_exit();
+		return -ENODEV;
 	}
+	EMAC_CLK_EXTERNAL;
 
-	return ocp_register_driver(&emac_driver);
+	emac_init_debug();
+	return 0;
 }
 
 static void __exit emac_exit(void)
 {
+	DBG(": exit" NL);
 	ocp_unregister_driver(&emac_driver);
+	mal_exit();
+	emac_fini_debug();
 }
 
 module_init(emac_init);
diff -puN drivers/net/ibm_emac/ibm_emac_core.h~new-powerpc-4xx-on-chip-ethernet-controller-driver drivers/net/ibm_emac/ibm_emac_core.h
--- devel/drivers/net/ibm_emac/ibm_emac_core.h~new-powerpc-4xx-on-chip-ethernet-controller-driver	2005-10-28 17:44:03.000000000 -0700
+++ devel-akpm/drivers/net/ibm_emac/ibm_emac_core.h	2005-10-28 17:44:03.000000000 -0700
@@ -1,146 +1,221 @@
 /*
- * ibm_emac_core.h
+ * drivers/net/ibm_emac/ibm_emac_core.h
  *
- * Ethernet driver for the built in ethernet on the IBM 405 PowerPC
- * processor.
+ * Driver for PowerPC 4xx on-chip ethernet controller.
  *
- *      Armin Kuster akuster@mvista.com
- *      Sept, 2001
+ * Copyright (c) 2004, 2005 Zultys Technologies.
+ * Eugene Surovegin <eugene.surovegin@zultys.com> or <ebs@ebshome.net>
  *
- *      Orignial driver
- *         Johnnie Peters
- *         jpeters@mvista.com
- *
- * Copyright 2000 MontaVista Softare Inc.
+ * Based on original work by
+ *      Armin Kuster <akuster@mvista.com>
+ * 	Johnnie Peters <jpeters@mvista.com>
+ *      Copyright 2000, 2001 MontaVista Softare Inc.
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
  * Free Software Foundation;  either version 2 of the  License, or (at your
  * option) any later version.
+ *
  */
+#ifndef __IBM_EMAC_CORE_H_
+#define __IBM_EMAC_CORE_H_
 
-#ifndef _IBM_EMAC_CORE_H_
-#define _IBM_EMAC_CORE_H_
-
+#include <linux/config.h>
 #include <linux/netdevice.h>
+#include <linux/dma-mapping.h>
 #include <asm/ocp.h>
-#include <asm/mmu.h>		/* For phys_addr_t */
 
 #include "ibm_emac.h"
 #include "ibm_emac_phy.h"
-#include "ibm_emac_rgmii.h"
 #include "ibm_emac_zmii.h"
+#include "ibm_emac_rgmii.h"
 #include "ibm_emac_mal.h"
 #include "ibm_emac_tah.h"
 
-#ifndef CONFIG_IBM_EMAC_TXB
-#define NUM_TX_BUFF		64
-#define NUM_RX_BUFF		64
-#else
-#define NUM_TX_BUFF		CONFIG_IBM_EMAC_TXB
-#define NUM_RX_BUFF		CONFIG_IBM_EMAC_RXB
-#endif
+#define NUM_TX_BUFF			CONFIG_IBM_EMAC_TXB
+#define NUM_RX_BUFF			CONFIG_IBM_EMAC_RXB
 
-/* This does 16 byte alignment, exactly what we need.
- * The packet length includes FCS, but we don't want to
- * include that when passing upstream as it messes up
- * bridging applications.
- */
-#ifndef CONFIG_IBM_EMAC_SKBRES
-#define SKB_RES 2
-#else
-#define SKB_RES CONFIG_IBM_EMAC_SKBRES
+/* Simple sanity check */
+#if NUM_TX_BUFF > 256 || NUM_RX_BUFF > 256
+#error Invalid number of buffer descriptors (greater than 256)
 #endif
 
-/* Note about alignement. alloc_skb() returns a cache line
- * aligned buffer. However, dev_alloc_skb() will add 16 more
- * bytes and "reserve" them, so our buffer will actually end
- * on a half cache line. What we do is to use directly
- * alloc_skb, allocate 16 more bytes to match the total amount
- * allocated by dev_alloc_skb(), but we don't reserve.
+// XXX
+#define EMAC_MIN_MTU			46
+#define EMAC_MAX_MTU			9000
+
+/* Maximum L2 header length (VLAN tagged, no FCS) */
+#define EMAC_MTU_OVERHEAD		(6 * 2 + 2 + 4)
+
+/* RX BD size for the given MTU */
+static inline int emac_rx_size(int mtu)
+{
+	if (mtu > ETH_DATA_LEN)
+		return MAL_MAX_RX_SIZE;
+	else
+		return mal_rx_size(ETH_DATA_LEN + EMAC_MTU_OVERHEAD);
+}
+
+#define EMAC_DMA_ALIGN(x)		ALIGN((x), dma_get_cache_alignment())
+
+#define EMAC_RX_SKB_HEADROOM		\
+	EMAC_DMA_ALIGN(CONFIG_IBM_EMAC_RX_SKB_HEADROOM)
+
+/* Size of RX skb for the given MTU */
+static inline int emac_rx_skb_size(int mtu)
+{
+	int size = max(mtu + EMAC_MTU_OVERHEAD, emac_rx_size(mtu));
+	return EMAC_DMA_ALIGN(size + 2) + EMAC_RX_SKB_HEADROOM;
+}
+
+/* RX DMA sync size */
+static inline int emac_rx_sync_size(int mtu)
+{
+	return EMAC_DMA_ALIGN(emac_rx_size(mtu) + 2);
+}
+
+/* Driver statistcs is split into two parts to make it more cache friendly:
+ *   - normal statistics (packet count, etc)
+ *   - error statistics
+ *
+ * When statistics is requested by ethtool, these parts are concatenated,
+ * normal one goes first.
+ *
+ * Please, keep these structures in sync with emac_stats_keys.
  */
-#define MAX_NUM_BUF_DESC	255
-#define DESC_BUF_SIZE		4080	/* max 4096-16 */
-#define DESC_BUF_SIZE_REG	(DESC_BUF_SIZE / 16)
-
-/* Transmitter timeout. */
-#define TX_TIMEOUT		(2*HZ)
-
-/* MDIO latency delay */
-#define MDIO_DELAY		250
-
-/* Power managment shift registers */
-#define IBM_CPM_EMMII	0	/* Shift value for MII */
-#define IBM_CPM_EMRX	1	/* Shift value for recv */
-#define IBM_CPM_EMTX	2	/* Shift value for MAC */
-#define IBM_CPM_EMAC(x)	(((x)>>IBM_CPM_EMMII) | ((x)>>IBM_CPM_EMRX) | ((x)>>IBM_CPM_EMTX))
-
-#define ENET_HEADER_SIZE	14
-#define ENET_FCS_SIZE		4
-#define ENET_DEF_MTU_SIZE	1500
-#define ENET_DEF_BUF_SIZE	(ENET_DEF_MTU_SIZE + ENET_HEADER_SIZE + ENET_FCS_SIZE)
-#define EMAC_MIN_FRAME		64
-#define EMAC_MAX_FRAME		9018
-#define EMAC_MIN_MTU		(EMAC_MIN_FRAME - ENET_HEADER_SIZE - ENET_FCS_SIZE)
-#define EMAC_MAX_MTU		(EMAC_MAX_FRAME - ENET_HEADER_SIZE - ENET_FCS_SIZE)
-
-#ifdef CONFIG_IBM_EMAC_ERRMSG
-void emac_serr_dump_0(struct net_device *dev);
-void emac_serr_dump_1(struct net_device *dev);
-void emac_err_dump(struct net_device *dev, int em0isr);
-void emac_phy_dump(struct net_device *);
-void emac_desc_dump(struct net_device *);
-void emac_mac_dump(struct net_device *);
-void emac_mal_dump(struct net_device *);
-#else
-#define emac_serr_dump_0(dev) do { } while (0)
-#define emac_serr_dump_1(dev) do { } while (0)
-#define emac_err_dump(dev,x) do { } while (0)
-#define emac_phy_dump(dev) do { } while (0)
-#define emac_desc_dump(dev) do { } while (0)
-#define emac_mac_dump(dev) do { } while (0)
-#define emac_mal_dump(dev) do { } while (0)
-#endif
+
+/* Normal TX/RX Statistics */
+struct ibm_emac_stats {
+	u64 rx_packets;
+	u64 rx_bytes;
+	u64 tx_packets;
+	u64 tx_bytes;
+	u64 rx_packets_csum;
+	u64 tx_packets_csum;
+};
+
+/* Error statistics */
+struct ibm_emac_error_stats {
+	u64 tx_undo;
+
+	/* Software RX Errors */
+	u64 rx_dropped_stack;
+	u64 rx_dropped_oom;
+	u64 rx_dropped_error;
+	u64 rx_dropped_resize;
+	u64 rx_dropped_mtu;
+	u64 rx_stopped;
+	/* BD reported RX errors */
+	u64 rx_bd_errors;
+	u64 rx_bd_overrun;
+	u64 rx_bd_bad_packet;
+	u64 rx_bd_runt_packet;
+	u64 rx_bd_short_event;
+	u64 rx_bd_alignment_error;
+	u64 rx_bd_bad_fcs;
+	u64 rx_bd_packet_too_long;
+	u64 rx_bd_out_of_range;
+	u64 rx_bd_in_range;
+	/* EMAC IRQ reported RX errors */
+	u64 rx_parity;
+	u64 rx_fifo_overrun;
+	u64 rx_overrun;
+	u64 rx_bad_packet;
+	u64 rx_runt_packet;
+	u64 rx_short_event;
+	u64 rx_alignment_error;
+	u64 rx_bad_fcs;
+	u64 rx_packet_too_long;
+	u64 rx_out_of_range;
+	u64 rx_in_range;
+
+	/* Software TX Errors */
+	u64 tx_dropped;
+	/* BD reported TX errors */
+	u64 tx_bd_errors;
+	u64 tx_bd_bad_fcs;
+	u64 tx_bd_carrier_loss;
+	u64 tx_bd_excessive_deferral;
+	u64 tx_bd_excessive_collisions;
+	u64 tx_bd_late_collision;
+	u64 tx_bd_multple_collisions;
+	u64 tx_bd_single_collision;
+	u64 tx_bd_underrun;
+	u64 tx_bd_sqe;
+	/* EMAC IRQ reported TX errors */
+	u64 tx_parity;
+	u64 tx_underrun;
+	u64 tx_sqe;
+	u64 tx_errors;
+};
+
+#define EMAC_ETHTOOL_STATS_COUNT	((sizeof(struct ibm_emac_stats) + \
+					  sizeof(struct ibm_emac_error_stats)) \
+					 / sizeof(u64))
 
 struct ocp_enet_private {
-	struct sk_buff *tx_skb[NUM_TX_BUFF];
-	struct sk_buff *rx_skb[NUM_RX_BUFF];
-	struct mal_descriptor *tx_desc;
-	struct mal_descriptor *rx_desc;
-	struct mal_descriptor *rx_dirty;
-	struct net_device_stats stats;
-	int tx_cnt;
-	int rx_slot;
-	int dirty_rx;
-	int tx_slot;
-	int ack_slot;
-	int rx_buffer_size;
-
-	struct mii_phy phy_mii;
-	int mii_phy_addr;
-	int want_autoneg;
-	int timer_ticks;
-	struct timer_list link_timer;
-	struct net_device *mdio_dev;
-
-	struct ocp_device *rgmii_dev;
-	int rgmii_input;
-
-	struct ocp_device *zmii_dev;
-	int zmii_input;
-
-	struct ibm_ocp_mal *mal;
-	int mal_tx_chan, mal_rx_chan;
-	struct mal_commac commac;
-
-	struct ocp_device *tah_dev;
-
-	int opened;
-	int going_away;
-	int wol_irq;
-	emac_t *emacp;
-	struct ocp_device *ocpdev;
-	struct net_device *ndev;
-	spinlock_t lock;
+	struct net_device		*ndev;		/* 0 */
+	struct emac_regs		*emacp;
+
+	struct mal_descriptor		*tx_desc;
+	int				tx_cnt;
+	int				tx_slot;
+	int				ack_slot;
+
+	struct mal_descriptor		*rx_desc;
+	int				rx_slot;
+	struct sk_buff			*rx_sg_skb;	/* 1 */
+	int 				rx_skb_size;
+	int				rx_sync_size;
+
+	struct ibm_emac_stats 		stats;
+	struct ocp_device		*tah_dev;
+
+	struct ibm_ocp_mal		*mal;
+	struct mal_commac		commac;
+
+	struct sk_buff			*tx_skb[NUM_TX_BUFF];
+	struct sk_buff			*rx_skb[NUM_RX_BUFF];
+
+	struct ocp_device		*zmii_dev;
+	int				zmii_input;
+	struct ocp_enet_private		*mdio_dev;
+	struct ocp_device		*rgmii_dev;
+	int				rgmii_input;
+
+	struct ocp_def			*def;
+
+	struct mii_phy			phy;
+	struct timer_list		link_timer;
+	int				reset_failed;
+
+	struct ibm_emac_error_stats	estats;
+	struct net_device_stats		nstats;
+
+	struct device*			ldev;
 };
-#endif				/* _IBM_EMAC_CORE_H_ */
+
+/* Ethtool get_regs complex data.
+ * We want to get not just EMAC registers, but also MAL, ZMII, RGMII, TAH
+ * when available.
+ *
+ * Returned BLOB consists of the ibm_emac_ethtool_regs_hdr,
+ * MAL registers, EMAC registers and optional ZMII, RGMII, TAH registers.
+ * Each register component is preceded with emac_ethtool_regs_subhdr.
+ * Order of the optional headers follows their relative bit posititions
+ * in emac_ethtool_regs_hdr.components
+ */
+#define EMAC_ETHTOOL_REGS_ZMII		0x00000001
+#define EMAC_ETHTOOL_REGS_RGMII		0x00000002
+#define EMAC_ETHTOOL_REGS_TAH		0x00000004
+
+struct emac_ethtool_regs_hdr {
+	u32 components;
+};
+
+struct emac_ethtool_regs_subhdr {
+	u32 version;
+	u32 index;
+};
+
+#endif				/* __IBM_EMAC_CORE_H_ */
diff -puN drivers/net/ibm_emac/ibm_emac_debug.c~new-powerpc-4xx-on-chip-ethernet-controller-driver drivers/net/ibm_emac/ibm_emac_debug.c
--- devel/drivers/net/ibm_emac/ibm_emac_debug.c~new-powerpc-4xx-on-chip-ethernet-controller-driver	2005-10-28 17:44:03.000000000 -0700
+++ devel-akpm/drivers/net/ibm_emac/ibm_emac_debug.c	2005-10-28 17:44:03.000000000 -0700
@@ -1,224 +1,213 @@
 /*
- * ibm_ocp_debug.c
+ * drivers/net/ibm_emac/ibm_emac_debug.c
  *
- * This has all the debug routines that where in *_enet.c
+ * Driver for PowerPC 4xx on-chip ethernet controller, debug print routines.
  *
- *      Armin Kuster akuster@mvista.com
- *      April , 2002
- *
- * Copyright 2002 MontaVista Softare Inc.
+ * Copyright (c) 2004, 2005 Zultys Technologies
+ * Eugene Surovegin <eugene.surovegin@zultys.com> or <ebs@ebshome.net>
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
  * Free Software Foundation;  either version 2 of the  License, or (at your
  * option) any later version.
+ *
  */
-
 #include <linux/config.h>
+#include <linux/init.h>
+#include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/netdevice.h>
+#include <linux/sysrq.h>
 #include <asm/io.h>
-#include "ibm_ocp_mal.h"
-#include "ibm_ocp_zmii.h"
-#include "ibm_ocp_enet.h"
-
-extern int emac_phy_read(struct net_device *dev, int mii_id, int reg);
-
-void emac_phy_dump(struct net_device *dev)
-{
-	struct ocp_enet_private *fep = dev->priv;
-	unsigned long i;
-	uint data;
-
-	printk(KERN_DEBUG " Prepare for Phy dump....\n");
-	for (i = 0; i < 0x1A; i++) {
-		data = emac_phy_read(dev, fep->mii_phy_addr, i);
-		printk(KERN_DEBUG "Phy reg 0x%lx ==> %4x\n", i, data);
-		if (i == 0x07)
-			i = 0x0f;
+
+#include "ibm_emac_core.h"
+
+static void emac_desc_dump(int idx, struct ocp_enet_private *p)
+{
+	int i;
+	printk("** EMAC%d TX BDs **\n"
+	       " tx_cnt = %d tx_slot = %d ack_slot = %d\n",
+	       idx, p->tx_cnt, p->tx_slot, p->ack_slot);
+	for (i = 0; i < NUM_TX_BUFF / 2; ++i)
+		printk
+		    ("bd[%2d] 0x%08x %c 0x%04x %4u - bd[%2d] 0x%08x %c 0x%04x %4u\n",
+		     i, p->tx_desc[i].data_ptr, p->tx_skb[i] ? 'V' : ' ',
+		     p->tx_desc[i].ctrl, p->tx_desc[i].data_len,
+		     NUM_TX_BUFF / 2 + i,
+		     p->tx_desc[NUM_TX_BUFF / 2 + i].data_ptr,
+		     p->tx_skb[NUM_TX_BUFF / 2 + i] ? 'V' : ' ',
+		     p->tx_desc[NUM_TX_BUFF / 2 + i].ctrl,
+		     p->tx_desc[NUM_TX_BUFF / 2 + i].data_len);
+
+	printk("** EMAC%d RX BDs **\n"
+	       " rx_slot = %d rx_stopped = %d rx_skb_size = %d rx_sync_size = %d\n"
+	       " rx_sg_skb = 0x%p\n",
+	       idx, p->rx_slot, p->commac.rx_stopped, p->rx_skb_size,
+	       p->rx_sync_size, p->rx_sg_skb);
+	for (i = 0; i < NUM_RX_BUFF / 2; ++i)
+		printk
+		    ("bd[%2d] 0x%08x %c 0x%04x %4u - bd[%2d] 0x%08x %c 0x%04x %4u\n",
+		     i, p->rx_desc[i].data_ptr, p->rx_skb[i] ? 'V' : ' ',
+		     p->rx_desc[i].ctrl, p->rx_desc[i].data_len,
+		     NUM_RX_BUFF / 2 + i,
+		     p->rx_desc[NUM_RX_BUFF / 2 + i].data_ptr,
+		     p->rx_skb[NUM_RX_BUFF / 2 + i] ? 'V' : ' ',
+		     p->rx_desc[NUM_RX_BUFF / 2 + i].ctrl,
+		     p->rx_desc[NUM_RX_BUFF / 2 + i].data_len);
+}
+
+static void emac_mac_dump(int idx, struct ocp_enet_private *dev)
+{
+	struct emac_regs *p = dev->emacp;
+
+	printk("** EMAC%d registers **\n"
+	       "MR0 = 0x%08x MR1 = 0x%08x TMR0 = 0x%08x TMR1 = 0x%08x\n"
+	       "RMR = 0x%08x ISR = 0x%08x ISER = 0x%08x\n"
+	       "IAR = %04x%08x VTPID = 0x%04x VTCI = 0x%04x\n"
+	       "IAHT: 0x%04x 0x%04x 0x%04x 0x%04x "
+	       "GAHT: 0x%04x 0x%04x 0x%04x 0x%04x\n"
+	       "LSA = %04x%08x IPGVR = 0x%04x\n"
+	       "STACR = 0x%08x TRTR = 0x%08x RWMR = 0x%08x\n"
+	       "OCTX = 0x%08x OCRX = 0x%08x IPCR = 0x%08x\n",
+	       idx, in_be32(&p->mr0), in_be32(&p->mr1),
+	       in_be32(&p->tmr0), in_be32(&p->tmr1),
+	       in_be32(&p->rmr), in_be32(&p->isr), in_be32(&p->iser),
+	       in_be32(&p->iahr), in_be32(&p->ialr), in_be32(&p->vtpid),
+	       in_be32(&p->vtci),
+	       in_be32(&p->iaht1), in_be32(&p->iaht2), in_be32(&p->iaht3),
+	       in_be32(&p->iaht4),
+	       in_be32(&p->gaht1), in_be32(&p->gaht2), in_be32(&p->gaht3),
+	       in_be32(&p->gaht4),
+	       in_be32(&p->lsah), in_be32(&p->lsal), in_be32(&p->ipgvr),
+	       in_be32(&p->stacr), in_be32(&p->trtr), in_be32(&p->rwmr),
+	       in_be32(&p->octx), in_be32(&p->ocrx), in_be32(&p->ipcr)
+	    );
+
+	emac_desc_dump(idx, dev);
+}
+
+static void emac_mal_dump(struct ibm_ocp_mal *mal)
+{
+	struct ocp_func_mal_data *maldata = mal->def->additions;
+	int i;
+
+	printk("** MAL%d Registers **\n"
+	       "CFG = 0x%08x ESR = 0x%08x IER = 0x%08x\n"
+	       "TX|CASR = 0x%08x CARR = 0x%08x EOBISR = 0x%08x DEIR = 0x%08x\n"
+	       "RX|CASR = 0x%08x CARR = 0x%08x EOBISR = 0x%08x DEIR = 0x%08x\n",
+	       mal->def->index,
+	       get_mal_dcrn(mal, MAL_CFG), get_mal_dcrn(mal, MAL_ESR),
+	       get_mal_dcrn(mal, MAL_IER),
+	       get_mal_dcrn(mal, MAL_TXCASR), get_mal_dcrn(mal, MAL_TXCARR),
+	       get_mal_dcrn(mal, MAL_TXEOBISR), get_mal_dcrn(mal, MAL_TXDEIR),
+	       get_mal_dcrn(mal, MAL_RXCASR), get_mal_dcrn(mal, MAL_RXCARR),
+	       get_mal_dcrn(mal, MAL_RXEOBISR), get_mal_dcrn(mal, MAL_RXDEIR)
+	    );
+
+	printk("TX|");
+	for (i = 0; i < maldata->num_tx_chans; ++i) {
+		if (i && !(i % 4))
+			printk("\n   ");
+		printk("CTP%d = 0x%08x ", i, get_mal_dcrn(mal, MAL_TXCTPR(i)));
+	}
+	printk("\nRX|");
+	for (i = 0; i < maldata->num_rx_chans; ++i) {
+		if (i && !(i % 4))
+			printk("\n   ");
+		printk("CTP%d = 0x%08x ", i, get_mal_dcrn(mal, MAL_RXCTPR(i)));
 	}
+	printk("\n   ");
+	for (i = 0; i < maldata->num_rx_chans; ++i) {
+		u32 r = get_mal_dcrn(mal, MAL_RCBS(i));
+		if (i && !(i % 3))
+			printk("\n   ");
+		printk("RCBS%d = 0x%08x (%d) ", i, r, r * 16);
+	}
+	printk("\n");
 }
 
-void emac_desc_dump(struct net_device *dev)
+static struct ocp_enet_private *__emacs[4];
+static struct ibm_ocp_mal *__mals[1];
+
+void emac_dbg_register(int idx, struct ocp_enet_private *dev)
 {
-	struct ocp_enet_private *fep = dev->priv;
-	int curr_slot;
+	unsigned long flags;
 
-	printk(KERN_DEBUG
-	       "dumping the receive descriptors:  current slot is %d\n",
-	       fep->rx_slot);
-	for (curr_slot = 0; curr_slot < NUM_RX_BUFF; curr_slot++) {
-		printk(KERN_DEBUG
-		       "Desc %02d: status 0x%04x, length %3d, addr 0x%x\n",
-		       curr_slot, fep->rx_desc[curr_slot].ctrl,
-		       fep->rx_desc[curr_slot].data_len,
-		       (unsigned int)fep->rx_desc[curr_slot].data_ptr);
+	if (idx >= sizeof(__emacs) / sizeof(__emacs[0])) {
+		printk(KERN_WARNING
+		       "invalid index %d when registering EMAC for debugging\n",
+		       idx);
+		return;
 	}
+
+	local_irq_save(flags);
+	__emacs[idx] = dev;
+	local_irq_restore(flags);
 }
 
-void emac_mac_dump(struct net_device *dev)
+void mal_dbg_register(int idx, struct ibm_ocp_mal *mal)
 {
-	struct ocp_enet_private *fep = dev->priv;
-	volatile emac_t *emacp = fep->emacp;
+	unsigned long flags;
 
-	printk(KERN_DEBUG "EMAC DEBUG ********** \n");
-	printk(KERN_DEBUG "EMAC_M0  ==> 0x%x\n", in_be32(&emacp->em0mr0));
-	printk(KERN_DEBUG "EMAC_M1  ==> 0x%x\n", in_be32(&emacp->em0mr1));
-	printk(KERN_DEBUG "EMAC_TXM0==> 0x%x\n", in_be32(&emacp->em0tmr0));
-	printk(KERN_DEBUG "EMAC_TXM1==> 0x%x\n", in_be32(&emacp->em0tmr1));
-	printk(KERN_DEBUG "EMAC_RXM ==> 0x%x\n", in_be32(&emacp->em0rmr));
-	printk(KERN_DEBUG "EMAC_ISR ==> 0x%x\n", in_be32(&emacp->em0isr));
-	printk(KERN_DEBUG "EMAC_IER ==> 0x%x\n", in_be32(&emacp->em0iser));
-	printk(KERN_DEBUG "EMAC_IAH ==> 0x%x\n", in_be32(&emacp->em0iahr));
-	printk(KERN_DEBUG "EMAC_IAL ==> 0x%x\n", in_be32(&emacp->em0ialr));
-	printk(KERN_DEBUG "EMAC_VLAN_TPID_REG ==> 0x%x\n",
-	       in_be32(&emacp->em0vtpid));
-}
-
-void emac_mal_dump(struct net_device *dev)
-{
-	struct ibm_ocp_mal *mal = ((struct ocp_enet_private *)dev->priv)->mal;
-
-	printk(KERN_DEBUG " MAL DEBUG ********** \n");
-	printk(KERN_DEBUG " MCR      ==> 0x%x\n",
-	       (unsigned int)get_mal_dcrn(mal, DCRN_MALCR));
-	printk(KERN_DEBUG " ESR      ==> 0x%x\n",
-	       (unsigned int)get_mal_dcrn(mal, DCRN_MALESR));
-	printk(KERN_DEBUG " IER      ==> 0x%x\n",
-	       (unsigned int)get_mal_dcrn(mal, DCRN_MALIER));
-#ifdef CONFIG_40x
-	printk(KERN_DEBUG " DBR      ==> 0x%x\n",
-	       (unsigned int)get_mal_dcrn(mal, DCRN_MALDBR));
-#endif				/* CONFIG_40x */
-	printk(KERN_DEBUG " TXCASR   ==> 0x%x\n",
-	       (unsigned int)get_mal_dcrn(mal, DCRN_MALTXCASR));
-	printk(KERN_DEBUG " TXCARR   ==> 0x%x\n",
-	       (unsigned int)get_mal_dcrn(mal, DCRN_MALTXCARR));
-	printk(KERN_DEBUG " TXEOBISR ==> 0x%x\n",
-	       (unsigned int)get_mal_dcrn(mal, DCRN_MALTXEOBISR));
-	printk(KERN_DEBUG " TXDEIR   ==> 0x%x\n",
-	       (unsigned int)get_mal_dcrn(mal, DCRN_MALTXDEIR));
-	printk(KERN_DEBUG " RXCASR   ==> 0x%x\n",
-	       (unsigned int)get_mal_dcrn(mal, DCRN_MALRXCASR));
-	printk(KERN_DEBUG " RXCARR   ==> 0x%x\n",
-	       (unsigned int)get_mal_dcrn(mal, DCRN_MALRXCARR));
-	printk(KERN_DEBUG " RXEOBISR ==> 0x%x\n",
-	       (unsigned int)get_mal_dcrn(mal, DCRN_MALRXEOBISR));
-	printk(KERN_DEBUG " RXDEIR   ==> 0x%x\n",
-	       (unsigned int)get_mal_dcrn(mal, DCRN_MALRXDEIR));
-	printk(KERN_DEBUG " TXCTP0R  ==> 0x%x\n",
-	       (unsigned int)get_mal_dcrn(mal, DCRN_MALTXCTP0R));
-	printk(KERN_DEBUG " TXCTP1R  ==> 0x%x\n",
-	       (unsigned int)get_mal_dcrn(mal, DCRN_MALTXCTP1R));
-	printk(KERN_DEBUG " TXCTP2R  ==> 0x%x\n",
-	       (unsigned int)get_mal_dcrn(mal, DCRN_MALTXCTP2R));
-	printk(KERN_DEBUG " TXCTP3R  ==> 0x%x\n",
-	       (unsigned int)get_mal_dcrn(mal, DCRN_MALTXCTP3R));
-	printk(KERN_DEBUG " RXCTP0R  ==> 0x%x\n",
-	       (unsigned int)get_mal_dcrn(mal, DCRN_MALRXCTP0R));
-	printk(KERN_DEBUG " RXCTP1R  ==> 0x%x\n",
-	       (unsigned int)get_mal_dcrn(mal, DCRN_MALRXCTP1R));
-	printk(KERN_DEBUG " RCBS0    ==> 0x%x\n",
-	       (unsigned int)get_mal_dcrn(mal, DCRN_MALRCBS0));
-	printk(KERN_DEBUG " RCBS1    ==> 0x%x\n",
-	       (unsigned int)get_mal_dcrn(mal, DCRN_MALRCBS1));
-}
-
-void emac_serr_dump_0(struct net_device *dev)
-{
-	struct ibm_ocp_mal *mal = ((struct ocp_enet_private *)dev->priv)->mal;
-	unsigned long int mal_error, plb_error, plb_addr;
-
-	mal_error = get_mal_dcrn(mal, DCRN_MALESR);
-	printk(KERN_DEBUG "ppc405_eth_serr: %s channel %ld \n",
-	       (mal_error & 0x40000000) ? "Receive" :
-	       "Transmit", (mal_error & 0x3e000000) >> 25);
-	printk(KERN_DEBUG "  -----  latched error  -----\n");
-	if (mal_error & MALESR_DE)
-		printk(KERN_DEBUG "  DE: descriptor error\n");
-	if (mal_error & MALESR_OEN)
-		printk(KERN_DEBUG "  ONE: OPB non-fullword error\n");
-	if (mal_error & MALESR_OTE)
-		printk(KERN_DEBUG "  OTE: OPB timeout error\n");
-	if (mal_error & MALESR_OSE)
-		printk(KERN_DEBUG "  OSE: OPB slave error\n");
-
-	if (mal_error & MALESR_PEIN) {
-		plb_error = mfdcr(DCRN_PLB0_BESR);
-		printk(KERN_DEBUG
-		       "  PEIN: PLB error, PLB0_BESR is 0x%x\n",
-		       (unsigned int)plb_error);
-		plb_addr = mfdcr(DCRN_PLB0_BEAR);
-		printk(KERN_DEBUG
-		       "  PEIN: PLB error, PLB0_BEAR is 0x%x\n",
-		       (unsigned int)plb_addr);
+	if (idx >= sizeof(__mals) / sizeof(__mals[0])) {
+		printk(KERN_WARNING
+		       "invalid index %d when registering MAL for debugging\n",
+		       idx);
+		return;
 	}
+
+	local_irq_save(flags);
+	__mals[idx] = mal;
+	local_irq_restore(flags);
+}
+
+void emac_dbg_dump_all(void)
+{
+	unsigned int i;
+	unsigned long flags;
+
+	local_irq_save(flags);
+
+	for (i = 0; i < sizeof(__mals) / sizeof(__mals[0]); ++i)
+		if (__mals[i])
+			emac_mal_dump(__mals[i]);
+
+	for (i = 0; i < sizeof(__emacs) / sizeof(__emacs[0]); ++i)
+		if (__emacs[i])
+			emac_mac_dump(i, __emacs[i]);
+
+	local_irq_restore(flags);
+}
+
+#if defined(CONFIG_MAGIC_SYSRQ)
+static void emac_sysrq_handler(int key, struct pt_regs *pt_regs,
+			       struct tty_struct *tty)
+{
+	emac_dbg_dump_all();
 }
 
-void emac_serr_dump_1(struct net_device *dev)
+static struct sysrq_key_op emac_sysrq_op = {
+	.handler = emac_sysrq_handler,
+	.help_msg = "emaC",
+	.action_msg = "Show EMAC(s) status",
+};
+
+int __init emac_init_debug(void)
 {
-	struct ibm_ocp_mal *mal = ((struct ocp_enet_private *)dev->priv)->mal;
-	int mal_error = get_mal_dcrn(mal, DCRN_MALESR);
+	return register_sysrq_key('c', &emac_sysrq_op);
+}
 
-	printk(KERN_DEBUG "  -----  cumulative errors  -----\n");
-	if (mal_error & MALESR_DEI)
-		printk(KERN_DEBUG "  DEI: descriptor error interrupt\n");
-	if (mal_error & MALESR_ONEI)
-		printk(KERN_DEBUG "  OPB non-fullword error interrupt\n");
-	if (mal_error & MALESR_OTEI)
-		printk(KERN_DEBUG "  OTEI: timeout error interrupt\n");
-	if (mal_error & MALESR_OSEI)
-		printk(KERN_DEBUG "  OSEI: slave error interrupt\n");
-	if (mal_error & MALESR_PBEI)
-		printk(KERN_DEBUG "  PBEI: PLB bus error interrupt\n");
-}
-
-void emac_err_dump(struct net_device *dev, int em0isr)
-{
-	printk(KERN_DEBUG "%s: on-chip ethernet error:\n", dev->name);
-
-	if (em0isr & EMAC_ISR_OVR)
-		printk(KERN_DEBUG "  OVR: overrun\n");
-	if (em0isr & EMAC_ISR_PP)
-		printk(KERN_DEBUG "  PP: control pause packet\n");
-	if (em0isr & EMAC_ISR_BP)
-		printk(KERN_DEBUG "  BP: packet error\n");
-	if (em0isr & EMAC_ISR_RP)
-		printk(KERN_DEBUG "  RP: runt packet\n");
-	if (em0isr & EMAC_ISR_SE)
-		printk(KERN_DEBUG "  SE: short event\n");
-	if (em0isr & EMAC_ISR_ALE)
-		printk(KERN_DEBUG "  ALE: odd number of nibbles in packet\n");
-	if (em0isr & EMAC_ISR_BFCS)
-		printk(KERN_DEBUG "  BFCS: bad FCS\n");
-	if (em0isr & EMAC_ISR_PTLE)
-		printk(KERN_DEBUG "  PTLE: oversized packet\n");
-	if (em0isr & EMAC_ISR_ORE)
-		printk(KERN_DEBUG
-		       "  ORE: packet length field > max allowed LLC\n");
-	if (em0isr & EMAC_ISR_IRE)
-		printk(KERN_DEBUG "  IRE: In Range error\n");
-	if (em0isr & EMAC_ISR_DBDM)
-		printk(KERN_DEBUG "  DBDM: xmit error or SQE\n");
-	if (em0isr & EMAC_ISR_DB0)
-		printk(KERN_DEBUG "  DB0: xmit error or SQE on TX channel 0\n");
-	if (em0isr & EMAC_ISR_SE0)
-		printk(KERN_DEBUG
-		       "  SE0: Signal Quality Error test failure from TX channel 0\n");
-	if (em0isr & EMAC_ISR_TE0)
-		printk(KERN_DEBUG "  TE0: xmit channel 0 aborted\n");
-	if (em0isr & EMAC_ISR_DB1)
-		printk(KERN_DEBUG "  DB1: xmit error or SQE on TX channel \n");
-	if (em0isr & EMAC_ISR_SE1)
-		printk(KERN_DEBUG
-		       "  SE1: Signal Quality Error test failure from TX channel 1\n");
-	if (em0isr & EMAC_ISR_TE1)
-		printk(KERN_DEBUG "  TE1: xmit channel 1 aborted\n");
-	if (em0isr & EMAC_ISR_MOS)
-		printk(KERN_DEBUG "  MOS\n");
-	if (em0isr & EMAC_ISR_MOF)
-		printk(KERN_DEBUG "  MOF\n");
+void __exit emac_fini_debug(void)
+{
+	unregister_sysrq_key('c', &emac_sysrq_op);
+}
 
-	emac_mac_dump(dev);
-	emac_mal_dump(dev);
+#else
+int __init emac_init_debug(void)
+{
+	return 0;
+}
+void __exit emac_fini_debug(void)
+{
 }
+#endif				/* CONFIG_MAGIC_SYSRQ */
diff -puN /dev/null drivers/net/ibm_emac/ibm_emac_debug.h
--- /dev/null	2003-09-15 06:40:47.000000000 -0700
+++ devel-akpm/drivers/net/ibm_emac/ibm_emac_debug.h	2005-10-28 17:44:03.000000000 -0700
@@ -0,0 +1,63 @@
+/*
+ * drivers/net/ibm_emac/ibm_ocp_debug.h
+ *
+ * Driver for PowerPC 4xx on-chip ethernet controller, debug print routines.
+ *
+ * Copyright (c) 2004, 2005 Zultys Technologies
+ * Eugene Surovegin <eugene.surovegin@zultys.com> or <ebs@ebshome.net>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ */
+#ifndef __IBM_EMAC_DEBUG_H_
+#define __IBM_EMAC_DEBUG_H_
+
+#include <linux/config.h>
+#include <linux/init.h>
+#include "ibm_emac_core.h"
+#include "ibm_emac_mal.h"
+
+#if defined(CONFIG_IBM_EMAC_DEBUG)
+void emac_dbg_register(int idx, struct ocp_enet_private *dev);
+void mal_dbg_register(int idx, struct ibm_ocp_mal *mal);
+int emac_init_debug(void) __init;
+void emac_fini_debug(void) __exit;
+void emac_dbg_dump_all(void);
+# define DBG_LEVEL		1
+#else
+# define emac_dbg_register(x,y) ((void)0)
+# define mal_dbg_register(x,y)	((void)0)
+# define emac_init_debug()	((void)0)
+# define emac_fini_debug()	((void)0)
+# define emac_dbg_dump_all()	((void)0)
+# define DBG_LEVEL		0
+#endif
+
+#if DBG_LEVEL > 0
+#  define DBG(f,x...)		printk("emac" f, ##x)
+#  define MAL_DBG(f,x...)	printk("mal" f, ##x)
+#  define ZMII_DBG(f,x...)	printk("zmii" f, ##x)
+#  define RGMII_DBG(f,x...)	printk("rgmii" f, ##x)
+#  define NL			"\n"
+#else
+#  define DBG(f,x...)		((void)0)
+#  define MAL_DBG(f,x...)	((void)0)
+#  define ZMII_DBG(f,x...)	((void)0)
+#  define RGMII_DBG(f,x...)	((void)0)
+#endif
+#if DBG_LEVEL > 1
+#  define DBG2(f,x...) 		DBG(f, ##x)
+#  define MAL_DBG2(f,x...) 	MAL_DBG(f, ##x)
+#  define ZMII_DBG2(f,x...) 	ZMII_DBG(f, ##x)
+#  define RGMII_DBG2(f,x...) 	RGMII_DBG(f, ##x)
+#else
+#  define DBG2(f,x...) 		((void)0)
+#  define MAL_DBG2(f,x...) 	((void)0)
+#  define ZMII_DBG2(f,x...) 	((void)0)
+#  define RGMII_DBG2(f,x...) 	((void)0)
+#endif
+
+#endif				/* __IBM_EMAC_DEBUG_H_ */
diff -puN drivers/net/ibm_emac/ibm_emac.h~new-powerpc-4xx-on-chip-ethernet-controller-driver drivers/net/ibm_emac/ibm_emac.h
--- devel/drivers/net/ibm_emac/ibm_emac.h~new-powerpc-4xx-on-chip-ethernet-controller-driver	2005-10-28 17:44:03.000000000 -0700
+++ devel-akpm/drivers/net/ibm_emac/ibm_emac.h	2005-10-28 17:44:03.000000000 -0700
@@ -1,110 +1,142 @@
 /*
- * ibm_emac.h
+ * drivers/net/ibm_emac/ibm_emac.h
  *
+ * Register definitions for PowerPC 4xx on-chip ethernet contoller
  *
- *      Armin Kuster akuster@mvista.com
- *      June, 2002
+ * Copyright (c) 2004, 2005 Zultys Technologies.
+ * Eugene Surovegin <eugene.surovegin@zultys.com> or <ebs@ebshome.net>
  *
- * Copyright 2002 MontaVista Softare Inc.
+ * Based on original work by
+ *      Matt Porter <mporter@kernel.crashing.org>
+ *      Armin Kuster <akuster@mvista.com>
+ * 	Copyright 2002-2004 MontaVista Software Inc.
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
  * Free Software Foundation;  either version 2 of the  License, or (at your
  * option) any later version.
+ *
  */
+#ifndef __IBM_EMAC_H_
+#define __IBM_EMAC_H_
+
+#include <linux/config.h>
+#include <linux/types.h>
+
+/* This is a simple check to prevent use of this driver on non-tested SoCs */
+#if !defined(CONFIG_405GP) && !defined(CONFIG_405GPR) && !defined(CONFIG_405EP) && \
+    !defined(CONFIG_440GP) && !defined(CONFIG_440GX) && !defined(CONFIG_440SP) && \
+    !defined(CONFIG_440EP) && !defined(CONFIG_NP405H)
+#error	"Unknown SoC. Please, check chip user manual and make sure EMAC defines are OK"
+#endif
+
+/* EMAC registers 		Write Access rules */
+struct emac_regs {
+	u32 mr0;		/* special 	*/
+	u32 mr1;		/* Reset 	*/
+	u32 tmr0;		/* special 	*/
+	u32 tmr1;		/* special 	*/
+	u32 rmr;		/* Reset 	*/
+	u32 isr;		/* Always 	*/
+	u32 iser;		/* Reset 	*/
+	u32 iahr;		/* Reset, R, T 	*/
+	u32 ialr;		/* Reset, R, T 	*/
+	u32 vtpid;		/* Reset, R, T 	*/
+	u32 vtci;		/* Reset, R, T 	*/
+	u32 ptr;		/* Reset,    T 	*/
+	u32 iaht1;		/* Reset, R	*/
+	u32 iaht2;		/* Reset, R	*/
+	u32 iaht3;		/* Reset, R	*/
+	u32 iaht4;		/* Reset, R	*/
+	u32 gaht1;		/* Reset, R	*/
+	u32 gaht2;		/* Reset, R	*/
+	u32 gaht3;		/* Reset, R	*/
+	u32 gaht4;		/* Reset, R	*/
+	u32 lsah;
+	u32 lsal;
+	u32 ipgvr;		/* Reset,    T 	*/
+	u32 stacr;		/* special 	*/
+	u32 trtr;		/* special 	*/
+	u32 rwmr;		/* Reset 	*/
+	u32 octx;
+	u32 ocrx;
+	u32 ipcr;
+};
+
+#if !defined(CONFIG_IBM_EMAC4)
+#define EMAC_ETHTOOL_REGS_VER		0
+#define EMAC_ETHTOOL_REGS_SIZE		(sizeof(struct emac_regs) - sizeof(u32))
+#else
+#define EMAC_ETHTOOL_REGS_VER		1
+#define EMAC_ETHTOOL_REGS_SIZE		sizeof(struct emac_regs)
+#endif
+
+/* EMACx_MR0 */
+#define EMAC_MR0_RXI			0x80000000
+#define EMAC_MR0_TXI			0x40000000
+#define EMAC_MR0_SRST			0x20000000
+#define EMAC_MR0_TXE			0x10000000
+#define EMAC_MR0_RXE			0x08000000
+#define EMAC_MR0_WKE			0x04000000
+
+/* EMACx_MR1 */
+#define EMAC_MR1_FDE			0x80000000
+#define EMAC_MR1_ILE			0x40000000
+#define EMAC_MR1_VLE			0x20000000
+#define EMAC_MR1_EIFC			0x10000000
+#define EMAC_MR1_APP			0x08000000
+#define EMAC_MR1_IST			0x01000000
+
+#define EMAC_MR1_MF_MASK		0x00c00000
+#define EMAC_MR1_MF_10			0x00000000
+#define EMAC_MR1_MF_100			0x00400000
+#if !defined(CONFIG_IBM_EMAC4)
+#define EMAC_MR1_MF_1000		0x00000000
+#define EMAC_MR1_MF_1000GPCS		0x00000000
+#define EMAC_MR1_MF_IPPA(id)		0x00000000
+#else
+#define EMAC_MR1_MF_1000		0x00800000
+#define EMAC_MR1_MF_1000GPCS		0x00c00000
+#define EMAC_MR1_MF_IPPA(id)		(((id) & 0x1f) << 6)
+#endif
+
+#define EMAC_TX_FIFO_SIZE		2048
+
+#if !defined(CONFIG_IBM_EMAC4)
+#define EMAC_MR1_RFS_4K			0x00300000
+#define EMAC_MR1_RFS_16K		0x00000000
+#define EMAC_RX_FIFO_SIZE(gige)		4096
+#define EMAC_MR1_TFS_2K			0x00080000
+#define EMAC_MR1_TR0_MULT		0x00008000
+#define EMAC_MR1_JPSM			0x00000000
+#define EMAC_MR1_BASE(opb)		(EMAC_MR1_TFS_2K | EMAC_MR1_TR0_MULT)
+#else
+#define EMAC_MR1_RFS_4K			0x00180000
+#define EMAC_MR1_RFS_16K		0x00280000
+#define EMAC_RX_FIFO_SIZE(gige)		((gige) ? 16384 : 4096)
+#define EMAC_MR1_TFS_2K			0x00020000
+#define EMAC_MR1_TR			0x00008000
+#define EMAC_MR1_MWSW_001		0x00001000
+#define EMAC_MR1_JPSM			0x00000800
+#define EMAC_MR1_OBCI_MASK		0x00000038
+#define EMAC_MR1_OBCI_50		0x00000000
+#define EMAC_MR1_OBCI_66		0x00000008
+#define EMAC_MR1_OBCI_83		0x00000010
+#define EMAC_MR1_OBCI_100		0x00000018
+#define EMAC_MR1_OBCI_100P		0x00000020
+#define EMAC_MR1_OBCI(freq)		((freq) <= 50  ? EMAC_MR1_OBCI_50 : \
+					 (freq) <= 66  ? EMAC_MR1_OBCI_66 : \
+					 (freq) <= 83  ? EMAC_MR1_OBCI_83 : \
+					 (freq) <= 100 ? EMAC_MR1_OBCI_100 : EMAC_MR1_OBCI_100P)
+#define EMAC_MR1_BASE(opb)		(EMAC_MR1_TFS_2K | EMAC_MR1_TR | \
+					 EMAC_MR1_MWSW_001 | EMAC_MR1_OBCI(opb))
+#endif
 
-#ifndef _IBM_EMAC_H_
-#define _IBM_EMAC_H_
-/* General defines needed for the driver */
-
-/* Emac */
-typedef struct emac_regs {
-	u32 em0mr0;
-	u32 em0mr1;
-	u32 em0tmr0;
-	u32 em0tmr1;
-	u32 em0rmr;
-	u32 em0isr;
-	u32 em0iser;
-	u32 em0iahr;
-	u32 em0ialr;
-	u32 em0vtpid;
-	u32 em0vtci;
-	u32 em0ptr;
-	u32 em0iaht1;
-	u32 em0iaht2;
-	u32 em0iaht3;
-	u32 em0iaht4;
-	u32 em0gaht1;
-	u32 em0gaht2;
-	u32 em0gaht3;
-	u32 em0gaht4;
-	u32 em0lsah;
-	u32 em0lsal;
-	u32 em0ipgvr;
-	u32 em0stacr;
-	u32 em0trtr;
-	u32 em0rwmr;
-} emac_t;
-
-/* MODE REG 0 */
-#define EMAC_M0_RXI			0x80000000
-#define EMAC_M0_TXI			0x40000000
-#define EMAC_M0_SRST			0x20000000
-#define EMAC_M0_TXE			0x10000000
-#define EMAC_M0_RXE			0x08000000
-#define EMAC_M0_WKE			0x04000000
-
-/* MODE Reg 1 */
-#define EMAC_M1_FDE			0x80000000
-#define EMAC_M1_ILE			0x40000000
-#define EMAC_M1_VLE			0x20000000
-#define EMAC_M1_EIFC			0x10000000
-#define EMAC_M1_APP			0x08000000
-#define EMAC_M1_AEMI			0x02000000
-#define EMAC_M1_IST			0x01000000
-#define EMAC_M1_MF_1000GPCS		0x00c00000	/* Internal GPCS */
-#define EMAC_M1_MF_1000MBPS		0x00800000	/* External GPCS */
-#define EMAC_M1_MF_100MBPS		0x00400000
-#define EMAC_M1_RFS_16K                 0x00280000	/* 000 for 512 byte */
-#define EMAC_M1_TR			0x00008000
-#ifdef CONFIG_IBM_EMAC4
-#define EMAC_M1_RFS_8K                  0x00200000
-#define EMAC_M1_RFS_4K                  0x00180000
-#define EMAC_M1_RFS_2K                  0x00100000
-#define EMAC_M1_RFS_1K                  0x00080000
-#define EMAC_M1_TX_FIFO_16K             0x00050000	/* 0's for 512 byte */
-#define EMAC_M1_TX_FIFO_8K              0x00040000
-#define EMAC_M1_TX_FIFO_4K              0x00030000
-#define EMAC_M1_TX_FIFO_2K              0x00020000
-#define EMAC_M1_TX_FIFO_1K              0x00010000
-#define EMAC_M1_TX_TR                   0x00008000
-#define EMAC_M1_TX_MWSW                 0x00001000	/* 0 wait for status */
-#define EMAC_M1_JUMBO_ENABLE            0x00000800	/* Upt to 9Kr status */
-#define EMAC_M1_OPB_CLK_66              0x00000008	/* 66Mhz */
-#define EMAC_M1_OPB_CLK_83              0x00000010	/* 83Mhz */
-#define EMAC_M1_OPB_CLK_100             0x00000018	/* 100Mhz */
-#define EMAC_M1_OPB_CLK_100P            0x00000020	/* 100Mhz+ */
-#else				/* CONFIG_IBM_EMAC4 */
-#define EMAC_M1_RFS_4K			0x00300000	/* ~4k for 512 byte */
-#define EMAC_M1_RFS_2K			0x00200000
-#define EMAC_M1_RFS_1K			0x00100000
-#define EMAC_M1_TX_FIFO_2K		0x00080000	/* 0's for 512 byte */
-#define EMAC_M1_TX_FIFO_1K		0x00040000
-#define EMAC_M1_TR0_DEPEND		0x00010000	/* 0'x for single packet */
-#define EMAC_M1_TR1_DEPEND		0x00004000
-#define EMAC_M1_TR1_MULTI		0x00002000
-#define EMAC_M1_JUMBO_ENABLE		0x00001000
-#endif				/* CONFIG_IBM_EMAC4 */
-#define EMAC_M1_BASE			(EMAC_M1_TX_FIFO_2K | \
-					EMAC_M1_APP | \
-					EMAC_M1_TR | EMAC_M1_VLE)
-
-/* Transmit Mode Register 0 */
-#define EMAC_TMR0_GNP0			0x80000000
-#define EMAC_TMR0_GNP1			0x40000000
-#define EMAC_TMR0_GNPD			0x20000000
-#define EMAC_TMR0_FC			0x10000000
+/* EMACx_TMR0 */
+#define EMAC_TMR0_GNP			0x80000000
+#if !defined(CONFIG_IBM_EMAC4)
+#define EMAC_TMR0_DEFAULT		0x00000000
+#else
 #define EMAC_TMR0_TFAE_2_32		0x00000001
 #define EMAC_TMR0_TFAE_4_64		0x00000002
 #define EMAC_TMR0_TFAE_8_128		0x00000003
@@ -112,14 +144,36 @@ typedef struct emac_regs {
 #define EMAC_TMR0_TFAE_32_512		0x00000005
 #define EMAC_TMR0_TFAE_64_1024		0x00000006
 #define EMAC_TMR0_TFAE_128_2048		0x00000007
+#define EMAC_TMR0_DEFAULT		EMAC_TMR0_TFAE_2_32
+#endif
+#define EMAC_TMR0_XMIT			(EMAC_TMR0_GNP | EMAC_TMR0_DEFAULT)
+
+/* EMACx_TMR1 */
+
+/* IBM manuals are not very clear here.
+ * This is my interpretation of how things are. --ebs
+ */
+#if defined(CONFIG_40x)
+#define EMAC_FIFO_ENTRY_SIZE		8
+#define EMAC_MAL_BURST_SIZE		(16 * 4)
+#else
+#define EMAC_FIFO_ENTRY_SIZE		16
+#define EMAC_MAL_BURST_SIZE		(64 * 4)
+#endif
+
+#if !defined(CONFIG_IBM_EMAC4)
+#define EMAC_TMR1(l,h)			(((l) << 27) | (((h) & 0xff) << 16))
+#else
+#define EMAC_TMR1(l,h)			(((l) << 27) | (((h) & 0x3ff) << 14))
+#endif
 
-/* Receive Mode Register */
+/* EMACx_RMR */
 #define EMAC_RMR_SP			0x80000000
 #define EMAC_RMR_SFCS			0x40000000
-#define EMAC_RMR_ARRP			0x20000000
-#define EMAC_RMR_ARP			0x10000000
-#define EMAC_RMR_AROP			0x08000000
-#define EMAC_RMR_ARPI			0x04000000
+#define EMAC_RMR_RRP			0x20000000
+#define EMAC_RMR_RFP			0x10000000
+#define EMAC_RMR_ROP			0x08000000
+#define EMAC_RMR_RPIR			0x04000000
 #define EMAC_RMR_PPP			0x02000000
 #define EMAC_RMR_PME			0x01000000
 #define EMAC_RMR_PMME			0x00800000
@@ -127,6 +181,9 @@ typedef struct emac_regs {
 #define EMAC_RMR_MIAE			0x00200000
 #define EMAC_RMR_BAE			0x00100000
 #define EMAC_RMR_MAE			0x00080000
+#if !defined(CONFIG_IBM_EMAC4)
+#define EMAC_RMR_BASE			0x00000000
+#else
 #define EMAC_RMR_RFAF_2_32		0x00000001
 #define EMAC_RMR_RFAF_4_64		0x00000002
 #define EMAC_RMR_RFAF_8_128		0x00000003
@@ -134,9 +191,21 @@ typedef struct emac_regs {
 #define EMAC_RMR_RFAF_32_512		0x00000005
 #define EMAC_RMR_RFAF_64_1024		0x00000006
 #define EMAC_RMR_RFAF_128_2048		0x00000007
-#define EMAC_RMR_BASE			(EMAC_RMR_IAE | EMAC_RMR_BAE)
+#define EMAC_RMR_BASE			EMAC_RMR_RFAF_128_2048
+#endif
 
-/* Interrupt Status & enable Regs */
+/* EMACx_ISR & EMACx_ISER */
+#if !defined(CONFIG_IBM_EMAC4)
+#define EMAC_ISR_TXPE			0x00000000
+#define EMAC_ISR_RXPE			0x00000000
+#define EMAC_ISR_TXUE			0x00000000
+#define EMAC_ISR_RXOE			0x00000000
+#else
+#define EMAC_ISR_TXPE			0x20000000
+#define EMAC_ISR_RXPE			0x10000000
+#define EMAC_ISR_TXUE			0x08000000
+#define EMAC_ISR_RXOE			0x04000000
+#endif
 #define EMAC_ISR_OVR			0x02000000
 #define EMAC_ISR_PP			0x01000000
 #define EMAC_ISR_BP			0x00800000
@@ -147,53 +216,62 @@ typedef struct emac_regs {
 #define EMAC_ISR_PTLE			0x00040000
 #define EMAC_ISR_ORE			0x00020000
 #define EMAC_ISR_IRE			0x00010000
-#define EMAC_ISR_DBDM			0x00000200
-#define EMAC_ISR_DB0			0x00000100
-#define EMAC_ISR_SE0			0x00000080
-#define EMAC_ISR_TE0			0x00000040
-#define EMAC_ISR_DB1			0x00000020
-#define EMAC_ISR_SE1			0x00000010
-#define EMAC_ISR_TE1			0x00000008
+#define EMAC_ISR_SQE			0x00000080
+#define EMAC_ISR_TE			0x00000040
 #define EMAC_ISR_MOS			0x00000002
 #define EMAC_ISR_MOF			0x00000001
 
-/* STA CONTROL REG */
+/* EMACx_STACR */
+#define EMAC_STACR_PHYD_MASK		0xffff
+#define EMAC_STACR_PHYD_SHIFT		16
 #define EMAC_STACR_OC			0x00008000
 #define EMAC_STACR_PHYE			0x00004000
-#define EMAC_STACR_WRITE		0x00002000
-#define EMAC_STACR_READ			0x00001000
-#define EMAC_STACR_CLK_83MHZ		0x00000800	/* 0's for 50Mhz */
-#define EMAC_STACR_CLK_66MHZ		0x00000400
-#define EMAC_STACR_CLK_100MHZ		0x00000C00
-
-/* Transmit Request Threshold Register */
-#define EMAC_TRTR_1600			0x18000000	/* 0's for 64 Bytes */
-#define EMAC_TRTR_1024			0x0f000000
-#define EMAC_TRTR_512			0x07000000
-#define EMAC_TRTR_256			0x03000000
-#define EMAC_TRTR_192			0x10000000
-#define EMAC_TRTR_128			0x01000000
+#define EMAC_STACR_STAC_MASK		0x00003000
+#define EMAC_STACR_STAC_READ		0x00001000
+#define EMAC_STACR_STAC_WRITE		0x00002000
+#if !defined(CONFIG_IBM_EMAC4)
+#define EMAC_STACR_OPBC_MASK		0x00000C00
+#define EMAC_STACR_OPBC_50		0x00000000
+#define EMAC_STACR_OPBC_66		0x00000400
+#define EMAC_STACR_OPBC_83		0x00000800
+#define EMAC_STACR_OPBC_100		0x00000C00
+#define EMAC_STACR_OPBC(freq)		((freq) <= 50 ? EMAC_STACR_OPBC_50 : \
+					 (freq) <= 66 ? EMAC_STACR_OPBC_66 : \
+					 (freq) <= 83 ? EMAC_STACR_OPBC_83 : EMAC_STACR_OPBC_100)
+#define EMAC_STACR_BASE(opb)		EMAC_STACR_OPBC(opb)
+#else
+#define EMAC_STACR_BASE(opb)		0x00000000
+#endif
+#define EMAC_STACR_PCDA_MASK		0x1f
+#define EMAC_STACR_PCDA_SHIFT		5
+#define EMAC_STACR_PRA_MASK		0x1f
+
+/* EMACx_TRTR */
+#if !defined(CONFIG_IBM_EMAC4)
+#define EMAC_TRTR_SHIFT			27
+#else
+#define EMAC_TRTR_SHIFT			24
+#endif
+#define EMAC_TRTR(size)			((((size) >> 6) - 1) << EMAC_TRTR_SHIFT)
+
+/* EMACx_RWMR */
+#if !defined(CONFIG_IBM_EMAC4)
+#define EMAC_RWMR(l,h)			(((l) << 23) | ( ((h) & 0x1ff) << 7))
+#else
+#define EMAC_RWMR(l,h)			(((l) << 22) | ( ((h) & 0x3ff) << 6))
+#endif
 
+/* EMAC specific TX descriptor control fields (write access) */
 #define EMAC_TX_CTRL_GFCS		0x0200
 #define EMAC_TX_CTRL_GP			0x0100
 #define EMAC_TX_CTRL_ISA		0x0080
 #define EMAC_TX_CTRL_RSA		0x0040
 #define EMAC_TX_CTRL_IVT		0x0020
 #define EMAC_TX_CTRL_RVT		0x0010
-#define EMAC_TX_CTRL_TAH_CSUM		0x000e	/* TAH only */
-#define EMAC_TX_CTRL_TAH_SEG4		0x000a	/* TAH only */
-#define EMAC_TX_CTRL_TAH_SEG3		0x0008	/* TAH only */
-#define EMAC_TX_CTRL_TAH_SEG2		0x0006	/* TAH only */
-#define EMAC_TX_CTRL_TAH_SEG1		0x0004	/* TAH only */
-#define EMAC_TX_CTRL_TAH_SEG0		0x0002	/* TAH only */
-#define EMAC_TX_CTRL_TAH_DIS		0x0000	/* TAH only */
-
-#define EMAC_TX_CTRL_DFLT ( \
-	MAL_TX_CTRL_INTR | EMAC_TX_CTRL_GFCS | EMAC_TX_CTRL_GP )
+#define EMAC_TX_CTRL_TAH_CSUM		0x000e
 
-/* madmal transmit status / Control bits */
+/* EMAC specific TX descriptor status fields (read access) */
 #define EMAC_TX_ST_BFCS			0x0200
-#define EMAC_TX_ST_BPP			0x0100
 #define EMAC_TX_ST_LCS			0x0080
 #define EMAC_TX_ST_ED			0x0040
 #define EMAC_TX_ST_EC			0x0020
@@ -202,8 +280,16 @@ typedef struct emac_regs {
 #define EMAC_TX_ST_SC			0x0004
 #define EMAC_TX_ST_UR			0x0002
 #define EMAC_TX_ST_SQE			0x0001
+#if !defined(CONFIG_IBM_EMAC_TAH)
+#define EMAC_IS_BAD_TX(v)		((v) & (EMAC_TX_ST_LCS | EMAC_TX_ST_ED | \
+					 EMAC_TX_ST_EC | EMAC_TX_ST_LC | \
+					 EMAC_TX_ST_MC | EMAC_TX_ST_UR))
+#else
+#define EMAC_IS_BAD_TX(v)		((v) & (EMAC_TX_ST_LCS | EMAC_TX_ST_ED | \
+					 EMAC_TX_ST_EC | EMAC_TX_ST_LC))
+#endif
 
-/* madmal receive status / Control bits */
+/* EMAC specific RX descriptor status fields (read access) */
 #define EMAC_RX_ST_OE			0x0200
 #define EMAC_RX_ST_PP			0x0100
 #define EMAC_RX_ST_BP			0x0080
@@ -214,54 +300,10 @@ typedef struct emac_regs {
 #define EMAC_RX_ST_PTL			0x0004
 #define EMAC_RX_ST_ORE			0x0002
 #define EMAC_RX_ST_IRE			0x0001
-#define EMAC_BAD_RX_PACKET		0x02ff
-#define EMAC_CSUM_VER_ERROR		0x0003
-
-/* identify a bad rx packet dependent on emac features */
-#ifdef CONFIG_IBM_EMAC4
-#define EMAC_IS_BAD_RX_PACKET(desc) \
-	(((desc & (EMAC_BAD_RX_PACKET & ~EMAC_CSUM_VER_ERROR)) || \
-	((desc & EMAC_CSUM_VER_ERROR) == EMAC_RX_ST_ORE) || \
-	((desc & EMAC_CSUM_VER_ERROR) == EMAC_RX_ST_IRE)))
-#else
-#define EMAC_IS_BAD_RX_PACKET(desc) \
-	 (desc & EMAC_BAD_RX_PACKET)
-#endif
-
-/* SoC implementation specific EMAC register defaults */
-#if defined(CONFIG_440GP)
-#define EMAC_RWMR_DEFAULT		0x80009000
-#define EMAC_TMR0_DEFAULT		0x00000000
-#define EMAC_TMR1_DEFAULT		0xf8640000
-#elif defined(CONFIG_440GX)
-#define EMAC_RWMR_DEFAULT		0x1000a200
-#define EMAC_TMR0_DEFAULT		EMAC_TMR0_TFAE_2_32
-#define EMAC_TMR1_DEFAULT		0xa00f0000
-#elif defined(CONFIG_440SP)
-#define EMAC_RWMR_DEFAULT		0x08002000
-#define EMAC_TMR0_DEFAULT		EMAC_TMR0_TFAE_128_2048
-#define EMAC_TMR1_DEFAULT		0xf8200000
-#else
-#define EMAC_RWMR_DEFAULT		0x0f002000
-#define EMAC_TMR0_DEFAULT		0x00000000
-#define EMAC_TMR1_DEFAULT		0x380f0000
-#endif				/* CONFIG_440GP */
-
-/* Revision specific EMAC register defaults */
-#ifdef CONFIG_IBM_EMAC4
-#define EMAC_M1_DEFAULT			(EMAC_M1_BASE | \
-					EMAC_M1_OPB_CLK_83 | \
-					EMAC_M1_TX_MWSW)
-#define EMAC_RMR_DEFAULT		(EMAC_RMR_BASE | \
-					EMAC_RMR_RFAF_128_2048)
-#define EMAC_TMR0_XMIT			(EMAC_TMR0_GNP0 | \
-					EMAC_TMR0_DEFAULT)
-#define EMAC_TRTR_DEFAULT		EMAC_TRTR_1024
-#else				/* !CONFIG_IBM_EMAC4 */
-#define EMAC_M1_DEFAULT			EMAC_M1_BASE
-#define EMAC_RMR_DEFAULT		EMAC_RMR_BASE
-#define EMAC_TMR0_XMIT			EMAC_TMR0_GNP0
-#define EMAC_TRTR_DEFAULT		EMAC_TRTR_1600
-#endif				/* CONFIG_IBM_EMAC4 */
-
-#endif
+#define EMAC_RX_TAH_BAD_CSUM		0x0003
+#define EMAC_BAD_RX_MASK		(EMAC_RX_ST_OE | EMAC_RX_ST_BP | \
+					 EMAC_RX_ST_RP | EMAC_RX_ST_SE | \
+					 EMAC_RX_ST_AE | EMAC_RX_ST_BFCS | \
+					 EMAC_RX_ST_PTL | EMAC_RX_ST_ORE | \
+					 EMAC_RX_ST_IRE )
+#endif /* __IBM_EMAC_H_ */
diff -puN drivers/net/ibm_emac/ibm_emac_mal.c~new-powerpc-4xx-on-chip-ethernet-controller-driver drivers/net/ibm_emac/ibm_emac_mal.c
--- devel/drivers/net/ibm_emac/ibm_emac_mal.c~new-powerpc-4xx-on-chip-ethernet-controller-driver	2005-10-28 17:44:03.000000000 -0700
+++ devel-akpm/drivers/net/ibm_emac/ibm_emac_mal.c	2005-10-28 17:44:03.000000000 -0700
@@ -1,436 +1,565 @@
 /*
- * ibm_ocp_mal.c
+ * drivers/net/ibm_emac/ibm_emac_mal.c
  *
- *      Armin Kuster akuster@mvista.com
- *      Juen, 2002
+ * Memory Access Layer (MAL) support
  *
- * Copyright 2002 MontaVista Softare Inc.
+ * Copyright (c) 2004, 2005 Zultys Technologies.
+ * Eugene Surovegin <eugene.surovegin@zultys.com> or <ebs@ebshome.net>
+ *
+ * Based on original work by
+ *      Benjamin Herrenschmidt <benh@kernel.crashing.org>,
+ *      David Gibson <hermes@gibson.dropbear.id.au>,
+ *
+ *      Armin Kuster <akuster@mvista.com>
+ *      Copyright 2002 MontaVista Softare Inc.
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
  * Free Software Foundation;  either version 2 of the  License, or (at your
  * option) any later version.
+ *
  */
-
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/netdevice.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/dma-mapping.h>
 
-#include <asm/io.h>
-#include <asm/irq.h>
 #include <asm/ocp.h>
 
+#include "ibm_emac_core.h"
 #include "ibm_emac_mal.h"
+#include "ibm_emac_debug.h"
 
-// Locking: Should we share a lock with the client ? The client could provide
-// a lock pointer (optionally) in the commac structure... I don't think this is
-// really necessary though
-
-/* This lock protects the commac list. On today UP implementations, it's
- * really only used as IRQ protection in mal_{register,unregister}_commac()
- */
-static DEFINE_RWLOCK(mal_list_lock);
-
-int mal_register_commac(struct ibm_ocp_mal *mal, struct mal_commac *commac)
+int __init mal_register_commac(struct ibm_ocp_mal *mal,
+			       struct mal_commac *commac)
 {
 	unsigned long flags;
+	local_irq_save(flags);
 
-	write_lock_irqsave(&mal_list_lock, flags);
+	MAL_DBG("%d: reg(%08x, %08x)" NL, mal->def->index,
+		commac->tx_chan_mask, commac->rx_chan_mask);
 
-	/* Don't let multiple commacs claim the same channel */
+	/* Don't let multiple commacs claim the same channel(s) */
 	if ((mal->tx_chan_mask & commac->tx_chan_mask) ||
 	    (mal->rx_chan_mask & commac->rx_chan_mask)) {
-		write_unlock_irqrestore(&mal_list_lock, flags);
+		local_irq_restore(flags);
+		printk(KERN_WARNING "mal%d: COMMAC channels conflict!\n",
+		       mal->def->index);
 		return -EBUSY;
 	}
 
 	mal->tx_chan_mask |= commac->tx_chan_mask;
 	mal->rx_chan_mask |= commac->rx_chan_mask;
+	list_add(&commac->list, &mal->list);
 
-	list_add(&commac->list, &mal->commac);
-
-	write_unlock_irqrestore(&mal_list_lock, flags);
-
+	local_irq_restore(flags);
 	return 0;
 }
 
-int mal_unregister_commac(struct ibm_ocp_mal *mal, struct mal_commac *commac)
+void __exit mal_unregister_commac(struct ibm_ocp_mal *mal,
+				  struct mal_commac *commac)
 {
 	unsigned long flags;
+	local_irq_save(flags);
 
-	write_lock_irqsave(&mal_list_lock, flags);
+	MAL_DBG("%d: unreg(%08x, %08x)" NL, mal->def->index,
+		commac->tx_chan_mask, commac->rx_chan_mask);
 
 	mal->tx_chan_mask &= ~commac->tx_chan_mask;
 	mal->rx_chan_mask &= ~commac->rx_chan_mask;
-
 	list_del_init(&commac->list);
 
-	write_unlock_irqrestore(&mal_list_lock, flags);
-
-	return 0;
+	local_irq_restore(flags);
 }
 
 int mal_set_rcbs(struct ibm_ocp_mal *mal, int channel, unsigned long size)
 {
-	switch (channel) {
-	case 0:
-		set_mal_dcrn(mal, DCRN_MALRCBS0, size);
-		break;
-#ifdef DCRN_MALRCBS1
-	case 1:
-		set_mal_dcrn(mal, DCRN_MALRCBS1, size);
-		break;
-#endif
-#ifdef DCRN_MALRCBS2
-	case 2:
-		set_mal_dcrn(mal, DCRN_MALRCBS2, size);
-		break;
-#endif
-#ifdef DCRN_MALRCBS3
-	case 3:
-		set_mal_dcrn(mal, DCRN_MALRCBS3, size);
-		break;
-#endif
-	default:
+	struct ocp_func_mal_data *maldata = mal->def->additions;
+	BUG_ON(channel < 0 || channel >= maldata->num_rx_chans ||
+	       size > MAL_MAX_RX_SIZE);
+
+	MAL_DBG("%d: set_rbcs(%d, %lu)" NL, mal->def->index, channel, size);
+
+	if (size & 0xf) {
+		printk(KERN_WARNING
+		       "mal%d: incorrect RX size %lu for the channel %d\n",
+		       mal->def->index, size, channel);
 		return -EINVAL;
 	}
 
+	set_mal_dcrn(mal, MAL_RCBS(channel), size >> 4);
 	return 0;
 }
 
-static irqreturn_t mal_serr(int irq, void *dev_instance, struct pt_regs *regs)
+int mal_tx_bd_offset(struct ibm_ocp_mal *mal, int channel)
 {
-	struct ibm_ocp_mal *mal = dev_instance;
-	unsigned long mal_error;
+	struct ocp_func_mal_data *maldata = mal->def->additions;
+	BUG_ON(channel < 0 || channel >= maldata->num_tx_chans);
+	return channel * NUM_TX_BUFF;
+}
 
-	/*
-	 * This SERR applies to one of the devices on the MAL, here we charge
-	 * it against the first EMAC registered for the MAL.
-	 */
+int mal_rx_bd_offset(struct ibm_ocp_mal *mal, int channel)
+{
+	struct ocp_func_mal_data *maldata = mal->def->additions;
+	BUG_ON(channel < 0 || channel >= maldata->num_rx_chans);
+	return maldata->num_tx_chans * NUM_TX_BUFF + channel * NUM_RX_BUFF;
+}
 
-	mal_error = get_mal_dcrn(mal, DCRN_MALESR);
+void mal_enable_tx_channel(struct ibm_ocp_mal *mal, int channel)
+{
+	local_bh_disable();
+	MAL_DBG("%d: enable_tx(%d)" NL, mal->def->index, channel);
+	set_mal_dcrn(mal, MAL_TXCASR,
+		     get_mal_dcrn(mal, MAL_TXCASR) | MAL_CHAN_MASK(channel));
+	local_bh_enable();
+}
 
-	printk(KERN_ERR "%s: System Error (MALESR=%lx)\n",
-	       "MAL" /* FIXME: get the name right */ , mal_error);
+void mal_disable_tx_channel(struct ibm_ocp_mal *mal, int channel)
+{
+	set_mal_dcrn(mal, MAL_TXCARR, MAL_CHAN_MASK(channel));
+	MAL_DBG("%d: disable_tx(%d)" NL, mal->def->index, channel);
+}
 
-	/* FIXME: decipher error */
-	/* DIXME: distribute to commacs, if possible */
+void mal_enable_rx_channel(struct ibm_ocp_mal *mal, int channel)
+{
+	local_bh_disable();
+	MAL_DBG("%d: enable_rx(%d)" NL, mal->def->index, channel);
+	set_mal_dcrn(mal, MAL_RXCASR,
+		     get_mal_dcrn(mal, MAL_RXCASR) | MAL_CHAN_MASK(channel));
+	local_bh_enable();
+}
 
-	/* Clear the error status register */
-	set_mal_dcrn(mal, DCRN_MALESR, mal_error);
+void mal_disable_rx_channel(struct ibm_ocp_mal *mal, int channel)
+{
+	set_mal_dcrn(mal, MAL_RXCARR, MAL_CHAN_MASK(channel));
+	MAL_DBG("%d: disable_rx(%d)" NL, mal->def->index, channel);
+}
 
-	return IRQ_HANDLED;
+void mal_poll_add(struct ibm_ocp_mal *mal, struct mal_commac *commac)
+{
+	local_bh_disable();
+	MAL_DBG("%d: poll_add(%p)" NL, mal->def->index, commac);
+	list_add_tail(&commac->poll_list, &mal->poll_list);
+	local_bh_enable();
 }
 
-static irqreturn_t mal_txeob(int irq, void *dev_instance, struct pt_regs *regs)
+void mal_poll_del(struct ibm_ocp_mal *mal, struct mal_commac *commac)
+{
+	local_bh_disable();
+	MAL_DBG("%d: poll_del(%p)" NL, mal->def->index, commac);
+	list_del(&commac->poll_list);
+	local_bh_enable();
+}
+
+/* synchronized by mal_poll() */
+static inline void mal_enable_eob_irq(struct ibm_ocp_mal *mal)
+{
+	MAL_DBG2("%d: enable_irq" NL, mal->def->index);
+	set_mal_dcrn(mal, MAL_CFG, get_mal_dcrn(mal, MAL_CFG) | MAL_CFG_EOPIE);
+}
+
+/* synchronized by __LINK_STATE_RX_SCHED bit in ndev->state */
+static inline void mal_disable_eob_irq(struct ibm_ocp_mal *mal)
+{
+	set_mal_dcrn(mal, MAL_CFG, get_mal_dcrn(mal, MAL_CFG) & ~MAL_CFG_EOPIE);
+	MAL_DBG2("%d: disable_irq" NL, mal->def->index);
+}
+
+static irqreturn_t mal_serr(int irq, void *dev_instance, struct pt_regs *regs)
 {
 	struct ibm_ocp_mal *mal = dev_instance;
-	struct list_head *l;
-	unsigned long isr;
+	u32 esr = get_mal_dcrn(mal, MAL_ESR);
 
-	isr = get_mal_dcrn(mal, DCRN_MALTXEOBISR);
-	set_mal_dcrn(mal, DCRN_MALTXEOBISR, isr);
+	/* Clear the error status register */
+	set_mal_dcrn(mal, MAL_ESR, esr);
 
-	read_lock(&mal_list_lock);
-	list_for_each(l, &mal->commac) {
-		struct mal_commac *mc = list_entry(l, struct mal_commac, list);
+	MAL_DBG("%d: SERR %08x" NL, mal->def->index, esr);
+
+	if (esr & MAL_ESR_EVB) {
+		if (esr & MAL_ESR_DE) {
+			/* We ignore Descriptor error,
+			 * TXDE or RXDE interrupt will be generated anyway.
+			 */
+			return IRQ_HANDLED;
+		}
 
-		if (isr & mc->tx_chan_mask) {
-			mc->ops->txeob(mc->dev, isr & mc->tx_chan_mask);
+		if (esr & MAL_ESR_PEIN) {
+			/* PLB error, it's probably buggy hardware or
+			 * incorrect physical address in BD (i.e. bug)
+			 */
+			if (net_ratelimit())
+				printk(KERN_ERR
+				       "mal%d: system error, PLB (ESR = 0x%08x)\n",
+				       mal->def->index, esr);
+			return IRQ_HANDLED;
 		}
+
+		/* OPB error, it's probably buggy hardware or incorrect EBC setup */
+		if (net_ratelimit())
+			printk(KERN_ERR
+			       "mal%d: system error, OPB (ESR = 0x%08x)\n",
+			       mal->def->index, esr);
 	}
-	read_unlock(&mal_list_lock);
+	return IRQ_HANDLED;
+}
+
+static inline void mal_schedule_poll(struct ibm_ocp_mal *mal)
+{
+	if (likely(netif_rx_schedule_prep(&mal->poll_dev))) {
+		MAL_DBG2("%d: schedule_poll" NL, mal->def->index);
+		mal_disable_eob_irq(mal);
+		__netif_rx_schedule(&mal->poll_dev);
+	} else
+		MAL_DBG2("%d: already in poll" NL, mal->def->index);
+}
 
+static irqreturn_t mal_txeob(int irq, void *dev_instance, struct pt_regs *regs)
+{
+	struct ibm_ocp_mal *mal = dev_instance;
+	u32 r = get_mal_dcrn(mal, MAL_TXEOBISR);
+	MAL_DBG2("%d: txeob %08x" NL, mal->def->index, r);
+	mal_schedule_poll(mal);
+	set_mal_dcrn(mal, MAL_TXEOBISR, r);
 	return IRQ_HANDLED;
 }
 
 static irqreturn_t mal_rxeob(int irq, void *dev_instance, struct pt_regs *regs)
 {
 	struct ibm_ocp_mal *mal = dev_instance;
-	struct list_head *l;
-	unsigned long isr;
+	u32 r = get_mal_dcrn(mal, MAL_RXEOBISR);
+	MAL_DBG2("%d: rxeob %08x" NL, mal->def->index, r);
+	mal_schedule_poll(mal);
+	set_mal_dcrn(mal, MAL_RXEOBISR, r);
+	return IRQ_HANDLED;
+}
 
-	isr = get_mal_dcrn(mal, DCRN_MALRXEOBISR);
-	set_mal_dcrn(mal, DCRN_MALRXEOBISR, isr);
+static irqreturn_t mal_txde(int irq, void *dev_instance, struct pt_regs *regs)
+{
+	struct ibm_ocp_mal *mal = dev_instance;
+	u32 deir = get_mal_dcrn(mal, MAL_TXDEIR);
+	set_mal_dcrn(mal, MAL_TXDEIR, deir);
 
-	read_lock(&mal_list_lock);
-	list_for_each(l, &mal->commac) {
-		struct mal_commac *mc = list_entry(l, struct mal_commac, list);
+	MAL_DBG("%d: txde %08x" NL, mal->def->index, deir);
 
-		if (isr & mc->rx_chan_mask) {
-			mc->ops->rxeob(mc->dev, isr & mc->rx_chan_mask);
-		}
-	}
-	read_unlock(&mal_list_lock);
+	if (net_ratelimit())
+		printk(KERN_ERR
+		       "mal%d: TX descriptor error (TXDEIR = 0x%08x)\n",
+		       mal->def->index, deir);
 
 	return IRQ_HANDLED;
 }
 
-static irqreturn_t mal_txde(int irq, void *dev_instance, struct pt_regs *regs)
+static irqreturn_t mal_rxde(int irq, void *dev_instance, struct pt_regs *regs)
 {
 	struct ibm_ocp_mal *mal = dev_instance;
 	struct list_head *l;
-	unsigned long deir;
-
-	deir = get_mal_dcrn(mal, DCRN_MALTXDEIR);
+	u32 deir = get_mal_dcrn(mal, MAL_RXDEIR);
 
-	/* FIXME: print which MAL correctly */
-	printk(KERN_WARNING "%s: Tx descriptor error (MALTXDEIR=%lx)\n",
-	       "MAL", deir);
+	MAL_DBG("%d: rxde %08x" NL, mal->def->index, deir);
 
-	read_lock(&mal_list_lock);
-	list_for_each(l, &mal->commac) {
+	list_for_each(l, &mal->list) {
 		struct mal_commac *mc = list_entry(l, struct mal_commac, list);
-
-		if (deir & mc->tx_chan_mask) {
-			mc->ops->txde(mc->dev, deir & mc->tx_chan_mask);
+		if (deir & mc->rx_chan_mask) {
+			mc->rx_stopped = 1;
+			mc->ops->rxde(mc->dev);
 		}
 	}
-	read_unlock(&mal_list_lock);
+
+	mal_schedule_poll(mal);
+	set_mal_dcrn(mal, MAL_RXDEIR, deir);
 
 	return IRQ_HANDLED;
 }
 
-/*
- * This interrupt should be very rare at best.  This occurs when
- * the hardware has a problem with the receive descriptors.  The manual
- * states that it occurs when the hardware cannot the receive descriptor
- * empty bit is not set.  The recovery mechanism will be to
- * traverse through the descriptors, handle any that are marked to be
- * handled and reinitialize each along the way.  At that point the driver
- * will be restarted.
- */
-static irqreturn_t mal_rxde(int irq, void *dev_instance, struct pt_regs *regs)
+static int mal_poll(struct net_device *ndev, int *budget)
 {
-	struct ibm_ocp_mal *mal = dev_instance;
+	struct ibm_ocp_mal *mal = ndev->priv;
 	struct list_head *l;
-	unsigned long deir;
+	int rx_work_limit = min(ndev->quota, *budget), received = 0, done;
 
-	deir = get_mal_dcrn(mal, DCRN_MALRXDEIR);
+	MAL_DBG2("%d: poll(%d) %d ->" NL, mal->def->index, *budget,
+		 rx_work_limit);
+      again:
+	/* Process TX skbs */
+	list_for_each(l, &mal->poll_list) {
+		struct mal_commac *mc =
+		    list_entry(l, struct mal_commac, poll_list);
+		mc->ops->poll_tx(mc->dev);
+	}
 
-	/*
-	 * This really is needed.  This case encountered in stress testing.
+	/* Process RX skbs.
+	 * We _might_ need something more smart here to enforce polling fairness.
 	 */
-	if (deir == 0)
-		return IRQ_HANDLED;
-
-	/* FIXME: print which MAL correctly */
-	printk(KERN_WARNING "%s: Rx descriptor error (MALRXDEIR=%lx)\n",
-	       "MAL", deir);
-
-	read_lock(&mal_list_lock);
-	list_for_each(l, &mal->commac) {
-		struct mal_commac *mc = list_entry(l, struct mal_commac, list);
+	list_for_each(l, &mal->poll_list) {
+		struct mal_commac *mc =
+		    list_entry(l, struct mal_commac, poll_list);
+		int n = mc->ops->poll_rx(mc->dev, rx_work_limit);
+		if (n) {
+			received += n;
+			rx_work_limit -= n;
+			if (rx_work_limit <= 0) {
+				done = 0;
+				goto more_work;	// XXX What if this is the last one ?
+			}
+		}
+	}
 
-		if (deir & mc->rx_chan_mask) {
-			mc->ops->rxde(mc->dev, deir & mc->rx_chan_mask);
+	/* We need to disable IRQs to protect from RXDE IRQ here */
+	local_irq_disable();
+	__netif_rx_complete(ndev);
+	mal_enable_eob_irq(mal);
+	local_irq_enable();
+
+	done = 1;
+
+	/* Check for "rotting" packet(s) */
+	list_for_each(l, &mal->poll_list) {
+		struct mal_commac *mc =
+		    list_entry(l, struct mal_commac, poll_list);
+		if (unlikely(mc->ops->peek_rx(mc->dev) || mc->rx_stopped)) {
+			MAL_DBG2("%d: rotting packet" NL, mal->def->index);
+			if (netif_rx_reschedule(ndev, received))
+				mal_disable_eob_irq(mal);
+			else
+				MAL_DBG2("%d: already in poll list" NL,
+					 mal->def->index);
+
+			if (rx_work_limit > 0)
+				goto again;
+			else
+				goto more_work;
 		}
+		mc->ops->poll_tx(mc->dev);
 	}
-	read_unlock(&mal_list_lock);
 
-	return IRQ_HANDLED;
+      more_work:
+	ndev->quota -= received;
+	*budget -= received;
+
+	MAL_DBG2("%d: poll() %d <- %d" NL, mal->def->index, *budget,
+		 done ? 0 : 1);
+	return done ? 0 : 1;
+}
+
+static void mal_reset(struct ibm_ocp_mal *mal)
+{
+	int n = 10;
+	MAL_DBG("%d: reset" NL, mal->def->index);
+
+	set_mal_dcrn(mal, MAL_CFG, MAL_CFG_SR);
+
+	/* Wait for reset to complete (1 system clock) */
+	while ((get_mal_dcrn(mal, MAL_CFG) & MAL_CFG_SR) && n)
+		--n;
+
+	if (unlikely(!n))
+		printk(KERN_ERR "mal%d: reset timeout\n", mal->def->index);
+}
+
+int mal_get_regs_len(struct ibm_ocp_mal *mal)
+{
+	return sizeof(struct emac_ethtool_regs_subhdr) +
+	    sizeof(struct ibm_mal_regs);
+}
+
+void *mal_dump_regs(struct ibm_ocp_mal *mal, void *buf)
+{
+	struct emac_ethtool_regs_subhdr *hdr = buf;
+	struct ibm_mal_regs *regs = (struct ibm_mal_regs *)(hdr + 1);
+	struct ocp_func_mal_data *maldata = mal->def->additions;
+	int i;
+
+	hdr->version = MAL_VERSION;
+	hdr->index = mal->def->index;
+
+	regs->tx_count = maldata->num_tx_chans;
+	regs->rx_count = maldata->num_rx_chans;
+
+	regs->cfg = get_mal_dcrn(mal, MAL_CFG);
+	regs->esr = get_mal_dcrn(mal, MAL_ESR);
+	regs->ier = get_mal_dcrn(mal, MAL_IER);
+	regs->tx_casr = get_mal_dcrn(mal, MAL_TXCASR);
+	regs->tx_carr = get_mal_dcrn(mal, MAL_TXCARR);
+	regs->tx_eobisr = get_mal_dcrn(mal, MAL_TXEOBISR);
+	regs->tx_deir = get_mal_dcrn(mal, MAL_TXDEIR);
+	regs->rx_casr = get_mal_dcrn(mal, MAL_RXCASR);
+	regs->rx_carr = get_mal_dcrn(mal, MAL_RXCARR);
+	regs->rx_eobisr = get_mal_dcrn(mal, MAL_RXEOBISR);
+	regs->rx_deir = get_mal_dcrn(mal, MAL_RXDEIR);
+
+	for (i = 0; i < regs->tx_count; ++i)
+		regs->tx_ctpr[i] = get_mal_dcrn(mal, MAL_TXCTPR(i));
+
+	for (i = 0; i < regs->rx_count; ++i) {
+		regs->rx_ctpr[i] = get_mal_dcrn(mal, MAL_RXCTPR(i));
+		regs->rcbs[i] = get_mal_dcrn(mal, MAL_RCBS(i));
+	}
+	return regs + 1;
 }
 
 static int __init mal_probe(struct ocp_device *ocpdev)
 {
-	struct ibm_ocp_mal *mal = NULL;
+	struct ibm_ocp_mal *mal;
 	struct ocp_func_mal_data *maldata;
-	int err = 0;
+	int err = 0, i, bd_size;
 
-	maldata = (struct ocp_func_mal_data *)ocpdev->def->additions;
+	MAL_DBG("%d: probe" NL, ocpdev->def->index);
+
+	maldata = ocpdev->def->additions;
 	if (maldata == NULL) {
-		printk(KERN_ERR "mal%d: Missing additional datas !\n",
+		printk(KERN_ERR "mal%d: missing additional data!\n",
 		       ocpdev->def->index);
 		return -ENODEV;
 	}
 
-	mal = kmalloc(sizeof(struct ibm_ocp_mal), GFP_KERNEL);
-	if (mal == NULL) {
+	mal = kzalloc(sizeof(struct ibm_ocp_mal), GFP_KERNEL);
+	if (!mal) {
 		printk(KERN_ERR
-		       "mal%d: Out of memory allocating MAL structure !\n",
+		       "mal%d: out of memory allocating MAL structure!\n",
 		       ocpdev->def->index);
 		return -ENOMEM;
 	}
-	memset(mal, 0, sizeof(*mal));
-
-	switch (ocpdev->def->index) {
-	case 0:
-		mal->dcrbase = DCRN_MAL_BASE;
-		break;
-#ifdef DCRN_MAL1_BASE
-	case 1:
-		mal->dcrbase = DCRN_MAL1_BASE;
-		break;
-#endif
-	default:
-		BUG();
-	}
-
-	/**************************/
+	mal->dcrbase = maldata->dcr_base;
+	mal->def = ocpdev->def;
 
-	INIT_LIST_HEAD(&mal->commac);
+	INIT_LIST_HEAD(&mal->poll_list);
+	set_bit(__LINK_STATE_START, &mal->poll_dev.state);
+	mal->poll_dev.weight = CONFIG_IBM_EMAC_POLL_WEIGHT;
+	mal->poll_dev.poll = mal_poll;
+	mal->poll_dev.priv = mal;
+	atomic_set(&mal->poll_dev.refcnt, 1);
 
-	set_mal_dcrn(mal, DCRN_MALRXCARR, 0xFFFFFFFF);
-	set_mal_dcrn(mal, DCRN_MALTXCARR, 0xFFFFFFFF);
+	INIT_LIST_HEAD(&mal->list);
 
-	set_mal_dcrn(mal, DCRN_MALCR, MALCR_MMSR);	/* 384 */
-	/* FIXME: Add delay */
+	/* Load power-on reset defaults */
+	mal_reset(mal);
 
 	/* Set the MAL configuration register */
-	set_mal_dcrn(mal, DCRN_MALCR,
-		     MALCR_PLBB | MALCR_OPBBL | MALCR_LEA |
-		     MALCR_PLBLT_DEFAULT);
-
-	/* It would be nice to allocate buffers separately for each
-	 * channel, but we can't because the channels share the upper
-	 * 13 bits of address lines.  Each channels buffer must also
-	 * be 4k aligned, so we allocate 4k for each channel.  This is
-	 * inefficient FIXME: do better, if possible */
-	mal->tx_virt_addr = dma_alloc_coherent(&ocpdev->dev,
-					       MAL_DT_ALIGN *
-					       maldata->num_tx_chans,
-					       &mal->tx_phys_addr, GFP_KERNEL);
-	if (mal->tx_virt_addr == NULL) {
+	set_mal_dcrn(mal, MAL_CFG, MAL_CFG_DEFAULT | MAL_CFG_PLBB |
+		     MAL_CFG_OPBBL | MAL_CFG_LEA);
+
+	mal_enable_eob_irq(mal);
+
+	/* Allocate space for BD rings */
+	BUG_ON(maldata->num_tx_chans <= 0 || maldata->num_tx_chans > 32);
+	BUG_ON(maldata->num_rx_chans <= 0 || maldata->num_rx_chans > 32);
+	bd_size = sizeof(struct mal_descriptor) *
+	    (NUM_TX_BUFF * maldata->num_tx_chans +
+	     NUM_RX_BUFF * maldata->num_rx_chans);
+	mal->bd_virt =
+	    dma_alloc_coherent(&ocpdev->dev, bd_size, &mal->bd_dma, GFP_KERNEL);
+
+	if (!mal->bd_virt) {
 		printk(KERN_ERR
-		       "mal%d: Out of memory allocating MAL descriptors !\n",
-		       ocpdev->def->index);
+		       "mal%d: out of memory allocating RX/TX descriptors!\n",
+		       mal->def->index);
 		err = -ENOMEM;
 		goto fail;
 	}
+	memset(mal->bd_virt, 0, bd_size);
 
-	/* God, oh, god, I hate DCRs */
-	set_mal_dcrn(mal, DCRN_MALTXCTP0R, mal->tx_phys_addr);
-#ifdef DCRN_MALTXCTP1R
-	if (maldata->num_tx_chans > 1)
-		set_mal_dcrn(mal, DCRN_MALTXCTP1R,
-			     mal->tx_phys_addr + MAL_DT_ALIGN);
-#endif				/* DCRN_MALTXCTP1R */
-#ifdef DCRN_MALTXCTP2R
-	if (maldata->num_tx_chans > 2)
-		set_mal_dcrn(mal, DCRN_MALTXCTP2R,
-			     mal->tx_phys_addr + 2 * MAL_DT_ALIGN);
-#endif				/* DCRN_MALTXCTP2R */
-#ifdef DCRN_MALTXCTP3R
-	if (maldata->num_tx_chans > 3)
-		set_mal_dcrn(mal, DCRN_MALTXCTP3R,
-			     mal->tx_phys_addr + 3 * MAL_DT_ALIGN);
-#endif				/* DCRN_MALTXCTP3R */
-#ifdef DCRN_MALTXCTP4R
-	if (maldata->num_tx_chans > 4)
-		set_mal_dcrn(mal, DCRN_MALTXCTP4R,
-			     mal->tx_phys_addr + 4 * MAL_DT_ALIGN);
-#endif				/* DCRN_MALTXCTP4R */
-#ifdef DCRN_MALTXCTP5R
-	if (maldata->num_tx_chans > 5)
-		set_mal_dcrn(mal, DCRN_MALTXCTP5R,
-			     mal->tx_phys_addr + 5 * MAL_DT_ALIGN);
-#endif				/* DCRN_MALTXCTP5R */
-#ifdef DCRN_MALTXCTP6R
-	if (maldata->num_tx_chans > 6)
-		set_mal_dcrn(mal, DCRN_MALTXCTP6R,
-			     mal->tx_phys_addr + 6 * MAL_DT_ALIGN);
-#endif				/* DCRN_MALTXCTP6R */
-#ifdef DCRN_MALTXCTP7R
-	if (maldata->num_tx_chans > 7)
-		set_mal_dcrn(mal, DCRN_MALTXCTP7R,
-			     mal->tx_phys_addr + 7 * MAL_DT_ALIGN);
-#endif				/* DCRN_MALTXCTP7R */
-
-	mal->rx_virt_addr = dma_alloc_coherent(&ocpdev->dev,
-					       MAL_DT_ALIGN *
-					       maldata->num_rx_chans,
-					       &mal->rx_phys_addr, GFP_KERNEL);
-
-	set_mal_dcrn(mal, DCRN_MALRXCTP0R, mal->rx_phys_addr);
-#ifdef DCRN_MALRXCTP1R
-	if (maldata->num_rx_chans > 1)
-		set_mal_dcrn(mal, DCRN_MALRXCTP1R,
-			     mal->rx_phys_addr + MAL_DT_ALIGN);
-#endif				/* DCRN_MALRXCTP1R */
-#ifdef DCRN_MALRXCTP2R
-	if (maldata->num_rx_chans > 2)
-		set_mal_dcrn(mal, DCRN_MALRXCTP2R,
-			     mal->rx_phys_addr + 2 * MAL_DT_ALIGN);
-#endif				/* DCRN_MALRXCTP2R */
-#ifdef DCRN_MALRXCTP3R
-	if (maldata->num_rx_chans > 3)
-		set_mal_dcrn(mal, DCRN_MALRXCTP3R,
-			     mal->rx_phys_addr + 3 * MAL_DT_ALIGN);
-#endif				/* DCRN_MALRXCTP3R */
+	for (i = 0; i < maldata->num_tx_chans; ++i)
+		set_mal_dcrn(mal, MAL_TXCTPR(i), mal->bd_dma +
+			     sizeof(struct mal_descriptor) *
+			     mal_tx_bd_offset(mal, i));
+
+	for (i = 0; i < maldata->num_rx_chans; ++i)
+		set_mal_dcrn(mal, MAL_RXCTPR(i), mal->bd_dma +
+			     sizeof(struct mal_descriptor) *
+			     mal_rx_bd_offset(mal, i));
 
 	err = request_irq(maldata->serr_irq, mal_serr, 0, "MAL SERR", mal);
 	if (err)
-		goto fail;
-	err = request_irq(maldata->txde_irq, mal_txde, 0, "MAL TX DE ", mal);
+		goto fail2;
+	err = request_irq(maldata->txde_irq, mal_txde, 0, "MAL TX DE", mal);
 	if (err)
-		goto fail;
+		goto fail3;
 	err = request_irq(maldata->txeob_irq, mal_txeob, 0, "MAL TX EOB", mal);
 	if (err)
-		goto fail;
+		goto fail4;
 	err = request_irq(maldata->rxde_irq, mal_rxde, 0, "MAL RX DE", mal);
 	if (err)
-		goto fail;
+		goto fail5;
 	err = request_irq(maldata->rxeob_irq, mal_rxeob, 0, "MAL RX EOB", mal);
 	if (err)
-		goto fail;
+		goto fail6;
 
-	set_mal_dcrn(mal, DCRN_MALIER,
-		     MALIER_DE | MALIER_NE | MALIER_TE |
-		     MALIER_OPBE | MALIER_PLBE);
+	/* Enable all MAL SERR interrupt sources */
+	set_mal_dcrn(mal, MAL_IER, MAL_IER_EVENTS);
 
-	/* Advertise me to the rest of the world */
+	/* Advertise this instance to the rest of the world */
 	ocp_set_drvdata(ocpdev, mal);
 
-	printk(KERN_INFO "mal%d: Initialized, %d tx channels, %d rx channels\n",
-	       ocpdev->def->index, maldata->num_tx_chans,
-	       maldata->num_rx_chans);
+	mal_dbg_register(mal->def->index, mal);
 
+	printk(KERN_INFO "mal%d: initialized, %d TX channels, %d RX channels\n",
+	       mal->def->index, maldata->num_tx_chans, maldata->num_rx_chans);
 	return 0;
 
+      fail6:
+	free_irq(maldata->rxde_irq, mal);
+      fail5:
+	free_irq(maldata->txeob_irq, mal);
+      fail4:
+	free_irq(maldata->txde_irq, mal);
+      fail3:
+	free_irq(maldata->serr_irq, mal);
+      fail2:
+	dma_free_coherent(&ocpdev->dev, bd_size, mal->bd_virt, mal->bd_dma);
       fail:
-	/* FIXME: dispose requested IRQs ! */
-	if (err && mal)
-		kfree(mal);
+	kfree(mal);
 	return err;
 }
 
 static void __exit mal_remove(struct ocp_device *ocpdev)
 {
 	struct ibm_ocp_mal *mal = ocp_get_drvdata(ocpdev);
-	struct ocp_func_mal_data *maldata = ocpdev->def->additions;
+	struct ocp_func_mal_data *maldata = mal->def->additions;
 
-	BUG_ON(!maldata);
+	MAL_DBG("%d: remove" NL, mal->def->index);
+
+	/* Syncronize with scheduled polling,
+	   stolen from net/core/dev.c:dev_close()
+	 */
+	clear_bit(__LINK_STATE_START, &mal->poll_dev.state);
+	netif_poll_disable(&mal->poll_dev);
+
+	if (!list_empty(&mal->list)) {
+		/* This is *very* bad */
+		printk(KERN_EMERG
+		       "mal%d: commac list is not empty on remove!\n",
+		       mal->def->index);
+	}
 
 	ocp_set_drvdata(ocpdev, NULL);
 
-	/* FIXME: shut down the MAL, deal with dependency with emac */
 	free_irq(maldata->serr_irq, mal);
 	free_irq(maldata->txde_irq, mal);
 	free_irq(maldata->txeob_irq, mal);
 	free_irq(maldata->rxde_irq, mal);
 	free_irq(maldata->rxeob_irq, mal);
 
-	if (mal->tx_virt_addr)
-		dma_free_coherent(&ocpdev->dev,
-				  MAL_DT_ALIGN * maldata->num_tx_chans,
-				  mal->tx_virt_addr, mal->tx_phys_addr);
-
-	if (mal->rx_virt_addr)
-		dma_free_coherent(&ocpdev->dev,
-				  MAL_DT_ALIGN * maldata->num_rx_chans,
-				  mal->rx_virt_addr, mal->rx_phys_addr);
+	mal_reset(mal);
+
+	mal_dbg_register(mal->def->index, NULL);
+
+	dma_free_coherent(&ocpdev->dev,
+			  sizeof(struct mal_descriptor) *
+			  (NUM_TX_BUFF * maldata->num_tx_chans +
+			   NUM_RX_BUFF * maldata->num_rx_chans), mal->bd_virt,
+			  mal->bd_dma);
 
 	kfree(mal);
 }
 
 /* Structure for a device driver */
 static struct ocp_device_id mal_ids[] = {
-	{.vendor = OCP_ANY_ID,.function = OCP_FUNC_MAL},
-	{.vendor = OCP_VENDOR_INVALID}
+	{ .vendor = OCP_VENDOR_IBM, .function = OCP_FUNC_MAL },
+	{ .vendor = OCP_VENDOR_INVALID}
 };
 
 static struct ocp_driver mal_driver = {
@@ -441,23 +570,14 @@ static struct ocp_driver mal_driver = {
 	.remove = mal_remove,
 };
 
-static int __init init_mals(void)
+int __init mal_init(void)
 {
-	int rc;
-
-	rc = ocp_register_driver(&mal_driver);
-	if (rc < 0) {
-		ocp_unregister_driver(&mal_driver);
-		return -ENODEV;
-	}
-
-	return 0;
+	MAL_DBG(": init" NL);
+	return ocp_register_driver(&mal_driver);
 }
 
-static void __exit exit_mals(void)
+void __exit mal_exit(void)
 {
+	MAL_DBG(": exit" NL);
 	ocp_unregister_driver(&mal_driver);
 }
-
-module_init(init_mals);
-module_exit(exit_mals);
diff -puN drivers/net/ibm_emac/ibm_emac_mal.h~new-powerpc-4xx-on-chip-ethernet-controller-driver drivers/net/ibm_emac/ibm_emac_mal.h
--- devel/drivers/net/ibm_emac/ibm_emac_mal.h~new-powerpc-4xx-on-chip-ethernet-controller-driver	2005-10-28 17:44:03.000000000 -0700
+++ devel-akpm/drivers/net/ibm_emac/ibm_emac_mal.h	2005-10-28 17:44:03.000000000 -0700
@@ -1,131 +1,267 @@
-#ifndef _IBM_EMAC_MAL_H
-#define _IBM_EMAC_MAL_H
+/*
+ * drivers/net/ibm_emac/ibm_emac_mal.h
+ *
+ * Memory Access Layer (MAL) support
+ *
+ * Copyright (c) 2004, 2005 Zultys Technologies.
+ * Eugene Surovegin <eugene.surovegin@zultys.com> or <ebs@ebshome.net>
+ *
+ * Based on original work by
+ *      Armin Kuster <akuster@mvista.com>
+ *      Copyright 2002 MontaVista Softare Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ */
+#ifndef __IBM_EMAC_MAL_H_
+#define __IBM_EMAC_MAL_H_
 
+#include <linux/config.h>
+#include <linux/init.h>
 #include <linux/list.h>
+#include <linux/netdevice.h>
 
-#define MAL_DT_ALIGN	(4096)	/* Alignment for each channel's descriptor table */
+#include <asm/io.h>
 
-#define MAL_CHAN_MASK(chan)	(0x80000000 >> (chan))
+/*
+ * These MAL "versions" probably aren't the real versions IBM uses for these
+ * MAL cores, I assigned them just to make #ifdefs in this file nicer and
+ * reflect the fact that 40x and 44x have slightly different MALs. --ebs
+ */
+#if defined(CONFIG_405GP) || defined(CONFIG_405GPR) || defined(CONFIG_405EP) || \
+    defined(CONFIG_440EP) || defined(CONFIG_NP405H)
+#define MAL_VERSION		1
+#elif defined(CONFIG_440GP) || defined(CONFIG_440GX) || defined(CONFIG_440SP)
+#define MAL_VERSION		2
+#else
+#error "Unknown SoC, please check chip manual and choose MAL 'version'"
+#endif
+
+/* MALx DCR registers */
+#define	MAL_CFG			0x00
+#define	  MAL_CFG_SR		0x80000000
+#define   MAL_CFG_PLBB		0x00004000
+#define   MAL_CFG_OPBBL		0x00000080
+#define   MAL_CFG_EOPIE		0x00000004
+#define   MAL_CFG_LEA		0x00000002
+#define   MAL_CFG_SD		0x00000001
+#if MAL_VERSION == 1
+#define   MAL_CFG_PLBP_MASK	0x00c00000
+#define   MAL_CFG_PLBP_10	0x00800000
+#define   MAL_CFG_GA		0x00200000
+#define   MAL_CFG_OA		0x00100000
+#define   MAL_CFG_PLBLE		0x00080000
+#define   MAL_CFG_PLBT_MASK	0x00078000
+#define   MAL_CFG_DEFAULT	(MAL_CFG_PLBP_10 | MAL_CFG_PLBT_MASK)
+#elif MAL_VERSION == 2
+#define   MAL_CFG_RPP_MASK	0x00c00000
+#define   MAL_CFG_RPP_10	0x00800000
+#define   MAL_CFG_RMBS_MASK	0x00300000
+#define   MAL_CFG_WPP_MASK	0x000c0000
+#define   MAL_CFG_WPP_10	0x00080000
+#define   MAL_CFG_WMBS_MASK	0x00030000
+#define   MAL_CFG_PLBLE		0x00008000
+#define   MAL_CFG_DEFAULT	(MAL_CFG_RMBS_MASK | MAL_CFG_WMBS_MASK | \
+				 MAL_CFG_RPP_10 | MAL_CFG_WPP_10)
+#else
+#error "Unknown MAL version"
+#endif
+
+#define MAL_ESR			0x01
+#define   MAL_ESR_EVB		0x80000000
+#define   MAL_ESR_CIDT		0x40000000
+#define   MAL_ESR_CID_MASK	0x3e000000
+#define   MAL_ESR_CID_SHIFT	25
+#define   MAL_ESR_DE		0x00100000
+#define   MAL_ESR_OTE		0x00040000
+#define   MAL_ESR_OSE		0x00020000
+#define   MAL_ESR_PEIN		0x00010000
+#define   MAL_ESR_DEI		0x00000010
+#define   MAL_ESR_OTEI		0x00000004
+#define   MAL_ESR_OSEI		0x00000002
+#define   MAL_ESR_PBEI		0x00000001
+#if MAL_VERSION == 1
+#define   MAL_ESR_ONE		0x00080000
+#define   MAL_ESR_ONEI		0x00000008
+#elif MAL_VERSION == 2
+#define   MAL_ESR_PTE		0x00800000
+#define   MAL_ESR_PRE		0x00400000
+#define   MAL_ESR_PWE		0x00200000
+#define   MAL_ESR_PTEI		0x00000080
+#define   MAL_ESR_PREI		0x00000040
+#define   MAL_ESR_PWEI		0x00000020
+#else
+#error "Unknown MAL version"
+#endif
+
+#define MAL_IER			0x02
+#define   MAL_IER_DE		0x00000010
+#define   MAL_IER_OTE		0x00000004
+#define   MAL_IER_OE		0x00000002
+#define   MAL_IER_PE		0x00000001
+#if MAL_VERSION == 1
+#define   MAL_IER_NWE		0x00000008
+#define   MAL_IER_SOC_EVENTS	MAL_IER_NWE
+#elif MAL_VERSION == 2
+#define   MAL_IER_PT		0x00000080
+#define   MAL_IER_PRE		0x00000040
+#define   MAL_IER_PWE		0x00000020
+#define   MAL_IER_SOC_EVENTS	(MAL_IER_PT | MAL_IER_PRE | MAL_IER_PWE)
+#else
+#error "Unknown MAL version"
+#endif
+#define   MAL_IER_EVENTS	(MAL_IER_SOC_EVENTS | MAL_IER_OTE | \
+				 MAL_IER_OTE | MAL_IER_OE | MAL_IER_PE)
+
+#define MAL_TXCASR		0x04
+#define MAL_TXCARR		0x05
+#define MAL_TXEOBISR		0x06
+#define MAL_TXDEIR		0x07
+#define MAL_RXCASR		0x10
+#define MAL_RXCARR		0x11
+#define MAL_RXEOBISR		0x12
+#define MAL_RXDEIR		0x13
+#define MAL_TXCTPR(n)		((n) + 0x20)
+#define MAL_RXCTPR(n)		((n) + 0x40)
+#define MAL_RCBS(n)		((n) + 0x60)
+
+/* In reality MAL can handle TX buffers up to 4095 bytes long,
+ * but this isn't a good round number :) 		 --ebs
+ */
+#define MAL_MAX_TX_SIZE		4080
+#define MAL_MAX_RX_SIZE		4080
+
+static inline int mal_rx_size(int len)
+{
+	len = (len + 0xf) & ~0xf;
+	return len > MAL_MAX_RX_SIZE ? MAL_MAX_RX_SIZE : len;
+}
+
+static inline int mal_tx_chunks(int len)
+{
+	return (len + MAL_MAX_TX_SIZE - 1) / MAL_MAX_TX_SIZE;
+}
+
+#define MAL_CHAN_MASK(n)	(0x80000000 >> (n))
 
 /* MAL Buffer Descriptor structure */
 struct mal_descriptor {
-	unsigned short ctrl;	/* MAL / Commac status control bits */
-	short data_len;		/* Max length is 4K-1 (12 bits)     */
-	unsigned char *data_ptr;	/* pointer to actual data buffer    */
-} __attribute__ ((packed));
+	u16 ctrl;		/* MAL / Commac status control bits */
+	u16 data_len;		/* Max length is 4K-1 (12 bits)     */
+	u32 data_ptr;		/* pointer to actual data buffer    */
+};
 
 /* the following defines are for the MadMAL status and control registers. */
 /* MADMAL transmit and receive status/control bits  */
-#define MAL_RX_CTRL_EMPTY		0x8000
-#define MAL_RX_CTRL_WRAP		0x4000
-#define MAL_RX_CTRL_CM			0x2000
-#define MAL_RX_CTRL_LAST		0x1000
-#define MAL_RX_CTRL_FIRST		0x0800
-#define MAL_RX_CTRL_INTR		0x0400
-
-#define MAL_TX_CTRL_READY		0x8000
-#define MAL_TX_CTRL_WRAP		0x4000
-#define MAL_TX_CTRL_CM			0x2000
-#define MAL_TX_CTRL_LAST		0x1000
-#define MAL_TX_CTRL_INTR		0x0400
+#define MAL_RX_CTRL_EMPTY	0x8000
+#define MAL_RX_CTRL_WRAP	0x4000
+#define MAL_RX_CTRL_CM		0x2000
+#define MAL_RX_CTRL_LAST	0x1000
+#define MAL_RX_CTRL_FIRST	0x0800
+#define MAL_RX_CTRL_INTR	0x0400
+#define MAL_RX_CTRL_SINGLE	(MAL_RX_CTRL_LAST | MAL_RX_CTRL_FIRST)
+#define MAL_IS_SINGLE_RX(ctrl)	(((ctrl) & MAL_RX_CTRL_SINGLE) == MAL_RX_CTRL_SINGLE)
+
+#define MAL_TX_CTRL_READY	0x8000
+#define MAL_TX_CTRL_WRAP	0x4000
+#define MAL_TX_CTRL_CM		0x2000
+#define MAL_TX_CTRL_LAST	0x1000
+#define MAL_TX_CTRL_INTR	0x0400
 
 struct mal_commac_ops {
-	void (*txeob) (void *dev, u32 chanmask);
-	void (*txde) (void *dev, u32 chanmask);
-	void (*rxeob) (void *dev, u32 chanmask);
-	void (*rxde) (void *dev, u32 chanmask);
+	void	(*poll_tx) (void *dev);
+	int	(*poll_rx) (void *dev, int budget);
+	int	(*peek_rx) (void *dev);
+	void	(*rxde) (void *dev);
 };
 
 struct mal_commac {
-	struct mal_commac_ops *ops;
-	void *dev;
-	u32 tx_chan_mask, rx_chan_mask;
-	struct list_head list;
+	struct mal_commac_ops	*ops;
+	void			*dev;
+	struct list_head	poll_list;
+	int			rx_stopped;
+
+	u32			tx_chan_mask;
+	u32			rx_chan_mask;
+	struct list_head	list;
 };
 
 struct ibm_ocp_mal {
-	int dcrbase;
+	int			dcrbase;
 
-	struct list_head commac;
-	u32 tx_chan_mask, rx_chan_mask;
+	struct list_head	poll_list;
+	struct net_device	poll_dev;
 
-	dma_addr_t tx_phys_addr;
-	struct mal_descriptor *tx_virt_addr;
+	struct list_head	list;
+	u32			tx_chan_mask;
+	u32			rx_chan_mask;
 
-	dma_addr_t rx_phys_addr;
-	struct mal_descriptor *rx_virt_addr;
-};
+	dma_addr_t		bd_dma;
+	struct mal_descriptor	*bd_virt;
 
-#define GET_MAL_STANZA(base,dcrn) \
-	case base: \
-		x = mfdcr(dcrn(base)); \
-		break;
-
-#define SET_MAL_STANZA(base,dcrn, val) \
-	case base: \
-		mtdcr(dcrn(base), (val)); \
-		break;
-
-#define GET_MAL0_STANZA(dcrn) GET_MAL_STANZA(DCRN_MAL_BASE,dcrn)
-#define SET_MAL0_STANZA(dcrn,val) SET_MAL_STANZA(DCRN_MAL_BASE,dcrn,val)
-
-#ifdef DCRN_MAL1_BASE
-#define GET_MAL1_STANZA(dcrn) GET_MAL_STANZA(DCRN_MAL1_BASE,dcrn)
-#define SET_MAL1_STANZA(dcrn,val) SET_MAL_STANZA(DCRN_MAL1_BASE,dcrn,val)
-#else				/* ! DCRN_MAL1_BASE */
-#define GET_MAL1_STANZA(dcrn)
-#define SET_MAL1_STANZA(dcrn,val)
-#endif
-
-#define get_mal_dcrn(mal, dcrn) ({ \
-	u32 x; \
-	switch ((mal)->dcrbase) { \
-		GET_MAL0_STANZA(dcrn) \
-		GET_MAL1_STANZA(dcrn) \
-	default: \
-		x = 0; \
-		BUG(); \
-	} \
-x; })
-
-#define set_mal_dcrn(mal, dcrn, val) do { \
-	switch ((mal)->dcrbase) { \
-		SET_MAL0_STANZA(dcrn,val) \
-		SET_MAL1_STANZA(dcrn,val) \
-	default: \
-		BUG(); \
-	} } while (0)
-
-static inline void mal_enable_tx_channels(struct ibm_ocp_mal *mal, u32 chanmask)
-{
-	set_mal_dcrn(mal, DCRN_MALTXCASR,
-		     get_mal_dcrn(mal, DCRN_MALTXCASR) | chanmask);
-}
-
-static inline void mal_disable_tx_channels(struct ibm_ocp_mal *mal,
-					   u32 chanmask)
-{
-	set_mal_dcrn(mal, DCRN_MALTXCARR, chanmask);
-}
+	struct ocp_def		*def;
+};
 
-static inline void mal_enable_rx_channels(struct ibm_ocp_mal *mal, u32 chanmask)
+static inline u32 get_mal_dcrn(struct ibm_ocp_mal *mal, int reg)
 {
-	set_mal_dcrn(mal, DCRN_MALRXCASR,
-		     get_mal_dcrn(mal, DCRN_MALRXCASR) | chanmask);
+	return mfdcr(mal->dcrbase + reg);
 }
 
-static inline void mal_disable_rx_channels(struct ibm_ocp_mal *mal,
-					   u32 chanmask)
+static inline void set_mal_dcrn(struct ibm_ocp_mal *mal, int reg, u32 val)
 {
-	set_mal_dcrn(mal, DCRN_MALRXCARR, chanmask);
+	mtdcr(mal->dcrbase + reg, val);
 }
 
-extern int mal_register_commac(struct ibm_ocp_mal *mal,
-			       struct mal_commac *commac);
-extern int mal_unregister_commac(struct ibm_ocp_mal *mal,
-				 struct mal_commac *commac);
+/* Register MAL devices */
+int mal_init(void) __init;
+void mal_exit(void) __exit;
+
+int mal_register_commac(struct ibm_ocp_mal *mal,
+			struct mal_commac *commac) __init;
+void mal_unregister_commac(struct ibm_ocp_mal *mal,
+			   struct mal_commac *commac) __exit;
+int mal_set_rcbs(struct ibm_ocp_mal *mal, int channel, unsigned long size);
+
+/* Returns BD ring offset for a particular channel
+   (in 'struct mal_descriptor' elements)
+*/
+int mal_tx_bd_offset(struct ibm_ocp_mal *mal, int channel);
+int mal_rx_bd_offset(struct ibm_ocp_mal *mal, int channel);
+
+void mal_enable_tx_channel(struct ibm_ocp_mal *mal, int channel);
+void mal_disable_tx_channel(struct ibm_ocp_mal *mal, int channel);
+void mal_enable_rx_channel(struct ibm_ocp_mal *mal, int channel);
+void mal_disable_rx_channel(struct ibm_ocp_mal *mal, int channel);
+
+/* Add/remove EMAC to/from MAL polling list */
+void mal_poll_add(struct ibm_ocp_mal *mal, struct mal_commac *commac);
+void mal_poll_del(struct ibm_ocp_mal *mal, struct mal_commac *commac);
+
+/* Ethtool MAL registers */
+struct ibm_mal_regs {
+	u32 tx_count;
+	u32 rx_count;
+
+	u32 cfg;
+	u32 esr;
+	u32 ier;
+	u32 tx_casr;
+	u32 tx_carr;
+	u32 tx_eobisr;
+	u32 tx_deir;
+	u32 rx_casr;
+	u32 rx_carr;
+	u32 rx_eobisr;
+	u32 rx_deir;
+	u32 tx_ctpr[32];
+	u32 rx_ctpr[32];
+	u32 rcbs[32];
+};
 
-extern int mal_set_rcbs(struct ibm_ocp_mal *mal, int channel,
-			unsigned long size);
+int mal_get_regs_len(struct ibm_ocp_mal *mal);
+void *mal_dump_regs(struct ibm_ocp_mal *mal, void *buf);
 
-#endif				/* _IBM_EMAC_MAL_H */
+#endif				/* __IBM_EMAC_MAL_H_ */
diff -puN drivers/net/ibm_emac/ibm_emac_phy.c~new-powerpc-4xx-on-chip-ethernet-controller-driver drivers/net/ibm_emac/ibm_emac_phy.c
--- devel/drivers/net/ibm_emac/ibm_emac_phy.c~new-powerpc-4xx-on-chip-ethernet-controller-driver	2005-10-28 17:44:03.000000000 -0700
+++ devel-akpm/drivers/net/ibm_emac/ibm_emac_phy.c	2005-10-28 17:44:03.000000000 -0700
@@ -1,96 +1,80 @@
 /*
- * ibm_ocp_phy.c
+ * drivers/net/ibm_emac/ibm_emac_phy.c
  *
- * PHY drivers for the ibm ocp ethernet driver. Borrowed
- * from sungem_phy.c, though I only kept the generic MII
+ * Driver for PowerPC 4xx on-chip ethernet controller, PHY support.
+ * Borrowed from sungem_phy.c, though I only kept the generic MII
  * driver for now.
  * 
  * This file should be shared with other drivers or eventually
  * merged as the "low level" part of miilib
  * 
  * (c) 2003, Benjamin Herrenscmidt (benh@kernel.crashing.org)
+ * (c) 2004-2005, Eugene Surovegin <ebs@ebshome.net>
  *
  */
-
 #include <linux/config.h>
-
 #include <linux/module.h>
-
 #include <linux/kernel.h>
-#include <linux/sched.h>
 #include <linux/types.h>
 #include <linux/netdevice.h>
-#include <linux/etherdevice.h>
 #include <linux/mii.h>
 #include <linux/ethtool.h>
 #include <linux/delay.h>
 
+#include <asm/ocp.h>
+
 #include "ibm_emac_phy.h"
 
-static int reset_one_mii_phy(struct mii_phy *phy, int phy_id)
+static inline int phy_read(struct mii_phy *phy, int reg)
+{
+	return phy->mdio_read(phy->dev, phy->address, reg);
+}
+
+static inline void phy_write(struct mii_phy *phy, int reg, int val)
 {
-	u16 val;
+	phy->mdio_write(phy->dev, phy->address, reg, val);
+}
+
+int mii_reset_phy(struct mii_phy *phy)
+{
+	int val;
 	int limit = 10000;
 
-	val = __phy_read(phy, phy_id, MII_BMCR);
+	val = phy_read(phy, MII_BMCR);
 	val &= ~BMCR_ISOLATE;
 	val |= BMCR_RESET;
-	__phy_write(phy, phy_id, MII_BMCR, val);
+	phy_write(phy, MII_BMCR, val);
 
-	udelay(100);
+	udelay(300);
 
 	while (limit--) {
-		val = __phy_read(phy, phy_id, MII_BMCR);
-		if ((val & BMCR_RESET) == 0)
+		val = phy_read(phy, MII_BMCR);
+		if (val >= 0 && (val & BMCR_RESET) == 0)
 			break;
 		udelay(10);
 	}
 	if ((val & BMCR_ISOLATE) && limit > 0)
-		__phy_write(phy, phy_id, MII_BMCR, val & ~BMCR_ISOLATE);
-
-	return (limit <= 0);
-}
-
-static int cis8201_init(struct mii_phy *phy)
-{
-	u16 epcr;
-
-	epcr = phy_read(phy, MII_CIS8201_EPCR);
-	epcr &= ~EPCR_MODE_MASK;
-
-	switch (phy->mode) {
-	case PHY_MODE_TBI:
-		epcr |= EPCR_TBI_MODE;
-		break;
-	case PHY_MODE_RTBI:
-		epcr |= EPCR_RTBI_MODE;
-		break;
-	case PHY_MODE_GMII:
-		epcr |= EPCR_GMII_MODE;
-		break;
-	case PHY_MODE_RGMII:
-	default:
-		epcr |= EPCR_RGMII_MODE;
-	}
+		phy_write(phy, MII_BMCR, val & ~BMCR_ISOLATE);
 
-	phy_write(phy, MII_CIS8201_EPCR, epcr);
-
-	return 0;
+	return limit <= 0;
 }
 
 static int genmii_setup_aneg(struct mii_phy *phy, u32 advertise)
 {
-	u16 ctl, adv;
+	int ctl, adv;
 
-	phy->autoneg = 1;
+	phy->autoneg = AUTONEG_ENABLE;
 	phy->speed = SPEED_10;
 	phy->duplex = DUPLEX_HALF;
-	phy->pause = 0;
+	phy->pause = phy->asym_pause = 0;
 	phy->advertising = advertise;
 
 	/* Setup standard advertise */
 	adv = phy_read(phy, MII_ADVERTISE);
-	adv &= ~(ADVERTISE_ALL | ADVERTISE_100BASE4);
+	if (adv < 0)
+		return adv;
+	adv &= ~(ADVERTISE_ALL | ADVERTISE_100BASE4 | ADVERTISE_PAUSE_CAP |
+		 ADVERTISE_PAUSE_ASYM);
 	if (advertise & ADVERTISED_10baseT_Half)
 		adv |= ADVERTISE_10HALF;
 	if (advertise & ADVERTISED_10baseT_Full)
@@ -99,8 +83,25 @@ static int genmii_setup_aneg(struct mii_
 		adv |= ADVERTISE_100HALF;
 	if (advertise & ADVERTISED_100baseT_Full)
 		adv |= ADVERTISE_100FULL;
+	if (advertise & ADVERTISED_Pause)
+		adv |= ADVERTISE_PAUSE_CAP;
+	if (advertise & ADVERTISED_Asym_Pause)
+		adv |= ADVERTISE_PAUSE_ASYM;
 	phy_write(phy, MII_ADVERTISE, adv);
 
+	if (phy->features &
+	    (SUPPORTED_1000baseT_Full | SUPPORTED_1000baseT_Half)) {
+		adv = phy_read(phy, MII_CTRL1000);
+		if (adv < 0)
+			return adv;
+		adv &= ~(ADVERTISE_1000FULL | ADVERTISE_1000HALF);
+		if (advertise & ADVERTISED_1000baseT_Full)
+			adv |= ADVERTISE_1000FULL;
+		if (advertise & ADVERTISED_1000baseT_Half)
+			adv |= ADVERTISE_1000HALF;
+		phy_write(phy, MII_CTRL1000, adv);
+	}
+
 	/* Start/Restart aneg */
 	ctl = phy_read(phy, MII_BMCR);
 	ctl |= (BMCR_ANENABLE | BMCR_ANRESTART);
@@ -111,14 +112,16 @@ static int genmii_setup_aneg(struct mii_
 
 static int genmii_setup_forced(struct mii_phy *phy, int speed, int fd)
 {
-	u16 ctl;
+	int ctl;
 
-	phy->autoneg = 0;
+	phy->autoneg = AUTONEG_DISABLE;
 	phy->speed = speed;
 	phy->duplex = fd;
-	phy->pause = 0;
+	phy->pause = phy->asym_pause = 0;
 
 	ctl = phy_read(phy, MII_BMCR);
+	if (ctl < 0)
+		return ctl;
 	ctl &= ~(BMCR_FULLDPLX | BMCR_SPEED100 | BMCR_ANENABLE);
 
 	/* First reset the PHY */
@@ -132,6 +135,8 @@ static int genmii_setup_forced(struct mi
 		ctl |= BMCR_SPEED100;
 		break;
 	case SPEED_1000:
+		ctl |= BMCR_SPEED1000;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -144,112 +149,143 @@ static int genmii_setup_forced(struct mi
 
 static int genmii_poll_link(struct mii_phy *phy)
 {
-	u16 status;
+	int status;
 
-	(void)phy_read(phy, MII_BMSR);
+	/* Clear latched value with dummy read */
+	phy_read(phy, MII_BMSR);
 	status = phy_read(phy, MII_BMSR);
-	if ((status & BMSR_LSTATUS) == 0)
+	if (status < 0 || (status & BMSR_LSTATUS) == 0)
 		return 0;
-	if (phy->autoneg && !(status & BMSR_ANEGCOMPLETE))
+	if (phy->autoneg == AUTONEG_ENABLE && !(status & BMSR_ANEGCOMPLETE))
 		return 0;
 	return 1;
 }
 
-#define	MII_CIS8201_ACSR	0x1c
-#define  ACSR_DUPLEX_STATUS	0x0020
-#define  ACSR_SPEED_1000BASET	0x0010
-#define  ACSR_SPEED_100BASET	0x0008
-
-static int cis8201_read_link(struct mii_phy *phy)
+static int genmii_read_link(struct mii_phy *phy)
 {
-	u16 acsr;
+	if (phy->autoneg == AUTONEG_ENABLE) {
+		int glpa = 0;
+		int lpa = phy_read(phy, MII_LPA) & phy_read(phy, MII_ADVERTISE);
+		if (lpa < 0)
+			return lpa;
+
+		if (phy->features &
+		    (SUPPORTED_1000baseT_Full | SUPPORTED_1000baseT_Half)) {
+			int adv = phy_read(phy, MII_CTRL1000);
+			glpa = phy_read(phy, MII_STAT1000);
 
-	if (phy->autoneg) {
-		acsr = phy_read(phy, MII_CIS8201_ACSR);
+			if (glpa < 0 || adv < 0)
+				return adv;
 
-		if (acsr & ACSR_DUPLEX_STATUS)
+			glpa &= adv << 2;
+		}
+
+		phy->speed = SPEED_10;
+		phy->duplex = DUPLEX_HALF;
+		phy->pause = phy->asym_pause = 0;
+
+		if (glpa & (LPA_1000FULL | LPA_1000HALF)) {
+			phy->speed = SPEED_1000;
+			if (glpa & LPA_1000FULL)
+				phy->duplex = DUPLEX_FULL;
+		} else if (lpa & (LPA_100FULL | LPA_100HALF)) {
+			phy->speed = SPEED_100;
+			if (lpa & LPA_100FULL)
+				phy->duplex = DUPLEX_FULL;
+		} else if (lpa & LPA_10FULL)
+			phy->duplex = DUPLEX_FULL;
+
+		if (phy->duplex == DUPLEX_FULL) {
+			phy->pause = lpa & LPA_PAUSE_CAP ? 1 : 0;
+			phy->asym_pause = lpa & LPA_PAUSE_ASYM ? 1 : 0;
+		}
+	} else {
+		int bmcr = phy_read(phy, MII_BMCR);
+		if (bmcr < 0)
+			return bmcr;
+
+		if (bmcr & BMCR_FULLDPLX)
 			phy->duplex = DUPLEX_FULL;
 		else
 			phy->duplex = DUPLEX_HALF;
-		if (acsr & ACSR_SPEED_1000BASET) {
+		if (bmcr & BMCR_SPEED1000)
 			phy->speed = SPEED_1000;
-		} else if (acsr & ACSR_SPEED_100BASET)
+		else if (bmcr & BMCR_SPEED100)
 			phy->speed = SPEED_100;
 		else
 			phy->speed = SPEED_10;
-		phy->pause = 0;
-	}
-	/* On non-aneg, we assume what we put in BMCR is the speed,
-	 * though magic-aneg shouldn't prevent this case from occurring
-	 */
 
+		phy->pause = phy->asym_pause = 0;
+	}
 	return 0;
 }
 
-static int genmii_read_link(struct mii_phy *phy)
+/* Generic implementation for most 10/100/1000 PHYs */
+static struct mii_phy_ops generic_phy_ops = {
+	.setup_aneg	= genmii_setup_aneg,
+	.setup_forced	= genmii_setup_forced,
+	.poll_link	= genmii_poll_link,
+	.read_link	= genmii_read_link
+};
+
+static struct mii_phy_def genmii_phy_def = {
+	.phy_id		= 0x00000000,
+	.phy_id_mask	= 0x00000000,
+	.name		= "Generic MII",
+	.ops		= &generic_phy_ops
+};
+
+/* CIS8201 */
+#define MII_CIS8201_EPCR	0x17
+#define  EPCR_MODE_MASK		0x3000
+#define  EPCR_GMII_MODE		0x0000
+#define  EPCR_RGMII_MODE	0x1000
+#define  EPCR_TBI_MODE		0x2000
+#define  EPCR_RTBI_MODE		0x3000
+
+static int cis8201_init(struct mii_phy *phy)
 {
-	u16 lpa;
+	int epcr;
 
-	if (phy->autoneg) {
-		lpa = phy_read(phy, MII_LPA) & phy_read(phy, MII_ADVERTISE);
+	epcr = phy_read(phy, MII_CIS8201_EPCR);
+	if (epcr < 0)
+		return epcr;
 
-		phy->speed = SPEED_10;
-		phy->duplex = DUPLEX_HALF;
-		phy->pause = 0;
+	epcr &= ~EPCR_MODE_MASK;
 
-		if (lpa & (LPA_100FULL | LPA_100HALF)) {
-			phy->speed = SPEED_100;
-			if (lpa & LPA_100FULL)
-				phy->duplex = DUPLEX_FULL;
-		} else if (lpa & LPA_10FULL)
-			phy->duplex = DUPLEX_FULL;
+	switch (phy->mode) {
+	case PHY_MODE_TBI:
+		epcr |= EPCR_TBI_MODE;
+		break;
+	case PHY_MODE_RTBI:
+		epcr |= EPCR_RTBI_MODE;
+		break;
+	case PHY_MODE_GMII:
+		epcr |= EPCR_GMII_MODE;
+		break;
+	case PHY_MODE_RGMII:
+	default:
+		epcr |= EPCR_RGMII_MODE;
 	}
-	/* On non-aneg, we assume what we put in BMCR is the speed,
-	 * though magic-aneg shouldn't prevent this case from occurring
-	 */
+
+	phy_write(phy, MII_CIS8201_EPCR, epcr);
 
 	return 0;
 }
 
-#define MII_BASIC_FEATURES	(SUPPORTED_10baseT_Half | SUPPORTED_10baseT_Full | \
-				 SUPPORTED_100baseT_Half | SUPPORTED_100baseT_Full | \
-				 SUPPORTED_Autoneg | SUPPORTED_TP | SUPPORTED_MII)
-#define MII_GBIT_FEATURES	(MII_BASIC_FEATURES | \
-				 SUPPORTED_1000baseT_Half | SUPPORTED_1000baseT_Full)
-
-/* CIS8201 phy ops */
 static struct mii_phy_ops cis8201_phy_ops = {
-	init:cis8201_init,
-	setup_aneg:genmii_setup_aneg,
-	setup_forced:genmii_setup_forced,
-	poll_link:genmii_poll_link,
-	read_link:cis8201_read_link
-};
-
-/* Generic implementation for most 10/100 PHYs */
-static struct mii_phy_ops generic_phy_ops = {
-	setup_aneg:genmii_setup_aneg,
-	setup_forced:genmii_setup_forced,
-	poll_link:genmii_poll_link,
-	read_link:genmii_read_link
+	.init		= cis8201_init,
+	.setup_aneg	= genmii_setup_aneg,
+	.setup_forced	= genmii_setup_forced,
+	.poll_link	= genmii_poll_link,
+	.read_link	= genmii_read_link
 };
 
 static struct mii_phy_def cis8201_phy_def = {
-	phy_id:0x000fc410,
-	phy_id_mask:0x000ffff0,
-	name:"CIS8201 Gigabit Ethernet",
-	features:MII_GBIT_FEATURES,
-	magic_aneg:0,
-	ops:&cis8201_phy_ops
-};
-
-static struct mii_phy_def genmii_phy_def = {
-	phy_id:0x00000000,
-	phy_id_mask:0x00000000,
-	name:"Generic MII",
-	features:MII_BASIC_FEATURES,
-	magic_aneg:0,
-	ops:&generic_phy_ops
+	.phy_id		= 0x000fc410,
+	.phy_id_mask	= 0x000ffff0,
+	.name		= "CIS8201 Gigabit Ethernet",
+	.ops		= &cis8201_phy_ops
 };
 
 static struct mii_phy_def *mii_phy_table[] = {
@@ -258,39 +294,60 @@ static struct mii_phy_def *mii_phy_table
 	NULL
 };
 
-int mii_phy_probe(struct mii_phy *phy, int mii_id)
+int mii_phy_probe(struct mii_phy *phy, int address)
 {
-	int rc;
-	u32 id;
 	struct mii_phy_def *def;
 	int i;
+	u32 id;
 
-	phy->autoneg = 0;
+	phy->autoneg = AUTONEG_DISABLE;
 	phy->advertising = 0;
-	phy->mii_id = mii_id;
-	phy->speed = 0;
-	phy->duplex = 0;
-	phy->pause = 0;
-
-	/* Take PHY out of isloate mode and reset it. */
-	rc = reset_one_mii_phy(phy, mii_id);
-	if (rc)
+	phy->address = address;
+	phy->speed = SPEED_10;
+	phy->duplex = DUPLEX_HALF;
+	phy->pause = phy->asym_pause = 0;
+
+	/* Take PHY out of isolate mode and reset it. */
+	if (mii_reset_phy(phy))
 		return -ENODEV;
 
 	/* Read ID and find matching entry */
-	id = (phy_read(phy, MII_PHYSID1) << 16 | phy_read(phy, MII_PHYSID2))
-	    & 0xfffffff0;
+	id = (phy_read(phy, MII_PHYSID1) << 16) | phy_read(phy, MII_PHYSID2);
 	for (i = 0; (def = mii_phy_table[i]) != NULL; i++)
 		if ((id & def->phy_id_mask) == def->phy_id)
 			break;
 	/* Should never be NULL (we have a generic entry), but... */
-	if (def == NULL)
+	if (!def)
 		return -ENODEV;
 
 	phy->def = def;
 
+	/* Determine PHY features if needed */
+	phy->features = def->features;
+	if (!phy->features) {
+		u16 bmsr = phy_read(phy, MII_BMSR);
+		if (bmsr & BMSR_ANEGCAPABLE)
+			phy->features |= SUPPORTED_Autoneg;
+		if (bmsr & BMSR_10HALF)
+			phy->features |= SUPPORTED_10baseT_Half;
+		if (bmsr & BMSR_10FULL)
+			phy->features |= SUPPORTED_10baseT_Full;
+		if (bmsr & BMSR_100HALF)
+			phy->features |= SUPPORTED_100baseT_Half;
+		if (bmsr & BMSR_100FULL)
+			phy->features |= SUPPORTED_100baseT_Full;
+		if (bmsr & BMSR_ESTATEN) {
+			u16 esr = phy_read(phy, MII_ESTATUS);
+			if (esr & ESTATUS_1000_TFULL)
+				phy->features |= SUPPORTED_1000baseT_Full;
+			if (esr & ESTATUS_1000_THALF)
+				phy->features |= SUPPORTED_1000baseT_Half;
+		}
+		phy->features |= SUPPORTED_MII;
+	}
+
 	/* Setup default advertising */
-	phy->advertising = def->features;
+	phy->advertising = phy->features;
 
 	return 0;
 }
diff -puN drivers/net/ibm_emac/ibm_emac_phy.h~new-powerpc-4xx-on-chip-ethernet-controller-driver drivers/net/ibm_emac/ibm_emac_phy.h
--- devel/drivers/net/ibm_emac/ibm_emac_phy.h~new-powerpc-4xx-on-chip-ethernet-controller-driver	2005-10-28 17:44:03.000000000 -0700
+++ devel-akpm/drivers/net/ibm_emac/ibm_emac_phy.h	2005-10-28 17:44:03.000000000 -0700
@@ -1,65 +1,25 @@
-
 /*
- * ibm_emac_phy.h
- *
+ * drivers/net/ibm_emac/ibm_emac_phy.h
  *
- *      Benjamin Herrenschmidt <benh@kernel.crashing.org>
- *      February 2003
- *
- * This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
+ * Driver for PowerPC 4xx on-chip ethernet controller, PHY support
  *
- *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR   IMPLIED
- *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
- *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT,  INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
- *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
- *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ * Benjamin Herrenschmidt <benh@kernel.crashing.org>
+ * February 2003
  *
- *  You should have received a copy of the  GNU General Public License along
- *  with this program; if not, write  to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
+ * Minor additions by Eugene Surovegin <ebs@ebshome.net>, 2004
  *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
  *
  * This file basically duplicates sungem_phy.{c,h} with different PHYs
  * supported. I'm looking into merging that in a single mii layer more
  * flexible than mii.c 
  */
 
-#ifndef _IBM_EMAC_PHY_H_
-#define _IBM_EMAC_PHY_H_
-
-/*
- * PHY mode settings
- * Used for multi-mode capable PHYs
- */
-#define PHY_MODE_NA	0
-#define PHY_MODE_MII	1
-#define PHY_MODE_RMII	2
-#define PHY_MODE_SMII	3
-#define PHY_MODE_RGMII	4
-#define PHY_MODE_TBI	5
-#define PHY_MODE_GMII	6
-#define PHY_MODE_RTBI	7
-#define PHY_MODE_SGMII	8
-
-/*
- * PHY specific registers/values
- */
-
-/* CIS8201 */
-#define MII_CIS8201_EPCR	0x17
-#define EPCR_MODE_MASK		0x3000
-#define EPCR_GMII_MODE		0x0000
-#define EPCR_RGMII_MODE		0x1000
-#define EPCR_TBI_MODE		0x2000
-#define EPCR_RTBI_MODE		0x3000
+#ifndef _IBM_OCP_PHY_H_
+#define _IBM_OCP_PHY_H_
 
 struct mii_phy;
 
@@ -77,7 +37,8 @@ struct mii_phy_ops {
 struct mii_phy_def {
 	u32 phy_id;		/* Concatenated ID1 << 16 | ID2 */
 	u32 phy_id_mask;	/* Significant bits */
-	u32 features;		/* Ethtool SUPPORTED_* defines */
+	u32 features;		/* Ethtool SUPPORTED_* defines or
+				   0 for autodetect */
 	int magic_aneg;		/* Autoneg does all speed test for us */
 	const char *name;
 	const struct mii_phy_ops *ops;
@@ -86,8 +47,11 @@ struct mii_phy_def {
 /* An instance of a PHY, partially borrowed from mii_if_info */
 struct mii_phy {
 	struct mii_phy_def *def;
-	int advertising;
-	int mii_id;
+	u32 advertising;	/* Ethtool ADVERTISED_* defines */
+	u32 features;		/* Copied from mii_phy_def.features
+				   or determined automaticaly */
+	int address;		/* PHY address */
+	int mode;		/* PHY mode */
 
 	/* 1: autoneg enabled, 0: disabled */
 	int autoneg;
@@ -98,40 +62,19 @@ struct mii_phy {
 	int speed;
 	int duplex;
 	int pause;
-
-	/* PHY mode - if needed */
-	int mode;
+	int asym_pause;
 
 	/* Provided by host chip */
 	struct net_device *dev;
-	int (*mdio_read) (struct net_device * dev, int mii_id, int reg);
-	void (*mdio_write) (struct net_device * dev, int mii_id, int reg,
+	int (*mdio_read) (struct net_device * dev, int addr, int reg);
+	void (*mdio_write) (struct net_device * dev, int addr, int reg,
 			    int val);
 };
 
 /* Pass in a struct mii_phy with dev, mdio_read and mdio_write
  * filled, the remaining fields will be filled on return
  */
-extern int mii_phy_probe(struct mii_phy *phy, int mii_id);
-
-static inline int __phy_read(struct mii_phy *phy, int id, int reg)
-{
-	return phy->mdio_read(phy->dev, id, reg);
-}
-
-static inline void __phy_write(struct mii_phy *phy, int id, int reg, int val)
-{
-	phy->mdio_write(phy->dev, id, reg, val);
-}
-
-static inline int phy_read(struct mii_phy *phy, int reg)
-{
-	return phy->mdio_read(phy->dev, phy->mii_id, reg);
-}
-
-static inline void phy_write(struct mii_phy *phy, int reg, int val)
-{
-	phy->mdio_write(phy->dev, phy->mii_id, reg, val);
-}
+int mii_phy_probe(struct mii_phy *phy, int address);
+int mii_reset_phy(struct mii_phy *phy);
 
-#endif				/* _IBM_EMAC_PHY_H_ */
+#endif				/* _IBM_OCP_PHY_H_ */
diff -puN /dev/null drivers/net/ibm_emac/ibm_emac_rgmii.c
--- /dev/null	2003-09-15 06:40:47.000000000 -0700
+++ devel-akpm/drivers/net/ibm_emac/ibm_emac_rgmii.c	2005-10-28 17:44:03.000000000 -0700
@@ -0,0 +1,201 @@
+/*
+ * drivers/net/ibm_emac/ibm_emac_rgmii.c
+ *
+ * Driver for PowerPC 4xx on-chip ethernet controller, RGMII bridge support.
+ *
+ * Copyright (c) 2004, 2005 Zultys Technologies.
+ * Eugene Surovegin <eugene.surovegin@zultys.com> or <ebs@ebshome.net>
+ *
+ * Based on original work by
+ * 	Matt Porter <mporter@kernel.crashing.org>
+ * 	Copyright 2004 MontaVista Software, Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ */
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/ethtool.h>
+#include <asm/io.h>
+
+#include "ibm_emac_core.h"
+#include "ibm_emac_debug.h"
+
+/* RGMIIx_FER */
+#define RGMII_FER_MASK(idx)	(0x7 << ((idx) * 4))
+#define RGMII_FER_RTBI(idx)	(0x4 << ((idx) * 4))
+#define RGMII_FER_RGMII(idx)	(0x5 << ((idx) * 4))
+#define RGMII_FER_TBI(idx)	(0x6 << ((idx) * 4))
+#define RGMII_FER_GMII(idx)	(0x7 << ((idx) * 4))
+
+/* RGMIIx_SSR */
+#define RGMII_SSR_MASK(idx)	(0x7 << ((idx) * 8))
+#define RGMII_SSR_100(idx)	(0x2 << ((idx) * 8))
+#define RGMII_SSR_1000(idx)	(0x4 << ((idx) * 8))
+
+/* RGMII bridge supports only GMII/TBI and RGMII/RTBI PHYs */
+static inline int rgmii_valid_mode(int phy_mode)
+{
+	return  phy_mode == PHY_MODE_GMII ||
+		phy_mode == PHY_MODE_RGMII ||
+		phy_mode == PHY_MODE_TBI ||
+		phy_mode == PHY_MODE_RTBI;
+}
+
+static inline const char *rgmii_mode_name(int mode)
+{
+	switch (mode) {
+	case PHY_MODE_RGMII:
+		return "RGMII";
+	case PHY_MODE_TBI:
+		return "TBI";
+	case PHY_MODE_GMII:
+		return "GMII";
+	case PHY_MODE_RTBI:
+		return "RTBI";
+	default:
+		BUG();
+	}
+}
+
+static inline u32 rgmii_mode_mask(int mode, int input)
+{
+	switch (mode) {
+	case PHY_MODE_RGMII:
+		return RGMII_FER_RGMII(input);
+	case PHY_MODE_TBI:
+		return RGMII_FER_TBI(input);
+	case PHY_MODE_GMII:
+		return RGMII_FER_GMII(input);
+	case PHY_MODE_RTBI:
+		return RGMII_FER_RTBI(input);
+	default:
+		BUG();
+	}
+}
+
+static int __init rgmii_init(struct ocp_device *ocpdev, int input, int mode)
+{
+	struct ibm_ocp_rgmii *dev = ocp_get_drvdata(ocpdev);
+	struct rgmii_regs *p;
+
+	RGMII_DBG("%d: init(%d, %d)" NL, ocpdev->def->index, input, mode);
+
+	if (!dev) {
+		dev = kzalloc(sizeof(struct ibm_ocp_rgmii), GFP_KERNEL);
+		if (!dev) {
+			printk(KERN_ERR
+			       "rgmii%d: couldn't allocate device structure!\n",
+			       ocpdev->def->index);
+			return -ENOMEM;
+		}
+
+		p = (struct rgmii_regs *)ioremap(ocpdev->def->paddr,
+						 sizeof(struct rgmii_regs));
+		if (!p) {
+			printk(KERN_ERR
+			       "rgmii%d: could not ioremap device registers!\n",
+			       ocpdev->def->index);
+			kfree(dev);
+			return -ENOMEM;
+		}
+
+		dev->base = p;
+		ocp_set_drvdata(ocpdev, dev);
+
+		/* Disable all inputs by default */
+		out_be32(&p->fer, 0);
+	} else
+		p = dev->base;
+
+	/* Enable this input */
+	out_be32(&p->fer, in_be32(&p->fer) | rgmii_mode_mask(mode, input));
+
+	printk(KERN_NOTICE "rgmii%d: input %d in %s mode\n",
+	       ocpdev->def->index, input, rgmii_mode_name(mode));
+
+	++dev->users;
+	return 0;
+}
+
+int __init rgmii_attach(void *emac)
+{
+	struct ocp_enet_private *dev = emac;
+	struct ocp_func_emac_data *emacdata = dev->def->additions;
+
+	/* Check if we need to attach to a RGMII */
+	if (emacdata->rgmii_idx >= 0 && rgmii_valid_mode(emacdata->phy_mode)) {
+		dev->rgmii_input = emacdata->rgmii_mux;
+		dev->rgmii_dev =
+		    ocp_find_device(OCP_VENDOR_IBM, OCP_FUNC_RGMII,
+				    emacdata->rgmii_idx);
+		if (!dev->rgmii_dev) {
+			printk(KERN_ERR "emac%d: unknown rgmii%d!\n",
+			       dev->def->index, emacdata->rgmii_idx);
+			return -ENODEV;
+		}
+		if (rgmii_init
+		    (dev->rgmii_dev, dev->rgmii_input, emacdata->phy_mode)) {
+			printk(KERN_ERR
+			       "emac%d: rgmii%d initialization failed!\n",
+			       dev->def->index, emacdata->rgmii_idx);
+			return -ENODEV;
+		}
+	}
+	return 0;
+}
+
+void rgmii_set_speed(struct ocp_device *ocpdev, int input, int speed)
+{
+	struct ibm_ocp_rgmii *dev = ocp_get_drvdata(ocpdev);
+	u32 ssr = in_be32(&dev->base->ssr) & ~RGMII_SSR_MASK(input);
+
+	RGMII_DBG("%d: speed(%d, %d)" NL, ocpdev->def->index, input, speed);
+
+	if (speed == SPEED_1000)
+		ssr |= RGMII_SSR_1000(input);
+	else if (speed == SPEED_100)
+		ssr |= RGMII_SSR_100(input);
+
+	out_be32(&dev->base->ssr, ssr);
+}
+
+void __exit __rgmii_fini(struct ocp_device *ocpdev, int input)
+{
+	struct ibm_ocp_rgmii *dev = ocp_get_drvdata(ocpdev);
+	BUG_ON(!dev || dev->users == 0);
+
+	RGMII_DBG("%d: fini(%d)" NL, ocpdev->def->index, input);
+
+	/* Disable this input */
+	out_be32(&dev->base->fer,
+		 in_be32(&dev->base->fer) & ~RGMII_FER_MASK(input));
+
+	if (!--dev->users) {
+		/* Free everything if this is the last user */
+		ocp_set_drvdata(ocpdev, NULL);
+		iounmap((void *)dev->base);
+		kfree(dev);
+	}
+}
+
+int __rgmii_get_regs_len(struct ocp_device *ocpdev)
+{
+	return sizeof(struct emac_ethtool_regs_subhdr) +
+	    sizeof(struct rgmii_regs);
+}
+
+void *rgmii_dump_regs(struct ocp_device *ocpdev, void *buf)
+{
+	struct ibm_ocp_rgmii *dev = ocp_get_drvdata(ocpdev);
+	struct emac_ethtool_regs_subhdr *hdr = buf;
+	struct rgmii_regs *regs = (struct rgmii_regs *)(hdr + 1);
+
+	hdr->version = 0;
+	hdr->index = ocpdev->def->index;
+	memcpy_fromio(regs, dev->base, sizeof(struct rgmii_regs));
+	return regs + 1;
+}
diff -puN drivers/net/ibm_emac/ibm_emac_rgmii.h~new-powerpc-4xx-on-chip-ethernet-controller-driver drivers/net/ibm_emac/ibm_emac_rgmii.h
--- devel/drivers/net/ibm_emac/ibm_emac_rgmii.h~new-powerpc-4xx-on-chip-ethernet-controller-driver	2005-10-28 17:44:03.000000000 -0700
+++ devel-akpm/drivers/net/ibm_emac/ibm_emac_rgmii.h	2005-10-28 17:44:03.000000000 -0700
@@ -1,5 +1,7 @@
 /*
- * Defines for the IBM RGMII bridge
+ * drivers/net/ibm_emac/ibm_emac_rgmii.c
+ *
+ * Driver for PowerPC 4xx on-chip ethernet controller, RGMII bridge support.
  *
  * Based on ocp_zmii.h/ibm_emac_zmii.h
  * Armin Kuster akuster@mvista.com
@@ -7,6 +9,9 @@
  * Copyright 2004 MontaVista Software, Inc.
  * Matt Porter <mporter@kernel.crashing.org>
  *
+ * Copyright (c) 2004, 2005 Zultys Technologies.
+ * Eugene Surovegin <eugene.surovegin@zultys.com> or <ebs@ebshome.net>
+ *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
  * Free Software Foundation;  either version 2 of the  License, or (at your
@@ -19,47 +24,42 @@
 #include <linux/config.h>
 
 /* RGMII bridge */
-typedef struct rgmii_regs {
+struct rgmii_regs {
 	u32 fer;		/* Function enable register */
 	u32 ssr;		/* Speed select register */
-} rgmii_t;
-
-#define RGMII_INPUTS			4
+};
 
 /* RGMII device */
 struct ibm_ocp_rgmii {
 	struct rgmii_regs *base;
-	int mode[RGMII_INPUTS];
 	int users;		/* number of EMACs using this RGMII bridge */
 };
 
-/* Fuctional Enable Reg */
-#define RGMII_FER_MASK(x)		(0x00000007 << (4*x))
-#define RGMII_RTBI			0x00000004
-#define RGMII_RGMII			0x00000005
-#define RGMII_TBI  			0x00000006
-#define RGMII_GMII 			0x00000007
-
-/* Speed Selection reg */
-
-#define RGMII_SP2_100	0x00000002
-#define RGMII_SP2_1000	0x00000004
-#define RGMII_SP3_100	0x00000200
-#define RGMII_SP3_1000	0x00000400
-
-#define RGMII_MII2_SPDMASK	 0x00000007
-#define RGMII_MII3_SPDMASK	 0x00000700
-
-#define RGMII_MII2_100MB	 RGMII_SP2_100 & ~RGMII_SP2_1000
-#define RGMII_MII2_1000MB 	 RGMII_SP2_1000 & ~RGMII_SP2_100
-#define RGMII_MII2_10MB		 ~(RGMII_SP2_100 | RGMII_SP2_1000)
-#define RGMII_MII3_100MB	 RGMII_SP3_100 & ~RGMII_SP3_1000
-#define RGMII_MII3_1000MB 	 RGMII_SP3_1000 & ~RGMII_SP3_100
-#define RGMII_MII3_10MB		 ~(RGMII_SP3_100 | RGMII_SP3_1000)
-
-#define RTBI		0
-#define RGMII		1
-#define TBI		2
-#define GMII		3
+#ifdef CONFIG_IBM_EMAC_RGMII
+int rgmii_attach(void *emac) __init;
+
+void __rgmii_fini(struct ocp_device *ocpdev, int input) __exit;
+static inline void rgmii_fini(struct ocp_device *ocpdev, int input)
+{
+	if (ocpdev)
+		__rgmii_fini(ocpdev, input);
+}
+
+void rgmii_set_speed(struct ocp_device *ocpdev, int input, int speed);
+
+int __rgmii_get_regs_len(struct ocp_device *ocpdev);
+static inline int rgmii_get_regs_len(struct ocp_device *ocpdev)
+{
+	return ocpdev ? __rgmii_get_regs_len(ocpdev) : 0;
+}
+
+void *rgmii_dump_regs(struct ocp_device *ocpdev, void *buf);
+#else
+# define rgmii_attach(x)	0
+# define rgmii_fini(x,y)	((void)0)
+# define rgmii_set_speed(x,y,z)	((void)0)
+# define rgmii_get_regs_len(x)	0
+# define rgmii_dump_regs(x,buf)	(buf)
+#endif				/* !CONFIG_IBM_EMAC_RGMII */
 
 #endif				/* _IBM_EMAC_RGMII_H_ */
diff -puN /dev/null drivers/net/ibm_emac/ibm_emac_tah.c
--- /dev/null	2003-09-15 06:40:47.000000000 -0700
+++ devel-akpm/drivers/net/ibm_emac/ibm_emac_tah.c	2005-10-28 17:44:03.000000000 -0700
@@ -0,0 +1,111 @@
+/*
+ * drivers/net/ibm_emac/ibm_emac_tah.c
+ *
+ * Driver for PowerPC 4xx on-chip ethernet controller, TAH support.
+ *
+ * Copyright 2004 MontaVista Software, Inc.
+ * Matt Porter <mporter@kernel.crashing.org>
+ *
+ * Copyright (c) 2005 Eugene Surovegin <ebs@ebshome.net>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+#include <linux/config.h>
+#include <asm/io.h>
+
+#include "ibm_emac_core.h"
+
+static int __init tah_init(struct ocp_device *ocpdev)
+{
+	struct tah_regs *p;
+
+	if (ocp_get_drvdata(ocpdev)) {
+		printk(KERN_ERR "tah%d: already in use!\n", ocpdev->def->index);
+		return -EBUSY;
+	}
+
+	/* Initialize TAH and enable IPv4 checksum verification, no TSO yet */
+	p = (struct tah_regs *)ioremap(ocpdev->def->paddr, sizeof(*p));
+	if (!p) {
+		printk(KERN_ERR "tah%d: could not ioremap device registers!\n",
+		       ocpdev->def->index);
+		return -ENOMEM;
+	}
+	ocp_set_drvdata(ocpdev, p);
+	__tah_reset(ocpdev);
+
+	return 0;
+}
+
+int __init tah_attach(void *emac)
+{
+	struct ocp_enet_private *dev = emac;
+	struct ocp_func_emac_data *emacdata = dev->def->additions;
+
+	/* Check if we need to attach to a TAH */
+	if (emacdata->tah_idx >= 0) {
+		dev->tah_dev = ocp_find_device(OCP_ANY_ID, OCP_FUNC_TAH,
+					       emacdata->tah_idx);
+		if (!dev->tah_dev) {
+			printk(KERN_ERR "emac%d: unknown tah%d!\n",
+			       dev->def->index, emacdata->tah_idx);
+			return -ENODEV;
+		}
+		if (tah_init(dev->tah_dev)) {
+			printk(KERN_ERR
+			       "emac%d: tah%d initialization failed!\n",
+			       dev->def->index, emacdata->tah_idx);
+			return -ENODEV;
+		}
+	}
+	return 0;
+}
+
+void __exit __tah_fini(struct ocp_device *ocpdev)
+{
+	struct tah_regs *p = ocp_get_drvdata(ocpdev);
+	BUG_ON(!p);
+	ocp_set_drvdata(ocpdev, NULL);
+	iounmap((void *)p);
+}
+
+void __tah_reset(struct ocp_device *ocpdev)
+{
+	struct tah_regs *p = ocp_get_drvdata(ocpdev);
+	int n;
+
+	/* Reset TAH */
+	out_be32(&p->mr, TAH_MR_SR);
+	n = 100;
+	while ((in_be32(&p->mr) & TAH_MR_SR) && n)
+		--n;
+
+	if (unlikely(!n))
+		printk(KERN_ERR "tah%d: reset timeout\n", ocpdev->def->index);
+
+	/* 10KB TAH TX FIFO accomodates the max MTU of 9000 */
+	out_be32(&p->mr,
+		 TAH_MR_CVR | TAH_MR_ST_768 | TAH_MR_TFS_10KB | TAH_MR_DTFP |
+		 TAH_MR_DIG);
+}
+
+int __tah_get_regs_len(struct ocp_device *ocpdev)
+{
+	return sizeof(struct emac_ethtool_regs_subhdr) +
+	    sizeof(struct tah_regs);
+}
+
+void *tah_dump_regs(struct ocp_device *ocpdev, void *buf)
+{
+	struct tah_regs *dev = ocp_get_drvdata(ocpdev);
+	struct emac_ethtool_regs_subhdr *hdr = buf;
+	struct tah_regs *regs = (struct tah_regs *)(hdr + 1);
+
+	hdr->version = 0;
+	hdr->index = ocpdev->def->index;
+	memcpy_fromio(regs, dev, sizeof(struct tah_regs));
+	return regs + 1;
+}
diff -puN drivers/net/ibm_emac/ibm_emac_tah.h~new-powerpc-4xx-on-chip-ethernet-controller-driver drivers/net/ibm_emac/ibm_emac_tah.h
--- devel/drivers/net/ibm_emac/ibm_emac_tah.h~new-powerpc-4xx-on-chip-ethernet-controller-driver	2005-10-28 17:44:03.000000000 -0700
+++ devel-akpm/drivers/net/ibm_emac/ibm_emac_tah.h	2005-10-28 17:44:03.000000000 -0700
@@ -1,9 +1,13 @@
 /*
- * Defines for the IBM TAH
+ * drivers/net/ibm_emac/ibm_emac_tah.h
+ *
+ * Driver for PowerPC 4xx on-chip ethernet controller, TAH support.
  *
  * Copyright 2004 MontaVista Software, Inc.
  * Matt Porter <mporter@kernel.crashing.org>
  *
+ * Copyright (c) 2005 Eugene Surovegin <ebs@ebshome.net>
+ *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
  * Free Software Foundation;  either version 2 of the  License, or (at your
@@ -13,36 +17,72 @@
 #ifndef _IBM_EMAC_TAH_H
 #define _IBM_EMAC_TAH_H
 
+#include <linux/config.h>
+#include <linux/init.h>
+#include <asm/ocp.h>
+
 /* TAH */
-typedef struct tah_regs {
-	u32 tah_revid;
+struct tah_regs {
+	u32 revid;
 	u32 pad[3];
-	u32 tah_mr;
-	u32 tah_ssr0;
-	u32 tah_ssr1;
-	u32 tah_ssr2;
-	u32 tah_ssr3;
-	u32 tah_ssr4;
-	u32 tah_ssr5;
-	u32 tah_tsr;
-} tah_t;
+	u32 mr;
+	u32 ssr0;
+	u32 ssr1;
+	u32 ssr2;
+	u32 ssr3;
+	u32 ssr4;
+	u32 ssr5;
+	u32 tsr;
+};
 
 /* TAH engine */
-#define TAH_MR_CVR			0x80000000
-#define TAH_MR_SR			0x40000000
-#define TAH_MR_ST_256			0x01000000
-#define TAH_MR_ST_512			0x02000000
-#define TAH_MR_ST_768			0x03000000
-#define TAH_MR_ST_1024			0x04000000
-#define TAH_MR_ST_1280			0x05000000
-#define TAH_MR_ST_1536			0x06000000
-#define TAH_MR_TFS_16KB			0x00000000
-#define TAH_MR_TFS_2KB			0x00200000
-#define TAH_MR_TFS_4KB			0x00400000
-#define TAH_MR_TFS_6KB			0x00600000
-#define TAH_MR_TFS_8KB			0x00800000
-#define TAH_MR_TFS_10KB			0x00a00000
-#define TAH_MR_DTFP			0x00100000
-#define TAH_MR_DIG			0x00080000
+#define TAH_MR_CVR		0x80000000
+#define TAH_MR_SR		0x40000000
+#define TAH_MR_ST_256		0x01000000
+#define TAH_MR_ST_512		0x02000000
+#define TAH_MR_ST_768		0x03000000
+#define TAH_MR_ST_1024		0x04000000
+#define TAH_MR_ST_1280		0x05000000
+#define TAH_MR_ST_1536		0x06000000
+#define TAH_MR_TFS_16KB		0x00000000
+#define TAH_MR_TFS_2KB		0x00200000
+#define TAH_MR_TFS_4KB		0x00400000
+#define TAH_MR_TFS_6KB		0x00600000
+#define TAH_MR_TFS_8KB		0x00800000
+#define TAH_MR_TFS_10KB		0x00a00000
+#define TAH_MR_DTFP		0x00100000
+#define TAH_MR_DIG		0x00080000
+
+#ifdef CONFIG_IBM_EMAC_TAH
+int tah_attach(void *emac) __init;
+
+void __tah_fini(struct ocp_device *ocpdev) __exit;
+static inline void tah_fini(struct ocp_device *ocpdev)
+{
+	if (ocpdev)
+		__tah_fini(ocpdev);
+}
+
+void __tah_reset(struct ocp_device *ocpdev);
+static inline void tah_reset(struct ocp_device *ocpdev)
+{
+	if (ocpdev)
+		__tah_reset(ocpdev);
+}
+
+int __tah_get_regs_len(struct ocp_device *ocpdev);
+static inline int tah_get_regs_len(struct ocp_device *ocpdev)
+{
+	return ocpdev ? __tah_get_regs_len(ocpdev) : 0;
+}
+
+void *tah_dump_regs(struct ocp_device *ocpdev, void *buf);
+#else
+# define tah_attach(x)		0
+# define tah_fini(x)		((void)0)
+# define tah_reset(x)		((void)0)
+# define tah_get_regs_len(x)	0
+# define tah_dump_regs(x,buf)	(buf)
+#endif				/* !CONFIG_IBM_EMAC_TAH */
 
 #endif				/* _IBM_EMAC_TAH_H */
diff -puN /dev/null drivers/net/ibm_emac/ibm_emac_zmii.c
--- /dev/null	2003-09-15 06:40:47.000000000 -0700
+++ devel-akpm/drivers/net/ibm_emac/ibm_emac_zmii.c	2005-10-28 17:44:03.000000000 -0700
@@ -0,0 +1,255 @@
+/*
+ * drivers/net/ibm_emac/ibm_emac_zmii.c
+ *
+ * Driver for PowerPC 4xx on-chip ethernet controller, ZMII bridge support.
+ *
+ * Copyright (c) 2004, 2005 Zultys Technologies.
+ * Eugene Surovegin <eugene.surovegin@zultys.com> or <ebs@ebshome.net>
+ *
+ * Based on original work by
+ *      Armin Kuster <akuster@mvista.com>
+ * 	Copyright 2001 MontaVista Softare Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ */
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/ethtool.h>
+#include <asm/io.h>
+
+#include "ibm_emac_core.h"
+#include "ibm_emac_debug.h"
+
+/* ZMIIx_FER */
+#define ZMII_FER_MDI(idx)	(0x80000000 >> ((idx) * 4))
+#define ZMII_FER_MDI_ALL	(ZMII_FER_MDI(0) | ZMII_FER_MDI(1) | \
+				 ZMII_FER_MDI(2) | ZMII_FER_MDI(3))
+
+#define ZMII_FER_SMII(idx)	(0x40000000 >> ((idx) * 4))
+#define ZMII_FER_RMII(idx)	(0x20000000 >> ((idx) * 4))
+#define ZMII_FER_MII(idx)	(0x10000000 >> ((idx) * 4))
+
+/* ZMIIx_SSR */
+#define ZMII_SSR_SCI(idx)	(0x40000000 >> ((idx) * 4))
+#define ZMII_SSR_FSS(idx)	(0x20000000 >> ((idx) * 4))
+#define ZMII_SSR_SP(idx)	(0x10000000 >> ((idx) * 4))
+
+/* ZMII only supports MII, RMII and SMII
+ * we also support autodetection for backward compatibility
+ */
+static inline int zmii_valid_mode(int mode)
+{
+	return  mode == PHY_MODE_MII ||
+		mode == PHY_MODE_RMII ||
+		mode == PHY_MODE_SMII ||
+		mode == PHY_MODE_NA;
+}
+
+static inline const char *zmii_mode_name(int mode)
+{
+	switch (mode) {
+	case PHY_MODE_MII:
+		return "MII";
+	case PHY_MODE_RMII:
+		return "RMII";
+	case PHY_MODE_SMII:
+		return "SMII";
+	default:
+		BUG();
+	}
+}
+
+static inline u32 zmii_mode_mask(int mode, int input)
+{
+	switch (mode) {
+	case PHY_MODE_MII:
+		return ZMII_FER_MII(input);
+	case PHY_MODE_RMII:
+		return ZMII_FER_RMII(input);
+	case PHY_MODE_SMII:
+		return ZMII_FER_SMII(input);
+	default:
+		return 0;
+	}
+}
+
+static int __init zmii_init(struct ocp_device *ocpdev, int input, int *mode)
+{
+	struct ibm_ocp_zmii *dev = ocp_get_drvdata(ocpdev);
+	struct zmii_regs *p;
+
+	ZMII_DBG("%d: init(%d, %d)" NL, ocpdev->def->index, input, *mode);
+
+	if (!dev) {
+		dev = kzalloc(sizeof(struct ibm_ocp_zmii), GFP_KERNEL);
+		if (!dev) {
+			printk(KERN_ERR
+			       "zmii%d: couldn't allocate device structure!\n",
+			       ocpdev->def->index);
+			return -ENOMEM;
+		}
+		dev->mode = PHY_MODE_NA;
+
+		p = (struct zmii_regs *)ioremap(ocpdev->def->paddr,
+						sizeof(struct zmii_regs));
+		if (!p) {
+			printk(KERN_ERR
+			       "zmii%d: could not ioremap device registers!\n",
+			       ocpdev->def->index);
+			kfree(dev);
+			return -ENOMEM;
+		}
+		dev->base = p;
+		ocp_set_drvdata(ocpdev, dev);
+
+		/* We may need FER value for autodetection later */
+		dev->fer_save = in_be32(&p->fer);
+
+		/* Disable all inputs by default */
+		out_be32(&p->fer, 0);
+	} else
+		p = dev->base;
+
+	if (!zmii_valid_mode(*mode)) {
+		/* Probably an EMAC connected to RGMII,
+		 * but it still may need ZMII for MDIO
+		 */
+		goto out;
+	}
+
+	/* Autodetect ZMII mode if not specified.
+	 * This is only for backward compatibility with the old driver.
+	 * Please, always specify PHY mode in your board port to avoid
+	 * any surprises.
+	 */
+	if (dev->mode == PHY_MODE_NA) {
+		if (*mode == PHY_MODE_NA) {
+			u32 r = dev->fer_save;
+
+			ZMII_DBG("%d: autodetecting mode, FER = 0x%08x" NL,
+				 ocpdev->def->index, r);
+
+			if (r & (ZMII_FER_MII(0) | ZMII_FER_MII(1)))
+				dev->mode = PHY_MODE_MII;
+			else if (r & (ZMII_FER_RMII(0) | ZMII_FER_RMII(1)))
+				dev->mode = PHY_MODE_RMII;
+			else
+				dev->mode = PHY_MODE_SMII;
+		} else
+			dev->mode = *mode;
+
+		printk(KERN_NOTICE "zmii%d: bridge in %s mode\n",
+		       ocpdev->def->index, zmii_mode_name(dev->mode));
+	} else {
+		/* All inputs must use the same mode */
+		if (*mode != PHY_MODE_NA && *mode != dev->mode) {
+			printk(KERN_ERR
+			       "zmii%d: invalid mode %d specified for input %d\n",
+			       ocpdev->def->index, *mode, input);
+			return -EINVAL;
+		}
+	}
+
+	/* Report back correct PHY mode,
+	 * it may be used during PHY initialization.
+	 */
+	*mode = dev->mode;
+
+	/* Enable this input */
+	out_be32(&p->fer, in_be32(&p->fer) | zmii_mode_mask(dev->mode, input));
+      out:
+	++dev->users;
+	return 0;
+}
+
+int __init zmii_attach(void *emac)
+{
+	struct ocp_enet_private *dev = emac;
+	struct ocp_func_emac_data *emacdata = dev->def->additions;
+
+	if (emacdata->zmii_idx >= 0) {
+		dev->zmii_input = emacdata->zmii_mux;
+		dev->zmii_dev =
+		    ocp_find_device(OCP_VENDOR_IBM, OCP_FUNC_ZMII,
+				    emacdata->zmii_idx);
+		if (!dev->zmii_dev) {
+			printk(KERN_ERR "emac%d: unknown zmii%d!\n",
+			       dev->def->index, emacdata->zmii_idx);
+			return -ENODEV;
+		}
+		if (zmii_init
+		    (dev->zmii_dev, dev->zmii_input, &emacdata->phy_mode)) {
+			printk(KERN_ERR
+			       "emac%d: zmii%d initialization failed!\n",
+			       dev->def->index, emacdata->zmii_idx);
+			return -ENODEV;
+		}
+	}
+	return 0;
+}
+
+void __zmii_enable_mdio(struct ocp_device *ocpdev, int input)
+{
+	struct ibm_ocp_zmii *dev = ocp_get_drvdata(ocpdev);
+	u32 fer = in_be32(&dev->base->fer) & ~ZMII_FER_MDI_ALL;
+
+	ZMII_DBG2("%d: mdio(%d)" NL, ocpdev->def->index, input);
+
+	out_be32(&dev->base->fer, fer | ZMII_FER_MDI(input));
+}
+
+void __zmii_set_speed(struct ocp_device *ocpdev, int input, int speed)
+{
+	struct ibm_ocp_zmii *dev = ocp_get_drvdata(ocpdev);
+	u32 ssr = in_be32(&dev->base->ssr);
+
+	ZMII_DBG("%d: speed(%d, %d)" NL, ocpdev->def->index, input, speed);
+
+	if (speed == SPEED_100)
+		ssr |= ZMII_SSR_SP(input);
+	else
+		ssr &= ~ZMII_SSR_SP(input);
+
+	out_be32(&dev->base->ssr, ssr);
+}
+
+void __exit __zmii_fini(struct ocp_device *ocpdev, int input)
+{
+	struct ibm_ocp_zmii *dev = ocp_get_drvdata(ocpdev);
+	BUG_ON(!dev || dev->users == 0);
+
+	ZMII_DBG("%d: fini(%d)" NL, ocpdev->def->index, input);
+
+	/* Disable this input */
+	out_be32(&dev->base->fer,
+		 in_be32(&dev->base->fer) & ~zmii_mode_mask(dev->mode, input));
+
+	if (!--dev->users) {
+		/* Free everything if this is the last user */
+		ocp_set_drvdata(ocpdev, NULL);
+		iounmap((void *)dev->base);
+		kfree(dev);
+	}
+}
+
+int __zmii_get_regs_len(struct ocp_device *ocpdev)
+{
+	return sizeof(struct emac_ethtool_regs_subhdr) +
+	    sizeof(struct zmii_regs);
+}
+
+void *zmii_dump_regs(struct ocp_device *ocpdev, void *buf)
+{
+	struct ibm_ocp_zmii *dev = ocp_get_drvdata(ocpdev);
+	struct emac_ethtool_regs_subhdr *hdr = buf;
+	struct zmii_regs *regs = (struct zmii_regs *)(hdr + 1);
+
+	hdr->version = 0;
+	hdr->index = ocpdev->def->index;
+	memcpy_fromio(regs, dev->base, sizeof(struct zmii_regs));
+	return regs + 1;
+}
diff -puN drivers/net/ibm_emac/ibm_emac_zmii.h~new-powerpc-4xx-on-chip-ethernet-controller-driver drivers/net/ibm_emac/ibm_emac_zmii.h
--- devel/drivers/net/ibm_emac/ibm_emac_zmii.h~new-powerpc-4xx-on-chip-ethernet-controller-driver	2005-10-28 17:44:03.000000000 -0700
+++ devel-akpm/drivers/net/ibm_emac/ibm_emac_zmii.h	2005-10-28 17:44:03.000000000 -0700
@@ -1,23 +1,27 @@
 /*
- * ocp_zmii.h
+ * drivers/net/ibm_emac/ibm_emac_zmii.h
  *
- * Defines for the IBM ZMII bridge
+ * Driver for PowerPC 4xx on-chip ethernet controller, ZMII bridge support.
  *
- *      Armin Kuster akuster@mvista.com
- *      Dec, 2001
+ * Copyright (c) 2004, 2005 Zultys Technologies.
+ * Eugene Surovegin <eugene.surovegin@zultys.com> or <ebs@ebshome.net>
  *
- * Copyright 2001 MontaVista Softare Inc.
+ * Based on original work by
+ *      Armin Kuster <akuster@mvista.com>
+ * 	Copyright 2001 MontaVista Softare Inc.
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
  * Free Software Foundation;  either version 2 of the  License, or (at your
  * option) any later version.
+ *
  */
-
 #ifndef _IBM_EMAC_ZMII_H_
 #define _IBM_EMAC_ZMII_H_
 
 #include <linux/config.h>
+#include <linux/init.h>
+#include <asm/ocp.h>
 
 /* ZMII bridge registers */
 struct zmii_regs {
@@ -26,68 +30,54 @@ struct zmii_regs {
 	u32 smiirs;		/* SMII status reg */
 };
 
-#define ZMII_INPUTS	4
-
 /* ZMII device */
 struct ibm_ocp_zmii {
 	struct zmii_regs *base;
-	int mode[ZMII_INPUTS];
+	int mode;		/* subset of PHY_MODE_XXXX */
 	int users;		/* number of EMACs using this ZMII bridge */
+	u32 fer_save;		/* FER value left by firmware */
 };
 
-/* Fuctional Enable Reg */
-
-#define ZMII_FER_MASK(x)	(0xf0000000 >> (4*x))
+#ifdef CONFIG_IBM_EMAC_ZMII
+int zmii_attach(void *emac) __init;
 
-#define ZMII_MDI0	0x80000000
-#define ZMII_SMII0	0x40000000
-#define ZMII_RMII0	0x20000000
-#define ZMII_MII0	0x10000000
-#define ZMII_MDI1	0x08000000
-#define ZMII_SMII1	0x04000000
-#define ZMII_RMII1	0x02000000
-#define ZMII_MII1	0x01000000
-#define ZMII_MDI2	0x00800000
-#define ZMII_SMII2	0x00400000
-#define ZMII_RMII2	0x00200000
-#define ZMII_MII2	0x00100000
-#define ZMII_MDI3	0x00080000
-#define ZMII_SMII3	0x00040000
-#define ZMII_RMII3	0x00020000
-#define ZMII_MII3	0x00010000
-
-/* Speed Selection reg */
-
-#define ZMII_SCI0	0x40000000
-#define ZMII_FSS0	0x20000000
-#define ZMII_SP0	0x10000000
-#define ZMII_SCI1	0x04000000
-#define ZMII_FSS1	0x02000000
-#define ZMII_SP1	0x01000000
-#define ZMII_SCI2	0x00400000
-#define ZMII_FSS2	0x00200000
-#define ZMII_SP2	0x00100000
-#define ZMII_SCI3	0x00040000
-#define ZMII_FSS3	0x00020000
-#define ZMII_SP3	0x00010000
-
-#define ZMII_MII0_100MB	ZMII_SP0
-#define ZMII_MII0_10MB	~ZMII_SP0
-#define ZMII_MII1_100MB	ZMII_SP1
-#define ZMII_MII1_10MB	~ZMII_SP1
-#define ZMII_MII2_100MB	ZMII_SP2
-#define ZMII_MII2_10MB	~ZMII_SP2
-#define ZMII_MII3_100MB	ZMII_SP3
-#define ZMII_MII3_10MB	~ZMII_SP3
-
-/* SMII Status reg */
-
-#define ZMII_STS0 0xFF000000	/* EMAC0 smii status mask */
-#define ZMII_STS1 0x00FF0000	/* EMAC1 smii status mask */
-
-#define SMII	0
-#define RMII	1
-#define MII	2
-#define MDI	3
+void __zmii_fini(struct ocp_device *ocpdev, int input) __exit;
+static inline void zmii_fini(struct ocp_device *ocpdev, int input)
+{
+	if (ocpdev)
+		__zmii_fini(ocpdev, input);
+}
+
+void __zmii_enable_mdio(struct ocp_device *ocpdev, int input);
+static inline void zmii_enable_mdio(struct ocp_device *ocpdev, int input)
+{
+	if (ocpdev)
+		__zmii_enable_mdio(ocpdev, input);
+}
+
+void __zmii_set_speed(struct ocp_device *ocpdev, int input, int speed);
+static inline void zmii_set_speed(struct ocp_device *ocpdev, int input,
+				  int speed)
+{
+	if (ocpdev)
+		__zmii_set_speed(ocpdev, input, speed);
+}
+
+int __zmii_get_regs_len(struct ocp_device *ocpdev);
+static inline int zmii_get_regs_len(struct ocp_device *ocpdev)
+{
+	return ocpdev ? __zmii_get_regs_len(ocpdev) : 0;
+}
+
+void *zmii_dump_regs(struct ocp_device *ocpdev, void *buf);
+
+#else
+# define zmii_attach(x)		0
+# define zmii_fini(x,y)		((void)0)
+# define zmii_enable_mdio(x,y)	((void)0)
+# define zmii_set_speed(x,y,z)	((void)0)
+# define zmii_get_regs_len(x)	0
+# define zmii_dump_regs(x,buf)	(buf)
+#endif				/* !CONFIG_IBM_EMAC_ZMII */
 
 #endif				/* _IBM_EMAC_ZMII_H_ */
diff -puN drivers/net/ibm_emac/Makefile~new-powerpc-4xx-on-chip-ethernet-controller-driver drivers/net/ibm_emac/Makefile
--- devel/drivers/net/ibm_emac/Makefile~new-powerpc-4xx-on-chip-ethernet-controller-driver	2005-10-28 17:44:03.000000000 -0700
+++ devel-akpm/drivers/net/ibm_emac/Makefile	2005-10-28 17:44:03.000000000 -0700
@@ -1,12 +1,11 @@
 #
-# Makefile for the IBM PPC4xx EMAC controllers
+# Makefile for the PowerPC 4xx on-chip ethernet driver
 #
 
 obj-$(CONFIG_IBM_EMAC) += ibm_emac.o
 
 ibm_emac-objs := ibm_emac_mal.o ibm_emac_core.o ibm_emac_phy.o
-
-# Only need this if you want to see additional debug messages
-ifeq ($(CONFIG_IBM_EMAC_ERRMSG), y)
-ibm_emac-objs += ibm_emac_debug.o
-endif
+ibm_emac-$(CONFIG_IBM_EMAC_ZMII) += ibm_emac_zmii.o
+ibm_emac-$(CONFIG_IBM_EMAC_RGMII) += ibm_emac_rgmii.o
+ibm_emac-$(CONFIG_IBM_EMAC_TAH) += ibm_emac_tah.o
+ibm_emac-$(CONFIG_IBM_EMAC_DEBUG) += ibm_emac_debug.o
diff -puN drivers/net/Kconfig~new-powerpc-4xx-on-chip-ethernet-controller-driver drivers/net/Kconfig
--- devel/drivers/net/Kconfig~new-powerpc-4xx-on-chip-ethernet-controller-driver	2005-10-28 17:44:03.000000000 -0700
+++ devel-akpm/drivers/net/Kconfig	2005-10-28 17:44:03.000000000 -0700
@@ -1163,38 +1163,74 @@ config IBMVETH
 	  be called ibmveth.
 
 config IBM_EMAC
-	bool "IBM PPC4xx EMAC driver support"
+	tristate "PowerPC 4xx on-chip Ethernet support"
 	depends on 4xx
-	select CRC32
-	---help---
-	  This driver supports the IBM PPC4xx EMAC family of on-chip
-	  Ethernet controllers.
-
-config IBM_EMAC_ERRMSG
-	bool "Verbose error messages"
-	depends on IBM_EMAC && BROKEN
+	help
+	  This driver supports the PowerPC 4xx EMAC family of on-chip
+          Ethernet controllers.
 
 config IBM_EMAC_RXB
 	int "Number of receive buffers"
 	depends on IBM_EMAC
-	default "128" if IBM_EMAC4
-	default "64"
+	default "128"
 
 config IBM_EMAC_TXB
 	int "Number of transmit buffers"
 	depends on IBM_EMAC
-	default "128" if IBM_EMAC4
-	default "8"
+	default "64"
+
+config IBM_EMAC_POLL_WEIGHT
+	int "MAL NAPI polling weight"
+	depends on IBM_EMAC
+	default "32"
 
-config IBM_EMAC_FGAP
-	int "Frame gap"
+config IBM_EMAC_RX_COPY_THRESHOLD
+	int "RX skb copy threshold (bytes)"
 	depends on IBM_EMAC
-	default "8"
+	default "256"
 
-config IBM_EMAC_SKBRES
-	int "Skb reserve amount"
+config IBM_EMAC_RX_SKB_HEADROOM
+	int "Additional RX skb headroom (bytes)"
 	depends on IBM_EMAC
 	default "0"
+	help
+	  Additional receive skb headroom. Note, that driver
+	  will always reserve at least 2 bytes to make IP header
+	  aligned, so usualy there is no need to add any additional
+	  headroom.
+
+	  If unsure, set to 0.
+
+config IBM_EMAC_PHY_RX_CLK_FIX
+	bool "PHY Rx clock workaround"
+	depends on IBM_EMAC && (405EP || 440GX || 440EP)
+	help
+	  Enable this if EMAC attached to a PHY which doesn't generate
+	  RX clock if there is no link, if this is the case, you will
+	  see "TX disable timeout" or "RX disable timeout" in the system
+	  log.
+
+	  If unsure, say N.
+
+config IBM_EMAC_DEBUG
+	bool "Debugging"
+	depends on IBM_EMAC
+	default n
+
+config IBM_EMAC_ZMII
+	bool
+	depends on IBM_EMAC && (NP405H || NP405L || 44x)
+	default y
+
+config IBM_EMAC_RGMII
+	bool
+	depends on IBM_EMAC && 440GX
+	default y
+
+config IBM_EMAC_TAH
+	bool
+	depends on IBM_EMAC && 440GX
+	default y
 
 config NET_PCI
 	bool "EISA, VLB, PCI and on board controllers"
_
