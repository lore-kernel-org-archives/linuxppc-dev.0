Return-Path: <B32616@freescale.com>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe004.messaging.microsoft.com [213.199.154.142])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BF3E02C0309
 for <linuxppc-dev@ozlabs.org>; Mon,  4 Mar 2013 18:53:16 +1100 (EST)
From: Qiang Liu <qiang.liu@freescale.com>
To: <jgarzik@pobox.com>, <linux-ide@vger.kernel.org>
Subject: [PATCH] fsl/sata: create a sysfs entry for rx water mark
Date: Mon, 4 Mar 2013 15:20:23 +0800
Message-ID: <1362381623-10856-1-git-send-email-qiang.liu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Qiang Liu <qiang.liu@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Support config RX WATER MARK via sysfs when running at run-time;
A wrokaround for fix the exception happened to some WD HDD, found on
WD3000HLFS-01G6U1, WD3000HLFS-01G6U0, some SSD disks. The read performance
is also regression (about 30%) when use default value.

According to the latest documents, 0x10 is the default value of RX WATER MARK,
but exception/performance issue happened to some disks mentioned above.

The exception log as below when testing read performance with IOZone:
ata1.00: exception Emask 0x0 SAct 0x7 SErr 0x800000 action 0x6 frozen
ata1: SError: { LinkSeq }
ata1.00: failed command: READ FPDMA QUEUED
ata1.00: cmd 60/00:00:ff:2c:14/01:00:02:00:00/40 tag 0 ncq 131072 in
res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: status: { DRDY }
ata1.00: failed command: READ FPDMA QUEUED
ata1.00: cmd 60/00:08:ff:2d:14/01:00:02:00:00/40 tag 1 ncq 131072 in
res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: status: { DRDY }
ata1.00: failed command: WRITE FPDMA QUEUED
ata1.00: cmd 61/10:10:af:08:6e/00:00:12:00:00/40 tag 2 ncq 8192 out
res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: status: { DRDY }
ata1: hard resetting link
ata1: Hardreset failed, not off-lined 0
ata1: Signature Update detected @ 504 msecs
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: configured for UDMA/133
ata1.00: device reported invalid CHS sector 0
ata1.00: device reported invalid CHS sector 0
ata1.00: device reported invalid CHS sector 0
ata1: EH complete

The exception/performance can be resolved when RX WATER MARK value is 0x16.

Signed-off-by: Qiang Liu <qiang.liu@freescale.com>
---
 drivers/ata/sata_fsl.c |   55 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 55 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index 124b2c1..515f66f 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -285,6 +285,7 @@ struct sata_fsl_host_priv {
 	int irq;
 	int data_snoop;
 	struct device_attribute intr_coalescing;
+	struct device_attribute rx_watermark;
 };

 static void fsl_sata_set_irq_coalescing(struct ata_host *host,
@@ -343,6 +344,48 @@ static ssize_t fsl_sata_intr_coalescing_store(struct device *dev,
 	return strlen(buf);
 }

+static ssize_t fsl_sata_rx_watermark_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	unsigned int rx_watermark;
+	unsigned long flags;
+	struct ata_host *host = dev_get_drvdata(dev);
+	struct sata_fsl_host_priv *host_priv = host->private_data;
+	void __iomem *csr_base = host_priv->csr_base;
+
+	spin_lock_irqsave(&host->lock, flags);
+	rx_watermark = ioread32(csr_base + TRANSCFG);
+	rx_watermark &= 0x1f;
+
+	spin_unlock_irqrestore(&host->lock, flags);
+	return sprintf(buf, "%d\n", rx_watermark);
+}
+
+static ssize_t fsl_sata_rx_watermark_store(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf, size_t count)
+{
+	unsigned int rx_watermark;
+	unsigned long flags;
+	struct ata_host *host = dev_get_drvdata(dev);
+	struct sata_fsl_host_priv *host_priv = host->private_data;
+	void __iomem *csr_base = host_priv->csr_base;
+	u32 temp;
+
+	if (sscanf(buf, "%d", &rx_watermark) != 1) {
+		printk(KERN_ERR "fsl-sata: wrong parameter format.\n");
+		return -EINVAL;
+	}
+
+	spin_lock_irqsave(&host->lock, flags);
+	temp = ioread32(csr_base + TRANSCFG);
+	temp &= 0xffffffe0;
+	iowrite32(temp | rx_watermark, csr_base + TRANSCFG);
+
+	spin_unlock_irqrestore(&host->lock, flags);
+	return strlen(buf);
+}
+
 static inline unsigned int sata_fsl_tag(unsigned int tag,
 					void __iomem *hcr_base)
 {
@@ -1500,6 +1543,17 @@ static int sata_fsl_probe(struct platform_device *ofdev)
 	if (retval)
 		goto error_exit_with_cleanup;

+	host_priv->rx_watermark.show = fsl_sata_rx_watermark_show;
+	host_priv->rx_watermark.store = fsl_sata_rx_watermark_store;
+	sysfs_attr_init(&host_priv->rx_watermark.attr);
+	host_priv->rx_watermark.attr.name = "rx_watermark";
+	host_priv->rx_watermark.attr.mode = S_IRUGO | S_IWUSR;
+	retval = device_create_file(host->dev, &host_priv->rx_watermark);
+	if (retval) {
+		device_remove_file(&ofdev->dev, &host_priv->intr_coalescing);
+		goto error_exit_with_cleanup;
+	}
+
 	return 0;

 error_exit_with_cleanup:
@@ -1523,6 +1577,7 @@ static int sata_fsl_remove(struct platform_device *ofdev)
 	struct sata_fsl_host_priv *host_priv = host->private_data;

 	device_remove_file(&ofdev->dev, &host_priv->intr_coalescing);
+	device_remove_file(&ofdev->dev, &host_priv->rx_watermark);

 	ata_host_detach(host);

--
1.7.5.1
