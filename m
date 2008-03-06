Return-Path: <pbadari@us.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B7BA5DE253
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Mar 2008 06:25:55 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m26JPpXH012550
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Mar 2008 14:25:51 -0500
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m26JPphk220274
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Mar 2008 12:25:51 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m26JPovc023836
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Mar 2008 12:25:51 -0700
Subject: Re: [PATCH 1/5] generic __remove_pages() support
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Randy Dunlap <randy.dunlap@oracle.com>
In-Reply-To: <20080306110847.11d7cb26.randy.dunlap@oracle.com>
References: <1204829673.7939.59.camel@dyn9047017100.beaverton.ibm.com>
	<1204829734.7939.61.camel@dyn9047017100.beaverton.ibm.com>
	<20080306110847.11d7cb26.randy.dunlap@oracle.com>
Content-Type: text/plain
Date: Thu, 06 Mar 2008 11:29:11 -0800
Message-Id: <1204831751.6272.6.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	paulus@samba.org, lkml <linux-kernel@vger.kernel.org>,
	Yasunori Goto <y-goto@jp.fujitsu.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-03-06 at 11:08 -0800, Randy Dunlap wrote:
> On Thu, 06 Mar 2008 10:55:34 -0800 Badari Pulavarty wrote:
> 
> > Generic helper function to remove section mappings and sysfs entries
> > for the section of the memory we are removing.  offline_pages() correctly 
> > adjusted zone and marked the pages reserved.
> 
> Such generic (exported, non-static) interfaces could use some
> (kernel-)docs, please.

Sure. Will do.

> > Issue: If mem_map, usemap allocation could come from different places -
> > kmalloc, vmalloc, alloc_pages or bootmem. There is no easy way
> > to find and free up bootmem allocations.
> > 
> > Signed-off-by: Badari Pulavarty <pbadari@us.ibm.com>
> > 
> > ---
> >  include/linux/memory_hotplug.h |    4 +++
> >  mm/memory_hotplug.c            |   44 +++++++++++++++++++++++++++++++++++++++++
> >  mm/sparse.c                    |   43 +++++++++++++++++++++++++++++++++++++---
> >  3 files changed, 88 insertions(+), 3 deletions(-)
> 
> > Index: linux-2.6.25-rc2/include/linux/memory_hotplug.h
> > ===================================================================
> > --- linux-2.6.25-rc2.orig/include/linux/memory_hotplug.h	2008-02-27 12:58:17.000000000 -0800
> > +++ linux-2.6.25-rc2/include/linux/memory_hotplug.h	2008-02-27 13:00:04.000000000 -0800
> > @@ -64,6 +65,8 @@ extern int offline_pages(unsigned long, 
> >  /* reasonably generic interface to expand the physical pages in a zone  */
> >  extern int __add_pages(struct zone *zone, unsigned long start_pfn,
> >  	unsigned long nr_pages);
> > +extern int __remove_pages(struct zone *zone, unsigned long start_pfn,
> > +	unsigned long nr_pages);
> >  
> >  /*
> >   * Walk thorugh all memory which is registered as resource.
> 
>            through :)

I will fix that.

Thanks,
Badari
