Return-Path: <BATV+ddff6d03254b98e050e8+5253+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zGhKr748RzF0g1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jan 2018 19:01:36 +1100 (AEDT)
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org
Cc: Konrad Rzeszutek Wilk <konrad@darnok.org>, linux-alpha@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-c6x-dev@linux-c6x.org, linux-cris-kernel@axis.com,
 linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-metag@vger.kernel.org,
 Michal Simek <monstr@monstr.eu>, linux-mips@linux-mips.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 patches@groups.riscv.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, x86@kernel.org,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 18/33] s390: move s390_pci_dma_ops to asm/pci_dma.h
Date: Wed, 10 Jan 2018 09:00:12 +0100
Message-Id: <20180110080027.13879-19-hch@lst.de>
In-Reply-To: <20180110080027.13879-1-hch@lst.de>
References: <20180110080027.13879-1-hch@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is not needed in drivers, so move it to a private header.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/s390/include/asm/dma-mapping.h | 2 --
 arch/s390/include/asm/pci_dma.h     | 3 +++
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/s390/include/asm/dma-mapping.h b/arch/s390/include/asm/dma-mapping.h
index 2ec7240c1ada..bdc2455483f6 100644
--- a/arch/s390/include/asm/dma-mapping.h
+++ b/arch/s390/include/asm/dma-mapping.h
@@ -9,8 +9,6 @@
 #include <linux/dma-debug.h>
 #include <linux/io.h>
 
-extern const struct dma_map_ops s390_pci_dma_ops;
-
 static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 {
 	return &dma_noop_ops;
diff --git a/arch/s390/include/asm/pci_dma.h b/arch/s390/include/asm/pci_dma.h
index e8d9161fa17a..419fac7a62c0 100644
--- a/arch/s390/include/asm/pci_dma.h
+++ b/arch/s390/include/asm/pci_dma.h
@@ -201,4 +201,7 @@ void dma_cleanup_tables(unsigned long *);
 unsigned long *dma_walk_cpu_trans(unsigned long *rto, dma_addr_t dma_addr);
 void dma_update_cpu_trans(unsigned long *entry, void *page_addr, int flags);
 
+extern const struct dma_map_ops s390_pci_dma_ops;
+
+
 #endif
-- 
2.14.2
