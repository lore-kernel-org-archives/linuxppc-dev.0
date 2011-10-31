Return-Path: <nacc@us.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8E6A3B6F64
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Nov 2011 09:48:02 +1100 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@us.ibm.com>;
 Mon, 31 Oct 2011 18:47:54 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 p9VMlha9326410
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Oct 2011 18:47:44 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 p9VMlhdm013691
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Oct 2011 18:47:43 -0400
Date: Mon, 31 Oct 2011 15:47:40 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: benh@kernel.crashing.org
Subject: Re: [PATCH] powerpc/iommu: remove default window before creating
 larger window
Message-ID: <20111031224740.GA4078@us.ibm.com>
References: <20111026224323.GA15685@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111026224323.GA15685@us.ibm.com>
Cc: miltonm@us.ibm.com, paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben,

Please don't take this patch :)

While, it does work around some issues I'm tracking down, it can lead
to worse ones if we are unable to configure the larger DMA window, or if
some functions in a PE don't use 64-bit DMA masks.

Thanks,
Nish

On 26.10.2011 [15:43:23 -0700], Nishanth Aravamudan wrote:
> The DDW feature relies on there being sufficient TCE space to allocate
> for the requested DMA window size. The default window uses up some of
> that space, though, and it is recommended to first remove the default
> window and then allocate the larger window advertised by firmware. Do
> this by abstracting out parts of remove_ddw into a function that does
> not assume an existing larger window has been created.
> 
> Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
> ---
>  arch/powerpc/platforms/pseries/iommu.c |   35 +++++++++++++++++++++++--------
>  1 files changed, 26 insertions(+), 9 deletions(-)
> 
> Is there a better way to get the default window's LIOBN than to call
> of_parse_dma_window?
> 
> diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
> index 01faab9..afcc04c 100644
> --- a/arch/powerpc/platforms/pseries/iommu.c
> +++ b/arch/powerpc/platforms/pseries/iommu.c
> @@ -655,6 +655,21 @@ static int __init disable_ddw_setup(char *str)
>  
>  early_param("disable_ddw", disable_ddw_setup);
>  
> +static void __remove_ddw(struct device_node *np, const u32 *ddw_avail, u64 liobn)
> +{
> +	int ret;
> +
> +	ret = rtas_call(ddw_avail[2], 1, 1, NULL, liobn);
> +	if (ret)
> +		pr_warning("%s: failed to remove direct window: rtas returned "
> +			"%d to ibm,remove-pe-dma-window(%x) %llx\n",
> +			np->full_name, ret, ddw_avail[2], liobn);
> +	else
> +		pr_debug("%s: successfully removed direct window: rtas returned "
> +			"%d to ibm,remove-pe-dma-window(%x) %llx\n",
> +			np->full_name, ret, ddw_avail[2], liobn);
> +}
> +
>  static void remove_ddw(struct device_node *np)
>  {
>  	struct dynamic_dma_window_prop *dwp;
> @@ -684,15 +699,7 @@ static void remove_ddw(struct device_node *np)
>  		pr_debug("%s successfully cleared tces in window.\n",
>  			 np->full_name);
>  
> -	ret = rtas_call(ddw_avail[2], 1, 1, NULL, liobn);
> -	if (ret)
> -		pr_warning("%s: failed to remove direct window: rtas returned "
> -			"%d to ibm,remove-pe-dma-window(%x) %llx\n",
> -			np->full_name, ret, ddw_avail[2], liobn);
> -	else
> -		pr_debug("%s: successfully removed direct window: rtas returned "
> -			"%d to ibm,remove-pe-dma-window(%x) %llx\n",
> -			np->full_name, ret, ddw_avail[2], liobn);
> +	__remove_ddw(np, ddw_avail, liobn);
>  
>  delprop:
>  	ret = prom_remove_property(np, win64);
> @@ -843,6 +850,8 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
>  	struct direct_window *window;
>  	struct property *win64;
>  	struct dynamic_dma_window_prop *ddwprop;
> +	const void *dma_window = NULL;
> +	unsigned long liobn, offset, size;
>  
>  	mutex_lock(&direct_window_init_mutex);
>  
> @@ -918,6 +927,14 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
>  		goto out_free_prop;
>  	}
>  
> +	/*
> +	 * To maximize the resources available to the create RTAS call,
> +	 * delete the existing DMA window
> +	 */
> +	dma_window = of_get_property(pdn, "ibm,dma-window", NULL);
> +	of_parse_dma_window(pdn, dma_window, &liobn, &offset, &size);
> +	__remove_ddw(pdn, ddw_avail, liobn);
> +
>  	ret = create_ddw(dev, ddw_avail, &create, page_shift, len);
>  	if (ret != 0)
>  		goto out_free_prop;
> -- 
> 1.7.5.4
> 
> 
> -- 
> Nishanth Aravamudan <nacc@us.ibm.com>
> IBM Linux Technology Center

-- 
Nishanth Aravamudan <nacc@us.ibm.com>
IBM Linux Technology Center
