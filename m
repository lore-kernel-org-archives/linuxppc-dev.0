Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yxSFR0BxQzDrS0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Dec 2017 17:58:02 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vBD6tIJt063938
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Dec 2017 01:58:00 -0500
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2etrs9exx0-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Dec 2017 01:58:00 -0500
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Wed, 13 Dec 2017 01:57:59 -0500
From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, viresh.kumar@linaro.org,
 rjw@rjwysocki.net, huntbag@linux.vnet.ibm.com,
 akshay.adiga@linux.vnet.ibm.com, Michael Ellerman <mpe@ellerman.id.au>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: [v3 PATCH 2/3] powernv-cpufreq: Fix pstate_to_idx() to handle
 non-continguous pstates
Date: Wed, 13 Dec 2017 12:27:40 +0530
In-Reply-To: <1513148261-21097-1-git-send-email-ego@linux.vnet.ibm.com>
References: <1513148261-21097-1-git-send-email-ego@linux.vnet.ibm.com>
Message-Id: <1513148261-21097-3-git-send-email-ego@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>

The code in powernv-cpufreq, makes the following two assumptions which
are not guaranteed by the device-tree bindings:

    1) Pstate ids are continguous: This is used in pstate_to_idx() to
       obtain the reverse map from a pstate to it's corresponding
       entry into the cpufreq frequency table.

    2) Every Pstate should always lie between the max and the min
       pstates that are explicitly reported in the device tree: This
       is used to determine whether a pstate reported by the PMSR is
       out of bounds.

Both these assumptions are unwarranted and can change on future
platforms.

In this patch, we maintain the reverse map from a pstate to it's index
in the cpufreq frequency table and use this in pstate_to_idx(). This
does away with the assumptions (1) mentioned above, and will work with
non continguous pstate ids. If no entry exists for a particular
pstate, then such a pstate is treated as being out of bounds. This
gets rid of assumption (2).

On all the existing platforms, where the pstates are 8-bit long
values, the new implementation of pstate_to_idx() takes constant time.

Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
 drivers/cpufreq/powernv-cpufreq.c | 85 +++++++++++++++++++++++++++++----------
 1 file changed, 63 insertions(+), 22 deletions(-)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index f46b60f..8e3dbca 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -29,6 +29,7 @@
 #include <linux/reboot.h>
 #include <linux/slab.h>
 #include <linux/cpu.h>
+#include <linux/hashtable.h>
 #include <trace/events/power.h>
 
 #include <asm/cputhreads.h>
@@ -38,7 +39,8 @@
 #include <asm/opal.h>
 #include <linux/timer.h>
 
-#define POWERNV_MAX_PSTATES	256
+#define POWERNV_MAX_PSTATES_ORDER  8
+#define POWERNV_MAX_PSTATES	(1UL << (POWERNV_MAX_PSTATES_ORDER))
 #define PMSR_PSAFE_ENABLE	(1UL << 30)
 #define PMSR_SPR_EM_DISABLE	(1UL << 31)
 #define MAX_PSTATE_SHIFT	32
@@ -92,6 +94,27 @@ struct global_pstate_info {
 };
 
 static struct cpufreq_frequency_table powernv_freqs[POWERNV_MAX_PSTATES+1];
+
+DEFINE_HASHTABLE(pstate_revmap, POWERNV_MAX_PSTATES_ORDER);
+/**
+ * struct pstate_idx_revmap_data: Entry in the hashmap pstate_revmap
+ *				  indexed by a function of pstate id.
+ *
+ * @pstate_id: pstate id for this entry.
+ *
+ * @cpufreq_table_idx: Index into the powernv_freqs
+ *		       cpufreq_frequency_table for frequency
+ *		       corresponding to pstate_id.
+ *
+ * @hentry: hlist_node that hooks this entry into the pstate_revmap
+ *	    hashtable
+ */
+struct pstate_idx_revmap_data {
+	int pstate_id;
+	unsigned int cpufreq_table_idx;
+	struct hlist_node hentry;
+};
+
 u32 pstate_sign_prefix;
 static bool rebooting, throttled, occ_reset;
 
@@ -161,39 +184,47 @@ static inline int extract_pstate(u64 pmsr_val, unsigned int shift)
 #define extract_global_pstate(x) extract_pstate(x, GPSTATE_SHIFT)
 #define extract_max_pstate(x)  extract_pstate(x, MAX_PSTATE_SHIFT)
 
-/* Use following macros for conversions between pstate_id and index */
+/* Use following functions for conversions between pstate_id and index */
+
+/**
+ * idx_to_pstate : Returns the pstate id corresponding to the
+ *		   frequency in the cpufreq frequency table
+ *		   powernv_freqs indexed by @i.
+ *
+ *		   If @i is out of bound, this will return the pstate
+ *		   corresponding to the nominal frequency.
+ */
 static inline int idx_to_pstate(unsigned int i)
 {
 	if (unlikely(i >= powernv_pstate_info.nr_pstates)) {
-		pr_warn_once("index %u is out of bound\n", i);
+		pr_warn_once("idx_to_pstate: index %u is out of bound\n", i);
 		return powernv_freqs[powernv_pstate_info.nominal].driver_data;
 	}
 
 	return powernv_freqs[i].driver_data;
 }
 
-static inline unsigned int pstate_to_idx(int pstate)
+/**
+ * pstate_to_idx : Returns the index in the cpufreq frequencytable
+ *		   powernv_freqs for the frequency whose corresponding
+ *		   pstate id is @pstate.
+ *
+ *		   If no frequency corresponding to @pstate is found,
+ *		   this will return the index of the nominal
+ *		   frequency.
+ */
+static unsigned int pstate_to_idx(int pstate)
 {
-	int min = powernv_freqs[powernv_pstate_info.min].driver_data;
-	int max = powernv_freqs[powernv_pstate_info.max].driver_data;
+	unsigned int key = pstate % POWERNV_MAX_PSTATES;
+	struct pstate_idx_revmap_data *revmap_data;
 
-	if (min > 0) {
-		if (unlikely((pstate < max) || (pstate > min))) {
-			pr_warn_once("pstate %d is out of bound\n", pstate);
-			return powernv_pstate_info.nominal;
-		}
-	} else {
-		if (unlikely((pstate > max) || (pstate < min))) {
-			pr_warn_once("pstate %d is out of bound\n", pstate);
-			return powernv_pstate_info.nominal;
-		}
+	hash_for_each_possible(pstate_revmap, revmap_data, hentry, key) {
+		if (revmap_data->pstate_id == pstate)
+			return revmap_data->cpufreq_table_idx;
 	}
-	/*
-	 * abs() is deliberately used so that is works with
-	 * both monotonically increasing and decreasing
-	 * pstate values
-	 */
-	return abs(pstate - idx_to_pstate(powernv_pstate_info.max));
+
+	pr_warn_once("pstate_to_idx: pstate %d not found\n", pstate);
+	return powernv_pstate_info.nominal;
 }
 
 static inline void reset_gpstates(struct cpufreq_policy *policy)
@@ -297,11 +328,21 @@ static int init_powernv_pstates(void)
 	for (i = 0; i < nr_pstates; i++) {
 		u32 id = be32_to_cpu(pstate_ids[i]);
 		u32 freq = be32_to_cpu(pstate_freqs[i]);
+		struct pstate_idx_revmap_data *revmap_data;
+		unsigned int key;
 
 		pr_debug("PState id %d freq %d MHz\n", id, freq);
 		powernv_freqs[i].frequency = freq * 1000; /* kHz */
 		powernv_freqs[i].driver_data = id;
 
+		revmap_data = (struct pstate_idx_revmap_data *)
+			      kmalloc(sizeof(*revmap_data), GFP_KERNEL);
+
+		revmap_data->pstate_id = id;
+		revmap_data->cpufreq_table_idx = i;
+		key = id % POWERNV_MAX_PSTATES;
+		hash_add(pstate_revmap, &revmap_data->hentry, key);
+
 		if (id == pstate_max)
 			powernv_pstate_info.max = i;
 		else if (id == pstate_nominal)
-- 
1.9.4
