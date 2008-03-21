Return-Path: <y-goto@jp.fujitsu.com>
Received: from fgwmail7.fujitsu.co.jp (fgwmail7.fujitsu.co.jp [192.51.44.37])
	by ozlabs.org (Postfix) with ESMTP id 1D473DDF23
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Mar 2008 02:26:27 +1100 (EST)
Date: Sat, 22 Mar 2008 00:25:48 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Badari Pulavarty <pbadari@us.ibm.com>
Subject: Re: [PATCH 1/5] generic __remove_pages() support
In-Reply-To: <1204829734.7939.61.camel@dyn9047017100.beaverton.ibm.com>
References: <1204829673.7939.59.camel@dyn9047017100.beaverton.ibm.com>
	<1204829734.7939.61.camel@dyn9047017100.beaverton.ibm.com>
Message-Id: <20080321235322.2B17.E1E9C6FF@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	paulus@samba.org, lkml <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Badari-san.

> Index: linux-2.6.25-rc2/mm/memory_hotplug.c
> ===================================================================
> --- linux-2.6.25-rc2.orig/mm/memory_hotplug.c	2008-02-27 12:58:17.000000000 -0800
> +++ linux-2.6.25-rc2/mm/memory_hotplug.c	2008-02-27 16:06:50.000000000 -0800
> @@ -102,6 +102,21 @@ static int __add_section(struct zone *zo
>  	return register_new_memory(__pfn_to_section(phys_start_pfn));
>  }
>  
> +static int __remove_section(struct zone *zone, struct mem_section *ms)
> +{
> +	int ret = -EINVAL;
> +
> +	if (!valid_section(ms))
> +		return ret;
> +
> +	ret = unregister_memory_section(ms);
> +	if (ret)
> +		return ret;
> +
> +	sparse_remove_one_section(zone, ms);
> +	return 0;
> +}
> +
>  /*
>   * Reasonably generic function for adding memory.  It is
>   * expected that archs that support memory hotplug will
> @@ -135,6 +150,35 @@ int __add_pages(struct zone *zone, unsig
>  }
>  EXPORT_SYMBOL_GPL(__add_pages);
>  
> +int __remove_pages(struct zone *zone, unsigned long phys_start_pfn,
> +		 unsigned long nr_pages)
> +{
> +	unsigned long i, ret = 0;
> +	int sections_to_remove;
> +	unsigned long flags;
> +	struct pglist_data *pgdat = zone->zone_pgdat;
> +
> +	/*
> +	 * We can only remove entire sections
> +	 */
> +	BUG_ON(phys_start_pfn & ~PAGE_SECTION_MASK);
> +	BUG_ON(nr_pages % PAGES_PER_SECTION);
> +
> +	release_mem_region(phys_start_pfn << PAGE_SHIFT, nr_pages * PAGE_SIZE);
> +
> +	sections_to_remove = nr_pages / PAGES_PER_SECTION;
> +	for (i = 0; i < sections_to_remove; i++) {
> +		unsigned long pfn = phys_start_pfn + i*PAGES_PER_SECTION;
> +		pgdat_resize_lock(pgdat, &flags);
> +		ret = __remove_section(zone, __pfn_to_section(pfn));
> +		pgdat_resize_unlock(pgdat, &flags);
> +		if (ret)
> +			break;
> +	}
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(__remove_pages);

Here may be a bug.
__remove_section() is called with pgdat_resize_lock() which is
spin_lock_irqsave().

  __remove_section()
      |
      +--> unregister_memory_section()
              |
              +--> remove_memory_block()
                      |
                      +--> unregister_memory()
                             |
                             +--> sysdev_unregister()

sysdev_unregister() calls mutex_lock().
It might sleep with irq disable, right?
I found BUG()'s messages by this.

Bye.

-- 
Yasunori Goto 
