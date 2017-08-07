Return-Path: <geoff@infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:8b0:10b:1231::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xR7sh2FlLzDqp8
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Aug 2017 06:09:28 +1000 (AEST)
Message-Id: <9f412d91a41af6e0a8eb44413a40e154f02bdd3a.1502135910.git.geoff@infradead.org>
In-Reply-To: <cover.1502135910.git.geoff@infradead.org>
References: <cover.1502135910.git.geoff@infradead.org>
From: Geoff Levand <geoff@infradead.org>
Subject: [PATCH 1/3] block/ps3vram: Delete an error message for a failed
 memory allocation in ps3vram_cache_init()
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

From: Markus Elfring <elfring@users.sourceforge.net>

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Link: http://events.linuxfoundation.org/sites/events/files/slides/LCJ16-Refactor_Strings-WSang_0.pdf

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Cc: Jim Paris <jim@jtan.com>
Cc: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 drivers/block/ps3vram.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/block/ps3vram.c b/drivers/block/ps3vram.c
index e0e81cacd781..ba97d037279e 100644
--- a/drivers/block/ps3vram.c
+++ b/drivers/block/ps3vram.c
@@ -409,10 +409,8 @@ static int ps3vram_cache_init(struct ps3_system_bus_device *dev)
 	priv->cache.page_size = CACHE_PAGE_SIZE;
 	priv->cache.tags = kzalloc(sizeof(struct ps3vram_tag) *
 				   CACHE_PAGE_COUNT, GFP_KERNEL);
-	if (priv->cache.tags == NULL) {
-		dev_err(&dev->core, "Could not allocate cache tags\n");
+	if (!priv->cache.tags)
 		return -ENOMEM;
-	}
 
 	dev_info(&dev->core, "Created ram cache: %d entries, %d KiB each\n",
 		CACHE_PAGE_COUNT, CACHE_PAGE_SIZE / 1024);
-- 
2.11.0
