Return-Path: <dgibson@ozlabs.org>
Date: Thu, 26 Jun 2008 17:08:57 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: dtc: Clean up lexing of include files
Message-ID: <20080626070857.GA1869@yookeroo.seuss>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Currently we scan the /include/ directive as two tokens, the
"/include/" keyword itself, then the string giving the file name to
include.  We use a special scanner state to keep the two linked
together, and use the scanner state stack to keep track of the
original state while we're parsing the two /include/ tokens.

This does mean that we need to enable the 'stack' option in flex,
which results in a not-easily-suppressed warning from the flex
boilerplate code.  This is mildly irritating.

However, this two-token scanning of the /include/ directive also has
some extremely strange edge cases, because there are a variety of
tokens recognized in all scanner states, including INCLUDE.  For
example the following strange dts file:

	/include/ /dts-v1/;
	/ {
		 /* ... */
	};

Will be processed successfully with the /include/ being effectively
ignored: the '/dts-v1/' and ';' are recognized even in INCLUDE state,
then the ';' transitions us to PROPNODENAME state, throwing away
INCLUDE, and the previous state is never popped off the stack.  Or
for another example this construct:
	foo /include/ = "somefile.dts"
will be parsed as though it were:
	foo = /include/ "somefile.dts"
Again, the '=' is scanned without leaving INCLUDE state, then the next
string triggers the include logic.

And finally, we use a different regexp for the string with the
included filename than the normal string regexpt, which is also
potentially weird.

This patch, therefore, cleans up the lexical handling of the /include/
directive.  Instead of the INCLUDE state, we instead scan the whole
include directive, both keyword and filename as a single token.  This
does mean a bit more complexity in extracting the filename out of
yytext, but I think it's worth it to avoid the strageness described
above.  It also means it's no longer possible to put a comment between
the /include/ and the filename, but I'm really not very worried about
breaking files using such a strange construct.

Index: dtc/dtc-lexer.l
===================================================================
--- dtc.orig/dtc-lexer.l	2008-06-26 17:07:40.000000000 +1000
+++ dtc/dtc-lexer.l	2008-06-26 17:07:46.000000000 +1000
@@ -18,7 +18,7 @@
  *                                                                   USA
  */
 
-%option noyywrap nounput yylineno stack
+%option noyywrap nounput yylineno
 
 %x INCLUDE
 %x BYTESTRING
@@ -28,6 +28,10 @@
 PROPNODECHAR	[a-zA-Z0-9,._+*#?@-]
 PATHCHAR	({PROPNODECHAR}|[/])
 LABEL		[a-zA-Z_][a-zA-Z0-9_]*
+STRING		\"([^\\"]|\\.)*\"
+WS		[[:space:]]
+COMMENT		"/*"([^*]|\*+[^*/])*\*+"/"
+LINECOMMENT	"//".*\n
 
 %{
 #include "dtc.h"
@@ -58,22 +62,19 @@
 %}
 
 %%
-<*>"/include/"		yy_push_state(INCLUDE);
-
-<INCLUDE>\"[^"\n]*\"	{
-			yytext[strlen(yytext) - 1] = 0;
-			push_input_file(yytext + 1);
-			yy_pop_state();
+<*>"/include/"{WS}*{STRING} {
+			char *name = strchr(yytext, '\"') + 1;
+			yytext[yyleng-1] = '\0';
+			push_input_file(name);
 		}
 
-
 <*><<EOF>>		{
 			if (!pop_input_file()) {
 				yyterminate();
 			}
 		}
 
-<*>\"([^\\"]|\\.)*\"	{
+<*>{STRING}	{
 			yylloc.file = srcpos_file;
 			yylloc.first_line = yylineno;
 			DPRINT("String: %s\n", yytext);
@@ -197,16 +198,9 @@
 			return DT_INCBIN;
 		}
 
-<*>[[:space:]]+	/* eat whitespace */
-
-<*>"/*"([^*]|\*+[^*/])*\*+"/"	{
-			yylloc.file = srcpos_file;
-			yylloc.first_line = yylineno;
-			DPRINT("Comment: %s\n", yytext);
-			/* eat comments */
-		}
-
-<*>"//".*\n	/* eat line comments */
+<*>{WS}+	/* eat whitespace */
+<*>{COMMENT}+	/* eat C-style comments */
+<*>{LINECOMMENT}+ /* eat C++-style comments */
 
 <*>.		{
 			yylloc.file = srcpos_file;
Index: dtc/convert-dtsv0-lexer.l
===================================================================
--- dtc.orig/convert-dtsv0-lexer.l	2008-06-26 17:07:40.000000000 +1000
+++ dtc/convert-dtsv0-lexer.l	2008-06-26 17:07:46.000000000 +1000
@@ -17,7 +17,7 @@
  *                                                                   USA
  */
 
-%option noyywrap nounput stack
+%option noyywrap nounput
 
 %x INCLUDE
 %x BYTESTRING
@@ -26,6 +26,11 @@
 PROPNODECHAR	[a-zA-Z0-9,._+*#?@-]
 PATHCHAR	({PROPNODECHAR}|[/])
 LABEL		[a-zA-Z_][a-zA-Z0-9_]*
+STRING		\"([^\\"]|\\.)*\"
+WS		[[:space:]]
+COMMENT		"/*"([^*]|\*+[^*/])*\*+"/"
+LINECOMMENT	"//".*\n
+GAP		({WS}|{COMMENT}|{LINECOMMENT})*
 
 %{
 #include <string.h>
@@ -91,16 +96,7 @@
 %}
 
 %%
-<*>"/include/"	{
-			ECHO;
-			yy_push_state(INCLUDE);
-		}
-
-<INCLUDE>\"[^"\n]*\"	{
-			ECHO;
-			yy_pop_state();
-		}
-
+<*>"/include/"{GAP}{STRING}	ECHO;
 
 <*>\"([^\\"]|\\.)*\"	ECHO;
 
@@ -193,11 +189,7 @@
 			BEGIN(INITIAL);
 		}
 
-<*>[[:space:]]+		ECHO;
-
-<*>"/*"([^*]|\*+[^*/])*\*+"/" ECHO;
-
-<*>"//".*\n		ECHO;
+<*>{GAP}	ECHO;
 
 <*>-		{	/* Hack to convert old style memreserves */
 			saw_hyphen = 1;

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
