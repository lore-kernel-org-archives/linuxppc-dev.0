Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp06.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CD4F5B7B77
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 28 Sep 2009 14:39:07 +1000 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp06.au.ibm.com (8.14.3/8.13.1) with ESMTP id n8S4d3Ia025401
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2009 14:39:03 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n8S4anTf1487014
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2009 14:36:49 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	n8S4d5hG029378
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2009 14:39:05 +1000
Date: Mon, 28 Sep 2009 14:39:02 +1000
From: David Gibson <dwg@au1.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, Benjamin Herrenschmidt <benh@au1.ibm.com>
Subject: [0/5] Assorted hugepage cleanups (v3)
Message-ID: <20090928043902.GA6302@yookeroo.seuss>
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

In addition we split out the hash / classic MMU specific code into a
separate hugetlbpage-hash64.c file.  This will make adding support for
other MMUs (like 440 and/or Book3E) easier.

I've used the libhugetlbfs testsuite to test these patches on a
Power5+ machine, but they could certainly do with more testing. In
particular, I don't have any suitable hardware to test 16G pages.

V2: Made the tweaks that BenH suggested to patch 2 of the original
series.  Some corresponding tweaks in patch 3 to match.

V3: Fix several small bugs.
	* We had a BUILD_BUG_ON() which is broken by the recent
problems with BUILD_BUG_ON().  Since it's not a hot path, use a
runtime BUG_ON() instead.

	* The ifdef logic was inverted for the test against
CONFIG_SPU_FS_64K_LS.

	* That in turn masked a compile bug (using a non-existent
constant) in the CONFIG_SPU_FS_64K_LS path.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
