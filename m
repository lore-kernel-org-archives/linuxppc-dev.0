Return-Path: <dgibson@ozlabs.org>
Date: Fri, 31 Aug 2007 16:21:23 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: dtc: Optimise by default, fix warnings thus uncovered
Message-ID: <20070831062123.GC29721@localhost.localdomain>
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

This patch turns on optimisation in the Makefile by default.  With the
optimizer on, some uninitialized variable warnings (one real, two
bogus) are now generated.  This patch also squashes those again.

Index: dtc/Makefile
===================================================================
--- dtc.orig/Makefile	2007-08-31 16:00:25.000000000 +1000
+++ dtc/Makefile	2007-08-31 16:00:28.000000000 +1000
@@ -45,7 +45,7 @@
 
 
 CPPFLAGS = -I libfdt
-CFLAGS = -Wall -g
+CFLAGS = -Wall -g -Os
 LDFLAGS = -Llibfdt
 
 BISON = bison
Index: dtc/tests/truncated_property.c
===================================================================
--- dtc.orig/tests/truncated_property.c	2007-08-31 16:05:27.000000000 +1000
+++ dtc/tests/truncated_property.c	2007-08-31 16:05:38.000000000 +1000
@@ -33,7 +33,6 @@
 {
 	void *fdt = &_truncated_property;
 	const void *prop;
-	int err;
 	int len;
 
 	test_init(argc, argv);
@@ -43,7 +42,7 @@
 		FAIL("fdt_getprop() succeeded on truncated property");
 	if (len != -FDT_ERR_BADSTRUCTURE)
 		FAIL("fdt_getprop() failed with \"%s\" instead of \"%s\"",
-		     fdt_strerror(err), fdt_strerror(-FDT_ERR_BADSTRUCTURE));
+		     fdt_strerror(len), fdt_strerror(-FDT_ERR_BADSTRUCTURE));
 
 	PASS();
 }
Index: dtc/flattree.c
===================================================================
--- dtc.orig/flattree.c	2007-08-31 16:08:06.000000000 +1000
+++ dtc/flattree.c	2007-08-31 16:09:29.000000000 +1000
@@ -909,6 +909,7 @@
 		fprintf(stderr, "\tboot_cpuid_phys:\t0x%x\n",
 			be32_to_cpu(bph->boot_cpuid_phys));
 
+	size_str = -1;
 	if (version >= 3) {
 		size_str = be32_to_cpu(bph->size_dt_strings);
 		fprintf(stderr, "\tsize_dt_strings:\t%d\n", size_str);
@@ -932,10 +933,10 @@
 	inbuf_init(&memresvbuf,
 		   blob + off_mem_rsvmap, blob + totalsize);
 	inbuf_init(&dtbuf, blob + off_dt, blob + totalsize);
-	inbuf_init(&strbuf, blob + off_str, blob + totalsize);
-
-	if (version >= 3)
-		strbuf.limit = strbuf.base + size_str;
+	if (size_str >= 0)
+		inbuf_init(&strbuf, blob + off_str, blob + off_str + size_str);
+	else
+		inbuf_init(&strbuf, blob + off_str, blob + totalsize);
 
 	reservelist = flat_read_mem_reserve(&memresvbuf);
 
Index: dtc/dtc.c
===================================================================
--- dtc.orig/dtc.c	2007-08-31 16:10:23.000000000 +1000
+++ dtc/dtc.c	2007-08-31 16:12:44.000000000 +1000
@@ -71,7 +71,7 @@
 		fill_fullpaths(child, tree->fullpath);
 }
 
-static void usage(void)
+static void  __attribute__ ((noreturn)) usage(void)
 {
 	fprintf(stderr, "Usage:\n");
 	fprintf(stderr, "\tdtc [options] <input file>\n");
Index: dtc/dtc.h
===================================================================
--- dtc.orig/dtc.h	2007-08-31 16:13:01.000000000 +1000
+++ dtc/dtc.h	2007-08-31 16:13:07.000000000 +1000
@@ -43,7 +43,7 @@
 extern int reservenum;		/* Number of memory reservation slots */
 extern int minsize;		/* Minimum blob size */
 
-static inline void die(char * str, ...)
+static inline void __attribute__((noreturn)) die(char * str, ...)
 {
 	va_list ap;
 

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
