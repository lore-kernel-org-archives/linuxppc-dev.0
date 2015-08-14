Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AFCEB1A1D50
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2015 13:54:39 +1000 (AEST)
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1330E1401DA
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Aug 2015 13:54:38 +1000 (AEST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Fri, 14 Aug 2015 09:24:37 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 2C9113940065
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Aug 2015 09:24:34 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7E3sX0c9896022
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Aug 2015 09:24:33 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7E3sXp7011156
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Aug 2015 09:24:33 +0530
Date: Fri, 14 Aug 2015 11:54:31 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, aik@ozlabs.ru,
 benh@kernel.crashing.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH v3 3/6] powerpc/powernv: use one M64 BAR in Single PE
 mode for one VF BAR
Message-ID: <20150814035431.GB11381@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <1439475071-7001-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1439475071-7001-4-git-send-email-weiyang@linux.vnet.ibm.com>
 <20150814005221.GB14809@gwshan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150814005221.GB14809@gwshan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 14, 2015 at 10:52:21AM +1000, Gavin Shan wrote:
>On Thu, Aug 13, 2015 at 10:11:08PM +0800, Wei Yang wrote:
>>In current implementation, when VF BAR is bigger than 64MB, it uses 4 M64
>>BARs in Single PE mode to cover the number of VFs required to be enabled.
>>By doing so, several VFs would be in one VF Group and leads to interference
>>between VFs in the same group.
>>
>>This patch changes the design by using one M64 BAR in Single PE mode for
>>one VF BAR. This gives absolute isolation for VFs.
>>
>>Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>>---
>> arch/powerpc/include/asm/pci-bridge.h     |    6 +-
>> arch/powerpc/platforms/powernv/pci-ioda.c |  163 +++++++++++------------------
>> 2 files changed, 62 insertions(+), 107 deletions(-)
>>
>>diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
>>index 712add5..9d33ada 100644
>>--- a/arch/powerpc/include/asm/pci-bridge.h
>>+++ b/arch/powerpc/include/asm/pci-bridge.h
>>@@ -187,6 +187,7 @@ static inline int isa_vaddr_is_ioport(void __iomem *address)
>>  */
>> struct iommu_table;
>>
>>+#define MAX_M64_BAR  16
>
>struct pnv_phb::m64_bar_idx is initialized to 15. Another macro is defined here
>as 16. Both of them can be used as maximal M64 BAR number. Obviously, they're
>duplicated. On the other hand, I don't think it's a good idea to have the static
>"m64_map" because @pdn is created for every PCI devices, including VFs. non-PF
>don't "m64_map", together other fields like "m64_per_iov" at all. It's obviously
>wasting memory. So it would be allocated dynamically when the PF's pdn is created
>or in pnv_pci_ioda_fixup_iov_resources().
>

I prefer the dynamic one.

Alexey,

I changed to static defined based on your comments. So do you have some
concern on the dynamic version?

>In long run, it might be reasonable to move all SRIOV related fields in pci_dn
>to another data struct (struct pci_iov_dn?) and allocate that dynamically.
>
>> 	int     flags;
>> #define PCI_DN_FLAG_IOV_VF	0x01
>>@@ -214,10 +215,9 @@ struct pci_dn {
>> 	u16     vfs_expanded;		/* number of VFs IOV BAR expanded */
>> 	u16     num_vfs;		/* number of VFs enabled*/
>> 	int     offset;			/* PE# for the first VF PE */
>>-#define M64_PER_IOV 4
>>-	int     m64_per_iov;
>>+	bool    m64_single_mode;	/* Use M64 BAR in Single Mode */
>> #define IODA_INVALID_M64        (-1)
>>-	int     m64_wins[PCI_SRIOV_NUM_BARS][M64_PER_IOV];
>>+	int      m64_map[PCI_SRIOV_NUM_BARS][MAX_M64_BAR];
>> #endif /* CONFIG_PCI_IOV */
>> #endif
>> 	struct list_head child_list;
>>diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>>index 67b8f72..4da0f50 100644
>>--- a/arch/powerpc/platforms/powernv/pci-ioda.c
>>+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>>@@ -1162,15 +1162,14 @@ static int pnv_pci_vf_release_m64(struct pci_dev *pdev)
>> 	pdn = pci_get_pdn(pdev);
>>
>> 	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++)
>>-		for (j = 0; j < M64_PER_IOV; j++) {
>>-			if (pdn->m64_wins[i][j] == IODA_INVALID_M64)
>>+		for (j = 0; j < MAX_M64_BAR; j++) {
>>+			if (pdn->m64_map[i][j] == IODA_INVALID_M64)
>> 				continue;
>> 			opal_pci_phb_mmio_enable(phb->opal_id,
>>-				OPAL_M64_WINDOW_TYPE, pdn->m64_wins[i][j], 0);
>>-			clear_bit(pdn->m64_wins[i][j], &phb->ioda.m64_bar_alloc);
>>-			pdn->m64_wins[i][j] = IODA_INVALID_M64;
>>+				OPAL_M64_WINDOW_TYPE, pdn->m64_map[i][j], 0);
>>+			clear_bit(pdn->m64_map[i][j], &phb->ioda.m64_bar_alloc);
>>+			pdn->m64_map[i][j] = IODA_INVALID_M64;
>> 		}
>>-
>> 	return 0;
>> }
>>
>>@@ -1187,8 +1186,7 @@ static int pnv_pci_vf_assign_m64(struct pci_dev *pdev, u16 num_vfs)
>> 	int                    total_vfs;
>> 	resource_size_t        size, start;
>> 	int                    pe_num;
>>-	int                    vf_groups;
>>-	int                    vf_per_group;
>>+	int                    m64_bars;
>>
>> 	bus = pdev->bus;
>> 	hose = pci_bus_to_host(bus);
>>@@ -1196,26 +1194,23 @@ static int pnv_pci_vf_assign_m64(struct pci_dev *pdev, u16 num_vfs)
>> 	pdn = pci_get_pdn(pdev);
>> 	total_vfs = pci_sriov_get_totalvfs(pdev);
>>
>>-	/* Initialize the m64_wins to IODA_INVALID_M64 */
>>-	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++)
>>-		for (j = 0; j < M64_PER_IOV; j++)
>>-			pdn->m64_wins[i][j] = IODA_INVALID_M64;
>>+	if (pdn->m64_single_mode)
>>+		m64_bars = num_vfs;
>>+	else
>>+		m64_bars = 1;
>>+
>>+	/* Initialize the m64_map to IODA_INVALID_M64 */
>>+	for (i = 0; i < PCI_SRIOV_NUM_BARS ; i++)
>>+		for (j = 0; j < MAX_M64_BAR; j++)
>>+			pdn->m64_map[i][j] = IODA_INVALID_M64;
>
>It would be done in pnv_pci_ioda_fixup_iov_resources(). That means it will
>be done for once if hotplug isn't considered. The code here will be called
>on every attempt to enable SRIOV capability, which isn't necessary, right?
>

I think you are right.


-- 
Richard Yang
Help you, Help me
