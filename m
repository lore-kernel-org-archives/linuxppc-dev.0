Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <03a90e8c72a4d5cf324549bb6cd77d38d436acb5.1210220828.git.michael@ellerman.id.au>
In-Reply-To: <5d2ed2a7e92250bdc6d9959dbeaeb3784a7109b4.1210220828.git.michael@ellerman.id.au>
References: <5d2ed2a7e92250bdc6d9959dbeaeb3784a7109b4.1210220828.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 07/12] Move xmon_irq() declaration into xmon.h
Date: Thu,  8 May 2008 14:27:15 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The typdef for irqreturn_t was moved into its own header a
while back, so there's no reason we can't move xmon_irq()
into xmon.h now.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/chrp/setup.c   |    7 -------
 arch/powerpc/platforms/powermac/pic.c |    8 +-------
 include/asm-powerpc/xmon.h            |    3 +++
 3 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/platforms/chrp/setup.c b/arch/powerpc/platforms/chrp/setup.c
index 116babb..1ba7ce5 100644
--- a/arch/powerpc/platforms/chrp/setup.c
+++ b/arch/powerpc/platforms/chrp/setup.c
@@ -63,13 +63,6 @@ static struct mpic *chrp_mpic;
 DEFINE_PER_CPU(struct timer_list, heartbeat_timer);
 unsigned long event_scan_interval;
 
-/*
- * XXX this should be in xmon.h, but putting it there means xmon.h
- * has to include <linux/interrupt.h> (to get irqreturn_t), which
- * causes all sorts of problems.  -- paulus
- */
-extern irqreturn_t xmon_irq(int, void *);
-
 extern unsigned long loops_per_jiffy;
 
 /* To be replaced by RTAS when available */
diff --git a/arch/powerpc/platforms/powermac/pic.c b/arch/powerpc/platforms/powermac/pic.c
index 829b8b0..6d149ae 100644
--- a/arch/powerpc/platforms/powermac/pic.c
+++ b/arch/powerpc/platforms/powermac/pic.c
@@ -34,16 +34,10 @@
 #include <asm/time.h>
 #include <asm/pmac_feature.h>
 #include <asm/mpic.h>
+#include <asm/xmon.h>
 
 #include "pmac.h"
 
-/*
- * XXX this should be in xmon.h, but putting it there means xmon.h
- * has to include <linux/interrupt.h> (to get irqreturn_t), which
- * causes all sorts of problems.  -- paulus
- */
-extern irqreturn_t xmon_irq(int, void *);
-
 #ifdef CONFIG_PPC32
 struct pmac_irq_hw {
         unsigned int    event;
diff --git a/include/asm-powerpc/xmon.h b/include/asm-powerpc/xmon.h
index 81477f2..d83da3c 100644
--- a/include/asm-powerpc/xmon.h
+++ b/include/asm-powerpc/xmon.h
@@ -12,11 +12,14 @@
 
 #ifdef __KERNEL__
 
+#include <linux/irqreturn.h>
+
 #ifdef CONFIG_XMON
 extern void xmon_setup(void);
 extern void xmon_register_spus(struct list_head *list);
 struct pt_regs;
 extern int xmon(struct pt_regs *excp);
+extern irqreturn_t xmon_irq(int, void *);
 #else
 static inline void xmon_setup(void) { };
 static inline void xmon_register_spus(struct list_head *list) { };
-- 
1.5.5
