Return-Path: <anton@samba.org>
Date: Mon, 14 Oct 2013 21:03:58 +1100
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc: Add VMX optimised xor for RAID5
Message-ID: <20131014210358.700f3a41@kryten>
In-Reply-To: <1381470838.5630.62.camel@pasglop>
References: <20130926133004.1bff1bd4@kryten> <1381470838.5630.62.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add a VMX optimised xor, used primarily for RAID5. On a POWER7 blade
this is a decent win:

   32regs    : 17932.800 MB/sec
   altivec   : 19724.800 MB/sec

The bigger gain is when the same test is run in SMT4 mode, as it
would if there was a lot of work going on:

   8regs     :  8377.600 MB/sec
   altivec   : 15801.600 MB/sec

I tested this against an array created without the patch, and also
verified it worked as expected on a little endian kernel.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: le-kernel/arch/powerpc/include/asm/xor.h
===================================================================
--- le-kernel.orig/arch/powerpc/include/asm/xor.h
+++ le-kernel/arch/powerpc/include/asm/xor.h
@@ -1 +1,68 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ * Copyright (C) IBM Corporation, 2012
+ *
+ * Author: Anton Blanchard <anton@au.ibm.com>
+ */
+#ifndef _ASM_POWERPC_XOR_H
+#define _ASM_POWERPC_XOR_H
+
+#ifdef CONFIG_ALTIVEC
+
+#include <asm/cputable.h>
+
+void xor_altivec_2(unsigned long bytes, unsigned long *v1_in,
+		   unsigned long *v2_in);
+void xor_altivec_3(unsigned long bytes, unsigned long *v1_in,
+		   unsigned long *v2_in, unsigned long *v3_in);
+void xor_altivec_4(unsigned long bytes, unsigned long *v1_in,
+		   unsigned long *v2_in, unsigned long *v3_in,
+		   unsigned long *v4_in);
+void xor_altivec_5(unsigned long bytes, unsigned long *v1_in,
+		   unsigned long *v2_in, unsigned long *v3_in,
+		   unsigned long *v4_in, unsigned long *v5_in);
+
+static struct xor_block_template xor_block_altivec = {
+	.name = "altivec",
+	.do_2 = xor_altivec_2,
+	.do_3 = xor_altivec_3,
+	.do_4 = xor_altivec_4,
+	.do_5 = xor_altivec_5,
+};
+
+#define XOR_SPEED_ALTIVEC()				\
+	do {						\
+		if (cpu_has_feature(CPU_FTR_ALTIVEC))	\
+			xor_speed(&xor_block_altivec);	\
+	} while (0)
+#else
+#define XOR_SPEED_ALTIVEC
+#endif
+
+/* Also try the generic routines. */
 #include <asm-generic/xor.h>
+
+#undef XOR_TRY_TEMPLATES
+#define XOR_TRY_TEMPLATES				\
+do {							\
+	xor_speed(&xor_block_8regs);			\
+	xor_speed(&xor_block_8regs_p);			\
+	xor_speed(&xor_block_32regs);			\
+	xor_speed(&xor_block_32regs_p);			\
+	XOR_SPEED_ALTIVEC();				\
+} while (0)
+
+#endif /* _ASM_POWERPC_XOR_H */
Index: le-kernel/arch/powerpc/lib/Makefile
===================================================================
--- le-kernel.orig/arch/powerpc/lib/Makefile
+++ le-kernel/arch/powerpc/lib/Makefile
@@ -39,3 +39,6 @@ obj-$(CONFIG_PPC_LIB_RHEAP) += rheap.o
 obj-y			+= code-patching.o
 obj-y			+= feature-fixups.o
 obj-$(CONFIG_FTR_FIXUP_SELFTEST) += feature-fixups-test.o
+
+obj-$(CONFIG_ALTIVEC)	+= xor_vmx.o
+CFLAGS_xor_vmx.o += -maltivec -mabi=altivec
Index: le-kernel/arch/powerpc/lib/xor_vmx.c
===================================================================
--- /dev/null
+++ le-kernel/arch/powerpc/lib/xor_vmx.c
@@ -0,0 +1,177 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ * Copyright (C) IBM Corporation, 2012
+ *
+ * Author: Anton Blanchard <anton@au.ibm.com>
+ */
+#include <altivec.h>
+
+#include <linux/preempt.h>
+#include <linux/export.h>
+#include <linux/sched.h>
+#include <asm/switch_to.h>
+
+typedef vector signed char unative_t;
+
+#define DEFINE(V)				\
+	unative_t *V = (unative_t *)V##_in;	\
+	unative_t V##_0, V##_1, V##_2, V##_3
+
+#define LOAD(V)			\
+	do {			\
+		V##_0 = V[0];	\
+		V##_1 = V[1];	\
+		V##_2 = V[2];	\
+		V##_3 = V[3];	\
+	} while (0)
+
+#define STORE(V)		\
+	do {			\
+		V[0] = V##_0;	\
+		V[1] = V##_1;	\
+		V[2] = V##_2;	\
+		V[3] = V##_3;	\
+	} while (0)
+
+#define XOR(V1, V2)					\
+	do {						\
+		V1##_0 = vec_xor(V1##_0, V2##_0);	\
+		V1##_1 = vec_xor(V1##_1, V2##_1);	\
+		V1##_2 = vec_xor(V1##_2, V2##_2);	\
+		V1##_3 = vec_xor(V1##_3, V2##_3);	\
+	} while (0)
+
+void xor_altivec_2(unsigned long bytes, unsigned long *v1_in,
+		   unsigned long *v2_in)
+{
+	DEFINE(v1);
+	DEFINE(v2);
+	unsigned long lines = bytes / (sizeof(unative_t)) / 4;
+
+	preempt_disable();
+	enable_kernel_altivec();
+
+	do {
+		LOAD(v1);
+		LOAD(v2);
+		XOR(v1, v2);
+		STORE(v1);
+
+		v1 += 4;
+		v2 += 4;
+	} while (--lines > 0);
+
+	preempt_enable();
+}
+EXPORT_SYMBOL(xor_altivec_2);
+
+void xor_altivec_3(unsigned long bytes, unsigned long *v1_in,
+		   unsigned long *v2_in, unsigned long *v3_in)
+{
+	DEFINE(v1);
+	DEFINE(v2);
+	DEFINE(v3);
+	unsigned long lines = bytes / (sizeof(unative_t)) / 4;
+
+	preempt_disable();
+	enable_kernel_altivec();
+
+	do {
+		LOAD(v1);
+		LOAD(v2);
+		LOAD(v3);
+		XOR(v1, v2);
+		XOR(v1, v3);
+		STORE(v1);
+
+		v1 += 4;
+		v2 += 4;
+		v3 += 4;
+	} while (--lines > 0);
+
+	preempt_enable();
+}
+EXPORT_SYMBOL(xor_altivec_3);
+
+void xor_altivec_4(unsigned long bytes, unsigned long *v1_in,
+		   unsigned long *v2_in, unsigned long *v3_in,
+		   unsigned long *v4_in)
+{
+	DEFINE(v1);
+	DEFINE(v2);
+	DEFINE(v3);
+	DEFINE(v4);
+	unsigned long lines = bytes / (sizeof(unative_t)) / 4;
+
+	preempt_disable();
+	enable_kernel_altivec();
+
+	do {
+		LOAD(v1);
+		LOAD(v2);
+		LOAD(v3);
+		LOAD(v4);
+		XOR(v1, v2);
+		XOR(v3, v4);
+		XOR(v1, v3);
+		STORE(v1);
+
+		v1 += 4;
+		v2 += 4;
+		v3 += 4;
+		v4 += 4;
+	} while (--lines > 0);
+
+	preempt_enable();
+}
+EXPORT_SYMBOL(xor_altivec_4);
+
+void xor_altivec_5(unsigned long bytes, unsigned long *v1_in,
+		   unsigned long *v2_in, unsigned long *v3_in,
+		   unsigned long *v4_in, unsigned long *v5_in)
+{
+	DEFINE(v1);
+	DEFINE(v2);
+	DEFINE(v3);
+	DEFINE(v4);
+	DEFINE(v5);
+	unsigned long lines = bytes / (sizeof(unative_t)) / 4;
+
+	preempt_disable();
+	enable_kernel_altivec();
+
+	do {
+		LOAD(v1);
+		LOAD(v2);
+		LOAD(v3);
+		LOAD(v4);
+		LOAD(v5);
+		XOR(v1, v2);
+		XOR(v3, v4);
+		XOR(v1, v5);
+		XOR(v1, v3);
+		STORE(v1);
+
+		v1 += 4;
+		v2 += 4;
+		v3 += 4;
+		v4 += 4;
+		v5 += 4;
+	} while (--lines > 0);
+
+	preempt_enable();
+}
+EXPORT_SYMBOL(xor_altivec_5);
