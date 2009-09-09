Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp06.au.ibm.com", Issuer "Equifax" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id B1FD0B6F34
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  9 Sep 2009 15:55:40 +1000 (EST)
Received: from d23relay02.au.ibm.com (d23relay02.au.ibm.com [202.81.31.244])
	by e23smtp06.au.ibm.com (8.14.3/8.13.1) with ESMTP id n895tW9C001043
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Sep 2009 15:55:32 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay02.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n895tbRc1306834
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Sep 2009 15:55:37 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n895taxt017763
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Sep 2009 15:55:36 +1000
Date: Wed, 9 Sep 2009 15:55:34 +1000
From: David Gibson <dwg@au1.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, Benjamin Herrenschmidt <benh@au1.ibm.com>
Subject: [0/5] Assorted hugepage cleanups
Message-ID: <20090909055534.GF7909@yookeroo.seuss>
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

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
