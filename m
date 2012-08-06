Return-Path: <B32616@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe005.messaging.microsoft.com [216.32.180.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 186AF2C0B23
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Aug 2012 20:41:29 +1000 (EST)
From: <qiang.liu@freescale.com>
To: <linux-crypto@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <dan.j.williams@intel.com>, <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
 <linux-kernel@vger.kernel.org>, <dan.j.williams@gmail.com>,
 <vinod.koul@intel.com>
Subject: [PATCH v6 8/8] carma: remove unnecessary DMA_INTERRUPT capability
Date: Mon, 6 Aug 2012 18:15:13 +0800
Message-ID: <1344248113-9398-1-git-send-email-qiang.liu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Qiang Liu <qiang.liu@freescale.com>, herbert@gondor.hengli.com.au,
 davem@davemloft.net, "Ira W. Snyder" <iws@ovro.caltech.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Qiang Liu <qiang.liu@freescale.com>

These drivers set the DMA_INTERRUPT capability bit when requesting a DMA
controller channel. This was historical, and is no longer needed.

Recent changes to the drivers/dma/fsldma.c driver have removed support
for this flag. This makes the carma drivers unable to find a DMA channel
with the required capabilities.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
---
Based on git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
against branch char-misc-next.

 drivers/misc/carma/carma-fpga-program.c |    1 -
 drivers/misc/carma/carma-fpga.c         |    2 +-
 2 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/carma/carma-fpga-program.c b/drivers/misc/carma/carma-fpga-program.c
index a2d25e4..eaddfe9 100644
--- a/drivers/misc/carma/carma-fpga-program.c
+++ b/drivers/misc/carma/carma-fpga-program.c
@@ -978,7 +978,6 @@ static int fpga_of_probe(struct platform_device *op)
 	dev_set_drvdata(priv->dev, priv);
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_MEMCPY, mask);
-	dma_cap_set(DMA_INTERRUPT, mask);
 	dma_cap_set(DMA_SLAVE, mask);
 	dma_cap_set(DMA_SG, mask);

diff --git a/drivers/misc/carma/carma-fpga.c b/drivers/misc/carma/carma-fpga.c
index 8c279da..0c43297 100644
--- a/drivers/misc/carma/carma-fpga.c
+++ b/drivers/misc/carma/carma-fpga.c
@@ -666,7 +666,7 @@ static int data_submit_dma(struct fpga_device *priv, struct data_buf *buf)
 	src = SYS_FPGA_BLOCK;
 	tx = chan->device->device_prep_dma_memcpy(chan, dst, src,
 						  REG_BLOCK_SIZE,
-						  DMA_PREP_INTERRUPT);
+						  0);
 	if (!tx) {
 		dev_err(priv->dev, "unable to prep SYS-FPGA DMA\n");
 		return -ENOMEM;
--
1.7.5.1
