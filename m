Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7F2C81A055C
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Oct 2015 06:19:22 +1000 (AEST)
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Fri, 2 Oct 2015 14:19:20 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 519BE19D804C
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Oct 2015 14:07:29 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t92KG8Wo2884086
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 2 Oct 2015 13:16:08 -0700
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t92KJFvZ007601
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 2 Oct 2015 14:19:16 -0600
Date: Fri, 2 Oct 2015 13:19:14 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Matthew Wilcox <willy@linux.intel.com>
Cc: Keith Busch <keith.busch@intel.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>,
 Christoph Hellwig <hch@infradead.org>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/5 v2] powerpc/dma: implement per-platform dma_get_page_shift
Message-ID: <20151002201914.GI8040@linux.vnet.ibm.com>
References: <20151002171606.GA41011@linux.vnet.ibm.com>
 <20151002200953.GB40695@linux.vnet.ibm.com>
 <20151002201142.GC40695@linux.vnet.ibm.com>
 <20151002201647.GH8040@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151002201647.GH8040@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The IOMMU page size is not always stored in struct iommu on Power.
Specifically if a device is configured for DDW (Dynamic DMA Windows aka.
64-bit direct DMA), the used TCE (Translation Control Entry) size is
stored in a special device property created at run-time by the DDW
configuration code. DDW is a pseries-specific feature, so allow
platforms to override the implementation of dma_get_page_shift if
desired.

Signed-off-by: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>

diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index cab6753..5c372e3 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -78,9 +78,10 @@ struct machdep_calls {
 #endif
 #endif /* CONFIG_PPC64 */
 
-	/* Platform set_dma_mask and dma_get_required_mask overrides */
+	/* Platform overrides */
 	int		(*dma_set_mask)(struct device *dev, u64 dma_mask);
 	u64		(*dma_get_required_mask)(struct device *dev);
+	unsigned long	(*dma_get_page_shift)(struct device *dev);
 
 	int		(*probe)(void);
 	void		(*setup_arch)(void); /* Optional, may be NULL */
diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
index e805af2..c363896 100644
--- a/arch/powerpc/kernel/dma.c
+++ b/arch/powerpc/kernel/dma.c
@@ -338,6 +338,8 @@ EXPORT_SYMBOL(dma_set_mask);
 unsigned long dma_get_page_shift(struct device *dev)
 {
 	struct iommu_table *tbl = get_iommu_table_base(dev);
+	if (ppc_md.dma_get_page_shift)
+		return ppc_md.dma_get_page_shift(dev);
 	if (tbl)
 		return tbl->it_page_shift;
 	return PAGE_SHIFT;
