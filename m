Return-Path: <jacmet@gmail.com>
Received: from mail-fx0-f215.google.com (mail-fx0-f215.google.com
	[209.85.220.215]) by ozlabs.org (Postfix) with ESMTP id D4A55B6EF0
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Jan 2010 21:24:03 +1100 (EST)
Received: by fxm7 with SMTP id 7so17233992fxm.9
	for <linuxppc-dev@ozlabs.org>; Thu, 07 Jan 2010 02:24:01 -0800 (PST)
Sender: Peter Korsgaard <jacmet@gmail.com>
From: Peter Korsgaard <jacmet@sunsite.dk>
To: avorontsov@ru.mvista.com, dbrownell@users.sourceforge.net,
	galak@kernel.crashing.org, linuxppc-dev@ozlabs.org
Subject: [PATCHv2] spi_mpc8xxx: fix WARN_ON on remove after 4c1fba44296
Date: Thu,  7 Jan 2010 11:23:57 +0100
Message-Id: <1262859837-11311-1-git-send-email-jacmet@sunsite.dk>
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

Changes since v1:
Fix return statement, mpc8xxx_spi_cpm_free() has void return type.
diff --git a/drivers/spi/spi_mpc8xxx.c b/drivers/spi/spi_mpc8xxx.c
index 1fb2a6e..674e7a2 100644
--- a/drivers/spi/spi_mpc8xxx.c
+++ b/drivers/spi/spi_mpc8xxx.c
@@ -946,6 +946,9 @@ static void mpc8xxx_spi_cpm_free(struct mpc8xxx_spi *mspi)
 {
 	struct device *dev = mspi->dev;
 
+	if (!(mspi->flags & SPI_CPM_MODE))
+		return;
+
 	dma_unmap_single(dev, mspi->dma_dummy_rx, SPI_MRBLR, DMA_FROM_DEVICE);
 	dma_unmap_single(dev, mspi->dma_dummy_tx, PAGE_SIZE, DMA_TO_DEVICE);
 	cpm_muram_free(cpm_muram_offset(mspi->tx_bd));
-- 
1.6.5
