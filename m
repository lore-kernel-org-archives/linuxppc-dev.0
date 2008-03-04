Return-Path: <dgibson@ozlabs.org>
Date: Tue, 4 Mar 2008 16:10:39 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: dtc: Make dt_from_blob() open its own file
Message-ID: <20080304051039.GC2757@localhost.localdomain>
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

dt_from_source() and dt_from_fs() both take a filename (or directory
name) argument and open files as necessary themselves.
dt_from_blob(), however, expects the caller to open a file and pass it
in.

This patch makes dt_from_blob() take a filename and open its own
files, removing the inconsistency.  In addition, dt_from_blob() now
correctly uses dtc_close_file() to close the file opened with
dtc_open_file(), rather than directly calling fclose() on the
contained FILE *.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

---
 dtc.c      |   11 +----------
 dtc.h      |    4 ++--
 flattree.c |   10 +++++++++-
 3 files changed, 12 insertions(+), 13 deletions(-)

Index: dtc/dtc.c
===================================================================
--- dtc.orig/dtc.c	2008-03-04 15:58:49.000000000 +1100
+++ dtc/dtc.c	2008-03-04 16:02:12.000000000 +1100
@@ -118,7 +118,6 @@ int main(int argc, char *argv[])
 	int force = 0, check = 0;
 	const char *arg;
 	int opt;
-	struct dtc_file *inf = NULL;
 	FILE *outf = NULL;
 	int outversion = DEFAULT_FDT_VERSION;
 	int boot_cpuid_phys = 0xfeedbeef;
@@ -192,19 +191,11 @@ int main(int argc, char *argv[])
 	} else if (streq(inform, "fs")) {
 		bi = dt_from_fs(arg);
 	} else if(streq(inform, "dtb")) {
-		inf = dtc_open_file(arg, NULL);
-		if (!inf)
-			die("Couldn't open \"%s\": %s\n", arg,
-			    strerror(errno));
-
-		bi = dt_from_blob(inf->file);
+		bi = dt_from_blob(arg);
 	} else {
 		die("Unknown input format \"%s\"\n", inform);
 	}
 
-	if (inf && inf->file != stdin)
-		fclose(inf->file);
-
 	if (! bi || ! bi->dt || bi->error)
 		die("Couldn't read input tree\n");
 
Index: dtc/flattree.c
===================================================================
--- dtc.orig/flattree.c	2008-03-04 15:59:53.000000000 +1100
+++ dtc/flattree.c	2008-03-04 16:06:55.000000000 +1100
@@ -19,6 +19,7 @@
  */
 
 #include "dtc.h"
+#include "srcpos.h"
 
 #define FTF_FULLPATH	0x1
 #define FTF_VARALIGN	0x2
@@ -780,8 +781,10 @@ static struct node *unflatten_tree(struc
 }
 
 
-struct boot_info *dt_from_blob(FILE *f)
+struct boot_info *dt_from_blob(const char *fname)
 {
+	struct dtc_file *dtcf;
+	FILE *f;
 	u32 magic, totalsize, version, size_dt;
 	u32 off_dt, off_str, off_mem_rsvmap;
 	int rc;
@@ -796,6 +799,9 @@ struct boot_info *dt_from_blob(FILE *f)
 	u32 val;
 	int flags = 0;
 
+	dtcf = dtc_open_file(fname, NULL);
+	f = dtcf->file;
+
 	rc = fread(&magic, sizeof(magic), 1, f);
 	if (ferror(f))
 		die("Error reading DT blob magic number: %s\n",
@@ -902,5 +908,7 @@ struct boot_info *dt_from_blob(FILE *f)
 
 	free(blob);
 
+	dtc_close_file(dtcf);
+
 	return build_boot_info(reservelist, tree);
 }
Index: dtc/dtc.h
===================================================================
--- dtc.orig/dtc.h	2008-03-04 16:01:22.000000000 +1100
+++ dtc/dtc.h	2008-03-04 16:01:43.000000000 +1100
@@ -250,12 +250,12 @@ void dt_to_blob(FILE *f, struct boot_inf
 void dt_to_asm(FILE *f, struct boot_info *bi, int version,
 	       int boot_cpuid_phys);
 
-struct boot_info *dt_from_blob(FILE *f);
+struct boot_info *dt_from_blob(const char *fname);
 
 /* Tree source */
 
 void dt_to_source(FILE *f, struct boot_info *bi);
-struct boot_info *dt_from_source(const char *f);
+struct boot_info *dt_from_source(const char *fname);
 
 /* FS trees */
 

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
