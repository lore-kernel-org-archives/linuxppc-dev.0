Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 02/18] powerpc/crypto: Remove users of virt_to_abs() and
 phys_to_abs() in nx crypto driver
Date: Thu, 26 Jul 2012 17:19:48 +1000
Message-Id: <1343287204-7700-2-git-send-email-michael@ellerman.id.au>
In-Reply-To: <1343287204-7700-1-git-send-email-michael@ellerman.id.au>
References: <1343287204-7700-1-git-send-email-michael@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

phys_to_abs() is a nop, don't use it.

virt_to_abs() is just a wrapper around __pa(), call __pa() directly.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 drivers/crypto/nx/nx.c |   17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/crypto/nx/nx.c b/drivers/crypto/nx/nx.c
index d7f179c..638110e 100644
--- a/drivers/crypto/nx/nx.c
+++ b/drivers/crypto/nx/nx.c
@@ -34,7 +34,6 @@
 #include <linux/device.h>
 #include <linux/of.h>
 #include <asm/pSeries_reconfig.h>
-#include <asm/abs_addr.h>
 #include <asm/hvcall.h>
 #include <asm/vio.h>
 
@@ -104,10 +103,10 @@ struct nx_sg *nx_build_sg_list(struct nx_sg *sg_head,
 	/* determine the start and end for this address range - slightly
 	 * different if this is in VMALLOC_REGION */
 	if (is_vmalloc_addr(start_addr))
-		sg_addr = phys_to_abs(page_to_phys(vmalloc_to_page(start_addr)))
+		sg_addr = page_to_phys(vmalloc_to_page(start_addr))
 			  + offset_in_page(sg_addr);
 	else
-		sg_addr = virt_to_abs(sg_addr);
+		sg_addr = __pa(sg_addr);
 
 	end_addr = sg_addr + len;
 
@@ -265,17 +264,17 @@ void nx_ctx_init(struct nx_crypto_ctx *nx_ctx, unsigned int function)
 	nx_ctx->csbcpb->csb.valid |= NX_CSB_VALID_BIT;
 
 	nx_ctx->op.flags = function;
-	nx_ctx->op.csbcpb = virt_to_abs(nx_ctx->csbcpb);
-	nx_ctx->op.in = virt_to_abs(nx_ctx->in_sg);
-	nx_ctx->op.out = virt_to_abs(nx_ctx->out_sg);
+	nx_ctx->op.csbcpb = __pa(nx_ctx->csbcpb);
+	nx_ctx->op.in = __pa(nx_ctx->in_sg);
+	nx_ctx->op.out = __pa(nx_ctx->out_sg);
 
 	if (nx_ctx->csbcpb_aead) {
 		nx_ctx->csbcpb_aead->csb.valid |= NX_CSB_VALID_BIT;
 
 		nx_ctx->op_aead.flags = function;
-		nx_ctx->op_aead.csbcpb = virt_to_abs(nx_ctx->csbcpb_aead);
-		nx_ctx->op_aead.in = virt_to_abs(nx_ctx->in_sg);
-		nx_ctx->op_aead.out = virt_to_abs(nx_ctx->out_sg);
+		nx_ctx->op_aead.csbcpb = __pa(nx_ctx->csbcpb_aead);
+		nx_ctx->op_aead.in = __pa(nx_ctx->in_sg);
+		nx_ctx->op_aead.out = __pa(nx_ctx->out_sg);
 	}
 }
 
-- 
1.7.9.5
