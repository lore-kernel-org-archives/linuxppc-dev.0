Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Wed, 22 Nov 2006 18:55:33 +1100
Subject: [PATCH 7/9] Make xmon disassembly optional
In-Reply-To: <1164182122.302443.256192350213.qpush@cradle>
Message-Id: <20061122075537.ED60367D6B@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd.bergmann@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

While adding spu disassembly support it struck me that we're actually
carrying quite a lot of code around, just to do disassembly in the case
of a crash.

While on large systems it's not an issue, on smaller ones it might be
nice to have xmon - but without the weight of the disassembly support.
For a Cell build this saves ~230KB (!), and for pSeries ~195KB.

We still support the 'di' and 'sdi' commands, however they just dump
the instruction in hex.

Move the definitions into a header to clean xmon.c just a tiny bit.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/Kconfig.debug  |    9 +++++++++
 arch/powerpc/xmon/Makefile  |    8 ++++++--
 arch/powerpc/xmon/dis-asm.h |   31 +++++++++++++++++++++++++++++++
 arch/powerpc/xmon/ppc-dis.c |    3 +--
 arch/powerpc/xmon/spu-dis.c |    3 +--
 arch/powerpc/xmon/xmon.c    |    5 +----
 6 files changed, 49 insertions(+), 10 deletions(-)

Index: cell/arch/powerpc/Kconfig.debug
===================================================================
--- cell.orig/arch/powerpc/Kconfig.debug
+++ cell/arch/powerpc/Kconfig.debug
@@ -98,6 +98,15 @@ config XMON_DEFAULT
 	  xmon is normally disabled unless booted with 'xmon=on'.
 	  Use 'xmon=off' to disable xmon init during runtime.
 
+config XMON_DISASSEMBLY
+	bool "Include disassembly support in xmon"
+	depends on XMON
+	default y
+	help
+	  Include support for disassembling in xmon. You probably want
+	  to say Y here, unless you're building for a memory-constrained
+	  system.
+
 config IRQSTACKS
 	bool "Use separate kernel stacks when processing interrupts"
 	depends on PPC64
Index: cell/arch/powerpc/xmon/Makefile
===================================================================
--- cell.orig/arch/powerpc/xmon/Makefile
+++ cell/arch/powerpc/xmon/Makefile
@@ -3,6 +3,10 @@
 ifdef CONFIG_PPC64
 EXTRA_CFLAGS += -mno-minimal-toc
 endif
-obj-y			+= xmon.o ppc-dis.o ppc-opc.o setjmp.o start.o \
-			   nonstdio.o
+
+obj-y			+= xmon.o setjmp.o start.o nonstdio.o
+
+ifdef CONFIG_XMON_DISASSEMBLY
+obj-y			+= ppc-dis.o ppc-opc.o
 obj-$(CONFIG_PPC_CELL)	+= spu-dis.o spu-opc.o
+endif
Index: cell/arch/powerpc/xmon/dis-asm.h
===================================================================
--- /dev/null
+++ cell/arch/powerpc/xmon/dis-asm.h
@@ -0,0 +1,31 @@
+#ifndef _POWERPC_XMON_DIS_ASM_H
+#define _POWERPC_XMON_DIS_ASM_H
+/*
+ * Copyright (C) 2006 Michael Ellerman, IBM Corporation.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+extern void print_address (unsigned long memaddr);
+
+#ifdef CONFIG_XMON_DISASSEMBLY
+extern int print_insn_powerpc(unsigned long insn, unsigned long memaddr);
+extern int print_insn_spu(unsigned long insn, unsigned long memaddr);
+#else
+static inline int print_insn_powerpc(unsigned long insn, unsigned long memaddr)
+{
+	printf("%.8x", insn);
+	return 0;
+}
+
+static inline int print_insn_spu(unsigned long insn, unsigned long memaddr)
+{
+	printf("%.8x", insn);
+	return 0;
+}
+#endif
+
+#endif /* _POWERPC_XMON_DIS_ASM_H */
Index: cell/arch/powerpc/xmon/ppc-dis.c
===================================================================
--- cell.orig/arch/powerpc/xmon/ppc-dis.c
+++ cell/arch/powerpc/xmon/ppc-dis.c
@@ -21,8 +21,7 @@ Software Foundation, 59 Temple Place - S
 #include "nonstdio.h"
 #include "ansidecl.h"
 #include "ppc.h"
-
-extern void print_address (unsigned long memaddr);
+#include "dis-asm.h"
 
 /* Print a PowerPC or POWER instruction.  */
 
Index: cell/arch/powerpc/xmon/spu-dis.c
===================================================================
--- cell.orig/arch/powerpc/xmon/spu-dis.c
+++ cell/arch/powerpc/xmon/spu-dis.c
@@ -22,8 +22,7 @@
 #include "nonstdio.h"
 #include "ansidecl.h"
 #include "spu.h"
-
-extern void print_address (unsigned long memaddr);
+#include "dis-asm.h"
 
 /* This file provides a disassembler function which uses
    the disassembler interface defined in dis-asm.h.   */
Index: cell/arch/powerpc/xmon/xmon.c
===================================================================
--- cell.orig/arch/powerpc/xmon/xmon.c
+++ cell/arch/powerpc/xmon/xmon.c
@@ -46,6 +46,7 @@
 #endif
 
 #include "nonstdio.h"
+#include "dis-asm.h"
 
 #define scanhex	xmon_scanhex
 #define skipbl	xmon_skipbl
@@ -109,7 +110,6 @@ static int bsesc(void);
 static void dump(void);
 static void prdump(unsigned long, long);
 static int ppc_inst_dump(unsigned long, long, int);
-void print_address(unsigned long);
 static void backtrace(struct pt_regs *);
 static void excprint(struct pt_regs *);
 static void prregs(struct pt_regs *);
@@ -153,9 +153,6 @@ static int do_spu_cmd(void);
 
 int xmon_no_auto_backtrace;
 
-extern int print_insn_powerpc(unsigned long insn, unsigned long memaddr);
-extern int print_insn_spu(unsigned long insn, unsigned long memaddr);
-
 extern void xmon_enter(void);
 extern void xmon_leave(void);
 
