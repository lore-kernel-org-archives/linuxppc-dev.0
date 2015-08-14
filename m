Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C82871A0779
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2015 13:58:00 +1000 (AEST)
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2D55E140216
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Aug 2015 13:58:00 +1000 (AEST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Fri, 14 Aug 2015 09:27:57 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 173A9394005A
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Aug 2015 09:27:55 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7E3vsBk17629264
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Aug 2015 09:27:54 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7E3vspl015916
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Aug 2015 09:27:54 +0530
Date: Fri, 14 Aug 2015 11:57:52 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, aik@ozlabs.ru,
 benh@kernel.crashing.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH v3 6/6] powerpc/powernv: allocate sparse PE# when using
 M64 BAR in Single PE mode
Message-ID: <20150814035752.GC11381@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <1439475071-7001-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1439475071-7001-7-git-send-email-weiyang@linux.vnet.ibm.com>
 <20150814010300.GC18334@gwshan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150814010300.GC18334@gwshan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 14, 2015 at 11:03:00AM +1000, Gavin Shan wrote:
>On Thu, Aug 13, 2015 at 10:11:11PM +0800, Wei Yang wrote:
>>When M64 BAR is set to Single PE mode, the PE# assigned to VF could be
>>sparse.
>>
>>This patch restructures the patch to allocate sparse PE# for VFs when M64
>>BAR is set to Single PE mode.
>>
>>Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>>---
>> arch/powerpc/include/asm/pci-bridge.h     |    2 +-
>> arch/powerpc/platforms/powernv/pci-ioda.c |   59 +++++++++++++++++++----------
>> 2 files changed, 41 insertions(+), 20 deletions(-)
>>
>>diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
>>index 9d33ada..b026ef8 100644
>>--- a/arch/powerpc/include/asm/pci-bridge.h
>>+++ b/arch/powerpc/include/asm/pci-bridge.h
>>@@ -214,7 +214,7 @@ struct pci_dn {
>> #ifdef CONFIG_PCI_IOV
>> 	u16     vfs_expanded;		/* number of VFs IOV BAR expanded */
>> 	u16     num_vfs;		/* number of VFs enabled*/
>>-	int     offset;			/* PE# for the first VF PE */
>>+	int     pe_num_map[MAX_M64_BAR];/* PE# for the first VF PE or array */
>
>Same question as to "m64_map". pdn for non-PF doesn't need it.
>

The same, I prefer the dynamic version.

>> 	bool    m64_single_mode;	/* Use M64 BAR in Single Mode */
>> #define IODA_INVALID_M64        (-1)
>> 	int      m64_map[PCI_SRIOV_NUM_BARS][MAX_M64_BAR];
>>diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>>index 1e6ac86..7633538 100644
>>--- a/arch/powerpc/platforms/powernv/pci-ioda.c
>>+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>>@@ -1232,7 +1232,7 @@ static int pnv_pci_vf_assign_m64(struct pci_dev *pdev, u16 num_vfs)
>>
>> 			/* Map the M64 here */
>> 			if (pdn->m64_single_mode) {
>>-				pe_num = pdn->offset + j;
>>+				pe_num = pdn->pe_num_map[j];
>> 				rc = opal_pci_map_pe_mmio_window(phb->opal_id,
>> 						pe_num, OPAL_M64_WINDOW_TYPE,
>> 						pdn->m64_map[i][j], 0);
>>@@ -1336,7 +1336,7 @@ void pnv_pci_sriov_disable(struct pci_dev *pdev)
>> 	struct pnv_phb        *phb;
>> 	struct pci_dn         *pdn;
>> 	struct pci_sriov      *iov;
>>-	u16 num_vfs;
>>+	u16 num_vfs, i;
>>
>> 	bus = pdev->bus;
>> 	hose = pci_bus_to_host(bus);
>>@@ -1350,14 +1350,17 @@ void pnv_pci_sriov_disable(struct pci_dev *pdev)
>>
>> 	if (phb->type == PNV_PHB_IODA2) {
>> 		if (!pdn->m64_single_mode)
>>-			pnv_pci_vf_resource_shift(pdev, -pdn->offset);
>>+			pnv_pci_vf_resource_shift(pdev, -pdn->pe_num_map[0]);
>>
>> 		/* Release M64 windows */
>> 		pnv_pci_vf_release_m64(pdev);
>>
>> 		/* Release PE numbers */
>>-		bitmap_clear(phb->ioda.pe_alloc, pdn->offset, num_vfs);
>>-		pdn->offset = 0;
>>+		if (pdn->m64_single_mode) {
>>+			for (i = 0; i < num_vfs; i++)
>>+				pnv_ioda_free_pe(phb, pdn->pe_num_map[i]);
>>+		} else
>>+			bitmap_clear(phb->ioda.pe_alloc, pdn->pe_num_map[0], num_vfs);
>> 	}
>> }
>>
>>@@ -1383,7 +1386,10 @@ static void pnv_ioda_setup_vf_PE(struct pci_dev *pdev, u16 num_vfs)
>>
>> 	/* Reserve PE for each VF */
>> 	for (vf_index = 0; vf_index < num_vfs; vf_index++) {
>>-		pe_num = pdn->offset + vf_index;
>>+		if (pdn->m64_single_mode)
>>+			pe_num = pdn->pe_num_map[vf_index];
>>+		else
>>+			pe_num = pdn->pe_num_map[0] + vf_index;
>>
>> 		pe = &phb->ioda.pe_array[pe_num];
>> 		pe->pe_number = pe_num;
>>@@ -1425,6 +1431,7 @@ int pnv_pci_sriov_enable(struct pci_dev *pdev, u16 num_vfs)
>> 	struct pnv_phb        *phb;
>> 	struct pci_dn         *pdn;
>> 	int                    ret;
>>+	u16                    i;
>>
>> 	bus = pdev->bus;
>> 	hose = pci_bus_to_host(bus);
>>@@ -1448,19 +1455,30 @@ int pnv_pci_sriov_enable(struct pci_dev *pdev, u16 num_vfs)
>> 		}
>>
>> 		/* Calculate available PE for required VFs */
>>-		mutex_lock(&phb->ioda.pe_alloc_mutex);
>>-		pdn->offset = bitmap_find_next_zero_area(
>>-			phb->ioda.pe_alloc, phb->ioda.total_pe,
>>-			0, num_vfs, 0);
>>-		if (pdn->offset >= phb->ioda.total_pe) {
>>+		if (pdn->m64_single_mode) {
>>+			for (i = 0; i < num_vfs; i++)
>>+				pdn->pe_num_map[i] = IODA_INVALID_PE;
>>+			for (i = 0; i < num_vfs; i++) {
>>+				pdn->pe_num_map[i] = pnv_ioda_alloc_pe(phb);
>>+				if (pdn->pe_num_map[i] == IODA_INVALID_PE) {
>>+					ret = -EBUSY;
>>+					goto m64_failed;
>>+				}
>>+			}
>>+		} else {
>>+			mutex_lock(&phb->ioda.pe_alloc_mutex);
>>+			pdn->pe_num_map[0] = bitmap_find_next_zero_area(
>>+				phb->ioda.pe_alloc, phb->ioda.total_pe,
>>+				0, num_vfs, 0);
>>+			if (pdn->pe_num_map[0] >= phb->ioda.total_pe) {
>>+				mutex_unlock(&phb->ioda.pe_alloc_mutex);
>>+				dev_info(&pdev->dev, "Failed to enable VF%d\n", num_vfs);
>>+				return -EBUSY;
>>+			}
>>+			bitmap_set(phb->ioda.pe_alloc, pdn->pe_num_map[0], num_vfs);
>> 			mutex_unlock(&phb->ioda.pe_alloc_mutex);
>>-			dev_info(&pdev->dev, "Failed to enable VF%d\n", num_vfs);
>>-			pdn->offset = 0;
>>-			return -EBUSY;
>> 		}
>>-		bitmap_set(phb->ioda.pe_alloc, pdn->offset, num_vfs);
>> 		pdn->num_vfs = num_vfs;
>>-		mutex_unlock(&phb->ioda.pe_alloc_mutex);
>>
>> 		/* Assign M64 window accordingly */
>> 		ret = pnv_pci_vf_assign_m64(pdev, num_vfs);
>>@@ -1475,7 +1493,7 @@ int pnv_pci_sriov_enable(struct pci_dev *pdev, u16 num_vfs)
>> 		 * Otherwise, the PE# for the VF will conflict with others.
>> 		 */
>> 		if (!pdn->m64_single_mode) {
>>-			ret = pnv_pci_vf_resource_shift(pdev, pdn->offset);
>>+			ret = pnv_pci_vf_resource_shift(pdev, pdn->pe_num_map[0]);
>> 			if (ret)
>> 				goto m64_failed;
>> 		}
>>@@ -1487,8 +1505,11 @@ int pnv_pci_sriov_enable(struct pci_dev *pdev, u16 num_vfs)
>> 	return 0;
>>
>> m64_failed:
>>-	bitmap_clear(phb->ioda.pe_alloc, pdn->offset, num_vfs);
>>-	pdn->offset = 0;
>>+	if (pdn->m64_single_mode) {
>>+		for (i = 0; i < num_vfs; i++)
>>+			pnv_ioda_free_pe(phb, pdn->pe_num_map[i]);
>
>if pdn->pe_num_map[i] isn't valid PE number, what will happen?
>

You are right, we need to check this.

>>+	} else
>>+		bitmap_clear(phb->ioda.pe_alloc, pdn->pe_num_map[0], num_vfs);
>>
>> 	return ret;
>> }
>>-- 
>>1.7.9.5
>>

-- 
Richard Yang
Help you, Help me
