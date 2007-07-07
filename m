Return-Path: <miltonm@sullivan.realtime.net>
Date: Sat, 7 Jul 2007 01:18:47 -0500 (CDT)
Subject: [PATCH 02/11] dtc: move declaration of yyerror
Sender: <miltonm@realtime.net>
From: Milton Miller <miltonm@bga.com>
To: Jon Loeliger <jdl@jdl.com>
Message-Id: <dtc-5-02.miltonm@bga.com>
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

yyerror() is used by both dtc-parser.y and dtc-lexer.l, so move
the declaration to srcpos.h.

Signed-off-by: Milton Miller <miltonm@bga.com>
--- 
eliminates implicit declaration warning.

Index: dtc/dtc-parser.y
===================================================================
--- dtc.orig/dtc-parser.y	2007-06-14 23:16:18.000000000 -0500
+++ dtc/dtc-parser.y	2007-06-14 23:16:25.000000000 -0500
@@ -26,7 +26,6 @@
 #include "srcpos.h"
 
 int yylex(void);
-void yyerror(char const *);
 cell_t cell_from_string(char *s, unsigned int base);
 
 extern struct boot_info *the_boot_info;
Index: dtc/srcpos.h
===================================================================
--- dtc.orig/srcpos.h	2007-06-14 23:16:18.000000000 -0500
+++ dtc/srcpos.h	2007-06-14 23:16:25.000000000 -0500
@@ -62,6 +62,7 @@ typedef struct YYLTYPE {
 
 
 
+extern void yyerror(char const *);
 
 extern int srcpos_filenum;
 
