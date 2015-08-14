Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3A45B1A0034
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2015 10:58:36 +1000 (AEST)
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0888D1401E7
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Aug 2015 10:58:36 +1000 (AEST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 14 Aug 2015 10:58:34 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id C82D72CE8052
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Aug 2015 10:58:32 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7E0wO6q55967906
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Aug 2015 10:58:32 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7E0w0ux027207
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Aug 2015 10:58:00 +1000
Date: Fri, 14 Aug 2015 10:57:35 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: aik@ozlabs.ru, gwshan@linux.vnet.ibm.com, benh@kernel.crashing.org,
 linuxppc-dev@ozlabs.org
Subject: Re: [PATCH v3 5/6] powerpc/powernv: boundary the total VF BAR size
 instead of the individual one
Message-ID: <20150814005735.GB18334@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1439475071-7001-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1439475071-7001-6-git-send-email-weiyang@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1439475071-7001-6-git-send-email-weiyang@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 13, 2015 at 10:11:10PM +0800, Wei Yang wrote:
>Each VF could have 6 BARs at most. When the total BAR size exceeds the
>gate, after expanding it will also exhaust the M64 Window.
>
>This patch limits the boundary by checking the total VF BAR size instead of
>the individual BAR.
>
>Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>

Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

>---
> arch/powerpc/platforms/powernv/pci-ioda.c |   13 +++++++------
> 1 file changed, 7 insertions(+), 6 deletions(-)
>
>diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>index 3e8c0b4..1e6ac86 100644
>--- a/arch/powerpc/platforms/powernv/pci-ioda.c
>+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>@@ -2688,7 +2688,7 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
> 	struct pnv_phb *phb;
> 	struct resource *res;
> 	int i;
>-	resource_size_t size, gate;
>+	resource_size_t size, gate, total_vf_bar_sz;
> 	struct pci_dn *pdn;
> 	int mul, total_vfs;
>
>@@ -2715,6 +2715,7 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
> 	 * which will exhaust the M64 Space and limit the system flexibility.
> 	 */
> 	gate = phb->ioda.m64_segsize >> 1;
>+	total_vf_bar_sz = 0;
>
> 	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
> 		res = &pdev->resource[i + PCI_IOV_RESOURCES];
>@@ -2727,13 +2728,13 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
> 			return;
> 		}
>
>-		size = pci_iov_resource_size(pdev, i + PCI_IOV_RESOURCES);
>+		total_vf_bar_sz += pci_iov_resource_size(pdev,
>+				i + PCI_IOV_RESOURCES);
>
> 		/* bigger than or equal to gate */
>-		if (size >= gate) {
>-			dev_info(&pdev->dev, "PowerNV: VF BAR%d: %pR IOV size "
>-				"is bigger than %lld, roundup power2\n",
>-				 i, res, gate);
>+		if (total_vf_bar_sz >= gate) {
>+			dev_info(&pdev->dev, "PowerNV: VF BAR Total IOV size "
>+				"is bigger than %lld, roundup power2\n", gate);

			dev_info(&pdev->dev, "PowerNV: Total VF BAR size %lld "
				 "is bigger than %lld, roundup power2\n",
				 total_vf_bar_sz, gate);

> 			mul = roundup_pow_of_two(total_vfs);
> 			pdn->m64_single_mode = true;
> 			break;
>-- 
>1.7.9.5
>
