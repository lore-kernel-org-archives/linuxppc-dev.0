Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EA1751A0CD7
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Oct 2015 07:57:25 +1100 (AEDT)
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Fri, 23 Oct 2015 16:57:23 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 6763B6E8041
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Oct 2015 16:45:32 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9NKvL2o56295522
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Oct 2015 20:57:21 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9NKvJUc023791
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Oct 2015 16:57:20 -0400
Date: Fri, 23 Oct 2015 13:57:18 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Matthew Wilcox <willy@linux.intel.com>,
 Keith Busch <keith.busch@intel.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>,
 Christoph Hellwig <hch@infradead.org>,
 "David S. Miller" <davem@davemloft.net>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org
Subject: [PATCH 2/7 v2] powerpc/dma-mapping: override dma_get_page_shift
Message-ID: <20151023205718.GC10197@linux.vnet.ibm.com>
References: <20151023205420.GA10197@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151023205420.GA10197@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Power, the kernel's page size can differ from the IOMMU's page size,
so we need to override the generic implementation, which always returns
the kernel's page size. Lookup the IOMMU's page size from struct
iommu_table, if available. Fallback to the kernel's page size,
otherwise.

Signed-off-by: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/dma-mapping.h | 3 +++
 arch/powerpc/kernel/dma.c              | 9 +++++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
index 7f522c0..c5638f4 100644
--- a/arch/powerpc/include/asm/dma-mapping.h
+++ b/arch/powerpc/include/asm/dma-mapping.h
@@ -125,6 +125,9 @@ static inline void set_dma_offset(struct device *dev, dma_addr_t off)
 #define HAVE_ARCH_DMA_SET_MASK 1
 extern int dma_set_mask(struct device *dev, u64 dma_mask);
 
+#define HAVE_ARCH_DMA_GET_PAGE_SHIFT 1
+extern unsigned long dma_get_page_shift(struct device *dev);
+
 #include <asm-generic/dma-mapping-common.h>
 
 extern int __dma_set_mask(struct device *dev, u64 dma_mask);
diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
index 59503ed..e805af2 100644
--- a/arch/powerpc/kernel/dma.c
+++ b/arch/powerpc/kernel/dma.c
@@ -335,6 +335,15 @@ int dma_set_mask(struct device *dev, u64 dma_mask)
 }
 EXPORT_SYMBOL(dma_set_mask);
 
+unsigned long dma_get_page_shift(struct device *dev)
+{
+	struct iommu_table *tbl = get_iommu_table_base(dev);
+	if (tbl)
+		return tbl->it_page_shift;
+	return PAGE_SHIFT;
+}
+EXPORT_SYMBOL(dma_get_page_shift);
+
 u64 __dma_get_required_mask(struct device *dev)
 {
 	struct dma_map_ops *dma_ops = get_dma_ops(dev);
-- 
1.9.1
