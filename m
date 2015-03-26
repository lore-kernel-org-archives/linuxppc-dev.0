Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 553C41A04A3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Mar 2015 10:39:57 +1100 (AEDT)
Message-ID: <1427413196.23142.1.camel@ellerman.id.au>
Subject: Re: [v3] Fix missing L2 cache size in /sys/devices/system/cpu
From: Michael Ellerman <mpe@ellerman.id.au>
To: Dave Olson <olson@cumulusnetworks.com>
Date: Fri, 27 Mar 2015 10:39:56 +1100
In-Reply-To: <20150326194914.GC23655@cumulusnetworks.com>
References: <1424909087-2819-1-git-send-email-olson@cumulusnetworks.com>
 <20150326044927.EAD4D1400B7@ozlabs.org>
 <20150326194914.GC23655@cumulusnetworks.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-03-26 at 12:49 -0700, Dave Olson wrote:
> Michael Ellerman <mpe@ellerman.id.au> wrote:
> 
> > On Thu, 2015-26-02 at 00:04:47 UTC, Dave Olson wrote:
> > > @@ -324,14 +335,33 @@ static bool cache_node_is_unified(const struct device_node *np)
> > >  	return of_get_property(np, "cache-unified", NULL);
> > >  }
> > >  
> > > +/*
> > > + * Handle unified caches that have two different types of tags.  Most embedded
> > > + * use cache-size, etc. for the unified cache size, but open firmware systems
> > > + * use d-cache-size, etc.   Since they all appear to be consistent, check on
> > > + * initialization for which type we are, and use the appropriate structure.
> > > + */
> > >  static struct cache *cache_do_one_devnode_unified(struct device_node *node,
> > >  						  int level)
> > >  {
> > >  	struct cache *cache;
> > > +	int ucache;
> > >  
> > >  	pr_debug("creating L%d ucache for %s\n", level, node->full_name);
> > >  
> > >  	cache = new_cache(CACHE_TYPE_UNIFIED, level, node);
> >         ^^
> > 
> > > +	if (of_get_property(node,
> > > +		cache_type_info[CACHE_TYPE_UNIFIED_D].size_prop, NULL)) {
> > > +		ucache = CACHE_TYPE_UNIFIED_D;
> > > +	} else {
> > > +		ucache = CACHE_TYPE_UNIFIED; /* assume embedded */
> > > +		if (of_get_property(node,
> > > +			cache_type_info[CACHE_TYPE_UNIFIED].size_prop, NULL) ==
> > > +			NULL)
> > > +			printk(KERN_WARNING "Unified cache property missing\n");
> > > +	}
> > > +
> > > +	cache = new_cache(ucache, level, node);
> >         ^^
> > >  
> > >  	return cache;
> > >  }
> > 
> > That looks fishy. You create a cache, and then throw it away and create another
> > one and return that. I don't think that's what you intended, is it?
> 
> It looks like I missed something when I regenerated the patch, yes.
> My version of cacheinfo.c doesn't have the first new_cache() call.
 
OK, not sure how you did that. I recommend using git to generate the patch.

> > And also I don't think you need to do the second property lookup, especially if
> > all you're going to do is print a warning.
> 
> I wanted to make sure that if a similar issue arose in the future, that
> a message was printed so it got caught and fixed.  I don't see a way
> to do that without the 2nd lookup.

That's an admirable goal but I don't think that's the right way to catch it. If
it's important then someone needs to be testing the end result, ie. the
contents of /sys/devices/system/cpu/*/cache.

Also a single printk is never going to get noticed in the boot log, unless
someone's already looking for it.

cheers
