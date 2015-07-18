Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0130.outbound.protection.outlook.com [157.56.110.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 162931A0EFB
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Jul 2015 06:09:41 +1000 (AEST)
From: Scott Wood <scottwood@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
CC: Tiejun Chen <tiejun.chen@intel.com>, <kexec@lists.infradead.org>, "Tiejun
 Chen" <tiejun.chen@windriver.com>, Scott Wood <scottwood@freescale.com>
Subject: [RFC PATCH 17/17] powerpc/book3e-64: Enable kexec
Date: Sat, 18 Jul 2015 15:08:54 -0500
Message-ID: <1437250134-307-18-git-send-email-scottwood@freescale.com>
In-Reply-To: <1437250134-307-1-git-send-email-scottwood@freescale.com>
References: <1437250134-307-1-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Tiejun Chen <tiejun.chen@windriver.com>

Allow KEXEC for book3e, and bypass or convert non-book3e stuff
in kexec code.

Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
[scottwood@freescale.com: move code to minimize diff, and cleanup]
Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/Kconfig                   |  2 +-
 arch/powerpc/kernel/machine_kexec_64.c | 19 +++++++++++++++++++
 arch/powerpc/kernel/misc_64.S          |  6 ++++++
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 5ef2711..710dcdb 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -414,7 +414,7 @@ config PPC64_SUPPORTS_MEMORY_FAILURE
 
 config KEXEC
 	bool "kexec system call"
-	depends on (PPC_BOOK3S || FSL_BOOKE || (44x && !SMP))
+	depends on (PPC_BOOK3S || FSL_BOOKE || (44x && !SMP)) || PPC_BOOK3E
 	help
 	  kexec is a system call that implements the ability to shutdown your
 	  current kernel, and to start another kernel.  It is like a reboot
diff --git a/arch/powerpc/kernel/machine_kexec_64.c b/arch/powerpc/kernel/machine_kexec_64.c
index 1a74446..b0d42a7 100644
--- a/arch/powerpc/kernel/machine_kexec_64.c
+++ b/arch/powerpc/kernel/machine_kexec_64.c
@@ -30,6 +30,21 @@
 #include <asm/smp.h>
 #include <asm/hw_breakpoint.h>
 
+#ifdef CONFIG_PPC_BOOK3E
+int default_machine_kexec_prepare(struct kimage *image)
+{
+	int i;
+	/*
+	 * Since we use the kernel fault handlers and paging code to
+	 * handle the virtual mode, we must make sure no destination
+	 * overlaps kernel static data or bss.
+	 */
+	for (i = 0; i < image->nr_segments; i++)
+		if (image->segment[i].mem < __pa(_end))
+			return -ETXTBSY;
+	return 0;
+}
+#else
 int default_machine_kexec_prepare(struct kimage *image)
 {
 	int i;
@@ -95,6 +110,7 @@ int default_machine_kexec_prepare(struct kimage *image)
 
 	return 0;
 }
+#endif /* !CONFIG_PPC_BOOK3E */
 
 static void copy_segments(unsigned long ind)
 {
@@ -365,6 +381,7 @@ void default_machine_kexec(struct kimage *image)
 	/* NOTREACHED */
 }
 
+#ifndef CONFIG_PPC_BOOK3E
 /* Values we need to export to the second kernel via the device tree. */
 static unsigned long htab_base;
 static unsigned long htab_size;
@@ -411,3 +428,5 @@ static int __init export_htab_values(void)
 	return 0;
 }
 late_initcall(export_htab_values);
+#endif /* !CONFIG_PPC_BOOK3E */
+
diff --git a/arch/powerpc/kernel/misc_64.S b/arch/powerpc/kernel/misc_64.S
index fb955d9..8cf0b8ae 100644
--- a/arch/powerpc/kernel/misc_64.S
+++ b/arch/powerpc/kernel/misc_64.S
@@ -624,9 +624,13 @@ _GLOBAL(kexec_sequence)
 	lhz	r25,PACAHWCPUID(r13)	/* get our phys cpu from paca */
 
 	/* disable interrupts, we are overwriting kernel data next */
+#ifdef CONFIG_PPC_BOOK3E
+	wrteei	0
+#else
 	mfmsr	r3
 	rlwinm	r3,r3,0,17,15
 	mtmsrd	r3,1
+#endif
 
 	/* copy dest pages, flush whole dest image */
 	mr	r3,r29
@@ -648,6 +652,7 @@ _GLOBAL(kexec_sequence)
 	li	r6,1
 	stw	r6,kexec_flag-1b(5)
 
+#ifndef CONFIG_PPC_BOOK3E
 	/* clear out hardware hash page table and tlb */
 #if !defined(_CALL_ELF) || _CALL_ELF != 2
 	ld	r12,0(r27)		/* deref function descriptor */
@@ -656,6 +661,7 @@ _GLOBAL(kexec_sequence)
 #endif
 	mtctr	r12
 	bctrl				/* ppc_md.hpte_clear_all(void); */
+#endif /* !CONFIG_PPC_BOOK3E */
 
 /*
  *   kexec image calling is:
-- 
2.1.4
