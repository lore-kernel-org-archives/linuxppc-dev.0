Return-Path: <dgibson@ozlabs.org>
Date: Wed, 26 Mar 2008 16:16:19 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: dtc: Make dt_from_blob() open its own input file, like the other
	input formats
Message-ID: <20080326051619.GA2090@localhost.localdomain>
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

Currently, main() has a variable for the input file.  It used to be
that main() would open the input based on command line arguments
before passing it to the dt_from_*() function.  However, only
dt_from_blob() uses this.  dt_from_source() opens its own file, and
dt_from_fs() interprets the argument as as a directory and does its
own opendir() call.

Furthermore, main() opened the file with dtc_open_file() but closed it
with a direct call to fclose().

Therefore, to improve the interface consistency between the
dt_from_*() functions, make dt_from_blob() open and close its own
files like the other dt_from_*() functions.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

---
 dtc.c      |   16 +++++-----------
 dtc.h      |    2 +-
 flattree.c |   26 ++++++++++++++++----------
 3 files changed, 22 insertions(+), 22 deletions(-)

Index: dtc/dtc.c
===================================================================
--- dtc.orig/dtc.c	2008-03-26 16:08:22.000000000 +1100
+++ dtc/dtc.c	2008-03-26 16:08:37.000000000 +1100
@@ -118,7 +118,6 @@
 	int force = 0, check = 0;
 	const char *arg;
 	int opt;
-	struct dtc_file *inf = NULL;
 	FILE *outf = NULL;
 	int outversion = DEFAULT_FDT_VERSION;
 	int boot_cpuid_phys = 0xfeedbeef;
@@ -187,19 +186,14 @@
 	fprintf(stderr, "DTC: %s->%s  on file \"%s\"\n",
 		inform, outform, arg);
 
-	if (streq(inform, "dts")) {
+	if (streq(inform, "dts"))
 		bi = dt_from_source(arg);
-	} else if (streq(inform, "fs")) {
+	else if (streq(inform, "fs"))
 		bi = dt_from_fs(arg);
-	} else if(streq(inform, "dtb")) {
-		inf = dtc_open_file(arg, NULL);
-		bi = dt_from_blob(inf->file);
-	} else {
+	else if(streq(inform, "dtb"))
+		bi = dt_from_blob(arg);
+	else
 		die("Unknown input format \"%s\"\n", inform);
-	}
-
-	if (inf && inf->file != stdin)
-		fclose(inf->file);
 
 	fill_fullpaths(bi->dt, "");
 	process_checks(force, bi);
Index: dtc/dtc.h
===================================================================
--- dtc.orig/dtc.h	2008-03-26 16:08:22.000000000 +1100
+++ dtc/dtc.h	2008-03-26 16:08:37.000000000 +1100
@@ -248,7 +248,7 @@
 void dt_to_asm(FILE *f, struct boot_info *bi, int version,
 	       int boot_cpuid_phys);
 
-struct boot_info *dt_from_blob(FILE *f);
+struct boot_info *dt_from_blob(const char *fname);
 
 /* Tree source */
 
Index: dtc/flattree.c
===================================================================
--- dtc.orig/flattree.c	2008-03-26 16:08:22.000000000 +1100
+++ dtc/flattree.c	2008-03-26 16:08:37.000000000 +1100
@@ -19,6 +19,7 @@
  */
 
 #include "dtc.h"
+#include "srcpos.h"
 
 #define FTF_FULLPATH	0x1
 #define FTF_VARALIGN	0x2
@@ -780,8 +781,9 @@
 }
 
 
-struct boot_info *dt_from_blob(FILE *f)
+struct boot_info *dt_from_blob(const char *fname)
 {
+	struct dtc_file *dtcf;
 	u32 magic, totalsize, version, size_dt;
 	u32 off_dt, off_str, off_mem_rsvmap;
 	int rc;
@@ -796,12 +798,14 @@
 	u32 val;
 	int flags = 0;
 
-	rc = fread(&magic, sizeof(magic), 1, f);
-	if (ferror(f))
+	dtcf = dtc_open_file(fname, NULL);
+
+	rc = fread(&magic, sizeof(magic), 1, dtcf->file);
+	if (ferror(dtcf->file))
 		die("Error reading DT blob magic number: %s\n",
 		    strerror(errno));
 	if (rc < 1) {
-		if (feof(f))
+		if (feof(dtcf->file))
 			die("EOF reading DT blob magic number\n");
 		else
 			die("Mysterious short read reading magic number\n");
@@ -811,11 +815,11 @@
 	if (magic != FDT_MAGIC)
 		die("Blob has incorrect magic number\n");
 
-	rc = fread(&totalsize, sizeof(totalsize), 1, f);
-	if (ferror(f))
+	rc = fread(&totalsize, sizeof(totalsize), 1, dtcf->file);
+	if (ferror(dtcf->file))
 		die("Error reading DT blob size: %s\n", strerror(errno));
 	if (rc < 1) {
-		if (feof(f))
+		if (feof(dtcf->file))
 			die("EOF reading DT blob size\n");
 		else
 			die("Mysterious short read reading blob size\n");
@@ -835,12 +839,12 @@
 	p = blob + sizeof(magic)  + sizeof(totalsize);
 
 	while (sizeleft) {
-		if (feof(f))
+		if (feof(dtcf->file))
 			die("EOF before reading %d bytes of DT blob\n",
 			    totalsize);
 
-		rc = fread(p, 1, sizeleft, f);
-		if (ferror(f))
+		rc = fread(p, 1, sizeleft, dtcf->file);
+		if (ferror(dtcf->file))
 			die("Error reading DT blob: %s\n",
 			    strerror(errno));
 
@@ -902,5 +906,7 @@
 
 	free(blob);
 
+	dtc_close_file(dtcf);
+
 	return build_boot_info(reservelist, tree);
 }

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
