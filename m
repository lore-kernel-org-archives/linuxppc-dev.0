Return-Path: <B48286@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe003.messaging.microsoft.com [213.199.154.206])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 773922C0091
 for <linuxppc-dev@ozlabs.org>; Wed, 11 Dec 2013 20:42:22 +1100 (EST)
From: Hou Zhiqiang <b48286@freescale.com>
To: <linux-mtd@lists.infradead.org>, <linuxppc-dev@ozlabs.org>
Subject: [PATCH] mtd: m25p80: Add Power Management support
Date: Wed, 11 Dec 2013 16:19:30 +0800
Message-ID: <1386749970-22021-1-git-send-email-b48286@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: scottwood@freescale.com, Mingkai.Hu@freescale.com,
 Hou Zhiqiang <b48286@freescale.com>, dwmw2@infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add PM support using callback function suspend and resume in .driver of
spi_driver.

Signed-off-by: Hou Zhiqiang <b48286@freescale.com>
---
 drivers/mtd/devices/m25p80.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index 7eda71d..b0c2b8c 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -66,6 +66,8 @@
 
 /* Used for Spansion flashes only. */
 #define	OPCODE_BRWR		0x17	/* Bank register write */
+#define	OPCODE_DP		0xb9	/* Enter deep power down mode */
+#define	OPCODE_RES		0xab	/* Exit deep power down mode */
 
 /* Status Register bits. */
 #define	SR_WIP			1	/* Write in progress */
@@ -1128,11 +1130,46 @@ static int m25p_remove(struct spi_device *spi)
 	return mtd_device_unregister(&flash->mtd);
 }
 
+#ifdef CONFIG_PM
+static int m25p_suspend(struct device *dev, pm_message_t mesg)
+{
+	struct m25p *flash = dev_get_drvdata(dev);
+	int ret;
+
+	flash->command[0] = OPCODE_DP;
+	mutex_lock(&flash->lock);
+	/* Wait until finished previous write/erase command. */
+	ret = wait_till_ready(flash);
+	if (ret) {
+		mutex_unlock(&flash->lock);
+		return ret;
+	}
+	ret = spi_write(flash->spi, flash->command, 1);
+	mutex_unlock(&flash->lock);
+
+	return ret;
+}
+
+static int m25p_resume(struct device *dev)
+{
+	struct m25p *flash = dev_get_drvdata(dev);
+	int ret;
+
+	flash->command[0] = OPCODE_RES;
+	ret = spi_write(flash->spi, flash->command, 1);
+
+	return ret;
+}
+#endif /* CONFIG_PM */
 
 static struct spi_driver m25p80_driver = {
 	.driver = {
 		.name	= "m25p80",
 		.owner	= THIS_MODULE,
+#ifdef CONFIG_PM
+		.suspend = m25p_suspend,
+		.resume = m25p_resume,
+#endif
 	},
 	.id_table	= m25p_ids,
 	.probe	= m25p_probe,
-- 
1.8.4.1
