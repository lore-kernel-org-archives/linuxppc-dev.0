Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id AD8EBB7079
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  6 Aug 2009 14:03:05 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C67E1DDD0C
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Aug 2009 14:03:04 +1000 (EST)
Subject: [PATCH] powerpc/perfctr: Check oprofile_cpu_type for NULL before
	using it
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Thu, 06 Aug 2009 14:02:36 +1000
Message-Id: <1249531356.18245.73.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, Ingo Molnar <mingo@elte.hu>,
	David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If the current CPU doesn't support performance counters,
cur_cpu_spec->oprofile_cpu_type can be NULL. The current
perfctr modules don't test for that case and would thus
crash.

Bug reported by David Woodhouse

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/mpc7450-pmu.c |    3 ++-
 arch/powerpc/kernel/power4-pmu.c  |    3 ++-
 arch/powerpc/kernel/power5+-pmu.c |    5 +++--
 arch/powerpc/kernel/power5-pmu.c  |    3 ++-
 arch/powerpc/kernel/power6-pmu.c  |    3 ++-
 arch/powerpc/kernel/power7-pmu.c  |    3 ++-
 arch/powerpc/kernel/ppc970-pmu.c  |    5 +++--
 7 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kernel/mpc7450-pmu.c b/arch/powerpc/kernel/mpc7450-pmu.c
index c244133..cc466d0 100644
--- a/arch/powerpc/kernel/mpc7450-pmu.c
+++ b/arch/powerpc/kernel/mpc7450-pmu.c
@@ -407,7 +407,8 @@ struct power_pmu mpc7450_pmu = {
 
 static int init_mpc7450_pmu(void)
 {
-	if (strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc/7450"))
+	if (!cur_cpu_spec->oprofile_cpu_type ||
+	    strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc/7450"))
 		return -ENODEV;
 
 	return register_power_pmu(&mpc7450_pmu);
diff --git a/arch/powerpc/kernel/power4-pmu.c b/arch/powerpc/kernel/power4-pmu.c
index db90b0c..3c90a3d 100644
--- a/arch/powerpc/kernel/power4-pmu.c
+++ b/arch/powerpc/kernel/power4-pmu.c
@@ -606,7 +606,8 @@ static struct power_pmu power4_pmu = {
 
 static int init_power4_pmu(void)
 {
-	if (strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc64/power4"))
+	if (!cur_cpu_spec->oprofile_cpu_type ||
+	    strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc64/power4"))
 		return -ENODEV;
 
 	return register_power_pmu(&power4_pmu);
diff --git a/arch/powerpc/kernel/power5+-pmu.c b/arch/powerpc/kernel/power5+-pmu.c
index f4adca8..31918af 100644
--- a/arch/powerpc/kernel/power5+-pmu.c
+++ b/arch/powerpc/kernel/power5+-pmu.c
@@ -678,8 +678,9 @@ static struct power_pmu power5p_pmu = {
 
 static int init_power5p_pmu(void)
 {
-	if (strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc64/power5+")
-	    && strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc64/power5++"))
+	if (!cur_cpu_spec->oprofile_cpu_type ||
+	    (strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc64/power5+")
+	     && strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc64/power5++")))
 		return -ENODEV;
 
 	return register_power_pmu(&power5p_pmu);
diff --git a/arch/powerpc/kernel/power5-pmu.c b/arch/powerpc/kernel/power5-pmu.c
index 29b2c6c..867f6f6 100644
--- a/arch/powerpc/kernel/power5-pmu.c
+++ b/arch/powerpc/kernel/power5-pmu.c
@@ -618,7 +618,8 @@ static struct power_pmu power5_pmu = {
 
 static int init_power5_pmu(void)
 {
-	if (strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc64/power5"))
+	if (!cur_cpu_spec->oprofile_cpu_type ||
+	    strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc64/power5"))
 		return -ENODEV;
 
 	return register_power_pmu(&power5_pmu);
diff --git a/arch/powerpc/kernel/power6-pmu.c b/arch/powerpc/kernel/power6-pmu.c
index 09ae5bf..fa21890 100644
--- a/arch/powerpc/kernel/power6-pmu.c
+++ b/arch/powerpc/kernel/power6-pmu.c
@@ -537,7 +537,8 @@ static struct power_pmu power6_pmu = {
 
 static int init_power6_pmu(void)
 {
-	if (strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc64/power6"))
+	if (!cur_cpu_spec->oprofile_cpu_type ||
+	    strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc64/power6"))
 		return -ENODEV;
 
 	return register_power_pmu(&power6_pmu);
diff --git a/arch/powerpc/kernel/power7-pmu.c b/arch/powerpc/kernel/power7-pmu.c
index 5a9f5cb..388cf57 100644
--- a/arch/powerpc/kernel/power7-pmu.c
+++ b/arch/powerpc/kernel/power7-pmu.c
@@ -366,7 +366,8 @@ static struct power_pmu power7_pmu = {
 
 static int init_power7_pmu(void)
 {
-	if (strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc64/power7"))
+	if (!cur_cpu_spec->oprofile_cpu_type ||
+	    strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc64/power7"))
 		return -ENODEV;
 
 	return register_power_pmu(&power7_pmu);
diff --git a/arch/powerpc/kernel/ppc970-pmu.c b/arch/powerpc/kernel/ppc970-pmu.c
index 833097a..75dccb7 100644
--- a/arch/powerpc/kernel/ppc970-pmu.c
+++ b/arch/powerpc/kernel/ppc970-pmu.c
@@ -488,8 +488,9 @@ static struct power_pmu ppc970_pmu = {
 
 static int init_ppc970_pmu(void)
 {
-	if (strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc64/970")
-	    && strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc64/970MP"))
+	if (!cur_cpu_spec->oprofile_cpu_type ||
+	    (strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc64/970")
+	     && strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc64/970MP")))
 		return -ENODEV;
 
 	return register_power_pmu(&ppc970_pmu);
-- 
1.6.0.4
