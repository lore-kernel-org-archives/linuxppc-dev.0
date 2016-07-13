Return-Path: <nfont@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rqW3K2Y5PzDqFP
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 06:42:05 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6DKdQm6087756
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 16:42:02 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0b-001b2d01.pphosted.com with ESMTP id 245jp9ydc5-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 16:42:02 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Wed, 13 Jul 2016 14:42:00 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id A83501FF0046
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 14:41:41 -0600 (MDT)
Subject: Re: [PATCH] linuxppc/devtree: Parse new DRC mem/cpu/dev device tree
 elements
To: Michael Bringmann <mwb@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <31f35f7c-3129-6bcc-1a0f-37e78aaa2e61@linux.vnet.ibm.com>
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Date: Wed, 13 Jul 2016 15:41:55 -0500
MIME-Version: 1.0
In-Reply-To: <31f35f7c-3129-6bcc-1a0f-37e78aaa2e61@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <5786A793.2000504@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/30/2016 04:44 PM, Michael Bringmann wrote:
> Several properties in the DRC device tree format are replaced by
> more compact representations to allow, for example, for the encoding
> of vast amounts of memory, and or reduced duplication of information
> in related data structures.
> 
> "ibm,drc-info": This property, when present, replaces the following
> four properties: "ibm,drc-indexes", "ibm,drc-names", "ibm,drc-types"
> and "ibm,drc-power-domains".  This property is defined for all
> dynamically reconfigurable platform nodes.  The "ibm,drc-info" elements
> are intended to provide a more compact representation, and reduce some
> search overhead.
> 
> "ibm,dynamic-memory-v2": This property replaces the "ibm,dynamic-memory"
> node representation within the "ibm,dynamic-reconfiguration-memory"
> property provided by the BMC.  This element format is intended to provide

BMC?

> a more compact representation of memory, especially, for systems with
> massive amounts of RAM.  To simplify portability, this property is
> converted to the "ibm,dynamic-memory" property during system boot.
> 
> "ibm,architecture.vec": Bit flags are added to this data structure
> by the front end processor to inform the kernel as to whether to expect
> the changes to one or both of the device tree structures "ibm,drc-info"
> and "ibm,dynamic-memory-v2".

The architecture vector is more a statement of what the kernel supports,
it does not imply that we will be getting these new properties because
the bits are set. For example, a newer kernel on older firmware that
does not support these properties will not see them.

A thought, this is a big patch. Perhaps it should be split into multiple
patches; setting the arch bit, prom updates, numa updates, hotplug
updates...

> 
> Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
> ---
> diff --git a/arch/powerpc/include/asm/firmware.h b/arch/powerpc/include/asm/firmware.h
> index b062924..a9d66d5 100644
> --- a/arch/powerpc/include/asm/firmware.h
> +++ b/arch/powerpc/include/asm/firmware.h
> @@ -51,6 +51,8 @@
>  #define FW_FEATURE_BEST_ENERGY	ASM_CONST(0x0000000080000000)
>  #define FW_FEATURE_TYPE1_AFFINITY ASM_CONST(0x0000000100000000)
>  #define FW_FEATURE_PRRN		ASM_CONST(0x0000000200000000)
> +#define FW_FEATURE_RPS_DM2	ASM_CONST(0x0000000400000000)
> +#define FW_FEATURE_RPS_DRC_INFO	ASM_CONST(0x0000000800000000)

I think something more than DM2 would provide a better description of what
the feature is. Also, what is RPS?

>  
>  #ifndef __ASSEMBLY__
>  
> @@ -66,7 +68,8 @@ enum {
>  		FW_FEATURE_MULTITCE | FW_FEATURE_SPLPAR | FW_FEATURE_LPAR |
>  		FW_FEATURE_CMO | FW_FEATURE_VPHN | FW_FEATURE_XCMO |
>  		FW_FEATURE_SET_MODE | FW_FEATURE_BEST_ENERGY |
> -		FW_FEATURE_TYPE1_AFFINITY | FW_FEATURE_PRRN,
> +		FW_FEATURE_TYPE1_AFFINITY | FW_FEATURE_PRRN |
> +		FW_FEATURE_RPS_DM2 | FW_FEATURE_RPS_DRC_INFO,
>  	FW_FEATURE_PSERIES_ALWAYS = 0,
>  	FW_FEATURE_POWERNV_POSSIBLE = FW_FEATURE_OPAL,
>  	FW_FEATURE_POWERNV_ALWAYS = 0,
> diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
> index 9d86c66..e4c5076 100644
> --- a/arch/powerpc/include/asm/opal.h
> +++ b/arch/powerpc/include/asm/opal.h
> @@ -215,6 +215,8 @@ extern int early_init_dt_scan_opal(unsigned long node, const char *uname,
>  				   int depth, void *data);
>  extern int early_init_dt_scan_recoverable_ranges(unsigned long node,
>  				 const char *uname, int depth, void *data);
> +extern int pseries_probe_fw_features(unsigned long node,
> +				 const char *uname, int depth, void *data);
>  
>  extern int opal_get_chars(uint32_t vtermno, char *buf, int count);
>  extern int opal_put_chars(uint32_t vtermno, const char *buf, int total_len);
> diff --git a/arch/powerpc/include/asm/prom.h b/arch/powerpc/include/asm/prom.h
> index 7f436ba..99ef058 100644
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
> @@ -92,9 +95,59 @@ struct of_drconf_cell {
>  	u32	flags;
>  };
>  
> -#define DRCONF_MEM_ASSIGNED	0x00000008
> -#define DRCONF_MEM_AI_INVALID	0x00000040
> -#define DRCONF_MEM_RESERVED	0x00000080
> +	/* It is important to note that this structure can not
> +	 * be safely mapped onto the memory containing the
> +	 * 'ibm,dynamic-memory-v2' property due to the issues
> +	 * of compiler alignment.  This structure represents
> +	 * the order of the fields stored, but compiler alignment
> +	 * may insert extra bytes of padding between the fields
> +	 * 'num_seq_lmbs' and 'base_addr'.
> +	 */
> +struct of_drconf_cell_v2 {
> +	u32	num_seq_lmbs;
> +	u64	base_addr;
> +	u32	drc_index;
> +	u32	aa_index;
> +	u32	flags;
> +};
> +
> +#define	DRCONF_V2_CELLS			(n_mem_addr_cells + 4)
> +#define	DRCONF_V2_CELLS_LEN		(DRCONF_V2_CELLS * sizeof(unsigned int))
> +#define	DRCONF_V2_CELL_OFFSET(i)	((i) * DRCONF_V2_CELLS_LEN)
> +#define	DRCONF_V2_CELL_POSITION(p, i)	\
> +			(void *)(((char *)(p))+((i) * DRCONF_V2_CELLS_LEN))
> +#define DYN_MEM_V2_LEN(entries)	(((entries) * DRCONF_V2_CELLS_LEN) + \
> +				 (1 * sizeof(unsigned int)))
> +

These should probably be functions instead of #defines, makes debugging
the code easier.

> +#define DRCONF_MEM_PRESERVED		0x00000001
> +#define DRCONF_MEM_PRESERVABLE		0x00000002
> +#define DRCONF_MEM_PRESERVED_STATE	0x00000004
> +#define DRCONF_MEM_ASSIGNED		0x00000008
> +#define DRCONF_MEM_NO_H_MIGRATE_DATA	0x00000010
> +#define DRCONF_MEM_DRC_INVALID		0x00000020
> +#define DRCONF_MEM_AI_INVALID		0x00000040
> +#define DRCONF_MEM_RESERVED		0x00000080
> +#define DRCONF_MEM_RESERVED_SW		0x80000000

I'll let others chime in, but we don't use all of these flags, or plan
to at this point so I'm not sure we need to include definitions for them.

> +
> +extern void read_drconf_cell_v2(struct of_drconf_cell_v2 *drmem,
> +				const __be32 **cellp);
> +extern void read_one_drc_info(int **info, char **drc_type, char **drc_name,
> +			unsigned long int *fdi_p, unsigned long int *nsl_p,
> +			unsigned long int *si_p, unsigned long int *ldi_p);
> +
> +
> +/*
> + * Set of dynamic DLPAR memory function operations
> + */
> +struct dlpar_memory_ops {
> +	struct property* (*clone_drconf_property)(struct device_node *dn);
> +	int (*add_by_count)(u32 lmbs_to_add, struct property **prop);
> +	int (*add_by_index)(u32 lmbs_to_add, struct property **prop);
> +	int (*remove_by_count)(u32 lmbs_to_add, struct property **prop);
> +	int (*remove_by_index)(u32 lmbs_to_add, struct property **prop);
> +	void (*update_drconf_property)(struct device_node *dn,
> +					struct property *prop);
> +};
>  
>  /*
>   * There are two methods for telling firmware what our capabilities are.
> @@ -155,6 +208,8 @@ struct of_drconf_cell {
>  #define OV5_PFO_HW_842		0x0E40	/* PFO Compression Accelerator */
>  #define OV5_PFO_HW_ENCR		0x0E20	/* PFO Encryption Accelerator */
>  #define OV5_SUB_PROCESSORS	0x0F01	/* 1,2,or 4 Sub-Processors supported */
> +#define OV5_RPS_DM2		0x1680	/* Redef Prop Structures: dyn-mem-v2 */
> +#define OV5_RPS_DRC_INFO	0x1640	/* Redef Prop Structures: drc-info   */
>  
>  /* Option Vector 6: IBM PAPR hints */
>  #define OV6_LINUX		0x02	/* Linux is our OS */
> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
> index 946e34f..f4713ee 100644
> --- a/arch/powerpc/kernel/prom.c
> +++ b/arch/powerpc/kernel/prom.c
> @@ -56,6 +56,7 @@
>  #include <asm/opal.h>
>  #include <asm/fadump.h>
>  #include <asm/debug.h>
> +#include <asm/firmware.h>
>  
>  #include <mm/mmu_decl.h>
>  
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
> @@ -516,6 +517,91 @@ static int __init early_init_dt_scan_drconf_memory(unsigned long node)
>  	memblock_dump_all();
>  	return 0;
>  }
> +
> +static int __init early_init_dt_scan_drconf_memory_v2(unsigned long node)
> +{
> +	const __be32 *dm, *ls, *usm;
> +	int l;
> +	unsigned long num_sets;
> +	u64 size, base, memblock_size;
> +	unsigned int is_kexec_kdump = 0, rngs;

Not sure if I'm in the minority, but I think longer variable names that make
the code more readable is a good thing.

> +
> +	ls = of_get_flat_dt_prop(node, "ibm,lmb-size", &l);
> +	if (ls == NULL || l < dt_root_size_cells * sizeof(__be32))
> +		return 0;
> +	memblock_size = dt_mem_next_cell(dt_root_size_cells, &ls);
> +
> +	dm = of_get_flat_dt_prop(node, "ibm,dynamic-memory-v2", &l);
> +	if (dm == NULL || l < sizeof(__be32))
> +		return 0;
> +
> +	num_sets = of_read_number(dm++, 1);
> +	if (l < (num_sets * (dt_root_addr_cells + 4) + 1) * sizeof(__be32))
> +		return 0;
> +
> +	/* check if this is a kexec/kdump kernel. */
> +	usm = of_get_flat_dt_prop(node, "linux,drconf-usable-memory", &l);
> +	if (usm != NULL)
> +		is_kexec_kdump = 1;
> +
> +	if (n_mem_addr_cells == 0)
> +		n_mem_addr_cells = dt_root_addr_cells;
> +
> +	for (; num_sets != 0; --num_sets) {
> +		struct of_drconf_cell_v2 drmem;
> +
> +		read_drconf_cell_v2(&drmem, &dm);
> +
> +		/* skip this block if the reserved bit is set in flags (0x80)
> +		 * or if the block is not assigned to this partition (0x8)
> +		 */
> +		if ((drmem.flags & DRCONF_MEM_RESERVED) ||
> +		    !(drmem.flags & DRCONF_MEM_ASSIGNED))
> +			continue;
> +
> +		size = memblock_size;
> +		rngs = 1;
> +		if (is_kexec_kdump) {
> +			/*
> +			 * For each memblock in ibm,dynamic-memory, a
> +			 * corresponding entry in linux,drconf-usable-memory
> +			 * property contains a counter 'p' followed by 'p'
> +			 * (base, size) duple.  Now read the counter from
> +			 * linux,drconf-usable-memory property
> +			 */
> +			rngs = dt_mem_next_cell(dt_root_size_cells, &usm);
> +			if (!rngs) /* there are no (base, size) duple */
> +				continue;
> +		}
> +		base = drmem.base_addr;
> +		do {
> +			if (is_kexec_kdump) {
> +				base = dt_mem_next_cell(dt_root_addr_cells,
> +							 &usm);
> +				size = dt_mem_next_cell(dt_root_size_cells,
> +							 &usm);
> +			}
> +			if (iommu_is_off) {
> +				if (base >= 0x80000000ul)
> +					continue;
> +				if ((base + size) > 0x80000000ul)
> +					size = 0x80000000ul - base;
> +			}
> +			memblock_add(base, size);
> +		} while (--rngs);
> +	}
> +	memblock_dump_all();
> +	return 0;
> +}
> +
> +static int __init early_init_dt_scan_drconf_memory(unsigned long node)
> +{
> +	if (firmware_has_feature(FW_FEATURE_RPS_DM2))
> +		return early_init_dt_scan_drconf_memory_v2(node);
> +	else
> +		return early_init_dt_scan_drconf_memory_v1(node);
> +}
> +
>  #else
>  #define early_init_dt_scan_drconf_memory(node)	0
>  #endif /* CONFIG_PPC_PSERIES */
> diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
> index 669a15e..fb42134 100644
> --- a/arch/powerpc/mm/numa.c
> +++ b/arch/powerpc/mm/numa.c
> @@ -57,8 +57,10 @@ EXPORT_SYMBOL(node_to_cpumask_map);
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
> @@ -407,30 +409,73 @@ static void read_drconf_cell(struct of_drconf_cell *drmem, const __be32 **cellp)
>  }
>  
>  /*
> - * Retrieve and validate the ibm,dynamic-memory property of the device tree.
> + * Read the next memblock set entry from the ibm,dynamic-memory-v2 property

Just saw this here, ans see that it is used elsewhere. You may want to avoid
using the term memblock, this already has a meaning in the kernel and may
cause some confusion.

Still reviewing this patch, more comments as I review more.

-Nathan

> + * and return the information in the provided of_drconf_cell_v2 structure.
> + */
> +void read_drconf_cell_v2(struct of_drconf_cell_v2 *drmem, const __be32 **cellp)
> +{
> +	const __be32 *cp = (const __be32 *)*cellp;
> +
> +	drmem->num_seq_lmbs = be32_to_cpu(*cp++);
> +
> +	drmem->base_addr = read_n_cells(n_mem_addr_cells, &cp);
> +
> +	drmem->drc_index = be32_to_cpu(*cp++);
> +	drmem->aa_index = be32_to_cpu(*cp++);
> +	drmem->flags = be32_to_cpu(*cp++);
> +
> +	*cellp = cp;
> +}
> +EXPORT_SYMBOL(read_drconf_cell_v2);
> +
> +/*
> + * Retrieve and validate the ibm,dynamic-memory[-v2] property of the
> + * device tree.
>   *
>   * The layout of the ibm,dynamic-memory property is a number N of memblock
>   * list entries followed by N memblock list entries.  Each memblock list entry
>   * contains information as laid out in the of_drconf_cell struct above.
> + *
> + * The layout of the ibm,dynamic-memory-v2 property is a number N of memblock
> + * list entries.
>   */
>  static int of_get_drconf_memory(struct device_node *memory, const __be32 **dm)
>  {
>  	const __be32 *prop;
>  	u32 len, entries;
>  
> -	prop = of_get_property(memory, "ibm,dynamic-memory", &len);
> -	if (!prop || len < sizeof(unsigned int))
> -		return 0;
> +	if (firmware_has_feature(FW_FEATURE_RPS_DM2)) {
>  
> -	entries = of_read_number(prop++, 1);
> +		prop = of_get_property(memory, "ibm,dynamic-memory-v2", &len);
> +		if (!prop || len < sizeof(unsigned int))
> +			return 0;
>  
> -	/* Now that we know the number of entries, revalidate the size
> -	 * of the property read in to ensure we have everything
> -	 */
> -	if (len < (entries * (n_mem_addr_cells + 4) + 1) * sizeof(unsigned int))
> -		return 0;
> +		entries = of_read_number(prop++, 1);
> +
> +		/* Now that we know the number of set entries, revalidate the
> +		 * size of the property read in to ensure we have everything.
> +		 */
> +		if (len < DYN_MEM_V2_LEN(entries))
> +			return 0;
> +
> +		*dm = prop;
> +	} else {
> +		prop = of_get_property(memory, "ibm,dynamic-memory", &len);
> +		if (!prop || len < sizeof(unsigned int))
> +			return 0;
> +
> +		entries = of_read_number(prop++, 1);
> +
> +		/* Now that we know the number of entries, revalidate the size
> +		 * of the property read in to ensure we have everything
> +		 */
> +		if (len < (entries * (n_mem_addr_cells + 4) + 1) *
> +			   sizeof(unsigned int))
> +			return 0;
> +
> +		*dm = prop;
> +	}
>  
> -	*dm = prop;
>  	return entries;
>  }
>  
> @@ -459,7 +504,7 @@ struct assoc_arrays {
>  /*
>   * Retrieve and validate the list of associativity arrays for drconf
>   * memory from the ibm,associativity-lookup-arrays property of the
> - * device tree..
> + * device tree.
>   *
>   * The layout of the ibm,associativity-lookup-arrays property is a number N
>   * indicating the number of associativity arrays, followed by a number M
> @@ -493,7 +538,7 @@ static int of_get_assoc_arrays(struct device_node *memory,
>   * This is like of_node_to_nid_single() for memory represented in the
>   * ibm,dynamic-reconfiguration-memory node.
>   */
> -static int of_drconf_to_nid_single(struct of_drconf_cell *drmem,
> +static int of_drconf_to_nid_single(u32 drmem_flags, u32 drmem_aa_index,
>  				   struct assoc_arrays *aa)
>  {
>  	int default_nid = 0;
> @@ -501,16 +546,16 @@ static int of_drconf_to_nid_single(struct of_drconf_cell *drmem,
>  	int index;
>  
>  	if (min_common_depth > 0 && min_common_depth <= aa->array_sz &&
> -	    !(drmem->flags & DRCONF_MEM_AI_INVALID) &&
> -	    drmem->aa_index < aa->n_arrays) {
> -		index = drmem->aa_index * aa->array_sz + min_common_depth - 1;
> +	    !(drmem_flags & DRCONF_MEM_AI_INVALID) &&
> +	    drmem_aa_index < aa->n_arrays) {
> +		index = drmem_aa_index * aa->array_sz + min_common_depth - 1;
>  		nid = of_read_number(&aa->arrays[index], 1);
>  
>  		if (nid == 0xffff || nid >= MAX_NUMNODES)
>  			nid = default_nid;
>  
>  		if (nid > 0) {
> -			index = drmem->aa_index * aa->array_sz;
> +			index = drmem_aa_index * aa->array_sz;
>  			initialize_distance_lookup_table(nid,
>  							&aa->arrays[index]);
>  		}
> @@ -653,7 +698,7 @@ static inline int __init read_usm_ranges(const __be32 **usm)
>   * Extract NUMA information from the ibm,dynamic-reconfiguration-memory
>   * node.  This assumes n_mem_{addr,size}_cells have been set.
>   */
> -static void __init parse_drconf_memory(struct device_node *memory)
> +static void __init parse_drconf_memory_v1(struct device_node *memory)
>  {
>  	const __be32 *uninitialized_var(dm), *usm;
>  	unsigned int n, rc, ranges, is_kexec_kdump = 0;
> @@ -673,7 +718,7 @@ static void __init parse_drconf_memory(struct device_node *memory)
>  	if (rc)
>  		return;
>  
> -	/* check if this is a kexec/kdump kernel */
> +	/* Check if this is a kexec/kdump kernel */
>  	usm = of_get_usable_memory(memory);
>  	if (usm != NULL)
>  		is_kexec_kdump = 1;
> @@ -703,19 +748,114 @@ static void __init parse_drconf_memory(struct device_node *memory)
>  				base = read_n_cells(n_mem_addr_cells, &usm);
>  				size = read_n_cells(n_mem_size_cells, &usm);
>  			}
> -			nid = of_drconf_to_nid_single(&drmem, &aa);
> +			nid = of_drconf_to_nid_single(drmem.flags,
> +							drmem.aa_index, &aa);
>  			fake_numa_create_new_node(
>  				((base + size) >> PAGE_SHIFT),
> -					   &nid);
> +				&nid);
>  			node_set_online(nid);
>  			sz = numa_enforce_memory_limit(base, size);
>  			if (sz)
>  				memblock_set_node(base, sz,
> -						  &memblock.memory, nid);
> +						&memblock.memory, nid);
>  		} while (--ranges);
>  	}
>  }
>  
> +static void __init parse_drconf_memory_v2(struct device_node *memory)
> +{
> +	const __be32 *uninitialized_var(dm);
> +	unsigned int num_lmb_sets, rc;
> +	unsigned long lmb_size, base;
> +	const __be32 *usm;
> +	unsigned int ranges, is_kexec_kdump = 0;
> +	unsigned long size, sz;
> +	int nid;
> +	struct assoc_arrays aa = { .arrays = NULL };
> +	const __be32 *prop, *p;
> +	u32	len;
> +
> +	prop = of_get_property(memory, "ibm,dynamic-memory-v2", &len);
> +	if (!prop)
> +		return;
> +	p = prop;
> +
> +	num_lmb_sets = of_get_drconf_memory(memory, &dm);
> +	if (!num_lmb_sets)
> +		return;
> +
> +	lmb_size = of_get_lmb_size(memory);
> +	if (!lmb_size)
> +		return;
> +
> +	rc = of_get_assoc_arrays(memory, &aa);
> +	if (rc)
> +		return;
> +
> +	/* Check if this is a kexec/kdump kernel */
> +	usm = of_get_usable_memory(memory);
> +	if (usm != NULL)
> +		is_kexec_kdump = 1;
> +
> +	for (; num_lmb_sets != 0; num_lmb_sets--) {
> +		struct of_drconf_cell_v2 drmem;
> +		unsigned long nsl;
> +
> +		/* Get the current LMB set */
> +		read_drconf_cell_v2(&drmem, &dm);
> +		base = drmem.base_addr;
> +		nsl = drmem.num_seq_lmbs;
> +
> +		/* Skip this block if the reserved bit is set in
> +		 * flags (0x80) or if the block is not assigned
> +		 * to this partition (0x8)
> +		 */
> +		if ((drmem.flags & DRCONF_MEM_RESERVED)
> +		    || !(drmem.flags & DRCONF_MEM_ASSIGNED))
> +			continue;
> +
> +		for (; nsl != 0; nsl--) {
> +			size = lmb_size;
> +			ranges = 1;
> +
> +			if (is_kexec_kdump) {
> +				ranges = read_usm_ranges(&usm);
> +				if (!ranges)
> +					/* there are no (base, size) duple */
> +					continue;
> +			}
> +			do {
> +				if (is_kexec_kdump) {
> +					base = read_n_cells(n_mem_addr_cells,
> +							&usm);
> +					size = read_n_cells(n_mem_size_cells,
> +							&usm);
> +				}
> +				nid = of_drconf_to_nid_single(drmem.flags,
> +							drmem.aa_index, &aa);
> +				fake_numa_create_new_node(
> +					((base + size) >> PAGE_SHIFT),
> +					&nid);
> +				node_set_online(nid);
> +				sz = numa_enforce_memory_limit(base, size);
> +				if (sz)
> +					memblock_set_node(base, sz,
> +						&memblock.memory, nid);
> +			} while (--ranges);
> +
> +			base += sz;
> +		}
> +	}
> +}
> +
> +static void __init parse_drconf_memory(struct device_node *memory)
> +{
> +	if (firmware_has_feature(FW_FEATURE_RPS_DM2))
> +		parse_drconf_memory_v2(memory);
> +	else
> +		parse_drconf_memory_v1(memory);
> +}
> +
>  static int __init parse_numa_properties(void)
>  {
>  	struct device_node *memory;
> @@ -1035,7 +1175,13 @@ early_param("topology_updates", early_topology_updates);
>  /*
>   * Find the node associated with a hot added memory section for
>   * memory represented in the device tree by the property
> - * ibm,dynamic-reconfiguration-memory/ibm,dynamic-memory.
> + *
> + *     ibm,dynamic-reconfiguration-memory/ibm,dynamic-memory
> + *         or
> + *     ibm,dynamic-reconfiguration-memory/ibm,dynamic-memory-v2
> + *
> + * The layout of the ibm,dynamic-memory[-v2] property is a number
> + * N of memblock list entries.
>   */
>  static int hot_add_drconf_scn_to_nid(struct device_node *memory,
>  				     unsigned long scn_addr)
> @@ -1044,7 +1190,7 @@ static int hot_add_drconf_scn_to_nid(struct device_node *memory,
>  	unsigned int drconf_cell_cnt, rc;
>  	unsigned long lmb_size;
>  	struct assoc_arrays aa;
> -	int nid = -1;
> +	int nid = -1, done = 0;
>  
>  	drconf_cell_cnt = of_get_drconf_memory(memory, &dm);
>  	if (!drconf_cell_cnt)
> @@ -1058,23 +1204,45 @@ static int hot_add_drconf_scn_to_nid(struct device_node *memory,
>  	if (rc)
>  		return -1;
>  
> -	for (; drconf_cell_cnt != 0; --drconf_cell_cnt) {
> -		struct of_drconf_cell drmem;
> +	for (; (drconf_cell_cnt != 0) && !done; --drconf_cell_cnt) {
>  
> -		read_drconf_cell(&drmem, &dm);
> +		if (firmware_has_feature(FW_FEATURE_RPS_DM2)) {
> +			struct of_drconf_cell_v2 drmem;
> +			int i;
>  
> -		/* skip this block if it is reserved or not assigned to
> -		 * this partition */
> -		if ((drmem.flags & DRCONF_MEM_RESERVED)
> -		    || !(drmem.flags & DRCONF_MEM_ASSIGNED))
> -			continue;
> +			read_drconf_cell_v2(&drmem, &dm);
>  
> -		if ((scn_addr < drmem.base_addr)
> -		    || (scn_addr >= (drmem.base_addr + lmb_size)))
> -			continue;
> +			for (i = 0; (i < drmem.num_seq_lmbs) && !done;
> +				i++, drmem.base_addr += lmb_size) {
>  
> -		nid = of_drconf_to_nid_single(&drmem, &aa);
> -		break;
> +				/* Skip this block/series if it is reserved
> +				 * or not assigned to this partition
> +				 */
> +				if ((drmem.flags & DRCONF_MEM_RESERVED)
> +				    || !(drmem.flags & DRCONF_MEM_ASSIGNED))
> +					continue;
> +
> +				if ((scn_addr < drmem.base_addr) ||
> +				    (scn_addr >=
> +					(drmem.base_addr + lmb_size)))
> +					continue;
> +				nid = of_drconf_to_nid_single(drmem.flags,
> +							drmem.aa_index, &aa);
> +
> +				done = 1;
> +			}
> +		} else {
> +			struct of_drconf_cell	drmem;
> +
> +			read_drconf_cell(&drmem, &dm);
> +
> +			if ((scn_addr < drmem.base_addr)
> +			    || (scn_addr >= (drmem.base_addr + lmb_size)))
> +				continue;
> +			nid = of_drconf_to_nid_single(drmem.flags,
> +							drmem.aa_index, &aa);
> +			done = 1;
> +		}
>  	}
>  
>  	return nid;
> @@ -1170,7 +1338,7 @@ static u64 hot_add_drconf_memory_max(void)
>  
>          memory = of_find_node_by_path("/ibm,dynamic-reconfiguration-memory");
>          if (memory) {
> -                drconf_cell_cnt = of_get_drconf_memory(memory, &dm);
> +		drconf_cell_cnt = of_get_drconf_memory(memory, &dm);
>                  lmb_size = of_get_lmb_size(memory);
>                  of_node_put(memory);
>          }
> diff --git a/arch/powerpc/platforms/pseries/firmware.c b/arch/powerpc/platforms/pseries/firmware.c
> index 8c80588..00243ee 100644
> --- a/arch/powerpc/platforms/pseries/firmware.c
> +++ b/arch/powerpc/platforms/pseries/firmware.c
> @@ -111,6 +111,8 @@ static __initdata struct vec5_fw_feature
>  vec5_fw_features_table[] = {
>  	{FW_FEATURE_TYPE1_AFFINITY,	OV5_TYPE1_AFFINITY},
>  	{FW_FEATURE_PRRN,		OV5_PRRN},
> +	{FW_FEATURE_RPS_DM2,		OV5_RPS_DM2},
> +	{FW_FEATURE_RPS_DRC_INFO,	OV5_RPS_DRC_INFO},
>  };
>  
>  void __init fw_vec5_feature_init(const char *vec5, unsigned long len)
> diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
> index 2ce1385..f422dcb 100644
> --- a/arch/powerpc/platforms/pseries/hotplug-memory.c
> +++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
> @@ -839,6 +839,92 @@ static int pseries_update_drconf_memory(struct of_reconfig_data *pr)
>  	return rc;
>  }
>  
> +static int pseries_rewrite_dynamic_memory_v2(void)
> +{
> +	unsigned long memblock_size;
> +	struct device_node *dn;
> +	struct property *prop, *prop_v2;
> +	__be32 *p;
> +	struct of_drconf_cell *lmbs;
> +	u32 num_lmb_desc_sets, num_lmbs;
> +	int i;
> +
> +	dn = of_find_node_by_path("/ibm,dynamic-reconfiguration-memory");
> +	if (!dn)
> +		return -EINVAL;
> +
> +	prop_v2 = of_find_property(dn, "ibm,dynamic-memory-v2", NULL);
> +	if (!prop_v2)
> +		return -EINVAL;
> +
> +	memblock_size = pseries_memory_block_size();
> +	if (!memblock_size)
> +		return -EINVAL;
> +
> +	/* The first int of the property is the number of lmb sets
> +	 * described by the property.
> +	 */
> +	p = (__be32 *)prop_v2->value;
> +	num_lmb_desc_sets = be32_to_cpu(*p++);
> +
> +	/* Count the number of LMBs for generating the alternate format
> +	 */
> +	for (i = 0, num_lmbs = 0; i < num_lmb_desc_sets; i++) {
> +		struct of_drconf_cell_v2 drmem;
> +
> +		read_drconf_cell_v2(&drmem, (const __be32 **)&p);
> +		num_lmbs += drmem.num_seq_lmbs;
> +	}
> +
> +	/* Create an empty copy of the new 'ibm,dynamic-memory' property
> +	 */
> +	{
> +		prop = kzalloc(sizeof(*prop), GFP_KERNEL);
> +		if (!prop)
> +			return -ENOMEM;
> +		prop->name = kstrdup("ibm,dynamic-memory", GFP_KERNEL);
> +		prop->length = DYN_MEM_V2_LEN(num_lmbs);
> +		prop->value = kzalloc(prop->length, GFP_KERNEL);
> +	}
> +
> +	/* Copy/expand the ibm,dynamic-memory-v2 format to produce the
> +	 * ibm,dynamic-memory format.
> +	 */
> +	p = (__be32 *)prop->value;
> +	*p = cpu_to_be32(num_lmbs);
> +	p++;
> +	lmbs = (struct of_drconf_cell *)p;
> +
> +	p = (__be32 *)prop_v2->value;
> +	p++;
> +
> +	for (i = 0; i < num_lmb_desc_sets; i++) {
> +		struct of_drconf_cell_v2 drmem;
> +		int j, k = 0;
> +
> +		read_drconf_cell_v2(&drmem, (const __be32 **)&p);
> +
> +		for (j = 0; j < drmem.num_seq_lmbs; j++) {
> +			lmbs[k+j].base_addr = be64_to_cpu(drmem.base_addr);
> +			lmbs[k+j].drc_index = be32_to_cpu(drmem.drc_index);
> +			lmbs[k+j].reserved  = 0;
> +			lmbs[k+j].aa_index  = be32_to_cpu(drmem.aa_index);
> +			lmbs[k+i].flags     = be32_to_cpu(drmem.flags);
> +
> +			drmem.base_addr += memblock_size;
> +			drmem.drc_index++;
> +		}
> +
> +		k += drmem.num_seq_lmbs;
> +	}
> +
> +	of_remove_property(dn, prop_v2);
> +
> +	of_add_property(dn, prop);
> +
> +	return 0;
> +}
> +
>  static int pseries_memory_notifier(struct notifier_block *nb,
>  				   unsigned long action, void *data)
>  {
> @@ -866,6 +952,8 @@ static struct notifier_block pseries_mem_nb = {
>  
>  static int __init pseries_memory_hotplug_init(void)
>  {
> +	if (firmware_has_feature(FW_FEATURE_RPS_DM2))
> +		pseries_rewrite_dynamic_memory_v2();
>  	if (firmware_has_feature(FW_FEATURE_LPAR))
>  		of_reconfig_notifier_register(&pseries_mem_nb);
>  
> diff --git a/arch/powerpc/platforms/pseries/pseries_energy.c b/arch/powerpc/platforms/pseries/pseries_energy.c
> index 9276779..10c4200 100644
> --- a/arch/powerpc/platforms/pseries/pseries_energy.c
> +++ b/arch/powerpc/platforms/pseries/pseries_energy.c
> @@ -35,10 +35,68 @@ static int sysfs_entries;
>  
>  /* Helper Routines to convert between drc_index to cpu numbers */
>  
> +void read_one_drc_info(int **info, char **dtype, char **dname,
> +			unsigned long int *fdi_p, unsigned long int *nsl_p,
> +			unsigned long int *si_p, unsigned long int *ldi_p)
> +{
> +	char *drc_type, *drc_name, *pc;
> +	u32 fdi, nsl, si, ldi;
> +
> +	fdi = nsl = si = ldi = 0;
> +
> +	/* Get drc-type:encode-string */
> +	pc = (char *)info;
> +	drc_type = pc;
> +	pc += (strlen(drc_type) + 1);
> +
> +	/* Get drc-name-prefix:encode-string */
> +	drc_name = (char *)pc;
> +	pc += (strlen(drc_name) + 1);
> +
> +	/* Get drc-index-start:encode-int */
> +	memcpy(&fdi, pc, 4);
> +	fdi = be32_to_cpu(fdi);
> +	pc += 4;
> +
> +	/* Get/skip drc-name-suffix-start:encode-int */
> +	pc += 4;
> +
> +	/* Get number-sequential-elements:encode-int */
> +	memcpy(&nsl, pc, 4);
> +	nsl = be32_to_cpu(nsl);
> +	pc += 4;
> +
> +	/* Get sequential-increment:encode-int */
> +	memcpy(&si, pc, 4);
> +	si = be32_to_cpu(si);
> +	pc += 4;
> +
> +	/* Get/skip drc-power-domain:encode-int */
> +	pc += 4;
> +
> +	/* Should now know end of current entry */
> +	ldi = fdi + ((nsl-1)*si);
> +
> +	(*info) = (int *)pc;
> +
> +	if (dtype)
> +		*dtype = drc_type;
> +	if (dname)
> +		*dname = drc_name;
> +	if (fdi_p)
> +		*fdi_p = fdi;
> +	if (nsl_p)
> +		*nsl_p = nsl;
> +	if (si_p)
> +		*si_p = si;
> +	if (ldi_p)
> +		*ldi_p = ldi;
> +}
> +EXPORT_SYMBOL(read_one_drc_info);
> +
>  static u32 cpu_to_drc_index(int cpu)
>  {
>  	struct device_node *dn = NULL;
> -	const int *indexes;
>  	int i;
>  	int rc = 1;
>  	u32 ret = 0;
> @@ -46,18 +104,54 @@ static u32 cpu_to_drc_index(int cpu)
>  	dn = of_find_node_by_path("/cpus");
>  	if (dn == NULL)
>  		goto err;
> -	indexes = of_get_property(dn, "ibm,drc-indexes", NULL);
> -	if (indexes == NULL)
> -		goto err_of_node_put;
> +
>  	/* Convert logical cpu number to core number */
>  	i = cpu_core_index_of_thread(cpu);
> -	/*
> -	 * The first element indexes[0] is the number of drc_indexes
> -	 * returned in the list.  Hence i+1 will get the drc_index
> -	 * corresponding to core number i.
> -	 */
> -	WARN_ON(i > indexes[0]);
> -	ret = indexes[i + 1];
> +
> +	if (firmware_has_feature(FW_FEATURE_RPS_DRC_INFO)) {
> +		int *info = (int *)4;
> +		unsigned long int num_set_entries, j, iw = i, fdi = 0;
> +		unsigned long int ldi = 0, nsl = 0, si = 0;
> +		char *dtype;
> +		char *dname;
> +
> +		info = (int *)of_get_property(dn, "ibm,drc-info", NULL);
> +		if (info == NULL)
> +			goto err_of_node_put;
> +
> +		num_set_entries = be32_to_cpu(*info++);
> +
> +		for (j = 0; j < num_set_entries; j++) {
> +
> +			read_one_drc_info(&info, &dtype, &dname, &fdi,
> +					&nsl, &si, &ldi);
> +			if (strcmp(dtype, "CPU"))
> +				goto err;
> +
> +			if (iw < ldi)
> +				break;
> +
> +			WARN_ON(((iw-fdi)%si) != 0);
> +		}
> +		WARN_ON((nsl == 0) | (si == 0));
> +
> +		ret = ldi + (iw*si);
> +	} else {
> +		const int *indexes;
> +
> +		indexes = of_get_property(dn, "ibm,drc-indexes", NULL);
> +		if (indexes == NULL)
> +			goto err_of_node_put;
> +
> +		/*
> +		 * The first element indexes[0] is the number of drc_indexes
> +		 * returned in the list.  Hence i+1 will get the drc_index
> +		 * corresponding to core number i.
> +		 */
> +		WARN_ON(i > indexes[0]);
> +		ret = indexes[i + 1];
> +	}
> +
>  	rc = 0;
>  
>  err_of_node_put:
> @@ -78,21 +172,51 @@ static int drc_index_to_cpu(u32 drc_index)
>  	dn = of_find_node_by_path("/cpus");
>  	if (dn == NULL)
>  		goto err;
> -	indexes = of_get_property(dn, "ibm,drc-indexes", NULL);
> -	if (indexes == NULL)
> -		goto err_of_node_put;
> -	/*
> -	 * First element in the array is the number of drc_indexes
> -	 * returned.  Search through the list to find the matching
> -	 * drc_index and get the core number
> -	 */
> -	for (i = 0; i < indexes[0]; i++) {
> -		if (indexes[i + 1] == drc_index)
> +
> +	if (firmware_has_feature(FW_FEATURE_RPS_DRC_INFO)) {
> +		int *info = (int *)dn;
> +		unsigned long int num_set_entries, j, ret;
> +		unsigned long int fdi = 0, ldi = 0, nsl = 0, si = 0;
> +		char *dtype, *dname;
> +
> +		info = (int *)of_get_property(dn, "ibm,drc-info", NULL);
> +		if (info == NULL)
> +			goto err_of_node_put;
> +
> +		num_set_entries = be32_to_cpu(*info++);
> +
> +		for (j = 0; j < num_set_entries; j++) {
> +			read_one_drc_info(&info, &dtype, &dname, &fdi,
> +					&nsl, &si, &ldi);
> +			if (strcmp(dtype, "CPU"))
> +				goto err;
> +
> +			WARN_ON(drc_index < fdi);
> +			if (drc_index > ldi)
> +				continue;
> +
> +			WARN_ON(((drc_index-fdi)%si) != 0);
> +
> +			ret = ((drc_index-fdi)/si);
>  			break;
> +		}
> +	} else {
> +		indexes = of_get_property(dn, "ibm,drc-indexes", NULL);
> +		if (indexes == NULL)
> +			goto err_of_node_put;
> +		/*
> +		 * First element in the array is the number of drc_indexes
> +		 * returned.  Search through the list to find the matching
> +		 * drc_index and get the core number
> +		 */
> +		for (i = 0; i < indexes[0]; i++) {
> +			if (indexes[i + 1] == drc_index)
> +				break;
> +		}
> +		/* Convert core number to logical cpu number */
> +		cpu = cpu_first_thread_of_core(i);
> +		rc = 0;
>  	}
> -	/* Convert core number to logical cpu number */
> -	cpu = cpu_first_thread_of_core(i);
> -	rc = 0;
>  
>  err_of_node_put:
>  	of_node_put(dn);
> diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
> index 9883bc7..f554205 100644
> --- a/arch/powerpc/platforms/pseries/setup.c
> +++ b/arch/powerpc/platforms/pseries/setup.c
> @@ -736,7 +736,7 @@ static void pseries_power_off(void)
>   * Called very early, MMU is off, device-tree isn't unflattened
>   */
>  
> -static int __init pseries_probe_fw_features(unsigned long node,
> +int __init pseries_probe_fw_features(unsigned long node,
>  					    const char *uname, int depth,
>  					    void *data)
>  {
> @@ -770,6 +770,7 @@ static int __init pseries_probe_fw_features(unsigned long node,
>  
>  	return hypertas_found && vec5_found;
>  }
> +EXPORT_SYMBOL(pseries_probe_fw_features);
>  
>  static int __init pSeries_probe(void)
>  {
> diff --git a/drivers/pci/hotplug/rpadlpar_core.c b/drivers/pci/hotplug/rpadlpar_core.c
> index dc67f39..bea9723 100644
> --- a/drivers/pci/hotplug/rpadlpar_core.c
> +++ b/drivers/pci/hotplug/rpadlpar_core.c
> @@ -27,6 +27,7 @@
>  #include <linux/mutex.h>
>  #include <asm/rtas.h>
>  #include <asm/vio.h>
> +#include <linux/firmware.h>
>  
>  #include "../pci.h"
>  #include "rpaphp.h"
> @@ -44,15 +45,14 @@ static struct device_node *find_vio_slot_node(char *drc_name)
>  {
>  	struct device_node *parent = of_find_node_by_name(NULL, "vdevice");
>  	struct device_node *dn = NULL;
> -	char *name;
>  	int rc;
>  
>  	if (!parent)
>  		return NULL;
>  
>  	while ((dn = of_get_next_child(parent, dn))) {
> -		rc = rpaphp_get_drc_props(dn, NULL, &name, NULL, NULL);
> -		if ((rc == 0) && (!strcmp(drc_name, name)))
> +		rc = rpaphp_check_drc_props(dn, drc_name, NULL);
> +		if (rc == 0)
>  			break;
>  	}
>  
> @@ -64,15 +64,12 @@ static struct device_node *find_php_slot_pci_node(char *drc_name,
>  						  char *drc_type)
>  {
>  	struct device_node *np = NULL;
> -	char *name;
> -	char *type;
>  	int rc;
>  
>  	while ((np = of_find_node_by_name(np, "pci"))) {
> -		rc = rpaphp_get_drc_props(np, NULL, &name, &type, NULL);
> +		rc = rpaphp_check_drc_props(np, drc_name, drc_type);
>  		if (rc == 0)
> -			if (!strcmp(drc_name, name) && !strcmp(drc_type, type))
> -				break;
> +			break;
>  	}
>  
>  	return np;
> diff --git a/drivers/pci/hotplug/rpaphp.h b/drivers/pci/hotplug/rpaphp.h
> index 7db024e..8db5f2e 100644
> --- a/drivers/pci/hotplug/rpaphp.h
> +++ b/drivers/pci/hotplug/rpaphp.h
> @@ -91,8 +91,8 @@ int rpaphp_get_sensor_state(struct slot *slot, int *state);
>  
>  /* rpaphp_core.c */
>  int rpaphp_add_slot(struct device_node *dn);
> -int rpaphp_get_drc_props(struct device_node *dn, int *drc_index,
> -		char **drc_name, char **drc_type, int *drc_power_domain);
> +int rpaphp_check_drc_props(struct device_node *dn, char *drc_name,
> +		char *drc_type);
>  
>  /* rpaphp_slot.c */
>  void dealloc_slot_struct(struct slot *slot);
> diff --git a/drivers/pci/hotplug/rpaphp_core.c b/drivers/pci/hotplug/rpaphp_core.c
> index 8d13202..0cfdbd9 100644
> --- a/drivers/pci/hotplug/rpaphp_core.c
> +++ b/drivers/pci/hotplug/rpaphp_core.c
> @@ -30,6 +30,7 @@
>  #include <linux/smp.h>
>  #include <linux/init.h>
>  #include <linux/vmalloc.h>
> +#include <asm/firmware.h>
>  #include <asm/eeh.h>       /* for eeh_add_device() */
>  #include <asm/rtas.h>		/* rtas_call */
>  #include <asm/pci-bridge.h>	/* for pci_controller */
> @@ -142,15 +143,6 @@ static enum pci_bus_speed get_max_bus_speed(struct slot *slot)
>  	case 5:
>  	case 6:
>  		speed = PCI_SPEED_33MHz;	/* speed for case 1-6 */
> -		break;
> -	case 7:
> -	case 8:
> -		speed = PCI_SPEED_66MHz;
> -		break;
> -	case 11:
> -	case 14:
> -		speed = PCI_SPEED_66MHz_PCIX;
> -		break;
>  	case 12:
>  	case 15:
>  		speed = PCI_SPEED_100MHz_PCIX;
> @@ -196,25 +188,21 @@ static int get_children_props(struct device_node *dn, const int **drc_indexes,
>  	return 0;
>  }
>  
> -/* To get the DRC props describing the current node, first obtain it's
> - * my-drc-index property.  Next obtain the DRC list from it's parent.  Use
> - * the my-drc-index for correlation, and obtain the requested properties.
> +
> +/* Verify the existence of 'drc_name' and/or 'drc_type' within the
> + * current node.  First obtain it's my-drc-index property.  Next,
> + * obtain the DRC info from it's parent.  Use the my-drc-index for
> + * correlation, and obtain/validate the requested properties.
>   */
> -int rpaphp_get_drc_props(struct device_node *dn, int *drc_index,
> -		char **drc_name, char **drc_type, int *drc_power_domain)
> +
> +static int rpaphp_check_drc_props_v1(struct device_node *dn, char *drc_name,
> +				char *drc_type, unsigned int my_index)
>  {
> +	char *name_tmp, *type_tmp;
>  	const int *indexes, *names;
>  	const int *types, *domains;
> -	const unsigned int *my_index;
> -	char *name_tmp, *type_tmp;
>  	int i, rc;
>  
> -	my_index = of_get_property(dn, "ibm,my-drc-index", NULL);
> -	if (!my_index) {
> -		/* Node isn't DLPAR/hotplug capable */
> -		return -EINVAL;
> -	}
> -
>  	rc = get_children_props(dn->parent, &indexes, &names, &types, &domains);
>  	if (rc < 0) {
>  		return -EINVAL;
> @@ -225,24 +213,83 @@ int rpaphp_get_drc_props(struct device_node *dn, int *drc_index,
>  
>  	/* Iterate through parent properties, looking for my-drc-index */
>  	for (i = 0; i < be32_to_cpu(indexes[0]); i++) {
> -		if ((unsigned int) indexes[i + 1] == *my_index) {
> -			if (drc_name)
> -				*drc_name = name_tmp;
> -			if (drc_type)
> -				*drc_type = type_tmp;
> -			if (drc_index)
> -				*drc_index = be32_to_cpu(*my_index);
> -			if (drc_power_domain)
> -				*drc_power_domain = be32_to_cpu(domains[i+1]);
> -			return 0;
> -		}
> +		if ((unsigned int) indexes[i + 1] == my_index)
> +			break;
> +
>  		name_tmp += (strlen(name_tmp) + 1);
>  		type_tmp += (strlen(type_tmp) + 1);
>  	}
>  
> +	if (((drc_name == NULL) || (drc_name && !strcmp(drc_name, name_tmp))) &&
> +	    ((drc_type == NULL) || (drc_type && !strcmp(drc_type, type_tmp))))
> +		return 0;
> +
> +	return -EINVAL;
> +}
> +
> +static int rpaphp_check_drc_props_v2(struct device_node *dn, char *drc_name,
> +				char *drc_type, unsigned int my_index)
> +{
> +	int *info = (int *)dn;
> +	unsigned int entries;
> +	unsigned long int fdi = 0, ldi = 0, nsl = 0, si = 0;
> +	char *name_tmp, *type_tmp;
> +	int j, ret = -EINVAL;
> +
> +	info = (int *)of_get_property(dn->parent, "ibm,drc-info", NULL);
> +	if (info == NULL)
> +		return -EINVAL;
> +
> +	entries = be32_to_cpu(*info++);
> +
> +	for (j = 0; j < entries; j++) {
> +		read_one_drc_info(&info, &type_tmp, &name_tmp,
> +				&fdi, &nsl, &si, &ldi);
> +
> +		/* Should now know end of current entry */
> +
> +		ldi = fdi + ((nsl-1)*si);
> +
> +		WARN_ON(my_index < fdi);
> +		if (my_index > ldi)
> +			continue;
> +
> +		WARN_ON(((my_index-fdi)%si) != 0);
> +
> +		ret = ((my_index-fdi)/si);
> +		break;
> +	}
> +	/* Found it */
> +
> +	if (((drc_name == NULL) ||
> +	     (drc_name && !strcmp(drc_name, name_tmp))) &&
> +	    ((drc_type == NULL) ||
> +	     (drc_type && !strcmp(drc_type, type_tmp))))
> +		return 0;
> +
>  	return -EINVAL;
>  }
> -EXPORT_SYMBOL_GPL(rpaphp_get_drc_props);
> +
> +int rpaphp_check_drc_props(struct device_node *dn, char *drc_name,
> +			char *drc_type)
> +{
> +	const unsigned int *my_index;
> +
> +	my_index = of_get_property(dn, "ibm,my-drc-index", NULL);
> +	if (!my_index) {
> +		/* Node isn't DLPAR/hotplug capable */
> +		return -EINVAL;
> +	}
> +
> +	if (firmware_has_feature(FW_FEATURE_RPS_DRC_INFO))
> +		return rpaphp_check_drc_props_v2(dn, drc_name, drc_type,
> +						*my_index);
> +	else
> +		return rpaphp_check_drc_props_v1(dn, drc_name, drc_type,
> +						*my_index);
> +}
> +EXPORT_SYMBOL_GPL(rpaphp_check_drc_props);
> +
>  
>  static int is_php_type(char *drc_type)
>  {
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
