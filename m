Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xC7F01HvnzDrTr
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 16:59:32 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id d193so5805482pgc.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jul 2017 23:59:32 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Subject: [PATCH v2 1/3] powerpc/powernv: handle the platform error reboot in
 ppc_md.restart
Date: Wed, 19 Jul 2017 16:59:10 +1000
Message-Id: <20170719065912.19183-2-npiggin@gmail.com>
In-Reply-To: <20170719065912.19183-1-npiggin@gmail.com>
References: <20170719065912.19183-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Unrecovered MCE and HMI errors are sent through a special restart OPAL
call to log the platform error. The downside is that they don't go
through normal Linux crash paths, so they don't give much information
to the Linux console.

Change this by providing a special crash function which does some of
the console flushing from the panic() path before calling firmware to
reboot.

The downside of this is a little more code to execute before reaching
the firmware reboot. However in practice, it's critical to get the
Linux console messages output in order to debug a problem. So this is
a desirable tradeoff.

Note on the implementation: It is difficult to plumb a custom reboot
handler into the panic path, because panic does a little bit too much
work. For example, it will try to delay with the timebase, but that
may be corrupted in some cases resulting in a hang without reaching
the platform reboot. Another problem is that panic can invoke the
crash dump code which is not what we want in the case of a hardware
platform error. Long-term the best solution will be to rework the
panic path so it can be suitable for this kind of panic, but for now
we just duplicate a bit of the code.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/opal.h           |  2 +-
 arch/powerpc/platforms/powernv/opal-hmi.c | 22 ++------
 arch/powerpc/platforms/powernv/opal.c     | 89 ++++++++++++++++++-------------
 arch/powerpc/platforms/powernv/powernv.h  |  2 +
 4 files changed, 57 insertions(+), 58 deletions(-)

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 588fb1c23af9..182dab435aad 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -50,7 +50,7 @@ int64_t opal_tpo_write(uint64_t token, uint32_t year_mon_day,
 		       uint32_t hour_min);
 int64_t opal_cec_power_down(uint64_t request);
 int64_t opal_cec_reboot(void);
-int64_t opal_cec_reboot2(uint32_t reboot_type, char *diag);
+int64_t opal_cec_reboot2(uint32_t reboot_type, const char *diag);
 int64_t opal_read_nvram(uint64_t buffer, uint64_t size, uint64_t offset);
 int64_t opal_write_nvram(uint64_t buffer, uint64_t size, uint64_t offset);
 int64_t opal_handle_interrupt(uint64_t isn, __be64 *outstanding_event_mask);
diff --git a/arch/powerpc/platforms/powernv/opal-hmi.c b/arch/powerpc/platforms/powernv/opal-hmi.c
index 88f3c61eec95..d78fed728cdf 100644
--- a/arch/powerpc/platforms/powernv/opal-hmi.c
+++ b/arch/powerpc/platforms/powernv/opal-hmi.c
@@ -30,6 +30,8 @@
 #include <asm/cputable.h>
 #include <asm/machdep.h>
 
+#include "powernv.h"
+
 static int opal_hmi_handler_nb_init;
 struct OpalHmiEvtNode {
 	struct list_head list;
@@ -267,8 +269,6 @@ static void hmi_event_handler(struct work_struct *work)
 	spin_unlock_irqrestore(&opal_hmi_evt_lock, flags);
 
 	if (unrecoverable) {
-		int ret;
-
 		/* Pull all HMI events from OPAL before we panic. */
 		while (opal_get_msg(__pa(&msg), sizeof(msg)) == OPAL_SUCCESS) {
 			u32 type;
@@ -284,23 +284,7 @@ static void hmi_event_handler(struct work_struct *work)
 			print_hmi_event_info(hmi_evt);
 		}
 
-		/*
-		 * Unrecoverable HMI exception. We need to inform BMC/OCC
-		 * about this error so that it can collect relevant data
-		 * for error analysis before rebooting.
-		 */
-		ret = opal_cec_reboot2(OPAL_REBOOT_PLATFORM_ERROR,
-			"Unrecoverable HMI exception");
-		if (ret == OPAL_UNSUPPORTED) {
-			pr_emerg("Reboot type %d not supported\n",
-						OPAL_REBOOT_PLATFORM_ERROR);
-		}
-
-		/*
-		 * Fall through and panic if opal_cec_reboot2() returns
-		 * OPAL_UNSUPPORTED.
-		 */
-		panic("Unrecoverable HMI exception");
+		pnv_platform_error_reboot(NULL, "Unrecoverable HMI exception");
 	}
 }
 
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 9b87abb178f0..96436d129684 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -25,6 +25,10 @@
 #include <linux/memblock.h>
 #include <linux/kthread.h>
 #include <linux/freezer.h>
+#include <linux/printk.h>
+#include <linux/kmsg_dump.h>
+#include <linux/console.h>
+#include <linux/sched/debug.h>
 
 #include <asm/machdep.h>
 #include <asm/opal.h>
@@ -436,10 +440,55 @@ static int opal_recover_mce(struct pt_regs *regs,
 	return recovered;
 }
 
+void pnv_platform_error_reboot(struct pt_regs *regs, const char *msg)
+{
+	/*
+	 * This is mostly taken from kernel/panic.c, but tries to do
+	 * relatively minimal work. Don't use delay functions (TB may
+	 * be broken), don't crash dump (need to set a firmware log),
+	 * don't run notifiers. We do want to get some information to
+	 * Linux console.
+	 */
+	console_verbose();
+	bust_spinlocks(1);
+	pr_emerg("Hardware platform error: %s\n", msg);
+	if (regs)
+		show_regs(regs);
+	smp_send_stop();
+	printk_safe_flush_on_panic();
+	kmsg_dump(KMSG_DUMP_PANIC);
+	bust_spinlocks(0);
+	debug_locks_off();
+	console_flush_on_panic();
+
+	/*
+	 * Don't bother to shut things down because this will
+	 * xstop the system.
+	 */
+	if (opal_cec_reboot2(OPAL_REBOOT_PLATFORM_ERROR, msg)
+						== OPAL_UNSUPPORTED) {
+		pr_emerg("Reboot type %d not supported for %s\n",
+				OPAL_REBOOT_PLATFORM_ERROR, msg);
+	}
+
+	/*
+	 * We reached here. There can be three possibilities:
+	 * 1. We are running on a firmware level that do not support
+	 *    opal_cec_reboot2()
+	 * 2. We are running on a firmware level that do not support
+	 *    OPAL_REBOOT_PLATFORM_ERROR reboot type.
+	 * 3. We are running on FSP based system that does not need
+	 *    opal to trigger checkstop explicitly for error analysis.
+	 *    The FSP PRD component would have already got notified
+	 *    about this error through other channels.
+	 */
+
+	ppc_md.restart(NULL);
+}
+
 int opal_machine_check(struct pt_regs *regs)
 {
 	struct machine_check_event evt;
-	int ret;
 
 	if (!get_mce_event(&evt, MCE_EVENT_RELEASE))
 		return 0;
@@ -455,43 +504,7 @@ int opal_machine_check(struct pt_regs *regs)
 	if (opal_recover_mce(regs, &evt))
 		return 1;
 
-	/*
-	 * Unrecovered machine check, we are heading to panic path.
-	 *
-	 * We may have hit this MCE in very early stage of kernel
-	 * initialization even before opal-prd has started running. If
-	 * this is the case then this MCE error may go un-noticed or
-	 * un-analyzed if we go down panic path. We need to inform
-	 * BMC/OCC about this error so that they can collect relevant
-	 * data for error analysis before rebooting.
-	 * Use opal_cec_reboot2(OPAL_REBOOT_PLATFORM_ERROR) to do so.
-	 * This function may not return on BMC based system.
-	 */
-	ret = opal_cec_reboot2(OPAL_REBOOT_PLATFORM_ERROR,
-			"Unrecoverable Machine Check exception");
-	if (ret == OPAL_UNSUPPORTED) {
-		pr_emerg("Reboot type %d not supported\n",
-					OPAL_REBOOT_PLATFORM_ERROR);
-	}
-
-	/*
-	 * We reached here. There can be three possibilities:
-	 * 1. We are running on a firmware level that do not support
-	 *    opal_cec_reboot2()
-	 * 2. We are running on a firmware level that do not support
-	 *    OPAL_REBOOT_PLATFORM_ERROR reboot type.
-	 * 3. We are running on FSP based system that does not need opal
-	 *    to trigger checkstop explicitly for error analysis. The FSP
-	 *    PRD component would have already got notified about this
-	 *    error through other channels.
-	 *
-	 * If hardware marked this as an unrecoverable MCE, we are
-	 * going to panic anyway. Even if it didn't, it's not safe to
-	 * continue at this point, so we should explicitly panic.
-	 */
-
-	panic("PowerNV Unrecovered Machine Check");
-	return 0;
+	pnv_platform_error_reboot(regs, "Unrecoverable Machine Check exception");
 }
 
 /* Early hmi handler called in real mode. */
diff --git a/arch/powerpc/platforms/powernv/powernv.h b/arch/powerpc/platforms/powernv/powernv.h
index 6dbc0a1da1f6..a159d48573d7 100644
--- a/arch/powerpc/platforms/powernv/powernv.h
+++ b/arch/powerpc/platforms/powernv/powernv.h
@@ -7,6 +7,8 @@ extern void pnv_smp_init(void);
 static inline void pnv_smp_init(void) { }
 #endif
 
+extern void pnv_platform_error_reboot(struct pt_regs *regs, const char *msg) __noreturn;
+
 struct pci_dev;
 
 #ifdef CONFIG_PCI
-- 
2.11.0
