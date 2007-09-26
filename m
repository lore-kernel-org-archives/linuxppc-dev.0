Return-Path: <dgibson@ozlabs.org>
Date: Wed, 26 Sep 2007 14:05:54 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: dtc: Use a custom name for lexer output
Message-ID: <20070926040554.GA32097@localhost.localdomain>
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

This patch makes dtc use the name dtc-lexer.lex.c for the flex output,
instead of the default lex.yy.c.  If nothing else that makes the
filename more obvious when/if dtc is embedded into other projects.

It also explicitly requests flex as the lexer generator, rather than
using make's default $(LEX).

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/Makefile
===================================================================
--- dtc.orig/Makefile	2007-09-26 13:53:58.000000000 +1000
+++ dtc/Makefile	2007-09-26 13:57:52.000000000 +1000
@@ -49,6 +49,7 @@ CFLAGS = -Wall -g -Os
 LDFLAGS = -Llibfdt
 
 BISON = bison
+LEX = flex
 
 INSTALL = /usr/bin/install
 DESTDIR =
@@ -83,7 +84,7 @@ all: dtc ftdump libfdt tests
 DTC_PROGS = dtc ftdump
 DTC_OBJS = dtc.o flattree.o fstree.o data.o livetree.o \
 		srcpos.o treesource.o \
-		dtc-parser.tab.o lex.yy.o
+		dtc-parser.tab.o dtc-lexer.lex.o
 DTC_DEPFILES = $(DTC_OBJS:%.o=%.d)
 
 BIN += dtc ftdump
@@ -96,9 +97,9 @@ dtc-parser.tab.c dtc-parser.tab.h dtc-pa
 $(VERSION_FILE): Makefile FORCE
 	$(call filechk,version)
 
-lex.yy.c: dtc-lexer.l
+dtc-lexer.lex.c: dtc-lexer.l
 	@$(VECHO) LEX $@
-	$(LEX) $<
+	$(LEX) -o $@ $<
 
 dtc: $(DTC_OBJS)
 
@@ -138,7 +139,7 @@ clean: libfdt_clean tests_clean
 	@$(VECHO) CLEAN
 	rm -f $(STD_CLEANFILES)
 	rm -f $(GEN_CLEANFILES)
-	rm -f *.tab.[ch] lex.yy.c *.output vgcore.*
+	rm -f *.tab.[ch] *.lex.c *.output vgcore.*
 	rm -f $(BIN)
 
 install: all

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
