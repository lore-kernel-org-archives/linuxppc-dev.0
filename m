Return-Path: <glikely@secretlab.ca>
Sender: Grant Likely <glikely@secretlab.ca>
Date: Wed, 29 Dec 2010 17:35:50 -0700
From: Grant Likely <grant.likely@secretlab.ca>
To: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
Subject: Re: [PATCH 5/7] fdt.c: Refactor unflatten_dt_node
Message-ID: <20101230003550.GE32711@angua.secretlab.ca>
References: <1290021345-4303-1-git-send-email-stephen.neuendorffer@xilinx.com>
	<1290124502-13125-1-git-send-email-stephen.neuendorffer@xilinx.com>
	<1290124502-13125-2-git-send-email-stephen.neuendorffer@xilinx.com>
	<1290124502-13125-3-git-send-email-stephen.neuendorffer@xilinx.com>
	<1290124502-13125-4-git-send-email-stephen.neuendorffer@xilinx.com>
	<1290124502-13125-5-git-send-email-stephen.neuendorffer@xilinx.com>
	<e5face75-4978-4686-9d75-d92fa9ec7328@VA3EHSMHS013.ehs.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e5face75-4978-4686-9d75-d92fa9ec7328@VA3EHSMHS013.ehs.local>
Cc: dirk.brandewie@gmail.com, microblaze-uclinux@itee.uq.edu.au,
	devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 18, 2010 at 03:55:00PM -0800, Stephen Neuendorffer wrote:
> unflatten_dt_node is a helper function that does most of the work to
> convert a device tree blob into tree of device nodes.  This code
> now uses a passed-in blob instead of using the single boot-time blob,
> allowing it to be called in more contexts.
> 
> Signed-off-by: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>

Merged, thanks.

g.

> 
> ---
> 
> V2: don't reorder
>     blob argument first.
> ---
>  drivers/of/fdt.c |   27 ++++++++++++++++-----------
>  1 files changed, 16 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index 190e26c..a07fd1a 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -206,7 +206,7 @@ int __init of_flat_dt_is_compatible(unsigned long node, const char *compat)
>  	return of_fdt_is_compatible(initial_boot_params, node, compat);
>  }
>  
> -static void *__init unflatten_dt_alloc(unsigned long *mem, unsigned long size,
> +static void *unflatten_dt_alloc(unsigned long *mem, unsigned long size,
>  				       unsigned long align)
>  {
>  	void *res;
> @@ -220,16 +220,18 @@ static void *__init unflatten_dt_alloc(unsigned long *mem, unsigned long size,
>  
>  /**
>   * unflatten_dt_node - Alloc and populate a device_node from the flat tree
> + * @blob: The parent device tree blob
>   * @p: pointer to node in flat tree
>   * @dad: Parent struct device_node
>   * @allnextpp: pointer to ->allnext from last allocated device_node
>   * @fpsize: Size of the node path up at the current depth.
>   */
> -unsigned long __init unflatten_dt_node(unsigned long mem,
> -					unsigned long *p,
> -					struct device_node *dad,
> -					struct device_node ***allnextpp,
> -					unsigned long fpsize)
> +unsigned long unflatten_dt_node(struct boot_param_header *blob,
> +				unsigned long mem,
> +				unsigned long *p,
> +				struct device_node *dad,
> +				struct device_node ***allnextpp,
> +				unsigned long fpsize)
>  {
>  	struct device_node *np;
>  	struct property *pp, **prev_pp = NULL;
> @@ -325,10 +327,10 @@ unsigned long __init unflatten_dt_node(unsigned long mem,
>  		sz = be32_to_cpup((__be32 *)(*p));
>  		noff = be32_to_cpup((__be32 *)((*p) + 4));
>  		*p += 8;
> -		if (be32_to_cpu(initial_boot_params->version) < 0x10)
> +		if (be32_to_cpu(blob->version) < 0x10)
>  			*p = ALIGN(*p, sz >= 8 ? 8 : 4);
>  
> -		pname = of_fdt_get_string(initial_boot_params, noff);
> +		pname = of_fdt_get_string(blob, noff);
>  		if (pname == NULL) {
>  			pr_info("Can't find property name in list !\n");
>  			break;
> @@ -407,7 +409,8 @@ unsigned long __init unflatten_dt_node(unsigned long mem,
>  		if (tag == OF_DT_NOP)
>  			*p += 4;
>  		else
> -			mem = unflatten_dt_node(mem, p, np, allnextpp, fpsize);
> +			mem = unflatten_dt_node(blob, mem, p, np, allnextpp,
> +						fpsize);
>  		tag = be32_to_cpup((__be32 *)(*p));
>  	}
>  	if (tag != OF_DT_END_NODE) {
> @@ -599,7 +602,8 @@ void __init unflatten_device_tree(void)
>  	/* First pass, scan for size */
>  	start = ((unsigned long)initial_boot_params) +
>  		be32_to_cpu(initial_boot_params->off_dt_struct);
> -	size = unflatten_dt_node(0, &start, NULL, NULL, 0);
> +	size = unflatten_dt_node(initial_boot_params, 0, &start,
> +				 NULL, NULL, 0);
>  	size = (size | 3) + 1;
>  
>  	pr_debug("  size is %lx, allocating...\n", size);
> @@ -616,7 +620,8 @@ void __init unflatten_device_tree(void)
>  	/* Second pass, do actual unflattening */
>  	start = ((unsigned long)initial_boot_params) +
>  		be32_to_cpu(initial_boot_params->off_dt_struct);
> -	unflatten_dt_node(mem, &start, NULL, &allnextp, 0);
> +	unflatten_dt_node(initial_boot_params, mem, &start,
> +			  NULL, &allnextp, 0);
>  	if (be32_to_cpup((__be32 *)start) != OF_DT_END)
>  		pr_warning("Weird tag at end of tree: %08x\n", *((u32 *)start));
>  	if (be32_to_cpu(((__be32 *)mem)[size / 4]) != 0xdeadbeef)
> -- 
> 1.5.6.6
> 
> 
> 
> This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
> 
> 
