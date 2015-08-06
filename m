Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0F76E1A01CC
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Aug 2015 15:37:03 +1000 (AEST)
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id CAAC61402B5
 for <linuxppc-dev@ozlabs.org>; Thu,  6 Aug 2015 15:37:02 +1000 (AEST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 6 Aug 2015 15:37:01 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 625092CE8058
 for <linuxppc-dev@ozlabs.org>; Thu,  6 Aug 2015 15:36:58 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t765ajLu57409718
 for <linuxppc-dev@ozlabs.org>; Thu, 6 Aug 2015 15:36:53 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t765aPJp002050
 for <linuxppc-dev@ozlabs.org>; Thu, 6 Aug 2015 15:36:26 +1000
Date: Thu, 6 Aug 2015 15:36:01 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: aik@ozlabs.ru, gwshan@linux.vnet.ibm.com, benh@kernel.crashing.org,
 linuxppc-dev@ozlabs.org
Subject: Re: [PATCH V2 6/6] powerpc/powernv: allocate discrete PE# when using
 M64 BAR in Single PE mode
Message-ID: <20150806053601.GB5636@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <20150731020148.GA6151@richard>
 <1438737903-10399-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1438737903-10399-7-git-send-email-weiyang@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1438737903-10399-7-git-send-email-weiyang@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 05, 2015 at 09:25:03AM +0800, Wei Yang wrote:
>When M64 BAR is set to Single PE mode, the PE# assigned to VF could be
>discrete.
>
>This patch restructures the patch to allocate discrete PE# for VFs when M64
>BAR is set to Single PE mode.
>
>Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>---
> arch/powerpc/include/asm/pci-bridge.h     |    2 +-
> arch/powerpc/platforms/powernv/pci-ioda.c |   69 +++++++++++++++++++++--------
> 2 files changed, 51 insertions(+), 20 deletions(-)
>
>diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
>index 8aeba4c..72415c7 100644
>--- a/arch/powerpc/include/asm/pci-bridge.h
>+++ b/arch/powerpc/include/asm/pci-bridge.h
>@@ -213,7 +213,7 @@ struct pci_dn {
> #ifdef CONFIG_PCI_IOV
> 	u16     vfs_expanded;		/* number of VFs IOV BAR expanded */
> 	u16     num_vfs;		/* number of VFs enabled*/
>-	int     offset;			/* PE# for the first VF PE */
>+	int     *offset;		/* PE# for the first VF PE or array */
> 	bool    m64_single_mode;	/* Use M64 BAR in Single Mode */
> #define IODA_INVALID_M64        (-1)
> 	int     (*m64_map)[PCI_SRIOV_NUM_BARS];

how about renaming "offset" to "pe_num_map", or "pe_map" ? Similar to the comments
I gave to the "m64_bar_map", num_of_max_vfs entries can be allocated. Though not
all of them will be used, not too much memory will be wasted.

>diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>index 4042303..9953829 100644
>--- a/arch/powerpc/platforms/powernv/pci-ioda.c
>+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>@@ -1243,7 +1243,7 @@ static int pnv_pci_vf_assign_m64(struct pci_dev *pdev, u16 num_vfs)
>
> 			/* Map the M64 here */
> 			if (pdn->m64_single_mode) {
>-				pe_num = pdn->offset + j;
>+				pe_num = pdn->offset[j];
> 				rc = opal_pci_map_pe_mmio_window(phb->opal_id,
> 						pe_num, OPAL_M64_WINDOW_TYPE,
> 						pdn->m64_map[j][i], 0);
>@@ -1347,7 +1347,7 @@ void pnv_pci_sriov_disable(struct pci_dev *pdev)
> 	struct pnv_phb        *phb;
> 	struct pci_dn         *pdn;
> 	struct pci_sriov      *iov;
>-	u16 num_vfs;
>+	u16                    num_vfs, i;
>
> 	bus = pdev->bus;
> 	hose = pci_bus_to_host(bus);
>@@ -1361,14 +1361,18 @@ void pnv_pci_sriov_disable(struct pci_dev *pdev)
>
> 	if (phb->type == PNV_PHB_IODA2) {
> 		if (!pdn->m64_single_mode)
>-			pnv_pci_vf_resource_shift(pdev, -pdn->offset);
>+			pnv_pci_vf_resource_shift(pdev, -*pdn->offset);
>
> 		/* Release M64 windows */
> 		pnv_pci_vf_release_m64(pdev, num_vfs);
>
> 		/* Release PE numbers */
>-		bitmap_clear(phb->ioda.pe_alloc, pdn->offset, num_vfs);
>-		pdn->offset = 0;
>+		if (pdn->m64_single_mode) {
>+			for (i = 0; i < num_vfs; i++)
>+				pnv_ioda_free_pe(phb, pdn->offset[i]);
>+		} else
>+			bitmap_clear(phb->ioda.pe_alloc, *pdn->offset, num_vfs);
>+		kfree(pdn->offset);

Can pnv_ioda_free_pe() be reused to release PE ?

> 	}
> }
>
>@@ -1394,7 +1398,10 @@ static void pnv_ioda_setup_vf_PE(struct pci_dev *pdev, u16 num_vfs)
>
> 	/* Reserve PE for each VF */
> 	for (vf_index = 0; vf_index < num_vfs; vf_index++) {
>-		pe_num = pdn->offset + vf_index;
>+		if (pdn->m64_single_mode)
>+			pe_num = pdn->offset[vf_index];
>+		else
>+			pe_num = *pdn->offset + vf_index;
>
> 		pe = &phb->ioda.pe_array[pe_num];
> 		pe->pe_number = pe_num;
>@@ -1436,6 +1443,7 @@ int pnv_pci_sriov_enable(struct pci_dev *pdev, u16 num_vfs)
> 	struct pnv_phb        *phb;
> 	struct pci_dn         *pdn;
> 	int                    ret;
>+	u16                    i;
>
> 	bus = pdev->bus;
> 	hose = pci_bus_to_host(bus);
>@@ -1462,19 +1470,38 @@ int pnv_pci_sriov_enable(struct pci_dev *pdev, u16 num_vfs)
> 		}
>
> 		/* Calculate available PE for required VFs */
>-		mutex_lock(&phb->ioda.pe_alloc_mutex);
>-		pdn->offset = bitmap_find_next_zero_area(
>-			phb->ioda.pe_alloc, phb->ioda.total_pe,
>-			0, num_vfs, 0);
>-		if (pdn->offset >= phb->ioda.total_pe) {
>+		if (pdn->m64_single_mode) {
>+			pdn->offset = kmalloc(sizeof(*pdn->offset) * num_vfs,
>+					GFP_KERNEL);
>+			if (!pdn->offset)
>+				return -ENOMEM;
>+			for (i = 0; i < num_vfs; i++)
>+				pdn->offset[i] = IODA_INVALID_PE;
>+			for (i = 0; i < num_vfs; i++) {
>+				pdn->offset[i] = pnv_ioda_alloc_pe(phb);
>+				if (pdn->offset[i] == IODA_INVALID_PE) {
>+					ret = -EBUSY;
>+					goto m64_failed;
>+				}
>+			}
>+		} else {
>+			pdn->offset = kmalloc(sizeof(*pdn->offset), GFP_KERNEL);
>+			if (!pdn->offset)
>+				return -ENOMEM;
>+			mutex_lock(&phb->ioda.pe_alloc_mutex);
>+			*pdn->offset = bitmap_find_next_zero_area(
>+				phb->ioda.pe_alloc, phb->ioda.total_pe,
>+				0, num_vfs, 0);
>+			if (*pdn->offset >= phb->ioda.total_pe) {
>+				mutex_unlock(&phb->ioda.pe_alloc_mutex);
>+				dev_info(&pdev->dev, "Failed to enable VF%d\n", num_vfs);
>+				kfree(pdn->offset);
>+				return -EBUSY;
>+			}
>+			bitmap_set(phb->ioda.pe_alloc, *pdn->offset, num_vfs);
> 			mutex_unlock(&phb->ioda.pe_alloc_mutex);
>-			dev_info(&pdev->dev, "Failed to enable VF%d\n", num_vfs);
>-			pdn->offset = 0;
>-			return -EBUSY;
> 		}
>-		bitmap_set(phb->ioda.pe_alloc, pdn->offset, num_vfs);
> 		pdn->num_vfs = num_vfs;
>-		mutex_unlock(&phb->ioda.pe_alloc_mutex);
>
> 		/* Assign M64 window accordingly */
> 		ret = pnv_pci_vf_assign_m64(pdev, num_vfs);
>@@ -1489,7 +1516,7 @@ int pnv_pci_sriov_enable(struct pci_dev *pdev, u16 num_vfs)
> 		 * Otherwise, the PE# for the VF will conflict with others.
> 		 */
> 		if (!pdn->m64_single_mode) {
>-			ret = pnv_pci_vf_resource_shift(pdev, pdn->offset);
>+			ret = pnv_pci_vf_resource_shift(pdev, *pdn->offset);
> 			if (ret)
> 				goto m64_failed;
> 		}
>@@ -1501,8 +1528,12 @@ int pnv_pci_sriov_enable(struct pci_dev *pdev, u16 num_vfs)
> 	return 0;
>
> m64_failed:
>-	bitmap_clear(phb->ioda.pe_alloc, pdn->offset, num_vfs);
>-	pdn->offset = 0;
>+	if (pdn->m64_single_mode) {
>+		for (i = 0; i < num_vfs; i++)
>+			pnv_ioda_free_pe(phb, pdn->offset[i]);
>+	} else
>+		bitmap_clear(phb->ioda.pe_alloc, *pdn->offset, num_vfs);
>+	kfree(pdn->offset);
>
> 	return ret;
> }
>-- 
>1.7.9.5
>
