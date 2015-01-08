Return-Path: <colin.king@canonical.com>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 56D331A0F57
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Jan 2015 09:37:53 +1100 (AEDT)
From: Colin King <colin.king@canonical.com>
To: Ian Munsie <imunsie@au1.ibm.com>, Michael Neuling <mikey@neuling.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] cxl: remove redundant increment of hwirq
Date: Thu,  8 Jan 2015 22:36:47 +0000
Message-Id: <1420756607-23459-1-git-send-email-colin.king@canonical.com>
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

hwirq has not been initialized, however it is being incremented
and also not being referenced in a loop.  This error was detected with
cppcheck:

[drivers/misc/cxl/irq.c:439]: (error) Uninitialized variable: hwirq

Commit 80fa93fce37d ("cxl: Name interrupts in /proc/interrupt") 
introduced this error.

This is a simple fix that removes the redundant increment.

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
