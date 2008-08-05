Return-Path: <mel@csn.ul.ie>
Received: from gir.skynet.ie (gir.skynet.ie [193.1.99.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CBE8CDDD0B
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Aug 2008 21:11:55 +1000 (EST)
Date: Tue, 5 Aug 2008 12:11:48 +0100
From: Mel Gorman <mel@csn.ul.ie>
To: Dave Hansen <dave@linux.vnet.ibm.com>
Subject: Re: [RFC] [PATCH 0/5 V2] Huge page backed user-space stacks
Message-ID: <20080805111147.GD20243@csn.ul.ie>
References: <cover.1216928613.git.ebmunson@us.ibm.com>
	<20080730014308.2a447e71.akpm@linux-foundation.org>
	<20080730172317.GA14138@csn.ul.ie>
	<20080730103407.b110afc2.akpm@linux-foundation.org>
	<20080730193010.GB14138@csn.ul.ie>
	<20080730130709.eb541475.akpm@linux-foundation.org>
	<20080731103137.GD1704@csn.ul.ie>
	<1217884211.20260.144.camel@nimitz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <1217884211.20260.144.camel@nimitz>
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

On (04/08/08 14:10), Dave Hansen didst pronounce:
> On Thu, 2008-07-31 at 11:31 +0100, Mel Gorman wrote:
> > We are a lot more reliable than we were although exact quantification is
> > difficult because it's workload dependent. For a long time, I've been able
> > to test bits and pieces with hugepages by allocating the pool at the time
> > I needed it even after days of uptime. Previously this required a reboot.
> 
> This is also a pretty big expansion of fs/hugetlb/ use outside of the
> filesystem itself.  It is hacking the existing shared memory
> kernel-internal user to spit out effectively anonymous memory.
> 
> Where do we draw the line where we stop using the filesystem for this?
> Other than the immediate code reuse, does it gain us anything?
> 
> I have to think that actually refactoring the filesystem code and making
> it usable for really anonymous memory, then using *that* in these
> patches would be a lot more sane.  Especially for someone that goes to
> look at it in a year. :)
> 

See, that's great until you start dealing with MAP_SHARED|MAP_ANONYMOUS.
To get that right between children, you end up something very fs-like
when the child needs to fault in a page that is already populated by the
parent. I strongly suspect we end up back at hugetlbfs backing it :/

If you were going to do such a thing, you'd end up converting something
like ramfs to hugetlbfs and sharing that.


-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
