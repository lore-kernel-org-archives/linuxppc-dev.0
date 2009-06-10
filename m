Return-Path: <geert@sonycom.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 36DADB7147
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Jun 2009 00:39:16 +1000 (EST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 04/33] ps3vram: Correct exchanged gotos in ps3vram_probe()
	error path
Date: Wed, 10 Jun 2009 16:38:39 +0200
Message-Id: <1244644748-24211-5-git-send-email-Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <1244644748-24211-4-git-send-email-Geert.Uytterhoeven@sonycom.com>
References: <1244644748-24211-1-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-2-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-3-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-4-git-send-email-Geert.Uytterhoeven@sonycom.com>
Sender: Geert Uytterhoeven <geert@sonycom.com>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	linuxppc-dev@ozlabs.org, Jens Axboe <axboe@kernel.dk>,
	cbe-oss-dev@ozlabs.org, Jim Paris <jim@jtan.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Jim Paris <jim@jtan.com>

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: Jim Paris <jim@jtan.com>
Cc: Jens Axboe <axboe@kernel.dk>
---
 drivers/block/ps3vram.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/ps3vram.c b/drivers/block/ps3vram.c
index 6e73868..3c9ad19 100644
--- a/drivers/block/ps3vram.c
+++ b/drivers/block/ps3vram.c
@@ -635,7 +635,7 @@ static int __devinit ps3vram_probe(struct ps3_system_bus_device *dev)
 	if (ps3_open_hv_device(dev)) {
 		dev_err(&dev->core, "ps3_open_hv_device failed\n");
 		error = -EAGAIN;
-		goto out_close_gpu;
+		goto out_free_xdr_buf;
 	}
 
 	/* Request memory */
@@ -659,7 +659,7 @@ static int __devinit ps3vram_probe(struct ps3_system_bus_device *dev)
 		dev_err(&dev->core, "lv1_gpu_memory_allocate failed %d\n",
 			status);
 		error = -ENOMEM;
-		goto out_free_xdr_buf;
+		goto out_close_gpu;
 	}
 
 	/* Request context */
-- 
1.6.2.4
