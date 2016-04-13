Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-x22b.google.com (mail-pa0-x22b.google.com
 [IPv6:2607:f8b0:400e:c03::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qlCkb3L0TzDqLT
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Apr 2016 15:57:27 +1000 (AEST)
Received: by mail-pa0-x22b.google.com with SMTP id fs9so8596427pac.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Apr 2016 22:57:27 -0700 (PDT)
Subject: Re: [PATCH v8 07/45] powerpc/powernv: Rename PE# fields in struct
 pnv_phb
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1455680668-23298-8-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, dja@axtens.net,
 bhelgaas@google.com, robherring2@gmail.com, grant.likely@linaro.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <570DDFBE.40302@ozlabs.ru>
Date: Wed, 13 Apr 2016 15:57:18 +1000
MIME-Version: 1.0
In-Reply-To: <1455680668-23298-8-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/17/2016 02:43 PM, Gavin Shan wrote:
> This renames the fields related to PE number in "struct pnv_phb"
> for better reflecting of their usages as Alexey suggested. No
> logical changes introduced.
>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>


Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>


> ---
>   arch/powerpc/platforms/powernv/eeh-powernv.c |  2 +-
>   arch/powerpc/platforms/powernv/pci-ioda.c    | 58 ++++++++++++++--------------
>   arch/powerpc/platforms/powernv/pci.c         |  2 +-
>   arch/powerpc/platforms/powernv/pci.h         |  4 +-
>   4 files changed, 33 insertions(+), 33 deletions(-)
>
> diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
> index 950b3e5..69e41ce 100644
> --- a/arch/powerpc/platforms/powernv/eeh-powernv.c
> +++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
> @@ -75,7 +75,7 @@ static int pnv_eeh_init(void)
>   		 * and P7IOC separately. So we should regard
>   		 * PE#0 as valid for PHB3 and P7IOC.
>   		 */
> -		if (phb->ioda.reserved_pe != 0)
> +		if (phb->ioda.reserved_pe_idx != 0)
>   			eeh_add_flag(EEH_VALID_PE_ZERO);
>
>   		break;
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index 10ecd97..1d2514f 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -124,7 +124,7 @@ static inline bool pnv_pci_is_mem_pref_64(unsigned long flags)
>
>   static void pnv_ioda_reserve_pe(struct pnv_phb *phb, int pe_no)
>   {
> -	if (!(pe_no >= 0 && pe_no < phb->ioda.total_pe)) {
> +	if (!(pe_no >= 0 && pe_no < phb->ioda.total_pe_num)) {
>   		pr_warn("%s: Invalid PE %d on PHB#%x\n",
>   			__func__, pe_no, phb->hose->global_number);
>   		return;
> @@ -144,8 +144,8 @@ static int pnv_ioda_alloc_pe(struct pnv_phb *phb)
>
>   	do {
>   		pe = find_next_zero_bit(phb->ioda.pe_alloc,
> -					phb->ioda.total_pe, 0);
> -		if (pe >= phb->ioda.total_pe)
> +					phb->ioda.total_pe_num, 0);
> +		if (pe >= phb->ioda.total_pe_num)
>   			return IODA_INVALID_PE;
>   	} while(test_and_set_bit(pe, phb->ioda.pe_alloc));
>
> @@ -199,13 +199,13 @@ static int pnv_ioda2_init_m64(struct pnv_phb *phb)
>   	 * expected to be 0 or last one of PE capabicity.
>   	 */
>   	r = &phb->hose->mem_resources[1];
> -	if (phb->ioda.reserved_pe == 0)
> +	if (phb->ioda.reserved_pe_idx == 0)
>   		r->start += phb->ioda.m64_segsize;
> -	else if (phb->ioda.reserved_pe == (phb->ioda.total_pe - 1))
> +	else if (phb->ioda.reserved_pe_idx == (phb->ioda.total_pe_num - 1))
>   		r->end -= phb->ioda.m64_segsize;
>   	else
>   		pr_warn("  Cannot strip M64 segment for reserved PE#%d\n",
> -			phb->ioda.reserved_pe);
> +			phb->ioda.reserved_pe_idx);
>
>   	return 0;
>
> @@ -274,7 +274,7 @@ static int pnv_ioda2_pick_m64_pe(struct pci_bus *bus, bool all)
>   		return IODA_INVALID_PE;
>
>   	/* Allocate bitmap */
> -	size = _ALIGN_UP(phb->ioda.total_pe / 8, sizeof(unsigned long));
> +	size = _ALIGN_UP(phb->ioda.total_pe_num / 8, sizeof(unsigned long));
>   	pe_alloc = kzalloc(size, GFP_KERNEL);
>   	if (!pe_alloc) {
>   		pr_warn("%s: Out of memory !\n",
> @@ -290,7 +290,7 @@ static int pnv_ioda2_pick_m64_pe(struct pci_bus *bus, bool all)
>   	 * contributed by its child buses. For the case, we needn't
>   	 * pick M64 dependent PE#.
>   	 */
> -	if (bitmap_empty(pe_alloc, phb->ioda.total_pe)) {
> +	if (bitmap_empty(pe_alloc, phb->ioda.total_pe_num)) {
>   		kfree(pe_alloc);
>   		return IODA_INVALID_PE;
>   	}
> @@ -301,8 +301,8 @@ static int pnv_ioda2_pick_m64_pe(struct pci_bus *bus, bool all)
>   	 */
>   	master_pe = NULL;
>   	i = -1;
> -	while ((i = find_next_bit(pe_alloc, phb->ioda.total_pe, i + 1)) <
> -		phb->ioda.total_pe) {
> +	while ((i = find_next_bit(pe_alloc, phb->ioda.total_pe_num, i + 1)) <
> +		phb->ioda.total_pe_num) {
>   		pe = &phb->ioda.pe_array[i];
>
>   		if (!master_pe) {
> @@ -355,7 +355,7 @@ static void __init pnv_ioda_parse_m64_window(struct pnv_phb *phb)
>   	hose->mem_offset[1] = res->start - pci_addr;
>
>   	phb->ioda.m64_size = resource_size(res);
> -	phb->ioda.m64_segsize = phb->ioda.m64_size / phb->ioda.total_pe;
> +	phb->ioda.m64_segsize = phb->ioda.m64_size / phb->ioda.total_pe_num;
>   	phb->ioda.m64_base = pci_addr;
>
>   	pr_info(" MEM64 0x%016llx..0x%016llx -> 0x%016llx\n",
> @@ -456,7 +456,7 @@ static int pnv_ioda_get_pe_state(struct pnv_phb *phb, int pe_no)
>   	s64 rc;
>
>   	/* Sanity check on PE number */
> -	if (pe_no < 0 || pe_no >= phb->ioda.total_pe)
> +	if (pe_no < 0 || pe_no >= phb->ioda.total_pe_num)
>   		return OPAL_EEH_STOPPED_PERM_UNAVAIL;
>
>   	/*
> @@ -1088,7 +1088,7 @@ static struct pnv_ioda_pe *pnv_ioda_setup_npu_PE(struct pci_dev *npu_pdev)
>   	 * same GPU get assigned the same PE.
>   	 */
>   	gpu_pdev = pnv_pci_get_gpu_dev(npu_pdev);
> -	for (pe_num = 0; pe_num < phb->ioda.total_pe; pe_num++) {
> +	for (pe_num = 0; pe_num < phb->ioda.total_pe_num; pe_num++) {
>   		pe = &phb->ioda.pe_array[pe_num];
>   		if (!pe->pdev)
>   			continue;
> @@ -1537,9 +1537,9 @@ int pnv_pci_sriov_enable(struct pci_dev *pdev, u16 num_vfs)
>   		} else {
>   			mutex_lock(&phb->ioda.pe_alloc_mutex);
>   			*pdn->pe_num_map = bitmap_find_next_zero_area(
> -				phb->ioda.pe_alloc, phb->ioda.total_pe,
> +				phb->ioda.pe_alloc, phb->ioda.total_pe_num,
>   				0, num_vfs, 0);
> -			if (*pdn->pe_num_map >= phb->ioda.total_pe) {
> +			if (*pdn->pe_num_map >= phb->ioda.total_pe_num) {
>   				mutex_unlock(&phb->ioda.pe_alloc_mutex);
>   				dev_info(&pdev->dev, "Failed to enable VF%d\n", num_vfs);
>   				kfree(pdn->pe_num_map);
> @@ -2858,7 +2858,7 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
>   	pdn->m64_single_mode = false;
>
>   	total_vfs = pci_sriov_get_totalvfs(pdev);
> -	mul = phb->ioda.total_pe;
> +	mul = phb->ioda.total_pe_num;
>   	total_vf_bar_sz = 0;
>
>   	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
> @@ -2960,7 +2960,7 @@ static void pnv_ioda_setup_pe_seg(struct pci_controller *hose,
>   			region.end   = res->end - phb->ioda.io_pci_base;
>   			index = region.start / phb->ioda.io_segsize;
>
> -			while (index < phb->ioda.total_pe &&
> +			while (index < phb->ioda.total_pe_num &&
>   			       region.start <= region.end) {
>   				phb->ioda.io_segmap[index] = pe->pe_number;
>   				rc = opal_pci_map_pe_mmio_window(phb->opal_id,
> @@ -2985,7 +2985,7 @@ static void pnv_ioda_setup_pe_seg(struct pci_controller *hose,
>   				       phb->ioda.m32_pci_base;
>   			index = region.start / phb->ioda.m32_segsize;
>
> -			while (index < phb->ioda.total_pe &&
> +			while (index < phb->ioda.total_pe_num &&
>   			       region.start <= region.end) {
>   				phb->ioda.m32_segmap[index] = pe->pe_number;
>   				rc = opal_pci_map_pe_mmio_window(phb->opal_id,
> @@ -3300,13 +3300,13 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
>   		pr_err("  Failed to map registers !\n");
>
>   	/* Initialize more IODA stuff */
> -	phb->ioda.total_pe = 1;
> +	phb->ioda.total_pe_num = 1;
>   	prop32 = of_get_property(np, "ibm,opal-num-pes", NULL);
>   	if (prop32)
> -		phb->ioda.total_pe = be32_to_cpup(prop32);
> +		phb->ioda.total_pe_num = be32_to_cpup(prop32);
>   	prop32 = of_get_property(np, "ibm,opal-reserved-pe", NULL);
>   	if (prop32)
> -		phb->ioda.reserved_pe = be32_to_cpup(prop32);
> +		phb->ioda.reserved_pe_idx = be32_to_cpup(prop32);
>
>   	/* Parse 64-bit MMIO range */
>   	pnv_ioda_parse_m64_window(phb);
> @@ -3315,29 +3315,29 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
>   	/* FW Has already off top 64k of M32 space (MSI space) */
>   	phb->ioda.m32_size += 0x10000;
>
> -	phb->ioda.m32_segsize = phb->ioda.m32_size / phb->ioda.total_pe;
> +	phb->ioda.m32_segsize = phb->ioda.m32_size / phb->ioda.total_pe_num;
>   	phb->ioda.m32_pci_base = hose->mem_resources[0].start - hose->mem_offset[0];
>   	phb->ioda.io_size = hose->pci_io_size;
> -	phb->ioda.io_segsize = phb->ioda.io_size / phb->ioda.total_pe;
> +	phb->ioda.io_segsize = phb->ioda.io_size / phb->ioda.total_pe_num;
>   	phb->ioda.io_pci_base = 0; /* XXX calculate this ? */
>
>   	/* Allocate aux data & arrays. We don't have IO ports on PHB3 */
> -	size = _ALIGN_UP(phb->ioda.total_pe / 8, sizeof(unsigned long));
> +	size = _ALIGN_UP(phb->ioda.total_pe_num / 8, sizeof(unsigned long));
>   	m32map_off = size;
> -	size += phb->ioda.total_pe * sizeof(phb->ioda.m32_segmap[0]);
> +	size += phb->ioda.total_pe_num * sizeof(phb->ioda.m32_segmap[0]);
>   	if (phb->type == PNV_PHB_IODA1) {
>   		iomap_off = size;
> -		size += phb->ioda.total_pe * sizeof(phb->ioda.io_segmap[0]);
> +		size += phb->ioda.total_pe_num * sizeof(phb->ioda.io_segmap[0]);
>   	}
>   	pemap_off = size;
> -	size += phb->ioda.total_pe * sizeof(struct pnv_ioda_pe);
> +	size += phb->ioda.total_pe_num * sizeof(struct pnv_ioda_pe);
>   	aux = memblock_virt_alloc(size, 0);
>   	phb->ioda.pe_alloc = aux;
>   	phb->ioda.m32_segmap = aux + m32map_off;
>   	if (phb->type == PNV_PHB_IODA1)
>   		phb->ioda.io_segmap = aux + iomap_off;
>   	phb->ioda.pe_array = aux + pemap_off;
> -	set_bit(phb->ioda.reserved_pe, phb->ioda.pe_alloc);
> +	set_bit(phb->ioda.reserved_pe_idx, phb->ioda.pe_alloc);
>
>   	INIT_LIST_HEAD(&phb->ioda.pe_dma_list);
>   	INIT_LIST_HEAD(&phb->ioda.pe_list);
> @@ -3356,7 +3356,7 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
>   #endif
>
>   	pr_info("  %03d (%03d) PE's M32: 0x%x [segment=0x%x]\n",
> -		phb->ioda.total_pe, phb->ioda.reserved_pe,
> +		phb->ioda.total_pe_num, phb->ioda.reserved_pe_idx,
>   		phb->ioda.m32_size, phb->ioda.m32_segsize);
>   	if (phb->ioda.m64_size)
>   		pr_info("                 M64: 0x%lx [segment=0x%lx]\n",
> diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
> index f838fcf..a53e4c8 100644
> --- a/arch/powerpc/platforms/powernv/pci.c
> +++ b/arch/powerpc/platforms/powernv/pci.c
> @@ -380,7 +380,7 @@ static void pnv_pci_config_check_eeh(struct pci_dn *pdn)
>   	 */
>   	pe_no = pdn->pe_number;
>   	if (pe_no == IODA_INVALID_PE) {
> -		pe_no = phb->ioda.reserved_pe;
> +		pe_no = phb->ioda.reserved_pe_idx;
>   	}
>
>   	/*
> diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
> index f2a1452..784882a 100644
> --- a/arch/powerpc/platforms/powernv/pci.h
> +++ b/arch/powerpc/platforms/powernv/pci.h
> @@ -120,8 +120,8 @@ struct pnv_phb {
>
>   	struct {
>   		/* Global bridge info */
> -		unsigned int		total_pe;
> -		unsigned int		reserved_pe;
> +		unsigned int		total_pe_num;
> +		unsigned int		reserved_pe_idx;
>
>   		/* 32-bit MMIO window */
>   		unsigned int		m32_size;
>


-- 
Alexey
