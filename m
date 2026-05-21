Return-Path: <linuxppc-dev+bounces-21273-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C428CD5BA6
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 May 2026 06:48:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gLfBP37Pvz3bpP;
	Thu, 21 May 2026 16:48:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779346109;
	cv=none; b=eY4eXZ1yYqJ8XXAUfz6U5iv+5stn8LJUYOdiWAmM7CS2JzJaAGojkQB3vzY8B3KtN16sBiuJ05DXHIuJ4O+bC21jS4M0LAyubP04NoiQ4B8w/zqwzF9Drzo0c4FHXJkI/fO/ic79L1eDBm1ruCO6Vjq/owAZklBVgV9+RIVkL9aoLu00ervLIlXZ6IEwj+NN5M9fgVcxhUiP5Unh+Q7w1QoXBY6RWXg1E8fiIOIZ0LWu5b/3abAqDIksnGnlUx1xxIslBguEziFMusQkAIUT1hYlLFgjn/WSRVzs2kXJlVKICBGdinPQgNESs0QA3UyGLrt6fMzhoqGg+JiqdZ4RFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779346109; c=relaxed/relaxed;
	bh=udzwYhTawzSzNQvyJpDKM0o+od4uW9MOHNJ2PUBQYQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G6WZkTX0YginzqzroOmUJPozS0MdEh2jZgPKfGGs8Zt+CCCvW04S8Qt4IP9fVpuXv04yyf+20ave+6ZQuPjMUSVIHM2mka2nSQmWKub1mdZ16kx2b5FbyCYTu3ITgX2dADX0mgz7eG8oZOifww1dpxecOh3Xr4E/TYEWoCmpQc7C6JNyF+FXcZAmGDWWgUgkFKSEOkcqEYa5C6ilBZhWbM8e/r1kLNnTlHbvHu2KMW2GdBECS/qC6HX51mMZZMRRkPlbrBRzW6ZRcFjn57c+cSnU3nSF8c9qtScLuQDiL1m4O04wgoAubvcRvcK5oOdZQt3mrz4DNcp5Gv8gBmPJ7A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=EUozKRy/; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=EUozKRy/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gLfBN4tljz2xQD
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2026 16:48:28 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L6jBKE160368;
	Thu, 21 May 2026 06:48:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=udzwYhTawzSzNQvyJ
	pDKM0o+od4uW9MOHNJ2PUBQYQ0=; b=EUozKRy/qynqU39nvlcEOX0Or1JacDwOr
	bDdcfrsKshaPSSye8vrw7oS+aYQsU1ZRYvM3M4oi1+j/S7Y2UaBH5J0mO0iPeuW4
	008yNctoGFEaETdH8JPWjQnA0LWX9cpxr55YipxlWc/hko/QDE++HUKOBX2QOfpQ
	82lCl6A6xT7jzlo4rHgje4Ti+aBgBl6MZBaCwxOG6LER9fpDsWDI7C9xOmHXwit9
	vamMjsaqbURFUgoFSO912CvLRGAZ5DaqT7SHYGx04HbBfAvB/UEbySIiYt0NK+jn
	24kTSfJjhpJmvahJI7sKdJJqpEn6CUz7rxdqz8emhas8buhbgX7sA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6hb8mbmd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 06:48:12 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64L6d83r013530;
	Thu, 21 May 2026 06:48:11 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e72wqb260-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 06:48:11 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64L6m8Dl50463086
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 May 2026 06:48:08 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 011152004B;
	Thu, 21 May 2026 06:48:08 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 06B5120040;
	Thu, 21 May 2026 06:48:05 +0000 (GMT)
Received: from li-3f69264c-2ce6-11b2-a85c-c3f414d24014.bl1-in.ibm.com (unknown [9.123.3.209])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 21 May 2026 06:48:04 +0000 (GMT)
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
Subject: [PATCH v7 05/13] selftests/mm: fix cgroup task placement and drop memory.current checks in hugetlb_reparenting_test.sh
Date: Thu, 21 May 2026 12:17:45 +0530
Message-ID: <fb57491ba83cb0a499c72922e1579b61bee514db.1779296493.git.sayalip@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1779296493.git.sayalip@linux.ibm.com>
References: <cover.1779296493.git.sayalip@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA2MiBTYWx0ZWRfX21iNKeR+KCX2
 OuCNHQLbNnV0F5ss/BZbjhjmVKU73GsCdonrSvZnWqNVnLFNDwYxI+dHMBAGl7AEPaz0/UazZni
 TEKbe476umaMWLHVQQCQjMV0fs2jCVVdyGPq9efT4S2TcaqEjn376MD7BH2jg7fv+mQmg4ar1+s
 nRWNDHgdGIGun0zcsLOcTYrp5EfHfpMpkFmazM0g7zh8MCKCpILCX1kgeRNF9kwovcQYjD7gWsL
 8obc8uFuc46KxIBFfuXOV3JAWRbtPYTwkt49PXGxAWzI1QlvVKRkdH4IdcIc16uorPb+FQFVJO8
 pK/uIYpnOF1paWYVmP332YJw4uMO7A8hWztEBxUyi5Cvh1UVAemsNKNHjacowlGUmUBd6pnvE4t
 PCydBGX1i5xE8nXNPOKzKtZsHJhiM2fup8LigBBlkFhyqKx4ZAalgsmFWAQsxgcMFmawOdXFEfx
 upkkWyIEM3JYl9N+HEQ==
X-Proofpoint-GUID: iMCUzNF_VwhkUlL8IdcE_H9LrsmkFWJ4
X-Proofpoint-ORIG-GUID: 2j9dxQs97PS-2Hu29T8HZTDJweJTj8aF
X-Authority-Analysis: v=2.4 cv=aYBRWxot c=1 sm=1 tr=0 ts=6a0eaaac cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=fW5kwVfrStG9UF1TlMAA:9
 a=O8hF6Hzn-FEA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210062

The test currently moves the calling shell ($$) into the target cgroup
before executing write_to_hugetlbfs. This results in the shell and any
intermediate allocations being charged to the cgroup, introducing noise
and nondeterminism in accounting. It also requires moving the shell back
to the root cgroup after execution.

Spawn a helper process that joins the target cgroup and
exec()'s write_to_hugetlbfs. This ensures that only the workload is
accounted to the cgroup and avoids unintended charging from the shell.

The test currently validates both hugetlb usage and memory.current.
However, memory.current includes internal memcg allocations and
per-CPU batched accounting (MEMCG_CHARGE_BATCH), which are not
synchronized and can vary across systems, leading to
non-deterministic results.

Since hugetlb memory is accounted via hugetlb.<size>.current,
memory.current is not a reliable indicator here. Drop memory.current
checks and rely only on hugetlb controller statistics for stable
and accurate validation.

Fixes: 29750f71a9b4 ("hugetlb_cgroup: add hugetlb_cgroup reservation tests")
Signed-off-by: Sayali Patil <sayalip@linux.ibm.com>
---
 .../selftests/mm/hugetlb_reparenting_test.sh  | 42 ++++++++-----------
 1 file changed, 18 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/mm/hugetlb_reparenting_test.sh b/tools/testing/selftests/mm/hugetlb_reparenting_test.sh
index d724b6e45432..95f517c3bd16 100755
--- a/tools/testing/selftests/mm/hugetlb_reparenting_test.sh
+++ b/tools/testing/selftests/mm/hugetlb_reparenting_test.sh
@@ -105,22 +105,17 @@ function assert_with_retry() {
 }
 
 function assert_state() {
-  local expected_a="$1"
-  local expected_a_hugetlb="$2"
-  local expected_b=""
+  local expected_a_hugetlb="$1"
   local expected_b_hugetlb=""
 
-  if [ ! -z ${3:-} ] && [ ! -z ${4:-} ]; then
-    expected_b="$3"
-    expected_b_hugetlb="$4"
+  if [ ! -z ${2:-} ]; then
+    expected_b_hugetlb="$2"
   fi
 
-  assert_with_retry "$CGROUP_ROOT/a/memory.$usage_file" "$expected_a"
   assert_with_retry \
 	  "$CGROUP_ROOT/a/hugetlb.${MB_DISPLAY}${UNIT}.$usage_file" "$expected_a_hugetlb"
 
-  if [[ -n "$expected_b" && -n "$expected_b_hugetlb" ]]; then
-    assert_with_retry "$CGROUP_ROOT/a/b/memory.$usage_file" "$expected_b"
+  if [[ -n "$expected_b_hugetlb" ]]; then
     assert_with_retry \
 	  "$CGROUP_ROOT/a/b/hugetlb.${MB_DISPLAY}${UNIT}.$usage_file" "$expected_b_hugetlb"
   fi
@@ -154,18 +149,17 @@ write_hugetlbfs() {
   local size="$3"
 
   if [[ $cgroup2 ]]; then
-    echo $$ >$CGROUP_ROOT/$cgroup/cgroup.procs
+    cg_file="$CGROUP_ROOT/$cgroup/cgroup.procs"
   else
     echo 0 >$CGROUP_ROOT/$cgroup/cpuset.mems
     echo 0 >$CGROUP_ROOT/$cgroup/cpuset.cpus
-    echo $$ >"$CGROUP_ROOT/$cgroup/tasks"
-  fi
-  ./write_to_hugetlbfs -p "$path" -s "$size" -m 0 -o
-  if [[ $cgroup2 ]]; then
-    echo $$ >$CGROUP_ROOT/cgroup.procs
-  else
-    echo $$ >"$CGROUP_ROOT/tasks"
+    cg_file="$CGROUP_ROOT/$cgroup/tasks"
   fi
+
+  # Spawn helper to join cgroup before exec to ensure correct cgroup accounting
+  bash -c 'echo $$ > "$1"; exec ./write_to_hugetlbfs -p "$2" -s "$3" -m 0 -o' _ \
+	  "$cg_file" "$path" "$size" & pid=$!
+  wait "$pid"
   echo
 }
 
@@ -203,21 +197,21 @@ if [[ ! $cgroup2 ]]; then
   write_hugetlbfs a "$MNT"/test $size
 
   echo Assert memory charged correctly for parent use.
-  assert_state 0 $size 0 0
+  assert_state $size 0
 
   write_hugetlbfs a/b "$MNT"/test2 $size
 
   echo Assert memory charged correctly for child use.
-  assert_state 0 $(($size * 2)) 0 $size
+  assert_state $(($size * 2)) $size
 
   rmdir "$CGROUP_ROOT"/a/b
   echo Assert memory reparent correctly.
-  assert_state 0 $(($size * 2))
+  assert_state $(($size * 2))
 
   rm -rf "$MNT"/*
   umount "$MNT"
   echo Assert memory uncharged correctly.
-  assert_state 0 0
+  assert_state 0
 
   cleanup
 fi
@@ -231,16 +225,16 @@ echo write
 write_hugetlbfs a/b "$MNT"/test2 $size
 
 echo Assert memory charged correctly for child only use.
-assert_state 0 $(($size)) 0 $size
+assert_state $(($size)) $size
 
 rmdir "$CGROUP_ROOT"/a/b
 echo Assert memory reparent correctly.
-assert_state 0 $size
+assert_state $size
 
 rm -rf "$MNT"/*
 umount "$MNT"
 echo Assert memory uncharged correctly.
-assert_state 0 0
+assert_state 0
 
 cleanup
 
-- 
2.52.0


