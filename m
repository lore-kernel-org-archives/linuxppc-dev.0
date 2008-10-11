Return-Path: <lark@linux.net.cn>
Received: from mx.linux.net.cn (unknown [210.82.31.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D6B4ADDDF4
	for <linuxppc-dev@ozlabs.org>; Sun, 12 Oct 2008 05:00:07 +1100 (EST)
Date: Sun, 12 Oct 2008 02:00:14 +0800
From: Wang Jian <lark@linux.net.cn>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH RFC] pata_platform: add 8 bit data io support
Message-ID: <20081011180014.GA4908@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

To avoid adding another rare used ata_port member, new bit is added to
ata_port->flags.

Originally, I hacked pata_platform to make it 8bit only to support 8bit
data wired CF card. This patch is more generic.

With this patch, __pata_platform_probe() interface is changed, and
pata_of_platform is broken, so a small patch is needed.

Signed-off-by: Wang Jian <lark@linux.net.cn>
---
 drivers/ata/pata_platform.c  |   63 ++++++++++++++++++++++++++++++++++++++++--
 include/linux/ata.h          |    8 +++++
 include/linux/ata_platform.h |    4 ++
 include/linux/libata.h       |    1 +
 4 files changed, 73 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/pata_platform.c b/drivers/ata/pata_platform.c
index 8f65ad6..d2276ad 100644
--- a/drivers/ata/pata_platform.c
+++ b/drivers/ata/pata_platform.c
@@ -50,9 +50,62 @@ static struct scsi_host_template pata_platform_sht = {
 	ATA_PIO_SHT(DRV_NAME),
 };
 
+static void pata_platform_postreset(struct ata_link *link, unsigned int *classes)
+{
+	struct ata_port *ap = link->ap;
+	struct ata_device *dev;
+	u8 select = ATA_DEVICE_OBS;
+
+	/* Call default callback first */
+	ata_sff_postreset(link, classes);
+
+	if (!(ap->flags & ATA_FLAG_8BIT_DATA))
+		return;
+
+	/* Set 8-bit mode. We know we can do that */
+	ata_link_for_each_dev(dev, link) {
+		if (dev->devno)
+			select |= ATA_DEV1;
+
+		iowrite8(SETFEATURES_8BIT_ON, ap->ioaddr.feature_addr);
+		iowrite8(select, ap->ioaddr.device_addr);
+		iowrite8(ATA_CMD_SET_FEATURES, ap->ioaddr.command_addr);
+	}
+}
+
+static unsigned int pata_platform_data_xfer(struct ata_device *dev,
+	unsigned char *buf, unsigned int buflen, int rw)
+{
+	struct ata_port *ap = dev->link->ap;
+
+	if (!(ap->flags & ATA_FLAG_8BIT_DATA))
+		return ata_sff_data_xfer(dev, buf, buflen, rw);
+
+	if (rw == READ)
+		ioread8_rep(ap->ioaddr.data_addr, buf, buflen);
+	else
+		iowrite8_rep(ap->ioaddr.data_addr, buf, buflen);
+
+	return buflen;
+}
+
+static unsigned int pata_platform_data_xfer_noirq(struct ata_device *dev,
+	unsigned char *buf, unsigned int buflen, int rw)
+{
+	unsigned long flags;
+	unsigned int consumed;
+
+	local_irq_save(flags);
+	consumed = pata_platform_data_xfer(dev, buf, buflen, rw);
+	local_irq_restore(flags);
+
+	return consumed;
+}
+
 static struct ata_port_operations pata_platform_port_ops = {
 	.inherits		= &ata_sff_port_ops,
-	.sff_data_xfer		= ata_sff_data_xfer_noirq,
+	.postreset		= pata_platform_postreset,
+	.sff_data_xfer		= pata_platform_data_xfer_noirq,
 	.cable_detect		= ata_cable_unknown,
 	.set_mode		= pata_platform_set_mode,
 	.port_start		= ATA_OP_NULL,
@@ -106,7 +159,8 @@ int __devinit __pata_platform_probe(struct device *dev,
 				    struct resource *ctl_res,
 				    struct resource *irq_res,
 				    unsigned int ioport_shift,
-				    int __pio_mask)
+				    int __pio_mask,
+				    unsigned int data_width)
 {
 	struct ata_host *host;
 	struct ata_port *ap;
@@ -140,6 +194,9 @@ int __devinit __pata_platform_probe(struct device *dev,
 	ap->pio_mask = __pio_mask;
 	ap->flags |= ATA_FLAG_SLAVE_POSS;
 
+	if (data_width == ATA_DATA_WIDTH_8BIT)
+		ap->flags |= ATA_FLAG_8BIT_DATA;
+
 	/*
 	 * Use polling mode if there's no IRQ
 	 */
@@ -242,7 +299,7 @@ static int __devinit pata_platform_probe(struct platform_device *pdev)
 
 	return __pata_platform_probe(&pdev->dev, io_res, ctl_res, irq_res,
 				     pp_info ? pp_info->ioport_shift : 0,
-				     pio_mask);
+				     pio_mask, pp_info->data_width);
 }
 
 static int __devexit pata_platform_remove(struct platform_device *pdev)
diff --git a/include/linux/ata.h b/include/linux/ata.h
index be00973..4ce26df 100644
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -45,6 +45,11 @@ enum {
 	ATA_MAX_SECTORS_LBA48	= 65535,/* TODO: 65536? */
 	ATA_MAX_SECTORS_TAPE	= 65535,
 
+	ATA_DATA_WIDTH_8BIT	= 1,
+	ATA_DATA_WIDTH_16BIT	= 2,
+	ATA_DATA_WIDTH_DEFAULT	= 2,
+	ATA_DATA_WIDTH_32BIT	= 4,
+
 	ATA_ID_WORDS		= 256,
 	ATA_ID_CONFIG		= 0,
 	ATA_ID_CYLS		= 1,
@@ -280,6 +285,9 @@ enum {
 	XFER_PIO_0		= 0x08,
 	XFER_PIO_SLOW		= 0x00,
 
+	SETFEATURES_8BIT_ON	= 0x01,	/* Enable 8 bit data transfers */
+	SETFEATURES_8BIT_OFF	= 0x81,	/* Disable 8 bit data transfers */
+
 	SETFEATURES_WC_ON	= 0x02, /* Enable write cache */
 	SETFEATURES_WC_OFF	= 0x82, /* Disable write cache */
 
diff --git a/include/linux/ata_platform.h b/include/linux/ata_platform.h
index 9a26c83..434fe49 100644
--- a/include/linux/ata_platform.h
+++ b/include/linux/ata_platform.h
@@ -13,6 +13,10 @@ struct pata_platform_info {
 	 * IRQ flags when call request_irq()
 	 */
 	unsigned int irq_flags;
+	/*
+	 * Data I/O width (in byte)
+	 */
+	unsigned int data_width;
 };
 
 extern int __devinit __pata_platform_probe(struct device *dev,
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 947cf84..156b7d3 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -187,6 +187,7 @@ enum {
 	ATA_FLAG_PIO_POLLING	= (1 << 9), /* use polling PIO if LLD
 					     * doesn't handle PIO interrupts */
 	ATA_FLAG_NCQ		= (1 << 10), /* host supports NCQ */
+	ATA_FLAG_8BIT_DATA	= (1 << 11), /* Host using 8 bit data */
 	ATA_FLAG_DEBUGMSG	= (1 << 13),
 	ATA_FLAG_IGN_SIMPLEX	= (1 << 15), /* ignore SIMPLEX */
 	ATA_FLAG_NO_IORDY	= (1 << 16), /* controller lacks iordy */
-- 
1.5.6.5
