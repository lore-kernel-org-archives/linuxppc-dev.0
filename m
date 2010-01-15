Return-Path: <bigeasy@Chamillionaire.breakpoint.cc>
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc
	[85.10.199.196])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8CD0DB7CC0
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Jan 2010 04:11:01 +1100 (EST)
From: Sebastian Andrzej Siewior <linuxppc-dev@ml.breakpoint.cc>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 5/5] powerpc/kexec: Add support for FSL-BookE
Date: Fri, 15 Jan 2010 17:41:37 +0100
Message-Id: <1263573697-17839-6-git-send-email-linuxppc-dev@ml.breakpoint.cc>
In-Reply-To: <1263573697-17839-1-git-send-email-linuxppc-dev@ml.breakpoint.cc>
References: <1263573697-17839-1-git-send-email-linuxppc-dev@ml.breakpoint.cc>
Cc: linuxppc-dev@ozlabs.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

This adds support kexec on FSL-BookE where the MMU can not be simply
switched off. The code borrows the initial MMU-setup code to create the
identical mapping mapping. The only difference to the original boot code
is the size of the mapping(s) and the executeable address.
The kexec code maps the first 2 GiB of memory in 256 MiB steps. This
should work also on e500v1 boxes.
SMP support is still not available.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/powerpc/Kconfig                          |    2 +-
 arch/powerpc/include/asm/kexec.h              |   13 +++++++++
 arch/powerpc/kernel/fsl_booke_entry_mapping.S |   34 +++++++++++++++++++++++++
 arch/powerpc/kernel/head_fsl_booke.S          |    2 +
 arch/powerpc/kernel/misc_32.S                 |   17 ++++++++++++
 5 files changed, 67 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index ba3948c..788a154 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -335,7 +335,7 @@ config ARCH_ENABLE_MEMORY_HOTREMOVE
 
 config KEXEC
 	bool "kexec system call (EXPERIMENTAL)"
-	depends on PPC_BOOK3S && EXPERIMENTAL
+	depends on (PPC_BOOK3S || (FSL_BOOKE && !SMP)) && EXPERIMENTAL
 	help
 	  kexec is a system call that implements the ability to shutdown your
 	  current kernel, and to start another kernel.  It is like a reboot
diff --git a/arch/powerpc/include/asm/kexec.h b/arch/powerpc/include/asm/kexec.h
index 7e06b43..83f6481 100644
--- a/arch/powerpc/include/asm/kexec.h
+++ b/arch/powerpc/include/asm/kexec.h
@@ -2,6 +2,18 @@
 #define _ASM_POWERPC_KEXEC_H
 #ifdef __KERNEL__
 
+#ifdef CONFIG_FSL_BOOKE
+
+/*
+ * On FSL-BookE we setup a 1:1 mapping which covers the first 2GiB of memory
+ * and therefore we can only deal with memory within this range
+ */
+#define KEXEC_SOURCE_MEMORY_LIMIT	(2 * 1024 * 1024 * 1024UL)
+#define KEXEC_DESTINATION_MEMORY_LIMIT	(2 * 1024 * 1024 * 1024UL)
+#define KEXEC_CONTROL_MEMORY_LIMIT	(2 * 1024 * 1024 * 1024UL)
+
+#else
+
 /*
  * Maximum page that is mapped directly into kernel memory.
  * XXX: Since we copy virt we can use any page we allocate
@@ -21,6 +33,7 @@
 /* TASK_SIZE, probably left over from use_mm ?? */
 #define KEXEC_CONTROL_MEMORY_LIMIT TASK_SIZE
 #endif
+#endif
 
 #define KEXEC_CONTROL_PAGE_SIZE 4096
 
diff --git a/arch/powerpc/kernel/fsl_booke_entry_mapping.S b/arch/powerpc/kernel/fsl_booke_entry_mapping.S
index d629618..1fc283a 100644
--- a/arch/powerpc/kernel/fsl_booke_entry_mapping.S
+++ b/arch/powerpc/kernel/fsl_booke_entry_mapping.S
@@ -155,6 +155,8 @@ skpinv:	addi	r6,r6,1				/* Increment */
 #define M_IF_SMP	0
 #endif
 
+#if defined(ENTRY_MAPPING_BOOT_SETUP)
+
 /* 6. Setup KERNELBASE mapping in TLB1[0] */
 	lis	r6,0x1000		/* Set MAS0(TLBSEL) = TLB1(1), ESEL = 0 */
 	mtspr	SPRN_MAS0,r6
@@ -170,6 +172,38 @@ skpinv:	addi	r6,r6,1				/* Increment */
 /* 7. Jump to KERNELBASE mapping */
 	lis	r6,(KERNELBASE & ~0xfff)@h
 	ori	r6,r6,(KERNELBASE & ~0xfff)@l
+
+#elif defined(ENTRY_MAPPING_KEXEC_SETUP)
+/*
+ * 6. Setup 1:1 mapping TLB1[0 - 8]. We start 0 and map in 256 MiB steps the
+ * first 2GiB of memory.
+ */
+	lis	r10, (MAS1_VALID|MAS1_IPROT)@h
+	ori	r10,r10, (MAS1_TSIZE(BOOK3E_PAGESZ_256M))@l
+	li	r11, 0		// We use 16 esel slots and map 4 GiB
+	li	r0, 8		// of mem 1:1 from 0 to 4 GiB - 1 in
+	mtctr	r0		// 256 MiB mem steps
+
+next_tlb_setup:
+	rlwinm	r0, r11, 16, 4, 15	// Compute esel
+	rlwinm	r9, r11, 28, 0, 3	// Compute [ER]PN
+	oris	r0, r0, (MAS0_TLBSEL(1))@h
+	mtspr	SPRN_MAS0,r0
+	mtspr	SPRN_MAS1,r10
+	mtspr	SPRN_MAS2,r9
+	ori	r9, r9, (MAS3_SX|MAS3_SW|MAS3_SR)
+	mtspr	SPRN_MAS3,r9
+	tlbwe
+	addi	r11, r11, 1
+	bdnz+	next_tlb_setup
+
+/* 7. Jump to KERNELBASE mapping */
+	li	r6, 0
+
+#else
+	#error You need to specify the mapping or not use this at all.
+#endif
+
 	lis	r7,MSR_KERNEL@h
 	ori	r7,r7,MSR_KERNEL@l
 	bl	1f			/* Find our address */
diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index 4de9bc5..fcace7b 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -95,7 +95,9 @@ _ENTRY(_start);
 
 _ENTRY(__early_start)
 
+#define ENTRY_MAPPING_BOOT_SETUP
 #include "fsl_booke_entry_mapping.S"
+#undef ENTRY_MAPPING_BOOT_SETUP
 
 	/* Establish the interrupt vector offsets */
 	SET_IVOR(0,  CriticalInput);
diff --git a/arch/powerpc/kernel/misc_32.S b/arch/powerpc/kernel/misc_32.S
index 8649f53..99bc652 100644
--- a/arch/powerpc/kernel/misc_32.S
+++ b/arch/powerpc/kernel/misc_32.S
@@ -706,6 +706,22 @@ relocate_new_kernel:
 	/* r4 = reboot_code_buffer */
 	/* r5 = start_address      */
 
+#ifdef CONFIG_FSL_BOOKE
+
+	mr	r29, r3
+	mr	r30, r4
+	mr	r31, r5
+
+#define ENTRY_MAPPING_KEXEC_SETUP
+#include "fsl_booke_entry_mapping.S"
+#undef ENTRY_MAPPING_KEXEC_SETUP
+
+	mr      r3, r29
+	mr      r4, r30
+	mr      r5, r31
+
+	li	r0, 0
+#else
 	li	r0, 0
 
 	/*
@@ -722,6 +738,7 @@ relocate_new_kernel:
 	rfi
 
 1:
+#endif
 	/* from this point address translation is turned off */
 	/* and interrupts are disabled */
 
-- 
1.6.2.5
