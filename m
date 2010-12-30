Return-Path: <glikely@secretlab.ca>
Sender: Grant Likely <glikely@secretlab.ca>
Date: Wed, 29 Dec 2010 17:36:25 -0700
From: Grant Likely <grant.likely@secretlab.ca>
To: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
Subject: Re: [PATCH 6/7] fdt.c: Reorder unflatten_dt_node
Message-ID: <20101230003625.GF32711@angua.secretlab.ca>
References: <1290021345-4303-1-git-send-email-stephen.neuendorffer@xilinx.com>
	<1290124502-13125-1-git-send-email-stephen.neuendorffer@xilinx.com>
	<1290124502-13125-2-git-send-email-stephen.neuendorffer@xilinx.com>
	<1290124502-13125-3-git-send-email-stephen.neuendorffer@xilinx.com>
	<1290124502-13125-4-git-send-email-stephen.neuendorffer@xilinx.com>
	<1290124502-13125-5-git-send-email-stephen.neuendorffer@xilinx.com>
	<1290124502-13125-6-git-send-email-stephen.neuendorffer@xilinx.com>
	<972516c0-f170-469f-937f-bfa6be8dd04a@SG2EHSMHS004.ehs.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <972516c0-f170-469f-937f-bfa6be8dd04a@SG2EHSMHS004.ehs.local>
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

On Thu, Nov 18, 2010 at 03:55:01PM -0800, Stephen Neuendorffer wrote:
> Move unflatten_dt_node to be grouped with non-__init functions.
> 
> Signed-off-by: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>

Merged, thanks.

g.

> ---
>  drivers/of/fdt.c |  218 +++++++++++++++++++++++++++---------------------------
>  1 files changed, 109 insertions(+), 109 deletions(-)
> 
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index a07fd1a..236a8c9 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -97,115 +97,6 @@ int of_fdt_is_compatible(struct boot_param_header *blob,
>  	return 0;
>  }
>  
> -/* Everything below here references initial_boot_params directly. */
> -int __initdata dt_root_addr_cells;
> -int __initdata dt_root_size_cells;
> -
> -struct boot_param_header *initial_boot_params;
> -
> -#ifdef CONFIG_EARLY_FLATTREE
> -
> -/**
> - * of_scan_flat_dt - scan flattened tree blob and call callback on each.
> - * @it: callback function
> - * @data: context data pointer
> - *
> - * This function is used to scan the flattened device-tree, it is
> - * used to extract the memory information at boot before we can
> - * unflatten the tree
> - */
> -int __init of_scan_flat_dt(int (*it)(unsigned long node,
> -				     const char *uname, int depth,
> -				     void *data),
> -			   void *data)
> -{
> -	unsigned long p = ((unsigned long)initial_boot_params) +
> -		be32_to_cpu(initial_boot_params->off_dt_struct);
> -	int rc = 0;
> -	int depth = -1;
> -
> -	do {
> -		u32 tag = be32_to_cpup((__be32 *)p);
> -		char *pathp;
> -
> -		p += 4;
> -		if (tag == OF_DT_END_NODE) {
> -			depth--;
> -			continue;
> -		}
> -		if (tag == OF_DT_NOP)
> -			continue;
> -		if (tag == OF_DT_END)
> -			break;
> -		if (tag == OF_DT_PROP) {
> -			u32 sz = be32_to_cpup((__be32 *)p);
> -			p += 8;
> -			if (be32_to_cpu(initial_boot_params->version) < 0x10)
> -				p = ALIGN(p, sz >= 8 ? 8 : 4);
> -			p += sz;
> -			p = ALIGN(p, 4);
> -			continue;
> -		}
> -		if (tag != OF_DT_BEGIN_NODE) {
> -			pr_err("Invalid tag %x in flat device tree!\n", tag);
> -			return -EINVAL;
> -		}
> -		depth++;
> -		pathp = (char *)p;
> -		p = ALIGN(p + strlen(pathp) + 1, 4);
> -		if ((*pathp) == '/') {
> -			char *lp, *np;
> -			for (lp = NULL, np = pathp; *np; np++)
> -				if ((*np) == '/')
> -					lp = np+1;
> -			if (lp != NULL)
> -				pathp = lp;
> -		}
> -		rc = it(p, pathp, depth, data);
> -		if (rc != 0)
> -			break;
> -	} while (1);
> -
> -	return rc;
> -}
> -
> -/**
> - * of_get_flat_dt_root - find the root node in the flat blob
> - */
> -unsigned long __init of_get_flat_dt_root(void)
> -{
> -	unsigned long p = ((unsigned long)initial_boot_params) +
> -		be32_to_cpu(initial_boot_params->off_dt_struct);
> -
> -	while (be32_to_cpup((__be32 *)p) == OF_DT_NOP)
> -		p += 4;
> -	BUG_ON(be32_to_cpup((__be32 *)p) != OF_DT_BEGIN_NODE);
> -	p += 4;
> -	return ALIGN(p + strlen((char *)p) + 1, 4);
> -}
> -
> -/**
> - * of_get_flat_dt_prop - Given a node in the flat blob, return the property ptr
> - *
> - * This function can be used within scan_flattened_dt callback to get
> - * access to properties
> - */
> -void *__init of_get_flat_dt_prop(unsigned long node, const char *name,
> -				 unsigned long *size)
> -{
> -	return of_fdt_get_property(initial_boot_params, node, name, size);
> -}
> -
> -/**
> - * of_flat_dt_is_compatible - Return true if given node has compat in compatible list
> - * @node: node to test
> - * @compat: compatible string to compare with compatible list.
> - */
> -int __init of_flat_dt_is_compatible(unsigned long node, const char *compat)
> -{
> -	return of_fdt_is_compatible(initial_boot_params, node, compat);
> -}
> -
>  static void *unflatten_dt_alloc(unsigned long *mem, unsigned long size,
>  				       unsigned long align)
>  {
> @@ -421,6 +312,115 @@ unsigned long unflatten_dt_node(struct boot_param_header *blob,
>  	return mem;
>  }
>  
> +/* Everything below here references initial_boot_params directly. */
> +int __initdata dt_root_addr_cells;
> +int __initdata dt_root_size_cells;
> +
> +struct boot_param_header *initial_boot_params;
> +
> +#ifdef CONFIG_EARLY_FLATTREE
> +
> +/**
> + * of_scan_flat_dt - scan flattened tree blob and call callback on each.
> + * @it: callback function
> + * @data: context data pointer
> + *
> + * This function is used to scan the flattened device-tree, it is
> + * used to extract the memory information at boot before we can
> + * unflatten the tree
> + */
> +int __init of_scan_flat_dt(int (*it)(unsigned long node,
> +				     const char *uname, int depth,
> +				     void *data),
> +			   void *data)
> +{
> +	unsigned long p = ((unsigned long)initial_boot_params) +
> +		be32_to_cpu(initial_boot_params->off_dt_struct);
> +	int rc = 0;
> +	int depth = -1;
> +
> +	do {
> +		u32 tag = be32_to_cpup((__be32 *)p);
> +		char *pathp;
> +
> +		p += 4;
> +		if (tag == OF_DT_END_NODE) {
> +			depth--;
> +			continue;
> +		}
> +		if (tag == OF_DT_NOP)
> +			continue;
> +		if (tag == OF_DT_END)
> +			break;
> +		if (tag == OF_DT_PROP) {
> +			u32 sz = be32_to_cpup((__be32 *)p);
> +			p += 8;
> +			if (be32_to_cpu(initial_boot_params->version) < 0x10)
> +				p = ALIGN(p, sz >= 8 ? 8 : 4);
> +			p += sz;
> +			p = ALIGN(p, 4);
> +			continue;
> +		}
> +		if (tag != OF_DT_BEGIN_NODE) {
> +			pr_err("Invalid tag %x in flat device tree!\n", tag);
> +			return -EINVAL;
> +		}
> +		depth++;
> +		pathp = (char *)p;
> +		p = ALIGN(p + strlen(pathp) + 1, 4);
> +		if ((*pathp) == '/') {
> +			char *lp, *np;
> +			for (lp = NULL, np = pathp; *np; np++)
> +				if ((*np) == '/')
> +					lp = np+1;
> +			if (lp != NULL)
> +				pathp = lp;
> +		}
> +		rc = it(p, pathp, depth, data);
> +		if (rc != 0)
> +			break;
> +	} while (1);
> +
> +	return rc;
> +}
> +
> +/**
> + * of_get_flat_dt_root - find the root node in the flat blob
> + */
> +unsigned long __init of_get_flat_dt_root(void)
> +{
> +	unsigned long p = ((unsigned long)initial_boot_params) +
> +		be32_to_cpu(initial_boot_params->off_dt_struct);
> +
> +	while (be32_to_cpup((__be32 *)p) == OF_DT_NOP)
> +		p += 4;
> +	BUG_ON(be32_to_cpup((__be32 *)p) != OF_DT_BEGIN_NODE);
> +	p += 4;
> +	return ALIGN(p + strlen((char *)p) + 1, 4);
> +}
> +
> +/**
> + * of_get_flat_dt_prop - Given a node in the flat blob, return the property ptr
> + *
> + * This function can be used within scan_flattened_dt callback to get
> + * access to properties
> + */
> +void *__init of_get_flat_dt_prop(unsigned long node, const char *name,
> +				 unsigned long *size)
> +{
> +	return of_fdt_get_property(initial_boot_params, node, name, size);
> +}
> +
> +/**
> + * of_flat_dt_is_compatible - Return true if given node has compat in compatible list
> + * @node: node to test
> + * @compat: compatible string to compare with compatible list.
> + */
> +int __init of_flat_dt_is_compatible(unsigned long node, const char *compat)
> +{
> +	return of_fdt_is_compatible(initial_boot_params, node, compat);
> +}
> +
>  #ifdef CONFIG_BLK_DEV_INITRD
>  /**
>   * early_init_dt_check_for_initrd - Decode initrd location from flat tree
> -- 
> 1.5.6.6
> 
> 
> 
> This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
> 
> 
