Return-Path: <mkravetz@us.ibm.com>
Date: Wed, 13 Dec 2006 15:17:17 -0800
From: Mike Kravetz <kravetz@us.ibm.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: Bug: early_pfn_in_nid() called when not early
Message-ID: <20061213231717.GC10708@monkey.ibm.com>
References: <200612131920.59270.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200612131920.59270.arnd@arndb.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, hch@infradead.org,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Michael Kravetz <mkravetz@us.ibm.com>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Dec 13, 2006 at 07:20:57PM +0100, Arnd Bergmann wrote:
> After a lot of debugging in spufs, I found that a crash that we encountered
> on Cell actually was caused by a change in the memory management.
> 
> The patch that caused it is archived in http://lkml.org/lkml/2006/11/1/43,
> and this one has been discussed back and forth, but I fear that the current
> version may be broken for all setups that do memory hotplug with sparsemen
> and NUMA, at least on powerpc.

I believe you are correct.  At least the memory hotplug code for powerpc
is currently broken (caused crash!).

> - both early_pfn_{in,to}_nid and early_node_map are in the __init
>   section and may already have been freed at the time we are calling
>   memmap_init_zone().

Well that is the root of the problem for powerpc.  I believe that
__meminit attribute on memmap_init_zone() has no definition if
CONFIG_MEMORY_HOTPLUG is defined.  This is so that it can be called
after boot.  But, this also implies that memmap_init_zone() can not
call any routines in the __init section.

> The patch below is not a suggested fix that I want to get into mainline
> (checking slab_is_available is the wrong here), but it is a quick fix
> that you should apply if you want to run a recent (post-2.6.18) kernel
> on the IBM QS20 blade. I'm sorry for not having reported this earlier,
> but we were always trying to find the problem in my own code...

Thanks for the debug work!  Just curious if you really need
CONFIG_NODES_SPAN_OTHER_NODES defined for your platform?  Can you get
those types of memory layouts?  If not, an easy/immediate fix for you
might be to simply turn off the option.

> --- linux-2.6.orig/mm/page_alloc.c
> +++ linux-2.6/mm/page_alloc.c
> @@ -1962,7 +1962,8 @@ void __meminit memmap_init_zone(unsigned
>  	for (pfn = start_pfn; pfn < end_pfn; pfn++) {
>  		if (!early_pfn_valid(pfn))
>  			continue;
> -		if (!early_pfn_in_nid(pfn, nid))
> +		if (!slab_is_available() &&
> +		    !early_pfn_in_nid(pfn, nid))
>  			continue;
>  		page = pfn_to_page(pfn);
>  		set_page_links(page, zone, nid, pfn);

I know you don't recommend this as a fix, but it has the interesting
quality of doing exactly what we want for powerpc.  When
slab_is_available() we are performing a 'memory add' operation
and there is no need to do the 'pfn_in_nid' check.  We know that
the range of added pages will all be on the same (passed) nid.

-- 
Mike
