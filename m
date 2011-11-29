Return-Path: <B29882@freescale.com>
Received: from VA3EHSOBE007.bigfish.com (va3ehsobe006.messaging.microsoft.com
 [216.32.180.16]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id A6CE3B6F89
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2011 15:24:39 +1100 (EST)
Received: from mail47-va3 (localhost [127.0.0.1])	by mail47-va3-R.bigfish.com
 (Postfix) with ESMTP id 3D74C4402C2	for
 <linuxppc-dev@lists.ozlabs.org>; Tue,
 29 Nov 2011 04:23:46 +0000 (UTC)
Received: from VA3EHSMHS007.bigfish.com (unknown [10.7.14.246])	by
 mail47-va3.bigfish.com (Postfix) with ESMTP id ED55AC029F	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2011 04:23:45 +0000 (UTC)
From: Matthew McClintock <msm@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH v2] powerpc/setup_{32, 64}.c: remove unneeded boot_cpuid{,
 _phys}
Date: Mon, 28 Nov 2011 22:24:29 -0600
Message-ID: <1322540669-6834-1-git-send-email-msm@freescale.com>
In-Reply-To: <1322192477.32635.15.camel@pasglop>
References: <1322192477.32635.15.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain
Cc: kumar.gala@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

boot_cpuid and init_thread_info.cpu are redundant, just use the
var that stays around longer and add a define to make boot_cpuid
point at the correct value

boot_cpudid_phys is not needed and can completly go away from the
SMP case, we leave it there for the non-SMP case since the paca
struct is not around to store this info

This patch also has the effect of having the logical cpu number
of the boot cpu be updated correctly independently of the ordering
of the cpu nodes in the device tree.

Signed-off-by: Matthew McClintock <msm@freescale.com>
---
v2: Fix compile issue for peries
    Remove '-1' initial value

 arch/powerpc/include/asm/smp.h         |    2 +-
 arch/powerpc/kernel/setup_32.c         |    5 +++--
 arch/powerpc/kernel/setup_64.c         |    1 -
 arch/powerpc/sysdev/xics/xics-common.c |    1 +
 4 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/smp.h b/arch/powerpc/include/asm/smp.h
index adba970..f26c554 100644
--- a/arch/powerpc/include/asm/smp.h
+++ b/arch/powerpc/include/asm/smp.h
@@ -29,7 +29,7 @@
 #endif
 #include <asm/percpu.h>
 
-extern int boot_cpuid;
+#define boot_cpuid 	(init_thread_info.cpu)
 extern int spinning_secondaries;
 
 extern void cpu_die(void);
diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index ac76108..8d4df4c 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -46,10 +46,11 @@
 
 extern void bootx_init(unsigned long r4, unsigned long phys);
 
-int boot_cpuid = -1;
-EXPORT_SYMBOL_GPL(boot_cpuid);
+/* we need a place to store phys cpu for non-SMP case */
+#ifndef CONFIG_SMP
 int boot_cpuid_phys;
 EXPORT_SYMBOL_GPL(boot_cpuid_phys);
+#endif
 
 int smp_hw_index[NR_CPUS];
 
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index fb9bb46..6d0f00f 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -73,7 +73,6 @@
 #define DBG(fmt...)
 #endif
 
-int boot_cpuid = 0;
 int __initdata spinning_secondaries;
 u64 ppc64_pft_size;
 
diff --git a/arch/powerpc/sysdev/xics/xics-common.c b/arch/powerpc/sysdev/xics/xics-common.c
index d72eda6..8998b7a 100644
--- a/arch/powerpc/sysdev/xics/xics-common.c
+++ b/arch/powerpc/sysdev/xics/xics-common.c
@@ -20,6 +20,7 @@
 #include <linux/of.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/sched.h>
 
 #include <asm/prom.h>
 #include <asm/io.h>
-- 
1.7.6.1
