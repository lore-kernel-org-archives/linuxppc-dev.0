Return-Path: <anton@samba.org>
Date: Thu, 5 Jul 2012 16:37:11 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH] powerpc: Add VDSO version of getcpu
Message-ID: <20120705163711.2de88b55@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


We have a request for a fast method of getting CPU and NUMA node IDs
from userspace. This patch implements a getcpu VDSO function,
similar to x86.

Ben suggested we use SPRG3 which is userspace readable. SPRG3 can be
modified by a KVM guest, so we save the SPRG3 value in the paca and
restore it when transitioning from the guest to the host.

I have a glibc patch that implements sched_getcpu on top of this.
Testing on a POWER7:

baseline: 538 cycles 
vdso:      30 cycles

Signed-off-by: Anton Blanchard <anton@samba.org>
---

v2:
- Fix kvm
- add vdso32 version on 64bit kernel

Index: linux-build/arch/powerpc/include/asm/reg.h
===================================================================
--- linux-build.orig/arch/powerpc/include/asm/reg.h	2012-07-05 16:33:46.191266813 +1000
+++ linux-build/arch/powerpc/include/asm/reg.h	2012-07-05 16:34:27.036005107 +1000
@@ -491,6 +491,7 @@
 #define SPRN_SPRG1	0x111	/* Special Purpose Register General 1 */
 #define SPRN_SPRG2	0x112	/* Special Purpose Register General 2 */
 #define SPRN_SPRG3	0x113	/* Special Purpose Register General 3 */
+#define SPRN_USPRG3	0x103	/* SPRG3 userspace read */
 #define SPRN_SPRG4	0x114	/* Special Purpose Register General 4 */
 #define SPRN_SPRG5	0x115	/* Special Purpose Register General 5 */
 #define SPRN_SPRG6	0x116	/* Special Purpose Register General 6 */
@@ -753,14 +754,14 @@
  * 64-bit server:
  *	- SPRG0 unused (reserved for HV on Power4)
  *	- SPRG2 scratch for exception vectors
- *	- SPRG3 unused (user visible)
+ *	- SPRG3 CPU and NUMA node for VDSO getcpu (user visible)
  *      - HSPRG0 stores PACA in HV mode
  *      - HSPRG1 scratch for "HV" exceptions
  *
  * 64-bit embedded
  *	- SPRG0 generic exception scratch
  *	- SPRG2 TLB exception stack
- *	- SPRG3 unused (user visible)
+ *	- SPRG3 CPU and NUMA node for VDSO getcpu (user visible)
  *	- SPRG4 unused (user visible)
  *	- SPRG6 TLB miss scratch (user visible, sorry !)
  *	- SPRG7 critical exception scratch
Index: linux-build/arch/powerpc/kernel/vdso.c
===================================================================
--- linux-build.orig/arch/powerpc/kernel/vdso.c	2012-07-05 16:33:46.311268984 +1000
+++ linux-build/arch/powerpc/kernel/vdso.c	2012-07-05 16:34:27.036005107 +1000
@@ -706,6 +706,34 @@ static void __init vdso_setup_syscall_ma
 	}
 }
 
+#ifdef CONFIG_PPC64
+int __cpuinit vdso_getcpu_init(void)
+{
+	unsigned long cpu, node, val;
+
+	/*
+	 * SPRG3 contains the CPU in the bottom 16 bits and the NUMA node in
+	 * the next 16 bits. The VDSO uses this to implement getcpu().
+	 */
+	cpu = get_cpu();
+	WARN_ON_ONCE(cpu > 0xffff);
+
+	node = cpu_to_node(cpu);
+	WARN_ON_ONCE(node > 0xffff);
+
+	val = (cpu & 0xfff) | ((node & 0xffff) << 16);
+	mtspr(SPRN_SPRG3, val);
+#ifdef CONFIG_KVM_BOOK3S_HANDLER
+	get_paca()->kvm_hstate.sprg3 = val;
+#endif
+
+	put_cpu();
+
+	return 0;
+}
+/* We need to call this before SMP init */
+early_initcall(vdso_getcpu_init);
+#endif
 
 static int __init vdso_init(void)
 {
Index: linux-build/arch/powerpc/kernel/vdso64/Makefile
===================================================================
--- linux-build.orig/arch/powerpc/kernel/vdso64/Makefile	2012-07-05 16:33:46.279268404 +1000
+++ linux-build/arch/powerpc/kernel/vdso64/Makefile	2012-07-05 16:34:27.036005107 +1000
@@ -1,6 +1,6 @@
 # List of files in the vdso, has to be asm only for now
 
-obj-vdso64 = sigtramp.o gettimeofday.o datapage.o cacheflush.o note.o
+obj-vdso64 = sigtramp.o gettimeofday.o datapage.o cacheflush.o note.o getcpu.o
 
 # Build rules
 
Index: linux-build/arch/powerpc/kernel/vdso64/vdso64.lds.S
===================================================================
--- linux-build.orig/arch/powerpc/kernel/vdso64/vdso64.lds.S	2012-07-05 16:33:46.295268693 +1000
+++ linux-build/arch/powerpc/kernel/vdso64/vdso64.lds.S	2012-07-05 16:34:27.036005107 +1000
@@ -146,6 +146,7 @@ VERSION
 		__kernel_sync_dicache;
 		__kernel_sync_dicache_p5;
 		__kernel_sigtramp_rt64;
+		__kernel_getcpu;
 
 	local: *;
 	};
Index: linux-build/arch/powerpc/kernel/vdso64/getcpu.S
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-build/arch/powerpc/kernel/vdso64/getcpu.S	2012-07-05 16:34:27.036005107 +1000
@@ -0,0 +1,45 @@
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
+#include <asm/ppc_asm.h>
+#include <asm/vdso.h>
+
+	.text
+/*
+ * Exact prototype of getcpu
+ *
+ * int __kernel_getcpu(unsigned *cpu, unsigned *node);
+ *
+ */
+V_FUNCTION_BEGIN(__kernel_getcpu)
+  .cfi_startproc
+	mfspr	r5,SPRN_USPRG3
+	cmpdi	cr0,r3,0
+	cmpdi	cr1,r4,0
+	clrlwi  r6,r5,16
+	rlwinm  r7,r5,16,31-15,31-0
+	beq	cr0,1f
+	stw	r6,0(r3)
+1:	beq	cr1,2f
+	stw	r7,0(r4)
+2:	crclr	cr0*4+so
+	li	r3,0			/* always success */
+	blr
+  .cfi_endproc
+V_FUNCTION_END(__kernel_getcpu)
Index: linux-build/arch/powerpc/kernel/smp.c
===================================================================
--- linux-build.orig/arch/powerpc/kernel/smp.c	2012-07-05 16:33:46.259268043 +1000
+++ linux-build/arch/powerpc/kernel/smp.c	2012-07-05 16:34:27.036005107 +1000
@@ -48,6 +48,7 @@
 #ifdef CONFIG_PPC64
 #include <asm/paca.h>
 #endif
+#include <asm/vdso.h>
 #include <asm/debug.h>
 
 #ifdef DEBUG
@@ -570,6 +571,8 @@ void __devinit start_secondary(void *unu
 #ifdef CONFIG_PPC64
 	if (system_state == SYSTEM_RUNNING)
 		vdso_data->processorCount++;
+
+	vdso_getcpu_init();
 #endif
 	ipi_call_lock();
 	notify_cpu_starting(cpu);
Index: linux-build/arch/powerpc/include/asm/vdso.h
===================================================================
--- linux-build.orig/arch/powerpc/include/asm/vdso.h	2012-07-05 16:33:46.179266598 +1000
+++ linux-build/arch/powerpc/include/asm/vdso.h	2012-07-05 16:34:27.036005107 +1000
@@ -22,6 +22,8 @@ extern unsigned long vdso64_rt_sigtramp;
 extern unsigned long vdso32_sigtramp;
 extern unsigned long vdso32_rt_sigtramp;
 
+int __cpuinit vdso_getcpu_init(void);
+
 #else /* __ASSEMBLY__ */
 
 #ifdef __VDSO64__
Index: linux-build/arch/powerpc/kernel/vdso32/Makefile
===================================================================
--- linux-build.orig/arch/powerpc/kernel/vdso32/Makefile	2012-07-05 16:33:46.231267536 +1000
+++ linux-build/arch/powerpc/kernel/vdso32/Makefile	2012-07-05 16:34:27.040005179 +1000
@@ -1,7 +1,9 @@
 
 # List of files in the vdso, has to be asm only for now
 
-obj-vdso32 = sigtramp.o gettimeofday.o datapage.o cacheflush.o note.o
+obj-vdso32-$(CONFIG_PPC64) = getcpu.o
+obj-vdso32 = sigtramp.o gettimeofday.o datapage.o cacheflush.o note.o \
+		$(obj-vdso32-y)
 
 # Build rules
 
Index: linux-build/arch/powerpc/kernel/vdso32/vdso32.lds.S
===================================================================
--- linux-build.orig/arch/powerpc/kernel/vdso32/vdso32.lds.S	2012-07-05 16:33:46.247267827 +1000
+++ linux-build/arch/powerpc/kernel/vdso32/vdso32.lds.S	2012-07-05 16:34:27.040005179 +1000
@@ -147,6 +147,9 @@ VERSION
 		__kernel_sync_dicache_p5;
 		__kernel_sigtramp32;
 		__kernel_sigtramp_rt32;
+#ifdef CONFIG_PPC64
+		__kernel_getcpu;
+#endif
 
 	local: *;
 	};
Index: linux-build/arch/powerpc/kernel/vdso32/getcpu.S
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-build/arch/powerpc/kernel/vdso32/getcpu.S	2012-07-05 16:34:27.040005179 +1000
@@ -0,0 +1,45 @@
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
+#include <asm/ppc_asm.h>
+#include <asm/vdso.h>
+
+	.text
+/*
+ * Exact prototype of getcpu
+ *
+ * int __kernel_getcpu(unsigned *cpu, unsigned *node);
+ *
+ */
+V_FUNCTION_BEGIN(__kernel_getcpu)
+  .cfi_startproc
+	mfspr	r5,SPRN_USPRG3
+	cmpdi	cr0,r3,0
+	cmpdi	cr1,r4,0
+	clrlwi  r6,r5,16
+	rlwinm  r7,r5,16,31-15,31-0
+	beq	cr0,1f
+	stw	r6,0(r3)
+1:	beq	cr1,2f
+	stw	r7,0(r4)
+2:	crclr	cr0*4+so
+	li	r3,0			/* always success */
+	blr
+  .cfi_endproc
+V_FUNCTION_END(__kernel_getcpu)
Index: linux-build/arch/powerpc/include/asm/kvm_book3s_asm.h
===================================================================
--- linux-build.orig/arch/powerpc/include/asm/kvm_book3s_asm.h	2012-07-05 16:33:46.163266308 +1000
+++ linux-build/arch/powerpc/include/asm/kvm_book3s_asm.h	2012-07-05 16:34:27.040005179 +1000
@@ -74,6 +74,7 @@ struct kvmppc_host_state {
 	ulong vmhandler;
 	ulong scratch0;
 	ulong scratch1;
+	ulong sprg3;
 	u8 in_guest;
 	u8 restore_hid5;
 	u8 napping;
Index: linux-build/arch/powerpc/kernel/asm-offsets.c
===================================================================
--- linux-build.orig/arch/powerpc/kernel/asm-offsets.c	2012-07-05 16:33:46.319269127 +1000
+++ linux-build/arch/powerpc/kernel/asm-offsets.c	2012-07-05 16:34:27.040005179 +1000
@@ -533,6 +533,7 @@ int main(void)
 	HSTATE_FIELD(HSTATE_VMHANDLER, vmhandler);
 	HSTATE_FIELD(HSTATE_SCRATCH0, scratch0);
 	HSTATE_FIELD(HSTATE_SCRATCH1, scratch1);
+	HSTATE_FIELD(HSTATE_SPRG3, sprg3);
 	HSTATE_FIELD(HSTATE_IN_GUEST, in_guest);
 	HSTATE_FIELD(HSTATE_RESTORE_HID5, restore_hid5);
 	HSTATE_FIELD(HSTATE_NAPPING, napping);
Index: linux-build/arch/powerpc/kvm/book3s_hv_rmhandlers.S
===================================================================
--- linux-build.orig/arch/powerpc/kvm/book3s_hv_rmhandlers.S	2012-07-05 16:33:46.327269273 +1000
+++ linux-build/arch/powerpc/kvm/book3s_hv_rmhandlers.S	2012-07-05 16:34:27.040005179 +1000
@@ -1067,6 +1067,10 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_206)
 	mtspr	SPRN_DABR,r5
 	mtspr	SPRN_DABRX,r6
 
+	/* Restore SPRG3 */
+	ld	r3,HSTATE_SPRG3(r13)
+	mtspr	SPRN_SPRG3,r3
+
 	/*
 	 * Reload DEC.  HDEC interrupts were disabled when
 	 * we reloaded the host's LPCR value.
