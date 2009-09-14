Return-Path: <John.Linn@xilinx.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id BB230B6F2B
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 15 Sep 2009 04:17:13 +1000 (EST)
Received: from SG2EHSOBE004.bigfish.com (sg2ehsobe004.messaging.microsoft.com
	[207.46.51.78]) by ozlabs.org (Postfix) with ESMTP id 45A97DDD04
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Sep 2009 04:17:12 +1000 (EST)
From: John Linn <john.linn@xilinx.com>
To: dbrownell@users.sourceforge.net, linuxppc-dev@ozlabs.org,
	grant.likely@secretlab.ca, jwboyer@linux.vnet.ibm.com,
	akonovalov@ru.mvista.com
Subject: [PATCH] Xilinx: SPI: Fix bits_per_word for transfers
Date: Mon, 14 Sep 2009 12:17:05 -0600
Message-ID: <20090914181617.ACF4B17B804F@mail59-sin.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: John Linn <john.linn@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The bits_per_word value can be set for each transfer, or can
be set to zero in each transfer in which case it should default
to the value in the driver.

The driver was fixed to properly check the bits_per_word in
the transfer that is passed in.

Signed-off-by: John Linn <john.linn@xilinx.com>
---
 drivers/spi/xilinx_spi.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/xilinx_spi.c b/drivers/spi/xilinx_spi.c
index 46b8c5c..5a143b9 100644
--- a/drivers/spi/xilinx_spi.c
+++ b/drivers/spi/xilinx_spi.c
@@ -148,7 +148,8 @@ static int xilinx_spi_setup_transfer(struct spi_device *spi,
 {
 	u8 bits_per_word;
 
-	bits_per_word = (t) ? t->bits_per_word : spi->bits_per_word;
+	bits_per_word = (t && t->bits_per_word)
+			 ? t->bits_per_word : spi->bits_per_word;
 	if (bits_per_word != 8) {
 		dev_err(&spi->dev, "%s, unsupported bits_per_word=%d\n",
 			__func__, bits_per_word);
-- 
1.6.2.1



This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
