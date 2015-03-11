Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-f42.google.com (mail-pa0-f42.google.com
 [209.85.220.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B6E3B1A0631
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2015 19:54:30 +1100 (AEDT)
Received: by padfb1 with SMTP id fb1so9724993pad.7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2015 01:54:28 -0700 (PDT)
Message-ID: <550002BC.6040601@ozlabs.ru>
Date: Wed, 11 Mar 2015 19:54:20 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v5 25/29] powerpc/powernv/ioda: Define and implement DMA
 table/window management callbacks
References: <1425910045-26167-1-git-send-email-aik@ozlabs.ru>
 <1425910045-26167-26-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1425910045-26167-26-git-send-email-aik@ozlabs.ru>
Content-Type: text/plain; charset=koi8-r; format=flowed
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/10/2015 01:07 AM, Alexey Kardashevskiy wrote:
> This extends iommu_table_group_ops by a set of callbacks to support dynamic
> DMA windows management.
>
> query() returns IOMMU capabilities such as default DMA window address and
> supported number of DMA windows and TCE table levels.
>
> create_table() creates a TCE table with specific parameters.
> it receives iommu_table_group to know nodeid in order to allocate TCE table
> memory closer to the PHB. The exact format of allocated multi-level table
> might be also specific to the PHB model (not the case now though).
> This callback puts the DMA window offset on a PCI bus into just created table.
>
> set_window() sets the window at specified TVT index on PHB.
>
> unset_window() unsets the window from specified TVT.
>
> This adds a free() callback to iommu_table_ops to free the memory
> (potentially a tree of tables) allocated for the TCE table.
>
> create_table() and free() are supposed to be called once per VFIO container
> and set_window()/unset_window() are supposed to be called for every group
> in a container.
>
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>   arch/powerpc/include/asm/iommu.h            | 32 +++++++++++
>   arch/powerpc/platforms/powernv/pci-ioda.c   | 87 ++++++++++++++++++++++++-----
>   arch/powerpc/platforms/powernv/pci-p5ioc2.c | 14 ++++-
>   3 files changed, 115 insertions(+), 18 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
> index 4007432..04f72ac 100644
> --- a/arch/powerpc/include/asm/iommu.h
> +++ b/arch/powerpc/include/asm/iommu.h
> @@ -62,6 +62,8 @@ struct iommu_table_ops {
>   			long index, long npages);
>   	unsigned long (*get)(struct iommu_table *tbl, long index);
>   	void (*flush)(struct iommu_table *tbl);
> +
> +	void (*free)(struct iommu_table *tbl);
>   };
>
>   /* These are used by VIO */
> @@ -148,12 +150,42 @@ struct iommu_table_group_ops {
>   	 */
>   	void (*set_ownership)(struct iommu_table_group *table_group,
>   			bool enable);
> +
> +	long (*create_table)(struct iommu_table_group *table_group,
> +			int num,
> +			__u32 page_shift,
> +			__u64 window_size,
> +			__u32 levels,
> +			struct iommu_table *tbl);
> +	long (*set_window)(struct iommu_table_group *table_group,
> +			int num,
> +			struct iommu_table *tblnew);
> +	long (*unset_window)(struct iommu_table_group *table_group,
> +			int num);
>   };
>
> +/* Page size flags for ibm,query-pe-dma-window */
> +#define DDW_PGSIZE_4K           0x01
> +#define DDW_PGSIZE_64K          0x02
> +#define DDW_PGSIZE_16M          0x04
> +#define DDW_PGSIZE_32M          0x08
> +#define DDW_PGSIZE_64M          0x10
> +#define DDW_PGSIZE_128M         0x20
> +#define DDW_PGSIZE_256M         0x40
> +#define DDW_PGSIZE_16G          0x80
> +#define DDW_PGSIZE_MASK         0xFF
> +
>   struct iommu_table_group {
>   #ifdef CONFIG_IOMMU_API
>   	struct iommu_group *group;
>   #endif
> +	/* Some key properties of IOMMU */
> +	__u32 tce32_start;
> +	__u32 tce32_size;
> +	__u32 max_dynamic_windows_supported;
> +	__u32 max_levels;
> +	__u32 flags;

Just realized that due to their static nature, they are better to be in 
iommu_table_group_ops, will fix it in v6.



> +
>   	struct iommu_table tables[IOMMU_TABLE_GROUP_MAX_TABLES];
>   	struct iommu_table_group_ops *ops;
>   };
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index ed60b38..07857c4 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -48,6 +48,7 @@
>   #include "pci.h"
>
>   #define POWERNV_IOMMU_DEFAULT_LEVELS	1
> +#define POWERNV_IOMMU_MAX_LEVELS	5
>
>   extern void ioda_eeh_tvt_print(struct pnv_phb *phb);
>
> @@ -1155,11 +1156,14 @@ static void pnv_ioda1_tce_free_vm(struct iommu_table *tbl, long index,
>   		pnv_pci_ioda1_tce_invalidate(tbl, index, npages, false);
>   }
>
> +static void pnv_pci_free_table(struct iommu_table *tbl);
> +
>   struct iommu_table_ops pnv_ioda1_iommu_ops = {
>   	.set = pnv_ioda1_tce_build_vm,
>   	.exchange = pnv_ioda1_tce_xchg_vm,
>   	.clear = pnv_ioda1_tce_free_vm,
>   	.get = pnv_tce_get,
> +	.free = pnv_pci_free_table
>   };
>
>   static void pnv_pci_ioda2_tce_invalidate(struct iommu_table *tbl,
> @@ -1317,6 +1321,11 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
>   				 TCE_PCI_SWINV_PAIR);
>   	}
>   	tbl->it_ops = &pnv_ioda1_iommu_ops;
> +	pe->table_group.tce32_start = tbl->it_offset << tbl->it_page_shift;
> +	pe->table_group.tce32_size = tbl->it_size << tbl->it_page_shift;
> +	pe->table_group.max_dynamic_windows_supported = 0;
> +	pe->table_group.max_levels = 0;
> +	pe->table_group.flags = 0;
>   	iommu_init_table(tbl, phb->hose->node);
>   	iommu_register_group(&pe->table_group, phb->hose->global_number,
>   			pe->pe_number);
> @@ -1401,7 +1410,7 @@ static __be64 *pnv_alloc_tce_table(int nid,
>   }
>
>   static long pnv_pci_ioda2_create_table(struct iommu_table_group *table_group,
> -		__u32 page_shift, __u64 window_size, __u32 levels,
> +		int num, __u32 page_shift, __u64 window_size, __u32 levels,
>   		struct iommu_table *tbl)
>   {
>   	struct pnv_ioda_pe *pe = container_of(table_group, struct pnv_ioda_pe,
> @@ -1428,8 +1437,8 @@ static long pnv_pci_ioda2_create_table(struct iommu_table_group *table_group,
>   	shift = ROUND_UP(ilog2(window_size) - page_shift, levels) / levels;
>   	shift += 3;
>   	shift = max_t(unsigned, shift, IOMMU_PAGE_SHIFT_4K);
> -	pr_info("Creating TCE table %08llx, %d levels, TCE table size = %lx\n",
> -			window_size, levels, 1UL << shift);
> +	pr_info("Creating TCE table #%d %08llx, %d levels, TCE table size = %lx\n",
> +			num, window_size, levels, 1UL << shift);
>
>   	tbl->it_level_size = 1ULL << (shift - 3);
>   	left = tce_table_size;
> @@ -1440,11 +1449,10 @@ static long pnv_pci_ioda2_create_table(struct iommu_table_group *table_group,
>   	tbl->it_indirect_levels = levels - 1;
>
>   	/* Setup linux iommu table */
> -	pnv_pci_setup_iommu_table(tbl, addr, tce_table_size, 0,
> -			page_shift);
> +	pnv_pci_setup_iommu_table(tbl, addr, tce_table_size,
> +			num ? pe->tce_bypass_base : 0, page_shift);
>
>   	tbl->it_ops = &pnv_ioda2_iommu_ops;
> -	iommu_init_table(tbl, nid);
>
>   	return 0;
>   }
> @@ -1461,8 +1469,21 @@ static void pnv_pci_free_table(struct iommu_table *tbl)
>   	iommu_reset_table(tbl, "ioda2");
>   }
>
> +static inline void pnv_pci_ioda2_tvt_invalidate(unsigned int pe_number,
> +		unsigned long it_index)
> +{
> +	__be64 __iomem *invalidate = (__be64 __iomem *)it_index;
> +	/* 01xb - invalidate TCEs that match the specified PE# */
> +	unsigned long addr = (0x4ull << 60) | (pe_number & 0xFF);
> +
> +	if (!it_index)
> +		return;
> +
> +	__raw_writeq(cpu_to_be64(addr), invalidate);
> +}
> +
>   static long pnv_pci_ioda2_set_window(struct iommu_table_group *table_group,
> -		struct iommu_table *tbl)
> +		int num, struct iommu_table *tbl)
>   {
>   	struct pnv_ioda_pe *pe = container_of(table_group, struct pnv_ioda_pe,
>   			table_group);
> @@ -1474,13 +1495,13 @@ static long pnv_pci_ioda2_set_window(struct iommu_table_group *table_group,
>   	const __u64 start_addr = tbl->it_offset << tbl->it_page_shift;
>   	const __u64 win_size = tbl->it_size << tbl->it_page_shift;
>
> -	pe_info(pe, "Setting up window at %llx..%llx pagesize=0x%x tablesize=0x%lx levels=%d levelsize=%x\n",
> -			start_addr, start_addr + win_size - 1,
> +	pe_info(pe, "Setting up window #%d (%p) at %llx..%llx pagesize=0x%x tablesize=0x%lx levels=%d levelsize=%x\n",
> +			num, tbl, start_addr, start_addr + win_size - 1,
>   			1UL << tbl->it_page_shift, tbl->it_size,
>   			tbl->it_indirect_levels + 1, tbl->it_level_size);
>
> -	pe->table_group.tables[0] = *tbl;
> -	tbl = &pe->table_group.tables[0];
> +	pe->table_group.tables[num] = *tbl;
> +	tbl = &pe->table_group.tables[num];
>   	tbl->it_group = &pe->table_group;
>
>   	/*
> @@ -1488,7 +1509,8 @@ static long pnv_pci_ioda2_set_window(struct iommu_table_group *table_group,
>   	 * shifted by 1 bit for 32-bits DMA space.
>   	 */
>   	rc = opal_pci_map_pe_dma_window(phb->opal_id, pe->pe_number,
> -			pe->pe_number << 1, tbl->it_indirect_levels + 1,
> +			(pe->pe_number << 1) + num,
> +			tbl->it_indirect_levels + 1,
>   			__pa(tbl->it_base),
>   			size << 3, 1ULL << tbl->it_page_shift);
>   	if (rc) {
> @@ -1510,6 +1532,8 @@ static long pnv_pci_ioda2_set_window(struct iommu_table_group *table_group,
>   		tbl->it_type |= (TCE_PCI_SWINV_CREATE | TCE_PCI_SWINV_FREE);
>   	}
>
> +	pnv_pci_ioda2_tvt_invalidate(pe->pe_number, tbl->it_index);
> +
>   	return 0;
>   fail:
>   	if (pe->tce32_seg >= 0)
> @@ -1518,6 +1542,29 @@ fail:
>   	return rc;
>   }
>
> +static long pnv_pci_ioda2_unset_window(struct iommu_table_group *table_group,
> +		int num)
> +{
> +	struct pnv_ioda_pe *pe = container_of(table_group, struct pnv_ioda_pe,
> +			table_group);
> +	struct pnv_phb *phb = pe->phb;
> +	long ret;
> +
> +	pe_info(pe, "Removing DMA window #%d\n", num);
> +
> +	ret = opal_pci_map_pe_dma_window(phb->opal_id, pe->pe_number,
> +			(pe->pe_number << 1) + num,
> +			0/* levels */, 0/* table address */,
> +			0/* table size */, 0/* page size */);
> +	if (ret)
> +		pe_warn(pe, "Unmapping failed, ret = %ld\n", ret);
> +
> +	pnv_pci_ioda2_tvt_invalidate(pe->pe_number,
> +			table_group->tables[num].it_index);
> +
> +	return ret;
> +}
> +
>   static void pnv_pci_ioda2_set_bypass(struct pnv_ioda_pe *pe, bool enable)
>   {
>   	uint16_t window_id = (pe->pe_number << 1 ) + 1;
> @@ -1583,6 +1630,9 @@ static void pnv_ioda2_set_ownership(struct iommu_table_group *table_group,
>
>   static struct iommu_table_group_ops pnv_pci_ioda2_ops = {
>   	.set_ownership = pnv_ioda2_set_ownership,
> +	.create_table = pnv_pci_ioda2_create_table,
> +	.set_window = pnv_pci_ioda2_set_window,
> +	.unset_window = pnv_pci_ioda2_unset_window,
>   };
>
>   static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
> @@ -1602,8 +1652,8 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
>   	pe_info(pe, "Setting up 32-bit TCE table at 0..%08x\n",
>   		end);
>
> -	rc = pnv_pci_ioda2_create_table(&pe->table_group, IOMMU_PAGE_SHIFT_4K,
> -			phb->ioda.m32_pci_base,
> +	rc = pnv_pci_ioda2_create_table(&pe->table_group, 0,
> +			IOMMU_PAGE_SHIFT_4K, phb->ioda.m32_pci_base,
>   			POWERNV_IOMMU_DEFAULT_LEVELS, tbl);
>   	if (rc) {
>   		pe_err(pe, "Failed to create 32-bit TCE table, err %ld", rc);
> @@ -1611,10 +1661,17 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
>   	}
>
>   	/* Setup iommu */
> +	pe->table_group.tce32_start = 0;
> +	pe->table_group.tce32_size = phb->ioda.m32_pci_base;
> +	pe->table_group.max_dynamic_windows_supported =
> +			IOMMU_TABLE_GROUP_MAX_TABLES;
> +	pe->table_group.max_levels = POWERNV_IOMMU_MAX_LEVELS;
> +	pe->table_group.flags = DDW_PGSIZE_4K | DDW_PGSIZE_64K | DDW_PGSIZE_16M;
> +	iommu_init_table(tbl, pe->phb->hose->node);
>   	pe->table_group.tables[0].it_group = &pe->table_group;
>   	pe->table_group.ops = &pnv_pci_ioda2_ops;
>
> -	rc = pnv_pci_ioda2_set_window(&pe->table_group, tbl);
> +	rc = pnv_pci_ioda2_set_window(&pe->table_group, 0, tbl);
>   	if (rc) {
>   		pe_err(pe, "Failed to configure 32-bit TCE table,"
>   		       " err %ld\n", rc);
> diff --git a/arch/powerpc/platforms/powernv/pci-p5ioc2.c b/arch/powerpc/platforms/powernv/pci-p5ioc2.c
> index 5888b2c..ad65d45 100644
> --- a/arch/powerpc/platforms/powernv/pci-p5ioc2.c
> +++ b/arch/powerpc/platforms/powernv/pci-p5ioc2.c
> @@ -114,6 +114,8 @@ static void __init pnv_pci_init_p5ioc2_phb(struct device_node *np, u64 hub_id,
>   	u64 phb_id;
>   	int64_t rc;
>   	static int primary = 1;
> +	struct iommu_table_group *table_group;
> +	struct iommu_table *tbl;
>
>   	pr_info(" Initializing p5ioc2 PHB %s\n", np->full_name);
>
> @@ -178,13 +180,19 @@ static void __init pnv_pci_init_p5ioc2_phb(struct device_node *np, u64 hub_id,
>   	pnv_pci_init_p5ioc2_msis(phb);
>
>   	/* Setup iommu */
> -	phb->p5ioc2.table_group.tables[0].it_group = &phb->p5ioc2.table_group;
> +	table_group = &phb->p5ioc2.table_group;
> +	tbl = &phb->p5ioc2.table_group.tables[0];
> +	tbl->it_group = table_group;
>
>   	/* Setup TCEs */
>   	phb->dma_dev_setup = pnv_pci_p5ioc2_dma_dev_setup;
> -	pnv_pci_setup_iommu_table(&phb->p5ioc2.table_group.tables[0],
> -				  tce_mem, tce_size, 0,
> +	pnv_pci_setup_iommu_table(tbl, tce_mem, tce_size, 0,
>   				  IOMMU_PAGE_SHIFT_4K);
> +	table_group->tce32_start = tbl->it_offset << tbl->it_page_shift;
> +	table_group->tce32_size = tbl->it_size << tbl->it_page_shift;
> +	table_group->max_dynamic_windows_supported = 0;
> +	table_group->max_levels = 0;
> +	table_group->flags = 0;
>   }
>
>   void __init pnv_pci_init_p5ioc2_hub(struct device_node *np)
>


-- 
Alexey
