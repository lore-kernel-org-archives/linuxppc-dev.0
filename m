Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0E6CF1A2D61
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Aug 2015 20:05:08 +1000 (AEST)
Received: from mail-pa0-f53.google.com (mail-pa0-f53.google.com
 [209.85.220.53])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5AB2D1401EF
 for <linuxppc-dev@ozlabs.org>; Thu,  6 Aug 2015 20:05:05 +1000 (AEST)
Received: by pawu10 with SMTP id u10so59523828paw.1
 for <linuxppc-dev@ozlabs.org>; Thu, 06 Aug 2015 03:05:04 -0700 (PDT)
Subject: Re: [PATCH V2 3/6] powerpc/powernv: use one M64 BAR in Single PE mode
 for one VF BAR
To: Wei Yang <weiyang@linux.vnet.ibm.com>, gwshan@linux.vnet.ibm.com,
 benh@kernel.crashing.org
References: <20150731020148.GA6151@richard>
 <1438737903-10399-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1438737903-10399-4-git-send-email-weiyang@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <55C3314A.3090305@ozlabs.ru>
Date: Thu, 6 Aug 2015 20:04:58 +1000
MIME-Version: 1.0
In-Reply-To: <1438737903-10399-4-git-send-email-weiyang@linux.vnet.ibm.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/05/2015 11:25 AM, Wei Yang wrote:
> In current implementation, when VF BAR is bigger than 64MB, it uses 4 M64
> BAR in Single PE mode to cover the number of VFs required to be enabled.
> By doing so, several VFs would be in one VF Group and leads to interference
> between VFs in the same group.
>
> This patch changes the design by using one M64 BAR in Single PE mode for
> one VF BAR. This gives absolute isolation for VFs.
>
> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
> ---
>   arch/powerpc/include/asm/pci-bridge.h     |    5 +-
>   arch/powerpc/platforms/powernv/pci-ioda.c |  180 ++++++++++++-----------------
>   2 files changed, 76 insertions(+), 109 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
> index 712add5..8aeba4c 100644
> --- a/arch/powerpc/include/asm/pci-bridge.h
> +++ b/arch/powerpc/include/asm/pci-bridge.h
> @@ -214,10 +214,9 @@ struct pci_dn {
>   	u16     vfs_expanded;		/* number of VFs IOV BAR expanded */
>   	u16     num_vfs;		/* number of VFs enabled*/
>   	int     offset;			/* PE# for the first VF PE */
> -#define M64_PER_IOV 4
> -	int     m64_per_iov;
> +	bool    m64_single_mode;	/* Use M64 BAR in Single Mode */
>   #define IODA_INVALID_M64        (-1)
> -	int     m64_wins[PCI_SRIOV_NUM_BARS][M64_PER_IOV];
> +	int     (*m64_map)[PCI_SRIOV_NUM_BARS];
>   #endif /* CONFIG_PCI_IOV */
>   #endif
>   	struct list_head child_list;
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index 7192e62..f5d110c 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -1148,29 +1148,36 @@ static void pnv_pci_ioda_setup_PEs(void)
>   }
>
>   #ifdef CONFIG_PCI_IOV
> -static int pnv_pci_vf_release_m64(struct pci_dev *pdev)
> +static int pnv_pci_vf_release_m64(struct pci_dev *pdev, u16 num_vfs)
>   {
>   	struct pci_bus        *bus;
>   	struct pci_controller *hose;
>   	struct pnv_phb        *phb;
>   	struct pci_dn         *pdn;
>   	int                    i, j;
> +	int                    m64_bars;
>
>   	bus = pdev->bus;
>   	hose = pci_bus_to_host(bus);
>   	phb = hose->private_data;
>   	pdn = pci_get_pdn(pdev);
>
> +	if (pdn->m64_single_mode)
> +		m64_bars = num_vfs;
> +	else
> +		m64_bars = 1;
> +
>   	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++)
> -		for (j = 0; j < M64_PER_IOV; j++) {
> -			if (pdn->m64_wins[i][j] == IODA_INVALID_M64)
> +		for (j = 0; j < m64_bars; j++) {
> +			if (pdn->m64_map[j][i] == IODA_INVALID_M64)
>   				continue;
>   			opal_pci_phb_mmio_enable(phb->opal_id,
> -				OPAL_M64_WINDOW_TYPE, pdn->m64_wins[i][j], 0);
> -			clear_bit(pdn->m64_wins[i][j], &phb->ioda.m64_bar_alloc);
> -			pdn->m64_wins[i][j] = IODA_INVALID_M64;
> +				OPAL_M64_WINDOW_TYPE, pdn->m64_map[j][i], 0);
> +			clear_bit(pdn->m64_map[j][i], &phb->ioda.m64_bar_alloc);
> +			pdn->m64_map[j][i] = IODA_INVALID_M64;
>   		}
>
> +	kfree(pdn->m64_map);
>   	return 0;
>   }
>
> @@ -1187,8 +1194,7 @@ static int pnv_pci_vf_assign_m64(struct pci_dev *pdev, u16 num_vfs)
>   	int                    total_vfs;
>   	resource_size_t        size, start;
>   	int                    pe_num;
> -	int                    vf_groups;
> -	int                    vf_per_group;
> +	int                    m64_bars;
>
>   	bus = pdev->bus;
>   	hose = pci_bus_to_host(bus);
> @@ -1196,26 +1202,26 @@ static int pnv_pci_vf_assign_m64(struct pci_dev *pdev, u16 num_vfs)
>   	pdn = pci_get_pdn(pdev);
>   	total_vfs = pci_sriov_get_totalvfs(pdev);
>
> -	/* Initialize the m64_wins to IODA_INVALID_M64 */
> -	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++)
> -		for (j = 0; j < M64_PER_IOV; j++)
> -			pdn->m64_wins[i][j] = IODA_INVALID_M64;
> +	if (pdn->m64_single_mode)


This is a physical function's @pdn, right?


> +		m64_bars = num_vfs;
> +	else
> +		m64_bars = 1;
> +
> +	pdn->m64_map = kmalloc(sizeof(*pdn->m64_map) * m64_bars, GFP_KERNEL);


Assume we have SRIOV device with 16VF.
So it was m64_wins[6][4], now it is (roughly speaking) m64_map[6][16] (for 
a single PE mode) or m64_map[6][1]. I believe m64_bars cannot be bigger 
than 16 on PHB3, right? Is this checked anywhere (does it have to)?

This m64_wins -> m64_map change - is was not a map (what was it?), and it 
is, is not it?

What does it store? An index of M64 BAR (0..15)?



> +	if (!pdn->m64_map)
> +		return -ENOMEM;
> +	/* Initialize the m64_map to IODA_INVALID_M64 */
> +	for (i = 0; i < m64_bars ; i++)
> +		for (j = 0; j < PCI_SRIOV_NUM_BARS; j++)
> +			pdn->m64_map[i][j] = IODA_INVALID_M64;
>
> -	if (pdn->m64_per_iov == M64_PER_IOV) {
> -		vf_groups = (num_vfs <= M64_PER_IOV) ? num_vfs: M64_PER_IOV;
> -		vf_per_group = (num_vfs <= M64_PER_IOV)? 1:
> -			roundup_pow_of_two(num_vfs) / pdn->m64_per_iov;
> -	} else {
> -		vf_groups = 1;
> -		vf_per_group = 1;
> -	}
>
>   	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
>   		res = &pdev->resource[i + PCI_IOV_RESOURCES];
>   		if (!res->flags || !res->parent)
>   			continue;
>
> -		for (j = 0; j < vf_groups; j++) {
> +		for (j = 0; j < m64_bars; j++) {
>   			do {
>   				win = find_next_zero_bit(&phb->ioda.m64_bar_alloc,
>   						phb->ioda.m64_bar_idx + 1, 0);
> @@ -1224,12 +1230,11 @@ static int pnv_pci_vf_assign_m64(struct pci_dev *pdev, u16 num_vfs)
>   					goto m64_failed;
>   			} while (test_and_set_bit(win, &phb->ioda.m64_bar_alloc));
>
> -			pdn->m64_wins[i][j] = win;
> +			pdn->m64_map[j][i] = win;
>
> -			if (pdn->m64_per_iov == M64_PER_IOV) {
> +			if (pdn->m64_single_mode) {
>   				size = pci_iov_resource_size(pdev,
>   							PCI_IOV_RESOURCES + i);
> -				size = size * vf_per_group;
>   				start = res->start + size * j;
>   			} else {
>   				size = resource_size(res);
> @@ -1237,16 +1242,16 @@ static int pnv_pci_vf_assign_m64(struct pci_dev *pdev, u16 num_vfs)
>   			}
>
>   			/* Map the M64 here */
> -			if (pdn->m64_per_iov == M64_PER_IOV) {
> +			if (pdn->m64_single_mode) {
>   				pe_num = pdn->offset + j;
>   				rc = opal_pci_map_pe_mmio_window(phb->opal_id,
>   						pe_num, OPAL_M64_WINDOW_TYPE,
> -						pdn->m64_wins[i][j], 0);
> +						pdn->m64_map[j][i], 0);
>   			}
>
>   			rc = opal_pci_set_phb_mem_window(phb->opal_id,
>   						 OPAL_M64_WINDOW_TYPE,
> -						 pdn->m64_wins[i][j],
> +						 pdn->m64_map[j][i],
>   						 start,
>   						 0, /* unused */
>   						 size);
> @@ -1258,12 +1263,12 @@ static int pnv_pci_vf_assign_m64(struct pci_dev *pdev, u16 num_vfs)
>   				goto m64_failed;
>   			}
>
> -			if (pdn->m64_per_iov == M64_PER_IOV)
> +			if (pdn->m64_single_mode)
>   				rc = opal_pci_phb_mmio_enable(phb->opal_id,
> -				     OPAL_M64_WINDOW_TYPE, pdn->m64_wins[i][j], 2);
> +				     OPAL_M64_WINDOW_TYPE, pdn->m64_map[j][i], 2);
>   			else
>   				rc = opal_pci_phb_mmio_enable(phb->opal_id,
> -				     OPAL_M64_WINDOW_TYPE, pdn->m64_wins[i][j], 1);
> +				     OPAL_M64_WINDOW_TYPE, pdn->m64_map[j][i], 1);
>
>   			if (rc != OPAL_SUCCESS) {
>   				dev_err(&pdev->dev, "Failed to enable M64 window #%d: %llx\n",
> @@ -1275,7 +1280,7 @@ static int pnv_pci_vf_assign_m64(struct pci_dev *pdev, u16 num_vfs)
>   	return 0;
>
>   m64_failed:
> -	pnv_pci_vf_release_m64(pdev);
> +	pnv_pci_vf_release_m64(pdev, num_vfs);
>   	return -EBUSY;
>   }
>
> @@ -1302,15 +1307,13 @@ static void pnv_pci_ioda2_release_dma_pe(struct pci_dev *dev, struct pnv_ioda_pe
>   	iommu_free_table(tbl, of_node_full_name(dev->dev.of_node));
>   }
>
> -static void pnv_ioda_release_vf_PE(struct pci_dev *pdev, u16 num_vfs)
> +static void pnv_ioda_release_vf_PE(struct pci_dev *pdev)
>   {
>   	struct pci_bus        *bus;
>   	struct pci_controller *hose;
>   	struct pnv_phb        *phb;
>   	struct pnv_ioda_pe    *pe, *pe_n;
>   	struct pci_dn         *pdn;
> -	u16                    vf_index;
> -	int64_t                rc;
>
>   	bus = pdev->bus;
>   	hose = pci_bus_to_host(bus);
> @@ -1320,35 +1323,6 @@ static void pnv_ioda_release_vf_PE(struct pci_dev *pdev, u16 num_vfs)
>   	if (!pdev->is_physfn)
>   		return;
>
> -	if (pdn->m64_per_iov == M64_PER_IOV && num_vfs > M64_PER_IOV) {
> -		int   vf_group;
> -		int   vf_per_group;
> -		int   vf_index1;
> -
> -		vf_per_group = roundup_pow_of_two(num_vfs) / pdn->m64_per_iov;
> -
> -		for (vf_group = 0; vf_group < M64_PER_IOV; vf_group++)
> -			for (vf_index = vf_group * vf_per_group;
> -				vf_index < (vf_group + 1) * vf_per_group &&
> -				vf_index < num_vfs;
> -				vf_index++)
> -				for (vf_index1 = vf_group * vf_per_group;
> -					vf_index1 < (vf_group + 1) * vf_per_group &&
> -					vf_index1 < num_vfs;
> -					vf_index1++){
> -
> -					rc = opal_pci_set_peltv(phb->opal_id,
> -						pdn->offset + vf_index,
> -						pdn->offset + vf_index1,
> -						OPAL_REMOVE_PE_FROM_DOMAIN);
> -
> -					if (rc)
> -					    dev_warn(&pdev->dev, "%s: Failed to unlink same group PE#%d(%lld)\n",
> -						__func__,
> -						pdn->offset + vf_index1, rc);
> -				}
> -	}
> -
>   	list_for_each_entry_safe(pe, pe_n, &phb->ioda.pe_list, list) {
>   		if (pe->parent_dev != pdev)
>   			continue;
> @@ -1383,14 +1357,14 @@ void pnv_pci_sriov_disable(struct pci_dev *pdev)
>   	num_vfs = pdn->num_vfs;
>
>   	/* Release VF PEs */
> -	pnv_ioda_release_vf_PE(pdev, num_vfs);
> +	pnv_ioda_release_vf_PE(pdev);
>
>   	if (phb->type == PNV_PHB_IODA2) {
> -		if (pdn->m64_per_iov == 1)
> +		if (!pdn->m64_single_mode)
>   			pnv_pci_vf_resource_shift(pdev, -pdn->offset);
>
>   		/* Release M64 windows */
> -		pnv_pci_vf_release_m64(pdev);
> +		pnv_pci_vf_release_m64(pdev, num_vfs);
>
>   		/* Release PE numbers */
>   		bitmap_clear(phb->ioda.pe_alloc, pdn->offset, num_vfs);
> @@ -1409,7 +1383,6 @@ static void pnv_ioda_setup_vf_PE(struct pci_dev *pdev, u16 num_vfs)
>   	int                    pe_num;
>   	u16                    vf_index;
>   	struct pci_dn         *pdn;
> -	int64_t                rc;
>
>   	bus = pdev->bus;
>   	hose = pci_bus_to_host(bus);
> @@ -1454,37 +1427,6 @@ static void pnv_ioda_setup_vf_PE(struct pci_dev *pdev, u16 num_vfs)
>
>   		pnv_pci_ioda2_setup_dma_pe(phb, pe);
>   	}
> -
> -	if (pdn->m64_per_iov == M64_PER_IOV && num_vfs > M64_PER_IOV) {
> -		int   vf_group;
> -		int   vf_per_group;
> -		int   vf_index1;
> -
> -		vf_per_group = roundup_pow_of_two(num_vfs) / pdn->m64_per_iov;
> -
> -		for (vf_group = 0; vf_group < M64_PER_IOV; vf_group++) {
> -			for (vf_index = vf_group * vf_per_group;
> -			     vf_index < (vf_group + 1) * vf_per_group &&
> -			     vf_index < num_vfs;
> -			     vf_index++) {
> -				for (vf_index1 = vf_group * vf_per_group;
> -				     vf_index1 < (vf_group + 1) * vf_per_group &&
> -				     vf_index1 < num_vfs;
> -				     vf_index1++) {
> -
> -					rc = opal_pci_set_peltv(phb->opal_id,
> -						pdn->offset + vf_index,
> -						pdn->offset + vf_index1,
> -						OPAL_ADD_PE_TO_DOMAIN);
> -
> -					if (rc)
> -					    dev_warn(&pdev->dev, "%s: Failed to link same group PE#%d(%lld)\n",
> -						__func__,
> -						pdn->offset + vf_index1, rc);
> -				}
> -			}
> -		}
> -	}
>   }
>
>   int pnv_pci_sriov_enable(struct pci_dev *pdev, u16 num_vfs)
> @@ -1507,6 +1449,18 @@ int pnv_pci_sriov_enable(struct pci_dev *pdev, u16 num_vfs)
>   			return -EBUSY;
>   		}
>
> +		/*
> +		 * On PNV_PHB_IODA2, We just have 16 M64 BARs and M64 BAR #15
> +		 * is used to cover the whole system, which leaves only 15 M64
> +		 * BAR usable for VFs.
> +		 * When M64 BAR functions in Single PE mode, this means it
> +		 * just could enable 15 VFs.
> +		 */
> +		if (pdn->m64_single_mode && num_vfs >= 16) {

Magic constant 16. Where did this 16 come from? My understanding is it 
could come from

1) hostboot or
2) OPAL or
3) architected on IODA2
4) defined in PHB3 (actually it has to be 2))

which one is it? If 1) and 2) - make it a variable; if 3) - add a macro for it.


> +			dev_info(&pdev->dev, "Not enough M64 BAR for VFs\n");
> +			return -EBUSY;
> +		}
> +
>   		/* Calculate available PE for required VFs */
>   		mutex_lock(&phb->ioda.pe_alloc_mutex);
>   		pdn->offset = bitmap_find_next_zero_area(
> @@ -1534,7 +1488,7 @@ int pnv_pci_sriov_enable(struct pci_dev *pdev, u16 num_vfs)
>   		 * the IOV BAR according to the PE# allocated to the VFs.
>   		 * Otherwise, the PE# for the VF will conflict with others.
>   		 */
> -		if (pdn->m64_per_iov == 1) {
> +		if (!pdn->m64_single_mode) {
>   			ret = pnv_pci_vf_resource_shift(pdev, pdn->offset);
>   			if (ret)
>   				goto m64_failed;
> @@ -1567,8 +1521,7 @@ int pcibios_sriov_enable(struct pci_dev *pdev, u16 num_vfs)
>   	/* Allocate PCI data */
>   	add_dev_pci_data(pdev);
>
> -	pnv_pci_sriov_enable(pdev, num_vfs);
> -	return 0;
> +	return pnv_pci_sriov_enable(pdev, num_vfs);
>   }
>   #endif /* CONFIG_PCI_IOV */
>
> @@ -2761,9 +2714,9 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
>
>   	pdn = pci_get_pdn(pdev);
>   	pdn->vfs_expanded = 0;
> +	pdn->m64_single_mode = false;
>
>   	total_vfs = pci_sriov_get_totalvfs(pdev);
> -	pdn->m64_per_iov = 1;
>   	mul = phb->ioda.total_pe;
>
>   	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
> @@ -2783,8 +2736,8 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
>   		if (size > (1 << 26)) {
>   			dev_info(&pdev->dev, "PowerNV: VF BAR%d: %pR IOV size is bigger than 64M, roundup power2\n",
>   				 i, res);
> -			pdn->m64_per_iov = M64_PER_IOV;
>   			mul = roundup_pow_of_two(total_vfs);
> +			pdn->m64_single_mode = true;
>   			break;
>   		}
>   	}
> @@ -2986,6 +2939,8 @@ static resource_size_t pnv_pci_window_alignment(struct pci_bus *bus,
>   static resource_size_t pnv_pci_iov_resource_alignment(struct pci_dev *pdev,
>   						      int resno)
>   {
> +	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
> +	struct pnv_phb *phb = hose->private_data;
>   	struct pci_dn *pdn = pci_get_pdn(pdev);
>   	resource_size_t align;
>
> @@ -2994,12 +2949,25 @@ static resource_size_t pnv_pci_iov_resource_alignment(struct pci_dev *pdev,
>   	 * SR-IOV. While from hardware perspective, the range mapped by M64
>   	 * BAR should be size aligned.
>   	 *
> +	 * When IOV BAR is mapped with M64 BAR in Single PE mode, the hardware
> +	 * restriction to alignment is gone.


Gone? Does not BAR still have to be aligned to its size?


> But if just use the VF BAR size
> +	 * as the alignment, PF BAR / VF BAR may be allocated with in one M64
> +	 * segment,


I thought each VF gets its own _segment_, am I wrong?


> which introduces the PE conflict between PF and VF. Based
> +	 * on this the minimum alignment of an IOV BAR is m64_segsize.
 >
> +	 *
>   	 * This function return the total IOV BAR size if expanded or just the
> -	 * individual size if not.
> +	 * individual size if not, when M64 BAR is in Shared PE mode.
> +	 * If the M64 BAR is in Single PE mode, return the VF BAR size or
> +	 * m64_size if IOV BAR size is less.
>   	 */
>   	align = pci_iov_resource_size(pdev, resno);
> -	if (pdn->vfs_expanded)
> -		return pdn->vfs_expanded * align;
> +	if (pdn->vfs_expanded) {
> +		if (pdn->m64_single_mode)
> +			return max(align,
> +				(resource_size_t)phb->ioda.m64_segsize);
> +		else
> +			return pdn->vfs_expanded * align;
> +	}
>
>   	return align;
>   }
>


-- 
Alexey
