Return-Path: <B21284@freescale.com>
Received: from VA3EHSOBE009.bigfish.com (va3ehsobe006.messaging.microsoft.com
	[216.32.180.16]) by ozlabs.org (Postfix) with ESMTP id CAFA2B6EFF
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jul 2010 12:21:29 +1000 (EST)
Received: from mail6-va3 (localhost.localdomain [127.0.0.1])	by
	mail6-va3-R.bigfish.com (Postfix) with ESMTP id 107A96C0728	for
	<linuxppc-dev@ozlabs.org>; Tue, 20 Jul 2010 02:21:27 +0000 (UTC)
Received: from VA3EHSMHS020.bigfish.com (unknown [10.7.14.252])	by
	mail6-va3.bigfish.com (Postfix) with ESMTP id AC8D41700052	for
	<linuxppc-dev@ozlabs.org>; Tue, 20 Jul 2010 02:21:26 +0000 (UTC)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP id
	o6K2LODG006760	for
	<linuxppc-dev@ozlabs.org>; Mon, 19 Jul 2010 19:21:24 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP
	id o6K2XWDh023963	for <linuxppc-dev@ozlabs.org>;
	Mon, 19 Jul 2010 21:33:40 -0500 (CDT)
From: Mingkai Hu <Mingkai.hu@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 4/6] mtd: m25p80: change the read function to read page by page
Date: Tue, 20 Jul 2010 10:08:23 +0800
Message-ID: <1279591705-7574-5-git-send-email-Mingkai.hu@freescale.com>
In-Reply-To: <1279591705-7574-4-git-send-email-Mingkai.hu@freescale.com>
References: <1279591705-7574-1-git-send-email-Mingkai.hu@freescale.com>
	<1279591705-7574-2-git-send-email-Mingkai.hu@freescale.com>
	<1279591705-7574-3-git-send-email-Mingkai.hu@freescale.com>
	<1279591705-7574-4-git-send-email-Mingkai.hu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Mingkai Hu <Mingkai.hu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For Freescale's eSPI controller, the max transaction length one time
is limitted by the SPCOM[TRANSLEN] field which is 0x10000. When used
mkfs.ext2 command to create ext2 filesystem on the flash, the read
length will exceed the max value of the SPCOM[TRANSLEN] field, so
change the read function to read page by page.

For other SPI flash driver, also needed to change the read function
if used the eSPI controller.

Signed-off-by: Mingkai Hu <Mingkai.hu@freescale.com>
---
 drivers/mtd/devices/m25p80.c |   18 ++++++++++++++----
 1 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index 81e49a9..6cbe6b1 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -317,6 +317,7 @@ static int m25p80_read(struct mtd_info *mtd, loff_t from, size_t len,
 	struct m25p *flash = mtd_to_m25p(mtd);
 	struct spi_transfer t[2];
 	struct spi_message m;
+	u32 i, page_size = 0;
 
 	DEBUG(MTD_DEBUG_LEVEL2, "%s: %s %s 0x%08x, len %zd\n",
 			dev_name(&flash->spi->dev), __func__, "from",
@@ -341,7 +342,6 @@ static int m25p80_read(struct mtd_info *mtd, loff_t from, size_t len,
 	spi_message_add_tail(&t[0], &m);
 
 	t[1].rx_buf = buf;
-	t[1].len = len;
 	spi_message_add_tail(&t[1], &m);
 
 	/* Byte count starts at zero. */
@@ -364,11 +364,21 @@ static int m25p80_read(struct mtd_info *mtd, loff_t from, size_t len,
 
 	/* Set up the write data buffer. */
 	flash->command[0] = OPCODE_READ;
-	m25p_addr2cmd(flash, from, flash->command);
 
-	spi_sync(flash->spi, &m);
+	for (i = page_size; i < len; i += page_size) {
+		page_size = len - i;
+		if (page_size > flash->page_size)
+			page_size = flash->page_size;
 
-	*retlen = m.actual_length - m25p_cmdsz(flash) - FAST_READ_DUMMY_BYTE;
+		m25p_addr2cmd(flash, from + i, flash->command);
+		t[1].len = page_size;
+		t[1].rx_buf = buf + i;
+
+		spi_sync(flash->spi, &m);
+
+		*retlen += m.actual_length - m25p_cmdsz(flash)
+			- FAST_READ_DUMMY_BYTE;
+	}
 
 	mutex_unlock(&flash->lock);
 
-- 
1.6.4
