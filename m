Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 88624DDFDC
	for <linuxppc-dev@ozlabs.org>; Fri,  9 May 2008 00:11:26 +1000 (EST)
Date: Thu, 8 May 2008 09:06:55 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH v2] [POWERPC] Fix bootwrapper builds with newer gcc versions
Message-ID: <Pine.LNX.4.64.0805080906240.9486@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

GCC 4.4.x looks to be adding support for generating out-of-line register
saves/restores based on:

http://gcc.gnu.org/ml/gcc-patches/2008-04/msg01678.html

This breaks the bootwrapper as we'd need to link with libgcc to get the
implementation of the register save/restores.

To workaround this issue, we just stole the save/restore code from gcc
and simplified it down for our needs (integer only).

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---

e500 toolchains use a slightly different function name for the save/restore
stubs, go figure (support both).

- k

 arch/powerpc/boot/Makefile    |    2 +-
 arch/powerpc/boot/crtsavres.S |  233 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 234 insertions(+), 1 deletions(-)
 create mode 100644 arch/powerpc/boot/crtsavres.S

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 7822d25..77645a3 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -51,7 +51,7 @@ $(addprefix $(obj)/,$(zlib) gunzip_util.o main.o): \
 	$(addprefix $(obj)/,$(zliblinuxheader)) $(addprefix $(obj)/,$(zlibheader))

 src-libfdt := fdt.c fdt_ro.c fdt_wip.c fdt_sw.c fdt_rw.c fdt_strerror.c
-src-wlib := string.S crt0.S stdio.c main.c \
+src-wlib := string.S crt0.S crtsavres.S stdio.c main.c \
 		$(addprefix libfdt/,$(src-libfdt)) libfdt-wrapper.c \
 		ns16550.c serial.c simple_alloc.c div64.S util.S \
 		gunzip_util.c elf_util.c $(zlib) devtree.c oflib.c ofconsole.c \
diff --git a/arch/powerpc/boot/crtsavres.S b/arch/powerpc/boot/crtsavres.S
new file mode 100644
index 0000000..6bac266
--- /dev/null
+++ b/arch/powerpc/boot/crtsavres.S
@@ -0,0 +1,233 @@
+/*
+ * Special support for eabi and SVR4
+ *
+ *   Copyright (C) 1995, 1996, 1998, 2000, 2001 Free Software Foundation, Inc.
+ *   Written By Michael Meissner
+ *   64-bit support written by David Edelsohn
+ *
+ * This file is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2, or (at your option) any
+ * later version.
+ *
+ * In addition to the permissions in the GNU General Public License, the
+ * Free Software Foundation gives you unlimited permission to link the
+ * compiled version of this file with other programs, and to distribute
+ * those programs without any restriction coming from the use of this
+ * file.  (The General Public License restrictions do apply in other
+ * respects; for example, they cover modification of the file, and
+ * distribution when not linked into another program.)
+ *
+ * This file is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; see the file COPYING.  If not, write to
+ * the Free Software Foundation, 51 Franklin Street, Fifth Floor,
+ * Boston, MA 02110-1301, USA.
+ *
+ *    As a special exception, if you link this library with files
+ *    compiled with GCC to produce an executable, this does not cause
+ *    the resulting executable to be covered by the GNU General Public License.
+ *    This exception does not however invalidate any other reasons why
+ *    the executable file might be covered by the GNU General Public License.
+ */
+
+/* Do any initializations needed for the eabi environment */
+
+	.file	"crtsavres.S"
+	.section ".text"
+
+/* On PowerPC64 Linux, these functions are provided by the linker.  */
+#ifndef __powerpc64__
+
+#define FUNC_START(name) \
+	.type name,@function; \
+	.globl name; \
+name:
+
+/* Routines for saving integer registers, called by the compiler.  */
+/* Called with r11 pointing to the stack header word of the caller of the */
+/* function, just beyond the end of the integer save area.  */
+
+FUNC_START(_savegpr_14)
+FUNC_START(_save32gpr_14)
+	stw	14,-72(11)	/* save gp registers */
+FUNC_START(_savegpr_15)
+FUNC_START(_save32gpr_15)
+	stw	15,-68(11)
+FUNC_START(_savegpr_16)
+FUNC_START(_save32gpr_16)
+	stw	16,-64(11)
+FUNC_START(_savegpr_17)
+FUNC_START(_save32gpr_17)
+	stw	17,-60(11)
+FUNC_START(_savegpr_18)
+FUNC_START(_save32gpr_18)
+	stw	18,-56(11)
+FUNC_START(_savegpr_19)
+FUNC_START(_save32gpr_19)
+	stw	19,-52(11)
+FUNC_START(_savegpr_20)
+FUNC_START(_save32gpr_20)
+	stw	20,-48(11)
+FUNC_START(_savegpr_21)
+FUNC_START(_save32gpr_21)
+	stw	21,-44(11)
+FUNC_START(_savegpr_22)
+FUNC_START(_save32gpr_22)
+	stw	22,-40(11)
+FUNC_START(_savegpr_23)
+FUNC_START(_save32gpr_23)
+	stw	23,-36(11)
+FUNC_START(_savegpr_24)
+FUNC_START(_save32gpr_24)
+	stw	24,-32(11)
+FUNC_START(_savegpr_25)
+FUNC_START(_save32gpr_25)
+	stw	25,-28(11)
+FUNC_START(_savegpr_26)
+FUNC_START(_save32gpr_26)
+	stw	26,-24(11)
+FUNC_START(_savegpr_27)
+FUNC_START(_save32gpr_27)
+	stw	27,-20(11)
+FUNC_START(_savegpr_28)
+FUNC_START(_save32gpr_28)
+	stw	28,-16(11)
+FUNC_START(_savegpr_29)
+FUNC_START(_save32gpr_29)
+	stw	29,-12(11)
+FUNC_START(_savegpr_30)
+FUNC_START(_save32gpr_30)
+	stw	30,-8(11)
+FUNC_START(_savegpr_31)
+FUNC_START(_save32gpr_31)
+	stw	31,-4(11)
+	blr
+
+/* Routines for restoring integer registers, called by the compiler.  */
+/* Called with r11 pointing to the stack header word of the caller of the */
+/* function, just beyond the end of the integer restore area.  */
+
+FUNC_START(_restgpr_14)
+FUNC_START(_rest32gpr_14)
+	lwz	14,-72(11)	/* restore gp registers */
+FUNC_START(_restgpr_15)
+FUNC_START(_rest32gpr_15)
+	lwz	15,-68(11)
+FUNC_START(_restgpr_16)
+FUNC_START(_rest32gpr_16)
+	lwz	16,-64(11)
+FUNC_START(_restgpr_17)
+FUNC_START(_rest32gpr_17)
+	lwz	17,-60(11)
+FUNC_START(_restgpr_18)
+FUNC_START(_rest32gpr_18)
+	lwz	18,-56(11)
+FUNC_START(_restgpr_19)
+FUNC_START(_rest32gpr_19)
+	lwz	19,-52(11)
+FUNC_START(_restgpr_20)
+FUNC_START(_rest32gpr_20)
+	lwz	20,-48(11)
+FUNC_START(_restgpr_21)
+FUNC_START(_rest32gpr_21)
+	lwz	21,-44(11)
+FUNC_START(_restgpr_22)
+FUNC_START(_rest32gpr_22)
+	lwz	22,-40(11)
+FUNC_START(_restgpr_23)
+FUNC_START(_rest32gpr_23)
+	lwz	23,-36(11)
+FUNC_START(_restgpr_24)
+FUNC_START(_rest32gpr_24)
+	lwz	24,-32(11)
+FUNC_START(_restgpr_25)
+FUNC_START(_rest32gpr_25)
+	lwz	25,-28(11)
+FUNC_START(_restgpr_26)
+FUNC_START(_rest32gpr_26)
+	lwz	26,-24(11)
+FUNC_START(_restgpr_27)
+FUNC_START(_rest32gpr_27)
+	lwz	27,-20(11)
+FUNC_START(_restgpr_28)
+FUNC_START(_rest32gpr_28)
+	lwz	28,-16(11)
+FUNC_START(_restgpr_29)
+FUNC_START(_rest32gpr_29)
+	lwz	29,-12(11)
+FUNC_START(_restgpr_30)
+FUNC_START(_rest32gpr_30)
+	lwz	30,-8(11)
+FUNC_START(_restgpr_31)
+FUNC_START(_rest32gpr_31)
+	lwz	31,-4(11)
+	blr
+
+/* Routines for restoring integer registers, called by the compiler.  */
+/* Called with r11 pointing to the stack header word of the caller of the */
+/* function, just beyond the end of the integer restore area.  */
+
+FUNC_START(_restgpr_14_x)
+FUNC_START(_rest32gpr_14_x)
+	lwz	14,-72(11)	/* restore gp registers */
+FUNC_START(_restgpr_15_x)
+FUNC_START(_rest32gpr_15_x)
+	lwz	15,-68(11)
+FUNC_START(_restgpr_16_x)
+FUNC_START(_rest32gpr_16_x)
+	lwz	16,-64(11)
+FUNC_START(_restgpr_17_x)
+FUNC_START(_rest32gpr_17_x)
+	lwz	17,-60(11)
+FUNC_START(_restgpr_18_x)
+FUNC_START(_rest32gpr_18_x)
+	lwz	18,-56(11)
+FUNC_START(_restgpr_19_x)
+FUNC_START(_rest32gpr_19_x)
+	lwz	19,-52(11)
+FUNC_START(_restgpr_20_x)
+FUNC_START(_rest32gpr_20_x)
+	lwz	20,-48(11)
+FUNC_START(_restgpr_21_x)
+FUNC_START(_rest32gpr_21_x)
+	lwz	21,-44(11)
+FUNC_START(_restgpr_22_x)
+FUNC_START(_rest32gpr_22_x)
+	lwz	22,-40(11)
+FUNC_START(_restgpr_23_x)
+FUNC_START(_rest32gpr_23_x)
+	lwz	23,-36(11)
+FUNC_START(_restgpr_24_x)
+FUNC_START(_rest32gpr_24_x)
+	lwz	24,-32(11)
+FUNC_START(_restgpr_25_x)
+FUNC_START(_rest32gpr_25_x)
+	lwz	25,-28(11)
+FUNC_START(_restgpr_26_x)
+FUNC_START(_rest32gpr_26_x)
+	lwz	26,-24(11)
+FUNC_START(_restgpr_27_x)
+FUNC_START(_rest32gpr_27_x)
+	lwz	27,-20(11)
+FUNC_START(_restgpr_28_x)
+FUNC_START(_rest32gpr_28_x)
+	lwz	28,-16(11)
+FUNC_START(_restgpr_29_x)
+FUNC_START(_rest32gpr_29_x)
+	lwz	29,-12(11)
+FUNC_START(_restgpr_30_x)
+FUNC_START(_rest32gpr_30_x)
+	lwz	30,-8(11)
+FUNC_START(_restgpr_31_x)
+FUNC_START(_rest32gpr_31_x)
+	lwz	0,4(11)
+	lwz	31,-4(11)
+	mtlr	0
+	mr	1,11
+	blr
+#endif
-- 
1.5.4.1
