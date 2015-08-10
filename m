Return-Path: <frowand.list@gmail.com>
Received: from mail-pd0-x22e.google.com (mail-pd0-x22e.google.com
 [IPv6:2607:f8b0:400e:c02::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CC3741A06F2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2015 08:42:16 +1000 (AEST)
Received: by pdbfa8 with SMTP id fa8so35854624pdb.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Aug 2015 15:42:14 -0700 (PDT)
Message-ID: <55C928C5.2080305@gmail.com>
Date: Mon, 10 Aug 2015 15:42:13 -0700
From: Frank Rowand <frowand.list@gmail.com>
Reply-To: frowand.list@gmail.com
MIME-Version: 1.0
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
CC: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, benh@kernel.crashing.org,
 mpe@ellerman.id.au, bhelgaas@google.com, grant.likely@linaro.org,
 robherring2@gmail.com, panto@antoniou-consulting.com, aik@ozlabs.ru
Subject: Re: [PATCH v6 39/42] drivers/of: Allow to specify root node in
 of_fdt_unflatten_tree()
References: <1438834307-26960-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1438834307-26960-40-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1438834307-26960-40-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 8/5/2015 9:11 PM, Gavin Shan wrote:
> This introduces one more argument to of_fdt_unflatten_tree()
> to specify the root node for the FDT blob, which is going to be
> unflattened. In the result, the function can be used to unflatten
> FDT blob, which represents device sub-tree in PowerNV hotplug
> driver.
> 
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> ---
>  drivers/of/fdt.c       | 13 ++++++++-----
>  drivers/of/unittest.c  |  2 +-
>  include/linux/of_fdt.h |  1 +
>  3 files changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index a18a2ce..074870a 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -388,10 +388,11 @@ static void *unflatten_dt_node(const void *blob,
>  			       struct device_node **nodepp,
>  			       bool dryrun)
>  {
> +	unsigned long fpsize = dad ? strlen(of_node_full_name(dad)) : 0;
>  	int depth = 1;
>  
>  	return __unflatten_dt_node(blob, mem, poffset,
> -				   dad, nodepp, 0,
> +				   dad, nodepp, fpsize,
>  				   dryrun, &depth);
>  }
>  
> @@ -408,6 +409,7 @@ static void *unflatten_dt_node(const void *blob,
>   * for the resulting tree
>   */
>  static void __unflatten_device_tree(const void *blob,
> +			     struct device_node *dad,
>  			     struct device_node **mynodes,
>  			     void * (*dt_alloc)(u64 size, u64 align))
>  {

Please add @dad to the documentation header for the function.


> @@ -435,7 +437,7 @@ static void __unflatten_device_tree(const void *blob,
>  	/* First pass, scan for size */
>  	start = 0;
>  	size = (unsigned long)unflatten_dt_node(blob, NULL, &start,
> -						NULL, NULL, true);
> +						dad, NULL, true);
>  	size = ALIGN(size, 4);
>  
>  	pr_debug("  size is %lx, allocating...\n", size);
> @@ -450,7 +452,7 @@ static void __unflatten_device_tree(const void *blob,
>  
>  	/* Second pass, do actual unflattening */
>  	start = 0;
> -	unflatten_dt_node(blob, mem, &start, NULL, mynodes, false);
> +	unflatten_dt_node(blob, mem, &start, dad, mynodes, false);
>  	if (be32_to_cpup(mem + size) != 0xdeadbeef)
>  		pr_warning("End of tree marker overwritten: %08x\n",
>  			   be32_to_cpup(mem + size));
> @@ -472,9 +474,10 @@ static void *kernel_tree_alloc(u64 size, u64 align)
>   * can be used.
>   */
>  void of_fdt_unflatten_tree(const unsigned long *blob,
> +			struct device_node *dad,
>  			struct device_node **mynodes)
>  {
> -	__unflatten_device_tree(blob, mynodes, &kernel_tree_alloc);
> +	__unflatten_device_tree(blob, dad, mynodes, &kernel_tree_alloc);
>  }
>  EXPORT_SYMBOL_GPL(of_fdt_unflatten_tree);
>  
> @@ -1125,7 +1128,7 @@ bool __init early_init_dt_scan(void *params)
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
> index df9ef38..3644960 100644
> --- a/include/linux/of_fdt.h
> +++ b/include/linux/of_fdt.h
> @@ -38,6 +38,7 @@ extern bool of_fdt_is_big_endian(const void *blob,
>  extern int of_fdt_match(const void *blob, unsigned long node,
>  			const char *const *compat);
>  extern void of_fdt_unflatten_tree(const unsigned long *blob,
> +			       struct device_node *dad,
>  			       struct device_node **mynodes);
>  
>  /* TBD: Temporary export of fdt globals - remove when code fully merged */
> 
