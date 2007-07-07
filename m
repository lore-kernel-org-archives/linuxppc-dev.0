Return-Path: <miltonm@sullivan.realtime.net>
Date: Sat, 7 Jul 2007 01:18:50 -0500 (CDT)
Subject: [PATCH 06/11] dtc: allow a label: in any dts context
Sender: <miltonm@realtime.net>
From: Milton Miller <miltonm@bga.com>
To: Jon Loeliger <jdl@jdl.com>
Message-Id: <dtc-5-06.miltonm@bga.com>
In-Reply-To: <dtc-5-00.miltonm@bga.com>
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Change the lexer to recognise a label in any context.  Place
before other celldata and bytestrings to avoid the initial
characters being stolen by other matches.

A label is a character sequence starting with an alphabetic
or underscore optinally followed by the same plus digits and
terminating in a colon.

The included terminating colon will prevent matching hex numbers.

Signed-off-by: Milton Miller <miltonm@bga.com>
--- 
The following patches parse matches in CELLDATA and BYTESTRING
in addition to the current INITIAL context; matches in MEMRESERVE
and INCLUDE context will not be parsed.

diff --git a/dtc-lexer.l b/dtc-lexer.l
index 77ccd54..0e356bb 100644
--- a/dtc-lexer.l
+++ b/dtc-lexer.l
@@ -107,6 +107,16 @@ #endif
 			BEGIN(INITIAL);
 			return ';';
 		}
+
+<*>[a-zA-Z_][a-zA-Z0-9_]*:	{
+			yylloc.filenum = srcpos_filenum;
+			yylloc.first_line = yylineno;
+			DPRINT("Label: %s\n", yytext);
+			yylval.str = strdup(yytext);
+			yylval.str[yyleng-1] = '\0';
+			return DT_LABEL;
+		}
+
 <CELLDATA>[bodh]# {
 			yylloc.filenum = srcpos_filenum;
 			yylloc.first_line = yylineno;
@@ -189,15 +199,6 @@ #endif
 		}
 
 
-[a-zA-Z_][a-zA-Z0-9_]*:	{
-			yylloc.filenum = srcpos_filenum;
-			yylloc.first_line = yylineno;
-			DPRINT("Label: %s\n", yytext);
-			yylval.str = strdup(yytext);
-			yylval.str[yyleng-1] = '\0';
-			return DT_LABEL;
-		}
-
 <*>{WS}+	/* eat whitespace */
 
 <*>"/*"([^*]|\*+[^*/])*\*+"/"	{
