Return-Path: <dbaryshkov@gmail.com>
Received: from mail-fx0-f42.google.com (mail-fx0-f42.google.com
	[209.85.161.42]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DA748B6F59
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 30 Jun 2011 00:54:06 +1000 (EST)
Received: by fxe23 with SMTP id 23so1303711fxe.15
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 29 Jun 2011 07:54:01 -0700 (PDT)
From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: correct annotations of pmu registration functions
Date: Wed, 29 Jun 2011 18:54:00 +0400
Message-Id: <1309359240-16290-1-git-send-email-dbaryshkov@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This fixes the following warning:
WARNING: arch/powerpc/kernel/built-in.o(.text+0x29768): Section mismatch in reference from the function .register_power_pmu() to the function .cpuinit.text:.power_pmu_notifier()
The function .register_power_pmu() references
the function __cpuinit .power_pmu_notifier().
This is often because .register_power_pmu lacks a __cpuinit
annotation or the annotation of .power_pmu_notifier is wrong.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/powerpc/kernel/mpc7450-pmu.c |    2 +-
 arch/powerpc/kernel/perf_event.c  |    2 +-
 arch/powerpc/kernel/power4-pmu.c  |    2 +-
 arch/powerpc/kernel/power5+-pmu.c |    2 +-
 arch/powerpc/kernel/power5-pmu.c  |    2 +-
 arch/powerpc/kernel/power6-pmu.c  |    2 +-
 arch/powerpc/kernel/power7-pmu.c  |    2 +-
 arch/powerpc/kernel/ppc970-pmu.c  |    2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kernel/mpc7450-pmu.c b/arch/powerpc/kernel/mpc7450-pmu.c
index 2cc5e03..a6de23d 100644
--- a/arch/powerpc/kernel/mpc7450-pmu.c
+++ b/arch/powerpc/kernel/mpc7450-pmu.c
@@ -405,7 +405,7 @@ struct power_pmu mpc7450_pmu = {
 	.cache_events		= &mpc7450_cache_events,
 };
 
-static int init_mpc7450_pmu(void)
+static int __init init_mpc7450_pmu(void)
 {
 	if (!cur_cpu_spec->oprofile_cpu_type ||
 	    strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc/7450"))
diff --git a/arch/powerpc/kernel/perf_event.c b/arch/powerpc/kernel/perf_event.c
index 822f630..31ab78f 100644
--- a/arch/powerpc/kernel/perf_event.c
+++ b/arch/powerpc/kernel/perf_event.c
@@ -1408,7 +1408,7 @@ power_pmu_notifier(struct notifier_block *self, unsigned long action, void *hcpu
 	return NOTIFY_OK;
 }
 
-int register_power_pmu(struct power_pmu *pmu)
+int __cpuinit register_power_pmu(struct power_pmu *pmu)
 {
 	if (ppmu)
 		return -EBUSY;		/* something's already registered */
diff --git a/arch/powerpc/kernel/power4-pmu.c b/arch/powerpc/kernel/power4-pmu.c
index ead8b3c..4eb7095 100644
--- a/arch/powerpc/kernel/power4-pmu.c
+++ b/arch/powerpc/kernel/power4-pmu.c
@@ -604,7 +604,7 @@ static struct power_pmu power4_pmu = {
 	.cache_events		= &power4_cache_events,
 };
 
-static int init_power4_pmu(void)
+static int __init init_power4_pmu(void)
 {
 	if (!cur_cpu_spec->oprofile_cpu_type ||
 	    strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc64/power4"))
diff --git a/arch/powerpc/kernel/power5+-pmu.c b/arch/powerpc/kernel/power5+-pmu.c
index eca0ac5..23aaadb 100644
--- a/arch/powerpc/kernel/power5+-pmu.c
+++ b/arch/powerpc/kernel/power5+-pmu.c
@@ -672,7 +672,7 @@ static struct power_pmu power5p_pmu = {
 	.cache_events		= &power5p_cache_events,
 };
 
-static int init_power5p_pmu(void)
+static int __init init_power5p_pmu(void)
 {
 	if (!cur_cpu_spec->oprofile_cpu_type ||
 	    (strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc64/power5+")
diff --git a/arch/powerpc/kernel/power5-pmu.c b/arch/powerpc/kernel/power5-pmu.c
index d5ff0f6..589e49a 100644
--- a/arch/powerpc/kernel/power5-pmu.c
+++ b/arch/powerpc/kernel/power5-pmu.c
@@ -612,7 +612,7 @@ static struct power_pmu power5_pmu = {
 	.cache_events		= &power5_cache_events,
 };
 
-static int init_power5_pmu(void)
+static int __init init_power5_pmu(void)
 {
 	if (!cur_cpu_spec->oprofile_cpu_type ||
 	    strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc64/power5"))
diff --git a/arch/powerpc/kernel/power6-pmu.c b/arch/powerpc/kernel/power6-pmu.c
index 3160392..e13dcda 100644
--- a/arch/powerpc/kernel/power6-pmu.c
+++ b/arch/powerpc/kernel/power6-pmu.c
@@ -535,7 +535,7 @@ static struct power_pmu power6_pmu = {
 	.cache_events		= &power6_cache_events,
 };
 
-static int init_power6_pmu(void)
+static int __init init_power6_pmu(void)
 {
 	if (!cur_cpu_spec->oprofile_cpu_type ||
 	    strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc64/power6"))
diff --git a/arch/powerpc/kernel/power7-pmu.c b/arch/powerpc/kernel/power7-pmu.c
index 593740f..8123040 100644
--- a/arch/powerpc/kernel/power7-pmu.c
+++ b/arch/powerpc/kernel/power7-pmu.c
@@ -360,7 +360,7 @@ static struct power_pmu power7_pmu = {
 	.cache_events		= &power7_cache_events,
 };
 
-static int init_power7_pmu(void)
+static int __init init_power7_pmu(void)
 {
 	if (!cur_cpu_spec->oprofile_cpu_type ||
 	    strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc64/power7"))
diff --git a/arch/powerpc/kernel/ppc970-pmu.c b/arch/powerpc/kernel/ppc970-pmu.c
index 9a6e093..45d7879 100644
--- a/arch/powerpc/kernel/ppc970-pmu.c
+++ b/arch/powerpc/kernel/ppc970-pmu.c
@@ -484,7 +484,7 @@ static struct power_pmu ppc970_pmu = {
 	.cache_events		= &ppc970_cache_events,
 };
 
-static int init_ppc970_pmu(void)
+static int __init init_ppc970_pmu(void)
 {
 	if (!cur_cpu_spec->oprofile_cpu_type ||
 	    (strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc64/970")
-- 
1.7.5.4
