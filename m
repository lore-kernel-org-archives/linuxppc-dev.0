Return-Path: <jk@bilbo.ozlabs.org>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 84578DDD04
	for <linuxppc-dev@ozlabs.org>; Tue,  5 May 2009 11:24:52 +1000 (EST)
From: Jeremy Kerr <jk@ozlabs.org>
To: linuxppc-dev@ozlabs.org
Subject: Re: [Patch] powerpc/cell: make ptcal more reliable
Date: Tue, 5 May 2009 10:57:18 +1000
References: <87iqkgd5qm.fsf@de.ibm.com>
In-Reply-To: <87iqkgd5qm.fsf@de.ibm.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200905051057.19562.jk@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Gerhard,

> This is for QS21. The following patch allocates pages only from
> the specified node, moves the ptcal area into the middle of the
> allocated page to avoid potential prefetch problems and prints
> the address of the ptcal area to facilitate diagnostics.

You're seeing prefetches that cross a page boundary?

> -	area->pages = alloc_pages_node(area->nid, GFP_KERNEL, area->order);
> +	area->pages = alloc_pages_node(area->nid, GFP_KERNEL |
> GFP_THISNODE, area->order);

Best to keep this under 80 cols.

>
> -	if (!area->pages)
> +	if (!area->pages) {
> +		printk(KERN_INFO "%s: no page on node %d\n",
> +			__FUNCTION__, area->nid);
>  		goto out_free_area;
> +	}

That could probably be a KERN_ERR, as we don't have ptcal enabled on 
that node. Also, I believe __func__ is preferred over __FUNCTION__.

> -	addr = __pa(page_address(area->pages));
> +	/*
> +	 * We move the ptcal area to the middle of the allocated
> +	 * page, in order to avoid prefetches in memcpy and similar
> +	 * functions stepping on it.
> +	 */
> +	addr = __pa(page_address(area->pages)) + (PAGE_SIZE >> 1);

Minor nitpick, but I think (PAGE_SIZE / 2) better illustrates that 
you're putting the addr in the middle of the page. But either should be 
fine.

> +	printk(KERN_INFO "%s: enabling PTCAL on node %d address=0x%016lx
> PAGE_SIZE>>1=0x%016lx \n",
> +			__FUNCTION__, area->nid, addr, PAGE_SIZE>>1);

80 cols again. Can we do this as a pr_debug?

Cheers,

Jeremy
