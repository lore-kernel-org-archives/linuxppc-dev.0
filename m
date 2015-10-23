Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2CD181A0D14
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Oct 2015 07:58:41 +1100 (AEDT)
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Fri, 23 Oct 2015 14:58:40 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id D7FAE1FF0043
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Oct 2015 14:46:49 -0600 (MDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9NKvHNk7274920
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Oct 2015 13:57:17 -0700
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9NKwaVX009130
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Oct 2015 14:58:37 -0600
Date: Fri, 23 Oct 2015 13:58:34 -0700
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
Subject: [PATCH 3/7 v2] powerpc/dma: implement per-platform dma_get_page_shift
Message-ID: <20151023205834.GE10197@linux.vnet.ibm.com>
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

The IOMMU page size is not always stored in struct iommu on Power.
Specifically if a device is configured for DDW (Dynamic DMA Windows aka.
64-bit direct DMA), the used TCE (Translation Control Entry) size is
stored in a special device property created at run-time by the DDW
configuration code. DDW is a pseries-specific feature, so allow
platforms to override the implementation of dma_get_page_shift if
desired.

Signed-off-by: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/machdep.h | 3 ++-
 arch/powerpc/kernel/dma.c          | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index 3f191f5..9dd03cf 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -83,9 +83,10 @@ struct machdep_calls {
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
-- 
1.9.1
