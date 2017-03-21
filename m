Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vnL6X1phMzDq95
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 15:53:08 +1100 (AEDT)
Received: by mail-pf0-x243.google.com with SMTP id o126so20295396pfb.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Mar 2017 21:53:08 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>
Subject: [PATCH 1/2] powerpc/powernv: process interrupts from system reset
 wakeup
Date: Tue, 21 Mar 2017 14:52:53 +1000
Message-Id: <20170321045254.21384-2-npiggin@gmail.com>
In-Reply-To: <20170321045254.21384-1-npiggin@gmail.com>
References: <20170321045254.21384-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When the CPU wakes from low power state, it begins at the system reset
interrupt with the exception that caused the wakeup encoded in SRR1.

Today, powernv idle wakeup ignores the wakeup reason (except a special
case for HMI), and the regular interrupt corresponding to the exception
will fire after the idle wakeup exits.

Change this to replay the interrupt from the idle wakeup before
interrupts are hard-enabled.

Test on POWER8 of context_switch selftests benchmark with polling idle
disabled (e.g., always nap) gives the following results:

                                original         wakeup direct
Different threads, same core:   315k/s           264k/s
Different cores:                235k/s           242k/s

There is a slowdown for doorbell IPI (same core) case because system
reset wakeup does not clear the message and the doorbell interrupt fires
again needlessly.
---
 arch/powerpc/include/asm/machdep.h    |  1 -
 arch/powerpc/include/asm/processor.h  |  1 +
 arch/powerpc/platforms/powernv/idle.c | 11 ++++++++---
 drivers/cpuidle/cpuidle-powernv.c     | 35 +++++++++++++++++++++++++++++++++--
 4 files changed, 42 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index 5011b69107a7..c0d9fd2e8c04 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -223,7 +223,6 @@ struct machdep_calls {
 
 extern void e500_idle(void);
 extern void power4_idle(void);
-extern void power7_idle(void);
 extern void ppc6xx_idle(void);
 extern void book3e_idle(void);
 
diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index e0fecbcea2a2..8190943d2619 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -454,6 +454,7 @@ extern int powersave_nap;	/* set if nap mode can be used in idle loop */
 extern unsigned long power7_nap(int check_irq);
 extern unsigned long power7_sleep(void);
 extern unsigned long power7_winkle(void);
+extern unsigned long power7_idle(void);
 extern unsigned long power9_idle_stop(unsigned long stop_psscr_val,
 				      unsigned long stop_psscr_mask);
 
diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
index 54546b632026..6b28a4f9c1fd 100644
--- a/arch/powerpc/platforms/powernv/idle.c
+++ b/arch/powerpc/platforms/powernv/idle.c
@@ -234,11 +234,16 @@ u64 pnv_default_stop_mask;
 /*
  * Used for ppc_md.power_save which needs a function with no parameters
  */
-static void power9_idle(void)
+static void power9_power_save(void)
 {
 	power9_idle_stop(pnv_default_stop_val, pnv_default_stop_mask);
 }
 
+static void power7_power_save(void)
+{
+	power7_idle();
+}
+
 /*
  * First deep stop state. Used to figure out when to save/restore
  * hypervisor context.
@@ -534,9 +539,9 @@ static int __init pnv_init_idle_states(void)
 	}
 
 	if (supported_cpuidle_states & OPAL_PM_NAP_ENABLED)
-		ppc_md.power_save = power7_idle;
+		ppc_md.power_save = power7_power_save;
 	else if (supported_cpuidle_states & OPAL_PM_STOP_INST_FAST)
-		ppc_md.power_save = power9_idle;
+		ppc_md.power_save = power9_power_save;
 
 out:
 	return 0;
diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
index 370593006f5f..e7e080c0790c 100644
--- a/drivers/cpuidle/cpuidle-powernv.c
+++ b/drivers/cpuidle/cpuidle-powernv.c
@@ -70,13 +70,37 @@ static int snooze_loop(struct cpuidle_device *dev,
 	return index;
 }
 
+/*
+ * Table to convert shifted SRR1 wakeup reason for POWER7, POWER8, POWER9
+ * to __replay_interrupt vector.
+ */
+static const unsigned short srr1_wakeup_to_replay_table[0x10] =
+{ 0, 0, 0, 0xe80,	/* 0x3 = hv doorbell */
+  0, 0xa00,		/* 0x5 = doorbell */
+  0x900,		/* 0x6 = decrementer */
+  0, 0x500,		/* 0x8 = external */
+  0xea0,		/* 0x9 = hv virt (POWER9) */
+  0xe60,		/* 0xa = hmi */
+  0, 0, 0, 0, 0, };
+
+/* Shift SRR1_WAKEMASK_P8 down and convert to __replay_interrupt vector */
+#define SRR1_TO_REPLAY(srr1) \
+	((unsigned int)srr1_wakeup_to_replay_table[((srr1) >> 18) & 0xf])
+
 static int nap_loop(struct cpuidle_device *dev,
 			struct cpuidle_driver *drv,
 			int index)
 {
+	u64 srr1;
+	unsigned int reason;
+
 	ppc64_runlatch_off();
-	power7_idle();
+	srr1 = power7_idle();
 	ppc64_runlatch_on();
+
+	reason = SRR1_TO_REPLAY(srr1);
+	__replay_interrupt(reason);
+
 	return index;
 }
 
@@ -111,10 +135,17 @@ static int stop_loop(struct cpuidle_device *dev,
 		     struct cpuidle_driver *drv,
 		     int index)
 {
+	u64 srr1;
+	unsigned int reason;
+
 	ppc64_runlatch_off();
-	power9_idle_stop(stop_psscr_table[index].val,
+	srr1 = power9_idle_stop(stop_psscr_table[index].val,
 			 stop_psscr_table[index].mask);
 	ppc64_runlatch_on();
+
+	reason = SRR1_TO_REPLAY(srr1);
+	__replay_interrupt(reason);
+
 	return index;
 }
 
-- 
2.11.0
