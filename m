Return-Path: <geert@sonycom.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 7AE89B7117
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Jun 2009 00:39:15 +1000 (EST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 03/33] ps3vram: Use proc_create_data() instead of proc_create()
Date: Wed, 10 Jun 2009 16:38:38 +0200
Message-Id: <1244644748-24211-4-git-send-email-Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <1244644748-24211-3-git-send-email-Geert.Uytterhoeven@sonycom.com>
References: <1244644748-24211-1-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-2-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-3-git-send-email-Geert.Uytterhoeven@sonycom.com>
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

Use proc_create_data() to avoid race conditions.

Reported-by: Alexey Dobriyan <adobriyan@gmail.com>
Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: Jim Paris <jim@jtan.com>
Cc: Jens Axboe <axboe@kernel.dk>
---
 drivers/block/ps3vram.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/block/ps3vram.c b/drivers/block/ps3vram.c
index 2e79d2c..6e73868 100644
--- a/drivers/block/ps3vram.c
+++ b/drivers/block/ps3vram.c
@@ -546,12 +546,10 @@ static void __devinit ps3vram_proc_init(struct ps3_system_bus_device *dev)
 	struct ps3vram_priv *priv = dev->core.driver_data;
 	struct proc_dir_entry *pde;
 
-	pde = proc_create(DEVICE_NAME, 0444, NULL, &ps3vram_proc_fops);
-	if (!pde) {
+	pde = proc_create_data(DEVICE_NAME, 0444, NULL, &ps3vram_proc_fops,
+			       priv);
+	if (!pde)
 		dev_warn(&dev->core, "failed to create /proc entry\n");
-		return;
-	}
-	pde->data = priv;
 }
 
 static int ps3vram_make_request(struct request_queue *q, struct bio *bio)
-- 
1.6.2.4
