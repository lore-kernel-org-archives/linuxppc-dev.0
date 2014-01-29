Return-Path: <nicolas.pitre@linaro.org>
Received: from relais.videotron.ca (relais.videotron.ca [24.201.245.36])
 by ozlabs.org (Postfix) with ESMTP id 562482C009A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jan 2014 04:45:24 +1100 (EST)
Received: from yoda.home ([66.130.143.177]) by VL-VM-MR006.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0N0600IRABZJOTG0@VL-VM-MR006.ip.videotron.ca> for
 linuxppc-dev@lists.ozlabs.org; Wed, 29 Jan 2014 12:45:19 -0500 (EST)
From: Nicolas Pitre <nicolas.pitre@linaro.org>
To: Russell King <linux@arm.linux.org.uk>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Preeti U Murthy <preeti@linux.vnet.ibm.com>, Paul Mundt <lethal@linux-sh.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH v2 2/6] ARM: remove redundant cpuidle_idle_call()
Date: Wed, 29 Jan 2014 12:45:09 -0500
Message-id: <1391017513-12995-3-git-send-email-nicolas.pitre@linaro.org>
In-reply-to: <1391017513-12995-1-git-send-email-nicolas.pitre@linaro.org>
References: <1391017513-12995-1-git-send-email-nicolas.pitre@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The core idle loop now takes care of it.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/kernel/process.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 92f7b15dd2..adabeababe 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -30,7 +30,6 @@
 #include <linux/uaccess.h>
 #include <linux/random.h>
 #include <linux/hw_breakpoint.h>
-#include <linux/cpuidle.h>
 #include <linux/leds.h>
 #include <linux/reboot.h>
 
@@ -133,7 +132,11 @@ EXPORT_SYMBOL_GPL(arm_pm_restart);
 
 void (*arm_pm_idle)(void);
 
-static void default_idle(void)
+/*
+ * Called from the core idle loop.
+ */
+
+void arch_cpu_idle(void)
 {
 	if (arm_pm_idle)
 		arm_pm_idle();
@@ -168,15 +171,6 @@ void arch_cpu_idle_dead(void)
 #endif
 
 /*
- * Called from the core idle loop.
- */
-void arch_cpu_idle(void)
-{
-	if (cpuidle_idle_call())
-		default_idle();
-}
-
-/*
  * Called by kexec, immediately prior to machine_kexec().
  *
  * This must completely disable all secondary CPUs; simply causing those CPUs
-- 
1.8.4.108.g55ea5f6
