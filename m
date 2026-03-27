Return-Path: <linuxppc-dev+bounces-18906-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77F0E10BA436
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Mar 2026 07:18:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhsRY6d18z3fD7;
	Fri, 27 Mar 2026 18:17:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774595865;
	cv=none; b=Y4Mbvyl7qU6JIh7LzmAysfgzZEV34jyglPjZjao7+2p1r/2jf5TR+qLEbOCHxFe7it3kCluoER11jCpVn0O3+F5MHhbN4fHfAOxn5xlY/JU/gnx9x+rIQF1Oi2mjuPxm0nDFGycZsyF71ZvRwXJStXiov0pmidauCtGyuxKVHAYFGGzQ5uVn5dMn7wVd3/im5xhSJxRY5g4QKkDG+dYmHGKFDJEpNdNffXoqU21FWtlC8MP172b4S+qr6ahL1qzvWRfobJyoF0BsJiqYndFnZ5DzI66v0lJIxWcW/Jqx68+jkf6JnmJGIrBmWt9B6BhX8cwlM9AhXNim5GELBCg4hg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774595865; c=relaxed/relaxed;
	bh=TBOgR1l9moyFZt4QtKx6pynWY1WrXZnmRZ9D9UZIMvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bTlCCNEragfTzRCXxE5yIwkiZZ3y7/OoKUHjklCopsZzF+4cU7rvxmlz9jje8cVBFvhN8Qnmd9WsKt94ZfLEtrGbJ+uUFmVQdDmW0FovTVyvMKQLrmg0gMYEtMnS81FXpifu4YCN/vLlgpm6BoxgNGl81j9I3GFccgSMzRsVDlm7dlQbymeXm2dTAhr65g6SfjYPzaQi6TzvgoqCenjPpk0kJjMJwm4zd3oEbtXzeokax5flofSv2agZu8MkKCIk14lXcvf38QOGVUOpqkd87ze+D1ZhEdwZ4V5wcSlZ/aDC3PfMwUfYwZTwcDQNxe0LF4webOUWeldBth2YEtY3qg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qOcpPHzH; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qOcpPHzH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhsRY0yTlz3fBy
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Mar 2026 18:17:44 +1100 (AEDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62QFxoxX755965;
	Fri, 27 Mar 2026 07:17:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=TBOgR1l9moyFZt4Qt
	Kx6pynWY1WrXZnmRZ9D9UZIMvA=; b=qOcpPHzH+o3e0onJgNuSY6rfdlaVSmmBs
	K20X9oi9kYFEGai2sXuzhMx5kDWn9+Pm769kFcRa1y94qQLwoviRP2xYbllz0sVl
	QgeEmvWGbzABgh2tP5X15LFrXL2lM9lJzrJXntdLwKTBdlBudo/1lU1vUP/ooL3E
	qkJ9SxECcvvCZgOyREEH3oJ2e9EZjdI0/FpYS46Cl0jNlmEg5vkD+RMm4QdRER1G
	4NesGH5U2cqBGAqotJUW0ipiLK+LLRbx3s+uqH5t1PfZ4eoFIDgHHM7u9VV5ANmb
	TKBs4itGO1qM7Ue3rUs7JVOqlJ1BGzgb2vITPnFHJY4DgFPlR9BVQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kty8xaf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Mar 2026 07:17:32 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62R5f79R009143;
	Fri, 27 Mar 2026 07:17:31 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d26nnxgpr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Mar 2026 07:17:30 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62R7HQGh51118442
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Mar 2026 07:17:27 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D9C7D2004F;
	Fri, 27 Mar 2026 07:17:26 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3CF5520043;
	Fri, 27 Mar 2026 07:17:23 +0000 (GMT)
Received: from li-3f69264c-2ce6-11b2-a85c-c3f414d24014.ibm.com.com (unknown [9.124.208.5])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Mar 2026 07:17:23 +0000 (GMT)
From: Sayali Patil <sayalip@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>
Cc: David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>,
        Michal Hocko <mhocko@kernel.org>, Oscar Salvador <osalvador@suse.de>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Dev Jain <dev.jain@arm.com>, Liam.Howlett@oracle.com,
        linuxppc-dev@lists.ozlabs.org, Sayali Patil <sayalip@linux.ibm.com>,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [PATCH v3 03/13] selftests/mm: fix hugetlb pathname construction in hugetlb_reparenting_test.sh
Date: Fri, 27 Mar 2026 12:45:57 +0530
Message-ID: <05459b5038595a3a673507e707402839cdcc2955.1774591179.git.sayalip@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1774591179.git.sayalip@linux.ibm.com>
References: <cover.1774591179.git.sayalip@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=IqITsb/g c=1 sm=1 tr=0 ts=69c62f0c cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=Ikd4Dj_1AAAA:8 a=VnNF1IyMAAAA:8
 a=FzkvBdHCBhmLUSHJBJ8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDA1MyBTYWx0ZWRfXwqNqCoTDMWjI
 V/cDYptktXkfxpQrOGMsHHe5eiKQRe9KPyV0hfxIOGW/eaJWwujzyU+TsC3AnI3kNt3/xox1bEz
 RO1HA1yguOGniLXKNeTpwkKawakNtGFsZrLSH1hBQaYLvOoXITyk1uDCiQgWveNonrQJG/wPjms
 jgd2Qzx6PpNk7wRW9rxHDHjilEonsKSJkbANQht5N9mKPd4/xm1h0BVL4vqzP/P0Bv1kIIcvlkU
 3l7UX9OUBIpEMyv9l8fpDAZOqZ/3MvwMdG6CyCstnIEqlSMD/fo31+IpV+7Qbpz3AET9meUmgzN
 Gw/hBH5drQequ8wv79DaLtCXUgVxN3BkR/jHCxkSA1rqTAAgcx3o09+zTJYLi923cJop6GHnzW+
 7z5ajzPMQZJN56W+CFGOch+pq0tHF9GhUPdCPpq3w8dGY5wxGrC9sDJ9RIZSbW+2Wn9HoiXLoW9
 ydGYWXGxCHglFCeO1/A==
X-Proofpoint-GUID: dhmQA_ssikxSnGk83UShumqltiWBxoez
X-Proofpoint-ORIG-GUID: Q6rcQmFkzW8eNl5Ajow8T3DjL16loKtD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_04,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 spamscore=0 impostorscore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603270053

The hugetlb_reparenting_test.sh script constructs hugetlb cgroup
memory interface file names based on the configured huge page size. The
script formats the size only in MB units, which causes mismatches on
systems using larger huge pages where the kernel exposes normalized
units (e.g. "1GB" instead of "1024MB").

As a result, the test fails to locate the corresponding cgroup files
when 1GB huge pages are configured.

Update the script to detect the huge page size and select the
appropriate unit (MB or GB) so that the constructed paths match the
kernel's hugetlb controller naming.

Also print an explicit "Fail" message when a test failure occurs to
improve result visibility.

Fixes: e487a5d513cb ("selftest/mm: make hugetlb_reparenting_test tolerant to async reparenting")
Reviewed-by: Zi Yan <ziy@nvidia.com>
Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Signed-off-by: Sayali Patil <sayalip@linux.ibm.com>
---
 .../selftests/mm/hugetlb_reparenting_test.sh       | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/mm/hugetlb_reparenting_test.sh b/tools/testing/selftests/mm/hugetlb_reparenting_test.sh
index 0dd31892ff67..073a71fa36b4 100755
--- a/tools/testing/selftests/mm/hugetlb_reparenting_test.sh
+++ b/tools/testing/selftests/mm/hugetlb_reparenting_test.sh
@@ -46,6 +46,13 @@ function get_machine_hugepage_size() {
 }
 
 MB=$(get_machine_hugepage_size)
+if (( MB >= 1024 )); then
+  UNIT="GB"
+  MB_DISPLAY=$((MB / 1024))
+else
+  UNIT="MB"
+  MB_DISPLAY=$MB
+fi
 
 function cleanup() {
   echo cleanup
@@ -87,6 +94,7 @@ function assert_with_retry() {
     if [[ $elapsed -ge $timeout ]]; then
       echo "actual = $((${actual%% *} / 1024 / 1024)) MB"
       echo "expected = $((${expected%% *} / 1024 / 1024)) MB"
+      echo FAIL
       cleanup
       exit 1
     fi
@@ -107,11 +115,13 @@ function assert_state() {
   fi
 
   assert_with_retry "$CGROUP_ROOT/a/memory.$usage_file" "$expected_a"
-  assert_with_retry "$CGROUP_ROOT/a/hugetlb.${MB}MB.$usage_file" "$expected_a_hugetlb"
+  assert_with_retry \
+	  "$CGROUP_ROOT/a/hugetlb.${MB_DISPLAY}${UNIT}.$usage_file" "$expected_a_hugetlb"
 
   if [[ -n "$expected_b" && -n "$expected_b_hugetlb" ]]; then
     assert_with_retry "$CGROUP_ROOT/a/b/memory.$usage_file" "$expected_b"
-    assert_with_retry "$CGROUP_ROOT/a/b/hugetlb.${MB}MB.$usage_file" "$expected_b_hugetlb"
+    assert_with_retry \
+	  "$CGROUP_ROOT/a/b/hugetlb.${MB_DISPLAY}${UNIT}.$usage_file" "$expected_b_hugetlb"
   fi
 }
 
-- 
2.52.0


