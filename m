Return-Path: <nickpiggin@yahoo.com.au>
Received: from smtp102.mail.mud.yahoo.com (smtp102.mail.mud.yahoo.com
	[209.191.85.212]) by ozlabs.org (Postfix) with SMTP id 1B902679F4
	for <linuxppc-dev@ozlabs.org>; Tue, 16 May 2006 10:32:06 +1000 (EST)
Message-ID: <44691D7C.5060208@yahoo.com.au>
Date: Tue, 16 May 2006 10:31:56 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
MIME-Version: 1.0
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: [PATCH 5/6] Have ia64 use add_active_range() and
	free_area_init_nodes
References: <20060508141030.26912.93090.sendpatchset@skynet>	<20060508141211.26912.48278.sendpatchset@skynet>	<20060514203158.216a966e.akpm@osdl.org>	<44683A09.2060404@shadowen.org>	<44685123.7040501@yahoo.com.au>	<446855AF.1090100@shadowen.org>
	<20060515192918.c3e2e895.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060515192918.c3e2e895.kamezawa.hiroyu@jp.fujitsu.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: akpm@osdl.org, davej@codemonkey.org.uk, tony.luck@intel.com,
	linuxppc-dev@ozlabs.org, mel@csn.ul.ie,
	linux-kernel@vger.kernel.org, bob.picco@hp.com, ak@suse.de,
	linux-mm@kvack.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

KAMEZAWA Hiroyuki wrote:

>On Mon, 15 May 2006 11:19:27 +0100
>Andy Whitcroft <apw@shadowen.org> wrote:
>
>>>
>>>Recently arrived? Over a year ago with the no-buddy-bitmap patches,
>>>right? Just checking because I that's what I'm assuming broke it...
>>>
>>Yep, sorry I forget I was out of the game for 6 months!  And yes that
>>was when the requirements were altered.
>>
>>
>When no-bitmap-buddy patches was included,
>
>1. bad_range() is not covered by CONFIG_VM_DEBUG. It always worked.
>==
>static int bad_range(struct zone *zone, struct page *page)
>{
>        if (page_to_pfn(page) >= zone->zone_start_pfn + zone->spanned_pages)
>                return 1;
>        if (page_to_pfn(page) < zone->zone_start_pfn)
>                return 1;
>==
>And , this code
>==
>                buddy = __page_find_buddy(page, page_idx, order);
>
>                if (bad_range(zone, buddy))
>                        break;
>==
>
>checked whether buddy is in zone and guarantees it to have page struct.
>

Ah, my mistake indeed. Sorry.

>But clean-up/speed-up codes vanished these checks. (I don't know when this occurs)
>Sorry for misses these things.
>

I think if anything they should be moved into page_is_buddy, however 
page_to_pfn
is expensive on some architectures, so it is something we want to be 
able to opt
out of if we do the correct alignment.

--
Send instant messages to your online friends http://au.messenger.yahoo.com 
