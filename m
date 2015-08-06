Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DABDD1A1001
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Aug 2015 15:27:33 +1000 (AEST)
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id AF2A11402AD
 for <linuxppc-dev@ozlabs.org>; Thu,  6 Aug 2015 15:27:33 +1000 (AEST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 6 Aug 2015 15:27:33 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 427832CE8057
 for <linuxppc-dev@ozlabs.org>; Thu,  6 Aug 2015 15:27:31 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t765RMf450987226
 for <linuxppc-dev@ozlabs.org>; Thu, 6 Aug 2015 15:27:31 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t765Qw5G019360
 for <linuxppc-dev@ozlabs.org>; Thu, 6 Aug 2015 15:26:58 +1000
Date: Thu, 6 Aug 2015 15:26:33 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: aik@ozlabs.ru, gwshan@linux.vnet.ibm.com, benh@kernel.crashing.org,
 linuxppc-dev@ozlabs.org
Subject: Re: [PATCH V2 4/6] powerpc/powernv: replace the hard coded boundary
 with gate
Message-ID: <20150806052633.GA4767@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <20150731020148.GA6151@richard>
 <1438737903-10399-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1438737903-10399-5-git-send-email-weiyang@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1438737903-10399-5-git-send-email-weiyang@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 05, 2015 at 09:25:01AM +0800, Wei Yang wrote:
>Based on the limitation of M64 Window size, when VF BAR size is bigger than
>64MB, IOV BAR just round up power of 2 of the total_vfs. While the 64MB is
>a magic boundary in code, which is hard to maintain.
>
>This patch replaces the hard coded boundary with gate, which is calculated
>from m64_segsize and adds comment to explain the reason for it.
>
>Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>---
> arch/powerpc/platforms/powernv/pci-ioda.c |   22 +++++++++++++++++-----
> 1 file changed, 17 insertions(+), 5 deletions(-)
>
>diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>index f5d110c..31dcedc 100644
>--- a/arch/powerpc/platforms/powernv/pci-ioda.c
>+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>@@ -2702,7 +2702,7 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
> 	struct pnv_phb *phb;
> 	struct resource *res;
> 	int i;
>-	resource_size_t size;
>+	resource_size_t size, gate;
> 	struct pci_dn *pdn;
> 	int mul, total_vfs;
>
>@@ -2718,6 +2718,17 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
>
> 	total_vfs = pci_sriov_get_totalvfs(pdev);
> 	mul = phb->ioda.total_pe;
>+	/*
>+	 * If bigger than or equal to half of m64_segsize, just round up power
>+	 * of two.
>+	 *
>+	 * Generally, one M64 BAR maps one IOV BAR. To avoid conflict with
>+	 * other devices, IOV BAR size is expanded to be (total_pe * VF size).
>+	 * When VF size is half of m64_segsize , the expanded size would equal
>+	 * to half of the whole M64 Window size, which will exhaust the M64
>+	 * Window and limit the system flexibility.
>+	 */

s/VF size/VF BAR size
s/m64_segsize/M64 segment size
s/M64 Window/M64 space

>+	gate = phb->ioda.m64_segsize >> 1;
>
> 	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
> 		res = &pdev->resource[i + PCI_IOV_RESOURCES];
>@@ -2732,10 +2743,11 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
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

If I understand the changes correctly, single VF BAR size is still checked against
the "gate" (128MB), not the total VF BAR size. Recap the comments I gave last time:

I mean to check the sum of all VF BARs. For example, the VFs attached to its PF has two
VF BARs and each of them is 64MB. For this case, the MMIO resource can't be allocated
once extending them to 256 VFs. So we have to try "single-pe-mode" for this situation.
So the check becomes as below:

        struct pci_controller *hose = pci_bus_to_host(pdev->bus);
        struct pnv_phb *phb = hose->private_data;
        resource_size_t total_vf_bar_sz = 0;
        resource_size_t gate;

        /* Some comments to explain the "gate" */
        gate = phb->m64_segsize / 2;
        for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
                total_vf_bar_sz += pci_iov_resource_size(pdev, PCI_IOV_RESOURCES + i);

        if (total_vf_bar_sz >= gate)
                /* single-pe-mode */
        else
                /* shared-mode */

> 			mul = roundup_pow_of_two(total_vfs);
> 			pdn->m64_single_mode = true;
> 			break;
>-- 
>1.7.9.5
>
