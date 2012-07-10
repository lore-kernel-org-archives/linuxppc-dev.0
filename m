Return-Path: <B32616@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9EE962C03C0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jul 2012 16:21:24 +1000 (EST)
From: Qiang Liu <qiang.liu@freescale.com>
To: <linux-crypto@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 4/4] Talitos: fix the issue of dma memory leak
Date: Tue, 10 Jul 2012 14:00:14 +0800
Message-ID: <1341900014-20915-1-git-send-email-qiang.liu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Qiang Liu <qiang.liu@freescale.com>,
 Herbert Xu <herbert@gondor.hengli.com.au>, "David
 S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

An error will be happened when test with mass data:
"DMA-API: device driver tries to sync DMA memory it has not allocated";
"DMA-API: debugging out of memory - disabling"
dma mapping memory of request->desc is not released by right device,
it should be private->dev but not dev;

Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: David S. Miller <davem@davemloft.net>
Signed-off-by: Qiang Liu <qiang.liu@freescale.com>
---
 drivers/crypto/talitos.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/crypto/talitos.c b/drivers/crypto/talitos.c
index 81f8497..a7da48c 100644
--- a/drivers/crypto/talitos.c
+++ b/drivers/crypto/talitos.c
@@ -264,7 +264,7 @@ static void flush_channel(struct device *dev, int ch, int error, int reset_ch)
 			else
 				status = error;

-		dma_unmap_single(dev, request->dma_desc,
+		 dma_unmap_single(priv->dev, request->dma_desc,
 				 sizeof(struct talitos_desc),
 				 DMA_BIDIRECTIONAL);

--
1.7.5.1
