Return-Path: <dwg@au1.ibm.com>
Received: from ausmtp05.au.ibm.com (ausmtp05.au.ibm.com [202.81.18.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp05.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DDD9ADDF1D
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jan 2007 11:48:36 +1100 (EST)
Received: from sd0208e0.au.ibm.com (d23rh904.au.ibm.com [202.81.18.202])
	by ausmtp05.au.ibm.com (8.13.8/8.13.8) with ESMTP id l0OCoDWW7205026
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jan 2007 11:50:13 -0100
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.250.237])
	by sd0208e0.au.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id
	l0O0q4pb218010
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jan 2007 11:52:04 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l0O0mY9a001313
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jan 2007 11:48:35 +1100
Date: Wed, 24 Jan 2007 11:35:56 +1100
From: David Gibson <dwg@au1.ibm.com>
To: Adam Litke <agl@us.ibm.com>
Subject: Re: [Libhugetlbfs-devel] 2.6.19: kernel BUG in hugepd_page
	at	arch/powerpc/mm/hugetlbpage.c:58!
Message-ID: <20070124003556.GA2218@localhost.localdomain>
References: <20070112195703.GA1826@kevlar.boston.burdell.org>
	<1168632510.12413.62.camel@localhost.localdomain>
	<20070112204250.GA2290@kevlar.boston.burdell.org>
	<20070112224348.GA18201@localhost.localdomain>
	<20070123051040.GA17272@kevlar.boston.burdell.org>
	<20070123061812.GE32019@localhost.localdomain>
	<1169569203.14914.36.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1169569203.14914.36.camel@localhost.localdomain>
Cc: sonnyrao@us.ibm.com, linuxppc-dev@ozlabs.org, anton@au1.ibm.com,
	libhugetlbfs-devel@lists.sourceforge.net, nacc@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jan 23, 2007 at 10:20:03AM -0600, Adam Litke wrote:
> On Tue, 2007-01-23 at 17:18 +1100, David Gibson wrote:
> > Second, there's the fact that we never demote hugepage segments back
> > to normal pages.  That was a deliberate decision to keep things
> > simple, incidentally, not simply an oversight.  I guess it would help
> > in this case and shouldn't be that hard.  It would mean a find_vma()
> > on each unmap to see if the region is now clear, but that's probably
> > not too bad.  Plus a bunch of on_each_cpu()ed slbies as when we open a
> > new hugepage segment.  Oh.. and making sure we get rid of any empty
> > hugepage directories, which might be a bit fiddly.
> 
> Could we also try lazy conversion of huge segments to normal ones?  When
> is_hugepage_only_range() detects overlapping hugepage ranges, it could
> attempt to "close" those ranges for huge pages first.  Then the heavy
> lifting only needs to happen when a small page mapping needs the space.

We could, but I think it's both easier and less operations to do the
check on unmap.  The lifting isn't that heavy.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
