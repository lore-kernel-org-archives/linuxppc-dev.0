Return-Path: <geert@sonycom.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id A61E0B7282
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Jun 2009 00:39:20 +1000 (EST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 16/33] ps3vram: Make ps3vram_priv.reports a void *
Date: Wed, 10 Jun 2009 16:38:51 +0200
Message-Id: <1244644748-24211-17-git-send-email-Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <1244644748-24211-16-git-send-email-Geert.Uytterhoeven@sonycom.com>
References: <1244644748-24211-1-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-2-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-3-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-4-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-5-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-6-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-7-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-8-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-9-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-10-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-11-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-12-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-13-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-14-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-15-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-16-git-send-email-Geert.Uytterhoeven@sonycom.com>
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

So we can kill a cast.

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: Jim Paris <jim@jtan.com>
Cc: Jens Axboe <axboe@kernel.dk>
---
 drivers/block/ps3vram.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/ps3vram.c b/drivers/block/ps3vram.c
index 5f408c6..fbbdd5c 100644
--- a/drivers/block/ps3vram.c
+++ b/drivers/block/ps3vram.c
@@ -72,7 +72,7 @@ struct ps3vram_priv {
 	u64 memory_handle;
 	u64 context_handle;
 	u32 *ctrl;
-	u32 *reports;
+	void *reports;
 	u8 *xdr_buf;
 
 	u32 *fifo_base;
@@ -102,9 +102,9 @@ static char *size = "256M";
 module_param(size, charp, 0);
 MODULE_PARM_DESC(size, "memory size");
 
-static u32 *ps3vram_get_notifier(u32 *reports, int notifier)
+static u32 *ps3vram_get_notifier(void *reports, int notifier)
 {
-	return (void *)reports + DMA_NOTIFIER_OFFSET_BASE +
+	return reports + DMA_NOTIFIER_OFFSET_BASE +
 	       DMA_NOTIFIER_SIZE * notifier;
 }
 
-- 
1.6.2.4
