Return-Path: <fujita.tomonori@lab.ntt.co.jp>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 92D1BB719B
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 10 Jul 2009 11:20:47 +1000 (EST)
Received: from sh.osrg.net (sh.osrg.net [192.16.179.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3C982DDDD4
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Jul 2009 11:20:47 +1000 (EST)
From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 06/15] x86: replace is_buffer_dma_capable() with dma_capable
Date: Fri, 10 Jul 2009 10:04:55 +0900
Message-Id: <1247187904-31999-7-git-send-email-fujita.tomonori@lab.ntt.co.jp>
In-Reply-To: <1247187904-31999-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
References: <1247187904-31999-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Cc: tony.luck@intel.com, linux-ia64@vger.kernel.org, x86@kernel.org,
	fujita.tomonori@lab.ntt.co.jp, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
---
 arch/x86/kernel/pci-dma.c     |    2 +-
 arch/x86/kernel/pci-gart_64.c |    5 ++---
 arch/x86/kernel/pci-nommu.c   |    2 +-
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/pci-dma.c b/arch/x86/kernel/pci-dma.c
index 1a041bc..3c945c0 100644
--- a/arch/x86/kernel/pci-dma.c
+++ b/arch/x86/kernel/pci-dma.c
@@ -147,7 +147,7 @@ again:
 		return NULL;
 
 	addr = page_to_phys(page);
-	if (!is_buffer_dma_capable(dma_mask, addr, size)) {
+	if (addr + size > dma_mask) {
 		__free_pages(page, get_order(size));
 
 		if (dma_mask < DMA_BIT_MASK(32) && !(flag & GFP_DMA)) {
diff --git a/arch/x86/kernel/pci-gart_64.c b/arch/x86/kernel/pci-gart_64.c
index d2e56b8..98a827e 100644
--- a/arch/x86/kernel/pci-gart_64.c
+++ b/arch/x86/kernel/pci-gart_64.c
@@ -190,14 +190,13 @@ static void iommu_full(struct device *dev, size_t size, int dir)
 static inline int
 need_iommu(struct device *dev, unsigned long addr, size_t size)
 {
-	return force_iommu ||
-		!is_buffer_dma_capable(*dev->dma_mask, addr, size);
+	return force_iommu || !dma_capable(dev, addr, size);
 }
 
 static inline int
 nonforced_iommu(struct device *dev, unsigned long addr, size_t size)
 {
-	return !is_buffer_dma_capable(*dev->dma_mask, addr, size);
+	return !dma_capable(dev, addr, size);
 }
 
 /* Map a single continuous physical area into the IOMMU.
diff --git a/arch/x86/kernel/pci-nommu.c b/arch/x86/kernel/pci-nommu.c
index 71d412a..c0a4222 100644
--- a/arch/x86/kernel/pci-nommu.c
+++ b/arch/x86/kernel/pci-nommu.c
@@ -14,7 +14,7 @@
 static int
 check_addr(char *name, struct device *hwdev, dma_addr_t bus, size_t size)
 {
-	if (hwdev && !is_buffer_dma_capable(*hwdev->dma_mask, bus, size)) {
+	if (hwdev && !dma_capable(hwdev, bus, size)) {
 		if (*hwdev->dma_mask >= DMA_BIT_MASK(32))
 			printk(KERN_ERR
 			    "nommu_%s: overflow %Lx+%zu of device mask %Lx\n",
-- 
1.6.0.6
