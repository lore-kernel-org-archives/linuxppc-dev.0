Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 15C881A086D
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Jun 2015 10:28:50 +1000 (AEST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 5 Jun 2015 10:28:48 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id CF2A53578052
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Jun 2015 10:28:45 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t550SbSr57409628
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 Jun 2015 10:28:45 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t550SCrd032632
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 Jun 2015 10:28:13 +1000
Date: Fri, 5 Jun 2015 10:27:48 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH kernel v11 21/34] powerpc/powernv/ioda2: Add TCE
 invalidation for all attached groups
Message-ID: <20150605002748.GB17429@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1432889098-22924-1-git-send-email-aik@ozlabs.ru>
 <1432889098-22924-22-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1432889098-22924-22-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, May 29, 2015 at 06:44:45PM +1000, Alexey Kardashevskiy wrote:
>The iommu_table struct keeps a list of IOMMU groups it is used for.
>At the moment there is just a single group attached but further
>patches will add TCE table sharing. When sharing is enabled, TCE cache
>in each PE needs to be invalidated so does the patch.
>
>This does not change pnv_pci_ioda1_tce_invalidate() as there is no plan
>to enable TCE table sharing on PHBs older than IODA2.
>
>Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

>---
>Changes:
>v10:
>* new to the series
>---
> arch/powerpc/platforms/powernv/pci-ioda.c | 35 ++++++++++++++++++++-----------
> 1 file changed, 23 insertions(+), 12 deletions(-)
>
>diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>index 3fd8b18..94fccc8 100644
>--- a/arch/powerpc/platforms/powernv/pci-ioda.c
>+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>@@ -24,6 +24,7 @@
> #include <linux/msi.h>
> #include <linux/memblock.h>
> #include <linux/iommu.h>
>+#include <linux/rculist.h>
>
> #include <asm/sections.h>
> #include <asm/io.h>
>@@ -1764,23 +1765,15 @@ static inline void pnv_pci_ioda2_tce_invalidate_entire(struct pnv_ioda_pe *pe)
> 	__raw_writeq(cpu_to_be64(val), phb->ioda.tce_inval_reg);
> }
>
>-static void pnv_pci_ioda2_tce_invalidate(struct iommu_table *tbl,
>-		unsigned long index, unsigned long npages, bool rm)
>+static void pnv_pci_ioda2_tce_do_invalidate(unsigned pe_number, bool rm,
>+		__be64 __iomem *invalidate, unsigned shift,
>+		unsigned long index, unsigned long npages)

The better function name would be: pnv_pci_ioda2_do_tce_invalidate(), and
it seems we needn't "bool rm" any more since "invalidate" has been assigned
with virtual/real address by caller.

Thanks,
Gavin

> {
>-	struct iommu_table_group_link *tgl = list_first_entry_or_null(
>-			&tbl->it_group_list, struct iommu_table_group_link,
>-			next);
>-	struct pnv_ioda_pe *pe = container_of(tgl->table_group,
>-			struct pnv_ioda_pe, table_group);
> 	unsigned long start, end, inc;
>-	__be64 __iomem *invalidate = rm ?
>-		(__be64 __iomem *)pe->phb->ioda.tce_inval_reg_phys :
>-		pe->phb->ioda.tce_inval_reg;
>-	const unsigned shift = tbl->it_page_shift;
>
> 	/* We'll invalidate DMA address in PE scope */
> 	start = 0x2ull << 60;
>-	start |= (pe->pe_number & 0xFF);
>+	start |= (pe_number & 0xFF);
> 	end = start;
>
> 	/* Figure out the start, end and step */
>@@ -1798,6 +1791,24 @@ static void pnv_pci_ioda2_tce_invalidate(struct iommu_table *tbl,
> 	}
> }
>
>+static void pnv_pci_ioda2_tce_invalidate(struct iommu_table *tbl,
>+		unsigned long index, unsigned long npages, bool rm)
>+{
>+	struct iommu_table_group_link *tgl;
>+
>+	list_for_each_entry_rcu(tgl, &tbl->it_group_list, next) {
>+		struct pnv_ioda_pe *pe = container_of(tgl->table_group,
>+				struct pnv_ioda_pe, table_group);
>+		__be64 __iomem *invalidate = rm ?
>+			(__be64 __iomem *)pe->phb->ioda.tce_inval_reg_phys :
>+			pe->phb->ioda.tce_inval_reg;
>+
>+		pnv_pci_ioda2_tce_do_invalidate(pe->pe_number, rm,
>+			invalidate, tbl->it_page_shift,
>+			index, npages);
>+	}
>+}
>+
> static int pnv_ioda2_tce_build(struct iommu_table *tbl, long index,
> 		long npages, unsigned long uaddr,
> 		enum dma_data_direction direction,
>-- 
>2.4.0.rc3.8.gfb3e7d5
>
