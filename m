Return-Path: <glikely@secretlab.ca>
Received: from mail-wi0-f176.google.com (mail-wi0-f176.google.com
 [209.85.212.176])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 168781A1009
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Jul 2015 06:22:45 +1000 (AEST)
Received: by wiwl6 with SMTP id l6so144078806wiw.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jun 2015 13:22:41 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@linaro.org>
Subject: Re: [PATCH v5 39/42] drivers/of: Unflatten nodes equal or deeper
 than specified level
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, bhelgaas@google.com, aik@ozlabs.ru,
 panto@antoniou-consulting.com, robherring2@gmail.com, Gavin Shan
 <gwshan@linux.vnet.ibm.com>
In-Reply-To: <1433400131-18429-40-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1433400131-18429-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1433400131-18429-40-git-send-email-gwshan@linux.vnet.ibm.com>
Date: Tue, 30 Jun 2015 18:47:04 +0100
Message-Id: <20150630174704.E1757C4059B@trevor.secretlab.ca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu,  4 Jun 2015 16:42:08 +1000
, Gavin Shan <gwshan@linux.vnet.ibm.com>
 wrote:
> unflatten_dt_node() is called recursively to unflatten FDT nodes
> with the assumption that FDT blob has only one root node, which
> isn't true when the FDT blob represents device sub-tree. The
> patch improves the function to supporting device sub-tree that
> have multiple root nodes:
> 
>    * Rename original unflatten_dt_node() to __unflatten_dt_node().
>    * Wrapper unflatten_dt_node() calls __unflatten_dt_node() with
>      adjusted current node depth to 1 to avoid underflow.
> 
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> ---
> v5:
>   * Split from PATCH[v4 19/21]
>   * Fixed "line over 80 characters" from checkpatch.pl
> ---
>  drivers/of/fdt.c | 56 ++++++++++++++++++++++++++++++++++++++------------------
>  1 file changed, 38 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index cde35c5d01..b87c157 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -28,6 +28,8 @@
>  #include <asm/setup.h>  /* for COMMAND_LINE_SIZE */
>  #include <asm/page.h>
>  
> +static int cur_node_depth;
> +

eeeek! We'll never be able to call this concurrently this way. That will
create theoretical race conditions in the overlay code. (actually, you
didn't introduce this problem, see below...)

>  /*
>   * of_fdt_limit_memory - limit the number of regions in the /memory node
>   * @limit: maximum entries
> @@ -161,27 +163,26 @@ static void *unflatten_dt_alloc(void **mem, unsigned long size,
>  }
>  
>  /**
> - * unflatten_dt_node - Alloc and populate a device_node from the flat tree
> + * __unflatten_dt_node - Alloc and populate a device_node from the flat tree
>   * @blob: The parent device tree blob
>   * @mem: Memory chunk to use for allocating device nodes and properties
>   * @p: pointer to node in flat tree
>   * @dad: Parent struct device_node
>   * @fpsize: Size of the node path up at the current depth.
>   */
> -static void * unflatten_dt_node(void *blob,
> -				void *mem,
> -				int *poffset,
> -				struct device_node *dad,
> -				struct device_node **nodepp,
> -				unsigned long fpsize,
> -				bool dryrun)
> +static void *__unflatten_dt_node(void *blob,
> +				 void *mem,
> +				 int *poffset,
> +				 struct device_node *dad,
> +				 struct device_node **nodepp,
> +				 unsigned long fpsize,
> +				 bool dryrun)

nitpick: If you resist the temptation to reflow indentation, then the
diffstat is smaller.

>  {
>  	const __be32 *p;
>  	struct device_node *np;
>  	struct property *pp, **prev_pp = NULL;
>  	const char *pathp;
>  	unsigned int l, allocl;
> -	static int depth = 0;

Hmmmm.. looks like the race condition is already there. Well that's no
good. If you move *depth into the parameters to unflatten_dt_node(), then
you can solve both problems at once without having to create a __
version of the function. That will be a cleaner solution overall.

>  	int old_depth;
>  	int offset;
>  	int has_name = 0;
> @@ -334,13 +335,19 @@ static void * unflatten_dt_node(void *blob,
>  			np->type = "<NULL>";
>  	}
>  
> -	old_depth = depth;
> -	*poffset = fdt_next_node(blob, *poffset, &depth);
> -	if (depth < 0)
> -		depth = 0;
> -	while (*poffset > 0 && depth > old_depth)
> -		mem = unflatten_dt_node(blob, mem, poffset, np, NULL,
> -					fpsize, dryrun);
> +	old_depth = cur_node_depth;
> +	*poffset = fdt_next_node(blob, *poffset, &cur_node_depth);
> +	while (*poffset > 0) {

What is the reasoning here? Why change to looking for poffset > 0?

> +		if (cur_node_depth < old_depth)
> +			break;
> +
> +		if (cur_node_depth == old_depth)
> +			mem = __unflatten_dt_node(blob, mem, poffset,
> +						  dad, NULL, fpsize, dryrun);
> +		else if (cur_node_depth > old_depth)
> +			mem = __unflatten_dt_node(blob, mem, poffset,
> +						  np, NULL, fpsize, dryrun);

Ditto here, please describe the purpose of the new logic.

> +	}
>  
>  	if (*poffset < 0 && *poffset != -FDT_ERR_NOTFOUND)
>  		pr_err("unflatten: error %d processing FDT\n", *poffset);
> @@ -366,6 +373,18 @@ static void * unflatten_dt_node(void *blob,
>  	return mem;
>  }
>  
> +static void *unflatten_dt_node(void *blob,
> +			       void *mem,
> +			       int *poffset,
> +			       struct device_node *dad,
> +			       struct device_node **nodepp,
> +			       bool dryrun)
> +{
> +	cur_node_depth = 1;
> +	return __unflatten_dt_node(blob, mem, poffset,
> +				   dad, nodepp, 0, dryrun);
> +}
> +
>  /**
>   * __unflatten_device_tree - create tree of device_nodes from flat blob
>   *
> @@ -405,7 +424,8 @@ static void __unflatten_device_tree(void *blob,
>  
>  	/* First pass, scan for size */
>  	start = 0;
> -	size = (unsigned long)unflatten_dt_node(blob, NULL, &start, NULL, NULL, 0, true);
> +	size = (unsigned long)unflatten_dt_node(blob, NULL, &start,
> +						NULL, NULL, true);
>  	size = ALIGN(size, 4);
>  
>  	pr_debug("  size is %lx, allocating...\n", size);
> @@ -420,7 +440,7 @@ static void __unflatten_device_tree(void *blob,
>  
>  	/* Second pass, do actual unflattening */
>  	start = 0;
> -	unflatten_dt_node(blob, mem, &start, NULL, mynodes, 0, false);
> +	unflatten_dt_node(blob, mem, &start, NULL, mynodes, false);
>  	if (be32_to_cpup(mem + size) != 0xdeadbeef)
>  		pr_warning("End of tree marker overwritten: %08x\n",
>  			   be32_to_cpup(mem + size));
> -- 
> 2.1.0
> 
