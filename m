Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E8215B7B77
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Oct 2009 10:35:35 +1100 (EST)
Date: Thu, 8 Oct 2009 16:34:49 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Robert Jennings <rcj@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2][v2] mm: add notifier in pageblock isolation for
	balloon drivers
Message-Id: <20091008163449.00dce972.akpm@linux-foundation.org>
In-Reply-To: <20091002184458.GC4908@austin.ibm.com>
References: <20091002184458.GC4908@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-mm@kvack.org, Mel Gorman <mel@csn.ul.ie>,
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

On Fri, 2 Oct 2009 13:44:58 -0500
Robert Jennings <rcj@linux.vnet.ibm.com> wrote:

> Memory balloon drivers can allocate a large amount of memory which
> is not movable but could be freed to accomodate memory hotplug remove.
> 
> Prior to calling the memory hotplug notifier chain the memory in the
> pageblock is isolated.  If the migrate type is not MIGRATE_MOVABLE the
> isolation will not proceed, causing the memory removal for that page
> range to fail.
> 
> Rather than failing pageblock isolation if the the migrateteype is not
> MIGRATE_MOVABLE, this patch checks if all of the pages in the pageblock
> are owned by a registered balloon driver (or other entity) using a
> notifier chain.  If all of the non-movable pages are owned by a balloon,
> they can be freed later through the memory notifier chain and the range
> can still be isolated in set_migratetype_isolate().

The patch looks sane enough to me.

I expect that if the powerpc and s390 guys want to work on CMM over the
next couple of months, they'd like this patch merged into 2.6.32.  It's
a bit larger and more involved than one would like, but I guess we can
do that if suitable people (Mel?  Kamezawa?) have had a close look and
are OK with it.

What do people think?

Has it been carefully compile- and run-time tested with
CONFIG_MEMORY_HOTPLUG_SPARSE=n?
