Return-Path: <bigeasy@Chamillionaire.breakpoint.cc>
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc
	[85.10.199.196])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 70C6AB7CF3
	for <linuxppc-dev@ozlabs.org>; Mon,  5 Apr 2010 06:40:46 +1000 (EST)
From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 3/3] powerpc/kexec: Add support for FSL-BookE
Date: Sun,  4 Apr 2010 22:19:03 +0200
Message-Id: <1270412343-19334-4-git-send-email-sebastian@breakpoint.cc>
In-Reply-To: <1270412343-19334-1-git-send-email-sebastian@breakpoint.cc>
References: <1270412343-19334-1-git-send-email-sebastian@breakpoint.cc>
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
 arch/powerpc/kernel/fsl_booke_entry_mapping.S |   37 +++++++++++++++++++++++++
 arch/powerpc/kernel/head_fsl_booke.S          |    2 +
 arch/powerpc/kernel/misc_32.S                 |   17 +++++++++++
 5 files changed, 70 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 2e19500..f8ce19d 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -350,7 +350,7 @@ config ARCH_ENABLE_MEMORY_HOTREMOVE
 
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
index cdb1296..beb4d78 100644
--- a/arch/powerpc/kernel/fsl_booke_entry_mapping.S
+++ b/arch/powerpc/kernel/fsl_booke_entry_mapping.S
@@ -159,6 +159,8 @@ skpinv:	addi	r6,r6,1				/* Increment */
 #define M_IF_SMP	0
 #endif
 
+#if defined(ENTRY_MAPPING_BOOT_SETUP)
+
 /* 6. Setup KERNELBASE mapping in TLB1[0] */
 	lis	r6,0x1000		/* Set MAS0(TLBSEL) = TLB1(1), ESEL = 0 */
 	mtspr	SPRN_MAS0,r6
@@ -174,6 +176,41 @@ skpinv:	addi	r6,r6,1				/* Increment */
 /* 7. Jump to KERNELBASE mapping */
 	lis	r6,(KERNELBASE & ~0xfff)@h
 	ori	r6,r6,(KERNELBASE & ~0xfff)@l
+
+#elif defined(ENTRY_MAPPING_KEXEC_SETUP)
+/*
+ * 6. Setup a 1:1 mapping in TLB1. Esel 0 is unsued, 1 or 2 contains the tmp
+ * mapping so we start at 3. We setup 8 mappings, each 256MiB in size. This
+ * will cover the first 2GiB of memory.
+ */
+
+	lis r10, (MAS1_VALID|MAS1_IPROT)@h
+	ori r10,r10, (MAS1_TSIZE(BOOK3E_PAGESZ_256M))@l
+	li  r11, 0
+	li  r0, 8
+	mtctr   r0
+
+next_tlb_setup:
+	addi	r0, r11, 3
+	rlwinm  r0, r0, 16, 4, 15  // Compute esel
+	rlwinm  r9, r11, 28, 0, 3   // Compute [ER]PN
+	oris    r0, r0, (MAS0_TLBSEL(1))@h
+	mtspr   SPRN_MAS0,r0
+	mtspr   SPRN_MAS1,r10
+	mtspr   SPRN_MAS2,r9
+	ori r9, r9, (MAS3_SX|MAS3_SW|MAS3_SR)
+	mtspr   SPRN_MAS3,r9
+	tlbwe
+	addi    r11, r11, 1
+	bdnz+   next_tlb_setup
+
+/* 7. Jump to our 1:1 mapping */
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
index 3dc7ef7..3620cf5 100644
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
1.6.6.1
