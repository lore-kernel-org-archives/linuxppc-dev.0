Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp02.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E54BD2C01E2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Aug 2013 21:59:05 +1000 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Wed, 14 Aug 2013 21:48:03 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 36EC73578052
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Aug 2013 21:59:01 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r7EBwokR8323456
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Aug 2013 21:58:50 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r7EBwxiq007771
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Aug 2013 21:59:01 +1000
Subject: [RFC V2 PATCH 4/6] cpuidle/ppc: Add longnap state to the idle
 states on powernv
To: fweisbec@gmail.com, paul.gortmaker@windriver.com, paulus@samba.org,
 shangw@linux.vnet.ibm.com, galak@kernel.crashing.org,
 deepthi@linux.vnet.ibm.com, benh@kernel.crashing.org,
 paulmck@linux.vnet.ibm.com, arnd@arndb.de, linux-pm@vger.kernel.org,
 rostedt@goodmis.org, rjw@sisk.pl, john.stultz@linaro.org,
 tglx@linutronix.de, chenhui.zhao@freescale.com, michael@ellerman.id.au,
 r58472@freescale.com, geoff@infradead.org,
 linux-kernel@vger.kernel.org, srivatsa.bhat@linux.vnet.ibm.com,
 schwidefsky@de.ibm.com, svaidy@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Date: Wed, 14 Aug 2013 17:26:23 +0530
Message-ID: <20130814115623.5193.36974.stgit@preeti.in.ibm.com>
In-Reply-To: <20130814115311.5193.32212.stgit@preeti.in.ibm.com>
References: <20130814115311.5193.32212.stgit@preeti.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch hooks into the existing broadcast framework along with the support
that this patchset introduces for ppc, and the cpuidle driver backend
for powernv(posted out by Deepthi Dharwar:https://lkml.org/lkml/2013/7/23/128)
to add sleep state as one of the deep idle states, in which the decrementer
is switched off.

However in this patch, we only emulate sleep by going into a state which does
a nap with the decrementer interrupts disabled, termed as longnap. This enables
focus on the timer broadcast framework for ppc in this series of patches ,
which is required as a first step to enable sleep on ppc.

Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
---

 arch/powerpc/platforms/powernv/processor_idle.c |   48 +++++++++++++++++++++++
 1 file changed, 47 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/processor_idle.c b/arch/powerpc/platforms/powernv/processor_idle.c
index f43ad91a..9aca502 100644
--- a/arch/powerpc/platforms/powernv/processor_idle.c
+++ b/arch/powerpc/platforms/powernv/processor_idle.c
@@ -9,16 +9,18 @@
 #include <linux/cpuidle.h>
 #include <linux/cpu.h>
 #include <linux/notifier.h>
+#include <linux/clockchips.h>
 
 #include <asm/machdep.h>
 #include <asm/runlatch.h>
+#include <asm/time.h>
 
 struct cpuidle_driver powernv_idle_driver = {
 	.name =		"powernv_idle",
 	.owner =	THIS_MODULE,
 };
 
-#define MAX_IDLE_STATE_COUNT	2
+#define MAX_IDLE_STATE_COUNT	3
 
 static int max_idle_state = MAX_IDLE_STATE_COUNT - 1;
 static struct cpuidle_device __percpu *powernv_cpuidle_devices;
@@ -54,6 +56,43 @@ static int nap_loop(struct cpuidle_device *dev,
 	return index;
 }
 
+/* Emulate sleep, with long nap.
+ * During sleep, the core does not receive decrementer interrupts.
+ * Emulate sleep using long nap with decrementers interrupts disabled.
+ * This is an initial prototype to test the timer offload framework for ppc.
+ * We will eventually introduce the sleep state once the timer offload framework
+ * for ppc is stable.
+ */
+static int longnap_loop(struct cpuidle_device *dev,
+				struct cpuidle_driver *drv,
+				int index)
+{
+	int cpu = dev->cpu;
+
+	unsigned long lpcr = mfspr(SPRN_LPCR);
+
+	lpcr &= ~(LPCR_MER | LPCR_PECE); /* lpcr[mer] must be 0 */
+
+	/* exit powersave upon external interrupt, but not decrementer
+	 * interrupt, Emulate sleep.
+	 */
+	lpcr |= LPCR_PECE0;
+
+	if (cpu != bc_cpu) {
+		mtspr(SPRN_LPCR, lpcr);
+		clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &cpu);
+		power7_nap();
+		clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &cpu);
+	} else {
+		/* Wakeup on a decrementer interrupt, Do a nap */
+		lpcr |= LPCR_PECE1;
+		mtspr(SPRN_LPCR, lpcr);
+		power7_nap();
+	}
+
+	return index;
+}
+
 /*
  * States for dedicated partition case.
  */
@@ -72,6 +111,13 @@ static struct cpuidle_state powernv_states[MAX_IDLE_STATE_COUNT] = {
 		.exit_latency = 10,
 		.target_residency = 100,
 		.enter = &nap_loop },
+	 { /* LongNap */
+		.name = "LongNap",
+		.desc = "LongNap",
+		.flags = CPUIDLE_FLAG_TIME_VALID,
+		.exit_latency = 10,
+		.target_residency = 100,
+		.enter = &longnap_loop },
 };
 
 static int powernv_cpuidle_add_cpu_notifier(struct notifier_block *n,
