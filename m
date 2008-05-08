Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <a2aa5ce3b65e8ba2bd7be0b7a2f47bb197aba97b.1210220828.git.michael@ellerman.id.au>
In-Reply-To: <5d2ed2a7e92250bdc6d9959dbeaeb3784a7109b4.1210220828.git.michael@ellerman.id.au>
References: <5d2ed2a7e92250bdc6d9959dbeaeb3784a7109b4.1210220828.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 09/12] Make cpus_in_xmon static and remove extern mess from
	hvc_console.c
Date: Thu,  8 May 2008 14:27:17 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a little messier than I'd like because xmon.h only exists
on powerpc and we can't have a static inline and an extern declaration
visible at the same time.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/xmon/xmon.c   |    7 ++++++-
 drivers/char/hvc_console.c |    8 +-------
 drivers/char/hvc_console.h |   10 ++++++++++
 include/asm-powerpc/xmon.h |    4 ++++
 4 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 2f57850..863ba0a 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -54,7 +54,7 @@
 #define skipbl	xmon_skipbl
 
 #ifdef CONFIG_SMP
-cpumask_t cpus_in_xmon = CPU_MASK_NONE;
+static cpumask_t cpus_in_xmon = CPU_MASK_NONE;
 static unsigned long xmon_taken = 1;
 static int xmon_owner;
 static int xmon_gate;
@@ -327,6 +327,11 @@ static void release_output_lock(void)
 {
 	xmon_speaker = 0;
 }
+
+int cpus_are_in_xmon(void)
+{
+	return !cpus_empty(cpus_in_xmon);
+}
 #endif
 
 static int xmon_core(struct pt_regs *regs, int fromipi)
diff --git a/drivers/char/hvc_console.c b/drivers/char/hvc_console.c
index 44160d5..2f9759d 100644
--- a/drivers/char/hvc_console.c
+++ b/drivers/char/hvc_console.c
@@ -675,12 +675,6 @@ static int hvc_poll(struct hvc_struct *hp)
 	return poll_mask;
 }
 
-#if defined(CONFIG_XMON) && defined(CONFIG_SMP)
-extern cpumask_t cpus_in_xmon;
-#else
-static const cpumask_t cpus_in_xmon = CPU_MASK_NONE;
-#endif
-
 /*
  * This kthread is either polling or interrupt driven.  This is determined by
  * calling hvc_poll() who determines whether a console adapter support
@@ -698,7 +692,7 @@ static int khvcd(void *unused)
 		hvc_kicked = 0;
 		try_to_freeze();
 		wmb();
-		if (cpus_empty(cpus_in_xmon)) {
+		if (!cpus_are_in_xmon()) {
 			spin_lock(&hvc_structs_lock);
 			list_for_each_entry(hp, &hvc_structs, next) {
 				poll_mask |= hvc_poll(hp);
diff --git a/drivers/char/hvc_console.h b/drivers/char/hvc_console.h
index 8c59818..42ffb17 100644
--- a/drivers/char/hvc_console.h
+++ b/drivers/char/hvc_console.h
@@ -60,4 +60,14 @@ extern struct hvc_struct * __devinit hvc_alloc(uint32_t vtermno, int irq,
 /* remove a vterm from hvc tty operation (modele_exit or hotplug remove) */
 extern int __devexit hvc_remove(struct hvc_struct *hp);
 
+
+#if defined(CONFIG_XMON) && defined(CONFIG_SMP)
+#include <asm/xmon.h>
+#else
+static inline int cpus_are_in_xmon(void)
+{
+	return 0;
+}
+#endif
+
 #endif // HVC_CONSOLE_H
diff --git a/include/asm-powerpc/xmon.h b/include/asm-powerpc/xmon.h
index d83da3c..5eb8e59 100644
--- a/include/asm-powerpc/xmon.h
+++ b/include/asm-powerpc/xmon.h
@@ -25,5 +25,9 @@ static inline void xmon_setup(void) { };
 static inline void xmon_register_spus(struct list_head *list) { };
 #endif
 
+#if defined(CONFIG_XMON) && defined(CONFIG_SMP)
+extern int cpus_are_in_xmon(void);
+#endif
+
 #endif /* __KERNEL __ */
 #endif /* __ASM_POWERPC_XMON_H */
-- 
1.5.5
