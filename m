Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9F3F11A0102
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2015 12:23:25 +1100 (AEDT)
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 17 Nov 2015 11:23:24 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 439813578052
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2015 12:23:21 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tAH1MvXb29753454
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2015 12:23:05 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tAH1MlDA011858
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2015 12:22:49 +1100
Date: Tue, 17 Nov 2015 12:22:23 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, bhelgaas@google.com,
 grant.likely@linaro.org, robherring2@gmail.com,
 panto@antoniou-consulting.com, frowand.list@gmail.com
Subject: Re: [PATCH v7 08/50] powerpc/powernv: Rename PE# fields in struct
 pnv_phb
Message-ID: <20151117012223.GA28026@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1446642770-4681-9-git-send-email-gwshan@linux.vnet.ibm.com>
 <56498D42.3000505@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56498D42.3000505@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 16, 2015 at 07:01:06PM +1100, Alexey Kardashevskiy wrote:
>On 11/05/2015 12:12 AM, Gavin Shan wrote:
>>This renames the fields related to PE number in "struct pnv_phb"
>>for better reflecting of their usages as Alexey suggested. No
>>logical changes introduced.
>>
>>Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>---
>>  arch/powerpc/platforms/powernv/eeh-powernv.c |  2 +-
>>  arch/powerpc/platforms/powernv/pci-ioda.c    | 56 ++++++++++++++--------------
>>  arch/powerpc/platforms/powernv/pci.c         |  2 +-
>>  arch/powerpc/platforms/powernv/pci.h         |  4 +-
>>  4 files changed, 32 insertions(+), 32 deletions(-)
>>
>>diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
>>index e1c9072..861a7d2 100644
>>--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
>>+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
>>@@ -75,7 +75,7 @@ static int pnv_eeh_init(void)
>>  		 * and P7IOC separately. So we should regard
>>  		 * PE#0 as valid for PHB3 and P7IOC.
>>  		 */
>>-		if (phb->ioda.reserved_pe != 0)
>>+		if (phb->ioda.reserved_pe_idx != 0)
>>  			eeh_add_flag(EEH_VALID_PE_ZERO);
>>
>>  		break;
>>diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>>index 968da91..b4932c3 100644
>>--- a/arch/powerpc/platforms/powernv/pci-ioda.c
>>+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>>@@ -134,7 +134,7 @@ static inline bool pnv_pci_is_mem_pref_64(unsigned long flags)
>>
>>  static void pnv_ioda_reserve_pe(struct pnv_phb *phb, int pe_no)
>>  {
>>-	if (!(pe_no >= 0 && pe_no < phb->ioda.total_pe)) {
>>+	if (!(pe_no >= 0 && pe_no < phb->ioda.total_pe_num)) {
>>  		pr_warn("%s: Invalid PE %d on PHB#%x\n",
>>  			__func__, pe_no, phb->hose->global_number);
>>  		return;
>>@@ -154,8 +154,8 @@ static int pnv_ioda_alloc_pe(struct pnv_phb *phb)
>>
>>  	do {
>>  		pe = find_next_zero_bit(phb->ioda.pe_alloc,
>>-					phb->ioda.total_pe, 0);
>>-		if (pe >= phb->ioda.total_pe)
>>+					phb->ioda.total_pe_num, 0);
>>+		if (pe >= phb->ioda.total_pe_num)
>>  			return IODA_INVALID_PE;
>>  	} while(test_and_set_bit(pe, phb->ioda.pe_alloc));
>>
>>@@ -209,13 +209,13 @@ static int pnv_ioda2_init_m64(struct pnv_phb *phb)
>>  	 * expected to be 0 or last one of PE capabicity.
>>  	 */
>>  	r = &phb->hose->mem_resources[1];
>>-	if (phb->ioda.reserved_pe == 0)
>>+	if (phb->ioda.reserved_pe_idx == 0)
>>  		r->start += phb->ioda.m64_segsize;
>>-	else if (phb->ioda.reserved_pe == (phb->ioda.total_pe - 1))
>>+	else if (phb->ioda.reserved_pe_idx == (phb->ioda.total_pe_num - 1))
>>  		r->end -= phb->ioda.m64_segsize;
>>  	else
>>  		pr_warn("  Cannot strip M64 segment for reserved PE#%d\n",
>>-			phb->ioda.reserved_pe);
>>+			phb->ioda.reserved_pe_idx);
>>
>>  	return 0;
>>
>>@@ -284,7 +284,7 @@ static int pnv_ioda2_pick_m64_pe(struct pci_bus *bus, bool all)
>>  		return IODA_INVALID_PE;
>>
>>  	/* Allocate bitmap */
>>-	size = _ALIGN_UP(phb->ioda.total_pe / 8, sizeof(unsigned long));
>>+	size = _ALIGN_UP(phb->ioda.total_pe_num / 8, sizeof(unsigned long));
>>  	pe_alloc = kzalloc(size, GFP_KERNEL);
>>  	if (!pe_alloc) {
>>  		pr_warn("%s: Out of memory !\n",
>>@@ -300,7 +300,7 @@ static int pnv_ioda2_pick_m64_pe(struct pci_bus *bus, bool all)
>>  	 * contributed by its child buses. For the case, we needn't
>>  	 * pick M64 dependent PE#.
>>  	 */
>>-	if (bitmap_empty(pe_alloc, phb->ioda.total_pe)) {
>>+	if (bitmap_empty(pe_alloc, phb->ioda.total_pe_num)) {
>>  		kfree(pe_alloc);
>>  		return IODA_INVALID_PE;
>>  	}
>>@@ -311,8 +311,8 @@ static int pnv_ioda2_pick_m64_pe(struct pci_bus *bus, bool all)
>>  	 */
>>  	master_pe = NULL;
>>  	i = -1;
>>-	while ((i = find_next_bit(pe_alloc, phb->ioda.total_pe, i + 1)) <
>>-		phb->ioda.total_pe) {
>>+	while ((i = find_next_bit(pe_alloc, phb->ioda.total_pe_num, i + 1)) <
>>+		phb->ioda.total_pe_num) {
>>  		pe = &phb->ioda.pe_array[i];
>>
>>  		if (!master_pe) {
>>@@ -364,7 +364,7 @@ static void __init pnv_ioda_parse_m64_window(struct pnv_phb *phb)
>>  	hose->mem_offset[1] = res->start - pci_addr;
>>
>>  	phb->ioda.m64_size = resource_size(res);
>>-	phb->ioda.m64_segsize = phb->ioda.m64_size / phb->ioda.total_pe;
>>+	phb->ioda.m64_segsize = phb->ioda.m64_size / phb->ioda.total_pe_num;
>>  	phb->ioda.m64_base = pci_addr;
>>
>>  	pr_info(" MEM64 0x%016llx..0x%016llx -> 0x%016llx\n",
>>@@ -465,7 +465,7 @@ static int pnv_ioda_get_pe_state(struct pnv_phb *phb, int pe_no)
>>  	s64 rc;
>>
>>  	/* Sanity check on PE number */
>>-	if (pe_no < 0 || pe_no >= phb->ioda.total_pe)
>>+	if (pe_no < 0 || pe_no >= phb->ioda.total_pe_num)
>>  		return OPAL_EEH_STOPPED_PERM_UNAVAIL;
>>
>>  	/*
>>@@ -1394,9 +1394,9 @@ int pnv_pci_sriov_enable(struct pci_dev *pdev, u16 num_vfs)
>>  		} else {
>>  			mutex_lock(&phb->ioda.pe_alloc_mutex);
>>  			*pdn->pe_num_map = bitmap_find_next_zero_area(
>>-				phb->ioda.pe_alloc, phb->ioda.total_pe,
>>+				phb->ioda.pe_alloc, phb->ioda.total_pe_num,
>>  				0, num_vfs, 0);
>>-			if (*pdn->pe_num_map >= phb->ioda.total_pe) {
>>+			if (*pdn->pe_num_map >= phb->ioda.total_pe_num) {
>>  				mutex_unlock(&phb->ioda.pe_alloc_mutex);
>>  				dev_info(&pdev->dev, "Failed to enable VF%d\n", num_vfs);
>>  				kfree(pdn->pe_num_map);
>>@@ -2670,7 +2670,7 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
>>  	pdn->m64_single_mode = false;
>>
>>  	total_vfs = pci_sriov_get_totalvfs(pdev);
>>-	mul = phb->ioda.total_pe;
>>+	mul = phb->ioda.total_pe_num;
>>  	total_vf_bar_sz = 0;
>>
>>  	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
>>@@ -2772,7 +2772,7 @@ static void pnv_ioda_setup_pe_seg(struct pci_controller *hose,
>>  			region.end   = res->end - phb->ioda.io_pci_base;
>>  			index = region.start / phb->ioda.io_segsize;
>>
>>-			while (index < phb->ioda.total_pe &&
>>+			while (index < phb->ioda.total_pe_num &&
>>  			       region.start <= region.end) {
>>  				phb->ioda.io_segmap[index] = pe->pe_number;
>>  				rc = opal_pci_map_pe_mmio_window(phb->opal_id,
>>@@ -2797,7 +2797,7 @@ static void pnv_ioda_setup_pe_seg(struct pci_controller *hose,
>>  				       phb->ioda.m32_pci_base;
>>  			index = region.start / phb->ioda.m32_segsize;
>>
>>-			while (index < phb->ioda.total_pe &&
>>+			while (index < phb->ioda.total_pe_num &&
>>  			       region.start <= region.end) {
>>  				phb->ioda.m32_segmap[index] = pe->pe_number;
>>  				rc = opal_pci_map_pe_mmio_window(phb->opal_id,
>>@@ -3067,13 +3067,13 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
>>  		pr_err("  Failed to map registers !\n");
>>
>>  	/* Initialize more IODA stuff */
>>-	phb->ioda.total_pe = 1;
>>+	phb->ioda.total_pe_num = 1;
>>  	prop32 = of_get_property(np, "ibm,opal-num-pes", NULL);
>>  	if (prop32)
>>-		phb->ioda.total_pe = be32_to_cpup(prop32);
>>+		phb->ioda.total_pe_num = be32_to_cpup(prop32);
>>  	prop32 = of_get_property(np, "ibm,opal-reserved-pe", NULL);
>>  	if (prop32)
>>-		phb->ioda.reserved_pe = be32_to_cpup(prop32);
>>+		phb->ioda.reserved_pe_idx = be32_to_cpup(prop32);
>
>
>It is not related to the patch but you initialize total_pe to 1 before
>checking the device tree (which is ok) but you do not initialize reserved_pe
>and I cannot find where @phb would be zeroed - it is allocated by
>memblock_virt_alloc() which does not do that.
>

There is a call "memset(ptr, 0, size)" in memblock_virt_alloc_internal().

Thanks,
Gavin
