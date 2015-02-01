Return-Path: <colin.king@canonical.com>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8793E1A0D2F
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Feb 2015 08:41:27 +1100 (AEDT)
From: Colin King <colin.king@canonical.com>
To: Ian Munsie <imunsie@au1.ibm.com>, Michael Neuling <mikey@neuling.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] cxl: remove redundant increment of hwirq
Date: Sun,  1 Feb 2015 21:40:08 +0000
Message-Id: <1422826808-31363-1-git-send-email-colin.king@canonical.com>
Cc: linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Colin Ian King <colin.king@canonical.com>

Recent commit 80fa93fce37d3490f
("cxl: Name interrupts in /proc/interrupt") introduced a
redundant increment of hwirq which is not used or even
initialised at the point it is incremented. Detected by
cppcheck:

[drivers/misc/cxl/irq.c:439]: (error) Uninitialized
  variable: hwirq

Simple fix, remove the redundant increment.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/misc/cxl/irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/cxl/irq.c b/drivers/misc/cxl/irq.c
index c294925..68ab608 100644
--- a/drivers/misc/cxl/irq.c
+++ b/drivers/misc/cxl/irq.c
@@ -436,7 +436,7 @@ int afu_register_irqs(struct cxl_context *ctx, u32 count)
 	 */
 	INIT_LIST_HEAD(&ctx->irq_names);
 	for (r = 1; r < CXL_IRQ_RANGES; r++) {
-		for (i = 0; i < ctx->irqs.range[r]; hwirq++, i++) {
+		for (i = 0; i < ctx->irqs.range[r]; i++) {
 			irq_name = kmalloc(sizeof(struct cxl_irq_name),
 					   GFP_KERNEL);
 			if (!irq_name)
-- 
2.1.4
