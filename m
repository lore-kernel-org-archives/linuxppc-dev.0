Return-Path: <dgibson@ozlabs.org>
Date: Fri, 7 Dec 2007 14:38:26 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: dtc: Reinstate full old-style reference-to-path for v0 dts files
Message-ID: <20071207033826.GD26412@localhost.localdomain>
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

Commit 7c44c2f9cb1cc2df7aacd13decfc4e64b73d1730 broke backwards
compatibility more badly than I realised.  Contrary to what I thought
there are in-kernel, in-use dts files which relied on
references-to-path with paths including a comma, which no longer
compile after that commit.

So, this patch reinstates full support for bare references-to-path in
dts-v0 input.  This means there will be some rather surprising lexical
corner cases when using path-expanded references in v0 files.  But,
since path-expanded references are new, v0 files shouldn't typically
be using them anyway.  If the corner cases cause a problem, you can
always convert to dts-v1 which handles the lexical issues here more
nicely.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/dtc-lexer.l
===================================================================
--- dtc.orig/dtc-lexer.l	2007-12-07 14:22:19.000000000 +1100
+++ dtc/dtc-lexer.l	2007-12-07 14:32:04.000000000 +1100
@@ -27,7 +27,6 @@
 
 PROPNODECHAR	[a-zA-Z0-9,._+*#?@-]
 PATHCHAR	({PROPNODECHAR}|[/])
-LEGACYPATHCHAR	[a-zA-Z0-9_@/]
 LABEL		[a-zA-Z_][a-zA-Z0-9_]*
 
 %{
@@ -158,7 +157,7 @@ static int dts_version; /* = 0 */
 			return DT_REF;
 		}
 
-<INITIAL>"&/"{LEGACYPATHCHAR}+ {	/* old-style path reference */
+<INITIAL>"&/"{PATHCHAR}+ {	/* old-style path reference */
 			yylloc.filenum = srcpos_filenum;
 			yylloc.first_line = yylineno;
 			DPRINT("Ref: %s\n", yytext+1);

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
