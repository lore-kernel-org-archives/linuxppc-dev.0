Return-Path: <balbir@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp08.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7A170B7C33
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 20 Feb 2010 04:39:35 +1100 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp08.au.ibm.com (8.14.3/8.13.1) with ESMTP id o1JHdZGA010417
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Feb 2010 04:39:35 +1100
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o1JHYBW4823356
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Feb 2010 04:34:11 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o1JHdYdM005134
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Feb 2010 04:39:34 +1100
Date: Fri, 19 Feb 2010 23:09:32 +0530
From: Balbir Singh <balbir@linux.vnet.ibm.com>
To: Christoph Lameter <cl@linux-foundation.org>
Subject: Re: [PATCH] powerpc: Set a smaller value for RECLAIM_DISTANCE to
	enable zone reclaim
Message-ID: <20100219173932.GX5612@balbir.in.ibm.com>
References: <20100218222923.GC31681@kryten> <20100219000730.GD31681@kryten>
	<20100219145523.GN30258@csn.ul.ie>
	<alpine.DEB.2.00.1002190906190.7486@router.home>
	<661de9471002190741k34ddb1acidf64d089bf9ff284@mail.gmail.com>
	<alpine.DEB.2.00.1002190948200.26567@router.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <alpine.DEB.2.00.1002190948200.26567@router.home>
Cc: Mel Gorman <mel@csn.ul.ie>, linuxppc-dev@lists.ozlabs.org,
	Anton Blanchard <anton@samba.org>
Reply-To: balbir@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Christoph Lameter <cl@linux-foundation.org> [2010-02-19 09:51:12]:

> On Fri, 19 Feb 2010, Balbir Singh wrote:
> 
> > >> zone_reclaim. The others back off and try the next zone in the zonelist
> > >> instead. I'm not sure what the original intention was but most likely it
> > >> was to prevent too many parallel reclaimers in the same zone potentially
> > >> dumping out way more data than necessary.
> > >
> > > Yes it was to prevent concurrency slowing down reclaim. At that time the
> > > number of processors per NUMA node was 2 or so. The number of pages that
> > > are reclaimed is limited to avoid tossing too many page cache pages.
> > >
> >
> > That is interesting, I always thought it was to try and free page
> > cache first. For example with zone->min_unmapped_pages, if
> > zone_pagecache_reclaimable is greater than unmapped pages, we start
> > reclaim the cached pages first. The min_unmapped_pages almost sounds
> > like the higher level watermark - or am I misreading the code.
> 
> Indeed the purpose is to free *old* page cache pages.
> 
> The min_unmapped_pages is to protect a mininum of the page cache pages /
> fs metadata from zone reclaim so that ongoing file I/O is not impacted.

Thanks for the explanation!

-- 
	Three Cheers,
	Balbir
