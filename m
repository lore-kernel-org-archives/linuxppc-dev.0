Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xdn2B10zYzDrJy
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Aug 2017 13:38:42 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, mikey@neuling.org,
 stewart@linux.vnet.ibm.com, apopple@au1.ibm.com, hbabu@us.ibm.com,
 oohall@gmail.com, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 04/12] powerpc/vas: Define helpers to access MMIO
 regions
In-Reply-To: <1503556688-15412-5-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1503556688-15412-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1503556688-15412-5-git-send-email-sukadev@linux.vnet.ibm.com>
Date: Fri, 25 Aug 2017 13:38:39 +1000
Message-ID: <87efs0uxj4.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Suka,

Comments inline.

Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com> writes:
> diff --git a/arch/powerpc/platforms/powernv/vas-window.c b/arch/powerpc/platforms/powernv/vas-window.c
> index 6156fbe..a3a705a 100644
> --- a/arch/powerpc/platforms/powernv/vas-window.c
> +++ b/arch/powerpc/platforms/powernv/vas-window.c
> @@ -9,9 +9,182 @@
>  
>  #include <linux/types.h>
>  #include <linux/mutex.h>
> +#include <linux/slab.h>
> +#include <linux/io.h>
>  
>  #include "vas.h"
>  
> +/*
> + * Compute the paste address region for the window @window using the
> + * ->paste_base_addr and ->paste_win_id_shift we got from device tree.
> + */
> +void compute_paste_address(struct vas_window *window, uint64_t *addr, int *len)
> +{
> +	uint64_t base, shift;

Please use the kernel types, so u64 here.

> +	int winid;
> +
> +	base = window->vinst->paste_base_addr;
> +	shift = window->vinst->paste_win_id_shift;
> +	winid = window->winid;
> +
> +	*addr  = base + (winid << shift);
> +	if (len)
> +		*len = PAGE_SIZE;

Having multiple output parameters makes for a pretty awkward API. Is it
really necesssary given len is a constant PAGE_SIZE anyway.

If you didn't return len, then you could just make the function return
the addr, and you wouldn't need any output parameters.

One of the callers that passes len is unmap_paste_region(), but that
is a bit odd. It would be more natural I think if once a window is
mapped it knows its size. Or if the mapping will always just be one page
then we can just know that.

> +
> +	pr_debug("Txwin #%d: Paste addr 0x%llx\n", winid, *addr);
> +}
> +
> +static inline void get_hvwc_mmio_bar(struct vas_window *window,
> +			uint64_t *start, int *len)
> +{
> +	uint64_t pbaddr;
> +
> +	pbaddr = window->vinst->hvwc_bar_start;
> +	*start = pbaddr + window->winid * VAS_HVWC_SIZE;
> +	*len = VAS_HVWC_SIZE;

This is:

#define VAS_HVWC_SIZE			512

But then we map it, which will round up to a page anyway. So again I
don't see the point of having the len returned form this helper.

> +}
> +
> +static inline void get_uwc_mmio_bar(struct vas_window *window,
> +			uint64_t *start, int *len)
> +{
> +	uint64_t pbaddr;
> +
> +	pbaddr = window->vinst->uwc_bar_start;
> +	*start = pbaddr + window->winid * VAS_UWC_SIZE;
> +	*len = VAS_UWC_SIZE;
> +}
> +
> +/*
> + * Map the paste bus address of the given send window into kernel address
> + * space. Unlike MMIO regions (map_mmio_region() below), paste region must
> + * be mapped cache-able and is only applicable to send windows.
> + */
> +void *map_paste_region(struct vas_window *txwin)
> +{
> +	int rc, len;
> +	void *map;
> +	char *name;
> +	uint64_t start;
> +
> +	rc = -ENOMEM;

You don't need that.

> +	name = kasprintf(GFP_KERNEL, "window-v%d-w%d", txwin->vinst->vas_id,
> +				txwin->winid);
> +	if (!name)
> +		return ERR_PTR(rc);

That can goto free_name;

> +
> +	txwin->paste_addr_name = name;
> +	compute_paste_address(txwin, &start, &len);
> +
> +	if (!request_mem_region(start, len, name)) {
> +		pr_devel("%s(): request_mem_region(0x%llx, %d) failed\n",
> +				__func__, start, len);
> +		goto free_name;
> +	}
> +
> +	map = ioremap_cache(start, len);
> +	if (!map) {
> +		pr_devel("%s(): ioremap_cache(0x%llx, %d) failed\n", __func__,
> +				start, len);
> +		goto free_name;
> +	}
> +
> +	pr_devel("VAS: mapped paste addr 0x%llx to kaddr 0x%p\n", start, map);
> +	return map;
> +
> +free_name:
> +	kfree(name);

Because kfree(NULL) is fine.

> +	return ERR_PTR(rc);

And that can just return ERR_PTR(-ENOMEM);

> +}

cheers
