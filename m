Return-Path: <linuxppc-dev+bounces-23768-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF134C43602
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2026 06:59:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gw89B0gbRz308f;
	Wed, 08 Jul 2026 16:59:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783493981;
	cv=none; b=IHUale1xVYpltY8/do4knN7f3KdtmbOcs2y8gFV7axcQO6UFFdWOQTzU32yNmrixeNfyWmTObIZzJGqqXEcgfQpDdPnOOW0gTY0Pj2zyKcsNtm+HbQDf2rm5mwwLbfbByNAVLDhl9eNvvhQN4NKf/vQXn/zGz0mdPyw+7QiDleF1ywNIhLL0EPIJnpYJE2O/K20eXURNgLrv4CWRit8RrzNMDOOsUlcCoTpljWLl/C+GKB0qQlMSQOyT5Uj8giO09DYPQhZTyFOWxrqcm4T6fi6wrX8Kp+LILpGFf3qHO8Ry5IhrGY9triPoy8WfqfQMmvseVFWaykHcCTllqelgJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783493981; c=relaxed/relaxed;
	bh=CuWuZbFd5cy9VxUgXbfMs27Q7qYTzAcGtHe14pOZImA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jykcbG3fmQBDv79nNWgckf4tgK1LYq2Q+oS1P+//m0aHPqVgecC8DEOtXlMwrgTgSSFlmv5jrUwMjIssz9mNVoMZ5qR2CZWnt2LGQyxWTE4vYRlBzJTZn6gsZ9WXXCPvwmCTBuX6TIBVDCCbdEzdF1/T4g56VD3zwGlyU5vP+o9N38O3mZJ4xgw9z6jAP7cDGVd5xse4x8OBG9P7+GjydOBF8IkT4LUd6Q5BH8zRhThr3GfIoAaO27GzTEn5Yb+PnxD4dnjd3lxgb6CWIci5QbzHmTFHQs9SbUaaB4Gi7k4S34WNB06gJ79UFIdeFQGrVuvByLTAPJi9zZndSwnQhg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=g3rFAHyQ; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=g3rFAHyQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gw8990Nyzz303B
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 16:59:40 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 667MnDoe1239287;
	Wed, 8 Jul 2026 06:59:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=CuWuZbFd5cy9VxUgX
	bfMs27Q7qYTzAcGtHe14pOZImA=; b=g3rFAHyQ0kmVzOFvBZTscjETjh2mUXRJu
	asKmpqTX2pBFzZU8nXjORbWbwvREV65o8u2PMujC76vBGyWPpTc1epubPAFchQic
	KynnaLp1xFlsbKn8yFqOaPUKLWVdmsF1T2uwyb98Q9NAghcSYyUxNZBmwOBuZLU8
	/q21E/MPnnkPA/a06B20HjHWe6syD/l7S/mMpLYDyQ7POcnfVDhWuzhzXzveg+XU
	ho3Gv3Lgc24V68XFA/NJ6yc+RuOGWaoYTL+MJWXK/BTnCC0cSl9PY7yw4N56efIQ
	5gcmlIgIQB4GUtqRYUwgWEevo6k+QkDdQrPwDmfV7nuBzmTlGJ/9Q==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6suqttx3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2026 06:59:27 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6686njRo023486;
	Wed, 8 Jul 2026 06:59:26 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7cvw6km1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2026 06:59:26 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6686xMbs52953376
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Jul 2026 06:59:22 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F4CD2004B;
	Wed,  8 Jul 2026 06:59:22 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D1A7F20043;
	Wed,  8 Jul 2026 06:59:18 +0000 (GMT)
Received: from li-3f69264c-2ce6-11b2-a85c-c3f414d24014.bl1-in.ibm.com (unknown [9.123.3.209])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  8 Jul 2026 06:59:18 +0000 (GMT)
From: Sayali Patil <sayalip@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>
Cc: David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>,
        Michal Hocko <mhocko@kernel.org>, Oscar Salvador <osalvador@suse.de>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Dev Jain <dev.jain@arm.com>, Liam.Howlett@oracle.com,
        linuxppc-dev@lists.ozlabs.org, Miaohe Lin <linmiaohe@huawei.com>,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
        Sayali Patil <sayalip@linux.ibm.com>
Subject: [PATCH v3 2/3] selftests/mm: fix ksm NUMA merge test for systems with memoryless NUMA nodes
Date: Wed,  8 Jul 2026 12:29:06 +0530
Message-ID: <78a3b0e3fb94004c0710872c5bab6f7381b7d63c.1783446924.git.sayalip@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1783446924.git.sayalip@linux.ibm.com>
References: <cover.1783446924.git.sayalip@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDA2MyBTYWx0ZWRfX9B49MXdit5iA
 X7QjY3hnrSbLY3XwgFaNta8FJx3TPWWWb91bUp0GbFUfiOB0CvxJiarm3y7FVhWdD+g27YI1C2X
 phuhVMIbcAfBJCOBXmbN0e8T260D8gM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDA2MyBTYWx0ZWRfX0AyQTEIsdmoD
 GszLh6neojyxo48ZR/oCauHiYNPMRcrSjFppStDEI1Lz8KcDlIxOtYmX1jW8+kAW/PSAl/iBlGq
 VWeixNweyKpn6IeLQE78BOCk61srNFEkK7wJMJ2wwNzsISKavpzI2u+wgOZkLA/oW81q+VPqeSQ
 86FuB5EmKeeh7bNHkeuQcKSVKZltszCN9WkZM/lLMatDDaNijKpU8eMPkSApKG99iF7UqXlvNkY
 eeXIhm9nei4d5bGpM3OiqPw4dV0nWcUT8Y2jPdvjGw33/XbtSmhX1eMvk/0L4DvasxLvbJCrqNW
 V7bo/m/0bjocQ/zRsnCJYiBccBM1upSr1GDgXrais/v12qBJq9QJ1NQE4mrwF3DH0UXnjjVPz+a
 DQFetPixjJ+ZEZTzuVLI21qg7PFSPVl2Sexp+S32GUouh32qDSPiVjKNth0UQI/YhZ71Kz2SQou
 VC2Sm6nCKq8vujpsF0A==
X-Proofpoint-GUID: LKt_BxzuBH8bzleBrGrxCSLKpGzLkXXc
X-Authority-Analysis: v=2.4 cv=Oot/DS/t c=1 sm=1 tr=0 ts=6a4df550 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=SdE_JmCAbqlUaBO606EA:9
X-Proofpoint-ORIG-GUID: NRA9Fm3-EzcvBxL3cOVjSqePTr9fbEEi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_06,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080063

The KSM NUMA merge test allocates identical pages on different NUMA
nodes and verifies KSM behavior with merge_across_nodes enabled and
disabled.

On systems with memoryless NUMA nodes, for example:
 #numactl  -H
      available: 2 nodes (0,4)
      .....
      node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
      node 0 size: 14825 MB
      node 0 free: 1382 MB
      node 4 cpus:
      node 4 size: 0 MB
      node 4 free: 0 MB

the test may attempt to allocate memory on a node without memory,
causing numa_alloc_onnode() to fail and resulting in a spurious test
failure.

The test currently checks numa_num_configured_nodes() to determine
whether sufficient NUMA nodes are available. However, configured nodes
do not necessarily have memory.

Reuse the existing get_first_mem_node() and get_next_mem_node()
helpers to locate NUMA nodes that actually contain memory, and skip
the test when fewer than two such nodes are available.

Before patch:
       ---------------------------
	running ./ksm_tests -N -m 1
       ---------------------------
        mbind: Invalid argument
        ok 1 KSM NUMA merging
	Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
        [PASS]
       ok 1 ksm_tests -N -m 1
       ---------------------------
        running ./ksm_tests -N -m 0
       ---------------------------
        mbind: Invalid argument
        not ok 1 KSM NUMA merging
	Totals: pass:0 fail:1 xfail:0 xpass:0 skip:0 error:0
        [FAIL]
       not ok 2 ksm_tests -N -m 0 # exit=1

After patch:
       ---------------------------
        running ./ksm_tests -N -m 1
       ---------------------------
        At least 2 NUMA nodes with memory must be available
	ok 1
	SKIP KSM NUMA merging
	Totals: pass:0 fail:0 xfail:0 xpass:0 skip:1 error:0
        [PASS]
        ok 1 ksm_tests -N -m 1
       ---------------------------
        running ./ksm_tests -N -m 0
       ---------------------------
        At least 2 NUMA nodes with memory must be available
	ok 1
	SKIP KSM NUMA merging
	Totals: pass:0 fail:0 xfail:0 xpass:0 skip:1 error:0
        [PASS]
        ok 2 ksm_tests -N -m 0

Fixes: e3820ab252dd ("selftest/vm: fix ksm selftest to run with different NUMA topologies")
Co-developed-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Sayali Patil <sayalip@linux.ibm.com>
---
 tools/testing/selftests/mm/ksm_tests.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/mm/ksm_tests.c b/tools/testing/selftests/mm/ksm_tests.c
index a050f4840cfa..2ebbb544c671 100644
--- a/tools/testing/selftests/mm/ksm_tests.c
+++ b/tools/testing/selftests/mm/ksm_tests.c
@@ -440,9 +440,9 @@ static int get_next_mem_node(int node)
 		mem_node = i % (max_node + 1);
 		node_size = numa_node_size(mem_node, NULL);
 		if (node_size > 0)
-			break;
+			return mem_node;
 	}
-	return mem_node;
+	return -ENODEV;
 }
 
 static int get_first_mem_node(void)
@@ -455,8 +455,8 @@ static int check_ksm_numa_merge(int merge_type, int mapping, int prot, int timeo
 {
 	void *numa1_map_ptr, *numa2_map_ptr;
 	struct timespec start_time;
+	int first_node, second_node;
 	int page_count = 2;
-	int first_node;
 
 	if (clock_gettime(CLOCK_MONOTONIC_RAW, &start_time)) {
 		ksft_perror("clock_gettime");
@@ -467,17 +467,19 @@ static int check_ksm_numa_merge(int merge_type, int mapping, int prot, int timeo
 		ksft_print_msg("NUMA support not enabled\n");
 		return KSFT_SKIP;
 	}
-	if (numa_num_configured_nodes() <= 1) {
-		ksft_print_msg("At least 2 NUMA nodes must be available\n");
+	first_node = get_first_mem_node();
+	second_node = get_next_mem_node(first_node);
+
+	if (second_node < 0) {
+		ksft_print_msg("At least 2 NUMA nodes with memory must be available\n");
 		return KSFT_SKIP;
 	}
 	if (ksm_write_sysfs(KSM_FP("merge_across_nodes"), merge_across_nodes))
 		return KSFT_FAIL;
 
 	/* allocate 2 pages in 2 different NUMA nodes and fill them with the same data */
-	first_node = get_first_mem_node();
 	numa1_map_ptr = numa_alloc_onnode(page_size, first_node);
-	numa2_map_ptr = numa_alloc_onnode(page_size, get_next_mem_node(first_node));
+	numa2_map_ptr = numa_alloc_onnode(page_size, second_node);
 	if (!numa1_map_ptr || !numa2_map_ptr) {
 		ksft_perror("numa_alloc_onnode");
 		return KSFT_FAIL;
-- 
2.52.0


