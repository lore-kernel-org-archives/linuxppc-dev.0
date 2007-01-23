Return-Path: <agl@us.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3A34DDDF2F
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jan 2007 03:20:07 +1100 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e31.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id l0NGK59n006999
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Jan 2007 11:20:05 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by westrelay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id
	l0NGK5Y1544044
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Jan 2007 09:20:05 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l0NGK4Wk029565
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Jan 2007 09:20:04 -0700
Subject: Re: [Libhugetlbfs-devel] 2.6.19: kernel BUG in hugepd_page at
	arch/powerpc/mm/hugetlbpage.c:58!
From: Adam Litke <agl@us.ibm.com>
To: David Gibson <dwg@au1.ibm.com>
In-Reply-To: <20070123061812.GE32019@localhost.localdomain>
References: <20070112195703.GA1826@kevlar.boston.burdell.org>
	<1168632510.12413.62.camel@localhost.localdomain>
	<20070112204250.GA2290@kevlar.boston.burdell.org>
	<20070112224348.GA18201@localhost.localdomain>
	<20070123051040.GA17272@kevlar.boston.burdell.org>
	<20070123061812.GE32019@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 23 Jan 2007 10:20:03 -0600
Message-Id: <1169569203.14914.36.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: anton@au1.ibm.com, sonnyrao@us.ibm.com,
	libhugetlbfs-devel@lists.sourceforge.net,
	linuxppc-dev@ozlabs.org, nacc@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-01-23 at 17:18 +1100, David Gibson wrote:
> Second, there's the fact that we never demote hugepage segments back
> to normal pages.  That was a deliberate decision to keep things
> simple, incidentally, not simply an oversight.  I guess it would help
> in this case and shouldn't be that hard.  It would mean a find_vma()
> on each unmap to see if the region is now clear, but that's probably
> not too bad.  Plus a bunch of on_each_cpu()ed slbies as when we open a
> new hugepage segment.  Oh.. and making sure we get rid of any empty
> hugepage directories, which might be a bit fiddly.

Could we also try lazy conversion of huge segments to normal ones?  When
is_hugepage_only_range() detects overlapping hugepage ranges, it could
attempt to "close" those ranges for huge pages first.  Then the heavy
lifting only needs to happen when a small page mapping needs the space.

-- 
Adam Litke - (agl at us.ibm.com)
IBM Linux Technology Center
