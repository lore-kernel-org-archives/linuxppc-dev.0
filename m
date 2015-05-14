Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F35CB1A03D6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2015 12:35:03 +1000 (AEST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 14 May 2015 12:35:03 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id B9E902CE8050
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2015 12:34:58 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4E2YoMb15728784
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2015 12:34:58 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4E2YPIT006041
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2015 12:34:25 +1000
Date: Thu, 14 May 2015 12:34:00 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v10 22/34] powerpc/powernv: Implement accessor to
 TCE entry
Message-ID: <20150514023400.GA3068@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1431358763-24371-1-git-send-email-aik@ozlabs.ru>
 <1431358763-24371-23-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1431358763-24371-23-git-send-email-aik@ozlabs.ru>
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

On Tue, May 12, 2015 at 01:39:11AM +1000, Alexey Kardashevskiy wrote:
>This replaces direct accesses to TCE table with a helper which
>returns an TCE entry address. This does not make difference now but will
>when multi-level TCE tables get introduces.
>
>No change in behavior is expected.
>
>Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Thanks,
Gavin

>---
>Changes:
>v9:
>* new patch in the series to separate this mechanical change from
>functional changes; this is not right before
>"powerpc/powernv: Implement multilevel TCE tables" but here in order
>to let the next patch - "powerpc/iommu/powernv: Release replaced TCE" -
>use pnv_tce() and avoid changing the same code twice
>---
> arch/powerpc/platforms/powernv/pci.c | 34 +++++++++++++++++++++-------------
> 1 file changed, 21 insertions(+), 13 deletions(-)
>
>diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
>index ed7de7b..cc82f05 100644
>--- a/arch/powerpc/platforms/powernv/pci.c
>+++ b/arch/powerpc/platforms/powernv/pci.c
>@@ -572,38 +572,46 @@ struct pci_ops pnv_pci_ops = {
> 	.write = pnv_pci_write_config,
> };
>
>+static __be64 *pnv_tce(struct iommu_table *tbl, long idx)
>+{
>+	__be64 *tmp = ((__be64 *)tbl->it_base);
>+
>+	return tmp + idx;
>+}
>+
> int pnv_tce_build(struct iommu_table *tbl, long index, long npages,
> 		unsigned long uaddr, enum dma_data_direction direction,
> 		struct dma_attrs *attrs)
> {
> 	u64 proto_tce = iommu_direction_to_tce_perm(direction);
>-	__be64 *tcep;
>-	u64 rpn;
>+	u64 rpn = __pa(uaddr) >> tbl->it_page_shift;
>+	long i;
>
>-	tcep = ((__be64 *)tbl->it_base) + index - tbl->it_offset;
>-	rpn = __pa(uaddr) >> tbl->it_page_shift;
>-
>-	while (npages--)
>-		*(tcep++) = cpu_to_be64(proto_tce |
>-				(rpn++ << tbl->it_page_shift));
>+	for (i = 0; i < npages; i++) {
>+		unsigned long newtce = proto_tce |
>+			((rpn + i) << tbl->it_page_shift);
>+		unsigned long idx = index - tbl->it_offset + i;
>
>+		*(pnv_tce(tbl, idx)) = cpu_to_be64(newtce);
>+	}
>
> 	return 0;
> }
>
> void pnv_tce_free(struct iommu_table *tbl, long index, long npages)
> {
>-	__be64 *tcep;
>+	long i;
>
>-	tcep = ((__be64 *)tbl->it_base) + index - tbl->it_offset;
>+	for (i = 0; i < npages; i++) {
>+		unsigned long idx = index - tbl->it_offset + i;
>
>-	while (npages--)
>-		*(tcep++) = cpu_to_be64(0);
>+		*(pnv_tce(tbl, idx)) = cpu_to_be64(0);
>+	}
> }
>
> unsigned long pnv_tce_get(struct iommu_table *tbl, long index)
> {
>-	return ((u64 *)tbl->it_base)[index - tbl->it_offset];
>+	return *(pnv_tce(tbl, index - tbl->it_offset));
> }
>
> struct iommu_table *pnv_pci_table_alloc(int nid)
>-- 
>2.4.0.rc3.8.gfb3e7d5
>
