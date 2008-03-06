Return-Path: <dgibson@ozlabs.org>
Date: Thu, 6 Mar 2008 12:16:55 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: dtc: Make dtc_open_file() die() if unable to open requested file
Message-ID: <20080306011655.GA18315@localhost.localdomain>
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

All current callers of dtc_open_file() immediately die() if it returns
an error.  In a non-interative tool like dtc, it's hard to see what
you could sensibly do to recover from a failure to open an input file
in any case.

Therefore, make dtc_open_file() itself die() if there's an error
opening the requested file.  This removes the need for error checking
at the callsites, and ensures a consistent error message in all cases.
While we're at it, change the rror message from fstree.c when we fail
to open the input directory to match dtc_open_file()'s error message.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

---
 dtc-lexer.l |    3 ---
 dtc.c       |    4 ----
 fstree.c    |    4 ++--
 srcpos.c    |   11 ++++-------
 4 files changed, 6 insertions(+), 16 deletions(-)

Index: dtc/dtc-lexer.l
===================================================================
--- dtc.orig/dtc-lexer.l	2008-03-06 12:07:32.000000000 +1100
+++ dtc/dtc-lexer.l	2008-03-06 12:08:22.000000000 +1100
@@ -259,9 +259,6 @@
 	}
 
 	newfile = dtc_open_file(filename, searchptr);
-	if (!newfile)
-		die("Couldn't open \"%s\": %s", filename, strerror(errno));
-
 
 	incl_file = xmalloc(sizeof(struct incl_file));
 
Index: dtc/fstree.c
===================================================================
--- dtc.orig/fstree.c	2008-03-06 12:07:32.000000000 +1100
+++ dtc/fstree.c	2008-03-06 12:08:22.000000000 +1100
@@ -31,8 +31,8 @@
 	struct node *tree;
 
 	d = opendir(dirname);
-	if (! d)
-		die("opendir(): %s\n", strerror(errno));
+	if (!d)
+		die("Couldn't opendir() \"%s\": %s\n", dirname, strerror(errno));
 
 	tree = build_node(NULL, NULL);
 
Index: dtc/srcpos.c
===================================================================
--- dtc.orig/srcpos.c	2008-03-06 12:07:32.000000000 +1100
+++ dtc/srcpos.c	2008-03-06 12:08:22.000000000 +1100
@@ -82,9 +82,8 @@
 
 	if (fname[0] == '/') {
 		file->file = fopen(fname, "r");
-
 		if (!file->file)
-			goto out;
+			goto fail;
 
 		file->name = strdup(fname);
 		return file;
@@ -98,15 +97,13 @@
 			return file;
 
 		if (errno != ENOENT)
-			goto out;
+			goto fail;
 
 		search = search->next;
 	}
 
-out:
-	free(file->dir);
-	free(file);
-	return NULL;
+fail:
+	die("Couldn't open \"%s\": %s\n", fname, strerror(errno));
 }
 
 void dtc_close_file(struct dtc_file *file)
Index: dtc/dtc.c
===================================================================
--- dtc.orig/dtc.c	2008-03-06 12:08:34.000000000 +1100
+++ dtc/dtc.c	2008-03-06 12:08:38.000000000 +1100
@@ -193,10 +193,6 @@
 		bi = dt_from_fs(arg);
 	} else if(streq(inform, "dtb")) {
 		inf = dtc_open_file(arg, NULL);
-		if (!inf)
-			die("Couldn't open \"%s\": %s\n", arg,
-			    strerror(errno));
-
 		bi = dt_from_blob(inf->file);
 	} else {
 		die("Unknown input format \"%s\"\n", inform);

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
