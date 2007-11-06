Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [208.123.74.7])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6ED1EDDE25
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Nov 2007 09:19:26 +1100 (EST)
Received: from jdl (helo=jdl.com) by jdl.com with local-esmtp (Exim 4.63)
	(envelope-from <jdl@jdl.com>) id 1IpWlT-0007Qd-IX
	for linuxppc-dev@ozlabs.org; Tue, 06 Nov 2007 16:19:21 -0600
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] DTC: Polish up the DTS Version 1 implementation.
Date: Tue, 06 Nov 2007 16:19:19 -0600
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1IpWlT-0007Qd-IX@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Jon Loeliger <jdl@freescale.com>

Fixes BYTESTRING lexing.
Allows -O dts output to be emitted in a given (1) format version.
Skirts around a range check problem in eval_literal() for now.

Signed-off-by: Jon Loeliger <jdl@freescale.com>
---

David,

This patch is directly on top of your prior two patches.
Lemme know what you think.

jdl



 dtc-lexer.l  |    4 ++++
 dtc-parser.y |   13 ++++++++++---
 dtc.c        |    2 +-
 dtc.h        |    2 +-
 treesource.c |   39 +++++++++++++++++++++++++++------------
 5 files changed, 43 insertions(+), 17 deletions(-)

diff --git a/dtc-lexer.l b/dtc-lexer.l
index 1c262d2..b18c0d1 100644
--- a/dtc-lexer.l
+++ b/dtc-lexer.l
@@ -190,6 +190,10 @@ static int dts_version; /* = 0 */
 <*>.		{
 			yylloc.filenum = srcpos_filenum;
 			yylloc.first_line = yylineno;
+			if (yytext[0] == '[') {
+				DPRINT("BYTESTRING\n");
+				BEGIN(BYTESTRING);
+			}
 			if ((yytext[0] == '{')
 			    || (yytext[0] == ';')) {
 				DPRINT("<PROPNODENAME>\n");
diff --git a/dtc-parser.y b/dtc-parser.y
index ffb2299..652199f 100644
--- a/dtc-parser.y
+++ b/dtc-parser.y
@@ -297,17 +297,23 @@ label:
 
 %%
 
-void yyerror (char const *s)
+void yyerror(char const *s)
 {
 	const char *fname = srcpos_filename_for_num(yylloc.filenum);
 
 	if (strcmp(fname, "-") == 0)
 		fname = "stdin";
 
-	fprintf(stderr, "%s:%d %s\n",
+	fprintf(stderr, "%s:%d Error: %s\n",
 		fname, yylloc.first_line, s);
 }
 
+/*
+ * bits is unused, but it should be 32 or 64 as needed.
+ *
+ * FIXME: However, with bits == 64, ((1ULL << bits) - 1)
+ * overflows before you can actually do the range test.
+ */
 unsigned long long eval_literal(const char *s, int base, int bits)
 {
 	unsigned long long val;
@@ -317,9 +323,10 @@ unsigned long long eval_literal(const char *s, int base, int bits)
 	val = strtoull(s, &e, base);
 	if (*e)
 		yyerror("bad characters in literal");
-	else if ((errno == ERANGE) || (val > ((1ULL << bits)-1)))
+	else if (errno == ERANGE)
 		yyerror("literal out of range");
 	else if (errno != 0)
 		yyerror("bad literal");
+
 	return val;
 }
diff --git a/dtc.c b/dtc.c
index bbef829..38313f5 100644
--- a/dtc.c
+++ b/dtc.c
@@ -225,7 +225,7 @@ int main(int argc, char *argv[])
 	}
 
 	if (streq(outform, "dts")) {
-		dt_to_source(outf, bi);
+		dt_to_source(outf, bi, 1);
 	} else if (streq(outform, "dtb")) {
 		dt_to_blob(outf, bi, outversion, boot_cpuid_phys);
 	} else if (streq(outform, "asm")) {
diff --git a/dtc.h b/dtc.h
index d080153..ba2027b 100644
--- a/dtc.h
+++ b/dtc.h
@@ -238,7 +238,7 @@ struct boot_info *dt_from_blob(FILE *f);
 
 /* Tree source */
 
-void dt_to_source(FILE *f, struct boot_info *bi);
+void dt_to_source(FILE *f, struct boot_info *bi, int dts_version);
 struct boot_info *dt_from_source(const char *f);
 
 /* FS trees */
diff --git a/treesource.c b/treesource.c
index 376ebc8..ac0c777 100644
--- a/treesource.c
+++ b/treesource.c
@@ -140,14 +140,18 @@ static void write_propval_string(FILE *f, struct data val)
 	fprintf(f, "\";\n");
 }
 
-static void write_propval_cells(FILE *f, struct data val)
+static void write_propval_cells(FILE *f, struct data val, int dts_version)
 {
 	void *propend = val.val + val.len;
 	cell_t *cp = (cell_t *)val.val;
 
 	fprintf(f, " = <");
 	for (;;) {
-		fprintf(f, "%x", be32_to_cpu(*cp++));
+		if (dts_version == 0) {
+			fprintf(f, "%x", be32_to_cpu(*cp++));
+		} else {
+			fprintf(f, "0x%x", be32_to_cpu(*cp++));
+		}
 		if ((void *)cp >= propend)
 			break;
 		fprintf(f, " ");
@@ -155,14 +159,18 @@ static void write_propval_cells(FILE *f, struct data val)
 	fprintf(f, ">;\n");
 }
 
-static void write_propval_bytes(FILE *f, struct data val)
+static void write_propval_bytes(FILE *f, struct data val, int dts_version)
 {
 	void *propend = val.val + val.len;
 	char *bp = val.val;
 
 	fprintf(f, " = [");
 	for (;;) {
-		fprintf(f, "%02hhx", *bp++);
+		if (dts_version == 0) {
+			fprintf(f, "%02hhx", *bp++);
+		} else {
+			fprintf(f, "0x%02hhx", *bp++);
+		}
 		if ((void *)bp >= propend)
 			break;
 		fprintf(f, " ");
@@ -170,7 +178,7 @@ static void write_propval_bytes(FILE *f, struct data val)
 	fprintf(f, "];\n");
 }
 
-static void write_tree_source_node(FILE *f, struct node *tree, int level)
+static void write_tree_source_node(FILE *f, struct node *tree, int level, int dts_version)
 {
 	struct property *prop;
 	struct node *child;
@@ -202,35 +210,42 @@ static void write_tree_source_node(FILE *f, struct node *tree, int level)
 			break;
 
 		case PROP_CELLS:
-			write_propval_cells(f, prop->val);
+			write_propval_cells(f, prop->val, dts_version);
 			break;
 
 		case PROP_BYTES:
-			write_propval_bytes(f, prop->val);
+			write_propval_bytes(f, prop->val, dts_version);
 			break;
 		}
 	}
 	for_each_child(tree, child) {
 		fprintf(f, "\n");
-		write_tree_source_node(f, child, level+1);
+		write_tree_source_node(f, child, level + 1, dts_version);
 	}
 	write_prefix(f, level);
 	fprintf(f, "};\n");
 }
 
 
-void dt_to_source(FILE *f, struct boot_info *bi)
+void dt_to_source(FILE *f, struct boot_info *bi, int dts_version)
 {
 	struct reserve_info *re;
+	const char *fmt_str;
 
+	if (dts_version > 0) {
+		fprintf(f, "/dts-v1/;\n\n");
+		fmt_str = "/memreserve/\t0x%016llx 0x%016llx;\n";
+	} else {
+		fmt_str = "/memreserve/\t%016llx %016llx;\n";
+	}
 	for (re = bi->reservelist; re; re = re->next) {
 		if (re->label)
 			fprintf(f, "%s: ", re->label);
-		fprintf(f, "/memreserve/\t%016llx-%016llx;\n",
+		fprintf(f, fmt_str,
 			(unsigned long long)re->re.address,
 			(unsigned long long)(re->re.address + re->re.size - 1));
 	}
+	fprintf(f, "\n");
 
-	write_tree_source_node(f, bi->dt, 0);
+	write_tree_source_node(f, bi->dt, 0, dts_version);
 }
-
-- 
1.5.3.1.139.g9346b
