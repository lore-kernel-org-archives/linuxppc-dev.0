Return-Path: <geert@sonycom.com>
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] ps3vram: Correct exchanged gotos in ps3vram_probe() error path
Date: Fri,  3 Apr 2009 15:05:37 +0200
Message-Id: <1238763938-7076-3-git-send-email-Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <1238763938-7076-2-git-send-email-Geert.Uytterhoeven@sonycom.com>
References: <1238763938-7076-1-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1238763938-7076-2-git-send-email-Geert.Uytterhoeven@sonycom.com>
Sender: Geert Uytterhoeven <geert@sonycom.com>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	Jim Paris <jim@jtan.com>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Jim Paris <jim@jtan.com>

From: Jim Paris <jim@jtan.com>

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
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
1.6.0.4
