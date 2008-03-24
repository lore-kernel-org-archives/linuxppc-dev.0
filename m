Return-Path: <dgibson@ozlabs.org>
Date: Mon, 24 Mar 2008 14:44:24 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: dtc: Simplify error handling for unparseable input
Message-ID: <20080324034424.GC29985@localhost.localdomain>
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

Currently, main() tests if it got a valid input tree from whichever
dt_from_*() function it invoked and if not, die()s.  For one thing,
this test has, for no good reason, three different ways for those
functions to communicate a failure to provide input (bi NULL, bi->dt
NULL, or bi->error non-zero).  For another, in every case save one, if
the dt_from_*() functions are unable to provide input they will
immediately die() (with a more specific error message) rather than
proceeding to the test in main().

Therefore, this patch removes this test, making the one case that
could have triggered it (in dt_from_source()) call die() directly
instead.  With this change, the error field in struct boot_info is now
unused, so remove it.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

---
 dtc.c        |    3 ---
 dtc.h        |    1 -
 livetree.c   |    1 -
 treesource.c |    6 ++++--
 4 files changed, 4 insertions(+), 7 deletions(-)

Index: dtc/dtc.h
===================================================================
--- dtc.orig/dtc.h	2008-03-24 14:33:33.000000000 +1100
+++ dtc/dtc.h	2008-03-24 14:33:34.000000000 +1100
@@ -232,7 +232,6 @@
 struct boot_info {
 	struct reserve_info *reservelist;
 	struct node *dt;		/* the device tree */
-	int error;
 };
 
 struct boot_info *build_boot_info(struct reserve_info *reservelist,
Index: dtc/livetree.c
===================================================================
--- dtc.orig/livetree.c	2008-03-24 14:18:44.000000000 +1100
+++ dtc/livetree.c	2008-03-24 14:33:34.000000000 +1100
@@ -172,7 +172,6 @@
 	bi = xmalloc(sizeof(*bi));
 	bi->reservelist = reservelist;
 	bi->dt = tree;
-	bi->error = 0;
 
 	return bi;
 }
Index: dtc/dtc.c
===================================================================
--- dtc.orig/dtc.c	2008-03-24 14:35:05.000000000 +1100
+++ dtc/dtc.c	2008-03-24 14:35:10.000000000 +1100
@@ -201,9 +201,6 @@
 	if (inf && inf->file != stdin)
 		fclose(inf->file);
 
-	if (! bi || ! bi->dt || bi->error)
-		die("Couldn't read input tree\n");
-
 	fill_fullpaths(bi->dt, "");
 	process_checks(force, bi);
 
Index: dtc/treesource.c
===================================================================
--- dtc.orig/treesource.c	2008-03-24 14:33:44.000000000 +1100
+++ dtc/treesource.c	2008-03-24 14:35:52.000000000 +1100
@@ -36,9 +36,11 @@
 	yyin = srcpos_file->file;
 
 	if (yyparse() != 0)
-		return NULL;
+		die("Unable to parse input tree\n");
+
+	if (treesource_error)
+		die("Syntax error parsing input tree\n");
 
-	the_boot_info->error = treesource_error;
 	return the_boot_info;
 }
 

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
