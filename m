Return-Path: <geoff@infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:8b0:10b:1231::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xR7sm5LyLzDqp8
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Aug 2017 06:09:32 +1000 (AEST)
Message-Id: <f1d16f5ac3eb170493ca7835a7c39c1b4675a81f.1502135910.git.geoff@infradead.org>
In-Reply-To: <cover.1502135910.git.geoff@infradead.org>
References: <cover.1502135910.git.geoff@infradead.org>
From: Geoff Levand <geoff@infradead.org>
Subject: [PATCH 2/3] block/ps3vram: Check return of ps3vram_cache_init
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, Jim Paris <jim@jtan.com>,
 Jens Axboe <axboe@kernel.dk>,
 Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 07 Aug 2017 20:09:20 +0000
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Cc: Markus Elfring <elfring@users.sourceforge.net>
Cc: Jim Paris <jim@jtan.com>
Cc: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 drivers/block/ps3vram.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ps3vram.c b/drivers/block/ps3vram.c
index ba97d037279e..6a55959cbf78 100644
--- a/drivers/block/ps3vram.c
+++ b/drivers/block/ps3vram.c
@@ -741,7 +741,11 @@ static int ps3vram_probe(struct ps3_system_bus_device *dev)
 		goto out_unmap_reports;
 	}
 
-	ps3vram_cache_init(dev);
+	error = ps3vram_cache_init(dev);
+	if (error < 0) {
+		goto out_unmap_reports;
+	}
+
 	ps3vram_proc_init(dev);
 
 	queue = blk_alloc_queue(GFP_KERNEL);
-- 
2.11.0
