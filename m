Return-Path: <linuxppc-dev+bounces-26444-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AA1CC61DD6
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Sep 2026 12:36:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hZhzt6p0Lz2ygW;
	Wed, 02 Sep 2026 22:36:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788352586;
	cv=none; b=NoWK67eWE64UAh2s6t60RaC4nCGrvbrYowPOgqJGAojWxuuCj83NeDV3sq2PAssW0LC9joGvTM19O6liNUzNGvZvcyEQFn0Db9I5fIaM5dfge+C+pHiwRJk/GS4QiFfXiybW1rIjgSa6Yx8dlIxUdI589HHiqy+y6Z8TViRdwNv0pIt4K3qSOE43qcoD2FXWa76riHawcFsHLfpdp1ki5Z90dokIqv1FYwK3U3USWbi8HfuTxoKDoXTb/RSUcRa/lJt5DDo3boGXZLpeBZeWluuYThDBmpM3csjK1AP70u/UFGMrcu0Kxhu44hj7PonvLjZdj9douYtMyMW/Ix1UFw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788352586; c=relaxed/relaxed;
	bh=7IIJl6NptEGLqv3O332pxWQNoSbLPfqSdAaI7fpiArM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GI219NZKFGyuoGhhDNih7Kakx8hKhHlLKZ8/88QDHoiS7zN1MO2T2RKmQkN5jMZ4DXPhFke29eHniBcAOjZU8VjrKMzeR5Ie/tOVeBRr6h9YHKOd+CrWLIKY5fKUDaQWV2EKmiY7MFXtOX3CgczkXD98JNshlTxbz28H+tXo2A/3KwLkPYh5fO0jL0f82VKGUmETQ/gvSVlLFUUqNiFAooC5Uia25YuUzhFZdxqnmKT2aOS+uAH6SYxodJ76YQXQz//jMa8g1cBpTl2O8aaWPYlCcVPFcWYklreK+kdoUCWQLAH8o6defqwKfvLKn1/oT/3e2zgtkcaZyMBt/pL1Lw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=eLPsNe6z; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=srikar@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=eLPsNe6z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=srikar@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZhzt1F6fz2xpn;
	Wed, 02 Sep 2026 22:36:26 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682CVvgb4189812;
	Wed, 2 Sep 2026 12:36:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=7IIJl6NptEGLqv3O3
	32pxWQNoSbLPfqSdAaI7fpiArM=; b=eLPsNe6zTiQZnblEIXdehTtGw7y+o7R57
	ZbTAs2zjd/5SN6vQ3eKQQTGaK87PAcxzrGO4OBlgBFVxyCyd9u3+7cWMKJuEQuRn
	BkvBJvi+wKH5gfLXlV5GwC9id9d373AyUuT5r3UarFWQAQ1L0SgzAFe3xTo11HJY
	3YYyj779nFib4VelaOwTCh8RTnB3Om+6OAwB5FHKzR2yVhSS8AduHBVhnve/xE5Q
	thZA+53bXp96gBdwC3Ez/4hrl8Dwp+shKD9s0CW3sZBezP8D9ftdWtLkvI4xQ0dS
	96uEMBGLi17ymOXd0eRjWhgYOcE5qlMq/LA7b3yReqRGdBCwATwNg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbpx5pd4w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 12:36:16 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 682CU1Ko024915;
	Wed, 2 Sep 2026 12:36:15 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gecjaj06s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 12:36:14 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 682CaBWs45351244
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 2 Sep 2026 12:36:11 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1330F20043;
	Wed,  2 Sep 2026 12:36:11 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 95EF220040;
	Wed,  2 Sep 2026 12:36:07 +0000 (GMT)
Received: from sapthagiri.in.ibm.com (unknown [9.111.3.140])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  2 Sep 2026 12:36:07 +0000 (GMT)
From: Srikar Dronamraju <srikar@linux.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: skiboot@lists.ozlabs.org, arbab@linux.ibm.com, mahesh@linux.ibm.com,
        Srikar Dronamraju <srikar@linux.ibm.com>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] powerpc/numa: Support coregroup on PowerNV
Date: Wed,  2 Sep 2026 18:05:02 +0530
Message-ID: <20260902123458.340456-8-srikar@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902123458.340456-5-srikar@linux.ibm.com>
References: <20260902123458.340456-5-srikar@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=PPc/P/qC c=1 sm=1 tr=0 ts=6a981840 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=u_kndASixH3PHailIgsA:9
X-Proofpoint-GUID: kgKufkxNVk9NICCj_KNRw_NkD8U29rmV
X-Proofpoint-ORIG-GUID: Qv5cfG1dpNSRU1XJZcjAxmR2O5qqDbq3
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDExMSBTYWx0ZWRfX+5zvhwMaQSqP
 77JLQTdnW6rkhp/UX0NQIBjuxdyTxqY9JIk4IyC/3GgbPuwHW239Z1KEVFoSPO+857+YF6ooNLl
 FeXSRvuHgayQ9uQA47yrdhpxWmuT1d8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDExMSBTYWx0ZWRfX2tjWiW6HnWgT
 0YCtDiOAyemn21EMq5jHICEDLr8lIlesyVNMLp4uJI2uHT2lo1QzfznM0UFYtVUe6D6nY34AnVq
 uZPBsja5wBR2NjUzsxyPM/MwrwEagub7i6SwUrWTlGZOKiYKDuQKrOuDSAu91SC/5ed0xO9DpQq
 0jC9elG74Zcup6vAGSL+mYKARAhiBqFxHUQ4lDIlqY7hbbLkunVU8F3Aj60mq8cQ1m1iX4QwX0w
 hhsI2dK1PB4jIQvCPxnnIUfa/eJPv/zuQ/+rSXHyP4BCtxMlbE4rNXvyOMhX2bGcvdKSagypsKV
 47p6/PhvFxO3K5ooL6k4urMb+DqZ9Ois29+PrMYFXa1PKDSO4FMILpcR+PskfPU86OS11wJv/eU
 2/gtrka9uxvMD7fGpAIbou9jI31YAzrrDmJdj3kmhyEui+tLnVzUSSWYJ3AasFV0/5DBioxkoUH
 sFCeet+y+vN1zn9McBw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_03,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609020111

Coregroup support on powerpc has so far been limited to PowerVM LPARs.
However, PowerNV can also support coregroups when firmware exposes the
required coregroup information through the associativity hierarchy.

Detect coregroup support by checking whether primary_domain_index is the
penultimate domain in the CPU node's ibm,associativity property. On
PowerNV, a non-penultimate primary_domain_index indicates that firmware
provides an additional level for coregroup information.

This keeps the logic compatible with PowerVM systems, where
primary_domain_index is likewise not the penultimate associativity
domain.

Signed-off-by: Srikar Dronamraju <srikar@linux.ibm.com>
---
Changelog from v2:
- Handle comments from Ritesh (one hunk needed to be moved from patch 2 to
  patch 3 to build correctly)

Changelog from v1: https://lkml.kernel.org/r/20260524010017.140408-1-srikar@linux.ibm.com
- Handle comments from Christophe Leroy; make code more flat

 arch/powerpc/mm/numa.c | 58 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 48 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 5f326b005a2a..e97b624203ea 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -889,12 +889,32 @@ static int __init numa_setup_drmem_lmb(struct drmem_lmb *lmb,
 	return 0;
 }
 
+/*
+ * If hierarchy extends beyond primary_domain_index + 1, then next
+ * level corresponds to coregroup.
+ */
+static int detect_and_enable_coregroup(const __be32 *associativity, int index)
+{
+	if (!associativity || index == -1)
+		goto out;
+
+	index = of_read_number(associativity, 1);
+
+	if (index > primary_domain_index + 1) {
+		coregroup_enabled = 1;
+		return index;
+	}
+out:
+	coregroup_enabled = 0;
+	return -1;
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
@@ -927,7 +947,6 @@ static int __init parse_numa_properties(void)
 	 */
 	for_each_present_cpu(i) {
 		__be32 vphn_assoc[VPHN_ASSOC_BUFSIZE];
-		struct device_node *cpu;
 		int nid = NUMA_NO_NODE;
 
 		memset(vphn_assoc, 0, VPHN_ASSOC_BUFSIZE * sizeof(__be32));
@@ -935,7 +954,9 @@ static int __init parse_numa_properties(void)
 		if (__vphn_get_associativity(i, vphn_assoc) == 0) {
 			nid = associativity_to_nid(vphn_assoc);
 			initialize_form1_numa_distance(vphn_assoc);
+			index = detect_and_enable_coregroup(vphn_assoc, index);
 		} else {
+			struct device_node *cpu;
 
 			/*
 			 * Don't fall back to default_nid yet -- we will plug
@@ -948,6 +969,7 @@ static int __init parse_numa_properties(void)
 			associativity = of_get_associativity(cpu);
 			if (associativity) {
 				nid = associativity_to_nid(associativity);
+				index = detect_and_enable_coregroup(associativity, index);
 				initialize_form1_numa_distance(associativity);
 			}
 			of_node_put(cpu);
@@ -1445,7 +1467,9 @@ static long vphn_get_associativity(unsigned long cpu,
 
 int cpu_to_coregroup_id(int cpu)
 {
-	__be32 associativity[VPHN_ASSOC_BUFSIZE] = {0};
+	int coregroup_id = cpu_to_core_id(cpu);
+	struct device_node *cpunode = NULL;
+	const __be32 *associativity;
 	int index;
 
 	if (cpu < 0 || cpu > nr_cpu_ids)
@@ -1454,17 +1478,31 @@ int cpu_to_coregroup_id(int cpu)
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
 
+	return coregroup_id;
+}
-- 
2.43.7


