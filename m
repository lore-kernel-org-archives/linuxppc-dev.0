Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xMFKB5F32zDsPt
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Aug 2017 22:01:18 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id e3so2183681pfc.5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Aug 2017 05:01:18 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v2 2/4] powerpc: Fix powerpc-specific watchdog build
 configuration
Date: Tue,  1 Aug 2017 22:00:52 +1000
Message-Id: <20170801120054.3447-3-npiggin@gmail.com>
In-Reply-To: <20170801120054.3447-1-npiggin@gmail.com>
References: <20170801120054.3447-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The powerpc kernel/watchdog.o should be built when HARDLOCKUP_DETECTOR
and HAVE_HARDLOCKUP_DETECTOR_ARCH are both selected. If only the former
is selected, then the generic perf watchdog has been selected.

To simplify this check, introduce a new Kconfig symbol PPC_WATCHDOG that
depends on both. This Kconfig option means the powerpc specific
watchdog is enabled.

Without this patch, Book3E will attempt to build the powerpc watchdog.

Fixes: 2104180a53 ("powerpc/64s: implement arch-specific hardlockup watchdog")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/Kconfig                 | 11 +++++++++++
 arch/powerpc/kernel/Makefile         |  2 +-
 arch/powerpc/kernel/exceptions-64s.S |  6 +++---
 3 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 36f858c37ca7..2a5060aa1674 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -85,6 +85,17 @@ config NMI_IPI
 	depends on SMP && (DEBUGGER || KEXEC_CORE || HARDLOCKUP_DETECTOR)
 	default y
 
+config PPC_WATCHDOG
+	bool
+	depends on HARDLOCKUP_DETECTOR
+	depends on HAVE_HARDLOCKUP_DETECTOR_ARCH
+	default y
+	help
+	  This is a placeholder when the powerpc hardlockup detector
+	  watchdog is selected (arch/powerpc/kernel/watchdog.c). It is
+	  seleted via the generic lockup detector menu which is why we
+	  have no standalone config option for it here.
+
 config STACKTRACE_SUPPORT
 	bool
 	default y
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 4aa7c147e447..5622bd0248e5 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -38,7 +38,7 @@ obj-$(CONFIG_PPC64)		+= setup_64.o sys_ppc32.o \
 				   signal_64.o ptrace32.o \
 				   paca.o nvram_64.o firmware.o
 obj-$(CONFIG_VDSO32)		+= vdso32/
-obj-$(CONFIG_HARDLOCKUP_DETECTOR)	+= watchdog.o
+obj-$(CONFIG_PPC_WATCHDOG)	+= watchdog.o
 obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= hw_breakpoint.o
 obj-$(CONFIG_PPC_BOOK3S_64)	+= cpu_setup_ppc970.o cpu_setup_pa6t.o
 obj-$(CONFIG_PPC_BOOK3S_64)	+= cpu_setup_power.o
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 9029afd1fa2a..48aaca3e0b20 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1314,7 +1314,7 @@ EXC_REAL_NONE(0x1800, 0x100)
 EXC_VIRT_NONE(0x5800, 0x100)
 #endif
 
-#if defined(CONFIG_HARDLOCKUP_DETECTOR) && defined(CONFIG_HAVE_HARDLOCKUP_DETECTOR_ARCH)
+#ifdef CONFIG_PPC_WATCHDOG
 
 #define MASKED_DEC_HANDLER_LABEL 3f
 
@@ -1335,10 +1335,10 @@ EXC_COMMON_BEGIN(soft_nmi_common)
 			ADD_NVGPRS;ADD_RECONCILE)
 	b	ret_from_except
 
-#else
+#else /* CONFIG_PPC_WATCHDOG */
 #define MASKED_DEC_HANDLER_LABEL 2f /* normal return */
 #define MASKED_DEC_HANDLER(_H)
-#endif
+#endif /* CONFIG_PPC_WATCHDOG */
 
 /*
  * An interrupt came in while soft-disabled. We set paca->irq_happened, then:
-- 
2.11.0
