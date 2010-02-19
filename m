Return-Path: <bsingharora@gmail.com>
Received: from mail-px0-f189.google.com (mail-px0-f189.google.com
	[209.85.216.189]) by ozlabs.org (Postfix) with ESMTP id 38696B7C98
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 20 Feb 2010 02:41:29 +1100 (EST)
Received: by pxi27 with SMTP id 27so287381pxi.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 19 Feb 2010 07:41:27 -0800 (PST)
MIME-Version: 1.0
Sender: bsingharora@gmail.com
In-Reply-To: <alpine.DEB.2.00.1002190906190.7486@router.home>
References: <20100218222923.GC31681@kryten> <20100219000730.GD31681@kryten>
	<20100219145523.GN30258@csn.ul.ie>
	<alpine.DEB.2.00.1002190906190.7486@router.home>
Date: Fri, 19 Feb 2010 21:11:27 +0530
Message-ID: <661de9471002190741k34ddb1acidf64d089bf9ff284@mail.gmail.com>
Subject: Re: [PATCH] powerpc: Set a smaller value for RECLAIM_DISTANCE to
	enable zone reclaim
From: Balbir Singh <balbir@linux.vnet.ibm.com>
To: Christoph Lameter <cl@linux-foundation.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Mel Gorman <mel@csn.ul.ie>, linuxppc-dev@lists.ozlabs.org,
	Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Feb 19, 2010 at 8:42 PM, Christoph Lameter
<cl@linux-foundation.org> wrote:
> On Fri, 19 Feb 2010, Mel Gorman wrote:
>
>> > > The patch below sets a smaller value for RECLAIM_DISTANCE and thus e=
nables
>> > > zone reclaim.
>> >
>>
>> I've no problem with the patch anyway.
>
> Nor do I.
>
>> > - We seem to end up racing between zone_watermark_ok, zone_reclaim and
>> > =A0 buffered_rmqueue. Since everyone is in here the memory one thread =
reclaims
>> > =A0 may be stolen by another thread.
>> >
>>
>> You're pretty much on the button here. Only one thread at a time enters
>> zone_reclaim. The others back off and try the next zone in the zonelist
>> instead. I'm not sure what the original intention was but most likely it
>> was to prevent too many parallel reclaimers in the same zone potentially
>> dumping out way more data than necessary.
>
> Yes it was to prevent concurrency slowing down reclaim. At that time the
> number of processors per NUMA node was 2 or so. The number of pages that
> are reclaimed is limited to avoid tossing too many page cache pages.
>

That is interesting, I always thought it was to try and free page
cache first. For example with zone->min_unmapped_pages, if
zone_pagecache_reclaimable is greater than unmapped pages, we start
reclaim the cached pages first. The min_unmapped_pages almost sounds
like the higher level watermark - or am I misreading the code.

Balbir Singh
