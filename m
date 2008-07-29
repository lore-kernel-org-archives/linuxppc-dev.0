Return-Path: <dgibson@ozlabs.org>
Date: Tue, 29 Jul 2008 14:51:22 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: libfdt: Forgot one function when cleaning the namespace
Message-ID: <20080729045122.GC19856@yookeroo.seuss>
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

In commit b6d80a20fc293f3b995c3ce1a6744a5574192125, we renamed all
libfdt functions to be prefixed with fdt_ or _fdt_ to minimise the
chance of collisions with things from whatever package libfdt is
embedded in, pulled into the libfdt build via that environment's
libfdt_env.h.

Except... I missed one.  This patch applies the same treatment to
_stringlist_contains().  While we're at it, also make it static since
it's only used in the same file.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/libfdt/fdt_ro.c
===================================================================
--- dtc.orig/libfdt/fdt_ro.c	2008-07-29 13:43:23.000000000 +1000
+++ dtc/libfdt/fdt_ro.c	2008-07-29 13:43:33.000000000 +1000
@@ -408,7 +408,8 @@ int fdt_node_offset_by_phandle(const voi
 					     &phandle, sizeof(phandle));
 }
 
-int _stringlist_contains(const char *strlist, int listlen, const char *str)
+static int _fdt_stringlist_contains(const char *strlist, int listlen,
+				    const char *str)
 {
 	int len = strlen(str);
 	const char *p;
@@ -434,7 +435,7 @@ int fdt_node_check_compatible(const void
 	prop = fdt_getprop(fdt, nodeoffset, "compatible", &len);
 	if (!prop)
 		return len;
-	if (_stringlist_contains(prop, len, compatible))
+	if (_fdt_stringlist_contains(prop, len, compatible))
 		return 0;
 	else
 		return 1;

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
