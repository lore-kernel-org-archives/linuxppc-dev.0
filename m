Return-Path: <miltonm@bga.com>
Received: from mercury.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 3CCA3DE8E8
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jan 2009 23:19:45 +1100 (EST)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Milton Miller <miltonm@bga.com>
Subject: [PATCH 4/4] powerpc: numa: avoid possible reference beyond property
	length in find_min_common_depth
Date: Thu, 08 Jan 2009 06:19:43 -0600
Message-ID: <1231417183_141716@mercury.realtime.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

find_min_common_depth was checking the property length incorrectly.
The value is in bytes not cells, and it is using the second entry.

Signed-off-By: Milton Miller <miltonm@bga.com>
---
I'm not aware of any trees that are broken in this way, so backport
not likely needed but easy to apply.

Index: work.git/arch/powerpc/mm/numa.c
===================================================================
--- work.git.orig/arch/powerpc/mm/numa.c	2009-01-05 05:08:10.000000000 -0600
+++ work.git/arch/powerpc/mm/numa.c	2009-01-05 05:10:25.000000000 -0600
@@ -260,7 +260,7 @@ static int __init find_min_common_depth(
 	ref_points = of_get_property(rtas_root,
 			"ibm,associativity-reference-points", &len);
 
-	if ((len >= 1) && ref_points) {
+	if ((len >= 2 * sizeof(unsigned int)) && ref_points) {
 		depth = ref_points[1];
 	} else {
 		dbg("NUMA: ibm,associativity-reference-points not found.\n");
