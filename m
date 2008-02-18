Return-Path: <dgibson@ozlabs.org>
Date: Mon, 18 Feb 2008 18:09:04 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: libfdt: Remove no longer used code from
	fdt_node_offset_by_compatible()
Message-ID: <20080218070904.GJ29975@localhost.localdomain>
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

Since fdt_node_offset_by_compatible() was converted to the new
fdt_next_node() iterator, a chunk of initialization code became
redundant, but was not removed by oversight.  This patch cleans it up.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/libfdt/fdt_ro.c
===================================================================
--- dtc.orig/libfdt/fdt_ro.c	2008-02-18 18:02:01.000000000 +1100
+++ dtc/libfdt/fdt_ro.c	2008-02-18 18:06:33.000000000 +1100
@@ -453,20 +453,10 @@ int fdt_node_check_compatible(const void
 int fdt_node_offset_by_compatible(const void *fdt, int startoffset,
 				  const char *compatible)
 {
-	uint32_t tag;
-	int offset, nextoffset;
-	int err;
+	int offset, err;
 
 	CHECK_HEADER(fdt);
 
-	if (startoffset >= 0) {
-		tag = fdt_next_tag(fdt, startoffset, &nextoffset);
-		if (tag != FDT_BEGIN_NODE)
-			return -FDT_ERR_BADOFFSET;
-	} else {
-		nextoffset = 0;
-	}
-
 	/* FIXME: The algorithm here is pretty horrible: we scan each
 	 * property of a node in fdt_node_check_compatible(), then if
 	 * that didn't find what we want, we scan over them again

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
