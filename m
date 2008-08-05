Return-Path: <dave@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E836CDDEE3
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Aug 2008 02:12:38 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m75GCW4v024910
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Aug 2008 12:12:32 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m75GCWhb172536
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Aug 2008 12:12:32 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m75GCVRe024456
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Aug 2008 12:12:32 -0400
Subject: Re: [RFC] [PATCH 0/5 V2] Huge page backed user-space stacks
From: Dave Hansen <dave@linux.vnet.ibm.com>
To: Mel Gorman <mel@csn.ul.ie>
In-Reply-To: <20080805111147.GD20243@csn.ul.ie>
References: <cover.1216928613.git.ebmunson@us.ibm.com>
	<20080730014308.2a447e71.akpm@linux-foundation.org>
	<20080730172317.GA14138@csn.ul.ie>
	<20080730103407.b110afc2.akpm@linux-foundation.org>
	<20080730193010.GB14138@csn.ul.ie>
	<20080730130709.eb541475.akpm@linux-foundation.org>
	<20080731103137.GD1704@csn.ul.ie> <1217884211.20260.144.camel@nimitz>
	<20080805111147.GD20243@csn.ul.ie>
Content-Type: text/plain
Date: Tue, 05 Aug 2008 09:12:28 -0700
Message-Id: <1217952748.10907.18.camel@nimitz>
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

On Tue, 2008-08-05 at 12:11 +0100, Mel Gorman wrote:
> See, that's great until you start dealing with MAP_SHARED|MAP_ANONYMOUS.
> To get that right between children, you end up something very fs-like
> when the child needs to fault in a page that is already populated by the
> parent. I strongly suspect we end up back at hugetlbfs backing it :/

Yeah, but the case I'm worried about is plain anonymous.  We already
have the fs to back SHARED|ANONYMOUS, and they're not really
anonymous. :)

This patch *really* needs anonymous pages, and it kinda shoehorns them
in with the filesystem.  Stacks aren't shared at all, so this is a
perfect example of where we can forget the fs, right?

-- Dave
