Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x242.google.com (mail-pl0-x242.google.com
 [IPv6:2607:f8b0:400e:c01::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40DWxN3CtdzF22N
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Apr 2018 20:36:40 +1000 (AEST)
Received: by mail-pl0-x242.google.com with SMTP id v5-v6so561390plo.4
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 01 Apr 2018 03:36:40 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
Subject: [PATCH v2 3/3] powerpc/powernv: Always stop secondaries before
 reboot/shutdown
Date: Sun,  1 Apr 2018 20:36:15 +1000
Message-Id: <20180401103615.15454-4-npiggin@gmail.com>
In-Reply-To: <20180401103615.15454-1-npiggin@gmail.com>
References: <20180401103615.15454-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently powernv reboot and shutdown requests just leave secondaries
to do their own things. This is undesirable because they can trigger
any number of watchdogs while waiting for reboot, but also we don't
know what else they might be doing -- they might be causing trouble,
trampling memory, etc.

The opal scheduled flash update code already ran into watchdog problems
due to flashing taking a long time, and it was fixed with 2196c6f1ed
("powerpc/powernv: Return secondary CPUs to firmware before FW update"),
which returns secondaries to opal. It's been found that regular reboots
can take over 10 seconds, which can result in the hard lockup watchdog
firing,

  reboot: Restarting system
  [  360.038896709,5] OPAL: Reboot request...
  Watchdog CPU:0 Hard LOCKUP
  Watchdog CPU:44 detected Hard LOCKUP other CPUS:16
  Watchdog CPU:16 Hard LOCKUP
  watchdog: BUG: soft lockup - CPU#16 stuck for 3s! [swapper/16:0]

This patch removes the special case for flash update, and calls
smp_send_stop in all cases before calling reboot/shutdown.

smp_send_stop could return CPUs to OPAL, the main reason not to is
that the request could come from a NMI that interrupts OPAL code,
so re-entry to OPAL can cause a number of problems. Putting
secondaries into simple spin loops improves the chances of a
successful reboot.

Cc: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/opal.h             |  2 +-
 arch/powerpc/platforms/powernv/opal-flash.c | 28 +---------------------------
 arch/powerpc/platforms/powernv/setup.c      | 15 +++++----------
 3 files changed, 7 insertions(+), 38 deletions(-)

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index dde60089d0d4..7159e1a6a61a 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -325,7 +325,7 @@ struct rtc_time;
 extern unsigned long opal_get_boot_time(void);
 extern void opal_nvram_init(void);
 extern void opal_flash_update_init(void);
-extern void opal_flash_term_callback(void);
+extern void opal_flash_update_print_message(void);
 extern int opal_elog_init(void);
 extern void opal_platform_dump_init(void);
 extern void opal_sys_param_init(void);
diff --git a/arch/powerpc/platforms/powernv/opal-flash.c b/arch/powerpc/platforms/powernv/opal-flash.c
index 1cb0b895a236..b37015101bf6 100644
--- a/arch/powerpc/platforms/powernv/opal-flash.c
+++ b/arch/powerpc/platforms/powernv/opal-flash.c
@@ -303,26 +303,9 @@ static int opal_flash_update(int op)
 	return rc;
 }
 
-/* Return CPUs to OPAL before starting FW update */
-static void flash_return_cpu(void *info)
-{
-	int cpu = smp_processor_id();
-
-	if (!cpu_online(cpu))
-		return;
-
-	/* Disable IRQ */
-	hard_irq_disable();
-
-	/* Return the CPU to OPAL */
-	opal_return_cpu();
-}
-
 /* This gets called just before system reboots */
-void opal_flash_term_callback(void)
+void opal_flash_update_print_message(void)
 {
-	struct cpumask mask;
-
 	if (update_flash_data.status != FLASH_IMG_READY)
 		return;
 
@@ -333,15 +316,6 @@ void opal_flash_term_callback(void)
 
 	/* Small delay to help getting the above message out */
 	msleep(500);
-
-	/* Return secondary CPUs to firmware */
-	cpumask_copy(&mask, cpu_online_mask);
-	cpumask_clear_cpu(smp_processor_id(), &mask);
-	if (!cpumask_empty(&mask))
-		smp_call_function_many(&mask,
-				       flash_return_cpu, NULL, false);
-	/* Hard disable interrupts */
-	hard_irq_disable();
 }
 
 /*
diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index 5f963286232f..ef8c9ce53a61 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -201,17 +201,12 @@ static void pnv_prepare_going_down(void)
 	 */
 	opal_event_shutdown();
 
-	/* Soft disable interrupts */
-	local_irq_disable();
+	/* Print flash update message if one is scheduled. */
+	opal_flash_update_print_message();
 
-	/*
-	 * Return secondary CPUs to firwmare if a flash update
-	 * is pending otherwise we will get all sort of error
-	 * messages about CPU being stuck etc.. This will also
-	 * have the side effect of hard disabling interrupts so
-	 * past this point, the kernel is effectively dead.
-	 */
-	opal_flash_term_callback();
+	smp_send_stop();
+
+	hard_irq_disable();
 }
 
 static void  __noreturn pnv_restart(char *cmd)
-- 
2.16.3
