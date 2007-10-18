Return-Path: <dgibson@ozlabs.org>
Date: Thu, 18 Oct 2007 12:10:42 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: libfdt: Make fdt_string() return a const pointer
Message-ID: <20071018021042.GC24236@localhost.localdomain>
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

Currently, fdt_string() returns a (non-const) char *, despite taking a
const void *fdt.  This is inconsistent with all the other read-only
functions which all return const pointers into the blob.

This patch fixes that.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/libfdt/fdt_ro.c
===================================================================
--- dtc.orig/libfdt/fdt_ro.c	2007-10-17 17:35:49.000000000 +1000
+++ dtc/libfdt/fdt_ro.c	2007-10-17 17:35:50.000000000 +1000
@@ -82,7 +82,7 @@ static int nodename_eq(const void *fdt, 
 		return 0;
 }
 
-char *fdt_string(const void *fdt, int stroffset)
+const char *fdt_string(const void *fdt, int stroffset)
 {
 	return (char *)fdt + fdt_off_dt_strings(fdt) + stroffset;
 }
Index: dtc/libfdt/libfdt.h
===================================================================
--- dtc.orig/libfdt/libfdt.h	2007-10-17 17:35:35.000000000 +1000
+++ dtc/libfdt/libfdt.h	2007-10-17 17:35:36.000000000 +1000
@@ -110,7 +110,7 @@ static inline void *fdt_offset_ptr_w(voi
 int fdt_move(const void *fdt, void *buf, int bufsize);
 
 /* Read-only functions */
-char *fdt_string(const void *fdt, int stroffset);
+const char *fdt_string(const void *fdt, int stroffset);
 
 int fdt_get_mem_rsv(const void *fdt, int n, uint64_t *address, uint64_t *size);
 int fdt_num_mem_rsv(const void *fdt);

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
