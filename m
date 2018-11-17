Return-Path: <SRS0=8VeL=N4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99512C43441
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Nov 2018 11:54:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7AE820815
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Nov 2018 11:54:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7AE820815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42xtn22BXrzF3Gx
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Nov 2018 22:54:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=mwb@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42xtkd01NPzF3mC
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Nov 2018 22:52:24 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wAHBmtfM061137
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Nov 2018 06:52:22 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ntf6awxxk-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Nov 2018 06:52:22 -0500
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Sat, 17 Nov 2018 11:52:21 -0000
Received: from b03cxnp08026.gho.boulder.ibm.com (9.17.130.18)
 by e36.co.us.ibm.com (192.168.1.136) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Sat, 17 Nov 2018 11:52:17 -0000
Received: from b03ledav006.gho.boulder.ibm.com
 (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wAHBqGcj25821232
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sat, 17 Nov 2018 11:52:16 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8BF2EC6059;
 Sat, 17 Nov 2018 11:52:16 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0E82EC6055;
 Sat, 17 Nov 2018 11:52:12 +0000 (GMT)
Received: from oc5000245537.ibm.com (unknown [9.85.193.68])
 by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
 Sat, 17 Nov 2018 11:52:12 +0000 (GMT)
To: linuxppc-dev@lists.ozlabs.org
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: [PATCH v02] powerpc/numa: Perform full re-add of CPU for PRRN/VPHN
 topology update
Openpgp: preference=signencrypt
Autocrypt: addr=mwb@linux.vnet.ibm.com; prefer-encrypt=mutual; keydata=
 xsBNBFcY7GcBCADzw3en+yzo9ASFGCfldVkIg95SAMPK0myXp2XJYET3zT45uBsX/uj9/2nA
 lBmXXeOSXnPfJ9V3vtiwcfATnWIsVt3tL6n1kqikzH9nXNxZT7MU/7gqzWZngMAWh/GJ9qyg
 DTOZdjsvdUNUWxtiLvBo7y+reA4HjlQhwhYxxvCpXBeRoF0qDWfQ8DkneemqINzDZPwSQ7zY
 t4F5iyN1I9GC5RNK8Y6jiKmm6bDkrrbtXPOtzXKs0J0FqWEIab/u3BDrRP3STDVPdXqViHua
 AjEzthQbGZm0VCxI4a7XjMi99g614/qDcXZCs00GLZ/VYIE8hB9C5Q+l66S60PLjRrxnABEB
 AAHNLU1pY2hhZWwgVy4gQnJpbmdtYW5uIDxtd2JAbGludXgudm5ldC5pYm0uY29tPsLAeAQT
 AQIAIgUCVxjsZwIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQSEdag3dpuTI0NAf8
 CKYTDKQLgOSjVrU2L5rM4lXaJRmQV6oidD3vIhKSnWRvPq9C29ifRG6ri20prTHAlc0vycgm
 41HHg0y2vsGgNXGTWC2ObemoZBI7mySXe/7Tq5mD/semGzOp0YWZ7teqrkiSR8Bw0p+LdE7K
 QmT7tpjjvuhrtQ3RRojUYcuy1nWUsc4D+2cxsnZslsx84FUKxPbLagDgZmgBhUw/sUi40s6S
 AkdViVCVS0WANddLIpG0cfdsV0kCae/XdjK3mRK6drFKv1z+QFjvOhc8QIkkxFD0da9w3tJj
 oqnqHFV5gLcHO6/wizPx/NV90y6RngeBORkQiRFWxTXS4Oj9GVI/Us7ATQRXGOxnAQgAmJ5Y
 ikTWrMWPfiveUacETyEhWVl7u8UhZcx3yy2te8O0ay7t9fYcZgIEfQPPVVus89acIXlG3wYL
 DDPvb21OprLxi+ZJ2a0S5we+LcSWN1jByxJlbWBq+/LcMtGAOhNLpysY1gD0Y4UW/eKS+TFZ
 562qKC3k1dBvnV9JXCgeS1taYFxRdVAn+2DwK3nuyG/DDq/XgJ5BtmyC3MMx8CiW3POj+O+l
 6SedIeAfZlZ7/xhijx82g93h07VavUQRwMZgZFsqmuxBxVGiav2HB+dNvs3PFB087Pvc9OHe
 qhajPWOP/gNLMmvBvknn1NToM9a8/E8rzcIZXoYs4RggRRYh6wARAQABwsBfBBgBAgAJBQJX
 GOxnAhsMAAoJEEhHWoN3abky+RUH/jE08/r5QzaNKYeVhu0uVbgXu5fsxqr2cAxhf+KuwT3T
 efhEP2alarxzUZdEh4MsG6c+X2NYLbD3cryiXxVx/7kSAJEFQJfA5P06g8NLR25Qpq9BLsN7
 ++dxQ+CLKzSEb1X24hYAJZpOhS8ev3ii+M/XIo+olDBKuTaTgB6elrg3CaxUsVgLBJ+jbRkW
 yQe2S5f/Ja1ThDpSSLLWLiLK/z7+gaqwhnwjQ8Z8Y9D2itJQcj4itHilwImsqwLG7SxzC0NX
 IQ5KaAFYdRcOgwR8VhhkOIVd70ObSZU+E4pTET1WDz4o65xZ89yfose1No0+r5ht/xWOOrh8
 53/hcWvxHVs=
Organization: IBM Linux Technology Center
Date: Sat, 17 Nov 2018 05:52:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18111711-0020-0000-0000-00000E8B3151
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010067; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01118731; UDB=6.00580366; IPR=6.00898840; 
 MB=3.00024205; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-17 11:52:20
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111711-0021-0000-0000-000063BE1AED
Message-Id: <90ec70e1-135d-16f9-98da-ca598a9125c3@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-11-17_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811170114
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Rob Herring <robh@kernel.org>, Oliver O'Halloran <oohall@gmail.com>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 Kees Cook <keescook@chromium.org>, Nicholas Piggin <npiggin@gmail.com>,
 Al Viro <viro@zeniv.linux.org.uk>, Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Juliet Kim <minkim@us.ibm.com>, Paul Mackerras <paulus@samba.org>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
 Guenter Roeck <linux@roeck-us.net>, Corentin Labbe <clabbe@baylibre.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On pseries systems, performing changes to a partition's affinity
can result in altering the nodes a CPU is assigned to the
current system.  For example, some systems are subject to resource
balancing operations by the operator or control software.  In such
environments, system CPUs may be in node 1 and 3 at boot, and be
moved to nodes 2, 3, and 5, for better performance.

The current implementation attempts to recognize such changes within
the powerpc-specific version of arch_update_cpu_topology to modify a
range of system data structures directly.  However, some scheduler
data structures may be inaccessible, or the timing of a node change
may still lead to corruption or error in other modules (e.g. user
space) which do not receive notification of these changes.

This patch modifies the PRRN/VPHN topology update worker function to
recognize an affinity change for a CPU, and to perform a full DLPAR
remove and add of the CPU instead of dynamically changing its node
to resolve this issue.

[Based upon patch submission:
Subject: [PATCH] powerpc/pseries: Perform full re-add of CPU for topology update post-migration
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Date: Tue Oct 30 05:43:36 AEDT 2018
]

[Replace patch submission:
Subject: [PATCH] powerpc/topology: Update numa mask when cpu node mapping changes
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Date: Wed Oct 10 15:24:46 AEDT 2018
]

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
---
Changes in v02:
  -- Reuse more of the previous implementation to reduce patch size
  -- Replace former calls to numa_update_cpu_topology(false) by
     topology_schedule_update
  -- Make sure that we report topology changes back through
     arch_update_cpu_topology
  -- Fix problem observed in powerpc next kernel with updating
     cpu_associativity_changes_mask in timer_topology_fn when both
     prrn_enabled and vphn_enabled, and many extra CPUs are possible,
     but not installed.
  -- Fix problem with updating cpu_associativity_changes_mask when
     VPHN associativity information does not arrive until after first
     call to update topology occurs.
---
 arch/powerpc/include/asm/topology.h |    7 +---
 arch/powerpc/kernel/rtasd.c         |    2 +
 arch/powerpc/mm/numa.c              |   69 +++++++++++++++++++++++------------
 3 files changed, 48 insertions(+), 30 deletions(-)

diff --git a/arch/powerpc/include/asm/topology.h b/arch/powerpc/include/asm/topology.h
index f85e2b0..79505c3 100644
--- a/arch/powerpc/include/asm/topology.h
+++ b/arch/powerpc/include/asm/topology.h
@@ -42,7 +42,7 @@ static inline int pcibus_to_node(struct pci_bus *bus)
 
 extern int sysfs_add_device_to_node(struct device *dev, int nid);
 extern void sysfs_remove_device_from_node(struct device *dev, int nid);
-extern int numa_update_cpu_topology(bool cpus_locked);
+extern void topology_schedule_update(void);
 
 static inline void update_numa_cpu_lookup_table(unsigned int cpu, int node)
 {
@@ -77,10 +77,7 @@ static inline void sysfs_remove_device_from_node(struct device *dev,
 {
 }
 
-static inline int numa_update_cpu_topology(bool cpus_locked)
-{
-	return 0;
-}
+static inline void topology_schedule_update(void) {}
 
 static inline void update_numa_cpu_lookup_table(unsigned int cpu, int node) {}
 
diff --git a/arch/powerpc/kernel/rtasd.c b/arch/powerpc/kernel/rtasd.c
index 38cadae..7e2777c 100644
--- a/arch/powerpc/kernel/rtasd.c
+++ b/arch/powerpc/kernel/rtasd.c
@@ -285,7 +285,7 @@ static void handle_prrn_event(s32 scope)
 	 * the RTAS event.
 	 */
 	pseries_devicetree_update(-scope);
-	numa_update_cpu_topology(false);
+	topology_schedule_update();
 }
 
 static void handle_rtas_event(const struct rtas_error_log *log)
diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 5c2cfaf..15e0e06 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -1077,6 +1077,9 @@ struct topology_update_data {
 static void reset_topology_timer(void);
 static int topology_timer_secs = 1;
 static int topology_inited;
+static int topology_update_in_progress;
+static int topology_changed;
+static unsigned long topology_scans;
 
 /*
  * Change polling interval for associativity changes.
@@ -1297,9 +1300,9 @@ static int update_lookup_table(void *data)
  * Update the node maps and sysfs entries for each cpu whose home node
  * has changed. Returns 1 when the topology has changed, and 0 otherwise.
  *
- * cpus_locked says whether we already hold cpu_hotplug_lock.
+ * readd_cpus: Also readd any CPUs that have changed affinity
  */
-int numa_update_cpu_topology(bool cpus_locked)
+static int numa_update_cpu_topology(bool readd_cpus)
 {
 	unsigned int cpu, sibling, changed = 0;
 	struct topology_update_data *updates, *ud;
@@ -1307,7 +1310,8 @@ int numa_update_cpu_topology(bool cpus_locked)
 	struct device *dev;
 	int weight, new_nid, i = 0;
 
-	if (!prrn_enabled && !vphn_enabled && topology_inited)
+	if ((!prrn_enabled && !vphn_enabled && topology_inited) ||
+		topology_update_in_progress)
 		return 0;
 
 	weight = cpumask_weight(&cpu_associativity_changes_mask);
@@ -1318,6 +1322,8 @@ int numa_update_cpu_topology(bool cpus_locked)
 	if (!updates)
 		return 0;
 
+	topology_update_in_progress = 1;
+
 	cpumask_clear(&updated_cpus);
 
 	for_each_cpu(cpu, &cpu_associativity_changes_mask) {
@@ -1339,16 +1345,21 @@ int numa_update_cpu_topology(bool cpus_locked)
 
 		new_nid = find_and_online_cpu_nid(cpu);
 
-		if (new_nid == numa_cpu_lookup_table[cpu]) {
+		if ((new_nid == numa_cpu_lookup_table[cpu]) ||
+			!cpu_present(cpu)) {
 			cpumask_andnot(&cpu_associativity_changes_mask,
 					&cpu_associativity_changes_mask,
 					cpu_sibling_mask(cpu));
-			dbg("Assoc chg gives same node %d for cpu%d\n",
+			if (cpu_present(cpu))
+				dbg("Assoc chg gives same node %d for cpu%d\n",
 					new_nid, cpu);
 			cpu = cpu_last_thread_sibling(cpu);
 			continue;
 		}
 
+		if (readd_cpus)
+			dlpar_cpu_readd(cpu);
+
 		for_each_cpu(sibling, cpu_sibling_mask(cpu)) {
 			ud = &updates[i++];
 			ud->next = &updates[i];
@@ -1390,23 +1401,15 @@ int numa_update_cpu_topology(bool cpus_locked)
 	if (!cpumask_weight(&updated_cpus))
 		goto out;
 
-	if (cpus_locked)
-		stop_machine_cpuslocked(update_cpu_topology, &updates[0],
-					&updated_cpus);
-	else
-		stop_machine(update_cpu_topology, &updates[0], &updated_cpus);
+	stop_machine(update_cpu_topology, &updates[0], &updated_cpus);
 
 	/*
 	 * Update the numa-cpu lookup table with the new mappings, even for
 	 * offline CPUs. It is best to perform this update from the stop-
 	 * machine context.
 	 */
-	if (cpus_locked)
-		stop_machine_cpuslocked(update_lookup_table, &updates[0],
-					cpumask_of(raw_smp_processor_id()));
-	else
-		stop_machine(update_lookup_table, &updates[0],
-			     cpumask_of(raw_smp_processor_id()));
+	stop_machine(update_lookup_table, &updates[0],
+		     cpumask_of(raw_smp_processor_id()));
 
 	for (ud = &updates[0]; ud; ud = ud->next) {
 		unregister_cpu_under_node(ud->cpu, ud->old_nid);
@@ -1420,35 +1423,53 @@ int numa_update_cpu_topology(bool cpus_locked)
 	}
 
 out:
+	topology_changed = changed;
+	topology_update_in_progress = 0;
 	kfree(updates);
 	return changed;
 }
 
 int arch_update_cpu_topology(void)
 {
-	return numa_update_cpu_topology(true);
+	int changed = topology_changed;
+
+	topology_changed = 0;
+	return changed;
 }
 
 static void topology_work_fn(struct work_struct *work)
 {
-	rebuild_sched_domains();
+	lock_device_hotplug();
+	if (numa_update_cpu_topology(true))
+        	rebuild_sched_domains();
+	unlock_device_hotplug();
 }
 static DECLARE_WORK(topology_work, topology_work_fn);
 
-static void topology_schedule_update(void)
+void topology_schedule_update(void)
 {
-	schedule_work(&topology_work);
+	if (!topology_update_in_progress);
+		schedule_work(&topology_work);
 }
 
 static void topology_timer_fn(struct timer_list *unused)
 {
+	bool sdo = false;
+
+	if (topology_scans < 1)
+		bitmap_fill(cpumask_bits(&cpu_associativity_changes_mask),
+			    nr_cpumask_bits);
+
 	if (prrn_enabled && cpumask_weight(&cpu_associativity_changes_mask))
-		topology_schedule_update();
-	else if (vphn_enabled) {
+		sdo =  true;
+	if (vphn_enabled) {
 		if (update_cpu_associativity_changes_mask() > 0)
-			topology_schedule_update();
+			sdo =  true;
 		reset_topology_timer();
 	}
+	if (sdo)
+		topology_schedule_update();
+	topology_scans++;
 }
 static struct timer_list topology_timer;
 
@@ -1561,7 +1582,7 @@ void __init shared_proc_topology_init(void)
 	if (lppaca_shared_proc(get_lppaca())) {
 		bitmap_fill(cpumask_bits(&cpu_associativity_changes_mask),
 			    nr_cpumask_bits);
-		numa_update_cpu_topology(false);
+		topology_schedule_update();
 	}
 }
 

