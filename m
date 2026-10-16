Return-Path: <linuxppc-dev+bounces-29601-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1135ECCA464
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Oct 2026 11:05:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j5htK4W86z3bwR;
	Fri, 16 Oct 2026 22:05:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792148713;
	cv=none; b=aG0d79N9PX+M0TD5XGP3Mq6E52kM1tk6/KZboDtx1OlunzcetjgTOjflydN9Y0wDpFwG3bTxHFM1CvIyNnIJyrRMGLR1W8LA17PlE5jkA4SrzchhKjLv1mEc03Hy9FpvUIh0Xs1FNKQPD5RuO9H1+T+03+IRsMyM5u5gO6mjCs5YYfpp3HhypNzb8MOQMCMyBcw1EOl/JSWxJZw4F2jKdHWT/KmIklhMpBL2SjNOFNRynJ1Oz+AzXHnJxGW8y9bakhzQ5gH1m/BEFUZ0WOlhMQVuj/rFJv1+4pprkvoRXEA8642QmxM8vlxu6Y1nQT9V+a+urRyt1i7PbXRtIN3LdA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792148713; c=relaxed/relaxed;
	bh=ZzcWpbJ+WGNjOpTIgFA5wZdtn7byV4BKif+YEWLPAK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y3EFTThLtRkwwHPzOi6Kr4cVswCidgHEVnL8xHK+Jga4A66z1jUsCvVp+28RTq+uyY5Bkjyr7e59kwF8YlC6H+xu2YgOYfm8oU/cJHvVGJTJIXfPQXgv8Y76ClEFbr86GznAWz4VnvUlYPjy09AcFb88Sj2wX8qYPMoSdBoP7h/sTcApQI2ynB+XmwtdljVrIZI2DOae4gzFjuxVegEWj39mcLRLZzKtRupBlUEr0RXH9ypkJHM3oFm0Pyqo4MqUZKDjPSpCeRY3iXs6XaDq9a2BZhQ5uE7nauNXqGa3P395WbfGXRjIesjLdvtmh5HZ8M2JscVszBEXZaqd5q0t9w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JcrfecMz; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=srikar@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JcrfecMz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=srikar@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j5htJ5zc8z3bsq
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Oct 2026 22:05:12 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69GAE8iR3502878;
	Fri, 16 Oct 2026 11:05:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ZzcWpbJ+WGNjOpTIg
	FA5wZdtn7byV4BKif+YEWLPAK4=; b=JcrfecMzP44N054tmvXLoH620FkgkY7XJ
	fT+62ytxJLjGx8p22DJbOoXdY+wQ1JGUgQKO+iIf8eaFjaLzdJZtKF0t024z3F6P
	lALgNqdYD2yJLGRxp1ePDheLD3jxMl7v+LvUkHbrmELPsuz5HKLqtd1j5NbfeQte
	xNP0k00k6kleW/r/b6FqHWEqkGknwbuc4YMnz1h/JUBRty/CB6o+CNJ+d7Hc3UuP
	zafKoN/TZdRS7N4yjv61Je9uNCP7TOlTPySWBq5GN5FHru6rjaOaOm1Kmvwgfk8S
	wee2d/gkSlv4J/Pv5C1OHP3Uww45tn9h/BNoUiCZxrHgrmRDEtFbA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dv3xvh3-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 16 Oct 2026 11:04:59 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69GAJr1V3586429;
	Fri, 16 Oct 2026 11:04:58 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hb36wk593-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Oct 2026 11:04:58 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69GB4t1652953540
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Oct 2026 11:04:55 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 331572004F;
	Fri, 16 Oct 2026 11:04:55 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 750C820043;
	Fri, 16 Oct 2026 11:04:53 +0000 (GMT)
Received: from sapthagiri.in.ibm.com (unknown [9.123.124.175])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 16 Oct 2026 11:04:53 +0000 (GMT)
From: Srikar Dronamraju <srikar@linux.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
        Madhavan Srinivasan <maddy@linux.ibm.com>, chleroy@kernel.org,
        Srikar Dronamraju <srikar@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] powerpc/numa: Extract CPU associativity processing into separate function
Date: Fri, 16 Oct 2026 16:34:11 +0530
Message-ID: <20261016110412.1380298-7-srikar@linux.ibm.com>
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
X-Proofpoint-GUID: y_bDebaEFDmebbvk4noYHdPoBXe1bMmK
X-Proofpoint-ORIG-GUID: oi2OGu5N0HeWDuyG1ooZ5Hlho7vF4Bd0
X-Authority-Analysis: v=2.4 cv=aqInmiZV c=1 sm=1 tr=0 ts=6ad204dc cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=CSkan9fJTwVe4Lm5sQ8A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA0MiBTYWx0ZWRfX48Lc0YHBocnI
 x/fmqUjSkWMUNrKl8L6U6/ZW0NBaB0eMVgmR38pcSz/rgpuOig1cq2ggoQo+luw5J7c0eW1xSEM
 L8f7XAUjVflbXzZ5JhLm5qvJRQfzpuI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA0MiBTYWx0ZWRfX0Hys5IO2hFP8
 yejQ2vV13M/XIqNfa/v2D8Ioy0mdIQjW9nlVef8Nr+y+XuOoMY0h26CWlJ2Ko1Cu3eQL42Pox0h
 JzPE9azHw3kuTzaBhNxVexpdcw6hrsTzqKIZ95SkC5FWtNob4j8F4f2GSqIr1rO4zdVkh0M/Eu7
 anyhkieuIpl0cP/0s1VPqAoZKSI43ezToL0pdWNFySC9vdROarVSeDsJhJc4hFudh/d0Z9aZYsI
 qgaL86lC+cfcWpRhdgobVaj/RoZ3/putthh5vIv6jDSNuWzwkEWtrqY/ftOdq/k8ZnokhS3vLOs
 XS//9At1JCvtSoPczpq6T6k3GCaLTQrD/JPEor05TRivbBw2SUnf8K1juMAhes7B4ZznAG76Kx7
 PCsUfAh7cxhav6dNs8V1Sumt5Pq4GOFAYeUrwYJwmYhrPdBcMQK9VcaIYXCYJmZ6CYbGYpGc6uJ
 O3fwlKie30hEbYZdqRg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610160042

Move the CPU associativity processing loop from parse_numa_properties()
into a dedicated process_cpu_associativity() function. This improves code
organization by separating concerns:

- parse_numa_properties() handles overall NUMA initialization
- process_cpu_associativity() focuses on CPU associativity processing

This also allows CPU associativity processing to be invoked again after
the processor sharing mode is known.

No functional change in the initialization flow.

Signed-off-by: Srikar Dronamraju <srikar@linux.ibm.com>
---
 arch/powerpc/mm/numa.c | 65 +++++++++++++++++++++++-------------------
 1 file changed, 36 insertions(+), 29 deletions(-)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index c2aefb60ed5a..fde79f34340e 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -918,44 +918,18 @@ static int detect_and_enable_coregroup(const __be32 *associativity, int index)
 	return -1;
 }
 
-static int __init parse_numa_properties(void)
+static void process_cpu_associativity(void)
 {
 	bool vphn = firmware_has_feature(FW_FEATURE_VPHN);
-	struct device_node *memory, *pci;
-	int default_nid = 0, index = 0;
-	const __be32 *associativity;
 	unsigned long i;
+	int index = 0;
 
-	primary_domain_index = find_primary_domain_index();
-
-	if (primary_domain_index < 0) {
-		/*
-		 * if we fail to parse primary_domain_index from device tree
-		 * mark the numa disabled, boot with numa disabled.
-		 */
-		numa_enabled = false;
-		return primary_domain_index;
-	}
-
-	pr_debug("associativity depth for CPU/Memory: %d\n", primary_domain_index);
-
-	/*
-	 * If it is FORM2 initialize the distance table here.
-	 */
-	if (affinity_form == FORM2_AFFINITY)
-		initialize_form2_numa_distance_lookup_table();
-
-	/*
-	 * Even though we connect cpus to numa domains later in SMP
-	 * init, we need to know the node ids now. This is because
-	 * each node to be onlined must have NODE_DATA etc backing it.
-	 */
 	for_each_present_cpu(i) {
+		const __be32 *associativity = NULL;
 		__be32 vphn_assoc[VPHN_ASSOC_BUFSIZE];
 		struct device_node *cpu = NULL;
 		int nid = NUMA_NO_NODE;
 
-		associativity = NULL;
 		if (vphn) {
 			memset(vphn_assoc, 0, VPHN_ASSOC_BUFSIZE * sizeof(__be32));
 			if (vphn_get_associativity(i, vphn_assoc) == 0)
@@ -984,6 +958,39 @@ static int __init parse_numa_properties(void)
 		if (likely(nid >= 0) && numa_enabled)
 			node_set_online(nid);
 	}
+}
+
+static int __init parse_numa_properties(void)
+{
+	struct device_node *memory, *pci;
+	int default_nid = 0;
+	const __be32 *associativity;
+
+	primary_domain_index = find_primary_domain_index();
+
+	if (primary_domain_index < 0) {
+		/*
+		 * if we fail to parse primary_domain_index from device tree
+		 * mark the numa disabled, boot with numa disabled.
+		 */
+		numa_enabled = false;
+		return primary_domain_index;
+	}
+
+	pr_debug("associativity depth for CPU/Memory: %d\n", primary_domain_index);
+
+	/*
+	 * If it is FORM2 initialize the distance table here.
+	 */
+	if (affinity_form == FORM2_AFFINITY)
+		initialize_form2_numa_distance_lookup_table();
+
+	/*
+	 * Even though we connect cpus to numa domains later in SMP
+	 * init, we need to know the node ids now. This is because
+	 * each node to be onlined must have NODE_DATA etc backing it.
+	 */
+	process_cpu_associativity();
 
 	if (numa_enabled == 0) {
 		pr_warn("disabled by user\n");
-- 
2.47.1


