Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [208.123.74.7])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 824DEDE53F
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Oct 2007 03:43:36 +1000 (EST)
Received: from jdl (helo=jdl.com) by jdl.com with local-esmtp (Exim 4.63)
	(envelope-from <jdl@jdl.com>) id 1Iivsg-00078a-Vp
	for linuxppc-dev@ozlabs.org; Fri, 19 Oct 2007 12:43:33 -0500
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 4/4] DTC: Begin the path to sane literals and expressions.
Date: Fri, 19 Oct 2007 12:43:30 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1Iivsg-00078a-Vp@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Add support for the "/dts-version/ <number>;" statment.
Make legacy DTS files version 0 whether explicitly stated
or implied by a lack of /dts-version/ statement.

Begin supporting a new /dts-version/ 1 that changes the
format of the literals in a DTS source file.  In the new
format, hex constants are prefixed with 0x or 0X, and
bare numbers are decimal or octal according to standard
conventions.

Property names have been limited to start with
characters from the set [a-zA-Z,._#?].  That is, the
digits and the expression symbols have been removed.

Use of "d#', "o#", "h#" and "b#" are gone in version 1.

Several warnings are introduced for debatable constructs.

- Only /dts-version/ 0 and 1 are supported yet.

- A missing /dts-version/ statement garners a
  suggestion to add one, and defaults to verion 0.

- The /memreserve/ construct using "-" for ranges looks
  suspiciously like the subtraction of two expressions,
  so its syntax has been changed to use ".." as the range
  indicator.

Signed-off-by: Jon Loeliger <jdl@freescale.com>
---
 dtc-lexer.l  |  180 +++++++++++++++++++++++++++++++++++++++++++++------------
 dtc-parser.y |  143 +++++++++++++++++++++++++++++++---------------
 dtc.c        |   26 ++++++++
 dtc.h        |   23 ++++++--
 srcpos.h     |    1 +
 treesource.c |   24 +++++++-
 6 files changed, 303 insertions(+), 94 deletions(-)

diff --git a/dtc-lexer.l b/dtc-lexer.l
index 278a96e..a1c52c4 100644
--- a/dtc-lexer.l
+++ b/dtc-lexer.l
@@ -22,12 +22,19 @@
 
 %x INCLUDE
 %x CELLDATA
+%x CELLDATA_LEGACY
 %x BYTESTRING
+%x BYTESTRING_LEGACY
 %x MEMRESERVE
+%x MEMRESERVE_LEGACY
 
+DIGIT		[0-9]
+HEXDIGIT	[0-9a-fA-F]
+FIRSTPROPCHAR	[a-zA-Z,._#?]
 PROPCHAR	[a-zA-Z0-9,._+*#?-]
 UNITCHAR	[0-9a-f,]
 WS		[[:space:]]
+DOT		[.]
 
 REFCHAR		({PROPCHAR}|{UNITCHAR}|[/@])
 
@@ -46,11 +53,20 @@ REFCHAR		({PROPCHAR}|{UNITCHAR}|[/@])
 #endif
 
 
+unsigned int in_lexer_use_base = 16;	/* Feedback from parser.  Ugh. */
+
 
 %}
 
 %%
 
+"/dts-version/"	{
+			yylloc.filenum = srcpos_filenum;
+			yylloc.first_line = yylineno;
+			DPRINT("Keyword: /dts-version/\n");
+			return DT_DTS_VERSION;
+		}
+
 "/include/"		BEGIN(INCLUDE);
 
 <INCLUDE>\"[^"\n]*\"	{
@@ -83,24 +99,15 @@ REFCHAR		({PROPCHAR}|{UNITCHAR}|[/@])
 			yylloc.filenum = srcpos_filenum;
 			yylloc.first_line = yylineno;
 			DPRINT("Keyword: /memreserve/\n");
-			BEGIN(MEMRESERVE);
-			return DT_MEMRESERVE;
-		}
-
-<MEMRESERVE>[0-9a-fA-F]+ {
-			yylloc.filenum = srcpos_filenum;
-			yylloc.first_line = yylineno;
-			if (yyleng > 2*sizeof(yylval.addr)) {
-				fprintf(stderr, "Address value %s too large\n",
-					yytext);
+			if (dts_version == 0) {
+				BEGIN(MEMRESERVE_LEGACY);
+			} else {
+				BEGIN(MEMRESERVE);
 			}
-			yylval.addr = (u64) strtoull(yytext, NULL, 16);
-			DPRINT("Addr: %llx\n",
-			       (unsigned long long)yylval.addr);
-			return DT_ADDR;
+			return DT_MEMRESERVE;
 		}
 
-<MEMRESERVE>";"	{
+<MEMRESERVE,MEMRESERVE_LEGACY>";"	{
 			yylloc.filenum = srcpos_filenum;
 			yylloc.first_line = yylineno;
 			DPRINT("/MEMRESERVE\n");
@@ -117,7 +124,7 @@ REFCHAR		({PROPCHAR}|{UNITCHAR}|[/@])
 			return DT_LABEL;
 		}
 
-<CELLDATA>[bodh]# {
+<CELLDATA_LEGACY>[bodh]# {
 			yylloc.filenum = srcpos_filenum;
 			yylloc.first_line = yylineno;
 			if (*yytext == 'b')
@@ -132,15 +139,7 @@ REFCHAR		({PROPCHAR}|{UNITCHAR}|[/@])
 			return DT_BASE;
 		}
 
-<CELLDATA>[0-9a-fA-F]+	{
-			yylloc.filenum = srcpos_filenum;
-			yylloc.first_line = yylineno;
-			yylval.str = strdup(yytext);
-			DPRINT("Cell: '%s'\n", yylval.str);
-			return DT_CELL;
-		}
-
-<CELLDATA>">"	{
+<CELLDATA,CELLDATA_LEGACY>">"	{
 			yylloc.filenum = srcpos_filenum;
 			yylloc.first_line = yylineno;
 			DPRINT("/CELLDATA\n");
@@ -156,15 +155,7 @@ REFCHAR		({PROPCHAR}|{UNITCHAR}|[/@])
 			return DT_REF;
 		}
 
-<BYTESTRING>[0-9a-fA-F]{2} {
-			yylloc.filenum = srcpos_filenum;
-			yylloc.first_line = yylineno;
-			yylval.byte = strtol(yytext, NULL, 16);
-			DPRINT("Byte: %02x\n", (int)yylval.byte);
-			return DT_BYTE;
-		}
-
-<BYTESTRING>"]"	{
+<BYTESTRING,BYTESTRING_LEGACY>"]"	{
 			yylloc.filenum = srcpos_filenum;
 			yylloc.first_line = yylineno;
 			DPRINT("/BYTESTRING\n");
@@ -182,7 +173,63 @@ REFCHAR		({PROPCHAR}|{UNITCHAR}|[/@])
 			return yytext[0];
 		}
 
-{PROPCHAR}+	{
+
+<MEMRESERVE_LEGACY>{HEXDIGIT}+	{
+			yylloc.filenum = srcpos_filenum;
+			yylloc.first_line = yylineno;
+			DPRINT("LEGACY MEMRESERVE LITERAL bare hex: '%s'\n",
+			       yytext);
+			yylval.ire = expr_from_string(yytext, 16);
+			in_lexer_use_base = expr_default_base;
+			return DT_LITERAL;
+		}
+
+<CELLDATA_LEGACY>{HEXDIGIT}+	{
+			yylloc.filenum = srcpos_filenum;
+			yylloc.first_line = yylineno;
+			DPRINT("LEGACY CELLDATA LITERAL bare hex: '%s'\n",
+			       yytext);
+			yylval.ire = expr_from_string(yytext,
+						      in_lexer_use_base);
+			in_lexer_use_base = expr_default_base;
+			return DT_LITERAL;
+		}
+
+<BYTESTRING_LEGACY>[0-9a-fA-F]{2} {
+			yylloc.filenum = srcpos_filenum;
+			yylloc.first_line = yylineno;
+			yylval.ire = strtol(yytext, NULL, 16);
+			DPRINT("LEGACY BYTE LITERAL: %02x\n", (int)yylval.ire);
+			return DT_LITERAL;
+		}
+
+
+<CELLDATA,MEMRESERVE,BYTESTRING>{DIGIT}+	{
+			yylloc.filenum = srcpos_filenum;
+			yylloc.first_line = yylineno;
+			DPRINT("CONTEXT LITERAL bare dec: '%s'\n", yytext);
+			yylval.ire = expr_from_string(yytext, 0);
+			return DT_LITERAL;
+		}
+
+<CELLDATA,MEMRESERVE,BYTESTRING>0(x|X){HEXDIGIT}+	{
+			yylloc.filenum = srcpos_filenum;
+			yylloc.first_line = yylineno;
+			yylval.ire = expr_from_string(yytext, 0);
+			DPRINT("CONTEXT LITERAL 0x: '%llx'\n",
+			       (unsigned long long)yylval.ire);
+			return DT_LITERAL;
+		}
+
+
+<*>{DOT}{DOT}	{
+			yylloc.filenum = srcpos_filenum;
+			yylloc.first_line = yylineno;
+			DPRINT("DT_RANGE\n");
+			return DT_RANGE;
+		}
+
+{FIRSTPROPCHAR}{PROPCHAR}+	{
 			yylloc.filenum = srcpos_filenum;
 			yylloc.first_line = yylineno;
 			DPRINT("PropName: %s\n", yytext);
@@ -190,7 +237,7 @@ REFCHAR		({PROPCHAR}|{UNITCHAR}|[/@])
 			return DT_PROPNAME;
 		}
 
-{PROPCHAR}+(@{UNITCHAR}+)? {
+{FIRSTPROPCHAR}{PROPCHAR}+(@{UNITCHAR}+)? {
 			yylloc.filenum = srcpos_filenum;
 			yylloc.first_line = yylineno;
 			DPRINT("NodeName: %s\n", yytext);
@@ -198,6 +245,23 @@ REFCHAR		({PROPCHAR}|{UNITCHAR}|[/@])
 			return DT_NODENAME;
 		}
 
+{DIGIT}+	{
+			yylloc.filenum = srcpos_filenum;
+			yylloc.first_line = yylineno;
+			yylval.ire = expr_from_string(yytext, 0);
+			DPRINT("LITERAL: '%llx'\n",
+			       (unsigned long long)yylval.ire);
+			return DT_LITERAL;
+		}
+
+0(x|X){HEXDIGIT}+	{
+			yylloc.filenum = srcpos_filenum;
+			yylloc.first_line = yylineno;
+			DPRINT("LITERAL bare hex: '%s'\n", yytext);
+			yylval.ire = expr_from_string(yytext, 0);
+			return DT_LITERAL;
+		}
+
 
 <*>{WS}+	/* eat whitespace */
 
@@ -216,11 +280,19 @@ REFCHAR		({PROPCHAR}|{UNITCHAR}|[/@])
 			switch (yytext[0]) {
 				case '<':
 					DPRINT("CELLDATA\n");
-					BEGIN(CELLDATA);
+					if (dts_version == 0) {
+					    BEGIN(CELLDATA_LEGACY);
+					} else {
+					    BEGIN(CELLDATA);
+					}
 					break;
 				case '[':
 					DPRINT("BYTESTRING\n");
-					BEGIN(BYTESTRING);
+					if (dts_version == 0) {
+					    BEGIN(BYTESTRING_LEGACY);
+					} else {
+					    BEGIN(BYTESTRING);
+					}
 					break;
 				default:
 
@@ -339,3 +411,35 @@ int pop_input_file(void)
 
 	return 1;
 }
+
+/*
+ * Convert a string representation of a numeric literal
+ * in the given base into a binary representation.
+ *
+ * FIXME: should these specification errors be fatal instead?
+ */
+
+u64 expr_from_string(char *s, unsigned int base)
+{
+	u64 v;
+	char *e;
+
+	v = strtoull(s, &e, base);
+	if (*e) {
+		fprintf(stderr,
+			"Line %d: Invalid literal value '%s' : "
+			"%c is not a base %d digit; %lld assumed\n",
+			yylloc.first_line, s, *e,
+			base == 0 ? expr_default_base : base,
+			(unsigned long long) v);
+	}
+
+	if (errno == EINVAL || errno == ERANGE) {
+		fprintf(stderr,
+			"Line %d: Invalid literal value '%s'; %lld assumed\n",
+			yylloc.first_line, s, (unsigned long long) v);
+		errno = 0;
+	}
+
+	return v;
+}
diff --git a/dtc-parser.y b/dtc-parser.y
index 4698793..fd82381 100644
--- a/dtc-parser.y
+++ b/dtc-parser.y
@@ -27,6 +27,8 @@
 
 int yylex(void);
 cell_t cell_from_string(char *s, unsigned int base);
+cell_t expr_cell_value(u64 c);
+u8 expr_byte_value(u64 c);
 
 extern struct boot_info *the_boot_info;
 
@@ -35,7 +37,6 @@ extern struct boot_info *the_boot_info;
 %union {
 	cell_t cval;
 	unsigned int cbase;
-	u8 byte;
 	char *str;
 	struct data data;
 	struct property *prop;
@@ -46,25 +47,27 @@ extern struct boot_info *the_boot_info;
 	int hexlen;
 	u64 addr;
 	struct reserve_info *re;
+	u64 ire;
 }
 
+%token DT_DTS_VERSION
 %token DT_MEMRESERVE
-%token <addr> DT_ADDR
 %token <str> DT_PROPNAME
 %token <str> DT_NODENAME
 %token <cbase> DT_BASE
-%token <str> DT_CELL
-%token <byte> DT_BYTE
 %token <data> DT_STRING
 %token <str> DT_UNIT
 %token <str> DT_LABEL
 %token <str> DT_REF
+%token <ire> DT_LITERAL
+%token DT_RANGE
 
 %type <data> propdata
 %type <data> propdataprefix
 %type <re> memreserve
 %type <re> memreserves
 %type <cbase> opt_cell_base
+%type <cval> cell
 %type <data> celllist
 %type <data> bytestring
 %type <prop> propdef
@@ -76,13 +79,27 @@ extern struct boot_info *the_boot_info;
 %type <nodelist> subnodes
 %type <str> label
 %type <str> nodename
+%type <ire> expr
+%type <ire> expr_primary
 
 %%
 
 sourcefile:
-	  memreserves devicetree
+	  opt_version memreserves devicetree
 		{
-			the_boot_info = build_boot_info($1, $2);
+			the_boot_info = build_boot_info($2, $3);
+		}
+	;
+
+opt_version:
+	  /* empty */
+		{
+			yywarn("Missing /dts-version/; 0 assumed.");
+			set_dts_version(0);
+		}
+	|  DT_DTS_VERSION expr ';'
+		{
+			set_dts_version($2);
 		}
 	;
 
@@ -98,11 +115,16 @@ memreserves:
 	;
 
 memreserve:
-	  label DT_MEMRESERVE DT_ADDR DT_ADDR ';'
+	  label DT_MEMRESERVE expr expr ';'
 		{
 			$$ = build_reserve_entry($3, $4, $1);
 		}
-	| label DT_MEMRESERVE DT_ADDR '-' DT_ADDR ';'
+	| label DT_MEMRESERVE expr '-' expr ';'
+		{
+			yywarn("/memreserve/ using '-' should be converted to '..' instead.");
+			$$ = build_reserve_entry($3, $5 - $3 + 1, $1);
+		}
+	| label DT_MEMRESERVE expr DT_RANGE expr ';'
 		{
 			$$ = build_reserve_entry($3, $5 - $3 + 1, $1);
 		}
@@ -179,19 +201,10 @@ propdataprefix:
 		}
 	;
 
-opt_cell_base:
-	  /* empty */
-		{
-			$$ = 16;
-		}
-	| DT_BASE
-	;
-
 celllist:
-	  celllist opt_cell_base DT_CELL
+	  celllist cell
 		{
-			$$ = data_append_cell($1,
-					      cell_from_string($3, $2));
+			$$ = data_append_cell($1, $2);
 		}
 	| celllist DT_REF
 		{
@@ -207,8 +220,39 @@ celllist:
 		}
 	;
 
+cell:
+	  expr
+		{
+			$$ = expr_cell_value($1);
+		}
+	;
+
+expr:
+	  expr_primary
+	;
+
+expr_primary:
+	  opt_cell_base DT_LITERAL
+		{
+			$$ = $2;
+		}
+	;
+
+opt_cell_base:
+	  /* empty */
+		{
+			/* This is a lot gross, but hopefully temporary. */
+			in_lexer_use_base = 16;
+		}
+	| DT_BASE
+		{
+			/* This is a lot gross, but hopefully temporary. */
+			in_lexer_use_base = $1;
+		}
+	;
+
 bytestring:
-	  bytestring DT_BYTE
+	  bytestring expr
 		{
 			$$ = data_append_byte($1, $2);
 		}
@@ -264,7 +308,7 @@ label:
 
 %%
 
-void yyerror (char const *s)
+void yyerror(char const *s)
 {
 	const char *fname = srcpos_filename_for_num(yylloc.filenum);
 
@@ -276,32 +320,37 @@ void yyerror (char const *s)
 }
 
 
-/*
- * Convert a string representation of a numeric cell
- * in the given base into a cell.
- *
- * FIXME: should these specification errors be fatal instead?
- */
+void yywarn(char const *s, ...)
+{
+	va_list ap;
+	const char *fname;
+
+	if (quiet >= 1)
+		return;
 
-cell_t cell_from_string(char *s, unsigned int base)
+	va_start(ap, s);
+
+	fname = srcpos_filename_for_num(yylloc.filenum);
+	if (strcmp(fname, "-") == 0)
+		fname = "stdin";
+
+	fprintf(stderr, "%s:%d Warning: ", fname, yylloc.first_line);
+	vfprintf(stderr, s, ap);
+	fprintf(stderr, "\n");
+}
+
+
+cell_t expr_cell_value(u64 c)
 {
-	cell_t c;
-	char *e;
-
-	c = strtoul(s, &e, base);
-	if (*e) {
-		fprintf(stderr,
-			"Line %d: Invalid cell value '%s' : "
-			"%c is not a base %d digit; %d assumed\n",
-			yylloc.first_line, s, *e, base, c);
-	}
-
-	if (errno == EINVAL || errno == ERANGE) {
-		fprintf(stderr,
-			"Line %d: Invalid cell value '%s'; %d assumed\n",
-			yylloc.first_line, s, c);
-		errno = 0;
-	}
-
-	return c;
+	/* FIXME: Range check to fit in u32 cell_t */
+
+	return (cell_t) c;
+}
+
+
+u8 expr_byte_value(u64 c)
+{
+	/* FIXME: Range check to fit in u8 byte */
+
+	return (u8) c;
 }
diff --git a/dtc.c b/dtc.c
index 76a6dfe..6417c2d 100644
--- a/dtc.c
+++ b/dtc.c
@@ -30,6 +30,32 @@ int quiet;		/* Level of quietness */
 int reservenum;		/* Number of memory reservation slots */
 int minsize;		/* Minimum blob size */
 
+/*
+ * DTS sourcefile version.
+ */
+unsigned int dts_version = 0;
+unsigned int expr_default_base = 10;
+
+
+void set_dts_version(u64 vers)
+{
+	if (vers > 1) {
+		yywarn("Unknown version %lld; 0 assumed\n", vers);
+		dts_version = 0;
+	} else {
+		dts_version = vers;
+	}
+
+	if (dts_version == 0) {
+		expr_default_base = 16;
+		in_lexer_use_base = 16;
+	} else {
+		expr_default_base = 10;
+		in_lexer_use_base = 10;
+	}
+}
+
+
 char *join_path(char *path, char *name)
 {
 	int lenp = strlen(path);
diff --git a/dtc.h b/dtc.h
index 09dec54..900ad9f 100644
--- a/dtc.h
+++ b/dtc.h
@@ -36,7 +36,14 @@
 
 #include <fdt.h>
 
+typedef uint8_t u8;
+typedef uint16_t u16;
+typedef uint32_t u32;
+typedef uint64_t u64;
+typedef u32 cell_t;
+
 #define DEFAULT_FDT_VERSION	17
+
 /*
  * Command line options
  */
@@ -44,6 +51,13 @@ extern int quiet;		/* Level of quietness */
 extern int reservenum;		/* Number of memory reservation slots */
 extern int minsize;		/* Minimum blob size */
 
+/*
+ * DTS sourcefile version
+ */
+extern unsigned int dts_version;
+extern void set_dts_version(u64 vers);
+
+
 static inline void __attribute__((noreturn)) die(char * str, ...)
 {
 	va_list ap;
@@ -74,12 +88,6 @@ static inline void *xrealloc(void *p, size_t len)
 	return new;
 }
 
-typedef uint8_t u8;
-typedef uint16_t u16;
-typedef uint32_t u32;
-typedef uint64_t u64;
-typedef u32 cell_t;
-
 #define cpu_to_be16(x)	htons(x)
 #define be16_to_cpu(x)	ntohs(x)
 
@@ -237,5 +245,8 @@ struct boot_info *dt_from_fs(char *dirname);
 
 char *join_path(char *path, char *name);
 void fill_fullpaths(struct node *tree, char *prefix);
+u64 expr_from_string(char *s, unsigned int base);
+extern unsigned int in_lexer_use_base;
+unsigned int expr_default_base;
 
 #endif /* _DTC_H */
diff --git a/srcpos.h b/srcpos.h
index ce7ab5b..c285e47 100644
--- a/srcpos.h
+++ b/srcpos.h
@@ -63,6 +63,7 @@ typedef struct YYLTYPE {
 
 
 extern void yyerror(char const *);
+extern void yywarn(char const *, ...);
 
 extern int srcpos_filenum;
 
diff --git a/treesource.c b/treesource.c
index f62041f..653be3a 100644
--- a/treesource.c
+++ b/treesource.c
@@ -147,7 +147,11 @@ static void write_propval_cells(FILE *f, struct data val)
 
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
@@ -162,7 +166,11 @@ static void write_propval_bytes(FILE *f, struct data val)
 
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
@@ -218,12 +226,22 @@ static void write_tree_source_node(FILE *f, struct node *tree, int level)
 void dt_to_source(FILE *f, struct boot_info *bi)
 {
 	struct reserve_info *re;
+	const char *range_str;
+
+	if (dts_version == 0) {
+	    range_str = " - ";
+	} else {
+	    range_str = " .. ";
+	    fprintf(f, "/dts-version/ %d;\n\n", dts_version);
+	}
 
 	for (re = bi->reservelist; re; re = re->next) {
-		fprintf(f, "/memreserve/\t%016llx-%016llx;\n",
+		fprintf(f, "/memreserve/\t0x%016llx %s 0x%016llx;\n",
 			(unsigned long long)re->re.address,
+			range_str,
 			(unsigned long long)(re->re.address + re->re.size - 1));
 	}
+	fprintf(f, "\n");
 
 	write_tree_source_node(f, bi->dt, 0);
 }
-- 
1.5.3.1.139.g9346b
