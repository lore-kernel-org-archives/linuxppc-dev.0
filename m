Return-Path: <jsarha@ti.com>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B3E621A03B4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Feb 2016 03:05:13 +1100 (AEDT)
Subject: Re: [PATCH v8 43/45] drivers/of: Specify parent node in
 of_fdt_unflatten_tree()
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, <linuxppc-dev@lists.ozlabs.org>
References: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1455680668-23298-44-git-send-email-gwshan@linux.vnet.ibm.com>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <benh@kernel.crashing.org>, <mpe@ellerman.id.au>, <aik@ozlabs.ru>,
 <dja@axtens.net>, <bhelgaas@google.com>, <robherring2@gmail.com>,
 <grant.likely@linaro.org>
From: Jyri Sarha <jsarha@ti.com>
Message-ID: <56C49896.3090109@ti.com>
Date: Wed, 17 Feb 2016 17:58:14 +0200
MIME-Version: 1.0
In-Reply-To: <1455680668-23298-44-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/17/16 05:44, Gavin Shan wrote:
> This adds one more argument to of_fdt_unflatten_tree() to specify
> the parent node of the FDT blob that is going to be unflattened.
> In the result, the function can be used to unflatten FDT blob that
> represents device sub-tree in PowerNV PCI hotplug driver.
>
> Cc: Jyri Sarha <jsarha@ti.com>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> ---
>   drivers/gpu/drm/tilcdc/tilcdc_slave_compat.c |  2 +-

Acked-by: Jyri Sarha <jsarha@ti.com>

>   drivers/of/fdt.c                             | 14 ++++++++++----
>   drivers/of/unittest.c                        |  2 +-
>   include/linux/of_fdt.h                       |  1 +
>   4 files changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/tilcdc/tilcdc_slave_compat.c b/drivers/gpu/drm/tilcdc/tilcdc_slave_compat.c
> index 106679b..f9c79da 100644
> --- a/drivers/gpu/drm/tilcdc/tilcdc_slave_compat.c
> +++ b/drivers/gpu/drm/tilcdc/tilcdc_slave_compat.c
> @@ -157,7 +157,7 @@ struct device_node * __init tilcdc_get_overlay(struct kfree_table *kft)
>   	if (!overlay_data || kfree_table_add(kft, overlay_data))
>   		return NULL;
>
> -	of_fdt_unflatten_tree(overlay_data, &overlay);
> +	of_fdt_unflatten_tree(overlay_data, NULL, &overlay);
>   	if (!overlay) {
>   		pr_warn("%s: Unfattening overlay tree failed\n", __func__);
>   		return NULL;
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index 3fc9a30..16a1ba5 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -450,11 +450,13 @@ static int unflatten_dt_nodes(const void *blob,
>    * pointers of the nodes so the normal device-tree walking functions
>    * can be used.
>    * @blob: The blob to expand
> + * @dad: Parent device node
>    * @mynodes: The device_node tree created by the call
>    * @dt_alloc: An allocator that provides a virtual address to memory
>    * for the resulting tree
>    */
>   static void __unflatten_device_tree(const void *blob,
> +			     struct device_node *dad,
>   			     struct device_node **mynodes,
>   			     void * (*dt_alloc)(u64 size, u64 align))
>   {
> @@ -479,7 +481,7 @@ static void __unflatten_device_tree(const void *blob,
>   	}
>
>   	/* First pass, scan for size */
> -	size = unflatten_dt_nodes(blob, NULL, NULL, NULL);
> +	size = unflatten_dt_nodes(blob, NULL, dad, NULL);
>   	if (size < 0)
>   		return;
>
> @@ -495,7 +497,7 @@ static void __unflatten_device_tree(const void *blob,
>   	pr_debug("  unflattening %p...\n", mem);
>
>   	/* Second pass, do actual unflattening */
> -	unflatten_dt_nodes(blob, mem, NULL, mynodes);
> +	unflatten_dt_nodes(blob, mem, dad, mynodes);
>   	if (be32_to_cpup(mem + size) != 0xdeadbeef)
>   		pr_warning("End of tree marker overwritten: %08x\n",
>   			   be32_to_cpup(mem + size));
> @@ -512,6 +514,9 @@ static DEFINE_MUTEX(of_fdt_unflatten_mutex);
>
>   /**
>    * of_fdt_unflatten_tree - create tree of device_nodes from flat blob
> + * @blob: Flat device tree blob
> + * @dad: Parent device node
> + * @mynodes: The device tree created by the call
>    *
>    * unflattens the device-tree passed by the firmware, creating the
>    * tree of struct device_node. It also fills the "name" and "type"
> @@ -519,10 +524,11 @@ static DEFINE_MUTEX(of_fdt_unflatten_mutex);
>    * can be used.
>    */
>   void of_fdt_unflatten_tree(const unsigned long *blob,
> +			struct device_node *dad,
>   			struct device_node **mynodes)
>   {
>   	mutex_lock(&of_fdt_unflatten_mutex);
> -	__unflatten_device_tree(blob, mynodes, &kernel_tree_alloc);
> +	__unflatten_device_tree(blob, dad, mynodes, &kernel_tree_alloc);
>   	mutex_unlock(&of_fdt_unflatten_mutex);
>   }
>   EXPORT_SYMBOL_GPL(of_fdt_unflatten_tree);
> @@ -1180,7 +1186,7 @@ bool __init early_init_dt_scan(void *params)
>    */
>   void __init unflatten_device_tree(void)
>   {
> -	__unflatten_device_tree(initial_boot_params, &of_root,
> +	__unflatten_device_tree(initial_boot_params, NULL, &of_root,
>   				early_init_dt_alloc_memory_arch);
>
>   	/* Get pointer to "/chosen" and "/aliases" nodes for use everywhere */
> diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
> index 979b6e4..ec36f93 100644
> --- a/drivers/of/unittest.c
> +++ b/drivers/of/unittest.c
> @@ -921,7 +921,7 @@ static int __init unittest_data_add(void)
>   			"not running tests\n", __func__);
>   		return -ENOMEM;
>   	}
> -	of_fdt_unflatten_tree(unittest_data, &unittest_data_node);
> +	of_fdt_unflatten_tree(unittest_data, NULL, &unittest_data_node);
>   	if (!unittest_data_node) {
>   		pr_warn("%s: No tree to attach; not running tests\n", __func__);
>   		return -ENODATA;
> diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
> index df9ef38..3644960 100644
> --- a/include/linux/of_fdt.h
> +++ b/include/linux/of_fdt.h
> @@ -38,6 +38,7 @@ extern bool of_fdt_is_big_endian(const void *blob,
>   extern int of_fdt_match(const void *blob, unsigned long node,
>   			const char *const *compat);
>   extern void of_fdt_unflatten_tree(const unsigned long *blob,
> +			       struct device_node *dad,
>   			       struct device_node **mynodes);
>
>   /* TBD: Temporary export of fdt globals - remove when code fully merged */
>
