Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6B7EF1A0017
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2015 15:02:12 +1000 (AEST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 14 May 2015 15:02:10 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id A70553578048
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2015 15:02:06 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4E51v2Z44499088
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2015 15:02:06 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4E51XVA015315
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2015 15:01:33 +1000
Date: Thu, 14 May 2015 15:01:07 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v10 26/34] powerpc/powernv/ioda2: Introduce
 pnv_pci_ioda2_set_window
Message-ID: <20150514050107.GA22516@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1431358763-24371-1-git-send-email-aik@ozlabs.ru>
 <1431358763-24371-27-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1431358763-24371-27-git-send-email-aik@ozlabs.ru>
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

On Tue, May 12, 2015 at 01:39:15AM +1000, Alexey Kardashevskiy wrote:
>This is a part of moving DMA window programming to an iommu_ops
>callback. pnv_pci_ioda2_set_window() takes an iommu_table_group as
>a first parameter (not pnv_ioda_pe) as it is going to be used as
>a callback for VFIO DDW code.
>
>This adds pnv_pci_ioda2_tvt_invalidate() to invalidate TVT as it is
>a good thing to do. It does not have immediate effect now as the table
>is never recreated after reboot but it will in the following patches.
>
>This should cause no behavioural change.
>
>Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

>---
>Changes:
>v9:
>* initialize pe->table_group.tables[0] at the very end when
>tbl is fully initialized
>* moved pnv_pci_ioda2_tvt_invalidate() from earlier patch
>---
> arch/powerpc/platforms/powernv/pci-ioda.c | 47 +++++++++++++++++++++++++------
> 1 file changed, 38 insertions(+), 9 deletions(-)
>
>diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>index 7d98d83..85f80b2 100644
>--- a/arch/powerpc/platforms/powernv/pci-ioda.c
>+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>@@ -1983,6 +1983,43 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
> 	}
> }
>
>+static long pnv_pci_ioda2_set_window(struct iommu_table_group *table_group,
>+		int num, struct iommu_table *tbl)
>+{
>+	struct pnv_ioda_pe *pe = container_of(table_group, struct pnv_ioda_pe,
>+			table_group);
>+	struct pnv_phb *phb = pe->phb;
>+	int64_t rc;
>+	const __u64 start_addr = tbl->it_offset << tbl->it_page_shift;
>+	const __u64 win_size = tbl->it_size << tbl->it_page_shift;

s/__u64/u64 maybe :-)

>+
>+	pe_info(pe, "Setting up window %llx..%llx pg=%x\n",
>+			start_addr, start_addr + win_size - 1,
>+			1UL << tbl->it_page_shift);
>+
>+	/*
>+	 * Map TCE table through TVT. The TVE index is the PE number
>+	 * shifted by 1 bit for 32-bits DMA space.
>+	 */
>+	rc = opal_pci_map_pe_dma_window(phb->opal_id,
>+			pe->pe_number,
>+			pe->pe_number << 1,
>+			1,
>+			__pa(tbl->it_base),
>+			tbl->it_size << 3,
>+			1ULL << tbl->it_page_shift);

There is one macro for IOMMU page size: IOMMU_PAGE_SIZE(), which is defined in
arch/powerpc/include/asm/iommu.h as below:

#define IOMMU_PAGE_SIZE(tblptr) (ASM_CONST(1) << (tblptr)->it_page_shift)

>+	if (rc) {
>+		pe_err(pe, "Failed to configure TCE table, err %ld\n", rc);
>+		return rc;
>+	}
>+
>+	pnv_pci_link_table_and_group(phb->hose->node, num,
>+			tbl, &pe->table_group);
>+	pnv_pci_ioda2_tvt_invalidate(pe);
>+
>+	return 0;
>+}
>+
> static void pnv_pci_ioda2_set_bypass(struct pnv_ioda_pe *pe, bool enable)
> {
> 	uint16_t window_id = (pe->pe_number << 1 ) + 1;
>@@ -2127,21 +2164,13 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
> 	pe->table_group.ops = &pnv_pci_ioda2_ops;
> #endif
>
>-	/*
>-	 * Map TCE table through TVT. The TVE index is the PE number
>-	 * shifted by 1 bit for 32-bits DMA space.
>-	 */
>-	rc = opal_pci_map_pe_dma_window(phb->opal_id, pe->pe_number,
>-			pe->pe_number << 1, 1, __pa(tbl->it_base),
>-			tbl->it_size << 3, 1ULL << tbl->it_page_shift);
>+	rc = pnv_pci_ioda2_set_window(&pe->table_group, 0, tbl);
> 	if (rc) {
> 		pe_err(pe, "Failed to configure 32-bit TCE table,"
> 		       " err %ld\n", rc);
> 		goto fail;
> 	}
>
>-	pnv_pci_ioda2_tvt_invalidate(pe);
>-
> 	/* OPAL variant of PHB3 invalidated TCEs */
> 	if (pe->tce_inval_reg)
> 		tbl->it_type |= (TCE_PCI_SWINV_CREATE | TCE_PCI_SWINV_FREE);

Thanks,
Gavin

>-- 
>2.4.0.rc3.8.gfb3e7d5
>
