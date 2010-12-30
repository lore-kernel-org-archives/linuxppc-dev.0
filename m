Return-Path: <glikely@secretlab.ca>
Sender: Grant Likely <glikely@secretlab.ca>
Date: Wed, 29 Dec 2010 17:34:58 -0700
From: Grant Likely <grant.likely@secretlab.ca>
To: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
Subject: Re: [PATCH 4/7] fdt.c: Add non-boottime device tree functions
Message-ID: <20101230003458.GD32711@angua.secretlab.ca>
References: <1290021345-4303-1-git-send-email-stephen.neuendorffer@xilinx.com>
	<1290124502-13125-1-git-send-email-stephen.neuendorffer@xilinx.com>
	<1290124502-13125-2-git-send-email-stephen.neuendorffer@xilinx.com>
	<1290124502-13125-3-git-send-email-stephen.neuendorffer@xilinx.com>
	<1290124502-13125-4-git-send-email-stephen.neuendorffer@xilinx.com>
	<d433b5eb-2d15-4a28-8083-97582bf4617f@VA3EHSMHS022.ehs.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <d433b5eb-2d15-4a28-8083-97582bf4617f@VA3EHSMHS022.ehs.local>
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

On Thu, Nov 18, 2010 at 03:54:59PM -0800, Stephen Neuendorffer wrote:
> In preparation for providing run-time handling of device trees, factor
> out some of the basic functions so that they take an arbitrary blob,
> rather than relying on the single boot-time tree.
> 
> Signed-off-by: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>

Thanks.  Merged, but one comment below.  Please fix with a followup patch.

g.

> 
> --
> 
> V2: functions have of_fdt_* names
>     removed find_flat_dt_string
>     blob argument is first
> ---
>  drivers/of/fdt.c       |  133 ++++++++++++++++++++++++++++-------------------
>  include/linux/of_fdt.h |   11 ++++
>  2 files changed, 90 insertions(+), 54 deletions(-)
> 
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index 4d71b29..190e26c 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -22,6 +22,82 @@
>  
>  #include <asm/page.h>
>  
> +char *of_fdt_get_string(struct boot_param_header *blob, u32 offset)
> +{
> +	return ((char *)blob) +
> +		be32_to_cpu(blob->off_dt_strings) + offset;
> +}
> +
> +/**
> + * of_fdt_get_property - Given a node in the given flat blob, return
> + * the property ptr
> + */
> +void *of_fdt_get_property(struct boot_param_header *blob,
> +		       unsigned long node, const char *name,
> +		       unsigned long *size)
> +{
> +	unsigned long p = node;
> +
> +	do {
> +		u32 tag = be32_to_cpup((__be32 *)p);
> +		u32 sz, noff;
> +		const char *nstr;
> +
> +		p += 4;
> +		if (tag == OF_DT_NOP)
> +			continue;
> +		if (tag != OF_DT_PROP)
> +			return NULL;
> +
> +		sz = be32_to_cpup((__be32 *)p);
> +		noff = be32_to_cpup((__be32 *)(p + 4));
> +		p += 8;
> +		if (be32_to_cpu(blob->version) < 0x10)
> +			p = ALIGN(p, sz >= 8 ? 8 : 4);
> +
> +		nstr = of_fdt_get_string(blob, noff);
> +		if (nstr == NULL) {
> +			pr_warning("Can't find property index name !\n");
> +			return NULL;
> +		}
> +		if (strcmp(name, nstr) == 0) {
> +			if (size)
> +				*size = sz;
> +			return (void *)p;
> +		}
> +		p += sz;
> +		p = ALIGN(p, 4);
> +	} while (1);
> +}
> +
> +/**
> + * of_fdt_is_compatible - Return true if given node from the given blob has
> + * compat in its compatible list
> + * @blob: A device tree blob
> + * @node: node to test
> + * @compat: compatible string to compare with compatible list.
> + */
> +int of_fdt_is_compatible(struct boot_param_header *blob,
> +		      unsigned long node, const char *compat)
> +{
> +	const char *cp;
> +	unsigned long cplen, l;
> +
> +	cp = of_fdt_get_property(blob, node, "compatible", &cplen);
> +	if (cp == NULL)
> +		return 0;
> +	while (cplen > 0) {
> +		if (of_compat_cmp(cp, compat, strlen(compat)) == 0)
> +			return 1;

Need to verify that strlen(cp) + 1 is not larger than cplen.
Otherwise cplen could wrap around and the loop won't terminate because
cplen is an unsigned long.

> +		l = strlen(cp) + 1;
> +		cp += l;
> +		cplen -= l;
> +	}
> +
> +	return 0;
> +}
> +
> +/* Everything below here references initial_boot_params directly. */
>  int __initdata dt_root_addr_cells;
>  int __initdata dt_root_size_cells;
>  
> @@ -29,12 +105,6 @@ struct boot_param_header *initial_boot_params;
>  
>  #ifdef CONFIG_EARLY_FLATTREE
>  
> -char *find_flat_dt_string(u32 offset)
> -{
> -	return ((char *)initial_boot_params) +
> -		be32_to_cpu(initial_boot_params->off_dt_strings) + offset;
> -}
> -
>  /**
>   * of_scan_flat_dt - scan flattened tree blob and call callback on each.
>   * @it: callback function
> @@ -123,38 +193,7 @@ unsigned long __init of_get_flat_dt_root(void)
>  void *__init of_get_flat_dt_prop(unsigned long node, const char *name,
>  				 unsigned long *size)
>  {
> -	unsigned long p = node;
> -
> -	do {
> -		u32 tag = be32_to_cpup((__be32 *)p);
> -		u32 sz, noff;
> -		const char *nstr;
> -
> -		p += 4;
> -		if (tag == OF_DT_NOP)
> -			continue;
> -		if (tag != OF_DT_PROP)
> -			return NULL;
> -
> -		sz = be32_to_cpup((__be32 *)p);
> -		noff = be32_to_cpup((__be32 *)(p + 4));
> -		p += 8;
> -		if (be32_to_cpu(initial_boot_params->version) < 0x10)
> -			p = ALIGN(p, sz >= 8 ? 8 : 4);
> -
> -		nstr = find_flat_dt_string(noff);
> -		if (nstr == NULL) {
> -			pr_warning("Can't find property index name !\n");
> -			return NULL;
> -		}
> -		if (strcmp(name, nstr) == 0) {
> -			if (size)
> -				*size = sz;
> -			return (void *)p;
> -		}
> -		p += sz;
> -		p = ALIGN(p, 4);
> -	} while (1);
> +	return of_fdt_get_property(initial_boot_params, node, name, size);
>  }
>  
>  /**
> @@ -164,21 +203,7 @@ void *__init of_get_flat_dt_prop(unsigned long node, const char *name,
>   */
>  int __init of_flat_dt_is_compatible(unsigned long node, const char *compat)
>  {
> -	const char *cp;
> -	unsigned long cplen, l;
> -
> -	cp = of_get_flat_dt_prop(node, "compatible", &cplen);
> -	if (cp == NULL)
> -		return 0;
> -	while (cplen > 0) {
> -		if (of_compat_cmp(cp, compat, strlen(compat)) == 0)
> -			return 1;
> -		l = strlen(cp) + 1;
> -		cp += l;
> -		cplen -= l;
> -	}
> -
> -	return 0;
> +	return of_fdt_is_compatible(initial_boot_params, node, compat);
>  }
>  
>  static void *__init unflatten_dt_alloc(unsigned long *mem, unsigned long size,
> @@ -303,7 +328,7 @@ unsigned long __init unflatten_dt_node(unsigned long mem,
>  		if (be32_to_cpu(initial_boot_params->version) < 0x10)
>  			*p = ALIGN(*p, sz >= 8 ? 8 : 4);
>  
> -		pname = find_flat_dt_string(noff);
> +		pname = of_fdt_get_string(initial_boot_params, noff);
>  		if (pname == NULL) {
>  			pr_info("Can't find property name in list !\n");
>  			break;
> diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
> index 7bbf5b3..70c5b73 100644
> --- a/include/linux/of_fdt.h
> +++ b/include/linux/of_fdt.h
> @@ -58,6 +58,17 @@ struct boot_param_header {
>  };
>  
>  #if defined(CONFIG_OF_FLATTREE)
> +
> +/* For scanning an arbitrary device-tree at any time */
> +extern char *of_fdt_get_string(struct boot_param_header *blob, u32 offset);
> +extern void *of_fdt_get_property(struct boot_param_header *blob,
> +				 unsigned long node,
> +				 const char *name,
> +				 unsigned long *size);
> +extern int of_fdt_is_compatible(struct boot_param_header *blob,
> +				unsigned long node,
> +				const char *compat);
> +
>  /* TBD: Temporary export of fdt globals - remove when code fully merged */
>  extern int __initdata dt_root_addr_cells;
>  extern int __initdata dt_root_size_cells;
> -- 
> 1.5.6.6
> 
> 
> 
> This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
> 
> 
