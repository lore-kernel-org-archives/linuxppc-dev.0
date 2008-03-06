Return-Path: <dgibson@ozlabs.org>
Date: Thu, 6 Mar 2008 12:45:41 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: dtc: Remove ugly include stack abuse
Message-ID: <20080306014541.GB18315@localhost.localdomain>
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

Currently, dt_from_source() uses push_input_file() to set up the
initial input file for the lexer.  That sounds sensible - put the
outermost input file at the bottom of the stack - until you realise
that what it *actually* does is pushes the current, uninitialized,
lexer input state onto the stack, then sets up the new lexer input.

That necessitates an extra check in pop_input_file(), rather than
signalling termination in the natural way when the include stack is
empty, it has to check when it pops the bogus uninitialized state off
the stack.  Ick.

With that fixed, push_input_file(), pop_input_file() and
incl_file_stack itself become local to the lexer, so make them static.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

---
 dtc-lexer.l  |   12 ++++++------
 srcpos.h     |    3 ---
 treesource.c |    3 ++-
 3 files changed, 8 insertions(+), 10 deletions(-)

Index: dtc/treesource.c
===================================================================
--- dtc.orig/treesource.c	2008-03-05 16:14:54.000000000 +1100
+++ dtc/treesource.c	2008-03-06 12:24:49.000000000 +1100
@@ -32,7 +32,8 @@
 	the_boot_info = NULL;
 	treesource_error = 0;
 
-	push_input_file(fname);
+	srcpos_file = dtc_open_file(fname, NULL);
+	yyin = srcpos_file->file;
 
 	if (yyparse() != 0)
 		return NULL;
Index: dtc/dtc-lexer.l
===================================================================
--- dtc.orig/dtc-lexer.l	2008-03-06 12:25:24.000000000 +1100
+++ dtc/dtc-lexer.l	2008-03-06 12:43:52.000000000 +1100
@@ -52,6 +52,9 @@
 				DPRINT("<V1>\n"); \
 				BEGIN(V1); \
 			}
+
+static void push_input_file(const char *filename);
+static int pop_input_file(void);
 %}
 
 %%
@@ -229,7 +232,7 @@
 	struct incl_file *prev;
 };
 
-struct incl_file *incl_file_stack;
+static struct incl_file *incl_file_stack;
 
 
 /*
@@ -240,7 +243,7 @@
 static int incl_depth = 0;
 
 
-void push_input_file(const char *filename)
+static void push_input_file(const char *filename)
 {
 	struct incl_file *incl_file;
 	struct dtc_file *newfile;
@@ -282,7 +285,7 @@
 }
 
 
-int pop_input_file(void)
+static int pop_input_file(void)
 {
 	struct incl_file *incl_file;
 
@@ -312,8 +315,5 @@
 	 */
 	free(incl_file);
 
-	if (YY_CURRENT_BUFFER == 0)
-		return 0;
-
 	return 1;
 }
Index: dtc/srcpos.h
===================================================================
--- dtc.orig/srcpos.h	2008-03-06 12:43:23.000000000 +1100
+++ dtc/srcpos.h	2008-03-06 12:43:25.000000000 +1100
@@ -75,9 +75,6 @@
 
 extern struct dtc_file *srcpos_file;
 
-extern void push_input_file(const char *filename);
-extern int pop_input_file(void);
-
 struct search_path {
 	const char *dir; /* NULL for current directory */
 	struct search_path *prev, *next;

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
