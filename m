Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3F330DE256
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jun 2008 07:21:02 +1000 (EST)
Date: Thu, 12 Jun 2008 16:20:58 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 2/2][FOR 2.6.26][POWERPC] Fix -Os kernel builds with newer
	gcc versions
In-Reply-To: <Pine.LNX.4.64.0806121549060.18722@blarg.am.freescale.net>
Message-ID: <Pine.LNX.4.64.0806121620110.18722@blarg.am.freescale.net>
References: <Pine.LNX.4.64.0806121549060.18722@blarg.am.freescale.net>
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

This breaks the kernel if we enable CONFIG_CC_OPTIMIZE_FOR_SIZE.  To fix
this we add the use the save/restore code from gcc and simplified it down
for our needs (integer only).

Additionally, we have to link this code into each module.  The other
solution was to add EXPORT_SYMBOL() which meant going through the
trampoline which seemed nonsensical for these out-of-line routines.

Finally, we add some checks to prom_init_check.sh to ignore the
out-of-line save/restore functions.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/Makefile                  |    2 +
 arch/powerpc/kernel/prom_init_check.sh |   14 ++
 arch/powerpc/lib/Makefile              |    2 +-
 arch/powerpc/lib/crtsavres.S           |  229 ++++++++++++++++++++++++++++++++
 4 files changed, 246 insertions(+), 1 deletions(-)
 create mode 100644 arch/powerpc/lib/crtsavres.S

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 9dcdc03..d3779a8 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -96,6 +96,8 @@ endif
 else
 	KBUILD_CFLAGS += $(call cc-option,-mtune=power4)
 endif
+else
+LDFLAGS_MODULE	+= arch/powerpc/lib/crtsavres.o
 endif

 ifeq ($(CONFIG_TUNE_CELL),y)
diff --git a/arch/powerpc/kernel/prom_init_check.sh b/arch/powerpc/kernel/prom_init_check.sh
index 31729a9..2c7e8e8 100644
--- a/arch/powerpc/kernel/prom_init_check.sh
+++ b/arch/powerpc/kernel/prom_init_check.sh
@@ -48,6 +48,20 @@ do
 		fi
 	done

+	# ignore register save/restore funcitons
+	if [ "${UNDEF:0:9}" = "_restgpr_" ]; then
+		OK=1
+	fi
+	if [ "${UNDEF:0:11}" = "_rest32gpr_" ]; then
+		OK=1
+	fi
+	if [ "${UNDEF:0:9}" = "_savegpr_" ]; then
+		OK=1
+	fi
+	if [ "${UNDEF:0:11}" = "_save32gpr_" ]; then
+		OK=1
+	fi
+
 	if [ $OK -eq 0 ]; then
 		ERROR=1
 		echo "Error: External symbol '$UNDEF' referenced" \
diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index c71d37d..e522b06 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -9,7 +9,7 @@ endif
 ifeq ($(CONFIG_PPC_MERGE),y)
 obj-y			:= string.o alloc.o \
 			   checksum_$(CONFIG_WORD_SIZE).o
-obj-$(CONFIG_PPC32)	+= div64.o copy_32.o
+obj-$(CONFIG_PPC32)	+= div64.o copy_32.o crtsavres.o
 obj-$(CONFIG_HAS_IOMEM)	+= devres.o
 endif

diff --git a/arch/powerpc/lib/crtsavres.S b/arch/powerpc/lib/crtsavres.S
new file mode 100644
index 0000000..70a9cd8
--- /dev/null
+++ b/arch/powerpc/lib/crtsavres.S
@@ -0,0 +1,229 @@
+/*
+ * Special support for eabi and SVR4
+ *
+ *   Copyright (C) 1995, 1996, 1998, 2000, 2001 Free Software Foundation, Inc.
+ *   Copyright 2008 Freescale Semiconductor, Inc.
+ *   Written By Michael Meissner
+ *
+ * Based on gcc/config/rs6000/crtsavres.asm from gcc
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
+#include <asm/ppc_asm.h>
+
+	.file	"crtsavres.S"
+	.section ".text"
+
+#ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
+
+/* Routines for saving integer registers, called by the compiler.  */
+/* Called with r11 pointing to the stack header word of the caller of the */
+/* function, just beyond the end of the integer save area.  */
+
+_GLOBAL(_savegpr_14)
+_GLOBAL(_save32gpr_14)
+	stw	14,-72(11)	/* save gp registers */
+_GLOBAL(_savegpr_15)
+_GLOBAL(_save32gpr_15)
+	stw	15,-68(11)
+_GLOBAL(_savegpr_16)
+_GLOBAL(_save32gpr_16)
+	stw	16,-64(11)
+_GLOBAL(_savegpr_17)
+_GLOBAL(_save32gpr_17)
+	stw	17,-60(11)
+_GLOBAL(_savegpr_18)
+_GLOBAL(_save32gpr_18)
+	stw	18,-56(11)
+_GLOBAL(_savegpr_19)
+_GLOBAL(_save32gpr_19)
+	stw	19,-52(11)
+_GLOBAL(_savegpr_20)
+_GLOBAL(_save32gpr_20)
+	stw	20,-48(11)
+_GLOBAL(_savegpr_21)
+_GLOBAL(_save32gpr_21)
+	stw	21,-44(11)
+_GLOBAL(_savegpr_22)
+_GLOBAL(_save32gpr_22)
+	stw	22,-40(11)
+_GLOBAL(_savegpr_23)
+_GLOBAL(_save32gpr_23)
+	stw	23,-36(11)
+_GLOBAL(_savegpr_24)
+_GLOBAL(_save32gpr_24)
+	stw	24,-32(11)
+_GLOBAL(_savegpr_25)
+_GLOBAL(_save32gpr_25)
+	stw	25,-28(11)
+_GLOBAL(_savegpr_26)
+_GLOBAL(_save32gpr_26)
+	stw	26,-24(11)
+_GLOBAL(_savegpr_27)
+_GLOBAL(_save32gpr_27)
+	stw	27,-20(11)
+_GLOBAL(_savegpr_28)
+_GLOBAL(_save32gpr_28)
+	stw	28,-16(11)
+_GLOBAL(_savegpr_29)
+_GLOBAL(_save32gpr_29)
+	stw	29,-12(11)
+_GLOBAL(_savegpr_30)
+_GLOBAL(_save32gpr_30)
+	stw	30,-8(11)
+_GLOBAL(_savegpr_31)
+_GLOBAL(_save32gpr_31)
+	stw	31,-4(11)
+	blr
+
+/* Routines for restoring integer registers, called by the compiler.  */
+/* Called with r11 pointing to the stack header word of the caller of the */
+/* function, just beyond the end of the integer restore area.  */
+
+_GLOBAL(_restgpr_14)
+_GLOBAL(_rest32gpr_14)
+	lwz	14,-72(11)	/* restore gp registers */
+_GLOBAL(_restgpr_15)
+_GLOBAL(_rest32gpr_15)
+	lwz	15,-68(11)
+_GLOBAL(_restgpr_16)
+_GLOBAL(_rest32gpr_16)
+	lwz	16,-64(11)
+_GLOBAL(_restgpr_17)
+_GLOBAL(_rest32gpr_17)
+	lwz	17,-60(11)
+_GLOBAL(_restgpr_18)
+_GLOBAL(_rest32gpr_18)
+	lwz	18,-56(11)
+_GLOBAL(_restgpr_19)
+_GLOBAL(_rest32gpr_19)
+	lwz	19,-52(11)
+_GLOBAL(_restgpr_20)
+_GLOBAL(_rest32gpr_20)
+	lwz	20,-48(11)
+_GLOBAL(_restgpr_21)
+_GLOBAL(_rest32gpr_21)
+	lwz	21,-44(11)
+_GLOBAL(_restgpr_22)
+_GLOBAL(_rest32gpr_22)
+	lwz	22,-40(11)
+_GLOBAL(_restgpr_23)
+_GLOBAL(_rest32gpr_23)
+	lwz	23,-36(11)
+_GLOBAL(_restgpr_24)
+_GLOBAL(_rest32gpr_24)
+	lwz	24,-32(11)
+_GLOBAL(_restgpr_25)
+_GLOBAL(_rest32gpr_25)
+	lwz	25,-28(11)
+_GLOBAL(_restgpr_26)
+_GLOBAL(_rest32gpr_26)
+	lwz	26,-24(11)
+_GLOBAL(_restgpr_27)
+_GLOBAL(_rest32gpr_27)
+	lwz	27,-20(11)
+_GLOBAL(_restgpr_28)
+_GLOBAL(_rest32gpr_28)
+	lwz	28,-16(11)
+_GLOBAL(_restgpr_29)
+_GLOBAL(_rest32gpr_29)
+	lwz	29,-12(11)
+_GLOBAL(_restgpr_30)
+_GLOBAL(_rest32gpr_30)
+	lwz	30,-8(11)
+_GLOBAL(_restgpr_31)
+_GLOBAL(_rest32gpr_31)
+	lwz	31,-4(11)
+	blr
+
+/* Routines for restoring integer registers, called by the compiler.  */
+/* Called with r11 pointing to the stack header word of the caller of the */
+/* function, just beyond the end of the integer restore area.  */
+
+_GLOBAL(_restgpr_14_x)
+_GLOBAL(_rest32gpr_14_x)
+	lwz	14,-72(11)	/* restore gp registers */
+_GLOBAL(_restgpr_15_x)
+_GLOBAL(_rest32gpr_15_x)
+	lwz	15,-68(11)
+_GLOBAL(_restgpr_16_x)
+_GLOBAL(_rest32gpr_16_x)
+	lwz	16,-64(11)
+_GLOBAL(_restgpr_17_x)
+_GLOBAL(_rest32gpr_17_x)
+	lwz	17,-60(11)
+_GLOBAL(_restgpr_18_x)
+_GLOBAL(_rest32gpr_18_x)
+	lwz	18,-56(11)
+_GLOBAL(_restgpr_19_x)
+_GLOBAL(_rest32gpr_19_x)
+	lwz	19,-52(11)
+_GLOBAL(_restgpr_20_x)
+_GLOBAL(_rest32gpr_20_x)
+	lwz	20,-48(11)
+_GLOBAL(_restgpr_21_x)
+_GLOBAL(_rest32gpr_21_x)
+	lwz	21,-44(11)
+_GLOBAL(_restgpr_22_x)
+_GLOBAL(_rest32gpr_22_x)
+	lwz	22,-40(11)
+_GLOBAL(_restgpr_23_x)
+_GLOBAL(_rest32gpr_23_x)
+	lwz	23,-36(11)
+_GLOBAL(_restgpr_24_x)
+_GLOBAL(_rest32gpr_24_x)
+	lwz	24,-32(11)
+_GLOBAL(_restgpr_25_x)
+_GLOBAL(_rest32gpr_25_x)
+	lwz	25,-28(11)
+_GLOBAL(_restgpr_26_x)
+_GLOBAL(_rest32gpr_26_x)
+	lwz	26,-24(11)
+_GLOBAL(_restgpr_27_x)
+_GLOBAL(_rest32gpr_27_x)
+	lwz	27,-20(11)
+_GLOBAL(_restgpr_28_x)
+_GLOBAL(_rest32gpr_28_x)
+	lwz	28,-16(11)
+_GLOBAL(_restgpr_29_x)
+_GLOBAL(_rest32gpr_29_x)
+	lwz	29,-12(11)
+_GLOBAL(_restgpr_30_x)
+_GLOBAL(_rest32gpr_30_x)
+	lwz	30,-8(11)
+_GLOBAL(_restgpr_31_x)
+_GLOBAL(_rest32gpr_31_x)
+	lwz	0,4(11)
+	lwz	31,-4(11)
+	mtlr	0
+	mr	1,11
+	blr
+#endif
-- 
1.5.5.1
