Return-Path: <arnd@arndb.de>
Message-Id: <20061127182430.576009000@arndb.de>
References: <20061127181851.796747000@arndb.de>
Date: Mon, 27 Nov 2006 19:18:55 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@ozlabs.org>
Subject: [POWERPC 4/9] cell: fix building without spufs
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
	Arnd Bergmann <arnd.bergmann@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

It may be desireable to build a kernel for cell without
spufs, e.g. as the initial kboot kernel. This requires
that the SPU specific parts of the core dump and the xmon
code depend on CONFIG_SPU_BASE instead of CONFIG_PPC_CELL.

Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

Index: linux-2.6/arch/powerpc/xmon/Makefile
===================================================================
--- linux-2.6.orig/arch/powerpc/xmon/Makefile
+++ linux-2.6/arch/powerpc/xmon/Makefile
@@ -8,5 +8,5 @@ obj-y			+= xmon.o setjmp.o start.o nonst
 
 ifdef CONFIG_XMON_DISASSEMBLY
 obj-y			+= ppc-dis.o ppc-opc.o
-obj-$(CONFIG_PPC_CELL)	+= spu-dis.o spu-opc.o
+obj-$(CONFIG_SPU_BASE)	+= spu-dis.o spu-opc.o
 endif
Index: linux-2.6/arch/powerpc/xmon/xmon.c
===================================================================
--- linux-2.6.orig/arch/powerpc/xmon/xmon.c
+++ linux-2.6/arch/powerpc/xmon/xmon.c
@@ -213,7 +213,7 @@ Commands:\n\
   p 	call a procedure\n\
   r	print registers\n\
   s	single step\n"
-#ifdef CONFIG_PPC_CELL
+#ifdef CONFIG_SPU_BASE
 "  ss	stop execution on all spus\n\
   sr	restore execution on stopped spus\n\
   sf  #	dump spu fields for spu # (in hex)\n\
@@ -2654,7 +2654,7 @@ void __init xmon_setup(void)
 		debugger(NULL);
 }
 
-#ifdef CONFIG_PPC_CELL
+#ifdef CONFIG_SPU_BASE
 
 struct spu_info {
 	struct spu *spu;
@@ -2907,7 +2907,7 @@ static int do_spu_cmd(void)
 
 	return 0;
 }
-#else /* ! CONFIG_PPC_CELL */
+#else /* ! CONFIG_SPU_BASE */
 static int do_spu_cmd(void)
 {
 	return -1;
Index: linux-2.6/include/asm-powerpc/elf.h
===================================================================
--- linux-2.6.orig/include/asm-powerpc/elf.h
+++ linux-2.6/include/asm-powerpc/elf.h
@@ -411,7 +411,7 @@ do {									\
 /* Keep this the last entry.  */
 #define R_PPC64_NUM		107
 
-#ifdef CONFIG_PPC_CELL
+#ifdef CONFIG_SPU_BASE
 /* Notes used in ET_CORE. Note name is "SPU/<fd>/<filename>". */
 #define NT_SPU		1
 

--
