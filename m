Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBDE60A2607
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2026 16:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=cvnyqAzi
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jV6h80CS1z2yVB;
	Thu, 19 Nov 2026 03:37:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795019831;
	cv=none; b=O4g/cCCIjbzmHjDsR8uxuy086K57L1PCHCjRjMkJJr33EMGpU/Ys4X+kxLsxPSUUj9ZiOzO4kMC0aBNwXLOEb3BYjypp1dS7cuGnhHVnQaLSMt1VquXn9+2NwOWHj3b5q0dmu9BVQ7ERln5A/Ox6bxXkY8A7suVXO+6Y95hzy82kI+rS6pwda7R5lvscEEvvD4q1tVHJ9snmcOZRh6nKkLSpf+V6jOGhMS3vb1YaJI4tEJb7zQT4WnoqLAAVfMZWUjZG+EaJnrRYxGN9b+BfqnS20KGPTRQ9NEVLTMQM9SKyXuSOz38YgFswU79QS5fLBeY0a6wIWNx+rV2CEzpkJw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795019831; c=relaxed/relaxed;
	bh=zWf+n3RZzzOpBOBWGo1cQyq4yCRc7gHuZjX7HIYaZrU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cg9gWeCaDr+xwg4wqyG6TgANsqPUorhCpe3UEicY9Ew/cEIzfw+8ZjKj4k7VTvHjfcORpJM8Fgo6AMZDoAm+qVEihZ1bd++GO8vKccJfY3Pi9nXjhniGDwfea5VRh5R3LN2nHH2VK58q4E+766EgxFPjI6PJ7SwBENFc5GrKx9tTPE7WFv9XrckOBUx+Dol5Xx0eFUOsBXKTjHPTVGlsVMziLa1zaqMnDkclHRnldbyz6DnCl2mtN5aYA20hMRKgrA2U3bdNz4ye8BjPv6oSQHU1M9v0XrXIgAIhBRBc7zJ3fAXJzMpaGiu/ism4+qqFQiR/dpdo/q7mgeT730WsKg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=cvnyqAzi; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=cvnyqAzi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jV6h71s8zz2xMt
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 03:37:11 +1100 (AEDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AIDQKFh3774666;
	Wed, 18 Nov 2026 16:37:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=zWf+n3RZzzOpBOBWG
	o1cQyq4yCRc7gHuZjX7HIYaZrU=; b=cvnyqAzixReXDn2xCzuuR/VjeYeNZI2yq
	NJKIJ/GyM7MmQ1dlTX/Bs8YMn0IT0339HEAg/LoLbFRHHOn3fenKjyDvyxmKKpxa
	qaJBGv7ISIxQLNf8416zWAIlzEDGZxAD/rln+57FxcD9YxeQtkigI6wmOav2mDDI
	0dInSeMh6bxK1H9PWZCGMyrHQntk/KsskWIRC7QxGUePV/LcsZGERh42HkTFcj+o
	CGhNJCrYP8oyntaDr5KKArlbJqAxtPQyFCoL4f92V7VYGB6qP1tEtkUxGtd1If0h
	lnJeS6mGzKC0Lch5oDprXuwH/ATfAx+V2aApMGTO3rPHMVeS0WJbQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105rkexd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 16:37:01 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AIDZ3k4975413;
	Wed, 18 Nov 2026 16:37:01 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j067ngj09-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 16:37:01 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AIGavZ639911922
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Nov 2026 16:36:57 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 56DB12004B;
	Wed, 18 Nov 2026 16:36:57 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3F0282004F;
	Wed, 18 Nov 2026 16:36:53 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.39.19.105])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Nov 2026 16:36:52 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        driver-core@lists.linux.dev
Cc: sshegde@linux.ibm.com, christophe.leroy@csgroup.eu, maddy@linux.ibm.com,
        gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
        johan@kernel.org, sudeep.holla@kernel.org, ritesh.list@gmail.com,
        tim.c.chen@linux.intel.com, yu.c.chen@intel.com
Subject: [PATCH 2/5] cacheinfo: Support unified caches described by d-cache properties
Date: Wed, 18 Nov 2026 22:06:36 +0530
Message-ID: <20261118163639.890546-3-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261118163639.890546-1-sshegde@linux.ibm.com>
References: <20261118163639.890546-1-sshegde@linux.ibm.com>
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
X-Proofpoint-GUID: znJIFxX2mFjgPaK6ixCjgQvz26t5kF6m
X-Authority-Analysis: v=2.4 cv=e8uT2qp/ c=1 sm=1 tr=0 ts=6afdd42e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=t_fYOQ62Ex-2Ni1ZEtoA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA2NSBTYWx0ZWRfX/vNVh2x7F+Qc
 iWQ4mTgyA/EfW5IyXPmMoRdXekyeachWLTeVOKHKMihhDlj2hx7XvqxobZhdS8sMWV+a/QpU5ki
 MkI6fpyGW1hY+RXy/ZGZvzPe6UTyn4A=
X-Proofpoint-ORIG-GUID: rBcOd7QnoS0W_WWkt4V4j0W6Ci2p7Te6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA2NSBTYWx0ZWRfX4pexe/YkbDgr
 k8pwMwPPcGGkk/xqt0RA552W7AD68POuF43c5VxO6wuXU73xNyHl86ShHnp4LoT8Oj4M+ZHmQnV
 yYlge4vC5gTYBBRD877p/HyN+0xEA4FgzLkPHhn2QvkAqZZebXPsGjc3CuLRf5j1MbUsONW5up3
 utuUgWOZprARsNshcZcD6LJmb2LYR39q53TmmYBMoIG3Q2uI+pQQSxmRkICzKHJZNWQhOqise9K
 IDME1msVYnh6ZG8bUbyjPZ1Rn849suXMOC78CzyaH7VsbaPmfJs7jf1Gs9M2YHxxdMe0MON/aMr
 QNMbyvVROe9lNdHaR49xr6XI7Xu5EU3T69ISkQJt6ZyL/2Ay5sPLU6VHpx1WODDbxP5LRu65w8N
 dSMd8qCr+63qYL1uv0SJNJ/t4yNz4rg8JDXkt5EK+6fIJdbeZJwCjjLXcNlVY1eSoFtUVORLYkl
 I+IPGcOosfe6qx8Efzg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611180065
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

PowerPC device trees commonly describe a unified cache using d-cache-*
properties.

For example, Power11 L2 and L3 cache nodes have cache-unified together
with properties such as:

  d-cache-size
  d-cache-line-size
  d-cache-sets

They do not provide the corresponding cache-size, cache-line-size and
cache-sets properties expected by generic cacheinfo for a unified cache.

When a unified cache node does not contain cache-size but contains
d-cache-size, select the data-cache property set. This only changes which
device-tree properties are read. The cache leaf remains
CACHE_TYPE_UNIFIED.

[Both draft changelog and code are written by LLM]
Assisted-by: LLM
Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 drivers/base/cacheinfo.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index 10a9bbce899e..4a23377e9312 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -148,11 +148,21 @@ static const struct cache_type_info cache_type_info[] = {
 	},
 };
 
-static inline int get_cacheinfo_idx(enum cache_type type)
+static inline int get_cacheinfo_idx(enum cache_type type, struct device_node *np)
 {
-	if (type == CACHE_TYPE_UNIFIED)
-		return 0;
-	return type;
+	if (type != CACHE_TYPE_UNIFIED)
+		return type;
+
+	/*
+	 * Some device-tree bindings describe unified caches using
+	 * d-cache-* properties. Select the data-cache property set
+	 * without changing the cache leaf type.
+	 */
+	if (!of_property_present(np, "cache-size") &&
+	    of_property_present(np, "d-cache-size"))
+		return CACHE_TYPE_DATA;
+
+	return 0;
 }
 
 static void cache_size(struct cacheinfo *this_leaf, struct device_node *np)
@@ -160,7 +170,7 @@ static void cache_size(struct cacheinfo *this_leaf, struct device_node *np)
 	const char *propname;
 	int ct_idx;
 
-	ct_idx = get_cacheinfo_idx(this_leaf->type);
+	ct_idx = get_cacheinfo_idx(this_leaf->type, np);
 	propname = cache_type_info[ct_idx].size_prop;
 
 	of_property_read_u32(np, propname, &this_leaf->size);
@@ -172,7 +182,7 @@ static void cache_get_line_size(struct cacheinfo *this_leaf,
 {
 	int i, lim, ct_idx;
 
-	ct_idx = get_cacheinfo_idx(this_leaf->type);
+	ct_idx = get_cacheinfo_idx(this_leaf->type, np);
 	lim = ARRAY_SIZE(cache_type_info[ct_idx].line_size_props);
 
 	for (i = 0; i < lim; i++) {
@@ -194,7 +204,7 @@ static void cache_nr_sets(struct cacheinfo *this_leaf, struct device_node *np)
 	const char *propname;
 	int ct_idx;
 
-	ct_idx = get_cacheinfo_idx(this_leaf->type);
+	ct_idx = get_cacheinfo_idx(this_leaf->type, np);
 	propname = cache_type_info[ct_idx].nr_sets_prop;
 
 	of_property_read_u32(np, propname, &this_leaf->number_of_sets);
-- 
2.54.0


