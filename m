Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id C7CB247573
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Dec 2008 07:09:27 +1100 (EST)
Date: Wed, 17 Dec 2008 23:09:26 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 6/7] powerpc/32: Wire up the trampoline code for kdump
Message-ID: <20081217200926.GF4624@oksana.dev.rtsoft.ru>
References: <20081217200610.GA31887@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <20081217200610.GA31887@oksana.dev.rtsoft.ru>
Cc: Milton Miller <miltonm@bga.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Dale Farnsworth <dale@farnsworth.org>

Wire up the trampoline code for ppc32 to relay exceptions from the
vectors at address 0 to vectors at address 32MB, and modify Kconfig
to enable Kdump support for all classic powerpcs.

Signed-off-by: Dale Farnsworth <dale@farnsworth.org>
Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/Kconfig             |    2 +-
 arch/powerpc/include/asm/kdump.h |   13 +++++++++++++
 arch/powerpc/kernel/setup_32.c   |    2 ++
 3 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index be4f99b..f7f5448 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -326,7 +326,7 @@ config KEXEC
 
 config CRASH_DUMP
 	bool "Build a kdump crash kernel"
-	depends on PPC_MULTIPLATFORM && PPC64 && RELOCATABLE
+	depends on (PPC64 && RELOCATABLE) || 6xx
 	help
 	  Build a kernel suitable for use as a kdump capture kernel.
 	  The same kernel binary can be used as production kernel and dump
diff --git a/arch/powerpc/include/asm/kdump.h b/arch/powerpc/include/asm/kdump.h
index b07ebb9..5ebfe5d 100644
--- a/arch/powerpc/include/asm/kdump.h
+++ b/arch/powerpc/include/asm/kdump.h
@@ -1,6 +1,8 @@
 #ifndef _PPC64_KDUMP_H
 #define _PPC64_KDUMP_H
 
+#include <asm/page.h>
+
 /* Kdump kernel runs at 32 MB, change at your peril. */
 #define KDUMP_KERNELBASE	0x2000000
 
@@ -11,8 +13,19 @@
 
 #ifdef CONFIG_CRASH_DUMP
 
+/*
+ * On PPC64 translation is disabled during trampoline setup, so we use
+ * physical addresses. Though on PPC32 translation is already enabled,
+ * so we can't do the same. Luckily create_trampoline() creates relative
+ * branches, so we can just add the PAGE_OFFSET and don't worry about it.
+ */
+#ifdef __powerpc64__
 #define KDUMP_TRAMPOLINE_START	0x0100
 #define KDUMP_TRAMPOLINE_END	0x3000
+#else
+#define KDUMP_TRAMPOLINE_START	(0x0100 + PAGE_OFFSET)
+#define KDUMP_TRAMPOLINE_END	(0x3000 + PAGE_OFFSET)
+#endif /* __powerpc64__ */
 
 #define KDUMP_MIN_TCE_ENTRIES	2048
 
diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index 086c23c..9ca1d2b 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -121,6 +121,8 @@ notrace void __init machine_init(unsigned long dt_ptr)
 
 	probe_machine();
 
+	setup_kdump_trampoline();
+
 #ifdef CONFIG_6xx
 	if (cpu_has_feature(CPU_FTR_CAN_DOZE) ||
 	    cpu_has_feature(CPU_FTR_CAN_NAP))
-- 
1.5.6.5
