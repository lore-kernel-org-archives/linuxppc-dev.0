Return-Path: <dgibson@ozlabs.org>
Date: Tue, 4 Dec 2007 11:49:43 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: dtc: Fix uninitialized use of structure_ok
Message-ID: <20071204004943.GD32577@localhost.localdomain>
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

My rework of the tree checking code introduced a potentially nasty bug
- it uses the structure_ok variable uninitialized.  This patch fixes
the problem.  It's a fairly ugly bandaid approach, but the ugly will
disappear once future patches have folded the semantic checks into the
new framework.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/checks.c
===================================================================
--- dtc.orig/checks.c	2007-12-03 17:14:27.000000000 +1100
+++ dtc/checks.c	2007-12-03 17:14:39.000000000 +1100
@@ -270,8 +270,12 @@ static struct check *check_table[] = {
 	&phandle_references,
 };
 
-void process_checks(int force, struct node *dt)
+int check_semantics(struct node *dt, int outversion, int boot_cpuid_phys);
+
+void process_checks(int force, struct boot_info *bi,
+		    int checkflag, int outversion, int boot_cpuid_phys)
 {
+	struct node *dt = bi->dt;
 	int i;
 	int error = 0;
 
@@ -292,6 +296,16 @@ void process_checks(int force, struct no
 				"output forced\n");
 		}
 	}
+
+	if (checkflag) {
+		if (error) {
+			fprintf(stderr, "Warning: Skipping semantic checks due to structural errors\n");
+		} else {
+			if (!check_semantics(bi->dt, outversion,
+					     boot_cpuid_phys))
+				fprintf(stderr, "Warning: Input tree has semantic errors\n");
+		}
+	}
 }
 
 /*
Index: dtc/dtc.c
===================================================================
--- dtc.orig/dtc.c	2007-12-03 17:14:27.000000000 +1100
+++ dtc/dtc.c	2007-12-03 17:14:39.000000000 +1100
@@ -119,7 +119,6 @@ int main(int argc, char *argv[])
 	FILE *outf = NULL;
 	int outversion = DEFAULT_FDT_VERSION;
 	int boot_cpuid_phys = 0xfeedbeef;
-	int structure_ok;
 
 	quiet      = 0;
 	reservenum = 0;
@@ -193,17 +192,7 @@ int main(int argc, char *argv[])
 	if (! bi || ! bi->dt)
 		die("Couldn't read input tree\n");
 
-	process_checks(force, bi->dt);
-
-	if (check) {
-		if (!structure_ok) {
-			fprintf(stderr, "Warning: Skipping semantic checks due to structural errors\n");
-		} else {
-			if (!check_semantics(bi->dt, outversion,
-					     boot_cpuid_phys))
-				fprintf(stderr, "Warning: Input tree has semantic errors\n");
-		}
-	}
+	process_checks(force, bi, check, outversion, boot_cpuid_phys);
 
 	if (streq(outname, "-")) {
 		outf = stdout;
Index: dtc/dtc.h
===================================================================
--- dtc.orig/dtc.h	2007-12-03 17:15:04.000000000 +1100
+++ dtc/dtc.h	2007-12-03 17:15:14.000000000 +1100
@@ -236,8 +236,8 @@ struct boot_info *build_boot_info(struct
 
 /* Checks */
 
-void process_checks(int force, struct node *dt);
-int check_semantics(struct node *dt, int outversion, int boot_cpuid_phys);
+void process_checks(int force, struct boot_info *bi,
+		    int checkflag, int outversion, int boot_cpuid_phys);
 
 /* Flattened trees */
 

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
