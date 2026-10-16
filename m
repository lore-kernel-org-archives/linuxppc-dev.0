Return-Path: <linuxppc-dev+bounces-29603-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FBAACC6B38
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Oct 2026 11:06:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j5htP2Wszz3c2G;
	Fri, 16 Oct 2026 22:05:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792148717;
	cv=none; b=UQNbpHRVTj9lvUs1q79tqefure6uikkIMh3rzf6OkDDd8IMgj7GzfIGrmAVRop4rU2AaW5TFMF67PK3JxEfwxTCLamPjDyIFoH54q+lEIVAIkjL0W+uXb1dNLvV8IR3qx9pj0nFWxbQbt401WqXiIvK0dRSHlSAdJrRgWmS+rxAxC+ACjRlZO7L852jdrSzW3R6OXqZzY6iwTkwwgWY+nIbhr1weLd7dRm18kbxKIR/zjR/KpzgloYn3UYKXeXzN00HoaweeaT0gCwFNVTx9vpW9NPKBFmKOlrpdPV6Xiof4qbLwvNhsY3dE+K7aZpDXhX+cgYNXzKOid3GtAw0zew==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792148717; c=relaxed/relaxed;
	bh=3LdbEFi7r4NaTkcBEcyhUB1vIUkbFrOAU/v3p1r9X2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I3Cp6blZP56I1h1EeaKDtDReEDSvCxzjHpdoH1fJxCsZVxDNmFf9udRjThVgwpffqK1iYTS7UjTVqAGjIsYZLpDxvYSQoYr+m6Ewowd84e9i6UmQQp/iFlaRZmkQEJBq32/T0MruD9zt0ehyB59YFUuPB9H4uX5HGBfWv7MAKWE8dcjOUMyxI6sw/SCZTOmJScRH87TgaFWgcftmMH9MJlaADZrmuIFTkgbIn4J0mYkfcF5WWV096p2Cd1mXnPpMTQndkvtpwl4ahb9oeDUO99wuQ4957okoWWAXikLsdb3T7JShasuOwZIM+qvH+KBG8wE3DJ49Bfw5jG8C7LNLYg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=WLw8oWXt; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=srikar@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=WLw8oWXt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=srikar@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j5htN4gMDz3c2F
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Oct 2026 22:05:16 +1100 (AEDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69GAE5iO1774726;
	Fri, 16 Oct 2026 11:05:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=3LdbEFi7r4NaTkcBE
	cyhUB1vIUkbFrOAU/v3p1r9X2k=; b=WLw8oWXtaPaDjy+Gd+pG29ADnQ2NkSDe9
	kk5hbV1pZ2pZgXQoZhkGKp1xv+3K0BB0jWEWacQPtcl3GxJ+NVuVPjN5Vahy8eDD
	ebKRtH2IucGyZWm7v2hff604tMS9yhhhFzsmjA+KmY+zgps9v27flvT+Ttd/JMLF
	RoPm4DGNyWE3/1AWzBT9mKXVKVgmhM/YTfslHG1V6pQxbFjQc+2ZIiW7+rIuB0cJ
	c7gcpJ7S2SwfhSW4yXkiD/eLIl34bubXfC/edqQtc7toCsp0EXPPAfIWPhHtVK+U
	u/Pg70oWpGP4/ehHThd/Q8JeI8Y6e+0Rs5GYttw7MTm9+54oyY4Xg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dwhxweq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 16 Oct 2026 11:05:04 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69GAYpGB3534796;
	Fri, 16 Oct 2026 11:05:03 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h9ypqb2se-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Oct 2026 11:05:01 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69GB4vq36619426
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Oct 2026 11:04:57 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3CC3020040;
	Fri, 16 Oct 2026 11:04:57 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7FCD82004B;
	Fri, 16 Oct 2026 11:04:55 +0000 (GMT)
Received: from sapthagiri.in.ibm.com (unknown [9.123.124.175])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 16 Oct 2026 11:04:55 +0000 (GMT)
From: Srikar Dronamraju <srikar@linux.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
        Madhavan Srinivasan <maddy@linux.ibm.com>, chleroy@kernel.org,
        Srikar Dronamraju <srikar@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] powerpc/numa: Enable coregroup support for shared LPARs
Date: Fri, 16 Oct 2026 16:34:12 +0530
Message-ID: <20261016110412.1380298-8-srikar@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261016110412.1380298-1-srikar@linux.ibm.com>
References: <20261016110412.1380298-1-srikar@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA0MiBTYWx0ZWRfXxNZVbJpFQjTi
 xXMedP2L3qspXb/a1XpPyDul3/Bic2P5SezBAlsGMf/e0zcEO5cqOpp5Sy95djiTcDc+kUW6cmS
 w1PU6whY5KnNZi6ORP3ICW/E+byfOTs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA0MiBTYWx0ZWRfX3bSV21Vsz3jB
 x783BzY8bNa/l32+BdyoFXjQynf+FAMNiSSi+0booy13BlbcbYAIyMOZy/OCGJeYv00XP2wSQJW
 +9EmrTMZKaiKcmiz70xHe3+4D+ueNzI8oP0gIXByCR6FE/JuRLqZpf1wrdI65lZ+7cAR1zOf/5q
 jkxMoiXhE6yRhvQM78EQh+lhmoggmfgtg0kk+rp/Lv7zdLtOmJaaOOFLkFMuyDquiXngFZgcrb6
 xp4V4U3XdgxbATGqQzOwIeFnmB7d5l+XTO9cBfNDEMR2kyVaKd5wQdU6GKO6eUKastE+sBB38Yy
 JNpR9NXw5oYOj3sSDzqy3MpaQhfEku7YQ5PRgGjlodBwuWtZ2+qmKNffRYv8x5bD1QGxKh2Y1gD
 VNj6BfdqTFcHJ1B2zCI7p+TAfEeFHlNFL57U31ebLaaxViHOcs6AMDbWjbE0vFUjVb7otfumiVd
 saQ+BSghCk09btnjjaw==
X-Proofpoint-GUID: sohdhe-9vh2IxJvBOihArff0YZFKHRFE
X-Authority-Analysis: v=2.4 cv=RoFQvymK c=1 sm=1 tr=0 ts=6ad204e0 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=LnY_ip3p0wky2DI6E4oA:9
X-Proofpoint-ORIG-GUID: OnOjFEw8nJcbZEEI1p6HPAA0TLn4mnfg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610160042

Coregroup support is currently disabled for shared LPARs even when the
associativity hierarchy contains the information required to identify
the coregroup level.

The associativity hierarchy differs between shared and dedicated LPARs.
For dedicated LPARs, the hierarchy must extend beyond
primary_domain_index + 1 to contain a coregroup level. Shared LPARs have
one fewer level, so a coregroup is available when the hierarchy extends
beyond primary_domain_index.

Remove the unconditional exclusion of shared processors from coregroup
support and use the appropriate hierarchy when detecting a coregroup
level. Read the coregroup ID from the associativity level immediately
following the primary NUMA domain. If no distinct coregroup ID is
available, fall back to the core ID.

The processor sharing mode is not known when NUMA properties are
initially parsed and is determined later in pSeries_setup_arch().
Therefore, initially process CPU associativity using the existing
dedicated-LPAR interpretation and reprocess it after shared processor
mode is known. During the second pass, only reevaluate coregroup
information and avoid repeating NUMA node and distance initialization.

This allows coregroup topology to be enabled on shared LPARs when the
required associativity information is available.

Signed-off-by: Srikar Dronamraju <srikar@linux.ibm.com>
---
 arch/powerpc/include/asm/topology.h    |  2 ++
 arch/powerpc/kernel/smp.c              |  4 ----
 arch/powerpc/mm/numa.c                 | 28 +++++++++++++++++---------
 arch/powerpc/platforms/pseries/setup.c |  6 ++++++
 4 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/include/asm/topology.h b/arch/powerpc/include/asm/topology.h
index 02c3c9ab3ea9..35230011ef84 100644
--- a/arch/powerpc/include/asm/topology.h
+++ b/arch/powerpc/include/asm/topology.h
@@ -67,6 +67,7 @@ int of_drconf_to_nid_single(struct drmem_lmb *lmb);
 void update_numa_distance(struct device_node *node);
 
 extern void map_cpu_to_node(int cpu, int node);
+void process_cpu_associativity(bool first_pass);
 #ifdef CONFIG_HOTPLUG_CPU
 extern void unmap_cpu_from_node(unsigned long cpu);
 #endif /* CONFIG_HOTPLUG_CPU */
@@ -104,6 +105,7 @@ static inline void update_numa_distance(struct device_node *node) {}
 
 #ifdef CONFIG_SMP
 static inline void map_cpu_to_node(int cpu, int node) {}
+static inline void process_cpu_associativity(bool first_pass) {}
 #ifdef CONFIG_HOTPLUG_CPU
 static inline void unmap_cpu_from_node(unsigned long cpu) {}
 #endif /* CONFIG_HOTPLUG_CPU */
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 6a5a5469aaae..0213ef8d855a 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -1052,10 +1052,6 @@ struct cpumask *cpu_coregroup_mask(int cpu)
 
 static bool has_coregroup_support(void)
 {
-	/* Coregroup identification not available on shared systems */
-	if (is_shared_processor())
-		return 0;
-
 	return coregroup_enabled;
 }
 
diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index fde79f34340e..2a5d94550dc0 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -890,12 +890,15 @@ static int __init numa_setup_drmem_lmb(struct drmem_lmb *lmb,
 }
 
 /*
- * Coregroup info is present in associativity property just after
- * primary_domain_index. In dedicated LPARs, coregroup info is present only
- * if primary_domain_index is third from the last or earlier.
+ * Coregroup information follows the primary NUMA domain in the
+ * associativity hierarchy. Shared LPARs have one fewer associativity
+ * level than dedicated LPARs.
  */
 static bool has_coregroup_level(int index)
 {
+	if (is_shared_processor())
+		return index > primary_domain_index;
+
 	return index > primary_domain_index + 1;
 }
 
@@ -918,7 +921,7 @@ static int detect_and_enable_coregroup(const __be32 *associativity, int index)
 	return -1;
 }
 
-static void process_cpu_associativity(void)
+void process_cpu_associativity(bool first_pass)
 {
 	bool vphn = firmware_has_feature(FW_FEATURE_VPHN);
 	unsigned long i;
@@ -947,15 +950,17 @@ static void process_cpu_associativity(void)
 			associativity = of_get_associativity(cpu);
 		}
 		if (associativity) {
-			nid = associativity_to_nid(associativity);
-			initialize_form1_numa_distance(associativity);
+			if (first_pass) {
+				nid = associativity_to_nid(associativity);
+				initialize_form1_numa_distance(associativity);
+			}
 			index = detect_and_enable_coregroup(associativity, index);
 		}
 		if (cpu)
 			of_node_put(cpu);
 
 		/* node_set_online() is an UB if 'nid' is negative */
-		if (likely(nid >= 0) && numa_enabled)
+		if (first_pass && likely(nid >= 0) && numa_enabled)
 			node_set_online(nid);
 	}
 }
@@ -990,7 +995,7 @@ static int __init parse_numa_properties(void)
 	 * init, we need to know the node ids now. This is because
 	 * each node to be onlined must have NODE_DATA etc backing it.
 	 */
-	process_cpu_associativity();
+	process_cpu_associativity(true);
 
 	if (numa_enabled == 0) {
 		pr_warn("disabled by user\n");
@@ -1463,12 +1468,15 @@ int cpu_to_coregroup_id(int cpu)
 		goto out;
 
 	index = of_read_number(associativity, 1);
-	if (index > primary_domain_index + 1)
-		coregroup_id = of_read_number(&associativity[index - 1], 1);
+	if (has_coregroup_level(index))
+		coregroup_id = (int)of_read_number(&associativity[primary_domain_index + 1], 1);
 
 out:
 	if (cpunode)
 		of_node_put(cpunode);
 
+	if (coregroup_id == -1)
+		return cpu_to_core_id(cpu);
+
 	return coregroup_id;
 }
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index f29e7547c995..fd8163200b97 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -874,6 +874,12 @@ static void __init pSeries_setup_arch(void)
 
 		if (lppaca_shared_proc()) {
 			static_branch_enable(&shared_processor);
+
+			/*
+			 * Reprocess CPU associativity now that the shared
+			 * LPAR hierarchy can be interpreted correctly.
+			 */
+			process_cpu_associativity(false);
 			pv_spinlocks_init();
 #ifdef CONFIG_PARAVIRT_TIME_ACCOUNTING
 			static_key_slow_inc(&paravirt_steal_enabled);
-- 
2.47.1


