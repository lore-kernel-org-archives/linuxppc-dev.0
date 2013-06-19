Return-Path: <haokexin@gmail.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 18D842C038A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jun 2013 19:21:14 +1000 (EST)
From: Kevin Hao <haokexin@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 3/4] powerpc: s/kdump/exception/ for the exception trampoline
 functions
Date: Wed, 19 Jun 2013 17:20:03 +0800
Message-ID: <1371633604-4491-4-git-send-email-haokexin@gmail.com>
In-Reply-To: <1371633604-4491-1-git-send-email-haokexin@gmail.com>
References: <1371633604-4491-1-git-send-email-haokexin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These functions are not just kdump specific. Replace the 'kdump' with
the 'exception' to make them more general.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 arch/powerpc/include/asm/exception_trampoline.h | 20 ++++++++++----------
 arch/powerpc/kernel/exception_trampoline.c      | 14 +++++++-------
 arch/powerpc/kernel/prom.c                      |  2 +-
 arch/powerpc/kernel/setup_32.c                  |  2 +-
 arch/powerpc/kernel/setup_64.c                  |  2 +-
 5 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/include/asm/exception_trampoline.h b/arch/powerpc/include/asm/exception_trampoline.h
index 707ad6c..88281c9 100644
--- a/arch/powerpc/include/asm/exception_trampoline.h
+++ b/arch/powerpc/include/asm/exception_trampoline.h
@@ -1,10 +1,10 @@
 #ifndef _EXCEPTION_TRAMPOLINE_H
 #define _EXCEPTION_TRAMPOLINE_H
 
-/* How many bytes to reserve at zero for kdump. The reserve limit should
+/* How many bytes to reserve at zero for exception. The reserve limit should
  * be greater or equal to the trampoline's end address.
  * Reserve to the end of the FWNMI area, see head_64.S */
-#define KDUMP_RESERVE_LIMIT	0x10000 /* 64K */
+#define EXCEPTION_RESERVE_LIMIT	0x10000 /* 64K */
 
 /*
  * On PPC64 translation is disabled during trampoline setup, so we use
@@ -13,22 +13,22 @@
  * branches, so we can just add the PAGE_OFFSET and don't worry about it.
  */
 #ifdef __powerpc64__
-#define KDUMP_TRAMPOLINE_START	0x0100
-#define KDUMP_TRAMPOLINE_END	0x3000
+#define EXCEPTION_TRAMPOLINE_START	0x0100
+#define EXCEPTION_TRAMPOLINE_END	0x3000
 #else
-#define KDUMP_TRAMPOLINE_START	(0x0100 + PAGE_OFFSET)
-#define KDUMP_TRAMPOLINE_END	(0x3000 + PAGE_OFFSET)
+#define EXCEPTION_TRAMPOLINE_START	(0x0100 + PAGE_OFFSET)
+#define EXCEPTION_TRAMPOLINE_END	(0x3000 + PAGE_OFFSET)
 #endif /* __powerpc64__ */
 
 #ifndef __ASSEMBLY__
 
 #if defined(CONFIG_CRASH_DUMP) && !defined(CONFIG_NONSTATIC_KERNEL)
-extern void reserve_kdump_trampoline(void);
-extern void setup_kdump_trampoline(void);
+extern void reserve_exception_trampoline(void);
+extern void setup_exception_trampoline(void);
 #else
 /* !CRASH_DUMP || !NONSTATIC_KERNEL */
-static inline void reserve_kdump_trampoline(void) { ; }
-static inline void setup_kdump_trampoline(void) { ; }
+static inline void reserve_exception_trampoline(void) { ; }
+static inline void setup_exception_trampoline(void) { ; }
 #endif
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/powerpc/kernel/exception_trampoline.c b/arch/powerpc/kernel/exception_trampoline.c
index 71f4b72..b725116 100644
--- a/arch/powerpc/kernel/exception_trampoline.c
+++ b/arch/powerpc/kernel/exception_trampoline.c
@@ -15,7 +15,7 @@
 #include <linux/bootmem.h>
 #include <linux/memblock.h>
 #include <asm/code-patching.h>
-#include <asm/kdump.h>
+#include <asm/exception_trampoline.h>
 #include <asm/prom.h>
 #include <asm/firmware.h>
 #include <asm/uaccess.h>
@@ -29,9 +29,9 @@
 #endif
 
 #ifndef CONFIG_NONSTATIC_KERNEL
-void __init reserve_kdump_trampoline(void)
+void __init reserve_exception_trampoline(void)
 {
-	memblock_reserve(0, KDUMP_RESERVE_LIMIT);
+	memblock_reserve(0, EXCEPTION_RESERVE_LIMIT);
 }
 
 static void __init create_trampoline(unsigned long addr)
@@ -50,13 +50,13 @@ static void __init create_trampoline(unsigned long addr)
 	patch_branch(++p, addr + PHYSICAL_START, 0);
 }
 
-void __init setup_kdump_trampoline(void)
+void __init setup_exception_trampoline(void)
 {
 	unsigned long i;
 
-	DBG(" -> setup_kdump_trampoline()\n");
+	DBG(" -> setup_exception_trampoline()\n");
 
-	for (i = KDUMP_TRAMPOLINE_START; i < KDUMP_TRAMPOLINE_END; i += 8) {
+	for (i = EXCEPTION_TRAMPOLINE_START; i < EXCEPTION_TRAMPOLINE_END; i += 8) {
 		create_trampoline(i);
 	}
 
@@ -65,6 +65,6 @@ void __init setup_kdump_trampoline(void)
 	create_trampoline(__pa(machine_check_fwnmi) - PHYSICAL_START);
 #endif /* CONFIG_PPC_PSERIES */
 
-	DBG(" <- setup_kdump_trampoline()\n");
+	DBG(" <- setup_exception_trampoline()\n");
 }
 #endif /* CONFIG_NONSTATIC_KERNEL */
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 4a13ac5..57214ee 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -669,7 +669,7 @@ void __init early_init_devtree(void *params)
 	/* If relocatable, reserve first 32k for interrupt vectors etc. */
 	if (PHYSICAL_START > MEMORY_START)
 		memblock_reserve(MEMORY_START, 0x8000);
-	reserve_kdump_trampoline();
+	reserve_exception_trampoline();
 #ifdef CONFIG_FA_DUMP
 	/*
 	 * If we fail to reserve memory for firmware-assisted dump then
diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index 9f3aa43..e040bb2 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -133,7 +133,7 @@ notrace void __init machine_init(u64 dt_ptr)
 
 	probe_machine();
 
-	setup_kdump_trampoline();
+	setup_exception_trampoline();
 
 #ifdef CONFIG_6xx
 	if (cpu_has_feature(CPU_FTR_CAN_DOZE) ||
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 06b8562..b077847 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -222,7 +222,7 @@ void __init early_setup(unsigned long dt_ptr)
 	/* Probe the machine type */
 	probe_machine();
 
-	setup_kdump_trampoline();
+	setup_exception_trampoline();
 
 	DBG("Found, Initializing memory management...\n");
 
-- 
1.8.1.4
