Return-Path: <anton@samba.org>
Date: Wed, 30 May 2012 15:31:24 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, michael@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/2] powerpc: Rename copyuser_power7_vmx.c to vmx-helper.c
Message-ID: <20120530153124.6a27d10d@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Subsequent patches will add more VMX library functions and it makes
sense to keep all the c-code helper functions in the one file.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-build/arch/powerpc/lib/Makefile
===================================================================
--- linux-build.orig/arch/powerpc/lib/Makefile	2012-05-30 09:39:59.084233436 +1000
+++ linux-build/arch/powerpc/lib/Makefile	2012-05-30 10:22:32.565764322 +1000
@@ -24,7 +24,7 @@ obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= sste
 
 ifeq ($(CONFIG_PPC64),y)
 obj-$(CONFIG_SMP)	+= locks.o
-obj-$(CONFIG_ALTIVEC)	+= copyuser_power7_vmx.o
+obj-$(CONFIG_ALTIVEC)	+= vmx-helper.o
 endif
 
 obj-$(CONFIG_PPC_LIB_RHEAP) += rheap.o
Index: linux-build/arch/powerpc/lib/vmx-helper.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-build/arch/powerpc/lib/vmx-helper.c	2012-05-30 10:22:32.577764541 +1000
@@ -0,0 +1,51 @@
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
+ * Copyright (C) IBM Corporation, 2011
+ *
+ * Authors: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
+ *          Anton Blanchard <anton@au.ibm.com>
+ */
+#include <linux/uaccess.h>
+#include <linux/hardirq.h>
+#include <asm/switch_to.h>
+
+int enter_vmx_usercopy(void)
+{
+	if (in_interrupt())
+		return 0;
+
+	/* This acts as preempt_disable() as well and will make
+	 * enable_kernel_altivec(). We need to disable page faults
+	 * as they can call schedule and thus make us lose the VMX
+	 * context. So on page faults, we just fail which will cause
+	 * a fallback to the normal non-vmx copy.
+	 */
+	pagefault_disable();
+
+	enable_kernel_altivec();
+
+	return 1;
+}
+
+/*
+ * This function must return 0 because we tail call optimise when calling
+ * from __copy_tofrom_user_power7 which returns 0 on success.
+ */
+int exit_vmx_usercopy(void)
+{
+	pagefault_enable();
+	return 0;
+}
Index: linux-build/arch/powerpc/lib/copyuser_power7_vmx.c
===================================================================
--- linux-build.orig/arch/powerpc/lib/copyuser_power7_vmx.c	2012-05-28 17:18:38.213091662 +1000
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,51 +0,0 @@
-/*
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
- *
- * Copyright (C) IBM Corporation, 2011
- *
- * Authors: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
- *          Anton Blanchard <anton@au.ibm.com>
- */
-#include <linux/uaccess.h>
-#include <linux/hardirq.h>
-#include <asm/switch_to.h>
-
-int enter_vmx_copy(void)
-{
-	if (in_interrupt())
-		return 0;
-
-	/* This acts as preempt_disable() as well and will make
-	 * enable_kernel_altivec(). We need to disable page faults
-	 * as they can call schedule and thus make us lose the VMX
-	 * context. So on page faults, we just fail which will cause
-	 * a fallback to the normal non-vmx copy.
-	 */
-	pagefault_disable();
-
-	enable_kernel_altivec();
-
-	return 1;
-}
-
-/*
- * This function must return 0 because we tail call optimise when calling
- * from __copy_tofrom_user_power7 which returns 0 on success.
- */
-int exit_vmx_copy(void)
-{
-	pagefault_enable();
-	return 0;
-}
Index: linux-build/arch/powerpc/lib/copyuser_power7.S
===================================================================
--- linux-build.orig/arch/powerpc/lib/copyuser_power7.S	2012-05-29 21:22:43.725611809 +1000
+++ linux-build/arch/powerpc/lib/copyuser_power7.S	2012-05-30 10:23:29.198797007 +1000
@@ -61,7 +61,7 @@
 	ld	r15,STK_REG(r15)(r1)
 	ld	r14,STK_REG(r14)(r1)
 .Ldo_err3:
-	bl	.exit_vmx_copy
+	bl	.exit_vmx_usercopy
 	ld	r0,STACKFRAMESIZE+16(r1)
 	mtlr	r0
 	b	.Lexit
@@ -290,7 +290,7 @@ err1;	stb	r0,0(r3)
 	mflr	r0
 	std	r0,16(r1)
 	stdu	r1,-STACKFRAMESIZE(r1)
-	bl	.enter_vmx_copy
+	bl	.enter_vmx_usercopy
 	cmpwi	r3,0
 	ld	r0,STACKFRAMESIZE+16(r1)
 	ld	r3,STACKFRAMESIZE+48(r1)
@@ -507,7 +507,7 @@ err3;	lbz	r0,0(r4)
 err3;	stb	r0,0(r3)
 
 15:	addi	r1,r1,STACKFRAMESIZE
-	b	.exit_vmx_copy		/* tail call optimise */
+	b	.exit_vmx_usercopy	/* tail call optimise */
 
 .Lvmx_unaligned_copy:
 	/* Get the destination 16B aligned */
@@ -710,5 +710,5 @@ err3;	lbz	r0,0(r4)
 err3;	stb	r0,0(r3)
 
 15:	addi	r1,r1,STACKFRAMESIZE
-	b	.exit_vmx_copy		/* tail call optimise */
+	b	.exit_vmx_usercopy	/* tail call optimise */
 #endif /* CONFiG_ALTIVEC */
