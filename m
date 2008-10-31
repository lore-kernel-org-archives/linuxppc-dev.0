Return-Path: <dgibson@ozlabs.org>
Date: Fri, 31 Oct 2008 13:37:05 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@samba.org>
Subject: Fix bug in kernel copy of libfdt's fdt_subnode_offset_namelen()
Message-ID: <20081031023705.GD16379@yookeroo.seuss>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

There's currently an off-by-one bug in fdt_subnode_offset_namelen()
which causes it to keep searching after it's finished the subnodes of
the given parent, and into the subnodes of siblings of the original
node which come after it in the tree.

A patch has already been submitted to dtc/libfdt mainline.  We don't
really want to pull in a new upstream version during the 2.6.28 cycle,
but we should still fix this bug, hence this standalone version of the
fix for the in-kernel libfdt.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: working-2.6/arch/powerpc/boot/libfdt/fdt_ro.c
===================================================================
--- working-2.6.orig/arch/powerpc/boot/libfdt/fdt_ro.c	2008-10-31 12:49:24.000000000 +1100
+++ working-2.6/arch/powerpc/boot/libfdt/fdt_ro.c	2008-10-31 12:50:02.000000000 +1100
@@ -104,8 +104,8 @@ int fdt_subnode_offset_namelen(const voi
 
 	FDT_CHECK_HEADER(fdt);
 
-	for (depth = 0;
-	     offset >= 0;
+	for (depth = 0, offset = fdt_next_node(fdt, offset, &depth);
+	     (offset >= 0) && (depth > 0);
 	     offset = fdt_next_node(fdt, offset, &depth)) {
 		if (depth < 0)
 			return -FDT_ERR_NOTFOUND;
@@ -114,7 +114,10 @@ int fdt_subnode_offset_namelen(const voi
 			return offset;
 	}
 
-	return offset; /* error */
+	if (offset < 0)
+		return offset; /* error */
+	else
+		return -FDT_ERR_NOTFOUND;
 }
 
 int fdt_subnode_offset(const void *fdt, int parentoffset,

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
