Return-Path: <geert@sonycom.com>
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] ps3vram: Use proc_create_data() instead of proc_create()
Date: Fri,  3 Apr 2009 15:05:36 +0200
Message-Id: <1238763938-7076-2-git-send-email-Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <1238763938-7076-1-git-send-email-Geert.Uytterhoeven@sonycom.com>
References: <1238763938-7076-1-git-send-email-Geert.Uytterhoeven@sonycom.com>
Sender: Geert Uytterhoeven <geert@sonycom.com>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Use proc_create_data() to avoid race conditions.

Reported-by: Alexey Dobriyan <adobriyan@gmail.com>
Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
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
1.6.0.4
