Return-Path: <B41889@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe005.messaging.microsoft.com [213.199.154.208])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2D2E02C0093
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Nov 2012 15:29:16 +1100 (EST)
Received: from mail4-am1 (localhost [127.0.0.1])	by mail4-am1-R.bigfish.com
 (Postfix) with ESMTP id 7731B2A0054	for <linuxppc-dev@lists.ozlabs.org>; Fri,
 23 Nov 2012 04:29:10 +0000 (UTC)
Received: from AM1EHSMHS003.bigfish.com (unknown [10.3.201.243])	by
 mail4-am1.bigfish.com (Postfix) with ESMTP id 34797400B7	for
 <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Nov 2012 04:29:09 +0000 (UTC)
From: Yuanquan Chen <B41889@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/pci-hotplug: fix the rescanned pci device's
 dma_set_mask issue
Date: Fri, 23 Nov 2012 12:29:28 +0800
Message-ID: <1353644968-29469-1-git-send-email-B41889@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: r61911@freescale.com, Yuanquan Chen <B41889@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On powerpc arch, dma_ops of rescanned pci device after system's booting up won't be
initialized by system, so it will fail to execute the dma_set_mask in the device's
driver. Initialize it to solve this issue.

Signed-off-by: Yuanquan Chen <B41889@freescale.com>
---
 arch/powerpc/include/asm/dma-mapping.h |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
index 7816087..22eae53 100644
--- a/arch/powerpc/include/asm/dma-mapping.h
+++ b/arch/powerpc/include/asm/dma-mapping.h
@@ -126,8 +126,11 @@ static inline int dma_supported(struct device *dev, u64 mask)
 {
 	struct dma_map_ops *dma_ops = get_dma_ops(dev);
 
-	if (unlikely(dma_ops == NULL))
-		return 0;
+	if (unlikely(dma_ops == NULL)) {
+		set_dma_ops(dev, &dma_direct_ops);
+		set_dma_offset(dev, PCI_DRAM_OFFSET);
+		dma_ops = &dma_direct_ops;
+	}
 	if (dma_ops->dma_supported == NULL)
 		return 1;
 	return dma_ops->dma_supported(dev, mask);
-- 
1.7.9.5
