Return-Path: <Paul.Gortmaker@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sDFq31JChzDr45
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Aug 2016 00:58:22 +1000 (AEST)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: <linux-kernel@vger.kernel.org>
CC: Paul Gortmaker <paul.gortmaker@windriver.com>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael
 Ellerman <mpe@ellerman.id.au>, <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc: migrate exception table users off module.h and onto
 extable.h
Date: Tue, 16 Aug 2016 10:57:34 -0400
Message-ID: <20160816145734.18706-1-paul.gortmaker@windriver.com>
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

These files were only including module.h for exception table
related functions.  We've now separated that content out into its
own file "extable.h" so now move over to that and avoid all the
extra header content in module.h that we don't really need to compile
these files.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---

[see: https://lkml.org/lkml/2016/7/24/224 for additional context if needed]


diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
index 3ed8ec09b5c9..e785cc9e1ecd 100644
--- a/arch/powerpc/kernel/kprobes.c
+++ b/arch/powerpc/kernel/kprobes.c
@@ -29,7 +29,7 @@
 #include <linux/kprobes.h>
 #include <linux/ptrace.h>
 #include <linux/preempt.h>
-#include <linux/module.h>
+#include <linux/extable.h>
 #include <linux/kdebug.h>
 #include <linux/slab.h>
 #include <asm/code-patching.h>
diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index a4db22f65021..bb1ffc559f38 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -26,7 +26,7 @@
 #include <linux/mm.h>
 #include <linux/interrupt.h>
 #include <linux/highmem.h>
-#include <linux/module.h>
+#include <linux/extable.h>
 #include <linux/kprobes.h>
 #include <linux/kdebug.h>
 #include <linux/perf_event.h>
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 2cb589264cb7..62859ebe0062 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -25,7 +25,8 @@
 #include <linux/user.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
-#include <linux/module.h>
+#include <linux/extable.h>
+#include <linux/module.h>	/* print_modules */
 #include <linux/prctl.h>
 #include <linux/delay.h>
 #include <linux/kprobes.h>
diff --git a/arch/powerpc/platforms/embedded6xx/holly.c b/arch/powerpc/platforms/embedded6xx/holly.c
index dafba1057a47..dfd310031549 100644
--- a/arch/powerpc/platforms/embedded6xx/holly.c
+++ b/arch/powerpc/platforms/embedded6xx/holly.c
@@ -26,7 +26,7 @@
 #include <linux/tty.h>
 #include <linux/serial_core.h>
 #include <linux/of_platform.h>
-#include <linux/module.h>
+#include <linux/extable.h>
 
 #include <asm/time.h>
 #include <asm/machdep.h>
diff --git a/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c b/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
index 80804f9916ee..f97bab8e37a2 100644
--- a/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
+++ b/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
@@ -23,7 +23,7 @@
 #include <linux/pci.h>
 #include <linux/kdev_t.h>
 #include <linux/console.h>
-#include <linux/module.h>
+#include <linux/extable.h>
 #include <linux/delay.h>
 #include <linux/irq.h>
 #include <linux/seq_file.h>
diff --git a/arch/powerpc/sysdev/fsl_rio.c b/arch/powerpc/sysdev/fsl_rio.c
index ee5b9f107089..82e31a889761 100644
--- a/arch/powerpc/sysdev/fsl_rio.c
+++ b/arch/powerpc/sysdev/fsl_rio.c
@@ -23,7 +23,7 @@
  */
 
 #include <linux/init.h>
-#include <linux/module.h>
+#include <linux/extable.h>
 #include <linux/types.h>
 #include <linux/dma-mapping.h>
 #include <linux/interrupt.h>
-- 
2.8.4
