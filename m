Return-Path: <dave@linux.vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E0B88DDF22
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Aug 2008 03:53:32 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m75HrSN8000542
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Aug 2008 13:53:28 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m75HrSGQ223958
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Aug 2008 13:53:28 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m75HrRJv012734
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Aug 2008 13:53:28 -0400
Subject: Re: [RFC] [PATCH 0/5 V2] Huge page backed user-space stacks
From: Dave Hansen <dave@linux.vnet.ibm.com>
To: Mel Gorman <mel@csn.ul.ie>
In-Reply-To: <20080805162800.GJ20243@csn.ul.ie>
References: <cover.1216928613.git.ebmunson@us.ibm.com>
	<20080730014308.2a447e71.akpm@linux-foundation.org>
	<20080730172317.GA14138@csn.ul.ie>
	<20080730103407.b110afc2.akpm@linux-foundation.org>
	<20080730193010.GB14138@csn.ul.ie>
	<20080730130709.eb541475.akpm@linux-foundation.org>
	<20080731103137.GD1704@csn.ul.ie> <1217884211.20260.144.camel@nimitz>
	<20080805111147.GD20243@csn.ul.ie> <1217952748.10907.18.camel@nimitz>
	<20080805162800.GJ20243@csn.ul.ie>
Content-Type: text/plain
Date: Tue, 05 Aug 2008 10:53:25 -0700
Message-Id: <1217958805.10907.45.camel@nimitz>
Mime-Version: 1.0
Cc: linux-mm@kvack.org, libhugetlbfs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	abh@cray.com, ebmunson@us.ibm.com,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-08-05 at 17:28 +0100, Mel Gorman wrote:
> Ok sure, you could do direct inserts for MAP_PRIVATE as conceptually it
> suits this patch.  However, I don't see what you gain. By reusing hugetlbfs,
> we get things like proper reservations which we can do for MAP_PRIVATE these
> days. Again, we could call that sort of thing directly if the reservation
> layer was split out separate from hugetlbfs but I still don't see the gain
> for all that churn.
> 
> What am I missing?

This is good for getting us incremental functionality.  It is probably
the smallest amount of code to get it functional.

My concern is that we're going down a path that all large page usage
should be through the one and only filesystem.  Once we establish that
dependency, it is going to be awfully hard to undo it; just think of all
of the inherent behavior in hugetlbfs.  So, we better be sure that the
filesystem really is the way to go, especially if we're going to start
having other areas of the kernel depend on it internally.

That said, this particular patch doesn't appear *too* bound to hugetlb
itself.  But, some of its limitations *do* come from the filesystem,
like its inability to handle VM_GROWS...  

-- Dave
