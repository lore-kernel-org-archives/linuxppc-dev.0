Return-Path: <rcjenn@austin.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e8.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9EB25B7B8F
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Oct 2009 07:23:08 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e8.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n99KKNgL012810
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Oct 2009 16:20:23 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n99KN5Wq255888
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Oct 2009 16:23:05 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n99KJe1V013729
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Oct 2009 16:19:41 -0400
Date: Fri, 9 Oct 2009 15:23:04 -0500
From: Robert Jennings <rcj@linux.vnet.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/2][v2] mm: add notifier in pageblock isolation for
	balloon drivers
Message-ID: <20091009202304.GB19114@austin.ibm.com>
References: <20091002184458.GC4908@austin.ibm.com>
	<20091008163449.00dce972.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20091008163449.00dce972.akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, Mel Gorman <mel@csn.ul.ie>,
	Gerald Schaefer <geralds@linux.vnet.ibm.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Badari Pulavarty <pbadari@us.ibm.com>,
	Brian King <brking@linux.vnet.ibm.com>,
	Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>,
	KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Andrew Morton (akpm@linux-foundation.org) wrote:
> On Fri, 2 Oct 2009 13:44:58 -0500
> Robert Jennings <rcj@linux.vnet.ibm.com> wrote:
> 
> > Memory balloon drivers can allocate a large amount of memory which
> > is not movable but could be freed to accomodate memory hotplug remove.
> > 
> > Prior to calling the memory hotplug notifier chain the memory in the
> > pageblock is isolated.  If the migrate type is not MIGRATE_MOVABLE the
> > isolation will not proceed, causing the memory removal for that page
> > range to fail.
> > 
> > Rather than failing pageblock isolation if the the migrateteype is not
> > MIGRATE_MOVABLE, this patch checks if all of the pages in the pageblock
> > are owned by a registered balloon driver (or other entity) using a
> > notifier chain.  If all of the non-movable pages are owned by a balloon,
> > they can be freed later through the memory notifier chain and the range
> > can still be isolated in set_migratetype_isolate().
> 
> The patch looks sane enough to me.
> 
> I expect that if the powerpc and s390 guys want to work on CMM over the
> next couple of months, they'd like this patch merged into 2.6.32.  It's
> a bit larger and more involved than one would like, but I guess we can
> do that if suitable people (Mel?  Kamezawa?) have had a close look and
> are OK with it.
>
> What do people think?

I'd love to get it in 2.6.32 if that's possible.  I have gone over the 
comments from Mel and Kamezawa I produced a new patchset.  I just
finished testing it (and I also tested with
CONFIG_MEMORY_HOTPLUG_SPARSE=n) and it will be posted shortly.

> 
> Has it been carefully compile- and run-time tested with
> CONFIG_MEMORY_HOTPLUG_SPARSE=n?

Yes, I have compiled the kernel CONFIG_MEMORY_HOTPLUG_SPARSE=n and made
sure that we didn't have any problems.

--Robert Jennings
