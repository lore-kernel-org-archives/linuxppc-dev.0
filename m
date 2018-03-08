Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zxZqg3P9VzF1hM
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Mar 2018 13:54:55 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com
Subject: [PATCH 1/4] powerpc/pseries: Move smp_query_cpu_stopped() etc. out of
 plpar_wrappers.h
Date: Thu,  8 Mar 2018 13:54:39 +1100
Message-Id: <20180308025442.6165-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

smp_query_cpu_stopped() and related #defines are currently in
plpar_wrappers.h. The function actually does an RTAS call, not an
hcall, and basically has nothing to do with plpar_wrappers.h

Move it into pseries.h, where it can easily be used by the only two
callers in pseries/smp.c and pseries/hotplug-cpu.c.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/plpar_wrappers.h | 8 --------
 arch/powerpc/platforms/pseries/pseries.h  | 8 ++++++++
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/plpar_wrappers.h b/arch/powerpc/include/asm/plpar_wrappers.h
index 55eddf50d149..1776af9e0118 100644
--- a/arch/powerpc/include/asm/plpar_wrappers.h
+++ b/arch/powerpc/include/asm/plpar_wrappers.h
@@ -9,14 +9,6 @@
 #include <asm/paca.h>
 #include <asm/page.h>
 
-/* Get state of physical CPU from query_cpu_stopped */
-int smp_query_cpu_stopped(unsigned int pcpu);
-#define QCSS_STOPPED 0
-#define QCSS_STOPPING 1
-#define QCSS_NOT_STOPPED 2
-#define QCSS_HARDWARE_ERROR -1
-#define QCSS_HARDWARE_BUSY -2
-
 static inline long poll_pending(void)
 {
 	return plpar_hcall_norets(H_POLL_PENDING);
diff --git a/arch/powerpc/platforms/pseries/pseries.h b/arch/powerpc/platforms/pseries/pseries.h
index 1ae1d9f4dbe9..c73351cea276 100644
--- a/arch/powerpc/platforms/pseries/pseries.h
+++ b/arch/powerpc/platforms/pseries/pseries.h
@@ -27,6 +27,14 @@ extern int pSeries_machine_check_exception(struct pt_regs *regs);
 
 #ifdef CONFIG_SMP
 extern void smp_init_pseries(void);
+
+/* Get state of physical CPU from query_cpu_stopped */
+int smp_query_cpu_stopped(unsigned int pcpu);
+#define QCSS_STOPPED 0
+#define QCSS_STOPPING 1
+#define QCSS_NOT_STOPPED 2
+#define QCSS_HARDWARE_ERROR -1
+#define QCSS_HARDWARE_BUSY -2
 #else
 static inline void smp_init_pseries(void) { };
 #endif
-- 
2.14.1
