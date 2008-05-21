Return-Path: <ncase@xes-inc.com>
Received: from xes-mad.com (xes-mad.com [216.165.139.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4DD32DF8E0
	for <linuxppc-dev@ozlabs.org>; Thu, 22 May 2008 07:29:04 +1000 (EST)
Subject: [PATCH 2/2] USB: isp1760: Support board-specific hardware
	configurations
From: Nate Case <ncase@xes-inc.com>
To: Sebastian Siewior <bigeasy@linutronix.de>
Content-Type: text/plain
Date: Wed, 21 May 2008 16:28:51 -0500
Message-Id: <1211405331.13845.628.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Greg Kroah-Hartman <gregkh@suse.de>,
	linux-usb@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This adds support for hardware configurations that don't match the
chip default register settings (e.g., 16-bit data bus, DACK and
DREQ pulled down instead of up, analog overcurrent mode).

These settings are passed in via the OF device tree.  The PCI
interface still assumes the same default values.

Signed-off-by: Nate Case <ncase@xes-inc.com>
---
 drivers/usb/host/isp1760-hcd.c |   68 +++++++++++++++++++++++++++++++--------
 drivers/usb/host/isp1760-hcd.h |   19 ++++++++++-
 drivers/usb/host/isp1760-if.c  |   34 +++++++++++++++++++-
 3 files changed, 103 insertions(+), 18 deletions(-)

diff --git a/drivers/usb/host/isp1760-hcd.c b/drivers/usb/host/isp1760-hcd.c
index 65aa5ec..679b8df 100644
--- a/drivers/usb/host/isp1760-hcd.c
+++ b/drivers/usb/host/isp1760-hcd.c
@@ -38,6 +38,7 @@ struct isp1760_hcd {
 	unsigned		i_thresh;
 	unsigned long		reset_done;
 	unsigned long		next_statechange;
+	unsigned int		devflags;
 };
 
 static inline struct isp1760_hcd *hcd_to_priv(struct usb_hcd *hcd)
@@ -378,9 +379,31 @@ static int isp1760_hc_setup(struct usb_hcd *hcd)
 {
 	struct isp1760_hcd *priv = hcd_to_priv(hcd);
 	int result;
-	u32 scratch;
+	u32 scratch, hwmode;
+
+	/* Setup HW Mode Control: This assumes a level active-low interrupt */
+	hwmode = HW_DATA_BUS_32BIT;
+
+	if (priv->devflags & ISP1760_FLAG_BUS_WIDTH_16)
+		hwmode &= ~HW_DATA_BUS_32BIT;
+	if (priv->devflags & ISP1760_FLAG_ANALOG_OC)
+		hwmode |= HW_ANA_DIGI_OC;
+	if (priv->devflags & ISP1760_FLAG_DACK_POL_HIGH)
+		hwmode |= HW_DACK_POL_HIGH;
+	if (priv->devflags & ISP1760_FLAG_DREQ_POL_HIGH)
+		hwmode |= HW_DREQ_POL_HIGH;
+
+	/*
+	 * We have to set this first in case we're in 16-bit mode.
+	 * Write it twice to ensure correct upper bits if switching
+	 * to 16-bit mode.
+	 */
+	isp1760_writel(hwmode, hcd->regs + HC_HW_MODE_CTRL);
+	isp1760_writel(hwmode, hcd->regs + HC_HW_MODE_CTRL);
 
 	isp1760_writel(0xdeadbabe, hcd->regs + HC_SCRATCH_REG);
+	/* Change bus pattern */
+	scratch = isp1760_readl(hcd->regs + HC_CHIP_ID_REG);
 	scratch = isp1760_readl(hcd->regs + HC_SCRATCH_REG);
 	if (scratch != 0xdeadbabe) {
 		printk(KERN_ERR "ISP1760: Scratch test failed.\n");
@@ -403,17 +426,30 @@ static int isp1760_hc_setup(struct usb_hcd *hcd)
 
 	/* Step 11 passed */
 
-	isp1760_writel(INTERRUPT_ENABLE_MASK, hcd->regs + HC_INTERRUPT_REG);
-	isp1760_writel(INTERRUPT_ENABLE_MASK, hcd->regs + HC_INTERRUPT_ENABLE);
+	isp1760_info(priv, "bus width: %d, oc: %s\n",
+			   (priv->devflags & ISP1760_FLAG_BUS_WIDTH_16) ?
+			   16 : 32, (priv->devflags & ISP1760_FLAG_ANALOG_OC) ?
+			   "analog" : "digital");
 
 	/* ATL reset */
-	scratch = isp1760_readl(hcd->regs + HC_HW_MODE_CTRL);
-	isp1760_writel(scratch | ALL_ATX_RESET, hcd->regs + HC_HW_MODE_CTRL);
+	isp1760_writel(hwmode | ALL_ATX_RESET, hcd->regs + HC_HW_MODE_CTRL);
 	mdelay(10);
-	isp1760_writel(scratch, hcd->regs + HC_HW_MODE_CTRL);
+	isp1760_writel(hwmode, hcd->regs + HC_HW_MODE_CTRL);
 
-	isp1760_writel(PORT1_POWER | PORT1_INIT2, hcd->regs + HC_PORT1_CTRL);
-	mdelay(10);
+	isp1760_writel(INTERRUPT_ENABLE_MASK, hcd->regs + HC_INTERRUPT_REG);
+	isp1760_writel(INTERRUPT_ENABLE_MASK, hcd->regs + HC_INTERRUPT_ENABLE);
+
+	/*
+	 * PORT 1 Control register of the ISP1760 is the OTG control
+	 * register on ISP1761.
+	 */
+	scratch = isp1760_readl(hcd->regs + HC_CHIP_ID_REG);
+	if (((scratch & 0xffff) == 0x1760) &&
+	    !(priv->devflags & ISP1760_FLAG_PORT1_DIS)) {
+		isp1760_writel(PORT1_POWER | PORT1_INIT2,
+			       hcd->regs + HC_PORT1_CTRL);
+		mdelay(10);
+	}
 
 	priv->hcs_params = isp1760_readl(hcd->regs + HC_HCSPARAMS);
 
@@ -453,8 +489,7 @@ static int isp1760_run(struct usb_hcd *hcd)
 	hcd->state = HC_STATE_RUNNING;
 	isp1760_enable_interrupts(hcd);
 	temp = isp1760_readl(hcd->regs + HC_HW_MODE_CTRL);
-	temp |= FINAL_HW_CONFIG;
-	isp1760_writel(temp, hcd->regs + HC_HW_MODE_CTRL);
+	isp1760_writel(temp | HW_GLOBAL_INTR_EN, hcd->regs + HC_HW_MODE_CTRL);
 
 	command = isp1760_readl(hcd->regs + HC_USBCMD);
 	command &= ~(CMD_LRESET|CMD_RESET);
@@ -2112,6 +2147,7 @@ static int isp1760_get_frame(struct usb_hcd *hcd)
 static void isp1760_stop(struct usb_hcd *hcd)
 {
 	struct isp1760_hcd *priv = hcd_to_priv(hcd);
+	u32 temp;
 
 	isp1760_hub_control(hcd, ClearPortFeature, USB_PORT_FEAT_POWER,	1,
 			NULL, 0);
@@ -2120,7 +2156,8 @@ static void isp1760_stop(struct usb_hcd *hcd)
 	spin_lock_irq(&priv->lock);
 	ehci_reset(priv);
 	/* Disable IRQ */
-	isp1760_writel(HW_DATA_BUS_32BIT, hcd->regs + HC_HW_MODE_CTRL);
+	temp = isp1760_readl(hcd->regs + HC_HW_MODE_CTRL);
+	isp1760_writel(temp &= ~HW_GLOBAL_INTR_EN, hcd->regs + HC_HW_MODE_CTRL);
 	spin_unlock_irq(&priv->lock);
 
 	isp1760_writel(0, hcd->regs + HC_CONFIGFLAG);
@@ -2128,10 +2165,11 @@ static void isp1760_stop(struct usb_hcd *hcd)
 
 static void isp1760_shutdown(struct usb_hcd *hcd)
 {
-	u32 command;
+	u32 command, temp;
 
 	isp1760_stop(hcd);
-	isp1760_writel(HW_DATA_BUS_32BIT, hcd->regs + HC_HW_MODE_CTRL);
+	temp = isp1760_readl(hcd->regs + HC_HW_MODE_CTRL);
+	isp1760_writel(temp &= ~HW_GLOBAL_INTR_EN, hcd->regs + HC_HW_MODE_CTRL);
 
 	command = isp1760_readl(hcd->regs + HC_USBCMD);
 	command &= ~CMD_RUN;
@@ -2183,7 +2221,8 @@ void deinit_kmem_cache(void)
 }
 
 struct usb_hcd *isp1760_register(u64 res_start, u64 res_len, int irq,
-		u64 irqflags, struct device *dev, const char *busname)
+		u64 irqflags, struct device *dev, const char *busname,
+		unsigned int devflags)
 {
 	struct usb_hcd *hcd;
 	struct isp1760_hcd *priv;
@@ -2200,6 +2239,7 @@ struct usb_hcd *isp1760_register(u64 res_start, u64 res_len, int irq,
 		return ERR_PTR(-ENOMEM);
 
 	priv = hcd_to_priv(hcd);
+	priv->devflags = devflags;
 	init_memory(priv);
 	hcd->regs = ioremap(res_start, res_len);
 	if (!hcd->regs) {
diff --git a/drivers/usb/host/isp1760-hcd.h b/drivers/usb/host/isp1760-hcd.h
index 3d86d0f..732fb2a 100644
--- a/drivers/usb/host/isp1760-hcd.h
+++ b/drivers/usb/host/isp1760-hcd.h
@@ -3,7 +3,8 @@
 
 /* exports for if */
 struct usb_hcd *isp1760_register(u64 res_start, u64 res_len, int irq,
-		u64 irqflags, struct device *dev, const char *busname);
+		u64 irqflags, struct device *dev, const char *busname,
+		unsigned int devflags);
 int init_kmem_once(void);
 void deinit_kmem_cache(void);
 
@@ -31,6 +32,7 @@ void deinit_kmem_cache(void);
 /* Configuration Register */
 #define HC_HW_MODE_CTRL		0x300
 #define ALL_ATX_RESET		(1 << 31)
+#define HW_ANA_DIGI_OC		(1 << 15)
 #define HW_DATA_BUS_32BIT	(1 << 8)
 #define HW_DACK_POL_HIGH	(1 << 6)
 #define HW_DREQ_POL_HIGH	(1 << 5)
@@ -56,13 +58,14 @@ void deinit_kmem_cache(void);
 #define PORT1_POWER		(3 << 3)
 #define PORT1_INIT1		(1 << 7)
 #define PORT1_INIT2		(1 << 23)
+#define HW_OTG_CTRL_SET		0x374
+#define HW_OTG_CTRL_CLR		0x376
 
 /* Interrupt Register */
 #define HC_INTERRUPT_REG	0x310
 
 #define HC_INTERRUPT_ENABLE	0x314
 #define INTERRUPT_ENABLE_MASK	(HC_INTL_INT | HC_ATL_INT | HC_EOT_INT)
-#define FINAL_HW_CONFIG	(HW_GLOBAL_INTR_EN | HW_DATA_BUS_32BIT)
 
 #define HC_ISO_INT		(1 << 9)
 #define HC_ATL_INT		(1 << 8)
@@ -122,6 +125,18 @@ typedef void (packet_enqueue)(struct usb_hcd *hcd, struct isp1760_qh *qh,
 #define isp1760_err(priv, fmt, args...) \
 	dev_err(priv_to_hcd(priv)->self.controller, fmt, ##args)
 
+/*
+ * Device flags that can vary from board to board.  All of these
+ * indicate the most "atypical" case, so that a devflags of 0 is
+ * a sane default configuration.
+ */
+#define ISP1760_FLAG_PORT1_DIS		0x00000001 /* Port 1 disabled */
+#define ISP1760_FLAG_BUS_WIDTH_16	0x00000002 /* 16-bit data bus width */
+#define ISP1760_FLAG_OTG_EN		0x00000004 /* Port 1 supports OTG */
+#define ISP1760_FLAG_ANALOG_OC		0x00000008 /* Analog overcurrent */
+#define ISP1760_FLAG_DACK_POL_HIGH	0x00000010 /* DACK active high */
+#define ISP1760_FLAG_DREQ_POL_HIGH	0x00000020 /* DREQ active high */
+
 /* chip memory management */
 struct memory_chunk {
 	unsigned int start;
diff --git a/drivers/usb/host/isp1760-if.c b/drivers/usb/host/isp1760-if.c
index 440bf94..c50c3f5 100644
--- a/drivers/usb/host/isp1760-if.c
+++ b/drivers/usb/host/isp1760-if.c
@@ -35,6 +35,8 @@ static int of_isp1760_probe(struct of_device *dev,
 	int virq;
 	u64 res_len;
 	int ret;
+	const unsigned int *prop;
+	unsigned int devflags = 0;
 
 	ret = of_address_to_resource(dp, 0, &memory);
 	if (ret)
@@ -55,8 +57,34 @@ static int of_isp1760_probe(struct of_device *dev,
 	virq = irq_create_of_mapping(oirq.controller, oirq.specifier,
 			oirq.size);
 
+	prop = of_get_property(dp, "port1-disable", NULL);
+	if (prop && *prop != 0)
+		devflags |= ISP1760_FLAG_PORT1_DIS;
+
+	/* Some systems wire up only 16 of the 32 data lines */
+	prop = of_get_property(dp, "bus-width", NULL);
+	if (prop && *prop == 16)
+		devflags |= ISP1760_FLAG_BUS_WIDTH_16;
+
+	prop = of_get_property(dp, "port1-otg", NULL);
+	if (prop && *prop != 0)
+		devflags |= ISP1760_FLAG_OTG_EN;
+
+	prop = of_get_property(dp, "analog-oc", NULL);
+	if (prop && *prop != 0)
+		devflags |= ISP1760_FLAG_ANALOG_OC;
+
+	prop = of_get_property(dp, "dack-polarity", NULL);
+	if (prop && *prop != 0)
+		devflags |= ISP1760_FLAG_DACK_POL_HIGH;
+
+	prop = of_get_property(dp, "dreq-polarity", NULL);
+	if (prop && *prop != 0)
+		devflags |= ISP1760_FLAG_DREQ_POL_HIGH;
+
 	hcd = isp1760_register(memory.start, res_len, virq,
-		IRQF_SHARED | IRQF_DISABLED, &dev->dev, dev->dev.bus_id);
+		IRQF_SHARED | IRQF_DISABLED, &dev->dev, dev->dev.bus_id,
+		devflags);
 	if (IS_ERR(hcd)) {
 		ret = PTR_ERR(hcd);
 		goto release_reg;
@@ -116,6 +144,7 @@ static int __devinit isp1761_pci_probe(struct pci_dev *dev,
 	int length;
 	int status = 1;
 	struct usb_hcd *hcd;
+	unsigned int devflags = 0;
 
 	if (usb_disabled())
 		return -ENODEV;
@@ -200,7 +229,8 @@ static int __devinit isp1761_pci_probe(struct pci_dev *dev,
 
 	dev->dev.dma_mask = NULL;
 	hcd = isp1760_register(pci_mem_phy0, length, dev->irq,
-		IRQF_SHARED | IRQF_DISABLED, &dev->dev, dev->dev.bus_id);
+		IRQF_SHARED | IRQF_DISABLED, &dev->dev, dev->dev.bus_id,
+		devflags);
 	pci_set_drvdata(dev, hcd);
 	if (!hcd)
 		return 0;
-- 
1.5.4.4
