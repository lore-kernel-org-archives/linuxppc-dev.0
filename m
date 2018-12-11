Return-Path: <SRS0=mkti=OU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD20C67839
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 22:12:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05D6D2084E
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 22:12:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05D6D2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43DvLW10FBzDqM9
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Dec 2018 09:12:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=mwb@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Dv9V58gyzDqmf
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Dec 2018 09:04:14 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wBBM3eG4098908
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Dec 2018 17:04:12 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2pam3gv7yk-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Dec 2018 17:04:12 -0500
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Tue, 11 Dec 2018 22:04:11 -0000
Received: from b03cxnp08026.gho.boulder.ibm.com (9.17.130.18)
 by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 11 Dec 2018 22:04:08 -0000
Received: from b03ledav006.gho.boulder.ibm.com
 (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wBBM452222347966
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 11 Dec 2018 22:04:05 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CAC33C6057;
 Tue, 11 Dec 2018 22:04:05 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A5412C6055;
 Tue, 11 Dec 2018 22:04:05 +0000 (GMT)
Received: from powerkvm6.aus.stglabs.ibm.com (unknown [9.40.192.78])
 by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
 Tue, 11 Dec 2018 22:04:05 +0000 (GMT)
Received: from powerkvm6.aus.stglabs.ibm.com (localhost [IPv6:::1])
 by powerkvm6.aus.stglabs.ibm.com (Postfix) with ESMTP id 5E737489EFAB;
 Tue, 11 Dec 2018 16:04:05 -0600 (CST)
Subject: [RFC 3/3] powerpc/numa: Apply mapping between HW and kernel cpus
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Date: Tue, 11 Dec 2018 16:04:05 -0600
In-Reply-To: <20181211220321.87502.72082.stgit@powerkvm6.aus.stglabs.ibm.com>
References: <20181211220321.87502.72082.stgit@powerkvm6.aus.stglabs.ibm.com>
User-Agent: StGit/0.18-105-g416a-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18121122-0036-0000-0000-00000A691622
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010214; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01130389; UDB=6.00587377; IPR=6.00910522; 
 MB=3.00024658; MTD=3.00000008; XFM=3.00000015; UTC=2018-12-11 22:04:10
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18121122-0037-0000-0000-000049F0F898
Message-Id: <20181211220400.87502.94057.stgit@powerkvm6.aus.stglabs.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-12-11_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812110194
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
Cc: Rob Herring <robh@kernel.org>, Mike Rapoport <rppt@linux.vnet.ibm.com>,
 tlfalcon@linux.vnet.ibm.com, Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Vaidyanathan Srinivasan <svaidyan@in.ibm.com>, mwb@linux.vnet.ibm.com,
 minkim@us.ibm.com, Paul Mackerras <paulus@samba.org>,
 tyreld@linux.vnet.ibm.com, Andrew Morton <akpm@linux-foundation.org>,
 Guenter Roeck <linux@roeck-us.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Apply new interface to map external powerpc cpus across multiple
nodes to a range of kernel cpu values.  Mapping is intended to
prevent confusion within the kernel about the cpu+node mapping, and
the changes in configuration that may happen due to powerpc LPAR
migration or other associativity changes during the lifetime of a
system.  These interfaces exchange the thread_index provided by the
'ibm,ppc-interrupt-server#s' properties, for an internal index to
be used by kernel scheduling interfaces.

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
---
 arch/powerpc/mm/numa.c                       |   45 +++++++++++++++++---------
 arch/powerpc/platforms/pseries/hotplug-cpu.c |   15 +++++++--
 2 files changed, 41 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 7d6bba264..59d7cd9 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -1063,7 +1063,8 @@ u64 memory_hotplug_max(void)
 
 struct topology_update_data {
 	struct topology_update_data *next;
-	unsigned int cpu;
+	unsigned int old_cpu;
+	unsigned int new_cpu;
 	int old_nid;
 	int new_nid;
 };
@@ -1253,13 +1254,13 @@ static int update_cpu_topology(void *data)
 
 	for (update = data; update; update = update->next) {
 		int new_nid = update->new_nid;
-		if (cpu != update->cpu)
+		if (cpu != update->new_cpu)
 			continue;
 
-		unmap_cpu_from_node(cpu);
-		map_cpu_to_node(cpu, new_nid);
-		set_cpu_numa_node(cpu, new_nid);
-		set_cpu_numa_mem(cpu, local_memory_node(new_nid));
+		unmap_cpu_from_node(update->old_cpu);
+		map_cpu_to_node(update->new_cpu, new_nid);
+		set_cpu_numa_node(update->new_cpu, new_nid);
+		set_cpu_numa_mem(update->new_cpu, local_memory_node(new_nid));
 		vdso_getcpu_init();
 	}
 
@@ -1283,7 +1284,7 @@ static int update_lookup_table(void *data)
 		int nid, base, j;
 
 		nid = update->new_nid;
-		base = cpu_first_thread_sibling(update->cpu);
+		base = cpu_first_thread_sibling(update->new_cpu);
 
 		for (j = 0; j < threads_per_core; j++) {
 			update_numa_cpu_lookup_table(base + j, nid);
@@ -1305,7 +1306,7 @@ int numa_update_cpu_topology(bool cpus_locked)
 	struct topology_update_data *updates, *ud;
 	cpumask_t updated_cpus;
 	struct device *dev;
-	int weight, new_nid, i = 0;
+	int weight, new_nid, i = 0, ii;
 
 	if (!prrn_enabled && !vphn_enabled && topology_inited)
 		return 0;
@@ -1349,12 +1350,16 @@ int numa_update_cpu_topology(bool cpus_locked)
 			continue;
 		}
 
+		ii = 0;
 		for_each_cpu(sibling, cpu_sibling_mask(cpu)) {
 			ud = &updates[i++];
 			ud->next = &updates[i];
-			ud->cpu = sibling;
 			ud->new_nid = new_nid;
 			ud->old_nid = numa_cpu_lookup_table[sibling];
+			ud->old_cpu = sibling;
+			ud->new_cpu = cpuremap_map_cpu(
+					get_hard_smp_processor_id(sibling),
+					ii++, new_nid);
 			cpumask_set_cpu(sibling, &updated_cpus);
 		}
 		cpu = cpu_last_thread_sibling(cpu);
@@ -1370,9 +1375,10 @@ int numa_update_cpu_topology(bool cpus_locked)
 	pr_debug("Topology update for the following CPUs:\n");
 	if (cpumask_weight(&updated_cpus)) {
 		for (ud = &updates[0]; ud; ud = ud->next) {
-			pr_debug("cpu %d moving from node %d "
-					  "to %d\n", ud->cpu,
-					  ud->old_nid, ud->new_nid);
+			pr_debug("cpu %d, node %d moving to"
+				 " cpu %d, node %d\n",
+				 ud->old_cpu, ud->old_nid,
+				 ud->new_cpu, ud->new_nid);
 		}
 	}
 
@@ -1409,13 +1415,20 @@ int numa_update_cpu_topology(bool cpus_locked)
 			     cpumask_of(raw_smp_processor_id()));
 
 	for (ud = &updates[0]; ud; ud = ud->next) {
-		unregister_cpu_under_node(ud->cpu, ud->old_nid);
-		register_cpu_under_node(ud->cpu, ud->new_nid);
+		unregister_cpu_under_node(ud->old_cpu, ud->old_nid);
+		register_cpu_under_node(ud->new_cpu, ud->new_nid);
 
-		dev = get_cpu_device(ud->cpu);
+		dev = get_cpu_device(ud->old_cpu);
 		if (dev)
 			kobject_uevent(&dev->kobj, KOBJ_CHANGE);
-		cpumask_clear_cpu(ud->cpu, &cpu_associativity_changes_mask);
+		cpumask_clear_cpu(ud->old_cpu, &cpu_associativity_changes_mask);
+		if (ud->old_cpu != ud->new_cpu) {
+			dev = get_cpu_device(ud->new_cpu);
+			if (dev)
+				kobject_uevent(&dev->kobj, KOBJ_CHANGE);
+			cpumask_clear_cpu(ud->new_cpu,
+				&cpu_associativity_changes_mask);
+		}
 		changed = 1;
 	}
 
diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
index 620cb57..3a11a31 100644
--- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -259,8 +259,13 @@ static int pseries_add_processor(struct device_node *np)
 	zalloc_cpumask_var(&tmp, GFP_KERNEL);
 
 	nthreads = len / sizeof(u32);
-	for (i = 0; i < nthreads; i++)
-		cpumask_set_cpu(i, tmp);
+	for (i = 0; i < nthreads; i++) {
+		int thread_index = be32_to_cpu(intserv[i]);
+		int nid = find_and_online_cpu_nid(thread_index, false);
+		int cpu = cpuremap_map_cpu(thread_index, i, nid);
+		cpumask_set_cpu(cpu, tmp);
+		cpuremap_reserve_cpu(cpu);
+	}
 
 	cpu_maps_update_begin();
 
@@ -333,6 +338,7 @@ static void pseries_remove_processor(struct device_node *np)
 			set_cpu_present(cpu, false);
 			set_hard_smp_processor_id(cpu, -1);
 			update_numa_cpu_lookup_table(cpu, -1);
+			cpuremap_release_cpu(cpu);
 			break;
 		}
 		if (cpu >= nr_cpu_ids)
@@ -346,7 +352,7 @@ static int dlpar_online_cpu(struct device_node *dn)
 {
 	int rc = 0;
 	unsigned int cpu;
-	int len, nthreads, i;
+	int len, nthreads, i, nid;
 	const __be32 *intserv;
 	u32 thread;
 
@@ -367,9 +373,11 @@ static int dlpar_online_cpu(struct device_node *dn)
 			cpu_maps_update_done();
 			timed_topology_update(1);
 			find_and_online_cpu_nid(cpu, true);
+			cpuremap_map_cpu(thread, i, nid);
 			rc = device_online(get_cpu_device(cpu));
 			if (rc)
 				goto out;
+			cpuremap_reserve_cpu(cpu);
 			cpu_maps_update_begin();
 
 			break;
@@ -541,6 +549,7 @@ static int dlpar_offline_cpu(struct device_node *dn)
 				rc = device_offline(get_cpu_device(cpu));
 				if (rc)
 					goto out;
+				cpuremap_release_cpu(cpu);
 				cpu_maps_update_begin();
 				break;
 

