Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id A1AD7DDDEE
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Dec 2008 07:08:56 +1100 (EST)
Date: Wed, 17 Dec 2008 23:08:55 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 1/7] powerpc: Prepare xmon_save_regs for use with kdump
Message-ID: <20081217200855.GA4624@oksana.dev.rtsoft.ru>
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

Today the arch/powerpc/xmon/setjmp.S file contains only the
xmon_save_regs function. We want to use it for kdump purposes, so let's
move the file into arch/powerpc/kernel/ and give the function a more
generic name (ppc_save_regs).

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---

This is "git-format-patch -M"-style patch.

 arch/powerpc/include/asm/reg.h                     |    4 ++++
 arch/powerpc/kernel/Makefile                       |    4 ++++
 .../{xmon/setjmp.S => kernel/ppc_save_regs.S}      |    2 +-
 arch/powerpc/xmon/Makefile                         |    2 +-
 arch/powerpc/xmon/xmon.c                           |    5 ++---
 5 files changed, 12 insertions(+), 5 deletions(-)
 rename arch/powerpc/{xmon/setjmp.S => kernel/ppc_save_regs.S} (98%)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index c6d1ab6..f484a34 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -783,6 +783,10 @@ extern void scom970_write(unsigned int address, unsigned long value);
 #define __get_SP()	({unsigned long sp; \
 			asm volatile("mr %0,1": "=r" (sp)); sp;})
 
+struct pt_regs;
+
+extern void ppc_save_regs(struct pt_regs *regs);
+
 #endif /* __ASSEMBLY__ */
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_REG_H */
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 92673b4..616c889 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -102,6 +102,10 @@ endif
 
 obj-$(CONFIG_PPC64)		+= $(obj64-y)
 
+ifneq ($(CONFIG_XMON),)
+obj-y				+= ppc_save_regs.o
+endif
+
 extra-$(CONFIG_PPC_FPU)		+= fpu.o
 extra-$(CONFIG_PPC64)		+= entry_64.o
 
diff --git a/arch/powerpc/xmon/setjmp.S b/arch/powerpc/kernel/ppc_save_regs.S
similarity index 98%
rename from arch/powerpc/xmon/setjmp.S
rename to arch/powerpc/kernel/ppc_save_regs.S
index 04c0b30..5113bd2 100644
--- a/arch/powerpc/xmon/setjmp.S
+++ b/arch/powerpc/kernel/ppc_save_regs.S
@@ -22,7 +22,7 @@
  * that will be different for 32-bit and 64-bit, because of the
  * different ABIs, though).
  */
-_GLOBAL(xmon_save_regs)
+_GLOBAL(ppc_save_regs)
 	PPC_STL	r0,0*SZL(r3)
 	PPC_STL	r2,2*SZL(r3)
 	PPC_STL	r3,3*SZL(r3)
diff --git a/arch/powerpc/xmon/Makefile b/arch/powerpc/xmon/Makefile
index 51d9758..9cb03b7 100644
--- a/arch/powerpc/xmon/Makefile
+++ b/arch/powerpc/xmon/Makefile
@@ -4,7 +4,7 @@ ifdef CONFIG_PPC64
 EXTRA_CFLAGS += -mno-minimal-toc
 endif
 
-obj-y			+= xmon.o setjmp.o start.o nonstdio.o
+obj-y			+= xmon.o start.o nonstdio.o
 
 ifdef CONFIG_XMON_DISASSEMBLY
 obj-y			+= ppc-dis.o ppc-opc.o
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 076368c..8dfad7d 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -41,6 +41,7 @@
 #include <asm/spu_priv1.h>
 #include <asm/firmware.h>
 #include <asm/setjmp.h>
+#include <asm/reg.h>
 
 #ifdef CONFIG_PPC64
 #include <asm/hvcall.h>
@@ -159,8 +160,6 @@ static int xmon_no_auto_backtrace;
 extern void xmon_enter(void);
 extern void xmon_leave(void);
 
-extern void xmon_save_regs(struct pt_regs *);
-
 #ifdef CONFIG_PPC64
 #define REG		"%.16lx"
 #define REGS_PER_LINE	4
@@ -532,7 +531,7 @@ int xmon(struct pt_regs *excp)
 	struct pt_regs regs;
 
 	if (excp == NULL) {
-		xmon_save_regs(&regs);
+		ppc_save_regs(&regs);
 		excp = &regs;
 	}
 
-- 
1.5.6.5
