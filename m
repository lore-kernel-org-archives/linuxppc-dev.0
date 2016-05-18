Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r8bsd3b32zDqBh
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 May 2016 11:17:41 +1000 (AEST)
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3r8bsc5HZRz9vL8
 for <linuxppc-dev@ozlabs.org>; Wed, 18 May 2016 11:17:40 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id y7so3414002pfb.0
 for <linuxppc-dev@ozlabs.org>; Tue, 17 May 2016 18:17:40 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@ozlabs.org
Cc: mpe@ellerman.id.au,
	Daniel Axtens <dja@axtens.net>
Subject: [PATCH 1/4] powerpc/sparse: make some things static
Date: Wed, 18 May 2016 11:16:49 +1000
Message-Id: <1463534212-4879-1-git-send-email-dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is just a smattering of things picked up by sparse that should
be made static.

Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 arch/powerpc/kernel/crash.c                     | 2 +-
 arch/powerpc/kernel/sysfs.c                     | 2 +-
 arch/powerpc/platforms/powernv/idle.c           | 2 +-
 arch/powerpc/platforms/pseries/pseries_energy.c | 8 ++++----
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/crash.c b/arch/powerpc/kernel/crash.c
index 2bb252c01f07..c47a1bf36403 100644
--- a/arch/powerpc/kernel/crash.c
+++ b/arch/powerpc/kernel/crash.c
@@ -65,7 +65,7 @@ static int handle_fault(struct pt_regs *regs)
 #ifdef CONFIG_SMP
 
 static atomic_t cpus_in_crash;
-void crash_ipi_callback(struct pt_regs *regs)
+static void crash_ipi_callback(struct pt_regs *regs)
 {
 	static cpumask_t cpus_state_saved = CPU_MASK_NONE;
 
diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
index 692873bff334..c4f1d1f7bae0 100644
--- a/arch/powerpc/kernel/sysfs.c
+++ b/arch/powerpc/kernel/sysfs.c
@@ -35,7 +35,7 @@ static DEFINE_PER_CPU(struct cpu, cpu_devices);
 #ifdef CONFIG_PPC64
 
 /* Time in microseconds we delay before sleeping in the idle loop */
-DEFINE_PER_CPU(long, smt_snooze_delay) = { 100 };
+static DEFINE_PER_CPU(long, smt_snooze_delay) = { 100 };
 
 static ssize_t store_smt_snooze_delay(struct device *dev,
 				      struct device_attribute *attr,
diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
index fcc8b6861b63..92a8020f3502 100644
--- a/arch/powerpc/platforms/powernv/idle.c
+++ b/arch/powerpc/platforms/powernv/idle.c
@@ -29,7 +29,7 @@
 
 static u32 supported_cpuidle_states;
 
-int pnv_save_sprs_for_winkle(void)
+static int pnv_save_sprs_for_winkle(void)
 {
 	int cpu;
 	int rc;
diff --git a/arch/powerpc/platforms/pseries/pseries_energy.c b/arch/powerpc/platforms/pseries/pseries_energy.c
index 92767791f93b..164a13d3998a 100644
--- a/arch/powerpc/platforms/pseries/pseries_energy.c
+++ b/arch/powerpc/platforms/pseries/pseries_energy.c
@@ -208,19 +208,19 @@ static ssize_t percpu_deactivate_hint_show(struct device *dev,
  *	Per-cpu value of the hint
  */
 
-struct device_attribute attr_cpu_activate_hint_list =
+static struct device_attribute attr_cpu_activate_hint_list =
 		__ATTR(pseries_activate_hint_list, 0444,
 		cpu_activate_hint_list_show, NULL);
 
-struct device_attribute attr_cpu_deactivate_hint_list =
+static struct device_attribute attr_cpu_deactivate_hint_list =
 		__ATTR(pseries_deactivate_hint_list, 0444,
 		cpu_deactivate_hint_list_show, NULL);
 
-struct device_attribute attr_percpu_activate_hint =
+static struct device_attribute attr_percpu_activate_hint =
 		__ATTR(pseries_activate_hint, 0444,
 		percpu_activate_hint_show, NULL);
 
-struct device_attribute attr_percpu_deactivate_hint =
+static struct device_attribute attr_percpu_deactivate_hint =
 		__ATTR(pseries_deactivate_hint, 0444,
 		percpu_deactivate_hint_show, NULL);
 
-- 
2.5.0
