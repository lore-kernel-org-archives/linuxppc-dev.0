Return-Path: <nfont@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s8c3j4YSzzDqJ5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 02:26:41 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7AGOHFI038444
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 12:26:38 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24qm9ux8u5-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 12:26:38 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Wed, 10 Aug 2016 10:26:37 -0600
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id E319C19D8041
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 10:26:06 -0600 (MDT)
Subject: Re: [PATCH V3 2/8] powerpc/memory: Parse new memory property to
 register blocks.
To: Michael Bringmann <mwb@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <adb543b0-4287-95b6-ba62-e658cb5072cb@linux.vnet.ibm.com>
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Date: Wed, 10 Aug 2016 11:26:32 -0500
MIME-Version: 1.0
In-Reply-To: <adb543b0-4287-95b6-ba62-e658cb5072cb@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <0c1c5872-45a6-7c36-f0d5-7cb6f5b0210a@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/01/2016 08:24 PM, Michael Bringmann wrote:
> powerpc/memory: Add parallel routines to parse the new property
> "ibm,dynamic-memory-v2" property when it is present, and then to
> register the relevant memory blocks with the operating system.
> This property format is intended to provide a more compact
> representation of memory when communicating with the front end
> processor, especially when describing vast amounts of RAM.
> 
> Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
> ---

It's generally a good idea to include a short description of what
changed in the patch between patch versions. This helps reviewers
avoid digging through the patch and trying to find updates.

> diff --git a/arch/powerpc/include/asm/prom.h b/arch/powerpc/include/asm/prom.h
> index 7f436ba..b9a1534 100644
> --- a/arch/powerpc/include/asm/prom.h
> +++ b/arch/powerpc/include/asm/prom.h
> @@ -69,6 +69,8 @@ struct boot_param_header {
>   * OF address retreival & translation
>   */
>  
> +extern int n_mem_addr_cells;
> +
>  /* Parse the ibm,dma-window property of an OF node into the busno, phys and
>   * size parameters.
>   */
> @@ -81,8 +83,9 @@ extern void of_instantiate_rtc(void);
>  extern int of_get_ibm_chip_id(struct device_node *np);
>  
>  /* The of_drconf_cell struct defines the layout of the LMB array
> - * specified in the device tree property
> - * ibm,dynamic-reconfiguration-memory/ibm,dynamic-memory
> + * specified in the device tree properties,
> + *     ibm,dynamic-reconfiguration-memory/ibm,dynamic-memory
> + *     ibm,dynamic-reconfiguration-memory/ibm,dynamic-memory-v2
>   */
>  struct of_drconf_cell {
>  	u64	base_addr;
> @@ -92,9 +95,32 @@ struct of_drconf_cell {
>  	u32	flags;
>  };
>  
> -#define DRCONF_MEM_ASSIGNED	0x00000008
> -#define DRCONF_MEM_AI_INVALID	0x00000040
> -#define DRCONF_MEM_RESERVED	0x00000080
> +#define DRCONF_MEM_ASSIGNED		0x00000008
> +#define DRCONF_MEM_AI_INVALID		0x00000040
> +#define DRCONF_MEM_RESERVED		0x00000080
> +
> +struct of_drconf_cell_v2 {
> +	u32	num_seq_lmbs;
> +	u64	base_addr;
> +	u32	drc_index;
> +	u32	aa_index;
> +	u32	flags;
> +} __attribute__((packed));
> +
> +
> +static inline int dyn_mem_v2_len(int entries)
> +{
> +	int drconf_v2_cells = (n_mem_addr_cells + 4);
> +	int drconf_v2_cells_len = (drconf_v2_cells * sizeof(unsigned int));
> +	return (((entries) * drconf_v2_cells_len) +
> +                (1 * sizeof(unsigned int)));
> +}
> +
> +extern void read_drconf_cell_v2(struct of_drconf_cell_v2 *drmem,
> +				const __be32 **cellp);
> +extern void read_one_drc_info(int **info, char **drc_type, char **drc_name,
> +			unsigned long int *fdi_p, unsigned long int *nsl_p,
> +			unsigned long int *si_p, unsigned long int *ldi_p);
>  

These two functions, read_drconf_cell_v2 and read_one_drc_info, are defined
in this patch but are not used. I think it makes more sense to introduce
new functionality in the patch that uses that functionality.

>  /*
>   * There are two methods for telling firmware what our capabilities are.
> diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
> index 669a15e..ad294ce 100644
> --- a/arch/powerpc/mm/numa.c
> +++ b/arch/powerpc/mm/numa.c
> @@ -57,8 +57,10 @@
>  EXPORT_SYMBOL(node_data);
>  
>  static int min_common_depth;
> -static int n_mem_addr_cells, n_mem_size_cells;
> +int n_mem_addr_cells;
> +static int n_mem_size_cells;
>  static int form1_affinity;
> +EXPORT_SYMBOL(n_mem_addr_cells);
>  
>  #define MAX_DISTANCE_REF_POINTS 4
>  static int distance_ref_points_depth;
> @@ -405,6 +405,24 @@ static void read_drconf_cell(struct of_drconf_cell *drmem, const __be32 **cellp)
>  
>  	*cellp = cp + 4;
>  }
> + 
> + /*
> + * Retrieve and validate the ibm,dynamic-memory property of the device tree.
> + * Read the next memory block set entry from the ibm,dynamic-memory-v2 property
> + * and return the information in the provided of_drconf_cell_v2 structure.
> + */
> +void read_drconf_cell_v2(struct of_drconf_cell_v2 *drmem, const __be32 **cellp)
> +{
> +	const __be32 *cp = (const __be32 *)*cellp;
> +	drmem->num_seq_lmbs = be32_to_cpu(*cp++);
> +	drmem->base_addr = read_n_cells(n_mem_addr_cells, &cp);
> +	drmem->drc_index = be32_to_cpu(*cp++);
> +	drmem->aa_index = be32_to_cpu(*cp++);
> +	drmem->flags = be32_to_cpu(*cp++);
> +
> +	*cellp = cp;
> +}
> +EXPORT_SYMBOL(read_drconf_cell_v2);
>  
>  /*
>   * Retrieve and validate the ibm,dynamic-memory property of the device tree.
> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
> index 946e34f..b6f8ae5 100644
> --- a/arch/powerpc/kernel/prom.c
> +++ b/arch/powerpc/kernel/prom.c
> @@ -441,12 +442,12 @@ static int __init early_init_dt_scan_chosen_ppc(unsigned long node,
>  
>  #ifdef CONFIG_PPC_PSERIES
>  /*
> - * Interpret the ibm,dynamic-memory property in the
> - * /ibm,dynamic-reconfiguration-memory node.
> + * Interpret the ibm,dynamic-memory property/ibm,dynamic-memory-v2
> + * in the /ibm,dynamic-reconfiguration-memory node.
>   * This contains a list of memory blocks along with NUMA affinity
>   * information.
>   */
> -static int __init early_init_dt_scan_drconf_memory(unsigned long node)
> +static int __init early_init_dt_scan_drconf_memory_v1(unsigned long node)
>  {
>  	const __be32 *dm, *ls, *usm;
>  	int l;
> @@ -516,6 +517,73 @@ static int __init early_init_dt_scan_drconf_memory(unsigned long node)
>  	memblock_dump_all();
>  	return 0;
>  }
> +
> +static int __init early_init_dt_scan_drconf_memory_v2(unsigned long node)
> +{
> +	const __be32 *dm, *ls;
> +	int l;
> +	unsigned long num_sets;
> +	u64 size, base, memblock_size;
> +
> +	ls = of_get_flat_dt_prop(node, "ibm,lmb-size", &l);
> +	if (ls == NULL || l < dt_root_size_cells * sizeof(__be32))
> +		return 0;
> +	memblock_size = dt_mem_next_cell(dt_root_size_cells, &ls);

We do the same thing in early_init_dt_scan_drconf_memory_v1 to retrieve
the memblock_size, perhaps it makes sense to break this out into a
helper routine.

> +
> +	dm = of_get_flat_dt_prop(node, "ibm,dynamic-memory-v2", &l);
> +	if (dm == NULL || l < sizeof(__be32))
> +		return 0;
> +
> +	num_sets = of_read_number(dm++, 1);
> +	if (l < (num_sets * (dt_root_addr_cells + 4) + 1) * sizeof(__be32))

Perhaps a comment here to help understand the calculation without having
to look up the format of the dynamic-mnemory-v2 device tree format.

-Nathan

> +		return 0;
> +
> +	if (n_mem_addr_cells == 0)
> +		n_mem_addr_cells = dt_root_addr_cells;
> +
> +	for (; num_sets != 0; --num_sets) {
> +		struct of_drconf_cell_v2 drmem;
> +		unsigned long nsl;
> +
> +		read_drconf_cell_v2(&drmem, &dm);
> +		base = drmem.base_addr;
> +		nsl = drmem.num_seq_lmbs;
> +		size = memblock_size;
> +
> +		/* SKip this block if the reserved bit is set in flags
> +		 * or if the block is not assigned to this partition
> +		 */
> +		if ((drmem.flags & DRCONF_MEM_RESERVED) ||
> +		    !(drmem.flags & DRCONF_MEM_ASSIGNED))
> +			continue;
> +
> +		for (; nsl != 0; nsl--) {
> +			size = memblock_size;
> +
> +			if (iommu_is_off) {
> +				if (base >= 0x80000000ul)
> +					continue;
> +				if ((base + size) > 0x80000000ul)
> +					size = 0x80000000ul - base;
> +			}
> +			memblock_add(base, size);
> +
> +			base += size;
> +		}
> +	}
> +
> +	memblock_dump_all();
> +	return 0;
> +}
> +
> +static int __init early_init_dt_scan_drconf_memory(unsigned long node)
> +{
> +	if (firmware_has_feature(FW_FEATURE_DYN_MEM_V2))

Will this check still work?

I believe the goal is to convert the dynamic-memory-v2 property
back to the current dynamic-memory property update and manage memory
with that. This allows us to not have to worry about kexec during
parse of the -v2 property. On a kexec boot though, will this test for
FW_FEATURE_DYN_MEM_V2 succeed even though we would have a -v1
version of the property. Perhaps the test should be for the
existence of the -v2 property.

-Nathan

> +		return early_init_dt_scan_drconf_memory_v2(node);
> +	else
> +		return early_init_dt_scan_drconf_memory_v1(node);
> +}
> +
>  #else
>  #define early_init_dt_scan_drconf_memory(node)	0
>  #endif /* CONFIG_PPC_PSERIES */
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
