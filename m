Return-Path: <B29237@freescale.com>
Received: from TX2EHSOBE004.bigfish.com (tx2ehsobe002.messaging.microsoft.com
 [65.55.88.12]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 0B07BB6FD3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Dec 2011 18:19:31 +1100 (EST)
From: <b29237@freescale.com>
To: <vinod.koul@intel.com>, <dan.j.williams@intel.com>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
 <r58472@freescale.com>
Subject: [PATCH] 	dmaengine: async_xor,
 fix zero address issue when xor highmem page
Date: Tue, 27 Dec 2011 14:30:46 +0800
Message-ID: <1324967446-28939-1-git-send-email-b29237@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Forrest shi <b29237@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Forrest shi <b29237@freescale.com>

	we may do_sync_xor high mem pages, in this case, page_address will
        return zero address which cause a failure.

	this patch uses kmap_atomic before xor the pages and kunmap_atomic
        after it.

	Signed-off-by: b29237@freescale.com <xuelin.shi@freescale.com>
---
 crypto/async_tx/async_xor.c |   16 ++++++++++++----
 1 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/crypto/async_tx/async_xor.c b/crypto/async_tx/async_xor.c
index bc28337..5b416d1 100644
--- a/crypto/async_tx/async_xor.c
+++ b/crypto/async_tx/async_xor.c
@@ -26,6 +26,7 @@
 #include <linux/kernel.h>
 #include <linux/interrupt.h>
 #include <linux/mm.h>
+#include <linux/highmem.h>
 #include <linux/dma-mapping.h>
 #include <linux/raid/xor.h>
 #include <linux/async_tx.h>
@@ -126,7 +127,7 @@ do_sync_xor(struct page *dest, struct page **src_list, unsigned int offset,
 	    int src_cnt, size_t len, struct async_submit_ctl *submit)
 {
 	int i;
-	int xor_src_cnt = 0;
+	int xor_src_cnt = 0, kmap_cnt=0;
 	int src_off = 0;
 	void *dest_buf;
 	void **srcs;
@@ -138,11 +139,13 @@ do_sync_xor(struct page *dest, struct page **src_list, unsigned int offset,
 
 	/* convert to buffer pointers */
 	for (i = 0; i < src_cnt; i++)
-		if (src_list[i])
-			srcs[xor_src_cnt++] = page_address(src_list[i]) + offset;
+		if (src_list[i]) {
+			srcs[xor_src_cnt++] = kmap_atomic(src_list[i], KM_USER1) + offset;
+		}
+	kmap_cnt = xor_src_cnt;
 	src_cnt = xor_src_cnt;
 	/* set destination address */
-	dest_buf = page_address(dest) + offset;
+	dest_buf = kmap_atomic(dest, KM_USER0) + offset;
 
 	if (submit->flags & ASYNC_TX_XOR_ZERO_DST)
 		memset(dest_buf, 0, len);
@@ -157,6 +160,11 @@ do_sync_xor(struct page *dest, struct page **src_list, unsigned int offset,
 		src_off += xor_src_cnt;
 	}
 
+	kunmap_atomic(dest_buf, KM_USER0);
+	for (i = 0; i < kmap_cnt; i++) 
+		if (src_list[i])
+			kunmap_atomic(srcs[i], KM_USER1);
+
 	async_tx_sync_epilog(submit);
 }
 
-- 
1.7.0.4
