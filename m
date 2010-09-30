Return-Path: <B21284@freescale.com>
Received: from VA3EHSOBE006.bigfish.com (va3ehsobe006.messaging.microsoft.com
	[216.32.180.16]) by ozlabs.org (Postfix) with ESMTP id 3B0C9B7169
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Sep 2010 18:26:13 +1000 (EST)
Received: from mail31-va3 (localhost.localdomain [127.0.0.1])	by
	mail31-va3-R.bigfish.com (Postfix) with ESMTP id EC79A1350187	for
	<linuxppc-dev@ozlabs.org>; Thu, 30 Sep 2010 08:26:11 +0000 (UTC)
Received: from VA3EHSMHS032.bigfish.com (unknown [10.7.14.246])	by
	mail31-va3.bigfish.com (Postfix) with ESMTP id 77CDE54004C	for
	<linuxppc-dev@ozlabs.org>; Thu, 30 Sep 2010 08:26:11 +0000 (UTC)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.14.3/8.14.3) with ESMTP id
	o8U8Q8n9006863	for
	<linuxppc-dev@ozlabs.org>; Thu, 30 Sep 2010 01:26:08 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id
	o8U8fXHG017737	for <linuxppc-dev@ozlabs.org>;
	Thu, 30 Sep 2010 03:41:52 -0500 (CDT)
From: Mingkai Hu <Mingkai.hu@freescale.com>
To: linuxppc-dev@ozlabs.org, spi-devel-general@lists.sourceforge.net,
	linux-mtd@lists.infradead.org
Subject: [PATCH v3 6/7] mtd: m25p80: add a read function to read page by page
Date: Thu, 30 Sep 2010 16:00:45 +0800
Message-ID: <1285833646-12006-7-git-send-email-Mingkai.hu@freescale.com>
In-Reply-To: <1285833646-12006-6-git-send-email-Mingkai.hu@freescale.com>
References: <1285833646-12006-1-git-send-email-Mingkai.hu@freescale.com>
	<1285833646-12006-2-git-send-email-Mingkai.hu@freescale.com>
	<1285833646-12006-3-git-send-email-Mingkai.hu@freescale.com>
	<1285833646-12006-4-git-send-email-Mingkai.hu@freescale.com>
	<1285833646-12006-5-git-send-email-Mingkai.hu@freescale.com>
	<1285833646-12006-6-git-send-email-Mingkai.hu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: kumar.gala@freescale.com, Mingkai Hu <Mingkai.hu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For Freescale's eSPI controller, the max transaction length one time
is limitted by the SPCOM[TRANSLEN] field which is 0xFFFF. When used
mkfs.ext2 command to create ext2 filesystem on the flash, the read
length will exceed the max value of the SPCOM[TRANSLEN] field, so
change the read function to read page by page.

For other SPI flash driver, also needed to supply the read function
if used the eSPI controller.

Signed-off-by: Mingkai Hu <Mingkai.hu@freescale.com>
---
v3:
 - Add a quirks member for the SPI master to handle the contrains of the
   SPI controller. I can't think of other method. :-(

 drivers/mtd/devices/m25p80.c |   78 ++++++++++++++++++++++++++++++++++++++++++
 drivers/spi/spi_fsl_lib.c    |    4 ++
 include/linux/spi/spi.h      |    5 +++
 3 files changed, 87 insertions(+), 0 deletions(-)

diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index 47d53c7..f65cca8 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -377,6 +377,81 @@ static int m25p80_read(struct mtd_info *mtd, loff_t from, size_t len,
 }
 
 /*
+ * Read an address range from the flash chip page by page.
+ * Some controller has transaction length limitation such as the
+ * Freescale's eSPI controller can only trasmit 0xFFFF bytes one
+ * time, so we have to read page by page if the len is more than
+ * the limitation.
+ */
+static int m25p80_page_read(struct mtd_info *mtd, loff_t from, size_t len,
+	size_t *retlen, u_char *buf)
+{
+	struct m25p *flash = mtd_to_m25p(mtd);
+	struct spi_transfer t[2];
+	struct spi_message m;
+	u32 i, page_size = 0;
+
+	DEBUG(MTD_DEBUG_LEVEL2, "%s: %s %s 0x%08x, len %zd\n",
+			dev_name(&flash->spi->dev), __func__, "from",
+			(u32)from, len);
+
+	/* sanity checks */
+	if (!len)
+		return 0;
+
+	if (from + len > flash->mtd.size)
+		return -EINVAL;
+
+	spi_message_init(&m);
+	memset(t, 0, (sizeof t));
+
+	/* NOTE:
+	 * OPCODE_FAST_READ (if available) is faster.
+	 * Should add 1 byte DUMMY_BYTE.
+	 */
+	t[0].tx_buf = flash->command;
+	t[0].len = m25p_cmdsz(flash) + FAST_READ_DUMMY_BYTE;
+	spi_message_add_tail(&t[0], &m);
+
+	t[1].rx_buf = buf;
+	spi_message_add_tail(&t[1], &m);
+
+	/* Byte count starts at zero. */
+	if (retlen)
+		*retlen = 0;
+
+	mutex_lock(&flash->lock);
+
+	/* Wait till previous write/erase is done. */
+	if (wait_till_ready(flash)) {
+		/* REVISIT status return?? */
+		mutex_unlock(&flash->lock);
+		return 1;
+	}
+
+	/* Set up the write data buffer. */
+	flash->command[0] = OPCODE_READ;
+
+	for (i = page_size; i < len; i += page_size) {
+		page_size = len - i;
+		if (page_size > flash->page_size)
+			page_size = flash->page_size;
+		m25p_addr2cmd(flash, from + i, flash->command);
+		t[1].len = page_size;
+		t[1].rx_buf = buf + i;
+
+		spi_sync(flash->spi, &m);
+
+		*retlen += m.actual_length - m25p_cmdsz(flash)
+			- FAST_READ_DUMMY_BYTE;
+	}
+
+	mutex_unlock(&flash->lock);
+
+	return 0;
+}
+
+/*
  * Write an address range to the flash chip.  Data must be written in
  * FLASH_PAGESIZE chunks.  The address range may be any size provided
  * it is within the physical boundaries.
@@ -874,6 +949,9 @@ static int __devinit m25p_probe(struct spi_device *spi)
 	flash->mtd.erase = m25p80_erase;
 	flash->mtd.read = m25p80_read;
 
+	if (spi->master->quirks & SPI_QUIRK_TRANS_LEN_LIMIT)
+		flash->mtd.read = m25p80_page_read;
+
 	/* sst flash chips use AAI word program */
 	if (info->jedec_id >> 16 == 0xbf)
 		flash->mtd.write = sst_write;
diff --git a/drivers/spi/spi_fsl_lib.c b/drivers/spi/spi_fsl_lib.c
index 5cd741f..c8d8c2d 100644
--- a/drivers/spi/spi_fsl_lib.c
+++ b/drivers/spi/spi_fsl_lib.c
@@ -135,6 +135,10 @@ int mpc8xxx_spi_probe(struct device *dev, struct resource *mem,
 	master->cleanup = mpc8xxx_spi_cleanup;
 	master->dev.of_node = dev->of_node;
 
+	if (of_get_property(dev->of_node,
+				"fsl,spi-quirk-trans-len-limit", NULL))
+		master->quirks |= SPI_QUIRK_TRANS_LEN_LIMIT;
+
 	mpc8xxx_spi = spi_master_get_devdata(master);
 	mpc8xxx_spi->dev = dev;
 	mpc8xxx_spi->get_rx = mpc8xxx_spi_rx_buf_u8;
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 92e52a1..4234dfd 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -304,6 +304,11 @@ struct spi_master {
 
 	/* called on release() to free memory provided by spi_master */
 	void			(*cleanup)(struct spi_device *spi);
+
+	/* some constraints of the controller */
+	u16			quirks;
+#define SPI_QUIRK_TRANS_LEN_LIMIT	BIT(0)	/* have trans length limit */
+
 };
 
 static inline void *spi_master_get_devdata(struct spi_master *master)
-- 
1.6.4
