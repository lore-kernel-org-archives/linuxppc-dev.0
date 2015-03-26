Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0B2FD1A0688
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2015 15:49:28 +1100 (AEDT)
In-Reply-To: <1424909087-2819-1-git-send-email-olson@cumulusnetworks.com>
To: Dave Olson <olson@cumulusnetworks.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [v3] Fix missing L2 cache size in /sys/devices/system/cpu
Message-Id: <20150326044927.EAD4D1400B7@ozlabs.org>
Date: Thu, 26 Mar 2015 15:49:27 +1100 (AEDT)
Cc: Dave Olson <olson@cumulusnetworks.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-26-02 at 00:04:47 UTC, Dave Olson wrote:
> @@ -324,14 +335,33 @@ static bool cache_node_is_unified(const struct device_node *np)
>  	return of_get_property(np, "cache-unified", NULL);
>  }
>  
> +/*
> + * Handle unified caches that have two different types of tags.  Most embedded
> + * use cache-size, etc. for the unified cache size, but open firmware systems
> + * use d-cache-size, etc.   Since they all appear to be consistent, check on
> + * initialization for which type we are, and use the appropriate structure.
> + */
>  static struct cache *cache_do_one_devnode_unified(struct device_node *node,
>  						  int level)
>  {
>  	struct cache *cache;
> +	int ucache;
>  
>  	pr_debug("creating L%d ucache for %s\n", level, node->full_name);
>  
>  	cache = new_cache(CACHE_TYPE_UNIFIED, level, node);
        ^^

> +	if (of_get_property(node,
> +		cache_type_info[CACHE_TYPE_UNIFIED_D].size_prop, NULL)) {
> +		ucache = CACHE_TYPE_UNIFIED_D;
> +	} else {
> +		ucache = CACHE_TYPE_UNIFIED; /* assume embedded */
> +		if (of_get_property(node,
> +			cache_type_info[CACHE_TYPE_UNIFIED].size_prop, NULL) ==
> +			NULL)
> +			printk(KERN_WARNING "Unified cache property missing\n");
> +	}
> +
> +	cache = new_cache(ucache, level, node);
        ^^
>  
>  	return cache;
>  }

That looks fishy. You create a cache, and then throw it away and create another
one and return that. I don't think that's what you intended, is it?

It would also be cleaner I think if you created another helper, eg.
cache_is_unified_d() to do the property lookup.

And also I don't think you need to do the second property lookup, especially if
all you're going to do is print a warning.

cheers
