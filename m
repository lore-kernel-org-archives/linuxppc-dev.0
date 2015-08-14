Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 049B41A1D39
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2015 10:55:02 +1000 (AEST)
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id BB5651401E7
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Aug 2015 10:55:01 +1000 (AEST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 14 Aug 2015 10:55:00 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 496152CE8050
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Aug 2015 10:54:59 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7E0spFY62521492
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Aug 2015 10:54:59 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7E0sQnQ003292
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Aug 2015 10:54:26 +1000
Date: Fri, 14 Aug 2015 10:54:02 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: aik@ozlabs.ru, gwshan@linux.vnet.ibm.com, benh@kernel.crashing.org,
 linuxppc-dev@ozlabs.org
Subject: Re: [PATCH v3 4/6] powerpc/powernv: replace the hard coded boundary
 with gate
Message-ID: <20150814005402.GA18334@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1439475071-7001-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1439475071-7001-5-git-send-email-weiyang@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1439475071-7001-5-git-send-email-weiyang@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 13, 2015 at 10:11:09PM +0800, Wei Yang wrote:
>At the moment 64bit-prefetchable window can be maximum 64GB, which is
>currently got from device tree. This means that in shared mode the maximum
>supported VF BAR size is 64GB/256=256MB. While this size could exhaust the
>whole 64bit-prefetchable window. This is a design decision to set a
>boundary to 64MB of the VF BAR size. Since VF BAR size with 64MB would
>occupy a quarter of the 64bit-prefetchable window, this is affordable.
>
>This patch replaces magic limit of 64MB with (m64_segsize >> 1) and adds
>comment to explain the reason for it.
>
>Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>

Reviewed-by: Gavin Shan <gwshan@linux.vent.ibm.com>

>---
> arch/powerpc/platforms/powernv/pci-ioda.c |   22 +++++++++++++++++-----
> 1 file changed, 17 insertions(+), 5 deletions(-)
>
>diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>index 4da0f50..3e8c0b4 100644
>--- a/arch/powerpc/platforms/powernv/pci-ioda.c
>+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>@@ -2688,7 +2688,7 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
> 	struct pnv_phb *phb;
> 	struct resource *res;
> 	int i;
>-	resource_size_t size;
>+	resource_size_t size, gate;
> 	struct pci_dn *pdn;
> 	int mul, total_vfs;
>
>@@ -2704,6 +2704,17 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
>
> 	total_vfs = pci_sriov_get_totalvfs(pdev);
> 	mul = phb->ioda.total_pe;
>+	/*
>+	 * If bigger than or equal to half of M64 segment size, just round up
>+	 * power of two.
>+	 *
>+	 * Generally, one M64 BAR maps one IOV BAR. To avoid conflict with
>+	 * other devices, IOV BAR size is expanded to be (total_pe *
>+	 * VF_BAR_size).  When VF_BAR_size is half of M64 segment size , the
>+	 * expanded size would equal to half of the whole M64 Space size,
>+	 * which will exhaust the M64 Space and limit the system flexibility.
>+	 */

s/M64 Space/M64 space

>+	gate = phb->ioda.m64_segsize >> 1;
>
> 	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
> 		res = &pdev->resource[i + PCI_IOV_RESOURCES];
>@@ -2718,10 +2729,11 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
>
> 		size = pci_iov_resource_size(pdev, i + PCI_IOV_RESOURCES);
>
>-		/* bigger than 64M */
>-		if (size > (1 << 26)) {
>-			dev_info(&pdev->dev, "PowerNV: VF BAR%d: %pR IOV size is bigger than 64M, roundup power2\n",
>-				 i, res);
>+		/* bigger than or equal to gate */
>+		if (size >= gate) {
>+			dev_info(&pdev->dev, "PowerNV: VF BAR%d: %pR IOV size "
>+				"is bigger than %lld, roundup power2\n",
>+				 i, res, gate);
> 			mul = roundup_pow_of_two(total_vfs);
> 			pdn->m64_single_mode = true;
> 			break;
>-- 
>1.7.9.5
>
