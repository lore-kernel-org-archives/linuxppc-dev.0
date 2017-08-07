Return-Path: <elfring@users.sourceforge.net>
Received: from mout.web.de (mout.web.de [212.227.15.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xQvWk2Rw4zDqjB
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Aug 2017 20:53:05 +1000 (AEST)
To: linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Geoff Levand <geoff@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Paul Mackerras <paulus@samba.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] block/ps3vram: Delete an error message for a failed memory
 allocation in ps3vram_cache_init()
Message-ID: <e22ee16a-5f34-46bd-577f-9b7ca75e9035@users.sourceforge.net>
Date: Mon, 7 Aug 2017 12:52:10 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 7 Aug 2017 12:37:01 +0200

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Link: http://events.linuxfoundation.org/sites/events/files/slides/LCJ16-Refactor_Strings-WSang_0.pdf
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
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
2.13.4
