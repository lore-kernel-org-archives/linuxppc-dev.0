Return-Path: <dgibson@ozlabs.org>
Date: Tue, 18 Dec 2007 15:07:20 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@samba.org>
Subject: [2/2] Use embedded dtc in kernel builds
Message-ID: <20071218040720.GD10348@localhost.localdomain>
References: <20071218040348.GB10348@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071218040348.GB10348@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch alters the kernel makefiles to build dtc from the sources
embedded in the previous patch.  It also changes the
arch/powerpc/boot/wrapper script to use the embedded dtc, rather than
expecting a copy of dtc already installed on the system.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

---
 arch/powerpc/boot/Makefile |   39 +++++++++++++++++++++++++++++++++++++--
 arch/powerpc/boot/wrapper  |    2 +-
 2 files changed, 38 insertions(+), 3 deletions(-)

Index: working-2.6/arch/powerpc/boot/Makefile
===================================================================
--- working-2.6.orig/arch/powerpc/boot/Makefile	2007-12-18 14:30:51.000000000 +1100
+++ working-2.6/arch/powerpc/boot/Makefile	2007-12-18 14:33:22.000000000 +1100
@@ -112,17 +112,52 @@ $(patsubst %.S,%.o, $(filter %.S, $(src-
 $(obj)/wrapper.a: $(obj-wlib) FORCE
 	$(call if_changed,bootar)
 
-hostprogs-y	:= addnote addRamDisk hack-coff mktree
+hostprogs-y	:= addnote addRamDisk hack-coff mktree dtc
 
 targets		+= $(patsubst $(obj)/%,%,$(obj-boot) wrapper.a)
 extra-y		:= $(obj)/wrapper.a $(obj-plat) $(obj)/empty.o \
 		   $(obj)/zImage.lds $(obj)/zImage.coff.lds $(obj)/zImage.ps3.lds
 
 wrapper		:=$(srctree)/$(src)/wrapper
-wrapperbits	:= $(extra-y) $(addprefix $(obj)/,addnote hack-coff mktree) \
+wrapperbits	:= $(extra-y) $(addprefix $(obj)/,addnote hack-coff mktree dtc) \
 			$(wrapper) FORCE
 
 #############
+# Bits for building dtc
+# DTC_GENPARSER      := 1    # Uncomment to rebuild flex/bison output
+
+dtc-objs := dtc.o flattree.o fstree.o data.o livetree.o treesource.o srcpos.o checks.o
+dtc-objs += dtc-lexer.lex.o dtc-parser.tab.o
+dtc-objs := $(addprefix dtc-src/, $(dtc-objs))
+
+# prerequisites on generated files needs to be explicit
+$(obj)/dtc-src/dtc-parser.tab.o: $(obj)/dtc-src/dtc-parser.tab.c $(obj)/dtc-src/dtc-parser.tab.h
+$(obj)/dtc-src/dtc-lexer.lex.o:  $(obj)/dtc-src/dtc-lexer.lex.c $(obj)/dtc-src/dtc-parser.tab.h
+
+HOSTCFLAGS += -I$(src)/dtc-src/ -I$(src)/libfdt/
+
+targets += dtc-src/dtc-parser.tab.c
+targets += dtc-src/dtc-lexer.lex.c
+
+ifdef DTC_GENPARSER
+BISON = bison
+FLEX = flex
+
+quiet_cmd_bison = BISON   $@
+      cmd_bison = $(BISON) -o$@ -d $<; cp $@ $@_shipped
+quiet_cmd_flex = FLEX    $@
+      cmd_flex = $(FLEX) -o$@ $<; cp $@ $@_shipped
+
+$(obj)/dtc-src/dtc-parser.tab.c: $(src)/dtc-src/dtc-parser.y FORCE
+     $(call if_changed,bison)
+
+$(obj)/dtc-src/dtc-parser.tab.h: $(obj)/dtc-src/dtc-parser.tab.c
+
+$(obj)/dtc-src/dtc-lexer.lex.c: $(src)/dtc-src/dtc-lexer.l FORCE
+     $(call if_changed,flex)
+endif
+
+#############
 # Bits for building various flavours of zImage
 
 ifneq ($(CROSS32_COMPILE),)
Index: working-2.6/arch/powerpc/boot/wrapper
===================================================================
--- working-2.6.orig/arch/powerpc/boot/wrapper	2007-12-18 14:30:52.000000000 +1100
+++ working-2.6/arch/powerpc/boot/wrapper	2007-12-18 14:33:22.000000000 +1100
@@ -124,7 +124,7 @@ if [ -n "$dts" ]; then
     if [ -z "$dtb" ]; then
 	dtb="$platform.dtb"
     fi
-    dtc -O dtb -o "$dtb" -b 0 -V 16 "$dts"
+    $object/dtc -O dtb -o "$dtb" -b 0 "$dts"
 fi
 
 if [ -z "$kernel" ]; then


-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
