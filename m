Return-Path: <anton@samba.org>
Date: Tue, 15 Nov 2011 09:54:47 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, michael@ellerman.id.au
Subject: [PATCH] powerpc: Copy down exception vectors after feature fixups
Message-ID: <20111115095447.5a5d5858@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


kdump fails because we try to execute an HV only instruction. Feature
fixups are being applied after we copy the exception vectors down to 0
so they miss out on any updates.

We have always had this issue but it only became critical in v3.0
when we added CFAR support (breaks POWER5) and v3.1 when we added
POWERNV (breaks everyone).

Signed-off-by: Anton Blanchard <anton@samba.org>
Cc: <stable@kernel.org> [v3.0+]
---

Index: linux-build/arch/powerpc/include/asm/sections.h
===================================================================
--- linux-build.orig/arch/powerpc/include/asm/sections.h	2011-09-06 17:24:51.380399734 +1000
+++ linux-build/arch/powerpc/include/asm/sections.h	2011-11-14 11:07:52.167266682 +1100
@@ -8,7 +8,7 @@
 
 #ifdef __powerpc64__
 
-extern char _end[];
+extern char __end_interrupts[];
 
 static inline int in_kernel_text(unsigned long addr)
 {
Index: linux-build/arch/powerpc/kernel/kvm.c
===================================================================
--- linux-build.orig/arch/powerpc/kernel/kvm.c	2011-11-08 11:41:51.818584018 +1100
+++ linux-build/arch/powerpc/kernel/kvm.c	2011-11-14 11:07:52.167266682 +1100
@@ -132,7 +132,6 @@ static void kvm_patch_ins_b(u32 *inst, i
 	/* On relocatable kernels interrupts handlers and our code
 	   can be in different regions, so we don't patch them */
 
-	extern u32 __end_interrupts;
 	if ((ulong)inst < (ulong)&__end_interrupts)
 		return;
 #endif
Index: linux-build/arch/powerpc/include/asm/synch.h
===================================================================
--- linux-build.orig/arch/powerpc/include/asm/synch.h	2011-09-07 15:15:49.106458709 +1000
+++ linux-build/arch/powerpc/include/asm/synch.h	2011-11-14 11:07:52.167266682 +1100
@@ -13,6 +13,7 @@
 extern unsigned int __start___lwsync_fixup, __stop___lwsync_fixup;
 extern void do_lwsync_fixups(unsigned long value, void *fixup_start,
 			     void *fixup_end);
+extern void do_final_fixups(void);
 
 static inline void eieio(void)
 {
Index: linux-build/arch/powerpc/kernel/setup_64.c
===================================================================
--- linux-build.orig/arch/powerpc/kernel/setup_64.c	2011-11-08 11:41:51.822584088 +1100
+++ linux-build/arch/powerpc/kernel/setup_64.c	2011-11-14 11:07:52.167266682 +1100
@@ -359,6 +359,7 @@ void __init setup_system(void)
 			  &__start___fw_ftr_fixup, &__stop___fw_ftr_fixup);
 	do_lwsync_fixups(cur_cpu_spec->cpu_features,
 			 &__start___lwsync_fixup, &__stop___lwsync_fixup);
+	do_final_fixups();
 
 	/*
 	 * Unflatten the device-tree passed by prom_init or kexec
Index: linux-build/arch/powerpc/kernel/setup_32.c
===================================================================
--- linux-build.orig/arch/powerpc/kernel/setup_32.c	2011-11-08 11:41:51.822584088 +1100
+++ linux-build/arch/powerpc/kernel/setup_32.c	2011-11-14 11:07:52.171266753 +1100
@@ -107,6 +107,8 @@ notrace unsigned long __init early_init(
 			 PTRRELOC(&__start___lwsync_fixup),
 			 PTRRELOC(&__stop___lwsync_fixup));
 
+	do_final_fixups();
+
 	return KERNELBASE + offset;
 }
 
Index: linux-build/arch/powerpc/lib/feature-fixups.c
===================================================================
--- linux-build.orig/arch/powerpc/lib/feature-fixups.c	2011-09-07 15:15:49.146459439 +1000
+++ linux-build/arch/powerpc/lib/feature-fixups.c	2011-11-15 09:33:41.346993356 +1100
@@ -18,6 +18,8 @@
 #include <linux/init.h>
 #include <asm/cputable.h>
 #include <asm/code-patching.h>
+#include <asm/page.h>
+#include <asm/sections.h>
 
 
 struct fixup_entry {
@@ -128,6 +130,27 @@ void do_lwsync_fixups(unsigned long valu
 	}
 }
 
+void do_final_fixups(void)
+{
+#if defined(CONFIG_PPC64) && defined(CONFIG_RELOCATABLE)
+	int *src, *dest;
+	unsigned long length;
+
+	if (PHYSICAL_START == 0)
+		return;
+
+	src = (int *)(KERNELBASE + PHYSICAL_START);
+	dest = (int *)KERNELBASE;
+	length = (__end_interrupts - _stext) / sizeof(int);
+
+	while (length--) {
+		patch_instruction(dest, *src);
+		src++;
+		dest++;
+	}
+#endif
+}
+
 #ifdef CONFIG_FTR_FIXUP_SELFTEST
 
 #define check(x)	\
