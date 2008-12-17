Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 0CB66DDDEE
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Dec 2008 07:09:04 +1100 (EST)
Date: Wed, 17 Dec 2008 23:09:01 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 2/7] powerpc/32/kdump: Implement crash_setup_regs() using
	ppc_save_regs()
Message-ID: <20081217200901.GB4624@oksana.dev.rtsoft.ru>
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

This patch replaces dummy function with full-fledged crash_setup_regs()
implementation. On PPC32 we simply use ppc_save_regs function to dump
the registers.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/include/asm/kexec.h |   15 ++++++---------
 arch/powerpc/kernel/Makefile     |    2 +-
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/kexec.h b/arch/powerpc/include/asm/kexec.h
index 3736d9b..6dbffc9 100644
--- a/arch/powerpc/include/asm/kexec.h
+++ b/arch/powerpc/include/asm/kexec.h
@@ -33,12 +33,12 @@
 
 #ifndef __ASSEMBLY__
 #include <linux/cpumask.h>
+#include <asm/reg.h>
 
 typedef void (*crash_shutdown_t)(void);
 
 #ifdef CONFIG_KEXEC
 
-#ifdef __powerpc64__
 /*
  * This function is responsible for capturing register states if coming
  * via panic or invoking dump using sysrq-trigger.
@@ -48,6 +48,7 @@ static inline void crash_setup_regs(struct pt_regs *newregs,
 {
 	if (oldregs)
 		memcpy(newregs, oldregs, sizeof(*newregs));
+#ifdef __powerpc64__
 	else {
 		/* FIXME Merge this with xmon_save_regs ?? */
 		unsigned long tmp1, tmp2;
@@ -100,15 +101,11 @@ static inline void crash_setup_regs(struct pt_regs *newregs,
 			: "b" (newregs)
 			: "memory");
 	}
-}
 #else
-/*
- * Provide a dummy definition to avoid build failures. Will remain
- * empty till crash dump support is enabled.
- */
-static inline void crash_setup_regs(struct pt_regs *newregs,
-					struct pt_regs *oldregs) { }
-#endif /* !__powerpc64 __ */
+	else
+		ppc_save_regs(newregs);
+#endif /* __powerpc64__ */
+}
 
 extern void kexec_smp_wait(void);	/* get and clear naca physid, wait for
 					  master to copy new code to 0 */
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 616c889..089209a 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -102,7 +102,7 @@ endif
 
 obj-$(CONFIG_PPC64)		+= $(obj64-y)
 
-ifneq ($(CONFIG_XMON),)
+ifneq ($(CONFIG_XMON)$(CONFIG_KEXEC),)
 obj-y				+= ppc_save_regs.o
 endif
 
-- 
1.5.6.5
