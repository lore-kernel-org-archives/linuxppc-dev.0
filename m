Return-Path: <grant.likely@secretlab.ca>
Received: from sandbox.secretlab.ca (S01060016b61d1226.cg.shawcable.net
	[68.147.67.118]) by ozlabs.org (Postfix) with ESMTP id BD349DDE1D
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Jun 2007 09:26:45 +1000 (EST)
From: Grant Likely <grant.likely@secretlab.ca>
To: Peter Korsgaard <jacmet@sunsite.dk>, linux-usb-devel@lists.sourceforge.net,
	linuxppc-embedded@ozlabs.org
Subject: [PATCH 5/6] [C67x00] Change 'struct c67x00_drv' to 'struct
	c67x00_device'
Date: Tue, 12 Jun 2007 17:02:20 -0600
Message-Id: <11816893503814-git-send-email-grant.likely@secretlab.ca>
In-Reply-To: <1181689350166-git-send-email-grant.likely@secretlab.ca>
References: <11816893411272-git-send-email-grant.likely@secretlab.ca>
	<11816893494143-git-send-email-grant.likely@secretlab.ca>
	<11816893492706-git-send-email-grant.likely@secretlab.ca>
	<11816893493783-git-send-email-grant.likely@secretlab.ca>
	<1181689350166-git-send-email-grant.likely@secretlab.ca>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

The structure describes per-device data, not per driver data.  Convention
seems to be to use the _device suffix for this kind of structure.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---
 drivers/usb/c67x00/c67x00-drv.c    |  102 +++++++-------
 drivers/usb/c67x00/c67x00-drv.h    |   10 +-
 drivers/usb/c67x00/c67x00-hcd.c    |    4 +-
 drivers/usb/c67x00/c67x00-hub.c    |    2 +-
 drivers/usb/c67x00/c67x00-ll-hpi.c |  266 ++++++++++++++++++------------------
 drivers/usb/c67x00/c67x00-ll-hpi.h |   28 ++--
 drivers/usb/c67x00/c67x00-sched.c  |   10 +-
 7 files changed, 211 insertions(+), 211 deletions(-)

diff --git a/drivers/usb/c67x00/c67x00-drv.c b/drivers/usb/c67x00/c67x00-drv.c
index 2737344..fe29734 100644
--- a/drivers/usb/c67x00/c67x00-drv.c
+++ b/drivers/usb/c67x00/c67x00-drv.c
@@ -51,7 +51,7 @@ static struct platform_driver c67x00_driver;
 /* -------------------------------------------------------------------------- */
 
 static void setup_sie(struct c67x00_sie *sie,
-		      struct c67x00_drv *drv, int sie_num)
+		      struct c67x00_device *dev, int sie_num)
 {
 	static unsigned int id = 0;
 
@@ -61,9 +61,9 @@ static void setup_sie(struct c67x00_sie *sie,
 	/* driver used in hub.c: hub_port_init */
 	sie->pdev->dev.driver = &c67x00_driver.driver;
 	spin_lock_init(&sie->lock);
-	sie->drv = drv;
+	sie->dev = dev;
 	sie->sie_num = sie_num;
-	sie->mode = c67x00_sie_config(drv->pdata->sie_config, sie_num);
+	sie->mode = c67x00_sie_config(dev->pdata->sie_config, sie_num);
 }
 
 static void teardown_sie(struct c67x00_sie *sie)
@@ -76,7 +76,7 @@ static void teardown_sie(struct c67x00_sie *sie)
 
 static void probe_sie(struct c67x00_sie *sie)
 {
-	switch (c67x00_sie_config(sie->drv->pdata->sie_config, sie->sie_num)) {
+	switch (c67x00_sie_config(sie->dev->pdata->sie_config, sie->sie_num)) {
 	case C67X00_SIE_HOST:
 		usb_hcd_c67x00_probe(sie);
 		break;
@@ -93,7 +93,7 @@ static void probe_sie(struct c67x00_sie *sie)
 	default:
 		dev_err(sie_dev(sie),
 			"Unsupported configuration: 0x%x for SIE %d\n",
-			c67x00_sie_config(sie->drv->pdata->sie_config,
+			c67x00_sie_config(sie->dev->pdata->sie_config,
 					  sie->sie_num), sie->sie_num);
 		break;
 	}
@@ -101,7 +101,7 @@ static void probe_sie(struct c67x00_sie *sie)
 
 static void remove_sie(struct c67x00_sie *sie)
 {
-	switch (c67x00_sie_config(sie->drv->pdata->sie_config, sie->sie_num)) {
+	switch (c67x00_sie_config(sie->dev->pdata->sie_config, sie->sie_num)) {
 	case C67X00_SIE_HOST:
 		usb_hcd_c67x00_remove(sie);
 		break;
@@ -117,36 +117,36 @@ static void remove_sie(struct c67x00_sie *sie)
 
 /* -------------------------------------------------------------------------- */
 
-static irqreturn_t c67x00_irq(int irq, void *__drv)
+static irqreturn_t c67x00_irq(int irq, void *__dev)
 {
-	struct c67x00_drv *drv = __drv;
+	struct c67x00_device *dev = __dev;
 	int i, count = 8;
 
-	drv->int_status = c67x00_hpi_status(drv);
-	if (!drv->int_status)
+	dev->int_status = c67x00_hpi_status(dev);
+	if (!dev->int_status)
 		return IRQ_NONE;
 
-	while (drv->int_status != 0 && (count-- >= 0)) {
-		c67x00_ll_irq(drv);
+	while (dev->int_status != 0 && (count-- >= 0)) {
+		c67x00_ll_irq(dev);
 		for (i = 0; i < C67X00_SIES; i++) {
-			spin_lock(&drv->sie[i].lock);
-			if (drv->int_status & SIEMSG_FLAG(i)) {
+			spin_lock(&dev->sie[i].lock);
+			if (dev->int_status & SIEMSG_FLAG(i)) {
 				u16 msg;
-				msg = c67x00_ll_get_siemsg(drv, i);
-				if (drv->sie[i].msg_received)
-					drv->sie[i].msg_received(&drv->sie[i],
+				msg = c67x00_ll_get_siemsg(dev, i);
+				if (dev->sie[i].msg_received)
+					dev->sie[i].msg_received(&dev->sie[i],
 								 msg);
 			}
-			if (drv->sie[i].irq)
-				drv->sie[i].irq(irq, &drv->sie[i]);
-			spin_unlock(&drv->sie[i].lock);
+			if (dev->sie[i].irq)
+				dev->sie[i].irq(irq, &dev->sie[i]);
+			spin_unlock(&dev->sie[i].lock);
 		}
-		drv->int_status = c67x00_hpi_status(drv);
+		dev->int_status = c67x00_hpi_status(dev);
 	}
 
-	if (drv->int_status)
-		dev_warn(&drv->pdev->dev, "Not all interrupts handled! "
-			 "status = 0x%04x\n", drv->int_status);
+	if (dev->int_status)
+		dev_warn(&dev->pdev->dev, "Not all interrupts handled! "
+			 "status = 0x%04x\n", dev->int_status);
 
 	return IRQ_HANDLED;
 }
@@ -155,7 +155,7 @@ static irqreturn_t c67x00_irq(int irq, void *__drv)
 
 static int __devinit usb_c67x00_drv_probe(struct platform_device *pdev)
 {
-	struct c67x00_drv *drv;
+	struct c67x00_device *dev;
 	struct c67x00_platform_data *pdata;
 	struct resource *res, *res2;
 	int ret, i;
@@ -172,8 +172,8 @@ static int __devinit usb_c67x00_drv_probe(struct platform_device *pdev)
 	if (!pdata)
 		return -ENODEV;
 
-	drv = kzalloc(sizeof(*drv), GFP_KERNEL);
-	if (!drv)
+	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
+	if (!dev)
 		return -ENOMEM;
 
 	if (!request_mem_region(res->start, res->end - res->start + 1,
@@ -182,82 +182,82 @@ static int __devinit usb_c67x00_drv_probe(struct platform_device *pdev)
 		ret = -EBUSY;
 		goto request_mem_failed;
 	}
-	drv->hpi.base = ioremap(res->start, res->end - res->start + 1);
-	if (!drv->hpi.base) {
+	dev->hpi.base = ioremap(res->start, res->end - res->start + 1);
+	if (!dev->hpi.base) {
 		dev_err(&pdev->dev, "Unable to map HPI registers\n");
 		ret = -EIO;
 		goto map_failed;
 	}
 
-	spin_lock_init(&drv->hw_lock);
-	drv->hpi.regstep = pdata->hpi_regstep;
-	drv->pdata = pdev->dev.platform_data;
-	drv->pdev = pdev;
+	spin_lock_init(&dev->hw_lock);
+	dev->hpi.regstep = pdata->hpi_regstep;
+	dev->pdata = pdev->dev.platform_data;
+	dev->pdev = pdev;
 
 	for (i = 0; i < C67X00_SIES; i++)
-		setup_sie(&drv->sie[i], drv, i);
+		setup_sie(&dev->sie[i], dev, i);
 
-	c67x00_ll_init(drv);
-	c67x00_ll_hpi_reg_init(drv);
+	c67x00_ll_init(dev);
+	c67x00_ll_hpi_reg_init(dev);
 
 	dev_info(&pdev->dev, "USB OTG controller, p:0x%x, v:0x%p, irq:%i\n",
-	         res->start, drv->hpi.base, res2->start);
+	         res->start, dev->hpi.base, res2->start);
 
-	ret = request_irq(res2->start, c67x00_irq, 0, pdev->name, drv);
+	ret = request_irq(res2->start, c67x00_irq, 0, pdev->name, dev);
 	if (ret) {
 		dev_err(&pdev->dev, "Cannot claim IRQ\n");
 		goto request_irq_failed;
 	}
 
-	ret = c67x00_ll_reset(drv);
+	ret = c67x00_ll_reset(dev);
 	if (ret) {
 		dev_err(&pdev->dev, "Device reset failed\n");
 		goto reset_failed;
 	}
 
 	for (i = 0; i < C67X00_SIES; i++)
-		probe_sie(&drv->sie[i]);
+		probe_sie(&dev->sie[i]);
 
-	platform_set_drvdata(pdev, drv);
+	platform_set_drvdata(pdev, dev);
 
 	return 0;
 
 reset_failed:
-	free_irq(res2->start, drv);
+	free_irq(res2->start, dev);
 request_irq_failed:
-	iounmap(drv->hpi.base);
+	iounmap(dev->hpi.base);
 map_failed:
 	release_mem_region(res->start, res->end - res->start + 1);
 request_mem_failed:
-	kfree(drv);
+	kfree(dev);
 
 	return ret;
 }
 
 static int __devexit usb_c67x00_drv_remove(struct platform_device *pdev)
 {
-	struct c67x00_drv *drv = platform_get_drvdata(pdev);
+	struct c67x00_device *dev = platform_get_drvdata(pdev);
 	struct resource *res;
 	int i;
 
 	for (i = 0; i < C67X00_SIES; i++) {
-		remove_sie(&drv->sie[i]);
-		teardown_sie(&drv->sie[i]);
+		remove_sie(&dev->sie[i]);
+		teardown_sie(&dev->sie[i]);
 	}
 
-	c67x00_ll_release(drv);
+	c67x00_ll_release(dev);
 
 	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
 	if (res)
-		free_irq(res->start, drv);
+		free_irq(res->start, dev);
 
-	iounmap(drv->hpi.base);
+	iounmap(dev->hpi.base);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (res)
 		release_mem_region(res->start, res->end - res->start + 1);
 
-	kfree(drv);
+	kfree(dev);
 
 	return 0;
 }
diff --git a/drivers/usb/c67x00/c67x00-drv.h b/drivers/usb/c67x00/c67x00-drv.h
index 8e7b99c..d29f4ad 100644
--- a/drivers/usb/c67x00/c67x00-drv.h
+++ b/drivers/usb/c67x00/c67x00-drv.h
@@ -31,7 +31,7 @@
 #include <linux/workqueue.h>
 #include "c67x00-ll-hpi.h"
 
-struct c67x00_drv;
+struct c67x00_device;
 
 /**
  * struct c67x00_sie - Common data associated with an SIE
@@ -40,7 +40,7 @@ struct c67x00_drv;
  * @pdev: platform device associated with this SIE, created in c67x00-drv.c
  * @irq: subdriver depenent irq handler, set NULL when not used
  * @msg_received: called when an SIEmsg has been received
- * @drv: link to common driver structure
+ * @dev: link to common driver structure
  * @sie_num: SIE number on chip, starting from 0
  * @mode: SIE mode (host/peripheral/otg/not used)
  *
@@ -57,7 +57,7 @@ struct c67x00_sie {
 	void (*msg_received) (struct c67x00_sie * sie, u16 msg);
 
 	/* Read only: */
-	struct c67x00_drv *drv;
+	struct c67x00_device *dev;
 	int sie_num;
 	int mode;
 };
@@ -73,7 +73,7 @@ struct c67x00_hpi {
 #define C67X00_PORTS	2
 
 /**
- * struct c67x00_drv - Common data structure associated with a c67x00 instance
+ * struct c67x00_device - Common data structure associated with a c67x00 instance
  * @hpi: hpi addresses
  * @sie: array of sie's on this chip
  * @pdata: configuration provided by the platform
@@ -81,7 +81,7 @@ struct c67x00_hpi {
  * @int_status: interrupt status register, only valid in_interrupt()
  * @lcp: lcp dependent data
  */
-struct c67x00_drv {
+struct c67x00_device {
 	struct c67x00_hpi hpi;
 	struct c67x00_sie sie[C67X00_SIES];
 	struct platform_device *pdev;
diff --git a/drivers/usb/c67x00/c67x00-hcd.c b/drivers/usb/c67x00/c67x00-hcd.c
index 357e34f..d5458ea 100644
--- a/drivers/usb/c67x00/c67x00-hcd.c
+++ b/drivers/usb/c67x00/c67x00-hcd.c
@@ -51,9 +51,9 @@ static irqreturn_t c67x00_hcd_irq(struct usb_hcd *hcd)
 {
 	struct c67x00_hcd *c67x00 = hcd_to_c67x00_hcd(hcd);
 	struct c67x00_sie *sie = c67x00->sie;
-	struct c67x00_drv *drv = sie->drv;
+	struct c67x00_device *dev = sie->dev;
 	int host = sie->sie_num;
-	if (drv->int_status & SOFEOP_FLG(host)) {
+	if (dev->int_status & SOFEOP_FLG(host)) {
 		c67x00_ll_husb_clear_status(sie, SOF_EOP_IRQ_FLG);
 		c67x00_sched_sofeop(c67x00);
 		return IRQ_HANDLED;
diff --git a/drivers/usb/c67x00/c67x00-hub.c b/drivers/usb/c67x00/c67x00-hub.c
index 91ad898..2518106 100644
--- a/drivers/usb/c67x00/c67x00-hub.c
+++ b/drivers/usb/c67x00/c67x00-hub.c
@@ -50,7 +50,7 @@ static void reset_host_port(struct c67x00_sie *sie, int port)
 	c67x00_ll_husb_reset_port(sie, port);
 	spin_unlock_irqrestore(&c67x00->lock, flags);
 
-	c67x00_ll_set_husb_eot(sie->drv, DEFAULT_EOT);
+	c67x00_ll_set_husb_eot(sie->dev, DEFAULT_EOT);
 }
 
 /* -------------------------------------------------------------------------- */
diff --git a/drivers/usb/c67x00/c67x00-ll-hpi.c b/drivers/usb/c67x00/c67x00-ll-hpi.c
index 868736a..052f35d 100644
--- a/drivers/usb/c67x00/c67x00-ll-hpi.c
+++ b/drivers/usb/c67x00/c67x00-ll-hpi.c
@@ -65,250 +65,250 @@
 
 /* These functions could also be implemented with SPI of HSS.
  * This is currently not supported */
-static inline u16 hpi_read_reg(struct c67x00_drv *drv, int reg)
+static inline u16 hpi_read_reg(struct c67x00_device *dev, int reg)
 {
-	return __raw_readw(drv->hpi.base + reg * drv->hpi.regstep);
+	return __raw_readw(dev->hpi.base + reg * dev->hpi.regstep);
 }
 
-static inline void hpi_write_reg(struct c67x00_drv *drv, int reg, u16 value)
+static inline void hpi_write_reg(struct c67x00_device *dev, int reg, u16 value)
 {
-	__raw_writew(value, drv->hpi.base + reg * drv->hpi.regstep);
+	__raw_writew(value, dev->hpi.base + reg * dev->hpi.regstep);
 }
 
-static inline u16 hpi_read_word_nolock(struct c67x00_drv *drv, u16 reg)
+static inline u16 hpi_read_word_nolock(struct c67x00_device *dev, u16 reg)
 {
-	hpi_write_reg(drv, HPI_ADDR, reg);
-	return hpi_read_reg(drv, HPI_DATA);
+	hpi_write_reg(dev, HPI_ADDR, reg);
+	return hpi_read_reg(dev, HPI_DATA);
 }
 
-static inline u16 hpi_read_word(struct c67x00_drv *drv, u16 reg)
+static inline u16 hpi_read_word(struct c67x00_device *dev, u16 reg)
 {
 	u16 value;
 	unsigned long flags;
 
-	spin_lock_irqsave(&drv->hw_lock, flags);
-	value = hpi_read_word_nolock(drv, reg);
-	spin_unlock_irqrestore(&drv->hw_lock, flags);
+	spin_lock_irqsave(&dev->hw_lock, flags);
+	value = hpi_read_word_nolock(dev, reg);
+	spin_unlock_irqrestore(&dev->hw_lock, flags);
 
 	return value;
 }
 
-static inline void hpi_write_word_nolock(struct c67x00_drv *drv, u16 reg,
+static inline void hpi_write_word_nolock(struct c67x00_device *dev, u16 reg,
 					 u16 value)
 {
-	hpi_write_reg(drv, HPI_ADDR, reg);
-	hpi_write_reg(drv, HPI_DATA, value);
+	hpi_write_reg(dev, HPI_ADDR, reg);
+	hpi_write_reg(dev, HPI_DATA, value);
 }
 
-static inline void hpi_write_word(struct c67x00_drv *drv, u16 reg, u16 value)
+static inline void hpi_write_word(struct c67x00_device *dev, u16 reg, u16 value)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&drv->hw_lock, flags);
-	hpi_write_word_nolock(drv, reg, value);
-	spin_unlock_irqrestore(&drv->hw_lock, flags);
+	spin_lock_irqsave(&dev->hw_lock, flags);
+	hpi_write_word_nolock(dev, reg, value);
+	spin_unlock_irqrestore(&dev->hw_lock, flags);
 }
 
 /*
  * Only data is little endian, addr has cpu endianess
  */
-static inline void hpi_write_words_le16(struct c67x00_drv *drv, u16 addr,
+static inline void hpi_write_words_le16(struct c67x00_device *dev, u16 addr,
 					u16 * data, u16 count)
 {
 	unsigned long flags;
 	int i;
 
-	spin_lock_irqsave(&drv->hw_lock, flags);
+	spin_lock_irqsave(&dev->hw_lock, flags);
 
-	hpi_write_reg(drv, HPI_ADDR, addr);
+	hpi_write_reg(dev, HPI_ADDR, addr);
 	for (i = 0; i < count; i++)
-		hpi_write_reg(drv, HPI_DATA, cpu_to_le16(*data++));
+		hpi_write_reg(dev, HPI_DATA, cpu_to_le16(*data++));
 
-	spin_unlock_irqrestore(&drv->hw_lock, flags);
+	spin_unlock_irqrestore(&dev->hw_lock, flags);
 }
 
 /*
  * Only data is little endian, addr has cpu endianess
  */
-static inline void hpi_read_words_le16(struct c67x00_drv *drv, u16 addr,
+static inline void hpi_read_words_le16(struct c67x00_device *dev, u16 addr,
 				       u16 * data, u16 count)
 {
 	unsigned long flags;
 	int i;
-	spin_lock_irqsave(&drv->hw_lock, flags);
-	hpi_write_reg(drv, HPI_ADDR, addr);
+	spin_lock_irqsave(&dev->hw_lock, flags);
+	hpi_write_reg(dev, HPI_ADDR, addr);
 	for (i = 0; i < count; i++)
-		*data++ = le16_to_cpu(hpi_read_reg(drv, HPI_DATA));
+		*data++ = le16_to_cpu(hpi_read_reg(dev, HPI_DATA));
 
-	spin_unlock_irqrestore(&drv->hw_lock, flags);
+	spin_unlock_irqrestore(&dev->hw_lock, flags);
 }
 
-static inline void hpi_set_bits(struct c67x00_drv *drv, u16 reg, u16 mask)
+static inline void hpi_set_bits(struct c67x00_device *dev, u16 reg, u16 mask)
 {
 	u16 value;
 	unsigned long flags;
 
-	spin_lock_irqsave(&drv->hw_lock, flags);
-	value = hpi_read_word_nolock(drv, reg);
-	hpi_write_word_nolock(drv, reg, value | mask);
-	spin_unlock_irqrestore(&drv->hw_lock, flags);
+	spin_lock_irqsave(&dev->hw_lock, flags);
+	value = hpi_read_word_nolock(dev, reg);
+	hpi_write_word_nolock(dev, reg, value | mask);
+	spin_unlock_irqrestore(&dev->hw_lock, flags);
 }
 
-static inline void hpi_clear_bits(struct c67x00_drv *drv, u16 reg, u16 mask)
+static inline void hpi_clear_bits(struct c67x00_device *dev, u16 reg, u16 mask)
 {
 	u16 value;
 	unsigned long flags;
 
-	spin_lock_irqsave(&drv->hw_lock, flags);
-	value = hpi_read_word_nolock(drv, reg);
-	hpi_write_word_nolock(drv, reg, value & ~mask);
-	spin_unlock_irqrestore(&drv->hw_lock, flags);
+	spin_lock_irqsave(&dev->hw_lock, flags);
+	value = hpi_read_word_nolock(dev, reg);
+	hpi_write_word_nolock(dev, reg, value & ~mask);
+	spin_unlock_irqrestore(&dev->hw_lock, flags);
 }
 
-static inline u16 hpi_recv_mbox(struct c67x00_drv *drv)
+static inline u16 hpi_recv_mbox(struct c67x00_device *dev)
 {
 	u16 value;
 	unsigned long flags;
 
-	spin_lock_irqsave(&drv->hw_lock, flags);
-	value = hpi_read_reg(drv, HPI_MAILBOX);
-	spin_unlock_irqrestore(&drv->hw_lock, flags);
+	spin_lock_irqsave(&dev->hw_lock, flags);
+	value = hpi_read_reg(dev, HPI_MAILBOX);
+	spin_unlock_irqrestore(&dev->hw_lock, flags);
 
 	return value;
 }
 
-static inline u16 hpi_send_mbox(struct c67x00_drv *drv, u16 value)
+static inline u16 hpi_send_mbox(struct c67x00_device *dev, u16 value)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&drv->hw_lock, flags);
-	hpi_write_reg(drv, HPI_MAILBOX, value);
-	spin_unlock_irqrestore(&drv->hw_lock, flags);
+	spin_lock_irqsave(&dev->hw_lock, flags);
+	hpi_write_reg(dev, HPI_MAILBOX, value);
+	spin_unlock_irqrestore(&dev->hw_lock, flags);
 
 	return value;
 }
 
-u16 c67x00_hpi_status(struct c67x00_drv * drv)
+u16 c67x00_hpi_status(struct c67x00_device * dev)
 {
 	u16 value;
 	unsigned long flags;
 
-	spin_lock_irqsave(&drv->hw_lock, flags);
-	value = hpi_read_reg(drv, HPI_STATUS);
-	spin_unlock_irqrestore(&drv->hw_lock, flags);
+	spin_lock_irqsave(&dev->hw_lock, flags);
+	value = hpi_read_reg(dev, HPI_STATUS);
+	spin_unlock_irqrestore(&dev->hw_lock, flags);
 
 	return value;
 }
 
-void c67x00_ll_hpi_reg_init(struct c67x00_drv *drv)
+void c67x00_ll_hpi_reg_init(struct c67x00_device *dev)
 {
 	int i;
 
-	hpi_recv_mbox(drv);
-	c67x00_hpi_status(drv);
-	hpi_write_word(drv, HPI_IRQ_ROUTING_REG, 0);
+	hpi_recv_mbox(dev);
+	c67x00_hpi_status(dev);
+	hpi_write_word(dev, HPI_IRQ_ROUTING_REG, 0);
 
 	for (i=0; i<C67X00_SIES; i++) {
-		hpi_write_word(drv, SIEMSG_REG(i), 0);
-		hpi_read_word(drv, SIEMSG_REG(i));
+		hpi_write_word(dev, SIEMSG_REG(i), 0);
+		hpi_read_word(dev, SIEMSG_REG(i));
 	}
 }
 
 void c67x00_ll_hpi_enable_sofeop(struct c67x00_sie *sie)
 {
-	hpi_set_bits(sie->drv, HPI_IRQ_ROUTING_REG,
+	hpi_set_bits(sie->dev, HPI_IRQ_ROUTING_REG,
 		     SOFEOP_TO_HPI_EN(sie->sie_num));
 }
 
 void c67x00_ll_hpi_disable_sofeop(struct c67x00_sie *sie)
 {
-	hpi_clear_bits(sie->drv, HPI_IRQ_ROUTING_REG,
+	hpi_clear_bits(sie->dev, HPI_IRQ_ROUTING_REG,
 		       SOFEOP_TO_HPI_EN(sie->sie_num));
 }
 
 /* -------------------------------------------------------------------------- */
 /* Transactions */
 
-static inline void ll_start(struct c67x00_drv *drv)
+static inline void ll_start(struct c67x00_device *dev)
 {
-	INIT_COMPLETION(drv->lcp.msg_received);
-	mutex_lock(&drv->lcp.mutex);
+	INIT_COMPLETION(dev->lcp.msg_received);
+	mutex_lock(&dev->lcp.mutex);
 }
 
-static inline u16 ll_recv_msg(struct c67x00_drv *drv)
+static inline u16 ll_recv_msg(struct c67x00_device *dev)
 {
 	u16 res;
 
-	res = wait_for_completion_timeout(&drv->lcp.msg_received, 5 * HZ);
-	INIT_COMPLETION(drv->lcp.msg_received);
+	res = wait_for_completion_timeout(&dev->lcp.msg_received, 5 * HZ);
+	INIT_COMPLETION(dev->lcp.msg_received);
 	WARN_ON(!res);
 
 	return (res == 0) ? -EIO : 0;
 }
 
-static inline void ll_release(struct c67x00_drv *drv)
+static inline void ll_release(struct c67x00_device *dev)
 {
-	mutex_unlock(&drv->lcp.mutex);
+	mutex_unlock(&dev->lcp.mutex);
 }
 
 /* -------------------------------------------------------------------------- */
 /* General functions */
 
-u16 c67x00_ll_get_siemsg(struct c67x00_drv *drv, int sie)
+u16 c67x00_ll_get_siemsg(struct c67x00_device *dev, int sie)
 {
-	return hpi_read_word(drv, SIEMSG_REG(sie));
+	return hpi_read_word(dev, SIEMSG_REG(sie));
 }
 
-void c67x00_ll_set_siemsg(struct c67x00_drv *drv, int sie, u16 val)
+void c67x00_ll_set_siemsg(struct c67x00_device *dev, int sie, u16 val)
 {
-	hpi_write_word(drv, SIEMSG_REG(sie), val);
+	hpi_write_word(dev, SIEMSG_REG(sie), val);
 }
 
 u16 c67x00_ll_get_usb_ctl(struct c67x00_sie *sie)
 {
-	return hpi_read_word(sie->drv, USB_CTL_REG(sie->sie_num));
+	return hpi_read_word(sie->dev, USB_CTL_REG(sie->sie_num));
 }
 
 /* -------------------------------------------------------------------------- */
 /* Host specific functions */
 
-void c67x00_ll_set_husb_eot(struct c67x00_drv *drv, u16 value)
+void c67x00_ll_set_husb_eot(struct c67x00_device *dev, u16 value)
 {
-	ll_start(drv);
-	hpi_write_word(drv, HUSB_pEOT, value);
-	ll_release(drv);
+	ll_start(dev);
+	hpi_write_word(dev, HUSB_pEOT, value);
+	ll_release(dev);
 }
 
 static inline void c67x00_ll_husb_sie_init(struct c67x00_sie *sie)
 {
-	struct c67x00_drv *drv = sie->drv;
+	struct c67x00_device *dev = sie->dev;
 	struct lcp_int_data data;
 	int rc;
 
-	rc = c67x00_comm_exec_int(drv, HUSB_SIE_INIT_INT(sie->sie_num), &data);
+	rc = c67x00_comm_exec_int(dev, HUSB_SIE_INIT_INT(sie->sie_num), &data);
 	BUG_ON(rc); /* No return path for error code; crash spectacularly */
 }
 
 void c67x00_ll_husb_reset(struct c67x00_sie *sie, int port)
 {
-	struct c67x00_drv *drv = sie->drv;
+	struct c67x00_device *dev = sie->dev;
 	struct lcp_int_data data;
 	int rc;
 
 	data.regs[0] = 50;	/* Reset USB port for 50ms */
 	data.regs[1] = port | (sie->sie_num << 1);
-	rc = c67x00_comm_exec_int(drv, HUSB_RESET_INT, &data);
+	rc = c67x00_comm_exec_int(dev, HUSB_RESET_INT, &data);
 	BUG_ON(rc); /* No return path for error code; crash spectacularly */
 }
 
 void c67x00_ll_husb_set_current_td(struct c67x00_sie *sie, u16 addr)
 {
-	hpi_write_word(sie->drv, HUSB_SIE_pCurrentTDPtr(sie->sie_num), addr);
+	hpi_write_word(sie->dev, HUSB_SIE_pCurrentTDPtr(sie->sie_num), addr);
 }
 
 u16 c67x00_ll_husb_get_current_td(struct c67x00_sie *sie)
 {
-	return hpi_read_word(sie->drv, HUSB_SIE_pCurrentTDPtr(sie->sie_num));
+	return hpi_read_word(sie->dev, HUSB_SIE_pCurrentTDPtr(sie->sie_num));
 }
 
 /**
@@ -316,28 +316,28 @@ u16 c67x00_ll_husb_get_current_td(struct c67x00_sie *sie)
  */
 void c67x00_ll_husb_clear_status(struct c67x00_sie *sie, u16 bits)
 {
-	hpi_write_word(sie->drv, HOST_STAT_REG(sie->sie_num), bits);
+	hpi_write_word(sie->dev, HOST_STAT_REG(sie->sie_num), bits);
 }
 
 u16 c67x00_ll_husb_get_status(struct c67x00_sie *sie)
 {
-	return hpi_read_word(sie->drv, HOST_STAT_REG(sie->sie_num));
+	return hpi_read_word(sie->dev, HOST_STAT_REG(sie->sie_num));
 }
 
 u16 c67x00_ll_husb_get_frame(struct c67x00_sie * sie)
 {
-	return hpi_read_word(sie->drv, HOST_FRAME_REG(sie->sie_num));
+	return hpi_read_word(sie->dev, HOST_FRAME_REG(sie->sie_num));
 }
 
 void c67x00_ll_husb_init_host_port(struct c67x00_sie *sie)
 {
 	/* Set port into host mode */
-	hpi_set_bits(sie->drv, USB_CTL_REG(sie->sie_num), HOST_MODE);
+	hpi_set_bits(sie->dev, USB_CTL_REG(sie->sie_num), HOST_MODE);
 	c67x00_ll_husb_sie_init(sie);
 	/* Clear interrupts */
 	c67x00_ll_husb_clear_status(sie, HOST_STAT_MASK);
 	/* Check */
-	if (!(hpi_read_word(sie->drv, USB_CTL_REG(sie->sie_num)) & HOST_MODE))
+	if (!(hpi_read_word(sie->dev, USB_CTL_REG(sie->sie_num)) & HOST_MODE))
 		dev_warn(sie_dev(sie),
 			 "SIE %d not set to host mode\n", sie->sie_num);
 }
@@ -348,94 +348,94 @@ void c67x00_ll_husb_reset_port(struct c67x00_sie *sie, int port)
 	c67x00_ll_husb_clear_status(sie, PORT_CONNECT_CHANGE(port));
 
 	/* Enable interrupts */
-	hpi_set_bits(sie->drv, HPI_IRQ_ROUTING_REG,
+	hpi_set_bits(sie->dev, HPI_IRQ_ROUTING_REG,
 		     SOFEOP_TO_CPU_EN(sie->sie_num));
-	hpi_set_bits(sie->drv, HOST_IRQ_EN_REG(sie->sie_num),
+	hpi_set_bits(sie->dev, HOST_IRQ_EN_REG(sie->sie_num),
 		     SOF_EOP_IRQ_EN | DONE_IRQ_EN);
 
 	/* Enable pull down transistors */
-	hpi_set_bits(sie->drv, USB_CTL_REG(sie->sie_num), PORT_RES_EN(port));
+	hpi_set_bits(sie->dev, USB_CTL_REG(sie->sie_num), PORT_RES_EN(port));
 }
 
 /* -------------------------------------------------------------------------- */
 void c67x00_ll_susb_init(struct c67x00_sie *sie)
 {
-	struct c67x00_drv *drv = sie->drv;
+	struct c67x00_device *dev = sie->dev;
 	struct lcp_int_data data;
 	int rc;
 
 	data.regs[1] = 1;	/* full speed */
 	data.regs[2] = sie->sie_num + 1;
-	rc = c67x00_comm_exec_int(drv, SUSB_INIT_INT, &data);
+	rc = c67x00_comm_exec_int(dev, SUSB_INIT_INT, &data);
 	BUG_ON(rc); /* No return path for error code; crash spectacularly */
 
-	hpi_clear_bits(drv, HPI_IRQ_ROUTING_REG,
+	hpi_clear_bits(dev, HPI_IRQ_ROUTING_REG,
 		       SOFEOP_TO_HPI_EN(sie->sie_num));
-	hpi_set_bits(drv, HPI_IRQ_ROUTING_REG, SOFEOP_TO_CPU_EN(sie->sie_num));
+	hpi_set_bits(dev, HPI_IRQ_ROUTING_REG, SOFEOP_TO_CPU_EN(sie->sie_num));
 }
 
 /* -------------------------------------------------------------------------- */
 
-void c67x00_ll_irq(struct c67x00_drv *drv)
+void c67x00_ll_irq(struct c67x00_device *dev)
 {
-	if ((drv->int_status & MBX_OUT_FLG) == 0)
+	if ((dev->int_status & MBX_OUT_FLG) == 0)
 		return;
 
-	drv->lcp.last_msg = hpi_recv_mbox(drv);
-	complete(&drv->lcp.msg_received);
+	dev->lcp.last_msg = hpi_recv_mbox(dev);
+	complete(&dev->lcp.msg_received);
 }
 
 /* -------------------------------------------------------------------------- */
 
-u16 c67x00_comm_read_ctrl_reg(struct c67x00_drv * drv, u16 addr)
+u16 c67x00_comm_read_ctrl_reg(struct c67x00_device * dev, u16 addr)
 {
 	unsigned long msg, res;
 	int rc;
 
-	ll_start(drv);
-	hpi_write_word(drv, COMM_CTRL_REG_ADDR, addr);
-	hpi_send_mbox(drv, COMM_READ_CTRL_REG);
-	rc = ll_recv_msg(drv);
+	ll_start(dev);
+	hpi_write_word(dev, COMM_CTRL_REG_ADDR, addr);
+	hpi_send_mbox(dev, COMM_READ_CTRL_REG);
+	rc = ll_recv_msg(dev);
 
 	BUG_ON(rc); /* No return path for error code; crash spectacularly */
 
-	msg = drv->lcp.last_msg;
+	msg = dev->lcp.last_msg;
 	if (msg != COMM_ACK) {
-		dev_warn(&drv->pdev->dev, "COMM_READ_CTRL_REG didn't ACK!\n");
+		dev_warn(&dev->pdev->dev, "COMM_READ_CTRL_REG didn't ACK!\n");
 		res = 0;
 	} else {
-		res = hpi_read_word(drv, COMM_CTRL_REG_DATA);
+		res = hpi_read_word(dev, COMM_CTRL_REG_DATA);
 	}
-	ll_release(drv);
+	ll_release(dev);
 	return res;
 }
 
-int c67x00_comm_exec_int(struct c67x00_drv *drv, u16 nr,
+int c67x00_comm_exec_int(struct c67x00_device *dev, u16 nr,
 			  struct lcp_int_data *data)
 {
 	int i, rc;
 
-	ll_start(drv);
-	hpi_write_word(drv, COMM_INT_NUM, nr);
+	ll_start(dev);
+	hpi_write_word(dev, COMM_INT_NUM, nr);
 	for (i = 0; i < COMM_REGS; i++)
-		hpi_write_word(drv, COMM_R(i), data->regs[i]);
-	hpi_send_mbox(drv, COMM_EXEC_INT);
-	rc = ll_recv_msg(drv);
-	ll_release(drv);
+		hpi_write_word(dev, COMM_R(i), data->regs[i]);
+	hpi_send_mbox(dev, COMM_EXEC_INT);
+	rc = ll_recv_msg(dev);
+	ll_release(dev);
 
 	return rc;
 }
 
 /* -------------------------------------------------------------------------- */
 
-int c67x00_ll_reset(struct c67x00_drv *drv)
+int c67x00_ll_reset(struct c67x00_device *dev)
 {
 	int rc;
 
-	ll_start(drv);
-	hpi_send_mbox(drv, COMM_RESET);
-	rc = ll_recv_msg(drv);
-	ll_release(drv);
+	ll_start(dev);
+	hpi_send_mbox(dev, COMM_RESET);
+	rc = ll_recv_msg(dev);
+	ll_release(dev);
 
 	return rc;
 }
@@ -446,12 +446,12 @@ int c67x00_ll_reset(struct c67x00_drv *drv)
  * c67x00_write_mem_le16 - write into c67x00 memory
  * Only data is little endian, addr has cpu endianess.
  */
-void c67x00_write_mem_le16(struct c67x00_drv *drv, u16 addr,
+void c67x00_write_mem_le16(struct c67x00_device *dev, u16 addr,
 			   int len, char *data)
 {
 	/* Sanity check */
 	if (addr + len > 0xffff) {
-		dev_err(&drv->pdev->dev,
+		dev_err(&dev->pdev->dev,
 			"Trying to write beyond writable region!\n");
 		return;
 	}
@@ -459,23 +459,23 @@ void c67x00_write_mem_le16(struct c67x00_drv *drv, u16 addr,
 	if (addr & 0x01) {
 		/* unaligned access */
 		u16 tmp;
-		tmp = hpi_read_word(drv, addr - 1);
+		tmp = hpi_read_word(dev, addr - 1);
 		tmp = (tmp & 0x00ff) | (*data++ << 8);
-		hpi_write_word(drv, addr - 1, tmp);
+		hpi_write_word(dev, addr - 1, tmp);
 		addr++;
 		len--;
 	}
 
-	hpi_write_words_le16(drv, addr, (u16 *) data, len / 2);
+	hpi_write_words_le16(dev, addr, (u16 *) data, len / 2);
 	data += len & ~0x01;
 	addr += len & ~0x01;
 	len &= 0x01;
 
 	if (len) {
 		u16 tmp;
-		tmp = hpi_read_word(drv, addr);
+		tmp = hpi_read_word(dev, addr);
 		tmp = (tmp & 0xff00) | (*data++);
-		hpi_write_word(drv, addr, tmp);
+		hpi_write_word(dev, addr, tmp);
 		addr++;
 		len--;
 	}
@@ -486,25 +486,25 @@ void c67x00_write_mem_le16(struct c67x00_drv *drv, u16 addr,
  * c67x00_read_mem_le16 - read from c67x00 memory
  * Only data is little endian, addr has cpu endianess.
  */
-void c67x00_read_mem_le16(struct c67x00_drv *drv, u16 addr, int len, char *data)
+void c67x00_read_mem_le16(struct c67x00_device *dev, u16 addr, int len, char *data)
 {
 	if (addr & 0x01) {
 		/* unaligned access */
 		u16 tmp;
-		tmp = hpi_read_word(drv, addr - 1);
+		tmp = hpi_read_word(dev, addr - 1);
 		*data++ = (tmp >> 8) & 0x00ff;
 		addr++;
 		len--;
 	}
 
-	hpi_read_words_le16(drv, addr, (u16 *) data, len / 2);
+	hpi_read_words_le16(dev, addr, (u16 *) data, len / 2);
 	data += len & ~0x01;
 	addr += len & ~0x01;
 	len &= 0x01;
 
 	if (len) {
 		u16 tmp;
-		tmp = hpi_read_word(drv, addr);
+		tmp = hpi_read_word(dev, addr);
 		*data++ = tmp & 0x00ff;
 		addr++;
 		len--;
@@ -513,12 +513,12 @@ void c67x00_read_mem_le16(struct c67x00_drv *drv, u16 addr, int len, char *data)
 
 /* -------------------------------------------------------------------------- */
 
-void c67x00_ll_init(struct c67x00_drv *drv)
+void c67x00_ll_init(struct c67x00_device *dev)
 {
-	mutex_init(&drv->lcp.mutex);
-	init_completion(&drv->lcp.msg_received);
+	mutex_init(&dev->lcp.mutex);
+	init_completion(&dev->lcp.msg_received);
 }
 
-void c67x00_ll_release(struct c67x00_drv *drv)
+void c67x00_ll_release(struct c67x00_device *dev)
 {
 }
diff --git a/drivers/usb/c67x00/c67x00-ll-hpi.h b/drivers/usb/c67x00/c67x00-ll-hpi.h
index 3f84348..b3b8512 100644
--- a/drivers/usb/c67x00/c67x00-ll-hpi.h
+++ b/drivers/usb/c67x00/c67x00-ll-hpi.h
@@ -28,7 +28,7 @@
 #include <linux/mutex.h>
 
 struct c67x00_sie;
-struct c67x00_drv;
+struct c67x00_device;
 
 struct lcp {
 	/* Internal use only */
@@ -46,22 +46,22 @@ struct lcp_int_data {
 /* ------------------------------------------------------------------------- */
 /* HPI */
 
-u16 c67x00_hpi_status(struct c67x00_drv *drv);
-void c67x00_ll_hpi_reg_init(struct c67x00_drv *drv);
+u16 c67x00_hpi_status(struct c67x00_device *dev);
+void c67x00_ll_hpi_reg_init(struct c67x00_device *dev);
 void c67x00_ll_hpi_enable_sofeop(struct c67x00_sie *sie);
 void c67x00_ll_hpi_disable_sofeop(struct c67x00_sie *sie);
 
 /* -------------------------------------------------------------------------- */
 /* General functions */
 
-u16 c67x00_ll_get_siemsg(struct c67x00_drv *drv, int sie);
-void c67x00_ll_set_siemsg(struct c67x00_drv *drv, int sie, u16 val);
+u16 c67x00_ll_get_siemsg(struct c67x00_device *dev, int sie);
+void c67x00_ll_set_siemsg(struct c67x00_device *dev, int sie, u16 val);
 u16 c67x00_ll_get_usb_ctl(struct c67x00_sie *sie);
 
 /* ------------------------------------------------------------------------- */
 /* Host specific functions */
 
-void c67x00_ll_set_husb_eot(struct c67x00_drv *drv, u16 value);
+void c67x00_ll_set_husb_eot(struct c67x00_device *dev, u16 value);
 void c67x00_ll_husb_reset(struct c67x00_sie *sie, int port);
 void c67x00_ll_husb_set_current_td(struct c67x00_sie *sie, u16 addr);
 u16 c67x00_ll_husb_get_current_td(struct c67x00_sie *sie);
@@ -78,21 +78,21 @@ void c67x00_ll_susb_init(struct c67x00_sie *sie);
 
 /* ------------------------------------------------------------------------- */
 
-void c67x00_write_mem_le16(struct c67x00_drv *drv, u16 addr,
+void c67x00_write_mem_le16(struct c67x00_device *dev, u16 addr,
 			   int len, char *data);
-void c67x00_read_mem_le16(struct c67x00_drv *drv, u16 addr,
+void c67x00_read_mem_le16(struct c67x00_device *dev, u16 addr,
 			  int len, char *data);
 
-u16 c67x00_comm_read_ctrl_reg(struct c67x00_drv *drv, u16 addr);
+u16 c67x00_comm_read_ctrl_reg(struct c67x00_device *dev, u16 addr);
 
-int c67x00_comm_exec_int(struct c67x00_drv *drv, u16 nr,
+int c67x00_comm_exec_int(struct c67x00_device *dev, u16 nr,
 			 struct lcp_int_data *data);
 
 /* Called by c67x00_irq to handle lcp interrupts */
-void c67x00_ll_irq(struct c67x00_drv *drv);
+void c67x00_ll_irq(struct c67x00_device *dev);
 
-void c67x00_ll_init(struct c67x00_drv *drv);
-void c67x00_ll_release(struct c67x00_drv *drv);
-int c67x00_ll_reset(struct c67x00_drv *drv);
+void c67x00_ll_init(struct c67x00_device *dev);
+void c67x00_ll_release(struct c67x00_device *dev);
+int c67x00_ll_reset(struct c67x00_device *dev);
 
 #endif				/* _USB_C67X00_LL_HPI_H */
diff --git a/drivers/usb/c67x00/c67x00-sched.c b/drivers/usb/c67x00/c67x00-sched.c
index 3a870cf..d408f2f 100644
--- a/drivers/usb/c67x00/c67x00-sched.c
+++ b/drivers/usb/c67x00/c67x00-sched.c
@@ -858,18 +858,18 @@ static void send_td(struct c67x00_hcd *c67x00, struct c67x00_td *td)
 	int len = td_length(td);
 
 	if (len && ((td->pid_ep & TD_PIDEPMASK_PID) != TD_PID_IN))
-		c67x00_write_mem_le16(c67x00->sie->drv,
+		c67x00_write_mem_le16(c67x00->sie->dev,
 				      td_ly_base_addr(td), len, td->data);
 #ifdef DEBUG_PATTERN
 	else {			/* write known patterns into memories */
 		memset(td->data, NON_RECEIVED_PATTERN, len);
-		c67x00_write_mem_le16(c67x00->sie->drv,
+		c67x00_write_mem_le16(c67x00->sie->dev,
 				      td_ly_base_addr(td), len, td->data);
 		memset(td->data, UNREAD_PATTERN, len);
 	}
 #endif				/* DEBUG_PATTERN */
 
-	c67x00_write_mem_le16(c67x00->sie->drv,
+	c67x00_write_mem_le16(c67x00->sie->dev,
 			      td->td_addr, CY_TD_SIZE, (char *)td);
 }
 
@@ -878,11 +878,11 @@ static void send_td(struct c67x00_hcd *c67x00, struct c67x00_td *td)
  */
 static inline void parse_td(struct c67x00_hcd *c67x00, struct c67x00_td *td)
 {
-	c67x00_read_mem_le16(c67x00->sie->drv,
+	c67x00_read_mem_le16(c67x00->sie->dev,
 			     td->td_addr, CY_TD_SIZE, (char *)td);
 
 	if (usb_pipein(td->pipe) && td_actual_bytes(td))
-		c67x00_read_mem_le16(c67x00->sie->drv, td_ly_base_addr(td),
+		c67x00_read_mem_le16(c67x00->sie->dev, td_ly_base_addr(td),
 				     td_actual_bytes(td), td->data);
 }
 
-- 
1.4.4.2
