Return-Path: <dgibson@ozlabs.org>
Date: Tue, 26 Feb 2008 16:44:29 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: dtc: Fix error reporting in push_input_file()
Message-ID: <20080226054429.GF3026@localhost.localdomain>
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

Error reporting in push_input_file() is a mess.  One error results in
a message and exit(1), others result in a message and return 0 - which
is turned into an exit(1) at one callsite.  The other callsite doesn't
check errors, but probably should.  One of the error conditions gives
a message, but can only be the result of an internal programming
error, not a user error.

So.  Clean that up by making push_input_file() a void function, using
die() to report errors and quit.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

---
 dtc-lexer.l |   28 ++++++++--------------------
 srcpos.h    |    2 +-
 2 files changed, 9 insertions(+), 21 deletions(-)

Index: dtc/dtc-lexer.l
===================================================================
--- dtc.orig/dtc-lexer.l	2008-02-26 15:35:38.000000000 +1100
+++ dtc/dtc-lexer.l	2008-02-26 16:38:31.000000000 +1100
@@ -59,10 +59,7 @@ static int dts_version; /* = 0 */
 
 <INCLUDE>\"[^"\n]*\"	{
 			yytext[strlen(yytext) - 1] = 0;
-			if (!push_input_file(yytext + 1)) {
-				/* Some unrecoverable error.*/
-				exit(1);
-			}
+			push_input_file(yytext + 1);
 			yy_pop_state();
 		}
 
@@ -243,21 +240,16 @@ struct incl_file *incl_file_stack;
 static int incl_depth = 0;
 
 
-int push_input_file(const char *filename)
+void push_input_file(const char *filename)
 {
 	struct incl_file *incl_file;
 	struct dtc_file *newfile;
 	struct search_path search, *searchptr = NULL;
 
-	if (!filename) {
-		yyerror("No include file name given.");
-		return 0;
-	}
+	assert(filename);
 
-	if (incl_depth++ >= MAX_INCLUDE_DEPTH) {
-		yyerror("Includes nested too deeply");
-		return 0;
-	}
+	if (incl_depth++ >= MAX_INCLUDE_DEPTH)
+		die("Includes nested too deeply");
 
 	if (srcpos_file) {
 		search.dir = srcpos_file->dir;
@@ -267,11 +259,9 @@ int push_input_file(const char *filename
 	}
 
 	newfile = dtc_open_file(filename, searchptr);
-	if (!newfile) {
-		yyerrorf("Couldn't open \"%s\": %s",
-		         filename, strerror(errno));
-		exit(1);
-	}
+	if (!newfile)
+		die("Couldn't open \"%s\": %s", filename, strerror(errno));
+
 
 	incl_file = xmalloc(sizeof(struct incl_file));
 
@@ -292,8 +282,6 @@ int push_input_file(const char *filename
 	yylineno = 1;
 	yyin = newfile->file;
 	yy_switch_to_buffer(yy_create_buffer(yyin, YY_BUF_SIZE));
-
-	return 1;
 }
 
 
Index: dtc/srcpos.h
===================================================================
--- dtc.orig/srcpos.h	2008-02-26 15:38:55.000000000 +1100
+++ dtc/srcpos.h	2008-02-26 15:39:11.000000000 +1100
@@ -75,7 +75,7 @@ extern void yyerrorf(char const *, ...) 
 
 extern struct dtc_file *srcpos_file;
 
-extern int push_input_file(const char *filename);
+extern void push_input_file(const char *filename);
 extern int pop_input_file(void);
 
 struct search_path {

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
