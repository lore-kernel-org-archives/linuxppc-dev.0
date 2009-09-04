Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp06.au.ibm.com", Issuer "Equifax" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id C4535B708B
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  4 Sep 2009 17:14:56 +1000 (EST)
Received: from d23relay02.au.ibm.com (d23relay02.au.ibm.com [202.81.31.244])
	by e23smtp06.au.ibm.com (8.14.3/8.13.1) with ESMTP id n847El8x021515
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Sep 2009 17:14:47 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay02.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n847EnZB1061080
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Sep 2009 17:14:51 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n847Emvf017654
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Sep 2009 17:14:48 +1000
Date: Fri, 4 Sep 2009 17:14:45 +1000
From: David Gibson <dwg@au1.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, Benjamin Herrenschmidt <benh@au1.ibm.com>
Subject: [0/3] Sanitize pagetable handling for hugepages
Message-ID: <20090904071445.GD20631@yookeroo.seuss>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently, ordinary pages use one pagetable layout, and each different
hugepage size uses a slightly different variant layout.  A number of
places which need to walk the pagetable must first check the slice map
to see what the pagetable layout then handle the various different
forms.  New hardware, like Book3E is liable to introduce more possible
variants.

This patch series, therefore, is designed to simplify the matter by
limiting knowledge of the pagetable layout to only the allocation
path.  With this patch, ordinary pages are handled as ever, with a
fixed 4 (or 3) level tree.  All other variants branch off from some
layer of that with a specially marked PGD/PUD/PMD pointer which also
contains enough information to interpret the directories below that
point.  This means that things walking the pagetables (without
allocating) don't need to look up the slice map, they can just step
down the tree in the usual way, branching off to the "non-standard
layout" path for hugepages, which uses the embdded information to
interpret the tree from that point on.

This reduces the source size in a number of places, and means that
newer variants on the pagetable layout to handle new hardware and new
features will need to alter the existing code in less places.


I've used the libhugetlbfs testsuite to test these patches on a
Power5+ machine, but they could do with some banging.  In particular I
don't have any suitable hardware to test 16G pages.  So, think of this
as the first draft of the series.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
