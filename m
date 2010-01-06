Return-Path: <jacmet@gmail.com>
Received: from mail-ew0-f214.google.com (mail-ew0-f214.google.com
	[209.85.219.214]) by ozlabs.org (Postfix) with ESMTP id 7D9FCB6EFE
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Jan 2010 02:57:19 +1100 (EST)
Received: by ewy6 with SMTP id 6so16286999ewy.9
	for <linuxppc-dev@ozlabs.org>; Wed, 06 Jan 2010 07:57:17 -0800 (PST)
Sender: Peter Korsgaard <jacmet@gmail.com>
From: Peter Korsgaard <jacmet@sunsite.dk>
To: avorontsov@ru.mvista.com, dbrownell@users.sourceforge.net,
	galak@kernel.crashing.org, linuxppc-dev@ozlabs.org
Subject: [PATCH] spi_mpc8xxx: fix WARN_ON on remove after 4c1fba44296
Date: Wed,  6 Jan 2010 16:57:11 +0100
Message-Id: <1262793431-24214-1-git-send-email-jacmet@sunsite.dk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 4c1fba44296 (Add support for QE DMA mode and CPM1/CPM2 chips)
added unconditional calls to _cpm_init() / _cpm_free() from
probe()/remove(), but only checked if we're actually using CPM mode
in _init(), causing the WARN_ON in mpc8xxx_spi_free_dummy_rx() for !CPM.

Fix it by adding the same check in _cpm_free() as well.

Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
---
 drivers/spi/spi_mpc8xxx.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/spi/spi_mpc8xxx.c b/drivers/spi/spi_mpc8xxx.c
index 1fb2a6e..0604d6b 100644
--- a/drivers/spi/spi_mpc8xxx.c
+++ b/drivers/spi/spi_mpc8xxx.c
@@ -946,6 +946,9 @@ static void mpc8xxx_spi_cpm_free(struct mpc8xxx_spi *mspi)
 {
 	struct device *dev = mspi->dev;
 
+	if (!(mspi->flags & SPI_CPM_MODE))
+		return 0;
+
 	dma_unmap_single(dev, mspi->dma_dummy_rx, SPI_MRBLR, DMA_FROM_DEVICE);
 	dma_unmap_single(dev, mspi->dma_dummy_tx, PAGE_SIZE, DMA_TO_DEVICE);
 	cpm_muram_free(cpm_muram_offset(mspi->tx_bd));
-- 
1.6.5
