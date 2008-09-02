Return-Path: <nacc@us.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DE0F3DDFA4
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Sep 2008 02:25:22 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m82GPJwP012555
	for <linuxppc-dev@ozlabs.org>; Tue, 2 Sep 2008 12:25:19 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m82GPJUP219972
	for <linuxppc-dev@ozlabs.org>; Tue, 2 Sep 2008 12:25:19 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m82GPIA0017636
	for <linuxppc-dev@ozlabs.org>; Tue, 2 Sep 2008 12:25:19 -0400
Date: Tue, 2 Sep 2008 09:25:17 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Mel Gorman <mel@csn.ul.ie>
Subject: Re: [Libhugetlbfs-devel] Buglet in 16G page handling
Message-ID: <20080902162517.GC6753@us.ibm.com>
References: <20080902050510.GB12965@yookeroo.seuss>
	<20080902124442.GD29766@csn.ul.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080902124442.GD29766@csn.ul.ie>
Cc: linuxppc-dev@ozlabs.org, Jon Tollefson <kniht@linux.vnet.ibm.com>,
	libhugetlbfs-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 02.09.2008 [13:44:42 +0100], Mel Gorman wrote:
> On (02/09/08 15:05), David Gibson didst pronounce:
> > When BenH and I were looking at the new code for handling 16G pages,
> > we noticed a small bug.  It doesn't actually break anything user
> > visible, but it's certainly not the way things are supposed to be.
> > The 16G patches didn't update the huge_pte_offset() and
> > huge_pte_alloc() functions, which means that the hugepte tables for
> > 16G pages will be allocated much further down the page table tree than
> > they should be - allocating several levels of page table with a single
> > entry in them along the way.
> > 
> > The patch below is supposed to fix this, cleaning up the existing
> > handling of 64k vs 16M pages while its at it.  However, it needs some
> > testing.
> > 
> 
> Actually, Jon has been hitting an occasional pagetable lock related
> problem. The last theory was that it might be some sort of race but it's
> vaguely possible that this is the issue. Jon?
> 
> > I've checked that it doesn't break existing 16M support, either with
> > 4k or 64k base pages.  I haven't figured out how to test with 64k
> > pages yet, at least until the multisize support goes into
> > libhugetlbfs. 
> 
> Mount a 64K point yourself and then set HUGETLB_PATH?

I don't think this will work, because we don't use fstatfs() to figure
out the pagesize, but instead assume meminfo and the fs are the same
hugepage size (but on power it will always be 16M in meminfo).

Thanks,
Nish
