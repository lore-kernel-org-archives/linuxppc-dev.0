Return-Path: <BATV+aedc8c2b8b4ea4ab6c83+2168+infradead.org+dwmw2@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [18.85.46.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id D2DE5B7B6D
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  1 Aug 2009 05:41:59 +1000 (EST)
Subject: [PATCH] Stop pci_set_dma_mask() from failing when RAM doesn't
	exceed the mask anyway
From: David Woodhouse <dwmw2@infradead.org>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain
Date: Fri, 31 Jul 2009 20:41:50 +0100
Message-Id: <1249069310.20192.220.camel@macbook.infradead.org>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On an iMac G5, the b43 driver is failing to initialise because trying to
set the dma mask to 30-bit fails. Even though there's only 512MiB of RAM
in the machine anyway:
	https://bugzilla.redhat.com/show_bug.cgi?id=514787

We should probably let it succeed if the available RAM in the system
doesn't exceed the requested limit.

Signed-off-by: David Woodhouse <David.Woodhouse@intel.com>

diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
index 20a60d6..1769a8e 100644
--- a/arch/powerpc/kernel/dma.c
+++ b/arch/powerpc/kernel/dma.c
@@ -90,11 +90,11 @@ static void dma_direct_unmap_sg(struct device *dev,
struct scatterlist *sg,
 static int dma_direct_dma_supported(struct device *dev, u64 mask)
 {
 #ifdef CONFIG_PPC64
-	/* Could be improved to check for memory though it better be
-	 * done via some global so platforms can set the limit in case
+	extern unsigned long highest_memmap_pfn;
+	/* Could be improved so platforms can set the limit in case
 	 * they have limited DMA windows
 	 */
-	return mask >= DMA_BIT_MASK(32);
+	return (mask >> PAGE_SHIFT) >= highest_memmap_pfn;
 #else
 	return 1;
 #endif

-- 
David Woodhouse                            Open Source Technology Centre
David.Woodhouse@intel.com                              Intel Corporation
