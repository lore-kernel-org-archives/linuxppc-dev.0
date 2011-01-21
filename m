Return-Path: <jlarrew@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5B2AAB6F10
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 21 Jan 2011 16:02:05 +1100 (EST)
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e35.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p0L4mNIZ004806
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jan 2011 21:48:23 -0700
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP
	id p0L51xS8156258
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jan 2011 22:01:59 -0700
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p0L51wEp020240
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jan 2011 22:01:59 -0700
Date: Thu, 20 Jan 2011 22:01:57 -0700
From: Jesse Larrew <jlarrew@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Message-Id: <20110121050156.5062.81631.sendpatchset@oc7304238415.ibm.com>
In-Reply-To: <20110121050010.5062.3390.sendpatchset@oc7304238415.ibm.com>
References: <20110121050010.5062.3390.sendpatchset@oc7304238415.ibm.com>
Subject: [PATCH 4/4] powerpc/pseries: Reorder VPHN functions to reduce forward
	declarations
Cc: markn@au1.ibm.com, tbreeds@au1.ibm.com, lkessler@us.ibm.com,
	Jesse Larrew <jlarrew@linux.vnet.ibm.com>, mjwolf@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Jesse Larrew <jlarrew@linux.vnet.ibm.com>

Reorder VPHN functions to reduce the need for forward declarations.

Signed-off-by: Jesse Larrew <jlarrew@linux.vnet.ibm.com>
---
 arch/powerpc/mm/numa.c |  115 ++++++++++++++++++++++++------------------------
 1 files changed, 57 insertions(+), 58 deletions(-)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index f7971d2..2010a17 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -1270,7 +1270,6 @@ static u8 vphn_cpu_change_counts[NR_CPUS][VPHN_NR_CHANGE_CTRS];
 static cpumask_t cpu_associativity_changes_mask;
 static int vphn_enabled;
 static void set_topology_timer(void);
-int stop_topology_update(void);
 
 /*
  * Store the current values of the associativity change counters in the
@@ -1328,6 +1327,63 @@ static int update_cpu_associativity_changes_mask(void)
 	return nr_cpus;
 }
 
+static void topology_work_fn(struct work_struct *work)
+{
+	rebuild_sched_domains();
+}
+static DECLARE_WORK(topology_work, topology_work_fn);
+
+void topology_schedule_update(void)
+{
+	schedule_work(&topology_work);
+}
+
+static void topology_timer_fn(unsigned long ignored)
+{
+	if (!vphn_enabled)
+		return;
+	if (update_cpu_associativity_changes_mask() > 0)
+		topology_schedule_update();
+	set_topology_timer();
+}
+static struct timer_list topology_timer =
+	TIMER_INITIALIZER(topology_timer_fn, 0, 0);
+
+static void set_topology_timer(void)
+{
+	topology_timer.data = 0;
+	topology_timer.expires = jiffies + 60 * HZ;
+	add_timer(&topology_timer);
+}
+
+/*
+ * Start polling for VPHN associativity changes.
+ */
+int start_topology_update(void)
+{
+	int rc = 0;
+
+	if (firmware_has_feature(FW_FEATURE_VPHN)) {
+		vphn_enabled = 1;
+		setup_cpu_associativity_change_counters();
+		init_timer_deferrable(&topology_timer);
+		set_topology_timer();
+		rc = 1;
+	}
+
+	return rc;
+}
+__initcall(start_topology_update);
+
+/*
+ * Disable polling for VPHN associativity changes.
+ */
+int stop_topology_update(void)
+{
+	vphn_enabled = 0;
+	return del_timer_sync(&topology_timer);
+}
+
 /* 6 64-bit registers unpacked into 12 32-bit associativity values */
 #define VPHN_ASSOC_BUFSIZE (6*sizeof(u64)/sizeof(u32))
 
@@ -1446,61 +1502,4 @@ int arch_update_cpu_topology(void)
 
 	return 1;
 }
-
-static void topology_work_fn(struct work_struct *work)
-{
-	rebuild_sched_domains();
-}
-static DECLARE_WORK(topology_work, topology_work_fn);
-
-void topology_schedule_update(void)
-{
-	schedule_work(&topology_work);
-}
-
-static void topology_timer_fn(unsigned long ignored)
-{
-	if (!vphn_enabled)
-		return;
-	if (update_cpu_associativity_changes_mask() > 0)
-		topology_schedule_update();
-	set_topology_timer();
-}
-static struct timer_list topology_timer =
-	TIMER_INITIALIZER(topology_timer_fn, 0, 0);
-
-static void set_topology_timer(void)
-{
-	topology_timer.data = 0;
-	topology_timer.expires = jiffies + 60 * HZ;
-	add_timer(&topology_timer);
-}
-
-/*
- * Start polling for VPHN associativity changes.
- */
-int start_topology_update(void)
-{
-	int rc = 0;
-
-	if (firmware_has_feature(FW_FEATURE_VPHN)) {
-		vphn_enabled = 1;
-		setup_cpu_associativity_change_counters();
-		init_timer_deferrable(&topology_timer);
-		set_topology_timer();
-		rc = 1;
-	}
-
-	return rc;
-}
-__initcall(start_topology_update);
-
-/*
- * Disable polling for VPHN associativity changes.
- */
-int stop_topology_update(void)
-{
-	vphn_enabled = 0;
-	return del_timer_sync(&topology_timer);
-}
 #endif /* CONFIG_PPC_SPLPAR */
-- 
1.7.3.4
