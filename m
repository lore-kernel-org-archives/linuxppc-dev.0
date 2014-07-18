Return-Path: <nikhil.badola@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0142.outbound.protection.outlook.com [207.46.163.142])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 13A831A01E3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jul 2014 20:19:52 +1000 (EST)
From: Nikhil Badola <nikhil.badola@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc : dma-mapping : Check null condition for
 dev->archdata.dma_ops
Date: Fri, 18 Jul 2014 15:34:52 +0530
Message-ID: <1405677892-7201-1-git-send-email-nikhil.badola@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Nikhil Badola <nikhil.badola@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Modifies get_dma_ops() implementation on ppc arch to check null condition
for dev->archdata.dma_ops; returns common dma_direct_ops structure in
case its NULL

Signed-off-by: Nikhil Badola <nikhil.badola@freescale.com>
---
 arch/powerpc/include/asm/dma-mapping.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
index 150866b..d73bae8 100644
--- a/arch/powerpc/include/asm/dma-mapping.h
+++ b/arch/powerpc/include/asm/dma-mapping.h
@@ -86,10 +86,12 @@ static inline struct dma_map_ops *get_dma_ops(struct device *dev)
 	 */
 	if (unlikely(dev == NULL))
 		return NULL;
-
-	return dev->archdata.dma_ops;
+	if (dev->archdata.dma_ops)
+		return dev->archdata.dma_ops;
+	return &dma_direct_ops;
 }
 
+
 static inline void set_dma_ops(struct device *dev, struct dma_map_ops *ops)
 {
 	dev->archdata.dma_ops = ops;
-- 
1.7.11.7
