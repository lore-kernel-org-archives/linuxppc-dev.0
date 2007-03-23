Return-Path: <jdl@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 57B77DDEDB
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Mar 2007 07:18:47 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l2NKIgOc027595
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Mar 2007 13:18:42 -0700 (MST)
Received: from ld0161-tx32 (ld0161-tx32.am.freescale.net [10.82.19.111])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l2NKIfXH015685
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Mar 2007 15:18:41 -0500 (CDT)
Subject: [PATCH] DTC: Add support for a C-like #include "file" mechanism.
From: Jon Loeliger <jdl@freescale.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1174681120.32390.82.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Fri, 23 Mar 2007 15:18:41 -0500
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Keeps track of open files in a stack, and assigns
a filenum to source positions for each lexical token.
Modified error reporting to show source file as well.
No policy on file directory basis has been decided.
Still handles stdin.

Tested on all arch/powerpc/boot/dts DTS files

Signed-off-by: Jon Loeliger <jdl@freescale.com>
---
 Makefile      |    3 +-
 dtc-lexer.l   |   39 ++++++++++++++++-
 dtc-parser.y  |    9 +++-
 dtc.c         |   19 +-------
 dtc.h         |    2 +-
 srcpos.c      |  105 +++++++++++++++++++++++++++++++++++++++++++
 srcpos.h      |   71 +++++++++++++++++++++++++++++
 srcposstack.h |  138 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 treesource.c  |    6 ++-
 9 files changed, 369 insertions(+), 23 deletions(-)
 create mode 100644 srcpos.c
 create mode 100644 srcpos.h
 create mode 100644 srcposstack.h

diff --git a/Makefile b/Makefile
index cdea9a2..280db78 100644
--- a/Makefile
+++ b/Makefile
@@ -3,7 +3,8 @@ CFLAGS = -Wall -g
 
 BISON = bison
 
-DTC_OBJS = dtc.o livetree.o flattree.o data.o treesource.o fstree.o \
+DTC_OBJS = dtc.o flattree.o fstree.o data.o livetree.o \
+		srcpos.o treesource.o \
 		dtc-parser.tab.o lex.yy.o
 
 DEPFILES = $(DTC_OBJS:.o=.d)
diff --git a/dtc-lexer.l b/dtc-lexer.l
index 93f3268..45f66ef 100644
--- a/dtc-lexer.l
+++ b/dtc-lexer.l
@@ -20,6 +20,7 @@
 
 %option noyywrap nounput yylineno
 
+%x INCLUDE
 %x CELLDATA
 %x BYTESTRING
 %x MEMRESERVE
@@ -32,8 +33,9 @@ REFCHAR		({PROPCHAR}|{UNITCHAR}|[/@])
 
 %{
 #include "dtc.h"
-
 #include "dtc-parser.tab.h"
+#include "srcposstack.h"
+
 
 /*#define LEXDEBUG	1*/
 
@@ -49,7 +51,27 @@ REFCHAR		({PROPCHAR}|{UNITCHAR}|[/@])
 
 %%
 
+#[ \t]*include		BEGIN(INCLUDE);
+
+<INCLUDE>[ \t]*		/* whitespace before file name */
+<INCLUDE>\"[^"\n]*\"	{
+			yytext[strlen(yytext) - 1] = 0;
+			if (!push_input_file(yytext + 1)) {
+				/* Some unrecoverable error.*/
+				exit(1);
+			}
+			BEGIN(INITIAL);
+		}
+
+
+<<EOF>>		{
+			if (!pop_input_file()) {
+				yyterminate();
+			}
+		}
+
 \"[^"]*\"	{
+			yylloc.filenum = srcpos_filenum;
 			yylloc.first_line = yylineno;
 			DPRINT("String: %s\n", yytext);
 			yylval.data = data_copy_escape_string(yytext+1,
@@ -59,6 +81,7 @@ REFCHAR		({PROPCHAR}|{UNITCHAR}|[/@])
 		}
 
 "/memreserve/"	{
+			yylloc.filenum = srcpos_filenum;
 			yylloc.first_line = yylineno;
 			DPRINT("Keyword: /memreserve/\n");
 			BEGIN(MEMRESERVE);
@@ -66,6 +89,7 @@ REFCHAR		({PROPCHAR}|{UNITCHAR}|[/@])
 		}
 
 <MEMRESERVE>[0-9a-fA-F]+ {
+			yylloc.filenum = srcpos_filenum;
 			yylloc.first_line = yylineno;
 			if (yyleng > 2*sizeof(yylval.addr)) {
 				fprintf(stderr, "Address value %s too large\n",
@@ -78,12 +102,14 @@ REFCHAR		({PROPCHAR}|{UNITCHAR}|[/@])
 		}
 
 <MEMRESERVE>";"	{
+			yylloc.filenum = srcpos_filenum;
 			yylloc.first_line = yylineno;
 			DPRINT("/MEMRESERVE\n");
 			BEGIN(INITIAL);
 			return ';';
 		}
 <CELLDATA>[bodh]# {
+			yylloc.filenum = srcpos_filenum;
 			yylloc.first_line = yylineno;
 			if (*yytext == 'b')
 				yylval.cbase = 2;
@@ -98,6 +124,7 @@ REFCHAR		({PROPCHAR}|{UNITCHAR}|[/@])
 		}
 
 <CELLDATA>[0-9a-fA-F]+	{
+			yylloc.filenum = srcpos_filenum;
 			yylloc.first_line = yylineno;
 			yylval.str = strdup(yytext);
 			DPRINT("Cell: '%s'\n", yylval.str);
@@ -105,6 +132,7 @@ REFCHAR		({PROPCHAR}|{UNITCHAR}|[/@])
 		}
 
 <CELLDATA>">"	{
+			yylloc.filenum = srcpos_filenum;
 			yylloc.first_line = yylineno;
 			DPRINT("/CELLDATA\n");
 			BEGIN(INITIAL);
@@ -112,6 +140,7 @@ REFCHAR		({PROPCHAR}|{UNITCHAR}|[/@])
 		}
 
 <CELLDATA>\&{REFCHAR}*	{
+			yylloc.filenum = srcpos_filenum;
 			yylloc.first_line = yylineno;
 			DPRINT("Ref: %s\n", yytext+1);
 			yylval.str = strdup(yytext+1);
@@ -119,6 +148,7 @@ REFCHAR		({PROPCHAR}|{UNITCHAR}|[/@])
 		}
 
 <BYTESTRING>[0-9a-fA-F]{2} {
+			yylloc.filenum = srcpos_filenum;
 			yylloc.first_line = yylineno;
 			yylval.byte = strtol(yytext, NULL, 16);
 			DPRINT("Byte: %02x\n", (int)yylval.byte);
@@ -126,6 +156,7 @@ REFCHAR		({PROPCHAR}|{UNITCHAR}|[/@])
 		}
 
 <BYTESTRING>"]"	{
+			yylloc.filenum = srcpos_filenum;
 			yylloc.first_line = yylineno;
 			DPRINT("/BYTESTRING\n");
 			BEGIN(INITIAL);
@@ -135,6 +166,7 @@ REFCHAR		({PROPCHAR}|{UNITCHAR}|[/@])
 ,		{ /* Technically this is a valid property name,
 		     but we'd rather use it as punctuation, so detect it
 		     here in preference */
+			yylloc.filenum = srcpos_filenum;
 			yylloc.first_line = yylineno;
 			DPRINT("Char (propname like): %c (\\x%02x)\n", yytext[0],
 				(unsigned)yytext[0]);
@@ -142,6 +174,7 @@ REFCHAR		({PROPCHAR}|{UNITCHAR}|[/@])
 		}
 
 {PROPCHAR}+	{
+			yylloc.filenum = srcpos_filenum;
 			yylloc.first_line = yylineno;
 			DPRINT("PropName: %s\n", yytext);
 			yylval.str = strdup(yytext);
@@ -149,6 +182,7 @@ REFCHAR		({PROPCHAR}|{UNITCHAR}|[/@])
 		}
 
 {PROPCHAR}+(@{UNITCHAR}+)? {
+			yylloc.filenum = srcpos_filenum;
 			yylloc.first_line = yylineno;
 			DPRINT("NodeName: %s\n", yytext);
 			yylval.str = strdup(yytext);
@@ -157,6 +191,7 @@ REFCHAR		({PROPCHAR}|{UNITCHAR}|[/@])
 
 
 [a-zA-Z_][a-zA-Z0-9_]*:	{
+			yylloc.filenum = srcpos_filenum;
 			yylloc.first_line = yylineno;
 			DPRINT("Label: %s\n", yytext);
 			yylval.str = strdup(yytext);
@@ -167,6 +202,7 @@ REFCHAR		({PROPCHAR}|{UNITCHAR}|[/@])
 <*>{WS}+	/* eat whitespace */
 
 <*>"/*"([^*]|\*+[^*/])*\*+"/"	{
+			yylloc.filenum = srcpos_filenum;
 			yylloc.first_line = yylineno;
 			DPRINT("Comment: %s\n", yytext);
 			/* eat comments */
@@ -175,6 +211,7 @@ REFCHAR		({PROPCHAR}|{UNITCHAR}|[/@])
 <*>"//".*\n	/* eat line comments */
 
 <*>.		{
+			yylloc.filenum = srcpos_filenum;
 			yylloc.first_line = yylineno;
 			switch (yytext[0]) {
 				case '<':
diff --git a/dtc-parser.y b/dtc-parser.y
index a8902fc..39d9dac 100644
--- a/dtc-parser.y
+++ b/dtc-parser.y
@@ -23,6 +23,7 @@
 
 %{
 #include "dtc.h"
+#include "srcpos.h"
 
 int yylex(void);
 void yyerror(char const *);
@@ -178,7 +179,13 @@ label:		DT_LABEL	{ $$ = $1; }
 
 void yyerror (char const *s)
 {
-	fprintf (stderr, "%s at line %d\n", s, yylloc.first_line);
+	const char *fname = srcpos_filename_for_num(yylloc.filenum);
+
+	if (strcmp(fname, "-") == 0)
+		fname = "stdin";
+
+	fprintf(stderr, "%s:%d %s\n",
+		fname, yylloc.first_line, s);
 }
 
 
diff --git a/dtc.c b/dtc.c
index 051a68b..a009605 100644
--- a/dtc.c
+++ b/dtc.c
@@ -19,6 +19,7 @@
  */
 
 #include "dtc.h"
+#include "srcpos.h"
 
 char *join_path(char *path, char *name)
 {
@@ -61,21 +62,6 @@ void fill_fullpaths(struct node *tree, char *prefix)
 		fill_fullpaths(child, tree->fullpath);
 }
 
-static FILE *dtc_open_file(char *fname)
-{
-	FILE *f;
-
-	if (streq(fname, "-"))
-		f = stdin;
-	else
-		f = fopen(fname, "r");
-
-	if (! f)
-		die("Couldn't open \"%s\": %s\n", fname, strerror(errno));
-
-	return f;
-}
-
 static void usage(void)
 {
 	fprintf(stderr, "Usage:\n");
@@ -166,8 +152,7 @@ int main(int argc, char *argv[])
 		inform, outform, arg);
 
 	if (streq(inform, "dts")) {
-		inf = dtc_open_file(arg);
-		bi = dt_from_source(inf);
+		bi = dt_from_source(arg);
 	} else if (streq(inform, "fs")) {
 		bi = dt_from_fs(arg);
 	} else if(streq(inform, "dtb")) {
diff --git a/dtc.h b/dtc.h
index e3e2863..7ed3df2 100644
--- a/dtc.h
+++ b/dtc.h
@@ -223,7 +223,7 @@ struct boot_info *dt_from_blob(FILE *f);
 /* Tree source */
 
 void dt_to_source(FILE *f, struct boot_info *bi);
-struct boot_info *dt_from_source(FILE *f);
+struct boot_info *dt_from_source(const char *f);
 
 /* FS trees */
 
diff --git a/srcpos.c b/srcpos.c
new file mode 100644
index 0000000..44eee5d
--- /dev/null
+++ b/srcpos.c
@@ -0,0 +1,105 @@
+/*
+ * Copyright 2007 Jon Loeliger, Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of the
+ * License, or (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *                                                                       
+ *  You should have received a copy of the GNU General Public License    
+ *  along with this program; if not, write to the Free Software          
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 
+ *                                                                   USA 
+ */
+
+#include "dtc.h"
+#include "srcpos.h"
+
+
+/*
+ * Record the complete unique set of opened file names.
+ * Primarily used to cache source position file names.
+ */
+#define MAX_N_FILE_NAMES	(100)
+
+const char *file_names[MAX_N_FILE_NAMES];
+static int n_file_names = 0;
+
+/*
+ * Like yylineno, this is the current open file pos.
+ */
+
+int srcpos_filenum = -1;
+
+
+
+FILE *dtc_open_file(const char *fname)
+{
+	FILE *f;
+
+	if (lookup_file_name(fname, 1) < 0)
+		die("Too many files opened\n");
+
+	if (streq(fname, "-"))
+		f = stdin;
+	else
+		f = fopen(fname, "r");
+
+	if (! f)
+		die("Couldn't open \"%s\": %s\n", fname, strerror(errno));
+
+	return f;
+}
+
+
+
+/*
+ * Locate and optionally add filename fname in the file_names[] array.
+ *
+ * If the filename is currently not in the array and the boolean
+ * add_it is non-zero, an attempt to add the filename will be made.
+ *
+ * Returns;
+ *    Index [0..MAX_N_FILE_NAMES) where the filename is kept
+ *    -1 if the name can not be recorded
+ */
+
+int lookup_file_name(const char *fname, int add_it)
+{
+	int i;
+
+	for (i = 0; i < n_file_names; i++) {
+		if (strcmp(file_names[i], fname) == 0)
+			return i;
+	}
+
+	if (add_it) {
+		if (n_file_names < MAX_N_FILE_NAMES) {
+			file_names[n_file_names] = strdup(fname);
+			return n_file_names++;
+		}
+	}
+
+	return -1;
+}
+
+
+const char *srcpos_filename_for_num(int filenum)
+{
+	if (0 <= filenum && filenum < n_file_names) {
+		return file_names[filenum];
+	}
+
+	return 0;
+}
+
+
+const char *srcpos_get_filename(void)
+{
+	return srcpos_filename_for_num(srcpos_filenum);
+}
diff --git a/srcpos.h b/srcpos.h
new file mode 100644
index 0000000..7ad0bf5
--- /dev/null
+++ b/srcpos.h
@@ -0,0 +1,71 @@
+/*
+ * Copyright 2007 Jon Loeliger, Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of the
+ * License, or (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *                                                                       
+ *  You should have received a copy of the GNU General Public License    
+ *  along with this program; if not, write to the Free Software          
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 
+ *                                                                   USA 
+ */
+
+/*
+ * Augment the standard YYLTYPE with a filenum index into an
+ * array of all opened filenames.
+ */
+
+#if ! defined YYLTYPE && ! defined YYLTYPE_IS_DECLARED
+typedef struct YYLTYPE {
+    int first_line;
+    int first_column;
+    int last_line;
+    int last_column;
+    int filenum;
+} YYLTYPE;
+
+#define YYLTYPE_IS_DECLARED	1
+#define YYLTYPE_IS_TRIVIAL	1
+#endif
+
+
+#define YYLLOC_DEFAULT(Current, Rhs, N)					\
+    do									\
+      if (YYID (N))							\
+	{								\
+	  (Current).first_line   = YYRHSLOC (Rhs, 1).first_line;	\
+	  (Current).first_column = YYRHSLOC (Rhs, 1).first_column;	\
+	  (Current).last_line    = YYRHSLOC (Rhs, N).last_line;		\
+	  (Current).last_column  = YYRHSLOC (Rhs, N).last_column;	\
+	  (Current).filenum      = YYRHSLOC (Rhs, N).filenum;		\
+	}								\
+      else								\
+	{								\
+	  (Current).first_line   = (Current).last_line   =		\
+	    YYRHSLOC (Rhs, 0).last_line;				\
+	  (Current).first_column = (Current).last_column =		\
+	    YYRHSLOC (Rhs, 0).last_column;				\
+	  (Current).filenum      = YYRHSLOC (Rhs, 0).filenum;		\
+	}								\
+    while (YYID (0))
+
+
+
+
+extern int srcpos_filenum;
+
+extern int push_input_file(const char *filename);
+extern int pop_input_file(void);
+
+extern FILE *dtc_open_file(const char *fname);
+extern int lookup_file_name(const char *fname, int add_it);
+extern const char *srcpos_filename_for_num(int filenum);
+const char *srcpos_get_filename(void);
+
diff --git a/srcposstack.h b/srcposstack.h
new file mode 100644
index 0000000..b4a459b
--- /dev/null
+++ b/srcposstack.h
@@ -0,0 +1,138 @@
+/*
+ * Copyright 2007 Jon Loeliger, Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of the
+ * License, or (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *                                                                       
+ *  You should have received a copy of the GNU General Public License    
+ *  along with this program; if not, write to the Free Software          
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 
+ *                                                                   USA 
+ */
+
+#include "srcpos.h"
+
+
+/*
+ * This code should only be included into the lexical analysis.
+ * It references global context symbols that are only present
+ * in the generated lex.yy,c file.
+ */
+
+#ifdef FLEX_SCANNER
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
+
+#endif	/* FLEX_SCANNER */
diff --git a/treesource.c b/treesource.c
index e9bbaa5..c067b20 100644
--- a/treesource.c
+++ b/treesource.c
@@ -19,6 +19,7 @@
  */
 
 #include "dtc.h"
+#include "srcpos.h"
 
 extern FILE *yyin;
 extern int yyparse(void);
@@ -26,11 +27,12 @@ extern void yyerror(char const *);
 
 struct boot_info *the_boot_info;
 
-struct boot_info *dt_from_source(FILE *f)
+struct boot_info *dt_from_source(const char *fname)
 {
 	the_boot_info = NULL;
 
-	yyin = f;
+	push_input_file(fname);
+
 	if (yyparse() != 0)
 		return NULL;
 
-- 
1.5.0.3
