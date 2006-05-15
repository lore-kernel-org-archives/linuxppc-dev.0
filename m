Return-Path: <kamezawa.hiroyu@jp.fujitsu.com>
Received: from fgwmail6.fujitsu.co.jp (fgwmail6.fujitsu.co.jp [192.51.44.36])
	by ozlabs.org (Postfix) with ESMTP id 3498767A01
	for <linuxppc-dev@ozlabs.org>; Mon, 15 May 2006 20:46:17 +1000 (EST)
Date: Mon, 15 May 2006 19:47:35 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: [PATCH 5/6] Have ia64 use add_active_range() and
	free_area_init_nodes
Message-Id: <20060515194735.0858b7c9.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060515192918.c3e2e895.kamezawa.hiroyu@jp.fujitsu.com>
References: <20060508141030.26912.93090.sendpatchset@skynet>
	<20060508141211.26912.48278.sendpatchset@skynet>
	<20060514203158.216a966e.akpm@osdl.org>
	<44683A09.2060404@shadowen.org> <44685123.7040501@yahoo.com.au>
	<446855AF.1090100@shadowen.org>
	<20060515192918.c3e2e895.kamezawa.hiroyu@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: akpm@osdl.org, nickpiggin@yahoo.com.au, tony.luck@intel.com,
	davej@codemonkey.org.uk, mel@csn.ul.ie,
	linux-kernel@vger.kernel.org, bob.picco@hp.com, ak@suse.de,
	linuxppc-dev@ozlabs.org, linux-mm@kvack.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 15 May 2006 19:29:18 +0900
KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> wrote:

> On Mon, 15 May 2006 11:19:27 +0100
> Andy Whitcroft <apw@shadowen.org> wrote:
> 
> > Nick Piggin wrote:
> > > Andy Whitcroft wrote:
> > > 
> > >> Interesting.  You are correct there was no config component, at the time
> > >> I didn't have direct evidence that any architecture needed it, only that
> > >> we had an unchecked requirement on zones, a requirement that had only
> > >> recently arrived with the changes to free buddy detection.  I note that
> > > 
> > > 
> > > Recently arrived? Over a year ago with the no-buddy-bitmap patches,
> > > right? Just checking because I that's what I'm assuming broke it...
> > 
> > Yep, sorry I forget I was out of the game for 6 months!  And yes that
> > was when the requirements were altered.
> > 
> When no-bitmap-buddy patches was included,
> 
> 1. bad_range() is not covered by CONFIG_VM_DEBUG. It always worked.
> ==
> static int bad_range(struct zone *zone, struct page *page)
> {
>         if (page_to_pfn(page) >= zone->zone_start_pfn + zone->spanned_pages)
>                 return 1;
>         if (page_to_pfn(page) < zone->zone_start_pfn)
>                 return 1;
> ==
> And , this code
> ==
>                 buddy = __page_find_buddy(page, page_idx, order);
> 
>                 if (bad_range(zone, buddy))
>                         break;
> ==
> 
> checked whether buddy is in zone and guarantees it to have page struct.
> 
> 
> But clean-up/speed-up codes vanished these checks. (I don't know when this occurs)
> Sorry for misses these things.
> 

One more point
When above no-bitmap patches was included, the user of not-aligned zones
are only ia64, I think. Because ia64 used virtual mem_map, page_to_pfn(page)
on  CONFIG_DISCONTIG_MEM doesn't access page struct itself. 

#define page_to_pfn(page)	(page - vmemmap)

So, it didn't  panic. ia64/vmemmap was safe.

If other archs used not-aligned zone + CONFIG_DISCONTIGMEM,
not-aligned-zones problem would come out earlier.

-Kame
