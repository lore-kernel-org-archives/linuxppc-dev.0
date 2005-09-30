Return-Path: <sfr@canb.auug.org.au>
Date: Fri, 30 Sep 2005 23:56:53 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Message-Id: <20050930235653.28c52e00.sfr@canb.auug.org.au>
In-Reply-To: <20050930233602.138b6e27.sfr@canb.auug.org.au>
References: <20050930233602.138b6e27.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc64-dev <linuxppc64-dev@ozlabs.org>, ppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH 5/9] powerpc: Move lparmap.c to powerpc/platforms
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---

 arch/powerpc/platforms/iseries/lparmap.c |   31 ++++++++++++++++++++++++++++++
 arch/ppc64/kernel/Makefile               |    4 ++--
 arch/ppc64/kernel/lparmap.c              |   31 ------------------------------
 3 files changed, 33 insertions(+), 33 deletions(-)
 create mode 100644 arch/powerpc/platforms/iseries/lparmap.c
 delete mode 100644 arch/ppc64/kernel/lparmap.c

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

d96024c688b59d4d1e60dbb0e226964eb758aa01
diff --git a/arch/powerpc/platforms/iseries/lparmap.c b/arch/powerpc/platforms/iseries/lparmap.c
new file mode 100644
--- /dev/null
+++ b/arch/powerpc/platforms/iseries/lparmap.c
@@ -0,0 +1,31 @@
+/*
+ * Copyright (C) 2005  Stephen Rothwell  IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+#include <asm/mmu.h>
+#include <asm/page.h>
+#include <asm/iSeries/LparMap.h>
+
+const struct LparMap __attribute__((__section__(".text"))) xLparMap = {
+	.xNumberEsids = HvEsidsToMap,
+	.xNumberRanges = HvRangesToMap,
+	.xSegmentTableOffs = STAB0_PAGE,
+
+	.xEsids = {
+		{ .xKernelEsid = GET_ESID(KERNELBASE),
+		  .xKernelVsid = KERNEL_VSID(KERNELBASE), },
+		{ .xKernelEsid = GET_ESID(VMALLOCBASE),
+		  .xKernelVsid = KERNEL_VSID(VMALLOCBASE), },
+	},
+
+	.xRanges = {
+		{ .xPages = HvPagesToMap,
+		  .xOffset = 0,
+		  .xVPN = KERNEL_VSID(KERNELBASE) << (SID_SHIFT - PAGE_SHIFT),
+		},
+	},
+};
diff --git a/arch/ppc64/kernel/Makefile b/arch/ppc64/kernel/Makefile
--- a/arch/ppc64/kernel/Makefile
+++ b/arch/ppc64/kernel/Makefile
@@ -70,8 +70,8 @@ obj-$(CONFIG_KPROBES)		+= kprobes.o
 CFLAGS_ioctl32.o += -Ifs/
 
 ifeq ($(CONFIG_PPC_ISERIES),y)
-arch/ppc64/kernel/head.o: arch/ppc64/kernel/lparmap.s
-AFLAGS_head.o += -Iarch/ppc64/kernel
+arch/ppc64/kernel/head.o: arch/powerpc/platforms/iseries/lparmap.s
+AFLAGS_head.o += -Iarch/powerpc/platforms/iseries
 endif
 
 # These are here while we do the architecture merge
diff --git a/arch/ppc64/kernel/lparmap.c b/arch/ppc64/kernel/lparmap.c
deleted file mode 100644
--- a/arch/ppc64/kernel/lparmap.c
+++ /dev/null
@@ -1,31 +0,0 @@
-/*
- * Copyright (C) 2005  Stephen Rothwell  IBM Corp.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-#include <asm/mmu.h>
-#include <asm/page.h>
-#include <asm/iSeries/LparMap.h>
-
-const struct LparMap __attribute__((__section__(".text"))) xLparMap = {
-	.xNumberEsids = HvEsidsToMap,
-	.xNumberRanges = HvRangesToMap,
-	.xSegmentTableOffs = STAB0_PAGE,
-
-	.xEsids = {
-		{ .xKernelEsid = GET_ESID(KERNELBASE),
-		  .xKernelVsid = KERNEL_VSID(KERNELBASE), },
-		{ .xKernelEsid = GET_ESID(VMALLOCBASE),
-		  .xKernelVsid = KERNEL_VSID(VMALLOCBASE), },
-	},
-
-	.xRanges = {
-		{ .xPages = HvPagesToMap,
-		  .xOffset = 0,
-		  .xVPN = KERNEL_VSID(KERNELBASE) << (SID_SHIFT - PAGE_SHIFT),
-		},
-	},
-};
