Return-Path: <BATV+598c32ccc3a9ece13a58+4371+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:1868:205::9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D83F71A067D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Aug 2015 17:09:26 +1000 (AEST)
From: Christoph Hellwig <hch@lst.de>
To: torvalds@linux-foundation.org,
	axboe@kernel.dk
Cc: dan.j.williams@intel.com, vgupta@synopsys.com, hskinnemoen@gmail.com,
 egtvedt@samfundet.no, realmz6@gmail.com, dhowells@redhat.com,
 monstr@monstr.eu, x86@kernel.org, dwmw2@infradead.org,
 alex.williamson@redhat.com, grundler@parisc-linux.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-xtensa@linux-xtensa.org, linux-nvdimm@ml01.01.org,
 linux-media@vger.kernel.org
Subject: [PATCH 14/31] sparc32/io-unit: handle page-less SG entries
Date: Wed, 12 Aug 2015 09:05:33 +0200
Message-Id: <1439363150-8661-15-git-send-email-hch@lst.de>
In-Reply-To: <1439363150-8661-1-git-send-email-hch@lst.de>
References: <1439363150-8661-1-git-send-email-hch@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For the iommu offset we just need and offset into the page.  Calculate
that using the physical address instead of using the virtual address
so that we don't require a virtual mapping.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/sparc/mm/io-unit.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/arch/sparc/mm/io-unit.c b/arch/sparc/mm/io-unit.c
index f311bf2..82f97ae 100644
--- a/arch/sparc/mm/io-unit.c
+++ b/arch/sparc/mm/io-unit.c
@@ -91,13 +91,14 @@ static int __init iounit_init(void)
 subsys_initcall(iounit_init);
 
 /* One has to hold iounit->lock to call this */
-static unsigned long iounit_get_area(struct iounit_struct *iounit, unsigned long vaddr, int size)
+static dma_addr_t iounit_get_area(struct iounit_struct *iounit,
+		unsigned long paddr, int size)
 {
 	int i, j, k, npages;
-	unsigned long rotor, scan, limit;
+	unsigned long rotor, scan, limit, dma_addr;
 	iopte_t iopte;
 
-        npages = ((vaddr & ~PAGE_MASK) + size + (PAGE_SIZE-1)) >> PAGE_SHIFT;
+        npages = ((paddr & ~PAGE_MASK) + size + (PAGE_SIZE-1)) >> PAGE_SHIFT;
 
 	/* A tiny bit of magic ingredience :) */
 	switch (npages) {
@@ -106,7 +107,7 @@ static unsigned long iounit_get_area(struct iounit_struct *iounit, unsigned long
 	default: i = 0x0213; break;
 	}
 	
-	IOD(("iounit_get_area(%08lx,%d[%d])=", vaddr, size, npages));
+	IOD(("iounit_get_area(%08lx,%d[%d])=", paddr, size, npages));
 	
 next:	j = (i & 15);
 	rotor = iounit->rotor[j - 1];
@@ -121,7 +122,7 @@ nexti:	scan = find_next_zero_bit(iounit->bmap, limit, scan);
 		}
 		i >>= 4;
 		if (!(i & 15))
-			panic("iounit_get_area: Couldn't find free iopte slots for (%08lx,%d)\n", vaddr, size);
+			panic("iounit_get_area: Couldn't find free iopte slots for (%08lx,%d)\n", paddr, size);
 		goto next;
 	}
 	for (k = 1, scan++; k < npages; k++)
@@ -129,14 +130,14 @@ nexti:	scan = find_next_zero_bit(iounit->bmap, limit, scan);
 			goto nexti;
 	iounit->rotor[j - 1] = (scan < limit) ? scan : iounit->limit[j - 1];
 	scan -= npages;
-	iopte = MKIOPTE(__pa(vaddr & PAGE_MASK));
-	vaddr = IOUNIT_DMA_BASE + (scan << PAGE_SHIFT) + (vaddr & ~PAGE_MASK);
+	iopte = MKIOPTE(paddr & PAGE_MASK);
+	dma_addr = IOUNIT_DMA_BASE + (scan << PAGE_SHIFT) + (paddr & ~PAGE_MASK);
 	for (k = 0; k < npages; k++, iopte = __iopte(iopte_val(iopte) + 0x100), scan++) {
 		set_bit(scan, iounit->bmap);
 		sbus_writel(iopte, &iounit->page_table[scan]);
 	}
-	IOD(("%08lx\n", vaddr));
-	return vaddr;
+	IOD(("%08lx\n", dma_addr));
+	return dma_addr;
 }
 
 static __u32 iounit_get_scsi_one(struct device *dev, char *vaddr, unsigned long len)
@@ -145,7 +146,7 @@ static __u32 iounit_get_scsi_one(struct device *dev, char *vaddr, unsigned long
 	unsigned long ret, flags;
 	
 	spin_lock_irqsave(&iounit->lock, flags);
-	ret = iounit_get_area(iounit, (unsigned long)vaddr, len);
+	ret = iounit_get_area(iounit, virt_to_phys(vaddr), len);
 	spin_unlock_irqrestore(&iounit->lock, flags);
 	return ret;
 }
@@ -159,7 +160,7 @@ static void iounit_get_scsi_sgl(struct device *dev, struct scatterlist *sg, int
 	spin_lock_irqsave(&iounit->lock, flags);
 	while (sz != 0) {
 		--sz;
-		sg->dma_address = iounit_get_area(iounit, (unsigned long) sg_virt(sg), sg->length);
+		sg->dma_address = iounit_get_area(iounit, sg_phys(sg), sg->length);
 		sg->dma_length = sg->length;
 		sg = sg_next(sg);
 	}
-- 
1.9.1
