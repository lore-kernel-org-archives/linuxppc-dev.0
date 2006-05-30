Return-Path: <mikey@ozlabs.org>
To: linuxppc-dev@ozlabs.org, Jon Loeliger <jdl@freescale.com>
From: Michael Neuling <mikey@neuling.org>
Subject: [PATCH] dtc: add setting of physical boot cpu 
In-reply-to: <20060518170017.B15E367A6C@ozlabs.org> 
References: <20060518035734.2B2CA67A6D@ozlabs.org>
	<7AC7793A-74F3-4596-BF28-19BCA9E388CF@watson.ibm.com>
	<20060518170017.B15E367A6C@ozlabs.org>
Date: Wed, 31 May 2006 08:31:51 +1000
Sender: mikey@ozlabs.org
Message-Id: <20060530223309.9AB7667B3E@ozlabs.org>
Reply-To: Michael Neuling <mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

dtc always sets the physical boot CPU to 0xfeedbeef.  Add a -b option to
set this.    Also add warnings when using the wrong property with the
wrong blob version.  

Signed-off-by: Michael Neuling <mikey@neuling.org>

---
Retransmission with updated warnings after discussion with Jimi.

 dtc.c      |   14 ++++++++++----
 dtc.h      |    8 +++++---
 flattree.c |   16 ++++++++++------
 livetree.c |   17 ++++++++++++-----
 4 files changed, 37 insertions(+), 18 deletions(-)

Index: dtc/dtc.c
===================================================================
--- dtc.orig/dtc.c
+++ dtc/dtc.c
@@ -95,6 +95,8 @@ static void usage(void)
 	fprintf(stderr, "\t\tBlob version to produce, defaults to 3 (relevant for dtb\n\t\tand asm output only)\n");
 	fprintf(stderr, "\t-R <number>\n");
 	fprintf(stderr, "\t\tMake space for <number> reserve map entries (relevant for \n\t\tdtb and asm output only)\n");
+	fprintf(stderr, "\t-b <number>\n");
+	fprintf(stderr, "\t\tSet the physical boot cpu\n");
 	fprintf(stderr, "\t-f\n");
 	fprintf(stderr, "\t\tForce - try to produce output even if the input tree has errors\n");
 	exit(2);
@@ -113,8 +115,9 @@ int main(int argc, char *argv[])
 	FILE *outf = NULL;
 	int outversion = 3;
 	int reservenum = 1;
+	int boot_cpuid_phys = 0xfeedbeef;
 
-	while ((opt = getopt(argc, argv, "I:O:o:V:R:f")) != EOF) {
+	while ((opt = getopt(argc, argv, "I:O:o:V:R:fb:")) != EOF) {
 		switch (opt) {
 		case 'I':
 			inform = optarg;
@@ -134,6 +137,9 @@ int main(int argc, char *argv[])
 		case 'f':
 			force = 1;
 			break;
+		case 'b':
+			boot_cpuid_phys = strtol(optarg, NULL, 0);
+			break;
 		default:
 			usage();
 		}
@@ -167,7 +173,7 @@ int main(int argc, char *argv[])
 	if (! bi || ! bi->dt)
 		die("Couldn't read input tree\n");
 
-	if (! check_device_tree(bi->dt)) {
+	if (! check_device_tree(bi->dt, outversion, boot_cpuid_phys)) {
 		fprintf(stderr, "Input tree has errors\n");
 		if (! force)
 			exit(1);
@@ -185,9 +191,9 @@ int main(int argc, char *argv[])
 	if (streq(outform, "dts")) {
 		dt_to_source(outf, bi);
 	} else if (streq(outform, "dtb")) {
-		dt_to_blob(outf, bi, outversion);
+		dt_to_blob(outf, bi, outversion, boot_cpuid_phys);
 	} else if (streq(outform, "asm")) {
-		dt_to_asm(outf, bi, outversion);
+		dt_to_asm(outf, bi, outversion, boot_cpuid_phys);
 	} else if (streq(outform, "null")) {
 		/* do nothing */
 	} else {
Index: dtc/dtc.h
===================================================================
--- dtc.orig/dtc.h
+++ dtc/dtc.h
@@ -178,7 +178,7 @@ struct node *chain_node(struct node *fir
 void add_property(struct node *node, struct property *prop);
 void add_child(struct node *parent, struct node *child);
 
-int check_device_tree(struct node *dt);
+int check_device_tree(struct node *dt, int outversion, int boot_cpuid_phys);
 
 /* Boot info (tree plus memreserve information */
 
@@ -207,8 +207,10 @@ struct boot_info *build_boot_info(struct
 
 /* Flattened trees */
 
-void dt_to_blob(FILE *f, struct boot_info *bi, int version);
-void dt_to_asm(FILE *f, struct boot_info *bi, int version);
+void dt_to_blob(FILE *f, struct boot_info *bi, int version,
+		int boot_cpuid_phys);
+void dt_to_asm(FILE *f, struct boot_info *bi, int version,
+	       int boot_cpuid_phys);
 
 struct boot_info *dt_from_blob(FILE *f);
 
Index: dtc/flattree.c
===================================================================
--- dtc.orig/flattree.c
+++ dtc/flattree.c
@@ -301,7 +301,8 @@ static struct data flatten_reserve_list(
 }
 static void make_bph(struct boot_param_header *bph,
 		     struct version_info *vi,
-		     int reservesize, int dtsize, int strsize)
+		     int reservesize, int dtsize, int strsize,
+		     int boot_cpuid_phys)
 {
 	int reserve_off;
 
@@ -324,12 +325,13 @@ static void make_bph(struct boot_param_h
 				     + dtsize + strsize);
 		
 	if (vi->flags & FTF_BOOTCPUID)
-		bph->boot_cpuid_phys = 0xfeedbeef;
+		bph->boot_cpuid_phys = cpu_to_be32(boot_cpuid_phys);
 	if (vi->flags & FTF_STRTABSIZE)
 		bph->size_dt_strings = cpu_to_be32(strsize);
 }
 
-void dt_to_blob(FILE *f, struct boot_info *bi, int version)
+void dt_to_blob(FILE *f, struct boot_info *bi, int version,
+		int boot_cpuid_phys)
 {
 	struct version_info *vi = NULL;
 	int i;
@@ -355,7 +357,8 @@ void dt_to_blob(FILE *f, struct boot_inf
 	reservebuf = flatten_reserve_list(bi->reservelist, vi);
 
 	/* Make header */
-	make_bph(&bph, vi, reservebuf.len, dtbuf.len, strbuf.len);
+	make_bph(&bph, vi, reservebuf.len, dtbuf.len, strbuf.len,
+		 boot_cpuid_phys);
 
 	fwrite(&bph, vi->hdr_size, 1, f);
 
@@ -395,7 +398,7 @@ static void dump_stringtable_asm(FILE *f
 	}
 }
 
-void dt_to_asm(FILE *f, struct boot_info *bi, int version)
+void dt_to_asm(FILE *f, struct boot_info *bi, int version, int boot_cpuid_phys)
 {
 	struct version_info *vi = NULL;
 	int i;
@@ -434,7 +437,8 @@ void dt_to_asm(FILE *f, struct boot_info
 		vi->last_comp_version);
 
 	if (vi->flags & FTF_BOOTCPUID)
-		fprintf(f, "\t.long\t0xdeadbeef\t/*boot_cpuid_phys*/\n");
+		fprintf(f, "\t.long\t%i\t/*boot_cpuid_phys*/\n",
+			boot_cpuid_phys);
 
 	if (vi->flags & FTF_STRTABSIZE)
 		fprintf(f, "\t.long\t_%s_strings_end - _%s_strings_start\t/* size_dt_strings */\n",
Index: dtc/livetree.c
===================================================================
--- dtc.orig/livetree.c
+++ dtc/livetree.c
@@ -456,7 +456,7 @@ static int check_root(struct node *root)
 	return ok;
 }
 
-static int check_cpus(struct node *root)
+static int check_cpus(struct node *root, int outversion, int boot_cpuid_phys)
 {
 	struct node *cpus, *cpu;
 	struct property *prop;
@@ -518,8 +518,15 @@ static int check_cpus(struct node *root)
 		}
 	}
 
-	if (! bootcpu)
-		WARNMSG("No cpu has \"linux,boot-cpu\" property\n");
+	if (outversion < 2) {
+		if (! bootcpu)
+			WARNMSG("No cpu has \"linux,boot-cpu\" property\n");
+	} else {
+		if (bootcpu)
+			WARNMSG("\"linux,boot-cpu\" property is deprecated in blob version 2 or higher\n");
+		if (boot_cpuid_phys == 0xfeedbeef)
+			WARNMSG("physical boot CPU not set.  Use -b option to set\n");
+	}
 
 	return ok;	
 }
@@ -697,7 +704,7 @@ static void fixup_phandles(struct node *
 		fixup_phandles(root, child);
 }
 
-int check_device_tree(struct node *dt)
+int check_device_tree(struct node *dt, int outversion, int boot_cpuid_phys)
 {
 	int ok = 1;
 
@@ -713,7 +720,7 @@ int check_device_tree(struct node *dt)
 		return 0;
 
 	ok = ok && check_root(dt);
-	ok = ok && check_cpus(dt);
+	ok = ok && check_cpus(dt, outversion, boot_cpuid_phys);
 	ok = ok && check_memory(dt);
 	ok = ok && check_chosen(dt);
 	if (! ok)
