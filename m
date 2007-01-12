Return-Path: <dwg@au1.ibm.com>
Received: from ausmtp05.au.ibm.com (ausmtp05.au.ibm.com [202.81.18.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp05.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E2D23DDEA2
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Jan 2007 10:26:00 +1100 (EST)
Received: from sd0208e0.au.ibm.com (d23rh904.au.ibm.com [202.81.18.202])
	by ausmtp05.au.ibm.com (8.13.8/8.13.6) with ESMTP id l0FBRVxX2519216
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Jan 2007 10:27:31 -0100
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.250.237])
	by sd0208e0.au.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id
	l0ENTDlx249224
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Jan 2007 10:29:18 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l0ENPhAn003602
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Jan 2007 10:25:44 +1100
Date: Sat, 13 Jan 2007 09:43:48 +1100
From: David Gibson <dwg@au1.ibm.com>
To: Sonny Rao <sonny@burdell.org>
Subject: Re: [Libhugetlbfs-devel] 2.6.19: kernel BUG in hugepd_page at
	arch/powerpc/mm/hugetlbpage.c:58!
Message-ID: <20070112224348.GA18201@localhost.localdomain>
References: <20070112195703.GA1826@kevlar.boston.burdell.org>
	<1168632510.12413.62.camel@localhost.localdomain>
	<20070112204250.GA2290@kevlar.boston.burdell.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070112204250.GA2290@kevlar.boston.burdell.org>
Cc: linuxppc-dev@ozlabs.org, libhugetlbfs-devel@lists.sourceforge.net,
	nacc@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jan 12, 2007 at 03:42:50PM -0500, Sonny Rao wrote:
> On Fri, Jan 12, 2007 at 02:08:30PM -0600, Adam Litke wrote:
> > On Fri, 2007-01-12 at 14:57 -0500, Sonny Rao wrote:
> > > (Apologies if this is a re-post)
> > > 
> > > Hi, I was running 2.6.19 and running some benchmarks using
> > > libhugetlbfs (1.0.1) and I can fairly reliably trigger this bug:
> > 
> > Is this triggered by a libhugetlbfs test case?  If so, which one?
> 
> Ok so the testsuite all passed except for "slbpacaflush" which said
> "PASS (inconclusive)" ... not sure if that is expected or not. 

I used "PASS (inconclusive)" to mean: you're probably ok, but the bug
in question is non-deterministically triggered, so maybe we just got
lucky.

This testcase attempts to trigger a bunch of times (50?), but the
conditions are sufficiently dicey that a false PASS is still a
realistic possibility (I've seen it happen, but not often).  Some
other tests (e.g. alloc-instantiate-race) are technically
non-deterministic too, but I've managed to device trigger conditions
which are reliable in practice, those tests report plain PASS.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
