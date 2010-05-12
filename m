Return-Path: <albert_herranz@yahoo.es>
Received: from smtp142.mail.ukl.yahoo.com (smtp142.mail.ukl.yahoo.com
	[77.238.184.73]) by ozlabs.org (Postfix) with SMTP id 57103B7BEE
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 13 May 2010 04:04:57 +1000 (EST)
From: Albert Herranz <albert_herranz@yahoo.es>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: fix register_power_pmu() section mismatch warning
Date: Wed, 12 May 2010 20:04:46 +0200
Message-Id: <1273687486-13381-1-git-send-email-albert_herranz@yahoo.es>
Cc: Albert Herranz <albert_herranz@yahoo.es>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add missing __cpuinit annotations to fix a bunch of warnings like the one
shown below when building a kernel for the PowerPC architecture with
CONFIG_DEBUG_SECTION_MISMATCH=y.

WARNING: arch/powerpc/kernel/built-in.o(.text+0x11c72): Section mismatch in reference from the function register_power_pmu() to the variable .cpuinit.data:power_pmu_notifier_nb.23552
The function register_power_pmu() references
the variable __cpuinitdata power_pmu_notifier_nb.23552.
This is often because register_power_pmu lacks a __cpuinitdata
annotation or the annotation of power_pmu_notifier_nb.23552 is wrong.

Signed-off-by: Albert Herranz <albert_herranz@yahoo.es>
---
 arch/powerpc/kernel/mpc7450-pmu.c |    2 +-
 arch/powerpc/kernel/perf_event.c  |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/mpc7450-pmu.c b/arch/powerpc/kernel/mpc7450-pmu.c
index 09d7202..3982bfa 100644
--- a/arch/powerpc/kernel/mpc7450-pmu.c
+++ b/arch/powerpc/kernel/mpc7450-pmu.c
@@ -405,7 +405,7 @@ struct power_pmu mpc7450_pmu = {
 	.cache_events		= &mpc7450_cache_events,
 };
 
-static int init_mpc7450_pmu(void)
+static int __cpuinit init_mpc7450_pmu(void)
 {
 	if (!cur_cpu_spec->oprofile_cpu_type ||
 	    strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc/7450"))
diff --git a/arch/powerpc/kernel/perf_event.c b/arch/powerpc/kernel/perf_event.c
index 08460a2..6b70834 100644
--- a/arch/powerpc/kernel/perf_event.c
+++ b/arch/powerpc/kernel/perf_event.c
@@ -1314,7 +1314,7 @@ power_pmu_notifier(struct notifier_block *self, unsigned long action, void *hcpu
 	return NOTIFY_OK;
 }
 
-int register_power_pmu(struct power_pmu *pmu)
+int __cpuinit register_power_pmu(struct power_pmu *pmu)
 {
 	if (ppmu)
 		return -EBUSY;		/* something's already registered */
-- 
1.6.3.3
