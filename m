Return-Path: <dgibson@ozlabs.org>
Date: Thu, 18 Oct 2007 14:17:25 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: libfdt: Add missing RW_CHECK_HEADER to fdt_del_node()
Message-ID: <20071018041725.GD8206@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

fdt_del_node(), unlike most of the rw functions does not check the
fdt's header with RW_CHECK_HEADER.  However, it could make a mess of
things if the conditions in RW_CHECK_HEADER aren't met.  So, this
patch adds the omitted check.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/libfdt/fdt_rw.c
===================================================================
--- dtc.orig/libfdt/fdt_rw.c	2007-10-16 10:44:53.000000000 +1000
+++ dtc/libfdt/fdt_rw.c	2007-10-18 14:14:47.000000000 +1000
@@ -329,6 +329,8 @@
 {
 	int endoffset;
 
+	RW_CHECK_HEADER(fdt);
+
 	endoffset = _fdt_node_end_offset(fdt, nodeoffset);
 	if (endoffset < 0)
 		return endoffset;

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
