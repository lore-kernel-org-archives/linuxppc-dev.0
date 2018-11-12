Return-Path: <SRS0=Ph+o=NX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7959DC43441
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Nov 2018 18:54:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0470622419
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Nov 2018 18:54:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0470622419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42v0LT17jzzF3R0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Nov 2018 05:54:57 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42v0JT1PqqzF3Ft
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Nov 2018 05:53:12 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wACIhc7Z034148
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Nov 2018 13:53:11 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2nqf0f8g1h-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Nov 2018 13:53:10 -0500
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Mon, 12 Nov 2018 18:53:09 -0000
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
 by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 12 Nov 2018 18:53:05 -0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
 [9.57.199.109])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wACIr4fb33161234
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 12 Nov 2018 18:53:04 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 78304112062;
 Mon, 12 Nov 2018 18:53:04 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 249DD112065;
 Mon, 12 Nov 2018 18:53:03 +0000 (GMT)
Received: from oc5000245537.ibm.com (unknown [9.53.179.211])
 by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
 Mon, 12 Nov 2018 18:53:03 +0000 (GMT)
To: "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/numa: Perform full re-add of CPU for PRRN/VPHN
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
Date: Mon, 12 Nov 2018 12:53:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18111218-0064-0000-0000-00000372C4AF
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010036; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01116474; UDB=6.00577118; IPR=6.00896582; 
 MB=3.00024130; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-12 18:53:08
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111218-0065-0000-0000-00003B4FDEDE
Message-Id: <7c3c840a-8a79-b639-185c-ce6d2e378850@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-11-12_12:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811120163
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
Cc: Rob Herring <robh@kernel.org>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 Kees Cook <keescook@chromium.org>, Nicholas Piggin <npiggin@gmail.com>,
 Al Viro <viro@zeniv.linux.org.uk>, Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Juliet Kim <minkim@us.ibm.com>, Paul Mackerras <paulus@samba.org>,
 Corentin Labbe <clabbe@baylibre.com>, Oliver O'Halloran <oohall@gmail.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
 Guenter Roeck <linux@roeck-us.net>, Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
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
DAte: Wed Oct 10 15:24:46 AEDT 2018
]

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/topology.h |    6 -
 arch/powerpc/kernel/rtasd.c         |    1 
 arch/powerpc/mm/numa.c              |  184 +++++------------------------------
 3 files changed, 27 insertions(+), 164 deletions(-)

diff --git a/arch/powerpc/include/asm/topology.h b/arch/powerpc/include/asm/topology.h
index f85e2b0..9f85246 100644
--- a/arch/powerpc/include/asm/topology.h
+++ b/arch/powerpc/include/asm/topology.h
@@ -42,7 +42,6 @@ static inline int pcibus_to_node(struct pci_bus *bus)
 
 extern int sysfs_add_device_to_node(struct device *dev, int nid);
 extern void sysfs_remove_device_from_node(struct device *dev, int nid);
-extern int numa_update_cpu_topology(bool cpus_locked);
 
 static inline void update_numa_cpu_lookup_table(unsigned int cpu, int node)
 {
@@ -77,11 +76,6 @@ static inline void sysfs_remove_device_from_node(struct device *dev,
 {
 }
 
-static inline int numa_update_cpu_topology(bool cpus_locked)
-{
-	return 0;
-}
-
 static inline void update_numa_cpu_lookup_table(unsigned int cpu, int node) {}
 
 #endif /* CONFIG_NUMA */
diff --git a/arch/powerpc/kernel/rtasd.c b/arch/powerpc/kernel/rtasd.c
index 38cadae..c161d74 100644
--- a/arch/powerpc/kernel/rtasd.c
+++ b/arch/powerpc/kernel/rtasd.c
@@ -285,7 +285,6 @@ static void handle_prrn_event(s32 scope)
 	 * the RTAS event.
 	 */
 	pseries_devicetree_update(-scope);
-	numa_update_cpu_topology(false);
 }
 
 static void handle_rtas_event(const struct rtas_error_log *log)
diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index be6216e..f79b65f 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -1236,96 +1236,25 @@ int find_and_online_cpu_nid(int cpu)
 	return new_nid;
 }
 
-/*
- * Update the CPU maps and sysfs entries for a single CPU when its NUMA
- * characteristics change. This function doesn't perform any locking and is
- * only safe to call from stop_machine().
- */
-static int update_cpu_topology(void *data)
-{
-	struct topology_update_data *update;
-	unsigned long cpu;
-
-	if (!data)
-		return -EINVAL;
-
-	cpu = smp_processor_id();
-
-	for (update = data; update; update = update->next) {
-		int new_nid = update->new_nid;
-		if (cpu != update->cpu)
-			continue;
-
-		unmap_cpu_from_node(cpu);
-		map_cpu_to_node(cpu, new_nid);
-		set_cpu_numa_node(cpu, new_nid);
-		set_cpu_numa_mem(cpu, local_memory_node(new_nid));
-		vdso_getcpu_init();
-	}
-
-	return 0;
-}
-
-static int update_lookup_table(void *data)
-{
-	struct topology_update_data *update;
-
-	if (!data)
-		return -EINVAL;
-
-	/*
-	 * Upon topology update, the numa-cpu lookup table needs to be updated
-	 * for all threads in the core, including offline CPUs, to ensure that
-	 * future hotplug operations respect the cpu-to-node associativity
-	 * properly.
-	 */
-	for (update = data; update; update = update->next) {
-		int nid, base, j;
-
-		nid = update->new_nid;
-		base = cpu_first_thread_sibling(update->cpu);
-
-		for (j = 0; j < threads_per_core; j++) {
-			update_numa_cpu_lookup_table(base + j, nid);
-		}
-	}
-
-	return 0;
-}
-
-/*
- * Update the node maps and sysfs entries for each cpu whose home node
- * has changed. Returns 1 when the topology has changed, and 0 otherwise.
- *
- * cpus_locked says whether we already hold cpu_hotplug_lock.
- */
-int numa_update_cpu_topology(bool cpus_locked)
+static void topology_work_fn(struct work_struct *work)
 {
 	unsigned int cpu, sibling, changed = 0;
-	struct topology_update_data *updates, *ud;
-	cpumask_t updated_cpus;
-	struct device *dev;
-	int weight, new_nid, i = 0;
+	int weight;
 
 	if (!prrn_enabled && !vphn_enabled && topology_inited)
-		return 0;
+		return;
 
 	weight = cpumask_weight(&cpu_associativity_changes_mask);
 	if (!weight)
-		return 0;
+		return;
 
-	updates = kcalloc(weight, sizeof(*updates), GFP_KERNEL);
-	if (!updates)
-		return 0;
+	pr_debug("Topology update CPUs beginning\n");
 
-	cpumask_clear(&updated_cpus);
+	lock_device_hotplug();
 
 	for_each_cpu(cpu, &cpu_associativity_changes_mask) {
-		/*
-		 * If siblings aren't flagged for changes, updates list
-		 * will be too short. Skip on this update and set for next
-		 * update.
-		 */
+		int new_nid;
+
 		if (!cpumask_subset(cpu_sibling_mask(cpu),
 					&cpu_associativity_changes_mask)) {
 			pr_info("Sibling bits not set for associativity "
@@ -1337,9 +1266,11 @@ int numa_update_cpu_topology(bool cpus_locked)
 			continue;
 		}
 
+		/* Use associativity from first thread for all siblings */
 		new_nid = find_and_online_cpu_nid(cpu);
 
-		if (new_nid == numa_cpu_lookup_table[cpu]) {
+		if ((new_nid == numa_cpu_lookup_table[cpu]) ||
+			!cpu_present(cpu)) {
 			cpumask_andnot(&cpu_associativity_changes_mask,
 					&cpu_associativity_changes_mask,
 					cpu_sibling_mask(cpu));
@@ -1349,89 +1280,29 @@ int numa_update_cpu_topology(bool cpus_locked)
 			continue;
 		}
 
-		for_each_cpu(sibling, cpu_sibling_mask(cpu)) {
-			ud = &updates[i++];
-			ud->next = &updates[i];
-			ud->cpu = sibling;
-			ud->new_nid = new_nid;
-			ud->old_nid = numa_cpu_lookup_table[sibling];
-			cpumask_set_cpu(sibling, &updated_cpus);
-		}
-		cpu = cpu_last_thread_sibling(cpu);
-	}
+		pr_debug("Topology update for cpu %d\n", cpu);
+		dlpar_cpu_readd(cpu);
+		changed++;
 
-	/*
-	 * Prevent processing of 'updates' from overflowing array
-	 * where last entry filled in a 'next' pointer.
-	 */
-	if (i)
-		updates[i-1].next = NULL;
-
-	pr_debug("Topology update for the following CPUs:\n");
-	if (cpumask_weight(&updated_cpus)) {
-		for (ud = &updates[0]; ud; ud = ud->next) {
-			pr_debug("cpu %d moving from node %d "
-					  "to %d\n", ud->cpu,
-					  ud->old_nid, ud->new_nid);
+		for_each_cpu(sibling, cpu_sibling_mask(cpu)) {
+			unmap_cpu_from_node(sibling);
+			map_cpu_to_node(sibling, new_nid);
+			set_cpu_numa_node(sibling, new_nid);
+			set_cpu_numa_mem(sibling,
+				local_memory_node(new_nid));
+			cpumask_clear_cpu(sibling,
+				&cpu_associativity_changes_mask);
 		}
-	}
-
-	/*
-	 * In cases where we have nothing to update (because the updates list
-	 * is too short or because the new topology is same as the old one),
-	 * skip invoking update_cpu_topology() via stop-machine(). This is
-	 * necessary (and not just a fast-path optimization) since stop-machine
-	 * can end up electing a random CPU to run update_cpu_topology(), and
-	 * thus trick us into setting up incorrect cpu-node mappings (since
-	 * 'updates' is kzalloc()'ed).
-	 *
-	 * And for the similar reason, we will skip all the following updating.
-	 */
-	if (!cpumask_weight(&updated_cpus))
-		goto out;
 
-	if (cpus_locked)
-		stop_machine_cpuslocked(update_cpu_topology, &updates[0],
-					&updated_cpus);
-	else
-		stop_machine(update_cpu_topology, &updates[0], &updated_cpus);
-
-	/*
-	 * Update the numa-cpu lookup table with the new mappings, even for
-	 * offline CPUs. It is best to perform this update from the stop-
-	 * machine context.
-	 */
-	if (cpus_locked)
-		stop_machine_cpuslocked(update_lookup_table, &updates[0],
-					cpumask_of(raw_smp_processor_id()));
-	else
-		stop_machine(update_lookup_table, &updates[0],
-			     cpumask_of(raw_smp_processor_id()));
-
-	for (ud = &updates[0]; ud; ud = ud->next) {
-		unregister_cpu_under_node(ud->cpu, ud->old_nid);
-		register_cpu_under_node(ud->cpu, ud->new_nid);
-
-		dev = get_cpu_device(ud->cpu);
-		if (dev)
-			kobject_uevent(&dev->kobj, KOBJ_CHANGE);
-		cpumask_clear_cpu(ud->cpu, &cpu_associativity_changes_mask);
-		changed = 1;
+		cpu = cpu_last_thread_sibling(cpu);
 	}
 
-out:
-	kfree(updates);
-	return changed;
-}
+	unlock_device_hotplug();
 
-int arch_update_cpu_topology(void)
-{
-	return numa_update_cpu_topology(true);
-}
+	pr_debug("Topology update CPUs ending\n");
 
-static void topology_work_fn(struct work_struct *work)
-{
-	rebuild_sched_domains();
+	if (changed)
+		rebuild_sched_domains();
 }
 static DECLARE_WORK(topology_work, topology_work_fn);
 
@@ -1553,7 +1424,6 @@ void __init shared_proc_topology_init(void)
 	if (lppaca_shared_proc(get_lppaca())) {
 		bitmap_fill(cpumask_bits(&cpu_associativity_changes_mask),
 			    nr_cpumask_bits);
-		numa_update_cpu_topology(false);
 	}
 }
 

