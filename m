Return-Path: <dgibson@ozlabs.org>
Date: Wed, 5 Dec 2007 09:50:25 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: dtc: Trivial lexer cleanups
Message-ID: <20071204225025.GB9487@localhost.localdomain>
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

This patch applies a couple of tiny cleanups to the lexer.  The
not-very-useful 'WS' named pattern is removed, and the debugging
printf() for single character tokens is moved to the top of the
action, which results in less confusing output when LEXDEBUG is
switched on (because it goes before the printf()s for possible
resulting lexer state changes).

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/dtc-lexer.l
===================================================================
--- dtc.orig/dtc-lexer.l	2007-11-22 17:29:51.000000000 +1100
+++ dtc/dtc-lexer.l	2007-11-22 17:30:55.000000000 +1100
@@ -29,7 +29,6 @@ PROPNODECHAR	[a-zA-Z0-9,._+*#?@-]
 PATHCHAR	({PROPNODECHAR}|[/])
 LEGACYPATHCHAR	[a-zA-Z0-9_@/]
 LABEL		[a-zA-Z_][a-zA-Z0-9_]*
-WS		[[:space:]]
 
 %{
 #include "dtc.h"
@@ -193,7 +192,7 @@ static int dts_version; /* = 0 */
 		}
 
 
-<*>{WS}+	/* eat whitespace */
+<*>[[:space:]]+	/* eat whitespace */
 
 <*>"/*"([^*]|\*+[^*/])*\*+"/"	{
 			yylloc.filenum = srcpos_filenum;
@@ -207,6 +206,8 @@ static int dts_version; /* = 0 */
 <*>.		{
 			yylloc.filenum = srcpos_filenum;
 			yylloc.first_line = yylineno;
+			DPRINT("Char: %c (\\x%02x)\n", yytext[0],
+				(unsigned)yytext[0]);
 			if (yytext[0] == '[') {
 				DPRINT("<BYTESTRING>\n");
 				BEGIN(BYTESTRING);
@@ -216,9 +217,6 @@ static int dts_version; /* = 0 */
 				DPRINT("<PROPNODENAME>\n");
 				BEGIN(PROPNODENAME);
 			}
-			DPRINT("Char: %c (\\x%02x)\n", yytext[0],
-				(unsigned)yytext[0]);
-
 			return yytext[0];
 		}
 

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
