Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [208.123.74.7])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CEB3BDDDFC
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Feb 2007 02:36:27 +1100 (EST)
Received: from jdl (helo=jdl.com) by jdl.com with local-esmtp (Exim 4.63)
	(envelope-from <jdl@jdl.com>) id 1HI58I-0003ZF-Ka
	for linuxppc-dev@ozlabs.org; Fri, 16 Feb 2007 09:36:23 -0600
To: linuxppc-dev@ozlabs.org
Subject: [DTC PATCH] Moved data_convert_cell() out of data.c to the parser.
Date: Fri, 16 Feb 2007 09:36:22 -0600
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1HI58I-0003ZF-Ka@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

It constructs a cell_t, not data objects.
Renamed it to cell_from_string() as well.

Signed-off-by: Jon Loeliger <jdl@freescale.com>
---

I've updated the DTC repo on jdl.com to have these patches
applied to it now!


 data.c       |   20 --------------------
 dtc-parser.y |   30 +++++++++++++++++++++++++++---
 dtc.h        |    1 -
 3 files changed, 27 insertions(+), 24 deletions(-)

diff --git a/data.c b/data.c
index c6c2350..5d7db17 100644
--- a/data.c
+++ b/data.c
@@ -225,26 +225,6 @@ struct data data_merge(struct data d1, struct data d2)
 	return d;
 }
 
-/*
- * Convert a string representation of a numberic cell
- * in the given base into a cell.
- */
-cell_t data_convert_cell(char *s, unsigned int base)
-{
-	cell_t c;
-	extern YYLTYPE yylloc;
-
-	c = strtoul(s, NULL, base);
-	if (errno == EINVAL || errno == ERANGE) {
-		fprintf(stderr,
-			"Line %d: Invalid cell value '%s'; %d assumed\n",
-			yylloc.first_line, s, c);
-	}
-
-	return c;
-}
-
-
 struct data data_append_cell(struct data d, cell_t word)
 {
 	cell_t beword = cpu_to_be32(word);
diff --git a/dtc-parser.y b/dtc-parser.y
index 992fdb1..a8902fc 100644
--- a/dtc-parser.y
+++ b/dtc-parser.y
@@ -24,8 +24,9 @@
 %{
 #include "dtc.h"
 
-int yylex (void);
-void yyerror (char const *);
+int yylex(void);
+void yyerror(char const *);
+cell_t cell_from_string(char *s, unsigned int base);
 
 extern struct boot_info *the_boot_info;
 
@@ -144,7 +145,7 @@ opt_cell_base:
 
 celllist:	celllist opt_cell_base DT_CELL {
 			$$ = data_append_cell($1,
-					      data_convert_cell($3, $2));
+					      cell_from_string($3, $2));
 		}
 	|	celllist DT_REF	{
 			$$ = data_append_cell(data_add_fixup($1, $2), -1);
@@ -179,3 +180,26 @@ void yyerror (char const *s)
 {
 	fprintf (stderr, "%s at line %d\n", s, yylloc.first_line);
 }
+
+
+/*
+ * Convert a string representation of a numeric cell
+ * in the given base into a cell.
+ *
+ * FIXME: The string "abc123", base 10, should be flagged
+ *        as an error due to the leading "a", but isn't yet.
+ */
+
+cell_t cell_from_string(char *s, unsigned int base)
+{
+	cell_t c;
+
+	c = strtoul(s, NULL, base);
+	if (errno == EINVAL || errno == ERANGE) {
+		fprintf(stderr,
+			"Line %d: Invalid cell value '%s'; %d assumed\n",
+			yylloc.first_line, s, c);
+	}
+
+	return c;
+}
diff --git a/dtc.h b/dtc.h
index 7ee96a5..8d3964c 100644
--- a/dtc.h
+++ b/dtc.h
@@ -118,7 +118,6 @@ struct data data_copy_mem(char *mem, int len);
 struct data data_copy_escape_string(char *s, int len);
 struct data data_copy_file(FILE *f, size_t len);
 
-cell_t data_convert_cell(char *s, unsigned int base);
 struct data data_append_data(struct data d, void *p, int len);
 struct data data_merge(struct data d1, struct data d2);
 struct data data_append_cell(struct data d, cell_t word);
-- 
1.5.0.rc3.ge4b0e
