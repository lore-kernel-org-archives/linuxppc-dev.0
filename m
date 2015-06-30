Return-Path: <glikely@secretlab.ca>
Received: from mail-wg0-f45.google.com (mail-wg0-f45.google.com [74.125.82.45])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3CBB01A1000
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Jul 2015 06:22:44 +1000 (AEST)
Received: by wguu7 with SMTP id u7so19238325wgu.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jun 2015 13:22:40 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@linaro.org>
Subject: Re: [PATCH v5 40/42] drivers/of: Allow to specify root node in
 of_fdt_unflatten_tree()
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, bhelgaas@google.com, aik@ozlabs.ru,
 panto@antoniou-consulting.com, robherring2@gmail.com, Gavin Shan
 <gwshan@linux.vnet.ibm.com>
In-Reply-To: <1433400131-18429-41-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1433400131-18429-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1433400131-18429-41-git-send-email-gwshan@linux.vnet.ibm.com>
Date: Tue, 30 Jun 2015 19:06:52 +0100
Message-Id: <20150630180652.198E2C4063C@trevor.secretlab.ca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu,  4 Jun 2015 16:42:09 +1000
, Gavin Shan <gwshan@linux.vnet.ibm.com>
 wrote:
> The patch introduces one more argument to of_fdt_unflatten_tree()
> to specify the root node for the FDT blob, which is going to be
> unflattened. In the result, the function can be used to unflatten
> FDT blob, which represents device sub-tree in subsequent patches.
> 
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

In principle, looks okay. There are going to be lifecycle issues though
because nodes allocated from unflatten_dt_node cannot be cleanly freed
because they aren't allocated in the same way as OF_DYNAMIC nodes are
allocated.

It may be time to dump the special allocation of fdt.c entirely and
treat all nodes the same way, with name and properties all allocated
with normal kmallocs.... Investigation is needed to figure out if this
is feasible.

Comments below.

> ---
> v5:
>   * Newly introduced
> ---
>  drivers/of/fdt.c       | 26 ++++++++++++++++++--------
>  drivers/of/unittest.c  |  2 +-
>  include/linux/of_fdt.h |  3 ++-
>  3 files changed, 21 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index b87c157..b6a6c59 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -380,9 +380,16 @@ static void *unflatten_dt_node(void *blob,
>  			       struct device_node **nodepp,
>  			       bool dryrun)
>  {
> +	unsigned long fpsize = 0;
> +
> +	if (dad)
> +		fpsize = strlen(of_node_full_name(dad));
> +	else
> +		fpsize = 0;

The 'else' is redundant. Better yet:

	unsigned long fpsize = dad ? strlen(of_node_full_name(dad)) : 0;

>  	cur_node_depth = 1;
>  	return __unflatten_dt_node(blob, mem, poffset,
> -				   dad, nodepp, 0, dryrun);
> +				   dad, nodepp, fpsize, dryrun);
>  }
>  
>  /**
> @@ -393,13 +400,15 @@ static void *unflatten_dt_node(void *blob,
>   * pointers of the nodes so the normal device-tree walking functions
>   * can be used.
>   * @blob: The blob to expand
> + * @dad: The root node of the created device_node tree
>   * @mynodes: The device_node tree created by the call
>   * @dt_alloc: An allocator that provides a virtual address to memory
>   * for the resulting tree
>   */
>  static void __unflatten_device_tree(void *blob,
> -			     struct device_node **mynodes,
> -			     void * (*dt_alloc)(u64 size, u64 align))
> +				    struct device_node *dad,
> +				    struct device_node **mynodes,
> +				    void * (*dt_alloc)(u64 size, u64 align))

Same comment as before, don't reflow the indentation unless you really
need to.

>  {
>  	unsigned long size;
>  	int start;
> @@ -425,7 +434,7 @@ static void __unflatten_device_tree(void *blob,
>  	/* First pass, scan for size */
>  	start = 0;
>  	size = (unsigned long)unflatten_dt_node(blob, NULL, &start,
> -						NULL, NULL, true);
> +						dad, NULL, true);
>  	size = ALIGN(size, 4);
>  
>  	pr_debug("  size is %lx, allocating...\n", size);
> @@ -440,7 +449,7 @@ static void __unflatten_device_tree(void *blob,
>  
>  	/* Second pass, do actual unflattening */
>  	start = 0;
> -	unflatten_dt_node(blob, mem, &start, NULL, mynodes, false);
> +	unflatten_dt_node(blob, mem, &start, dad, mynodes, false);
>  	if (be32_to_cpup(mem + size) != 0xdeadbeef)
>  		pr_warning("End of tree marker overwritten: %08x\n",
>  			   be32_to_cpup(mem + size));
> @@ -462,9 +471,10 @@ static void *kernel_tree_alloc(u64 size, u64 align)
>   * can be used.
>   */
>  void of_fdt_unflatten_tree(unsigned long *blob,
> -			struct device_node **mynodes)
> +			   struct device_node *dad,
> +			   struct device_node **mynodes)
>  {
> -	__unflatten_device_tree(blob, mynodes, &kernel_tree_alloc);
> +	__unflatten_device_tree(blob, dad, mynodes, &kernel_tree_alloc);
>  }
>  EXPORT_SYMBOL_GPL(of_fdt_unflatten_tree);
>  
> @@ -1095,7 +1105,7 @@ bool __init early_init_dt_scan(void *params)
>   */
>  void __init unflatten_device_tree(void)
>  {
> -	__unflatten_device_tree(initial_boot_params, &of_root,
> +	__unflatten_device_tree(initial_boot_params, NULL, &of_root,
>  				early_init_dt_alloc_memory_arch);
>  
>  	/* Get pointer to "/chosen" and "/aliases" nodes for use everywhere */
> diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
> index 1801634..2270830 100644
> --- a/drivers/of/unittest.c
> +++ b/drivers/of/unittest.c
> @@ -907,7 +907,7 @@ static int __init unittest_data_add(void)
>  			"not running tests\n", __func__);
>  		return -ENOMEM;
>  	}
> -	of_fdt_unflatten_tree(unittest_data, &unittest_data_node);
> +	of_fdt_unflatten_tree(unittest_data, NULL, &unittest_data_node);
>  	if (!unittest_data_node) {
>  		pr_warn("%s: No tree to attach; not running tests\n", __func__);
>  		return -ENODATA;
> diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
> index 587ee50..8882640 100644
> --- a/include/linux/of_fdt.h
> +++ b/include/linux/of_fdt.h
> @@ -38,7 +38,8 @@ extern bool of_fdt_is_big_endian(const void *blob,
>  extern int of_fdt_match(const void *blob, unsigned long node,
>  			const char *const *compat);
>  extern void of_fdt_unflatten_tree(unsigned long *blob,
> -			       struct device_node **mynodes);
> +				  struct device_node *dad,
> +				  struct device_node **mynodes);
>  
>  /* TBD: Temporary export of fdt globals - remove when code fully merged */
>  extern int __initdata dt_root_addr_cells;
> -- 
> 2.1.0
> 
