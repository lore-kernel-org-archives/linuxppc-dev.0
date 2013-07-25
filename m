Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp03.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C07442C022C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jul 2013 19:06:14 +1000 (EST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Thu, 25 Jul 2013 14:29:19 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id C4952E0054
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jul 2013 14:36:12 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r6P96Mpw4325606
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jul 2013 14:36:23 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r6P95KOD021248
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jul 2013 09:05:26 GMT
Subject: [RFC PATCH 4/5] cpuidle/ppc: CPU goes tickless if there are no
 arch-specific constraints
To: benh@kernel.crashing.org, paul.gortmaker@windriver.com, paulus@samba.org,
 shangw@linux.vnet.ibm.com, galak@kernel.crashing.org,
 fweisbec@gmail.com, paulmck@linux.vnet.ibm.com, michael@ellerman.id.au,
 arnd@arndb.de, linux-pm@vger.kernel.org, rostedt@goodmis.org,
 rjw@sisk.pl, john.stultz@linaro.org, tglx@linutronix.de,
 chenhui.zhao@freescale.com, deepthi@linux.vnet.ibm.com,
 geoff@infradead.org, linux-kernel@vger.kernel.org,
 srivatsa.bhat@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
 svaidy@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Date: Thu, 25 Jul 2013 14:33:02 +0530
Message-ID: <20130725090302.12500.42998.stgit@preeti.in.ibm.com>
In-Reply-To: <20130725090016.12500.28888.stgit@preeti.in.ibm.com>
References: <20130725090016.12500.28888.stgit@preeti.in.ibm.com>
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

In the current design of timer offload framework, the broadcast cpu should
*not* go into tickless idle so as to avoid missed wakeups on CPUs in deep idle states.

Since we prevent the CPUs entering deep idle states from programming the lapic of the
broadcast cpu for their respective next local events for reasons mentioned in
PATCH[3/5], the broadcast CPU checks if there are any CPUs to be woken up during
each of its timer interrupt programmed to its local events.

With tickless idle, the broadcast CPU might not get a timer interrupt till after
many ticks which can result in missed wakeups on CPUs in deep idle states. By
disabling tickless idle, worst case, the tick_sched hrtimer will trigger a
timer interrupt every period to check for broadcast.

However the current setup of tickless idle does not let us make the choice
of tickless on individual cpus. NOHZ_MODE_INACTIVE which disables tickless idle,
is a system wide setting. Hence resort to an arch specific call to check if a cpu
can go into tickless idle.

Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
---

 arch/powerpc/kernel/time.c |    5 +++++
 kernel/time/tick-sched.c   |    7 +++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 8ed0fb3..68a636f 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -862,6 +862,11 @@ static void decrementer_timer_broadcast(const struct cpumask *mask)
 	arch_send_tick_broadcast(mask);
 }
 
+int arch_can_stop_idle_tick(int cpu)
+{
+	return cpu != bc_cpu;
+}
+
 static void register_decrementer_clockevent(int cpu)
 {
 	struct clock_event_device *dec = &per_cpu(decrementers, cpu);
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 6960172..e9ffa84 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -700,8 +700,15 @@ static void tick_nohz_full_stop_tick(struct tick_sched *ts)
 #endif
 }
 
+int __weak arch_can_stop_idle_tick(int cpu)
+{
+	return 1;
+}
+
 static bool can_stop_idle_tick(int cpu, struct tick_sched *ts)
 {
+	if (!arch_can_stop_idle_tick(cpu))
+		return false;
 	/*
 	 * If this cpu is offline and it is the one which updates
 	 * jiffies, then give up the assignment and let it be taken by
