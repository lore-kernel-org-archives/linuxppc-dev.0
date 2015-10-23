Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B26C1A0D8A
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Oct 2015 08:01:30 +1100 (AEDT)
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Fri, 23 Oct 2015 17:01:28 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 6FA74C90052
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Oct 2015 16:49:36 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9NL1PQ951576938
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Oct 2015 21:01:25 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9NL1NO9011452
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Oct 2015 17:01:25 -0400
Date: Fri, 23 Oct 2015 14:01:15 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: Matthew Wilcox <willy@linux.intel.com>,
 Keith Busch <keith.busch@intel.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>,
 Christoph Hellwig <hch@infradead.org>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 sparclinux@vger.kernel.org
Subject: [RFC PATCH 6/7] sparc/dma-mapping: override dma_get_page_shift
Message-ID: <20151023210115.GH10197@linux.vnet.ibm.com>
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

On sparc, the kernel's page size differs from the IOMMU's page size, so
override the generic implementation, which always returns the kernel's
page size, and return IOMMU_PAGE_SHIFT instead.

Signed-off-by: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>

---
I know very little about sparc, so please correct me if this patch is
invalid.

 arch/sparc/include/asm/dma-mapping.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/sparc/include/asm/dma-mapping.h b/arch/sparc/include/asm/dma-mapping.h
index a21da59..76ba470 100644
--- a/arch/sparc/include/asm/dma-mapping.h
+++ b/arch/sparc/include/asm/dma-mapping.h
@@ -52,6 +52,14 @@ static inline int dma_set_mask(struct device *dev, u64 mask)
 	return -EINVAL;
 }
 
+/* for IOMMU_PAGE_SHIFT */
+#include <asm/iommu_common.h>
+#define HAVE_ARCH_DMA_GET_PAGE_SHIFT 1
+static inline unsigned long dma_get_page_shift(struct device *dev)
+{
+	return IOMMU_PAGE_SHIFT;
+}
+
 #include <asm-generic/dma-mapping-common.h>
 
 #endif
-- 
1.9.1
