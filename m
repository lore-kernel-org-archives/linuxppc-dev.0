Return-Path: <dgibson@ozlabs.org>
Date: Mon, 18 Feb 2008 18:06:31 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: libfdt: Trivial cleanup for CHECK_HEADER)
Message-ID: <20080218070631.GI29975@localhost.localdomain>
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

Currently the CHECK_HEADER() macro is defined local to fdt_ro.c.
However, there are a handful of functions (fdt_move, rw_check_header,
fdt_open_into) from other files which could also use it (currently
they open-code something more-or-less identical).  Therefore, this
patch moves CHECK_HEADER() to libfdt_internal.h and uses it in those
places.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

---
 libfdt/fdt.c             |    5 +----
 libfdt/fdt_ro.c          |    7 -------
 libfdt/fdt_rw.c          |    8 ++------
 libfdt/libfdt_internal.h |    7 +++++++
 4 files changed, 10 insertions(+), 17 deletions(-)

Index: dtc/libfdt/fdt.c
===================================================================
--- dtc.orig/libfdt/fdt.c	2008-02-18 18:01:59.000000000 +1100
+++ dtc/libfdt/fdt.c	2008-02-18 18:02:01.000000000 +1100
@@ -184,10 +184,7 @@ const char *_fdt_find_string(const char 
 
 int fdt_move(const void *fdt, void *buf, int bufsize)
 {
-	int err = fdt_check_header(fdt);
-
-	if (err)
-		return err;
+	CHECK_HEADER(fdt);
 
 	if (fdt_totalsize(fdt) > bufsize)
 		return -FDT_ERR_NOSPACE;
Index: dtc/libfdt/fdt_ro.c
===================================================================
--- dtc.orig/libfdt/fdt_ro.c	2008-02-18 18:01:59.000000000 +1100
+++ dtc/libfdt/fdt_ro.c	2008-02-18 18:02:01.000000000 +1100
@@ -55,13 +55,6 @@
 
 #include "libfdt_internal.h"
 
-#define CHECK_HEADER(fdt) \
-	{ \
-		int err; \
-		if ((err = fdt_check_header(fdt)) != 0) \
-			return err; \
-	}
-
 static int nodename_eq(const void *fdt, int offset,
 		       const char *s, int len)
 {
Index: dtc/libfdt/libfdt_internal.h
===================================================================
--- dtc.orig/libfdt/libfdt_internal.h	2008-02-18 18:01:59.000000000 +1100
+++ dtc/libfdt/libfdt_internal.h	2008-02-18 18:02:01.000000000 +1100
@@ -58,6 +58,13 @@
 #define memeq(p, q, n)	(memcmp((p), (q), (n)) == 0)
 #define streq(p, q)	(strcmp((p), (q)) == 0)
 
+#define CHECK_HEADER(fdt) \
+	{ \
+		int err; \
+		if ((err = fdt_check_header(fdt)) != 0) \
+			return err; \
+	}
+
 uint32_t _fdt_next_tag(const void *fdt, int startoffset, int *nextoffset);
 const char *_fdt_find_string(const char *strtab, int tabsize, const char *s);
 int _fdt_node_end_offset(void *fdt, int nodeoffset);
Index: dtc/libfdt/fdt_rw.c
===================================================================
--- dtc.orig/libfdt/fdt_rw.c	2008-02-18 18:02:52.000000000 +1100
+++ dtc/libfdt/fdt_rw.c	2008-02-18 18:04:00.000000000 +1100
@@ -69,10 +69,8 @@ static int _blocks_misordered(const void
 
 static int rw_check_header(void *fdt)
 {
-	int err;
+	CHECK_HEADER(fdt);
 
-	if ((err = fdt_check_header(fdt)))
-		return err;
 	if (fdt_version(fdt) < 17)
 		return -FDT_ERR_BADVERSION;
 	if (_blocks_misordered(fdt, sizeof(struct fdt_reserve_entry),
@@ -399,9 +397,7 @@ int fdt_open_into(const void *fdt, void 
 	int newsize;
 	void *tmp;
 
-	err = fdt_check_header(fdt);
-	if (err)
-		return err;
+	CHECK_HEADER(fdt);
 
 	mem_rsv_size = (fdt_num_mem_rsv(fdt)+1)
 		* sizeof(struct fdt_reserve_entry);

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
