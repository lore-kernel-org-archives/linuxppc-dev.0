Return-Path: <B21284@freescale.com>
Received: from DB3EHSOBE006.bigfish.com (db3ehsobe006.messaging.microsoft.com
	[213.199.154.144]) by ozlabs.org (Postfix) with ESMTP id 9372A100808
	for <linuxppc-dev@ozlabs.org>; Mon,  2 Aug 2010 18:22:39 +1000 (EST)
Received: from mail56-db3 (localhost.localdomain [127.0.0.1])	by
	mail56-db3-R.bigfish.com (Postfix) with ESMTP id BC4B01A80130	for
	<linuxppc-dev@ozlabs.org>; Mon,  2 Aug 2010 08:07:26 +0000 (UTC)
Received: from DB3EHSMHS005.bigfish.com (unknown [10.3.81.248])	by
	mail56-db3.bigfish.com (Postfix) with ESMTP id 0CB04130065	for
	<linuxppc-dev@ozlabs.org>; Mon,  2 Aug 2010 08:07:26 +0000 (UTC)
Received: from az33smr02.freescale.net (az33smr02.freescale.net
	[10.64.34.200])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id o7287Cvl012346	for <linuxppc-dev@ozlabs.org>;
	Mon, 2 Aug 2010 01:07:22 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP
	id o7287BM4014167	for <linuxppc-dev@ozlabs.org>;
	Mon, 2 Aug 2010 03:07:17 -0500 (CDT)
From: Mingkai Hu <Mingkai.hu@freescale.com>
To: linuxppc-dev@ozlabs.org, spi-devel-general@lists.sourceforge.net
Subject: [PATCH v2 4/6] mtd: m25p80: add a read function to read page by page
Date: Mon, 2 Aug 2010 15:52:02 +0800
Message-ID: <1280735524-17547-5-git-send-email-Mingkai.hu@freescale.com>
In-Reply-To: <1280735524-17547-4-git-send-email-Mingkai.hu@freescale.com>
References: <1280735524-17547-1-git-send-email-Mingkai.hu@freescale.com>
	<1280735524-17547-2-git-send-email-Mingkai.hu@freescale.com>
	<1280735524-17547-3-git-send-email-Mingkai.hu@freescale.com>
	<1280735524-17547-4-git-send-email-Mingkai.hu@freescale.com>
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

v2:
 - Add SPI_MASTER_TRANS_LIMIT flag to indicate the master's trans length
   limitation, so the MTD driver can select the correct transfer behaviour
   at driver probe time

 drivers/mtd/devices/m25p80.c |   78 ++++++++++++++++++++++++++++++++++++++++++
 drivers/spi/spi_fsl_espi.c   |    1 +
 include/linux/spi/spi.h      |    1 +
 3 files changed, 80 insertions(+), 0 deletions(-)

diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index 5f00075..30e4568 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -376,6 +376,81 @@ static int m25p80_read(struct mtd_info *mtd, loff_t from, size_t len,
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
@@ -877,6 +952,9 @@ static int __devinit m25p_probe(struct spi_device *spi)
 	flash->mtd.erase = m25p80_erase;
 	flash->mtd.read = m25p80_read;
 
+	if (spi->master->flags & SPI_MASTER_TRANS_LIMIT)
+		flash->mtd.read = m25p80_page_read;
+
 	/* sst flash chips use AAI word program */
 	if (info->jedec_id >> 16 == 0xbf)
 		flash->mtd.write = sst_write;
diff --git a/drivers/spi/spi_fsl_espi.c b/drivers/spi/spi_fsl_espi.c
index 61987cf..e15b7dc 100644
--- a/drivers/spi/spi_fsl_espi.c
+++ b/drivers/spi/spi_fsl_espi.c
@@ -470,6 +470,7 @@ static struct spi_master * __devinit fsl_espi_probe(struct device *dev,
 		goto err_probe;
 
 	master->setup = fsl_espi_setup;
+	master->flags = SPI_MASTER_TRANS_LIMIT;
 
 	mpc8xxx_spi = spi_master_get_devdata(master);
 	mpc8xxx_spi->spi_do_one_msg = fsl_espi_do_one_msg;
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index af56071..0729cbd 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -261,6 +261,7 @@ struct spi_master {
 #define SPI_MASTER_HALF_DUPLEX	BIT(0)		/* can't do full duplex */
 #define SPI_MASTER_NO_RX	BIT(1)		/* can't do buffer read */
 #define SPI_MASTER_NO_TX	BIT(2)		/* can't do buffer write */
+#define SPI_MASTER_TRANS_LIMIT	BIT(3)		/* have trans length limit */
 
 	/* Setup mode and clock, etc (spi driver may call many times).
 	 *
-- 
1.6.4
