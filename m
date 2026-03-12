Return-Path: <linuxppc-dev+bounces-18100-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A933105A594
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Mar 2026 12:26:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fWn0c4G8Fz3cL8;
	Thu, 12 Mar 2026 23:26:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773318384;
	cv=none; b=PThdCXBxBQp0ILUkvy6ViDXlCsyMEU6XWKc83qksr9tfYUP3+6Txd4nzkPbyr3UpwNI66bkeQaxCGDZPAVjMkA/5ZvEYi8W4hhXfvgJbbbonf08mGCtlqtRaRmJkcFiVmFdXs6SNIO5Ngs433M9TApQhFieFvYQgJEWOyg4W/Z1mecgqPLO/bH5nucUa/dWLfHVihzxdzjnO4eQcF03zzZovLlTkX3fZb0UFbqg+8Yjdn5j8+eVvKpU0D5fvxaHgoXBETMxN/gQPNTMqaVPnIsQ4T/YOUbX0DRAvLCKRuoDfmyKZEPivx9DpoDZmFGbhs283VlsiqHqxO9jmh8pfpA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773318384; c=relaxed/relaxed;
	bh=al6jYWb2aZA4hmaYaZhNzaupRDLJVh4UUYdgPwIwhk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A8EURVYgmQLHeOqcqcDJS00AM2CGC/T3KUPS5xhkDvufJ1J71TVyPiIkPq1TgNfaCP6CQigwuXctSa8dJkiRjfP+vRatkg47C5J1EVFPiU/41i+SAS0IfoHv7M/gYfrdViaa86sgMXFpuj5ZLVKdYjkSC55rcrfBQ0YMgyz49Wc3kZn7r9rnyiK0RtqQ3YOESnKHzmfCx2zZbir4Y0fH+AJ1uHJrHkSNQGFJ2NCyQHSvc9B1Wh0TaJSOei52fugplm+CVoSMBBuo/UalNLWubDa5YElZoZ/k6yV6Xs43vPL/noCuGmXGOb9dwk0N6BsuzvE0945W9LHL7LyplvIZCg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=CW28d+71; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=CW28d+71;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fWn0b6vH2z3cGw
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2026 23:26:23 +1100 (AEDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62BMWUtv2303568;
	Thu, 12 Mar 2026 12:26:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=al6jYWb2aZA4hmaYa
	ZhNzaupRDLJVh4UUYdgPwIwhk4=; b=CW28d+71SUixrGWhtyR/+mkbTEYaUnQJN
	JW1h4AJPfA0V7jO/EqtWUSKsifycJ7IcWdkJ84YAVOVR0KHrjmt8OkxVww/E2Kqh
	/dY8o57wOImH/1RvyKIAxbmx1ChW830sWGHmBGTRP9JRxgVIPLjDzEECUi3BYwIG
	bKph12W087SGR8GUR/mTNeHhM+c232w3iJ1nL4okfKAuaOLOiNuJqU34khvW8sRh
	nYmehxMwSTUVSG+zAtpz1jjGjBdGpYLEdlpOzFM2rmwAH9Sm1X91ezi6SlGoH8U8
	oZbpTmZq79zfXOA6xP2WazgJnXcg6vV0LfX23lqXgLlWFtLK1G18A==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cuh95tg9j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Mar 2026 12:26:14 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62C9KIKg008820;
	Thu, 12 Mar 2026 12:26:14 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cuha72979-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Mar 2026 12:26:13 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62CCQCha43712914
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Mar 2026 12:26:12 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E9F3B2005A;
	Thu, 12 Mar 2026 12:26:11 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8F7982004E;
	Thu, 12 Mar 2026 12:26:08 +0000 (GMT)
Received: from li-3f69264c-2ce6-11b2-a85c-c3f414d24014.in.ibm.com (unknown [9.109.243.201])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 12 Mar 2026 12:26:08 +0000 (GMT)
From: Sayali Patil <sayalip@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>
Cc: David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>,
        Michal Hocko <mhocko@kernel.org>, Oscar Salvador <osalvador@suse.de>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Dev Jain <dev.jain@arm.com>, Liam.Howlett@oracle.com,
        linuxppc-dev@lists.ozlabs.org, Sayali Patil <sayalip@linux.ibm.com>
Subject: [PATCH v2 03/13] selftests/mm: fix hugetlb pathname construction in hugetlb_reparenting_test.sh
Date: Thu, 12 Mar 2026 17:55:30 +0530
Message-ID: <3ab5781190ea0a6bffda2683b2ca221e0c7f6280.1773305677.git.sayalip@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1773305677.git.sayalip@linux.ibm.com>
References: <cover.1773305677.git.sayalip@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEyMDA5NSBTYWx0ZWRfX63TGo0ZlBIf4
 Uj5aB3Zg3C5VuEGFVhlil7pvZ1a7MI2AeE1LldfqCeDsvdWJyOkzsw4ra2eiO898fsWh9mL7mC6
 vrp6BKVKpfH+N4wnTX0aowytefM4mj9ElxsonGYJb9uz51+FDx7crE0vnsHiPD/f/ttibhnA1qj
 hzBvdDm3KkaHqdBM4gak+fzoXyHXVkRxnH7FWfJ1RW8F6OI9k+nsKjEHD1FWSrft0tTX/DGW9JZ
 VRAPq6wsGdT19uMcb8lon+PUBuwOAOmPdD5SrJVCGOU5+rZAt4uCcKfkY6uo3ti4XJp4toFpfvi
 z3ZEe922NoltA4kMWPx1CpUBFq7vmDSuHxIwyzATYl+Xei54KvWf/I5quT66ZSW370i80dAJLFr
 x4R7CPzy0HUSYUar1QBMUUZuiVl0Tpxr6WkkC6mqbAVzNbTAfwmFSGls/RhwBHANpD6FTNoUg47
 0olZc1HV6g2LrkayHZQ==
X-Authority-Analysis: v=2.4 cv=FowIPmrq c=1 sm=1 tr=0 ts=69b2b0e7 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=Ikd4Dj_1AAAA:8 a=VnNF1IyMAAAA:8
 a=GZ17xiyvJlIGkQ2CLjwA:9
X-Proofpoint-GUID: 3G8cnwaJ4QaZVz4DGmqOG0_7j8k2hu3b
X-Proofpoint-ORIG-GUID: G20fyj2GUhLBjWzP3YtY8JZbENDnytaE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-12_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 suspectscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603120095

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


