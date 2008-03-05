Return-Path: <dgibson@ozlabs.org>
Date: Wed, 5 Mar 2008 11:47:54 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: dtc: Make eval_literal() static
Message-ID: <20080305004754.GG8399@localhost.localdomain>
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

eval_literal() is used only in the parser, so make it a static
function.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

---
 dtc-parser.y |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Applies instead of the earlier patch that also localised yyerror().

Index: dtc/dtc-parser.y
===================================================================
--- dtc.orig/dtc-parser.y	2008-03-05 11:45:54.000000000 +1100
+++ dtc/dtc-parser.y	2008-03-05 11:46:07.000000000 +1100
@@ -24,12 +24,12 @@
 #include "dtc.h"
 #include "srcpos.h"
 
-int yylex(void);
-unsigned long long eval_literal(const char *s, int base, int bits);
+extern int yylex(void);
 
 extern struct boot_info *the_boot_info;
 extern int treesource_error;
 
+static unsigned long long eval_literal(const char *s, int base, int bits);
 %}
 
 %union {
@@ -330,7 +330,7 @@
 	yyerrorf("%s", s);
 }
 
-unsigned long long eval_literal(const char *s, int base, int bits)
+static unsigned long long eval_literal(const char *s, int base, int bits)
 {
 	unsigned long long val;
 	char *e;

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
