Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rZLX101VSzDq66
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2016 20:32:46 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5MATQcl019589
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2016 06:32:44 -0400
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [125.16.236.9])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23q1qnpxw5-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2016 06:32:44 -0400
Received: from localhost
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 22 Jun 2016 16:02:41 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 9714D125804F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2016 16:05:15 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5MAVqj228967060
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2016 16:01:52 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5MAWZp4020250
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2016 16:02:38 +0530
Date: Wed, 22 Jun 2016 20:32:19 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc dev list <linuxppc-dev@lists.ozlabs.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [PATCH 3/3] powerpc/pnv/pci: Fix incorrect PE reservation
 attempt on some 64-bit BARs
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1466580379.4089.27.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1466580379.4089.27.camel@kernel.crashing.org>
Message-Id: <20160622103219.GA5978@gwshan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 22, 2016 at 05:26:19PM +1000, Benjamin Herrenschmidt wrote:
>The generic allocation code may sometimes decide to assign a prefetchable
>64-bit BAR to the M32 window. In fact it may also decide to allocate
>a 64-bit non-prefetchable BAR to the M64 one ! So using the resource
>flags as a test to decide which window was used for PE allocation is
>just wrong and leads to insane PE numbers.
>
>Instead, compare the addresses to figure it out.
>
>CC: stable@vger.kernel.org
>Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

>---
>
>This is a pretty nasty bug, I'd like to have Gavin ack it first but
>then we should push it back to distros. I don't know yet *why* the
>generic code is eager to put my BARs into 32-bit space but that's
>irrelevant here, it's allowed to do that and we should do the right
>thing anyway.
>

It's likely related the lost 64-bits flag in prefetchable window on
root port. The similar issue was observed on CAPI adapter connected
to RC directly on Garrison platform, which was fixed by commit d40160f
("PHB3: Emulate root complex pref 64-bits window") in skiboot.

pcibios_init
pcibios_scan_phb
pci_scan_child_bus	-> Scan root port
pci_scan_bridge		-> Create bus behind root port
pci_scan_child_bus	-> Scan devices on bus#1
pcibios_fixup_bus
pci_read_bridge_bases	-> Setup bridge windows of root port
pci_read_bridge_mmio_pref

In pci_read_bridge_mmio_pref(), no prefetchable window (64bits+pref)
is populated if bit PCI_PREF_RANGE_TYPE_64 (0x1) isn't set on PCI
config register (PCI_PREF_MEMORY_BASE, 0x24). During the resource
resizing and assigning stage in PCI core, all resources including
64-bits prefetchable resources will be covered by 32-bits bridge
window.

Thanks,
Gavin

> arch/powerpc/platforms/powernv/pci-ioda.c | 27 +++++++++++++++++----------
> 1 file changed, 17 insertions(+), 10 deletions(-)
>
>diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>index c6396b6..0321ba3 100644
>--- a/arch/powerpc/platforms/powernv/pci-ioda.c
>+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>@@ -110,10 +110,16 @@ static int __init iommu_setup(char *str)
> }
> early_param("iommu", iommu_setup);
>
>-static inline bool pnv_pci_is_mem_pref_64(unsigned long flags)
>+static inline bool pnv_pci_is_mem_pref_64(struct pnv_phb *phb, struct resource *r)
> {
>-	return ((flags & (IORESOURCE_MEM_64 | IORESOURCE_PREFETCH)) ==
>-		(IORESOURCE_MEM_64 | IORESOURCE_PREFETCH));
>+	/* WARNING: We cannot rely on the resource flags. The Linux PCI
>+	 * allocation code sometimes decides to put a 64-bit prefetchable
>+	 * BAR in the 32-bit window, so we have to compare the addresses.
>+	 *
>+	 * For simplicity we only test resource start.
>+	 */
>+	return (r->start >= phb->ioda.m64_base &&
>+		r->start < (phb->ioda.m64_base + phb->ioda.m64_size));
> }
>
> static struct pnv_ioda_pe *pnv_ioda_init_pe(struct pnv_phb *phb, int pe_no)
>@@ -230,7 +236,7 @@ static void pnv_ioda_reserve_dev_m64_pe(struct pci_dev *pdev,
> 	sgsz = phb->ioda.m64_segsize;
> 	for (i = 0; i <= PCI_ROM_RESOURCE; i++) {
> 		r = &pdev->resource[i];
>-		if (!r->parent || !pnv_pci_is_mem_pref_64(r->flags))
>+		if (!r->parent || !pnv_pci_is_mem_pref_64(phb, r))
> 			continue;
>
> 		start = _ALIGN_DOWN(r->start - base, sgsz);
>@@ -3059,7 +3065,7 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
> 		res = &pdev->resource[i + PCI_IOV_RESOURCES];
> 		if (!res->flags || res->parent)
> 			continue;
>-		if (!pnv_pci_is_mem_pref_64(res->flags)) {
>+		if (!pnv_pci_is_mem_pref_64(phb, res)) {
> 			dev_warn(&pdev->dev, "Don't support SR-IOV with"
> 					" non M64 VF BAR%d: %pR. \n",
> 				 i, res);
>@@ -3154,8 +3160,7 @@ static void pnv_ioda_setup_pe_res(struct pnv_ioda_pe *pe,
> 			region.start += phb->ioda.io_segsize;
> 			index++;
> 		}
>-	} else if ((res->flags & IORESOURCE_MEM) &&
>-		   !pnv_pci_is_mem_pref_64(res->flags)) {
>+	} else if ((res->flags & IORESOURCE_MEM) && !pnv_pci_is_mem_pref_64(phb, res)) {
> 		region.start = res->start -
> 			       phb->hose->mem_offset[0] -
> 			       phb->ioda.m32_pci_base;
>@@ -3314,9 +3319,11 @@ static resource_size_t pnv_pci_window_alignment(struct pci_bus *bus,
> 		bridge = bridge->bus->self;
> 	}
>
>-	/* We fail back to M32 if M64 isn't supported */
>-	if (phb->ioda.m64_segsize &&
>-	    pnv_pci_is_mem_pref_64(type))
>+	/* We fail back to M32 if M64 isn't supported. We enforce the M64
>+	 * alignment for any 64-bit resource, PCIe doesn't care and
>+	 * bridges only do 64-bit prefetchable anyway
>+	 */
>+	if (phb->ioda.m64_segsize && (type & IORESOURCE_MEM_64))
> 		return phb->ioda.m64_segsize;
> 	if (type & IORESOURCE_MEM)
> 		return phb->ioda.m32_segsize;
>
>
