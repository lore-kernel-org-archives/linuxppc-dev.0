Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Chandru <chandru@in.ibm.com>
In-reply-to: <200807080014.24910.chandru@in.ibm.com> 
References: <200807080014.24910.chandru@in.ibm.com>
Date: Tue, 08 Jul 2008 11:56:25 +1000
Message-ID: <21291.1215482185@neuling.org>
Cc: linuxppc-dev@ozlabs.org, kexec@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



> [PATCH 1/4] kdump : add support for ibm, dynamic-reconfiguration-memory for kexec/kdump 

Please change the name of the individual patches 

BTW this patch doesn't apply against the powerpc-next tree.  Please use
that tree, not Linus tree.

In message <200807080014.24910.chandru@in.ibm.com> you wrote:
> kexec-tools adds  crash, rtas, and tce memory regions as linux,usable-memory 
> properties in device-tree.  Following changes are made in the kernel to 
> recognize these special properties in case of 
> ibm,dynamic-reconfiguration-memory node of device-tree.
> 
> Signed-off-by: Chandru Siddalingappa <chandru@in.ibm.com>
> ---
> 
> diff -Naurp linux-2.6.26-rc9-orig/arch/powerpc/kernel/prom.c 
> linux-2.6.26-rc9/arch/powerpc/kernel/prom.c
> --- linux-2.6.26-rc9-orig/arch/powerpc/kernel/prom.c	2008-07-06 
> 04:23:22.000000000 +0530
> +++ linux-2.6.26-rc9/arch/powerpc/kernel/prom.c	2008-07-07 17:23:58.000
000000 
> +0530
> @@ -884,9 +884,10 @@ static u64 __init dt_mem_next_cell(int s
>   */
>  static int __init early_init_dt_scan_drconf_memory(unsigned long node)
>  {
> -	cell_t *dm, *ls;
> +	cell_t *dm, *ls, *endp, *usm;
>  	unsigned long l, n, flags;
>  	u64 base, size, lmb_size;
> +	char buf[32], t[8];
>  
>  	ls = (cell_t *)of_get_flat_dt_prop(node, "ibm,lmb-size", &l);
>  	if (ls == NULL || l < dt_root_size_cells * sizeof(cell_t))
> @@ -917,7 +918,33 @@ static int __init early_init_dt_scan_drc
>  			if ((base + size) > 0x80000000ul)
>  				size = 0x80000000ul - base;
>  		}

Please document what you are trying to achieve here

> -		lmb_add(base, size);
> +		strcpy(buf, "linux,usable-memory");
> +		sprintf(t, "%d", (int)n);
> +		strcat(buf, t);

sprintf(buf, "linux,usable-memory%d", (int)n);
??

> +		usm = (cell_t *)of_get_flat_dt_prop(node,
> +						 (const char *)buf, &l);
> +		if (usm != NULL) {
> +			endp = usm + (l / sizeof(cell_t));
> +			while ((endp - usm) >= (dt_root_addr_cells +
> +						 dt_root_size_cells)) {
> +				base = dt_mem_next_cell(dt_root_addr_cells,
> +								 &usm);
> +				size = dt_mem_next_cell(dt_root_size_cells,
> +								 &usm);
> +				if (size == 0)
> +					continue;
> +				if (iommu_is_off) {
> +					if ((base + size) > 0x80000000ul)
> +						size = 0x80000000ul - base;

There is similar code to this above.  Can this be merged?  Why
0x80000000ul anyway?

> +				}
> +				lmb_add(base, size);
> +			}
> +
> +			/* Continue with next lmb entry */
> +			continue;

Is this "continue" needed?  

Also, this comment is useless.  We know what a continue does :-)

> +		} else {
> +			lmb_add(base, size);
> +		}
>  	}
>  	lmb_dump_all();
>  	return 0;
> diff -Naurp linux-2.6.26-rc9-orig/arch/powerpc/mm/numa.c 
> linux-2.6.26-rc9/arch/powerpc/mm/numa.c
> --- linux-2.6.26-rc9-orig/arch/powerpc/mm/numa.c	2008-07-06 04:23:22.000
000000 
> +0530
> +++ linux-2.6.26-rc9/arch/powerpc/mm/numa.c	2008-07-07 17:50:35.000000000 
> +0530
> @@ -349,18 +349,33 @@ static unsigned long __init numa_enforce
>  	return lmb_end_of_DRAM() - start;
>  }
>  
> +static void set_nodeinfo(int nid, unsigned long start, unsigned long size)
> +{
> +	fake_numa_create_new_node(((start + size) >> PAGE_SHIFT),
> +					&nid);
> +	node_set_online(nid);
> +
> +	size = numa_enforce_memory_limit(start, size);
> +	if (!size)
> +		return;
> +	add_active_range(nid, start >> PAGE_SHIFT,
> +			(start >> PAGE_SHIFT) + (size >> PAGE_SHIFT));
> +	return;
> +}
> +
>  /*
>   * Extract NUMA information from the ibm,dynamic-reconfiguration-memory
>   * node.  This assumes n_mem_{addr,size}_cells have been set.
>   */
>  static void __init parse_drconf_memory(struct device_node *memory)
>  {
> -	const unsigned int *lm, *dm, *aa;
> +	const unsigned int *lm, *dm, *aa, *usm;
>  	unsigned int ls, ld, la;
>  	unsigned int n, aam, aalen;
>  	unsigned long lmb_size, size, start;
>  	int nid, default_nid = 0;
> -	unsigned int ai, flags;
> +	unsigned int ai, flags, len, ranges;
> +	char buf[32], t[8];
>  
>  	lm = of_get_property(memory, "ibm,lmb-size", &ls);
>  	dm = of_get_property(memory, "ibm,dynamic-memory", &ld);
> @@ -396,16 +411,27 @@ static void __init parse_drconf_memory(s
>  				nid = default_nid;
>  		}
>  
> -		fake_numa_create_new_node(((start + lmb_size) >> PAGE_SHIFT),
> -						&nid);
> -		node_set_online(nid);
> +		strcpy(buf, "linux,usable-memory");
> +		sprintf(t, "%d", (int)n);
> +		strcat(buf, t);

Again, we can do this in a single sprintf, like above...

> +		usm = of_get_property(memory, (const char *)buf, &len);
> +		if (usm != NULL) {
> +			ranges = (len >> 2) / (n_mem_addr_cells +
> +						 n_mem_size_cells);
> +
> +dr_new_range:		start = read_n_cells(n_mem_addr_cells, &usm);
> +			size = read_n_cells(n_mem_size_cells, &usm);
> +			if (size == 0)
> +				continue;
>  
> -		size = numa_enforce_memory_limit(start, lmb_size);
> -		if (!size)
> -			continue;
> +			set_nodeinfo(nid, start, size);
> +			if (--ranges)
> +				goto dr_new_range;

Can you please use a while or for loop rather than a goto.  

>  
> -		add_active_range(nid, start >> PAGE_SHIFT,
> -				 (start >> PAGE_SHIFT) + (size >> PAGE_SHIFT));
> +			continue;
> +		} else {
> +			set_nodeinfo(nid, start, lmb_size);
> +		}
>  	}
>  }
>  
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 
