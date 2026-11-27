Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBB9606A32C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Nov 2026 15:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=EySxQzli
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jbcd90gc6z30dj;
	Sat, 28 Nov 2026 02:23:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795793021;
	cv=none; b=W4oJG9uDzcV05oVCUp5HnzD9gbFcbaAahHWSCDhJIpJYkPgc428nnJuJfGhDm5KPnab9OvXu/JNvxAniPnZvAQ3Ut9MhaM52fk7ykec/AQ6DeV3dNLZessf506/dEQgEsPivkCLA4FkGvkKDOGQH9D9j8kcfl8AshBpvWyGbl4lMLTJjhoj8FVjOUciraQAMDbyXqMNMCwksskqDjsgeasqS7ZDjCGItR4+vp0gtLmGTqqG3L8kMWE6UcPFxTor+9L4VeFnLO3hsuDO6ePx0mlInJ0phsDWwvEGSM/TE77a13MO27WeWVMjqr830jdrSJEa6iL/W3AUpSD/6iCCmhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795793021; c=relaxed/relaxed;
	bh=GikI0QYq6+kifLTocGiWuTnJ1tNj32BFxwWIkhXSL4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LMEO2dl18pSNPcjxXduodd1Hc2TGVCeaQKz0XrobTKBDPvyMi5RnEhEjww9zIsKpLvVrSDq6ZRi1a1qunbWvcd+L4WC1iV6saMUGy0BoFXY/XAflCnWBZ9rNJPj55zNn3qp4S21+ITQb0x5kkf99V3zyGUB7g0CDzDwn0mcr4OkV8+pubm/dUWPp6XPpOab4Bo0J7Ywq2rESmiIu+QgB/NspH53iOmCQwohUXUWBDrCDcQ8r0zLsDeb50u1i+uu86BTNgU/OMJgAzsfxLb3heDjQMKM+1+QHgYd6tF7RPGxVU2MkfGTsyTqVi6P+SCkC5oLhIeJT+Ns6JgmPi9awaw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=EySxQzli; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=EySxQzli;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jbcd821wsz2ySc
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Nov 2026 02:23:40 +1100 (AEDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARE4fpU3234322;
	Fri, 27 Nov 2026 15:23:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=GikI0QYq6+kifLToc
	GiWuTnJ1tNj32BFxwWIkhXSL4Q=; b=EySxQzlimAdD6fZD0m10kTUB35nEcJE26
	ZgO2Iy8iUT1OFbAv1OPcsHSLKbkZ08ySVviMdD7nWDmJx9T4EaqOKGPVyzq+138j
	UbSAKkOHYzO9YLtcORd/niqqcxttNp18E3K1kJlpXE8PETbXcoEgEiQSuhUwfeeE
	pDx5JOR3ctV66zZIkX9+ESqECKVKQGU/cDKzI1VNZS6d1FaKnY3kux2ukLRlaQWZ
	z90X5+sMHqSXHtEm5cN3lrRffA1HeqWuLTQMY45Zx7jg2Ub7reyhoVE2KuTyV33M
	+2txHQf6AYgnfkrwzqzrc2dZCAtHkPiJj2Pv6+9jIT0l81WA7Cy4g==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34gvnpm2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 15:23:04 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARE4FLO3892937;
	Fri, 27 Nov 2026 15:23:03 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j6uccu3xs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 15:23:03 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ARFMx8v55575028
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Nov 2026 15:22:59 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A81D22004B;
	Fri, 27 Nov 2026 15:22:59 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5CDB620040;
	Fri, 27 Nov 2026 15:22:54 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.39.16.105])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Nov 2026 15:22:54 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, driver-core@lists.linux.dev
Cc: sshegde@linux.ibm.com, christophe.leroy@csgroup.eu, ritesh.list@gmail.com,
        tim.c.chen@linux.intel.com, yu.c.chen@intel.com,
        gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
        johan@kernel.org, sudeep.holla@kernel.org, peterz@infradead.org,
        tglx@kernel.org, kprateek.nayak@amd.com, srikar@linux.ibm.com
Subject: [PATCH v2 1/6] cacheinfo: Allow architectures to provide custom cache IDs
Date: Fri, 27 Nov 2026 20:52:37 +0530
Message-ID: <20261127152242.306333-2-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261127152242.306333-1-sshegde@linux.ibm.com>
References: <20261127152242.306333-1-sshegde@linux.ibm.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=CYCdd7rl c=1 sm=1 tr=0 ts=6b09a058 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=77fLFVlFV3kl4jyPEUwA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA2MCBTYWx0ZWRfX9k6tSI076u9y
 kRJn5XzhhlKCiq7TWrgWF2T9MYw7Hiuq8QzFJO2Gt4aq+spqEd1cbr3DdDpuvS9NBdx3fFnklvB
 01FMM55CPIaguXfYA0OvVBz3okfY61Q=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA2MCBTYWx0ZWRfX1DEpG1BJXs6M
 C5BBydmqls8GefGVnvX3Nqt9dz1OrQvU3wxJl6kgPbuXcjdAsIMeV17a2nZaeFYTQf7vOcAcw0V
 IeSYbzBiN+RwBS5uc0hLW+YKUKP6ZRwIE2VvZsCBqAthDSnIz+5ObQo1na6jXQSWnCr3qewK4P0
 oHOmSAYtGfEzgPd9W96g/MyPgE+HF5zz6qszJC+Ewfpl+suI+EeQC2X557F1c122Zr/q/qU3WN8
 rmHBI2Ltwvcx+YmYkqWigGtnUUkJlbQmP0hEvIgwXHYzh3cAdeeg/neOHsoxXrgm/6G5YIbqXD4
 gL2eAxgAFwkvCHUAJMTqLikLwC9DMA+EMRQotQncJsIMBqrqfxXxAu4pHTN0jaY+V65Ert93g+E
 GzAGsB4SVj/oLetoWJmJdldqHDSXSdEbIcdOtFOITF3q88zwaM/1WVifurvfE0fRUdQZbZucwit
 LA/e5C96PpB/3NZPHkQ==
X-Proofpoint-ORIG-GUID: m5FkjCHmoI9Jt-2mZyLAIHagshm2K40_
X-Proofpoint-GUID: OhHw4PqEfsOWr59Oyi0227E8FFQgzyex
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611270060
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On PowerPC, a firmware cache node does not always correspond to a single
hardware cache instance.

For example, a Power11 CPU device-tree node can describe eight threads
and refer to one L2 and L3 cache-node chain:

  CPU node (0-7)
    l2-cache = <L2 node>

  L2 node
    l2-cache = <L3 node>

At the same time, the ibm,thread-groups property divides those threads
into two groups, such as:

  0,2,4,6
  1,3,5,7

Each group represents a separate hardware cache instance, even though
both groups refer to the same firmware L2 and L3 cache nodes.

Generic cacheinfo currently derives the cache ID from the firmware cache
node. It would therefore assign the same ID to both groups and incorrectly
represent all eight threads as sharing one cache.

Allow an architecture to provide the cache ID for a CPU and cache level.
When the architecture supplies an ID, use it instead of deriving one from
the firmware cache node. Otherwise, retain the existing generic behavior.

[Both draft changelog and code are written by LLM under guidance]
Assisted-by: LLM
Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 drivers/base/cacheinfo.c  | 43 +++++++++++++++++++++++++++++++--------
 include/linux/cacheinfo.h |  1 +
 2 files changed, 35 insertions(+), 9 deletions(-)

diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index eb8a907f6d50..10a9bbce899e 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -243,22 +243,46 @@ static bool match_cache_node(struct device_node *cpu,
 #define arch_compact_of_hwid(_x)	(_x)
 #endif
 
+/*
+ * Return an architecture-specific cache ID for @cpu and @level.
+ *
+ * Return 0 and store the ID in @id when the architecture provides the
+ * cache identity. Return an error to use the generic firmware-derived
+ * cache ID instead.
+ *
+ * The ID must uniquely identify a cache among caches of the same level
+ * and type.
+ */
+int __weak cacheinfo_get_arch_id(unsigned int cpu, unsigned int level,
+				 unsigned int *id)
+{
+	return -ENOENT;
+}
+
 static void cache_of_set_id(struct cacheinfo *this_leaf,
-			    struct device_node *cache_node)
+			    struct device_node *cache_node,
+			    unsigned int cpu)
 {
-	struct device_node *cpu;
+	struct device_node *cpu_node;
 	u32 min_id = ~0;
+	unsigned int arch_id;
+
+	if (!cacheinfo_get_arch_id(cpu, this_leaf->level, &arch_id)) {
+		this_leaf->id = arch_id;
+		this_leaf->attributes |= CACHE_ID;
+		return;
+	}
 
-	for_each_of_cpu_node(cpu) {
-		u64 id = of_get_cpu_hwid(cpu, 0);
+	for_each_of_cpu_node(cpu_node) {
+		u64 id = of_get_cpu_hwid(cpu_node, 0);
 
 		id = arch_compact_of_hwid(id);
 		if (FIELD_GET(GENMASK_ULL(63, 32), id)) {
-			of_node_put(cpu);
+			of_node_put(cpu_node);
 			return;
 		}
 
-		if (match_cache_node(cpu, cache_node))
+		if (match_cache_node(cpu_node, cache_node))
 			min_id = min(min_id, id);
 	}
 
@@ -269,7 +293,8 @@ static void cache_of_set_id(struct cacheinfo *this_leaf,
 }
 
 static void cache_of_set_props(struct cacheinfo *this_leaf,
-			       struct device_node *np)
+			       struct device_node *np,
+			       unsigned int cpu)
 {
 	/*
 	 * init_cache_level must setup the cache level correctly
@@ -283,7 +308,7 @@ static void cache_of_set_props(struct cacheinfo *this_leaf,
 	cache_get_line_size(this_leaf, np);
 	cache_nr_sets(this_leaf, np);
 	cache_associativity(this_leaf);
-	cache_of_set_id(this_leaf, np);
+	cache_of_set_id(this_leaf, np, cpu);
 }
 
 static int cache_setup_of_node(unsigned int cpu)
@@ -309,7 +334,7 @@ static int cache_setup_of_node(unsigned int cpu)
 			if (!np)
 				break;
 		}
-		cache_of_set_props(this_leaf, np);
+		cache_of_set_props(this_leaf, np, cpu);
 		this_leaf->fw_token = np;
 		index++;
 	}
diff --git a/include/linux/cacheinfo.h b/include/linux/cacheinfo.h
index 56fa646df0d1..d3557a1b464b 100644
--- a/include/linux/cacheinfo.h
+++ b/include/linux/cacheinfo.h
@@ -93,6 +93,7 @@ bool last_level_cache_is_shared(unsigned int cpu_x, unsigned int cpu_y);
 struct cacheinfo *get_cpu_cacheinfo_llc(unsigned int cpu);
 int fetch_cache_info(unsigned int cpu);
 int detect_cache_attributes(unsigned int cpu);
+int cacheinfo_get_arch_id(unsigned int cpu, unsigned int level, unsigned int *id);
 #ifndef CONFIG_ACPI_PPTT
 /*
  * acpi_get_cache_info() is only called on ACPI enabled
-- 
2.52.0


