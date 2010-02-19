Return-Path: <cl@linux-foundation.org>
Received: from nlpi129.prodigy.net (nlpi129.sbcis.sbc.com [207.115.36.143])
	by ozlabs.org (Postfix) with ESMTP id 9B634B7D00
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 20 Feb 2010 02:51:46 +1100 (EST)
Date: Fri, 19 Feb 2010 09:51:12 -0600 (CST)
From: Christoph Lameter <cl@linux-foundation.org>
To: Balbir Singh <balbir@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc: Set a smaller value for RECLAIM_DISTANCE to
	enable zone reclaim
In-Reply-To: <661de9471002190741k34ddb1acidf64d089bf9ff284@mail.gmail.com>
Message-ID: <alpine.DEB.2.00.1002190948200.26567@router.home>
References: <20100218222923.GC31681@kryten> <20100219000730.GD31681@kryten>
	<20100219145523.GN30258@csn.ul.ie>
	<alpine.DEB.2.00.1002190906190.7486@router.home>
	<661de9471002190741k34ddb1acidf64d089bf9ff284@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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

On Fri, 19 Feb 2010, Balbir Singh wrote:

> >> zone_reclaim. The others back off and try the next zone in the zonelist
> >> instead. I'm not sure what the original intention was but most likely it
> >> was to prevent too many parallel reclaimers in the same zone potentially
> >> dumping out way more data than necessary.
> >
> > Yes it was to prevent concurrency slowing down reclaim. At that time the
> > number of processors per NUMA node was 2 or so. The number of pages that
> > are reclaimed is limited to avoid tossing too many page cache pages.
> >
>
> That is interesting, I always thought it was to try and free page
> cache first. For example with zone->min_unmapped_pages, if
> zone_pagecache_reclaimable is greater than unmapped pages, we start
> reclaim the cached pages first. The min_unmapped_pages almost sounds
> like the higher level watermark - or am I misreading the code.

Indeed the purpose is to free *old* page cache pages.

The min_unmapped_pages is to protect a mininum of the page cache pages /
fs metadata from zone reclaim so that ongoing file I/O is not impacted.
