Return-Path: <linuxppc-dev+bounces-21435-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB316CD5BB8
	for <linuxppc-dev@archiver.kernel.org>; Sun, 24 May 2026 01:01:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gNLLM6h4gz2y8F;
	Sun, 24 May 2026 11:01:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779584475;
	cv=none; b=cMr3G3VTw6mW6yRUI7eRyLjeZtGVlFy7YeusGKkA/1hKJexOhI135EbDZETest+2LnqBpUjoz83QxcVfrxcnV2Rfhnoxu7tPAdmP0tpT9I7HKVUT1CwU8BjXP0t6QWoN7p7QOO6b5+UDtN/U2QtMrFv9JAGjg3juADL7vEEQ3VMThdJzI1MZb0wYAJ2UuvHmfdJ3ImeZaAhrRpy+0mjFSo9kWgk8TmaC/y9/bG/bXc3SELb7DezAc2Paj1X+2BM95K0i4xG7yMmACM9N7JGC7bAeN4qXnYFJBV+HEqSRd0mOnbFobfoz9TtIG9LblqBsb3DWRy7DhQbcx9EYoN7TsA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779584475; c=relaxed/relaxed;
	bh=hHW9Wj/5VODh1SWTWM+Id/tKlDd4cRVY/52KqnLtVT4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TXqhbawXeYY9nM7ylIYDp0qcP8PygQaJQ2ZIC50nQnB6tB78deVdZSJyFf7B1RSqr5SQ4Q/UdlXlx4jiTBfNr2fFw8l801Ps3KJIZ1mdvIvg3fUoEy/OiE21swTPWP98Rd+d6HN16y0IFBN9nuMo2ChcmmcQDuuKr4kcULxA7pivU9f7O8jjhAWa6OcsCJViUvwccqlRmmm+TqVmbFcZShZL7g3v7GfF5VtHYsd6qv9XIvRurBGk9TrRFeYtwXdtBzFeDiwZPXn83+z0s/WnIm0x+kfN/canFFs0SMlEbuMCLeGZgwBwN11jXkaH3qZWAkXdGamgQRjg8UpiPW40lw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=aGRpfP7K; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=srikar@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=aGRpfP7K;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=srikar@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gNLLL3w4yz2xmX
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 May 2026 11:01:13 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64NLFEVH2975700;
	Sun, 24 May 2026 01:00:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=hHW9Wj/5VODh1SWTWM+Id/tKlDd4cRVY/52KqnLtV
	T4=; b=aGRpfP7Kl3Pb0AFYWGzBGOK8t/VvYoBLuOoVaYBodzK/32LLIy2H//h21
	sglPb5KnEQl8D6p6+l9Yb3TZ1V0fQfi3+6T/95bpAsYyMTPsUWRxlP0ApYSp1hiS
	QGLoO/z+1w3bgBVmtYnBX1/JPgghlI4CPLdc/n4+Aswfvkp0aaBt6y1PdVC/wBI/
	qbGbqYDJ2o2BV7Y1sPLlYRFJtH0TrgXXhHS2cZ4nNtRz7RKSI2COE8B9l/QZ1F5F
	Lte2u/kmv/n/v2mHai+l9WVY927S7TW6itKX48pc7W1YkyOCU4CQ7BqEjWoYaJ3h
	rsHglKFsRPWnaSHI/zkRiwo9vxx6Q==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4s22k7y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 24 May 2026 01:00:54 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64O0sbbP024433;
	Sun, 24 May 2026 01:00:53 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ebpxvr1ge-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 24 May 2026 01:00:53 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64O10oIb55247120
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 24 May 2026 01:00:50 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EA30720040;
	Sun, 24 May 2026 01:00:49 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 70F2B2004E;
	Sun, 24 May 2026 01:00:39 +0000 (GMT)
Received: from sapthagiri.in.ibm.com (unknown [9.124.216.197])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 24 May 2026 01:00:38 +0000 (GMT)
From: Srikar Dronamraju <srikar@linux.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Naveen N Rao <naveen@kernel.org>
Cc: skiboot@lists.ozlags.org, arbab@linux.ibm.com, mahesh@linux.ibm.com,
        Srikar Dronamraju <srikar@linux.ibm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/topology: Support coregroup in PowerNV
Date: Sun, 24 May 2026 06:30:16 +0530
Message-ID: <20260524010017.140408-1-srikar@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 5daLFSEkpV9yLk-u2u30F6H9ClthKV0C
X-Authority-Analysis: v=2.4 cv=Sq2gLvO0 c=1 sm=1 tr=0 ts=6a124dc7 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=pykYN6zyk8JDSz1IcOYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI0MDAwMyBTYWx0ZWRfX6e9hes49WYua
 cC0fapyLbaIBO0EhV71WJHS1UMpihHcQM0gqTBr3VkCTRQOeskvuBv6nLfS6J1Pvic6TlXB7x7Y
 go01fOW8m9GZTd/IvAWw2Mu7k0Wi5z9p+TXajA8XZhJoXCQ/VmgAyNrkHyHsAy54l7AjTpT/lkp
 8LIYrIWtV9odBiVssPWXQoPD9pK7yb4pJ9AA8RhU1mDeaCyDqkJATs3imT941xMGe2BZNku6chd
 oKsZXN6UKF5yQZqABN0EuIBTF3GKRjpThA3WC+4Oof50ZawfkgsvZA4d9xU3D+2fA1hbFZozrf9
 sGPAM0HZRBWByL3wO5h/EDG1AXMWwveybQw2/rWv6gcYQt/FGA72vlHfmLFexBfrPw30hQDDf0b
 K+ReGHBaTAdsxffDzkXRGKV1KMveH9yoZnnNJDSHLvBNcWYarZBqqP1zTnDoa0nX+RvBDpHWPpC
 E3uQB4OIBKMnq4hnylw==
X-Proofpoint-ORIG-GUID: UOKdNpov0HS2Kf8zjwjIJDsE4EsU72PP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-23_07,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 clxscore=1011 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605240003

Coregroup support was only available on PowerPC on PowerVM LPARs.
However if firmware were to expose coregroup-id to the kernel, then
coregroup can even be supported on PowerNV too.

PowerPC Linux kernel will detect support for coregroup by looking at the
primary_domain_index. Till now on PowerNV systems, primary_domain_index
has been the penultimate domain in cpunode ibm,associativity device-tree
property. This would be taken as hint that coregroup support is not
available in the firmware.

If on PowerNV systems, primary_domain_index is not the penultimate
domain in cpunode ibm,associativity device-tree property, then it would
be taken as a hint that coregroup support is available in the firmware.

This logic makes it compatible with PowerVM Systems, where
primary_domain_index is not the penultimate domain in cpunode
ibm,associativity device-tree property.

$ lscpu
Architecture:        ppc64le
Byte Order:          Little Endian
CPU(s):              480
On-line CPU(s) list: 0-479
Thread(s) per core:  8
Core(s) per socket:  15
Socket(s):           4
NUMA node(s):        4
Model:               2.0 (pvr 0080 0200)
Model name:          POWER10, altivec supported
CPU max MHz:         3249.0000
CPU min MHz:         3249.0000
L1d cache:           32K
L1i cache:           48K
L2 cache:            1024K
L3 cache:            4096K
NUMA node0 CPU(s):   0-119
NUMA node1 CPU(s):   120-239
NUMA node2 CPU(s):   240-359
NUMA node3 CPU(s):   360-479

with-out patched firmware and/or Linux-kernel
---------------------------------------------
$ grep -h -r . /sys/devices/system/cpu/*/topology/die_id |sort | uniq -c | sort -n -r
    120 27
    120 18
    120 9
    120 0

$ grep -h -r . /sys/devices/system/cpu/*/topology/die_cpus_list |sort | uniq -c | sort -n -r
    120 360-479
    120 240-359
    120 120-239
    120 0-119

with patched firmware and Linux-kernel
--------------------------------------
grep -h -r . /sys/devices/system/cpu/*/topology/die_id |sort | uniq -c | sort -n -r
     64 6
     64 4
     64 2
     64 0
     56 7
     56 5
     56 3
     56 1
grep -h -r . /sys/devices/system/cpu/*/topology/die_cpus_list |sort | uniq -c | sort -n -r
     64 360-375,392-407,424-439,456-471
     64 240-255,272-287,296-311,328-343
     64 120-135,152-167,184-199,208-223
     64 0-15,32-47,64-79,88-103
     56 376-391,408-423,440-455,472-479
     56 256-271,288-295,312-327,344-359
     56 16-31,48-63,80-87,104-119
     56 136-151,168-183,200-207,224-239

Observation:
Without the patched kernel and/or skiboot, die-id and numa were same.
With patched kernel and/or skiboot, we see 2 die-id per node.
Signed-off-by: Srikar Dronamraju <srikar@linux.ibm.com>
---
 arch/powerpc/include/asm/topology.h | 15 +++--
 arch/powerpc/mm/numa.c              | 87 ++++++++++++++++++++++-------
 2 files changed, 73 insertions(+), 29 deletions(-)

diff --git a/arch/powerpc/include/asm/topology.h b/arch/powerpc/include/asm/topology.h
index 66ed5fe1b718..568e6bc55726 100644
--- a/arch/powerpc/include/asm/topology.h
+++ b/arch/powerpc/include/asm/topology.h
@@ -71,6 +71,7 @@ extern void map_cpu_to_node(int cpu, int node);
 extern void unmap_cpu_from_node(unsigned long cpu);
 #endif /* CONFIG_HOTPLUG_CPU */
 
+extern int cpu_to_coregroup_id(int cpu);
 #else
 
 static inline int early_cpu_to_node(int cpu) { return 0; }
@@ -107,14 +108,6 @@ static inline void map_cpu_to_node(int cpu, int node) {}
 static inline void unmap_cpu_from_node(unsigned long cpu) {}
 #endif /* CONFIG_HOTPLUG_CPU */
 #endif /* CONFIG_SMP */
-
-#endif /* CONFIG_NUMA */
-
-#if defined(CONFIG_NUMA) && defined(CONFIG_PPC_SPLPAR)
-void find_and_update_cpu_nid(int cpu);
-extern int cpu_to_coregroup_id(int cpu);
-#else
-static inline void find_and_update_cpu_nid(int cpu) {}
 static inline int cpu_to_coregroup_id(int cpu)
 {
 #ifdef CONFIG_SMP
@@ -124,6 +117,12 @@ static inline int cpu_to_coregroup_id(int cpu)
 #endif
 }
 
+#endif /* CONFIG_NUMA */
+
+#if defined(CONFIG_NUMA) && defined(CONFIG_PPC_SPLPAR)
+void find_and_update_cpu_nid(int cpu);
+#else
+static inline void find_and_update_cpu_nid(int cpu) {}
 #endif /* CONFIG_NUMA && CONFIG_PPC_SPLPAR */
 
 #include <asm-generic/topology.h>
diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index f4cf3ae036de..9b45cc9e1f27 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -432,7 +432,7 @@ static void __init initialize_form2_numa_distance_lookup_table(void)
 
 static int __init find_primary_domain_index(void)
 {
-	int index;
+	int index = -1;
 	struct device_node *root;
 
 	/*
@@ -502,12 +502,9 @@ static int __init find_primary_domain_index(void)
 		distance_ref_points_depth = MAX_DISTANCE_REF_POINTS;
 	}
 
-	of_node_put(root);
-	return index;
-
 err:
 	of_node_put(root);
-	return -1;
+	return index;
 }
 
 static void __init get_n_mem_cells(int *n_addr_cells, int *n_size_cells)
@@ -892,12 +889,32 @@ static int __init numa_setup_drmem_lmb(struct drmem_lmb *lmb,
 	return 0;
 }
 
+/*
+ * If hierarchy extends beyond primary_domain_index + 1, then next
+ * level corresponds to coregroup.
+ */
+static int detect_and_enable_coregroup(const __be32 *associativity, int index)
+{
+	if (!associativity)
+		return -1;
+
+	if (!index) {
+		index = of_read_number(associativity, 1);
+
+		if (index > primary_domain_index + 1)
+			coregroup_enabled = 1;
+		else
+			index = -1;
+	}
+	return index;
+}
+
 static int __init parse_numa_properties(void)
 {
 	struct device_node *memory, *pci;
-	int default_nid = 0;
-	unsigned long i;
+	int default_nid = 0, index = 0;
 	const __be32 *associativity;
+	unsigned long i;
 
 	if (numa_enabled == 0) {
 		pr_warn("disabled by user\n");
@@ -930,7 +947,6 @@ static int __init parse_numa_properties(void)
 	 */
 	for_each_present_cpu(i) {
 		__be32 vphn_assoc[VPHN_ASSOC_BUFSIZE];
-		struct device_node *cpu;
 		int nid = NUMA_NO_NODE;
 
 		memset(vphn_assoc, 0, VPHN_ASSOC_BUFSIZE * sizeof(__be32));
@@ -938,7 +954,10 @@ static int __init parse_numa_properties(void)
 		if (__vphn_get_associativity(i, vphn_assoc) == 0) {
 			nid = associativity_to_nid(vphn_assoc);
 			initialize_form1_numa_distance(vphn_assoc);
+			if (!index)
+				index = detect_and_enable_coregroup(vphn_assoc, index);
 		} else {
+			struct device_node *cpu;
 
 			/*
 			 * Don't fall back to default_nid yet -- we will plug
@@ -951,6 +970,8 @@ static int __init parse_numa_properties(void)
 			associativity = of_get_associativity(cpu);
 			if (associativity) {
 				nid = associativity_to_nid(associativity);
+				if (!index)
+					index = detect_and_enable_coregroup(associativity, index);
 				initialize_form1_numa_distance(associativity);
 			}
 			of_node_put(cpu);
@@ -1431,9 +1452,26 @@ void find_and_update_cpu_nid(int cpu)
 	pr_debug("%s:%d cpu %d nid %d\n", __func__, __LINE__, cpu, new_nid);
 }
 
+static int topology_update_init(void)
+{
+	topology_inited = 1;
+	return 0;
+}
+device_initcall(topology_update_init);
+
+#else
+static long vphn_get_associativity(unsigned long cpu,
+					__be32 *associativity)
+{
+	return -1;
+}
+#endif /* CONFIG_PPC_SPLPAR */
+
 int cpu_to_coregroup_id(int cpu)
 {
-	__be32 associativity[VPHN_ASSOC_BUFSIZE] = {0};
+	int coregroup_id = cpu_to_core_id(cpu);
+	struct device_node *cpunode = NULL;
+	const __be32 *associativity;
 	int index;
 
 	if (cpu < 0 || cpu > nr_cpu_ids)
@@ -1442,24 +1480,31 @@ int cpu_to_coregroup_id(int cpu)
 	if (!coregroup_enabled)
 		goto out;
 
-	if (!firmware_has_feature(FW_FEATURE_VPHN))
-		goto out;
+	if (firmware_has_feature(FW_FEATURE_VPHN)) {
+		__be32 tmp[VPHN_ASSOC_BUFSIZE] = {0};
 
-	if (vphn_get_associativity(cpu, associativity))
+		if (vphn_get_associativity(cpu, tmp))
+			goto out;
+
+		associativity = tmp;
+
+	} else {
+		cpunode = of_get_cpu_node(cpu, NULL);
+		if (!cpunode)
+			goto out;
+
+		associativity = of_get_associativity(cpunode);
+	}
+	if (!associativity)
 		goto out;
 
 	index = of_read_number(associativity, 1);
 	if (index > primary_domain_index + 1)
-		return of_read_number(&associativity[index - 1], 1);
+		coregroup_id = of_read_number(&associativity[index - 1], 1);
 
 out:
-	return cpu_to_core_id(cpu);
-}
+	if (cpunode)
+		of_node_put(cpunode);
 
-static int topology_update_init(void)
-{
-	topology_inited = 1;
-	return 0;
+	return coregroup_id;
 }
-device_initcall(topology_update_init);
-#endif /* CONFIG_PPC_SPLPAR */
-- 
2.43.0


