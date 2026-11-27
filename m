Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DD2606A681
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Nov 2026 15:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fMdgU/V6
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jbcd60gyFz2xNT;
	Sat, 28 Nov 2026 02:23:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795793018;
	cv=none; b=gjel+OSoSOudGPZuMwpmU1NBWThd5VhOxocg1dBe2hBHzdhegJQ5Bpj9SPLn5K9Aa5A0sSwDU4lqcyDDnB58piNq81SHygXFXAQtPAzixkBTvhbASy5cGCi4Imz2M7DOaadDON6653ISjloeSqWj6q9K6QklRq9jOyCoP9oBrC936lOXtzq+pEpjI0xYIuLIP8GNos15UrOx8jZGblFjnjGHUTTXeGwEuZrpwo+Jy1uGWhnWAFDqzpWeqmscx8SaWcEIM5G31pH9ONEgDP+EOu1F/KBsWmOsR/BKBpLP+DgH1/4e0EOMOm1e5Aup91/XKKSCQ1rL1R3M6nx/I6Uw8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795793018; c=relaxed/relaxed;
	bh=+fupf6lvO00F5v0Mc4Ym4lHQfcOxw66+HeSzTfZRHb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S6kq9yoM+L8caGbxSKMbZRYUZ5w0q7SHkHAoJMwRS77ma7P2hTnMojLnlA+voI+lcDQxbbMURxS+/JLaqxmHDWlrD+QpGVHh1fJls5CqsioF2kQhrZrpRU2qbOEO1LygTgbymexrWR0XVNfGhLm2EIL2blUPHK3J9CdfdYbaRYNxvqU4Jqmcs9SQXb8iJBn5PrkezHde6IYdzT/PLHtbaboyOHv3NYIDDKPlCx1GnG0vNBtOZM6SKhlz5+RGRChdsvirvimemqRn5aQJew2kZRSTV9BVvCgI0Cpt3SE4zBMvxynGyHoqVaBw5y8ZlgF/6TNi/rwn+Fivj4qrs+2FRA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fMdgU/V6; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fMdgU/V6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jbcd526r2z2ySc
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Nov 2026 02:23:36 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARE4r283266648;
	Fri, 27 Nov 2026 15:23:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=+fupf6lvO00F5v0Mc
	4Ym4lHQfcOxw66+HeSzTfZRHb8=; b=fMdgU/V6s/HCosDjUoQzos+hQs1whF73U
	akPMHje6Xeq0NkpMaRZhSJ5Slws9xVxBoBqErnqwCjXmr8LXLH5CtSxfiKILeUQw
	D32pIKTnBMnNMhFYhsmzwlk+VsbN5jLDtkk4CLadRs8xn5k5WfWAHxsi1iD/vWeq
	1a4neTQbf7ykVGalO9n5heFcVEtGSdkgUKxQGu+e4OAnuPuP7X50gOIJrgiEPU7B
	9qGLNQPEGIHXjS0AfpjVLr4PWgDP+7LzgrcUnZptwHGU1M6VTXuLYmEnBYDnki1h
	Ej8CTXsoBoJHg78E1Orl/bq3orLXbvhV/CogQ2EtYNDKda05z+ZKQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34fkxdjt-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 15:23:11 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARE4ENm1180971;
	Fri, 27 Nov 2026 15:23:10 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j6rhckr61-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 15:23:10 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ARFN6an53412098
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Nov 2026 15:23:06 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E468B2004F;
	Fri, 27 Nov 2026 15:23:05 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 30D3020040;
	Fri, 27 Nov 2026 15:23:00 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.39.16.105])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Nov 2026 15:22:59 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, driver-core@lists.linux.dev
Cc: sshegde@linux.ibm.com, christophe.leroy@csgroup.eu, ritesh.list@gmail.com,
        tim.c.chen@linux.intel.com, yu.c.chen@intel.com,
        gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
        johan@kernel.org, sudeep.holla@kernel.org, peterz@infradead.org,
        tglx@kernel.org, kprateek.nayak@amd.com, srikar@linux.ibm.com
Subject: [PATCH v2 2/6] cacheinfo: Support unified caches described by d-cache properties
Date: Fri, 27 Nov 2026 20:52:38 +0530
Message-ID: <20261127152242.306333-3-sshegde@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA2MCBTYWx0ZWRfX7A/2KmqAbOdk
 lqlvw18444F9iqfmDKXp4+mDdsvlFf/TLM8yfM2T5D7gAqgFGaEz26sjssO/q1fcy8pKS+xaA1G
 maENqq5c8AtDaIBIpj2xNA3NZrJmrlAdPHtjI9+3Q2X6BgfHdqLKu/1eamJ0iI1QZ99K556oEv/
 mYW4L4qs8Qk1IoaJ7k9QA6ggWBlyejVnr0zR7wFeAp5HpnaNbfihF8oEy6Yw2dh9N3Y5ekKvQX8
 IBaZQODGbsoUVn5sOrbeaLvUSZBVxtkxsMGOYFaCFlrXzMG5o+frpAmPVtCqnzqzM665tsVISzx
 nni15/5cHQ66DS04zQh0Hxz5F1MR1XrbsNvHKfEC21Q+UhcbOqIMGsyXrLntsw4+3RrfGMmeG7Q
 IiKja4tOky7YAonVdpc6KVWi8oHrs+esb1xv4kLMnx0wy2VTD3DjhiCUIDsx7jRuoA/3BsmO0RU
 XzCKJfBaSiFJrKfQkaQ==
X-Proofpoint-ORIG-GUID: c-0GeN-vVU-5ogbCifPbbxvHpe5sxh5A
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA2MCBTYWx0ZWRfX+GRTnyrVbpjR
 8Dv/xwEmwzw+4v0rYJbza/zsgMAs3c8Q/Y5TfPy/nl5fDhEHAfJf8UOvFHRhUnUJT42TXNlZTWq
 hZZ0rLulStqbctovcyASOZKopmkOPHw=
X-Authority-Analysis: v=2.4 cv=A9z5rKWG c=1 sm=1 tr=0 ts=6b09a060 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=t_fYOQ62Ex-2Ni1ZEtoA:9
X-Proofpoint-GUID: RuOKydFePPLanC_e1rO2aHKrnu8v2VEX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270060
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

[Both draft changelog and code are written by LLM under guidance]
Assisted-by: LLM
Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
A Subsequent optimization if the series is in an acceptable shape.

Cache the idx first and then use it in cache_size, cache_get_line_size
and cache_nr_sets.

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
2.52.0


