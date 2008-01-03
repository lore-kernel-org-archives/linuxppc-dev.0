Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 36CB3DDF36
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Jan 2008 10:43:51 +1100 (EST)
Date: Thu, 3 Jan 2008 17:43:31 -0600
From: Scott Wood <scottwood@freescale.com>
To: jdl@jdl.com
Subject: [PATCH 2/3] Look for include files in the directory of the including
	file.
Message-ID: <20080103234331.GB8441@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
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

Looking in the diretory dtc is invoked from is not very useful behavior.

As part of the code reorganization to implement this, I removed the
uniquifying of name storage -- it seemed a rather dubious optimization
given likely usage, and some aspects of it would have been mildly awkward
to integrate with the new code.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 dtc-lexer.l  |   64 +++++++++++++++++------------
 dtc-parser.y |    2 +-
 dtc.c        |   14 ++++--
 srcpos.c     |  126 +++++++++++++++++++++++++++++++---------------------------
 srcpos.h     |   28 +++++++++----
 5 files changed, 134 insertions(+), 100 deletions(-)

diff --git a/dtc-lexer.l b/dtc-lexer.l
index c811b22..bfb996e 100644
--- a/dtc-lexer.l
+++ b/dtc-lexer.l
@@ -74,7 +74,7 @@ static int dts_version; /* = 0 */
 		}
 
 <*>\"([^\\"]|\\.)*\"	{
-			yylloc.filenum = srcpos_filenum;
+			yylloc.file = srcpos_file;
 			yylloc.first_line = yylineno;
 			DPRINT("String: %s\n", yytext);
 			yylval.data = data_copy_escape_string(yytext+1,
@@ -84,7 +84,7 @@ static int dts_version; /* = 0 */
 		}
 
 <*>"/dts-v1/"	{
-			yylloc.filenum = srcpos_filenum;
+			yylloc.file = srcpos_file;
 			yylloc.first_line = yylineno;
 			DPRINT("Keyword: /dts-v1/\n");
 			dts_version = 1;
@@ -93,7 +93,7 @@ static int dts_version; /* = 0 */
 		}
 
 <*>"/memreserve/"	{
-			yylloc.filenum = srcpos_filenum;
+			yylloc.file = srcpos_file;
 			yylloc.first_line = yylineno;
 			DPRINT("Keyword: /memreserve/\n");
 			BEGIN_DEFAULT();
@@ -101,7 +101,7 @@ static int dts_version; /* = 0 */
 		}
 
 <*>{LABEL}:	{
-			yylloc.filenum = srcpos_filenum;
+			yylloc.file = srcpos_file;
 			yylloc.first_line = yylineno;
 			DPRINT("Label: %s\n", yytext);
 			yylval.labelref = strdup(yytext);
@@ -110,7 +110,7 @@ static int dts_version; /* = 0 */
 		}
 
 <INITIAL>[bodh]# {
-			yylloc.filenum = srcpos_filenum;
+			yylloc.file = srcpos_file;
 			yylloc.first_line = yylineno;
 			if (*yytext == 'b')
 				yylval.cbase = 2;
@@ -125,7 +125,7 @@ static int dts_version; /* = 0 */
 		}
 
 <INITIAL>[0-9a-fA-F]+	{
-			yylloc.filenum = srcpos_filenum;
+			yylloc.file = srcpos_file;
 			yylloc.first_line = yylineno;
 			yylval.literal = strdup(yytext);
 			DPRINT("Literal: '%s'\n", yylval.literal);
@@ -133,7 +133,7 @@ static int dts_version; /* = 0 */
 		}
 
 <V1>[0-9]+|0[xX][0-9a-fA-F]+      {
-			yylloc.filenum = srcpos_filenum;
+			yylloc.file = srcpos_file;
 			yylloc.first_line = yylineno;
 			yylval.literal = strdup(yytext);
 			DPRINT("Literal: '%s'\n", yylval.literal);
@@ -141,7 +141,7 @@ static int dts_version; /* = 0 */
 		}
 
 \&{LABEL}	{	/* label reference */
-			yylloc.filenum = srcpos_filenum;
+			yylloc.file = srcpos_file;
 			yylloc.first_line = yylineno;
 			DPRINT("Ref: %s\n", yytext+1);
 			yylval.labelref = strdup(yytext+1);
@@ -149,7 +149,7 @@ static int dts_version; /* = 0 */
 		}
 
 "&{/"{PATHCHAR}+\}	{	/* new-style path reference */
-			yylloc.filenum = srcpos_filenum;
+			yylloc.file = srcpos_file;
 			yylloc.first_line = yylineno;
 			yytext[yyleng-1] = '\0';
 			DPRINT("Ref: %s\n", yytext+2);
@@ -158,7 +158,7 @@ static int dts_version; /* = 0 */
 		}
 
 <INITIAL>"&/"{PATHCHAR}+ {	/* old-style path reference */
-			yylloc.filenum = srcpos_filenum;
+			yylloc.file = srcpos_file;
 			yylloc.first_line = yylineno;
 			DPRINT("Ref: %s\n", yytext+1);
 			yylval.labelref = strdup(yytext+1);
@@ -166,7 +166,7 @@ static int dts_version; /* = 0 */
 		}
 
 <BYTESTRING>[0-9a-fA-F]{2} {
-			yylloc.filenum = srcpos_filenum;
+			yylloc.file = srcpos_file;
 			yylloc.first_line = yylineno;
 			yylval.byte = strtol(yytext, NULL, 16);
 			DPRINT("Byte: %02x\n", (int)yylval.byte);
@@ -174,7 +174,7 @@ static int dts_version; /* = 0 */
 		}
 
 <BYTESTRING>"]"	{
-			yylloc.filenum = srcpos_filenum;
+			yylloc.file = srcpos_file;
 			yylloc.first_line = yylineno;
 			DPRINT("/BYTESTRING\n");
 			BEGIN_DEFAULT();
@@ -182,7 +182,7 @@ static int dts_version; /* = 0 */
 		}
 
 <PROPNODENAME>{PROPNODECHAR}+ {
-			yylloc.filenum = srcpos_filenum;
+			yylloc.file = srcpos_file;
 			yylloc.first_line = yylineno;
 			DPRINT("PropNodeName: %s\n", yytext);
 			yylval.propnodename = strdup(yytext);
@@ -190,11 +190,10 @@ static int dts_version; /* = 0 */
 			return DT_PROPNODENAME;
 		}
 
-
 <*>[[:space:]]+	/* eat whitespace */
 
 <*>"/*"([^*]|\*+[^*/])*\*+"/"	{
-			yylloc.filenum = srcpos_filenum;
+			yylloc.file = srcpos_file;
 			yylloc.first_line = yylineno;
 			DPRINT("Comment: %s\n", yytext);
 			/* eat comments */
@@ -203,7 +202,7 @@ static int dts_version; /* = 0 */
 <*>"//".*\n	/* eat line comments */
 
 <*>.		{
-			yylloc.filenum = srcpos_filenum;
+			yylloc.file = srcpos_file;
 			yylloc.first_line = yylineno;
 			DPRINT("Char: %c (\\x%02x)\n", yytext[0],
 				(unsigned)yytext[0]);
@@ -227,8 +226,7 @@ static int dts_version; /* = 0 */
  */
 
 struct incl_file {
-	int filenum;
-	FILE *file;
+	struct dtc_file *file;
 	YY_BUFFER_STATE yy_prev_buf;
 	int yy_prev_lineno;
 	struct incl_file *prev;
@@ -247,8 +245,9 @@ static int incl_depth = 0;
 
 int push_input_file(const char *filename)
 {
-	FILE *f;
 	struct incl_file *incl_file;
+	struct dtc_file *newfile;
+	struct search_path search, *searchptr = NULL;
 
 	if (!filename) {
 		yyerror("No include file name given.");
@@ -260,7 +259,19 @@ int push_input_file(const char *filename)
 		return 0;
 	}
 
-	f = dtc_open_file(filename);
+	if (srcpos_file) {
+		search.dir = srcpos_file->dir;
+		search.next = NULL;
+		search.prev = NULL;
+		searchptr = &search;
+	}
+
+	newfile = dtc_open_file(filename, searchptr);
+	if (!newfile) {
+		yyerrorf("Couldn't open \"%s\": %s",
+		         filename, strerror(errno));
+		exit(1);
+	}
 
 	incl_file = malloc(sizeof(struct incl_file));
 	if (!incl_file) {
@@ -273,8 +284,7 @@ int push_input_file(const char *filename)
 	 */
 	incl_file->yy_prev_buf = YY_CURRENT_BUFFER;
 	incl_file->yy_prev_lineno = yylineno;
-	incl_file->filenum = srcpos_filenum;
-	incl_file->file = yyin;
+	incl_file->file = srcpos_file;
 	incl_file->prev = incl_file_stack;
 
 	incl_file_stack = incl_file;
@@ -282,9 +292,9 @@ int push_input_file(const char *filename)
 	/*
 	 * Establish new context.
 	 */
-	srcpos_filenum = lookup_file_name(filename, 0);
+	srcpos_file = newfile;
 	yylineno = 1;
-	yyin = f;
+	yyin = newfile->file;
 	yy_switch_to_buffer(yy_create_buffer(yyin, YY_BUF_SIZE));
 
 	return 1;
@@ -298,7 +308,7 @@ int pop_input_file(void)
 	if (incl_file_stack == 0)
 		return 0;
 
-	fclose(yyin);
+	dtc_close_file(srcpos_file);
 
 	/*
 	 * Pop.
@@ -313,8 +323,8 @@ int pop_input_file(void)
 	yy_delete_buffer(YY_CURRENT_BUFFER);
 	yy_switch_to_buffer(incl_file->yy_prev_buf);
 	yylineno = incl_file->yy_prev_lineno;
-	srcpos_filenum = incl_file->filenum;
-	yyin = incl_file->file;
+	srcpos_file = incl_file->file;
+	yyin = incl_file->file ? incl_file->file->file : NULL;
 
 	/*
 	 * Free old state.
diff --git a/dtc-parser.y b/dtc-parser.y
index ddb7f27..8ed58e8 100644
--- a/dtc-parser.y
+++ b/dtc-parser.y
@@ -309,7 +309,7 @@ label:
 
 void yyerrorf(char const *s, ...)
 {
-	const char *fname = srcpos_filename_for_num(yylloc.filenum);
+	const char *fname = srcpos_file ? srcpos_file->name : "<no-file>";
 	va_list va;
 	va_start(va, s);
 
diff --git a/dtc.c b/dtc.c
index 6295b39..fb716f3 100644
--- a/dtc.c
+++ b/dtc.c
@@ -118,7 +118,7 @@ int main(int argc, char *argv[])
 	int force = 0, check = 0;
 	const char *arg;
 	int opt;
-	FILE *inf = NULL;
+	struct dtc_file *inf = NULL;
 	FILE *outf = NULL;
 	int outversion = DEFAULT_FDT_VERSION;
 	int boot_cpuid_phys = 0xfeedbeef;
@@ -192,14 +192,18 @@ int main(int argc, char *argv[])
 	} else if (streq(inform, "fs")) {
 		bi = dt_from_fs(arg);
 	} else if(streq(inform, "dtb")) {
-		inf = dtc_open_file(arg);
-		bi = dt_from_blob(inf);
+		inf = dtc_open_file(arg, NULL);
+		if (!inf)
+			die("Couldn't open \"%s\": %s\n", arg,
+			    strerror(errno));
+
+		bi = dt_from_blob(inf->file);
 	} else {
 		die("Unknown input format \"%s\"\n", inform);
 	}
 
-	if (inf && (inf != stdin))
-		fclose(inf);
+	if (inf && inf->file != stdin)
+		fclose(inf->file);
 
 	if (! bi || ! bi->dt)
 		die("Couldn't read input tree\n");
diff --git a/srcpos.c b/srcpos.c
index 352b0fe..7340c33 100644
--- a/srcpos.c
+++ b/srcpos.c
@@ -20,86 +20,94 @@
 #include "dtc.h"
 #include "srcpos.h"
 
-
-/*
- * Record the complete unique set of opened file names.
- * Primarily used to cache source position file names.
- */
-#define MAX_N_FILE_NAMES	(100)
-
-const char *file_names[MAX_N_FILE_NAMES];
-static int n_file_names = 0;
-
 /*
  * Like yylineno, this is the current open file pos.
  */
 
-int srcpos_filenum = -1;
-
+struct dtc_file *srcpos_file;
 
-
-FILE *dtc_open_file(const char *fname)
+static int dtc_open_one(struct dtc_file *file,
+                        const char *search,
+                        const char *fname)
 {
-	FILE *f;
-
-	if (lookup_file_name(fname, 1) < 0)
-		die("Too many files opened\n");
-
-	if (streq(fname, "-"))
-		f = stdin;
-	else
-		f = fopen(fname, "r");
+	char *fullname;
+
+	if (search) {
+		fullname = malloc(strlen(search) + strlen(fname) + 2);
+		if (!fullname)
+			die("Out of memory\n");
+
+		strcpy(fullname, search);
+		strcat(fullname, "/");
+		strcat(fullname, fname);
+	} else {
+		fullname = strdup(fname);
+	}
 
-	if (! f)
-		die("Couldn't open \"%s\": %s\n", fname, strerror(errno));
+	file->file = fopen(fullname, "r");
+	if (!file->file) {
+		free(fullname);
+		return 0;
+	}
 
-	return f;
+	file->name = fullname;
+	return 1;
 }
 
 
-
-/*
- * Locate and optionally add filename fname in the file_names[] array.
- *
- * If the filename is currently not in the array and the boolean
- * add_it is non-zero, an attempt to add the filename will be made.
- *
- * Returns;
- *    Index [0..MAX_N_FILE_NAMES) where the filename is kept
- *    -1 if the name can not be recorded
- */
-
-int lookup_file_name(const char *fname, int add_it)
+struct dtc_file *dtc_open_file(const char *fname,
+                               const struct search_path *search)
 {
-	int i;
-
-	for (i = 0; i < n_file_names; i++) {
-		if (strcmp(file_names[i], fname) == 0)
-			return i;
+	static const struct search_path default_search = { NULL, NULL, NULL };
+
+	struct dtc_file *file;
+	const char *slash;
+
+	file = malloc(sizeof(struct dtc_file));
+	if (!file)
+		die("Out of memory\n");
+
+	slash = strrchr(fname, '/');
+	if (slash) {
+		char *dir = malloc(slash - fname + 1);
+		if (!dir)
+			die("Out of memory\n");
+
+		memcpy(dir, fname, slash - fname);
+		dir[slash - fname] = 0;
+		file->dir = dir;
+	} else {
+		file->dir = NULL;
 	}
 
-	if (add_it) {
-		if (n_file_names < MAX_N_FILE_NAMES) {
-			file_names[n_file_names] = strdup(fname);
-			return n_file_names++;
-		}
+	if (streq(fname, "-")) {
+		file->name = "stdin";
+		file->file = stdin;
+		return file;
 	}
 
-	return -1;
-}
+	if (!search)
+		search = &default_search;
 
+	while (search) {
+		if (dtc_open_one(file, search->dir, fname))
+			return file;
 
-const char *srcpos_filename_for_num(int filenum)
-{
-	if (0 <= filenum && filenum < n_file_names) {
-		return file_names[filenum];
+		if (errno != ENOENT)
+			goto out;
+
+		search = search->next;
 	}
 
-	return 0;
+out:
+	free(file);
+	return NULL;
 }
 
-
-const char *srcpos_get_filename(void)
+void dtc_close_file(struct dtc_file *file)
 {
-	return srcpos_filename_for_num(srcpos_filenum);
+	if (fclose(file->file))
+		die("Error closing \"%s\": %s\n", file->name, strerror(errno));
+
+	free(file);
 }
diff --git a/srcpos.h b/srcpos.h
index e59c788..8108539 100644
--- a/srcpos.h
+++ b/srcpos.h
@@ -22,13 +22,21 @@
  * array of all opened filenames.
  */
 
+#include <stdio.h>
+
+struct dtc_file {
+	const char *dir;
+	const char *name;
+	FILE *file;
+};
+
 #if ! defined(YYLTYPE) && ! defined(YYLTYPE_IS_DECLARED)
 typedef struct YYLTYPE {
     int first_line;
     int first_column;
     int last_line;
     int last_column;
-    int filenum;
+    struct dtc_file *file;
 } YYLTYPE;
 
 #define YYLTYPE_IS_DECLARED	1
@@ -48,7 +56,7 @@ typedef struct YYLTYPE {
 	  (Current).first_column = YYRHSLOC (Rhs, 1).first_column;	\
 	  (Current).last_line    = YYRHSLOC (Rhs, N).last_line;		\
 	  (Current).last_column  = YYRHSLOC (Rhs, N).last_column;	\
-	  (Current).filenum      = YYRHSLOC (Rhs, N).filenum;		\
+	  (Current).file         = YYRHSLOC (Rhs, N).file;		\
 	}								\
       else								\
 	{								\
@@ -56,7 +64,7 @@ typedef struct YYLTYPE {
 	    YYRHSLOC (Rhs, 0).last_line;				\
 	  (Current).first_column = (Current).last_column =		\
 	    YYRHSLOC (Rhs, 0).last_column;				\
-	  (Current).filenum      = YYRHSLOC (Rhs, 0).filenum;		\
+	  (Current).file         = YYRHSLOC (Rhs, 0).file;		\
 	}								\
     while (YYID (0))
 
@@ -65,12 +73,16 @@ typedef struct YYLTYPE {
 extern void yyerror(char const *);
 extern void yyerrorf(char const *, ...) __attribute__((format(printf, 1, 2)));
 
-extern int srcpos_filenum;
+extern struct dtc_file *srcpos_file;
 
 extern int push_input_file(const char *filename);
 extern int pop_input_file(void);
 
-extern FILE *dtc_open_file(const char *fname);
-extern int lookup_file_name(const char *fname, int add_it);
-extern const char *srcpos_filename_for_num(int filenum);
-const char *srcpos_get_filename(void);
+struct search_path {
+	const char *dir; /* NULL for current directory */
+	struct search_path *prev, *next;
+};
+
+extern struct dtc_file *dtc_open_file(const char *fname,
+                                      const struct search_path *search);
+extern void dtc_close_file(struct dtc_file *file);
-- 
1.5.3
