Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C9A651A0015
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2015 12:23:21 +1000 (AEST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 14 May 2015 12:23:20 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id F09542BB0047
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2015 12:23:17 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4E2N93x32112676
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2015 12:23:17 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4E2MimS023850
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2015 12:22:45 +1000
Date: Thu, 14 May 2015 12:22:19 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v10 21/34] powerpc/powernv/ioda2: Add TCE
 invalidation for all attached groups
Message-ID: <20150514022219.GA32474@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1431358763-24371-1-git-send-email-aik@ozlabs.ru>
 <1431358763-24371-22-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1431358763-24371-22-git-send-email-aik@ozlabs.ru>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 12, 2015 at 01:39:10AM +1000, Alexey Kardashevskiy wrote:
>The iommu_table struct keeps a list of IOMMU groups it is used for.
>At the moment there is just a single group attached but further
>patches will add TCE table sharing. When sharing is enabled, TCE cache
>in each PE needs to be invalidated so does the patch.
>
>This does not change pnv_pci_ioda1_tce_invalidate() as there is no plan
>to enable TCE table sharing on PHBs older than IODA2.
>
>Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>---
>Changes:
>v10:
>* new to the series
>---
> arch/powerpc/platforms/powernv/pci-ioda.c | 35 ++++++++++++++++++++-----------
> 1 file changed, 23 insertions(+), 12 deletions(-)
>
>diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>index f972e40..8e4987d 100644
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
>@@ -1763,23 +1764,15 @@ static inline void pnv_pci_ioda2_tvt_invalidate(struct pnv_ioda_pe *pe)
> 	__raw_writeq(cpu_to_be64(val), pe->tce_inval_reg);
> }
>
>-static void pnv_pci_ioda2_tce_invalidate(struct iommu_table *tbl,
>-		unsigned long index, unsigned long npages, bool rm)
>+static void pnv_pci_ioda2_tce_do_invalidate(unsigned pe_number, bool rm,
>+		__be64 __iomem *invalidate, unsigned shift,
>+		unsigned long index, unsigned long npages)
> {
>-	struct iommu_table_group_link *tgl = list_first_entry_or_null(
>-			&tbl->it_group_list, struct iommu_table_group_link,
>-			next);
>-	struct pnv_ioda_pe *pe = container_of(tgl->table_group,
>-			struct pnv_ioda_pe, table_group);
> 	unsigned long start, end, inc;
>-	__be64 __iomem *invalidate = rm ?
>-		(__be64 __iomem *)pe->tce_inval_reg_phys :
>-		pe->tce_inval_reg;
>-	const unsigned shift = tbl->it_page_shift;
>
> 	/* We'll invalidate DMA address in PE scope */
> 	start = 0x2ull << 60;
>-	start |= (pe->pe_number & 0xFF);
>+	start |= (pe_number & 0xFF);
> 	end = start;
>
> 	/* Figure out the start, end and step */
>@@ -1797,6 +1790,24 @@ static void pnv_pci_ioda2_tce_invalidate(struct iommu_table *tbl,
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
>+			(__be64 __iomem *)pe->tce_inval_reg_phys :
>+			pe->tce_inval_reg;
>+
>+		pnv_pci_ioda2_tce_do_invalidate(pe->pe_number, rm,
>+			invalidate, tbl->it_page_shift,
>+			index, npages);
>+	}
>+}
>+

I don't understand this well and need a teaching session: One IOMMU
table can be connected with multiple IOMMU table groups, each of them
can be regarded as being equal to one PE. It means one IOMMU table
can be shared by two PEs. There must be something I missed.

Could you give a teaching session with an example about the IOMMU
table sharing? :-)

Thanks,
Gavin

> static int pnv_ioda2_tce_build(struct iommu_table *tbl, long index,
> 		long npages, unsigned long uaddr,
> 		enum dma_data_direction direction,
>-- 
>2.4.0.rc3.8.gfb3e7d5
>
