Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0239.outbound.protection.outlook.com [207.46.163.239])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EBC4F1A0A8A
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Aug 2014 09:41:12 +1000 (EST)
From: Scott Wood <scottwood@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 3/4] powerpc/64: Limit ZONE_DMA32 to 4GiB in
 swiotlb_detect_4g()
Date: Fri, 8 Aug 2014 18:40:44 -0500
Message-ID: <1407541245-27617-3-git-send-email-scottwood@freescale.com>
In-Reply-To: <1407541245-27617-1-git-send-email-scottwood@freescale.com>
References: <1407541245-27617-1-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 Shaohui Xie <Shaohui.Xie@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

A DMA zone is still needed with swiotlb, for coherent allocations.
This doesn't affect platforms that don't use swiotlb or that don't call
swiotlb_detect_4g().

Signed-off-by: Scott Wood <scottwood@freescale.com>
Cc: Shaohui Xie <Shaohui.Xie@freescale.com>
---
 arch/powerpc/kernel/dma-swiotlb.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/dma-swiotlb.c b/arch/powerpc/kernel/dma-swiotlb.c
index bd1a2ab..7359797 100644
--- a/arch/powerpc/kernel/dma-swiotlb.c
+++ b/arch/powerpc/kernel/dma-swiotlb.c
@@ -106,10 +106,14 @@ int __init swiotlb_setup_bus_notifier(void)
 	return 0;
 }
 
-void swiotlb_detect_4g(void)
+void __init swiotlb_detect_4g(void)
 {
-	if ((memblock_end_of_DRAM() - 1) > 0xffffffff)
+	if ((memblock_end_of_DRAM() - 1) > 0xffffffff) {
 		ppc_swiotlb_enable = 1;
+#ifdef CONFIG_ZONE_DMA32
+		limit_zone_pfn(ZONE_DMA32, (1ULL << 32) >> PAGE_SHIFT);
+#endif
+	}
 }
 
 static int __init swiotlb_late_init(void)
-- 
1.9.1
