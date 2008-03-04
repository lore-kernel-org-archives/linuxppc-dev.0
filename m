Return-Path: <dgibson@ozlabs.org>
Date: Tue, 4 Mar 2008 15:37:00 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: dtc: Make some functions local to parser
Message-ID: <20080304043700.GB2757@localhost.localdomain>
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

* eval_literal() is defined and used only in the parser, so make it
  static.

* The Bison documentation explicitly permits yyerror() to be a
  variadic function, so fold yyerror() and yyerrorf() into a single
  printf-style function.  The combined function is defined and used
  only in the parse, so make it static.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

---
 dtc-parser.y |   14 +++++---------
 srcpos.h     |    3 ---
 2 files changed, 5 insertions(+), 12 deletions(-)

Index: dtc/dtc-parser.y
===================================================================
--- dtc.orig/dtc-parser.y	2008-03-04 15:29:09.000000000 +1100
+++ dtc/dtc-parser.y	2008-03-04 15:31:32.000000000 +1100
@@ -24,12 +24,13 @@
 #include "dtc.h"
 #include "srcpos.h"
 
-int yylex(void);
-unsigned long long eval_literal(const char *s, int base, int bits);
+extern int yylex(void);
 
 extern struct boot_info *the_boot_info;
 extern int treesource_error;
 
+static void yyerror(char const *, ...) __attribute__((format(printf, 1, 2)));
+static unsigned long long eval_literal(const char *s, int base, int bits);
 %}
 
 %union {
@@ -308,7 +309,7 @@ label:
 
 %%
 
-void yyerrorf(char const *s, ...)
+static void yyerror(char const *s, ...)
 {
 	const char *fname = srcpos_file ? srcpos_file->name : "<no-file>";
 	va_list va;
@@ -325,12 +326,7 @@ void yyerrorf(char const *s, ...)
 	va_end(va);
 }
 
-void yyerror (char const *s)
-{
-	yyerrorf("%s", s);
-}
-
-unsigned long long eval_literal(const char *s, int base, int bits)
+static unsigned long long eval_literal(const char *s, int base, int bits)
 {
 	unsigned long long val;
 	char *e;
Index: dtc/srcpos.h
===================================================================
--- dtc.orig/srcpos.h	2008-03-04 15:30:06.000000000 +1100
+++ dtc/srcpos.h	2008-03-04 15:30:09.000000000 +1100
@@ -70,9 +70,6 @@ typedef struct YYLTYPE {
 
 
 
-extern void yyerror(char const *);
-extern void yyerrorf(char const *, ...) __attribute__((format(printf, 1, 2)));
-
 extern struct dtc_file *srcpos_file;
 
 extern void push_input_file(const char *filename);

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
