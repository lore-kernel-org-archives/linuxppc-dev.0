Return-Path: <shaggy@linux.vnet.ibm.com>
Message-Id: <20080707143011.544193207@linux.vnet.ibm.com>
References: <20080707142850.034542257@linux.vnet.ibm.com>
Date: Mon, 07 Jul 2008 09:28:54 -0500
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@au1.ibm.com>
Subject: [patch 4/5] powerpc: Add Strong Access Ordering
Cc: linuxppc-dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Allow an application to enable Strong Access Ordering on specific pages of
memory on Power 7 hardware. Currently, power has a weaker memory model than
x86. Implementing a stronger memory model allows an emulator to more
efficiently translate x86 code into power code, resulting in faster code
execution.

On Power 7 hardware, storing 0b1110 in the WIMG bits of the hpte enables
strong access ordering mode for the memory page.  This patchset allows a
user to specify which pages are thus enabled by passing a new protection
bit through mmap() and mprotect().  I have tentatively defined this bit,
PROT_SAO, as 0x10.

Signed-off-by: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
---

 arch/powerpc/kernel/syscalls.c |    3 +++
 include/asm-powerpc/mman.h     |   30 ++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

Index: b/arch/powerpc/kernel/syscalls.c
===================================================================
--- a/arch/powerpc/kernel/syscalls.c
+++ b/arch/powerpc/kernel/syscalls.c
@@ -143,6 +143,9 @@
 	struct file * file = NULL;
 	unsigned long ret = -EINVAL;
 
+	if (!arch_validate_prot(prot))
+		goto out;
+
 	if (shift) {
 		if (off & ((1 << shift) - 1))
 			goto out;
Index: b/include/asm-powerpc/mman.h
===================================================================
--- a/include/asm-powerpc/mman.h
+++ b/include/asm-powerpc/mman.h
@@ -1,7 +1,9 @@
 #ifndef _ASM_POWERPC_MMAN_H
 #define _ASM_POWERPC_MMAN_H
 
+#include <asm/cputable.h>
 #include <asm-generic/mman.h>
+#include <linux/mm.h>
 
 /*
  * This program is free software; you can redistribute it and/or
@@ -26,4 +28,32 @@
 #define MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
 #define MAP_NONBLOCK	0x10000		/* do not block on IO */
 
+#ifdef CONFIG_PPC64
+/*
+ * This file is included by linux/mman.h, so we can't use cacl_vm_prot_bits()
+ * here.  How important is the optimization?
+ */
+static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot)
+{
+	return (prot & PROT_SAO) ? VM_SAO : 0;
+}
+#define arch_calc_vm_prot_bits(prot) arch_calc_vm_prot_bits(prot)
+
+static inline pgprot_t arch_vm_get_page_prot(unsigned long vm_flags)
+{
+	return (vm_flags & VM_SAO) ? __pgprot(_PAGE_SAO) : 0;
+}
+#define arch_vm_get_page_prot(vm_flags) arch_vm_get_page_prot(vm_flags)
+
+static inline int arch_validate_prot(unsigned long prot)
+{
+	if (prot & ~(PROT_READ | PROT_WRITE | PROT_EXEC | PROT_SEM | PROT_SAO))
+		return 0;
+	if ((prot & PROT_SAO) && !cpu_has_feature(CPU_FTR_SAO))
+		return 0;
+	return 1;
+}
+#define arch_validate_prot(prot) arch_validate_prot(prot)
+
+#endif /* CONFIG_PPC64 */
 #endif	/* _ASM_POWERPC_MMAN_H */

-- 
Dave Kleikamp
IBM Linux Technology Center
