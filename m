Return-Path: <jdl@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 9567DDDEDB
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Mar 2007 04:44:29 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l2SIiPUf013080
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Mar 2007 11:44:25 -0700 (MST)
Received: from ld0161-tx32 (ld0161-tx32.am.freescale.net [10.82.19.111])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l2SIiOo8002810
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Mar 2007 13:44:24 -0500 (CDT)
Subject: [PATCH] DTC: Incorporate some review suggestions.
From: Jon Loeliger <jdl@freescale.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1175107464.32390.253.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Wed, 28 Mar 2007 13:44:24 -0500
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

    - Change include syntax to:  /include/ "filename"
    - Move private functions directly into dtc-lexer.l
    - Define YYID for some older parser templates

Also fix a #include ordering problem around YYLTPE.

Signed-off-by; Jon Loeliger <jdl@freescale.com>
Acked-by: Haiying Wang <Haiying.Wang@freescale.com>

---

 dtc-lexer.l   |  111 ++++++++++++++++++++++++++++++++++++++++++++-
 srcpos.h      |    7 ++-
 srcposstack.h |  138 ---------------------------------------------------------
 3 files changed, 113 insertions(+), 143 deletions(-)
 delete mode 100644 srcposstack.h

diff --git a/dtc-lexer.l b/dtc-lexer.l
index 45f66ef..57ac6db 100644
--- a/dtc-lexer.l
+++ b/dtc-lexer.l
@@ -33,8 +33,8 @@ REFCHAR		({PROPCHAR}|{UNITCHAR}|[/@])
 
 %{
 #include "dtc.h"
+#include "srcpos.h"
 #include "dtc-parser.tab.h"
-#include "srcposstack.h"
 
 
 /*#define LEXDEBUG	1*/
@@ -51,9 +51,8 @@ REFCHAR		({PROPCHAR}|{UNITCHAR}|[/@])
 
 %%
 
-#[ \t]*include		BEGIN(INCLUDE);
+"/include/"		BEGIN(INCLUDE);
 
-<INCLUDE>[ \t]*		/* whitespace before file name */
 <INCLUDE>\"[^"\n]*\"	{
 			yytext[strlen(yytext) - 1] = 0;
 			if (!push_input_file(yytext + 1)) {
@@ -233,3 +232,109 @@ REFCHAR		({PROPCHAR}|{UNITCHAR}|[/@])
 		}
 
 %%
+
+
+/*
+ * Stack of nested include file contexts.
+ */
+
+struct incl_file {
+	int filenum;
+	FILE *file;
+	YY_BUFFER_STATE yy_prev_buf;
+	int yy_prev_lineno;
+	struct incl_file *prev;
+};
+
+struct incl_file *incl_file_stack;
+
+
+/*
+ * Detect infinite include recursion.
+ */
+#define MAX_INCLUDE_DEPTH	(100)
+
+static int incl_depth = 0;
+
+
+int push_input_file(const char *filename)
+{
+	FILE *f;
+	struct incl_file *incl_file;
+
+	if (!filename) {
+		yyerror("No include file name given.");
+		return 0;
+	}
+
+	if (incl_depth++ >= MAX_INCLUDE_DEPTH) {
+		yyerror("Includes nested too deeply");
+		return 0;
+	}
+
+	f = dtc_open_file(filename);
+
+	incl_file = malloc(sizeof(struct incl_file));
+	if (!incl_file) {
+		yyerror("Can not allocate include file space.");
+		return 0;
+	}
+
+	/*
+	 * Save current context.
+	 */
+	incl_file->yy_prev_buf = YY_CURRENT_BUFFER;
+	incl_file->yy_prev_lineno = yylineno;
+	incl_file->filenum = srcpos_filenum;
+	incl_file->file = yyin;
+	incl_file->prev = incl_file_stack;
+
+	incl_file_stack = incl_file;
+
+	/*
+	 * Establish new context.
+	 */	 
+	srcpos_filenum = lookup_file_name(filename, 0);
+	yylineno = 1;
+	yyin = f;
+	yy_switch_to_buffer(yy_create_buffer(yyin, YY_BUF_SIZE));
+
+	return 1;
+}
+
+
+int pop_input_file(void)
+{
+	struct incl_file *incl_file;
+	
+	if (incl_file_stack == 0)
+		return 0;
+
+	fclose(yyin);
+
+	/*
+	 * Pop.
+	 */
+	--incl_depth;
+	incl_file = incl_file_stack;
+	incl_file_stack = incl_file->prev;
+
+	/*
+	 * Recover old context.
+	 */			 
+	yy_delete_buffer(YY_CURRENT_BUFFER);
+	yy_switch_to_buffer(incl_file->yy_prev_buf);
+	yylineno = incl_file->yy_prev_lineno;
+	srcpos_filenum = incl_file->filenum;
+	yyin = incl_file->file;
+
+	/*
+	 * Free old state.
+	 */
+	free(incl_file);
+
+	if (YY_CURRENT_BUFFER == 0)
+		return 0;
+	
+	return 1;
+}
diff --git a/srcpos.h b/srcpos.h
index 7ad0bf5..cdf6810 100644
--- a/srcpos.h
+++ b/srcpos.h
@@ -22,7 +22,7 @@
  * array of all opened filenames.
  */
 
-#if ! defined YYLTYPE && ! defined YYLTYPE_IS_DECLARED
+#if ! defined(YYLTYPE) && ! defined(YYLTYPE_IS_DECLARED)
 typedef struct YYLTYPE {
     int first_line;
     int first_column;
@@ -35,6 +35,10 @@ typedef struct YYLTYPE {
 #define YYLTYPE_IS_TRIVIAL	1
 #endif
 
+/* Cater to old parser templates. */
+#ifndef YYID
+#define YYID(n)	(n)
+#endif
 
 #define YYLLOC_DEFAULT(Current, Rhs, N)					\
     do									\
@@ -68,4 +72,3 @@ extern FILE *dtc_open_file(const char *fname);
 extern int lookup_file_name(const char *fname, int add_it);
 extern const char *srcpos_filename_for_num(int filenum);
 const char *srcpos_get_filename(void);
-
diff --git a/srcposstack.h b/srcposstack.h
deleted file mode 100644
index b4a459b..0000000
--- a/srcposstack.h
+++ /dev/null
@@ -1,138 +0,0 @@
-/*
- * Copyright 2007 Jon Loeliger, Freescale Semiconductor, Inc.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of the
- * License, or (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  General Public License for more details.
- *                                                                       
- *  You should have received a copy of the GNU General Public License    
- *  along with this program; if not, write to the Free Software          
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 
- *                                                                   USA 
- */
-
-#include "srcpos.h"
-
-
-/*
- * This code should only be included into the lexical analysis.
- * It references global context symbols that are only present
- * in the generated lex.yy,c file.
- */
-
-#ifdef FLEX_SCANNER
-
-
-/*
- * Stack of nested include file contexts.
- */
-
-struct incl_file {
-	int filenum;
-	FILE *file;
-	YY_BUFFER_STATE yy_prev_buf;
-	int yy_prev_lineno;
-	struct incl_file *prev;
-};
-
-struct incl_file *incl_file_stack;
-
-
-/*
- * Detect infinite include recursion.
- */
-#define MAX_INCLUDE_DEPTH	(100)
-
-static int incl_depth = 0;
-
-
-
-int push_input_file(const char *filename)
-{
-	FILE *f;
-	struct incl_file *incl_file;
-
-	if (!filename) {
-		yyerror("No include file name given.");
-		return 0;
-	}
-
-	if (incl_depth++ >= MAX_INCLUDE_DEPTH) {
-		yyerror("Includes nested too deeply");
-		return 0;
-	}
-
-	f = dtc_open_file(filename);
-
-	incl_file = malloc(sizeof(struct incl_file));
-	if (!incl_file) {
-		yyerror("Can not allocate include file space.");
-		return 0;
-	}
-
-	/*
-	 * Save current context.
-	 */
-	incl_file->yy_prev_buf = YY_CURRENT_BUFFER;
-	incl_file->yy_prev_lineno = yylineno;
-	incl_file->filenum = srcpos_filenum;
-	incl_file->file = yyin;
-	incl_file->prev = incl_file_stack;
-
-	incl_file_stack = incl_file;
-
-	/*
-	 * Establish new context.
-	 */	 
-	srcpos_filenum = lookup_file_name(filename, 0);
-	yylineno = 1;
-	yyin = f;
-	yy_switch_to_buffer(yy_create_buffer(yyin, YY_BUF_SIZE));
-
-	return 1;
-}
-
-
-int pop_input_file(void)
-{
-	struct incl_file *incl_file;
-	
-	if (incl_file_stack == 0)
-		return 0;
-
-	fclose(yyin);
-
-	/*
-	 * Pop.
-	 */
-	--incl_depth;
-	incl_file = incl_file_stack;
-	incl_file_stack = incl_file->prev;
-
-	/*
-	 * Recover old context.
-	 */			 
-	yy_delete_buffer(YY_CURRENT_BUFFER);
-	yy_switch_to_buffer(incl_file->yy_prev_buf);
-	yylineno = incl_file->yy_prev_lineno;
-	srcpos_filenum = incl_file->filenum;
-	yyin = incl_file->file;
-
-	/*
-	 * Free old state.
-	 */
-	free(incl_file);
-
-	if (YY_CURRENT_BUFFER == 0)
-		return 0;
-	
-	return 1;
-}
-
-#endif	/* FLEX_SCANNER */
-- 
1.5.0.3
