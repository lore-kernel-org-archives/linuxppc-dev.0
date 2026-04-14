Return-Path: <linuxppc-dev+bounces-19732-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC369ED7B8A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Apr 2026 08:23:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fvy2Z2L0sz2yd7;
	Tue, 14 Apr 2026 18:23:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776154982;
	cv=none; b=GD0hkQzx/PkjLrsAeiblzBLhYTxSH6sS5uSH/zJKMvjSPGLrfp8/y7OPZVIEz4ttJYOlXcWPKEmaa1fbhkffPVgyg+oVjbtPZURFBM8G0uLCR/kwFAgGckh69QBd/GSodnbkpsCmHaqiVpKr5XQEOTLgifc363ThcoGPc93xsz8iTSP8YHh1mGxOt+LciyJJGxnExiERnsOR2vpQpZMCebr/ArQq2gyRfNrUwF/ou9R0ZiytTh/LJ0J1hZK3DC0jR7T4KQLR4Uv+xQ2VAXIJ0hsqhwZLpSEFhbSvffdPW/V3nxr6cLoNtnfgeqPczwGSYewJjW7oFYOuYOU1I2QO0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776154982; c=relaxed/relaxed;
	bh=7DaF97K18SRMtygc1p5bBtDdhAo0qzwBysVgANcUPEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E4oRisQAMwcjmtoCTurAq/blGrjoQwDRiUui5rpuPbxlrCKf3RMKn4RBs8T87IqnCzrFUrFpdxWpinYUnp3snBCq9QI8iPo4GjjsOPu0Xd0/dc081zRAzKxQDkmpgnVu3Fm1WcV/VnTm86euY+kWotGPGz4umdD4wfbuNoQnKzWEXOca7kz5s4vnF+dcX1zJYbgEVLDyj9YL386gKzbZXt+FDcM9g+0yDyLzU1cM9fkXxwFJjkxdWOqNhBPMztX4aoq4xMbhyBHhL4Z81khhl8RKVsZbAIP8eMmSwmL18p4sQ0qKNCcj1GVV0xtGfRj0g/wfm6mnUuGPbtpcGUXKeA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Zsne20Vp; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Zsne20Vp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fvy2Y3Sdmz2yVL
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2026 18:23:01 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63DLIUv81733958;
	Tue, 14 Apr 2026 08:22:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=7DaF97K18SRMtygc1
	p5bBtDdhAo0qzwBysVgANcUPEU=; b=Zsne20Vpah5+igCMdb9Q/VoKQ0WKUagqS
	AJmhi0DnIDwmu+MEoYApZaCQSMsjKUGxkP9KII17qeqGgjXXVhqFaXAsxMGATsmr
	5xy2iqCU72cNXkuh1K7CrIbfw/EXrFQEYsHa0YqNVeBE8ufkNlPI3gZMd3mNF5lN
	zs5U6v0Zclj8XjVH0sHDWe3bUGrXWPzSXVDJSitX/0WbwO5lONSFkIZQlc980Arw
	apOQ3875saO7tYSUBey01/SNRM1iFxQ/F2poMTacV8bmsyzl8ZfSKAICGT6gqdNh
	aZdldjrv1uswUIEY48wRSokAVL5aVJUVpSGVRU/6gyUIaDp7zxHDg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89m1pnm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Apr 2026 08:22:46 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63E3UBEg015158;
	Tue, 14 Apr 2026 08:22:45 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dg0msgrqv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Apr 2026 08:22:45 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63E8Mgpv27591332
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Apr 2026 08:22:42 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 14D912004D;
	Tue, 14 Apr 2026 08:22:42 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1396620043;
	Tue, 14 Apr 2026 08:22:38 +0000 (GMT)
Received: from li-3f69264c-2ce6-11b2-a85c-c3f414d24014.ibm.com.com (unknown [9.39.26.223])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 14 Apr 2026 08:22:37 +0000 (GMT)
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
Subject: [PATCH v5 05/14] selftests/mm: fix cgroup task placement and drop memory.current checks in hugetlb_reparenting_test.sh
Date: Tue, 14 Apr 2026 13:51:59 +0530
Message-ID: <9c395e89454325ac8a3f93f191e5238214103551.1776150071.git.sayalip@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1776150071.git.sayalip@linux.ibm.com>
References: <cover.1776150071.git.sayalip@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=I/dVgtgg c=1 sm=1 tr=0 ts=69ddf957 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=XZ4_RENMreZbN4apZO0A:9
 a=O8hF6Hzn-FEA:10
X-Proofpoint-GUID: PBXI-A13GjqNF_d4uvuAjEMIssLZ5vKk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDA3NyBTYWx0ZWRfX3vibR2w2UfWV
 FB8ZTkDwIxCmPNGRGSigbBeTX7k0OqgUrBnXy9SSVNXwtiuFcgELLuhwb07Htab5kBUFD2y+tv0
 n1trZ6RE0us87r4PN9WO8CqD13dhvfR0ZVnuQFuB+zyDzEU6GGmtp3W/KaJhU8iiRB0sUroIg8q
 BExKYxaDaMq6ACFeKxVPy7tsDjRO1gtILxhsbsOI/hiPnuHiN7moPhSDv2F1K53drxn/dFThO/I
 21t3TQAneZQ+ecWZYPcPrawPBqp/NOJAspJDbt1RtlLaibAJ2j5UqFEFBNronV+kb/LGaxt/OhG
 PIJ2KqacOwujVjwLfUBydz406+a/RtKq8UWxzyR/zQbJfvLQSXAjcXSEONMPmdGsRHQF4+/vZ3p
 R+LyDId7mTpK9VQO31JzY9dNDXpg4cnkIlQl0fkbPtdBwWN4QmHZKejmngzfORwWIXlcA55yj1W
 gtQBJYAIwjMijnEOdyA==
X-Proofpoint-ORIG-GUID: M43yzD6g_1ZMRo-MLoP4CHb6XGA-Uw5m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_02,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 phishscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604140077

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
Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Signed-off-by: Sayali Patil <sayalip@linux.ibm.com>
---
 .../selftests/mm/hugetlb_reparenting_test.sh  | 41 ++++++++-----------
 1 file changed, 17 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/mm/hugetlb_reparenting_test.sh b/tools/testing/selftests/mm/hugetlb_reparenting_test.sh
index 00f3f3cd8909..014201cb6427 100755
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
@@ -154,18 +149,16 @@ write_hugetlbfs() {
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
+  bash -c "echo \$\$ > '$cg_file'; exec ./write_to_hugetlbfs -p '$path' -s '$size' -m 0 -o" & pid=$!
+  wait "$pid"
   echo
 }
 
@@ -203,21 +196,21 @@ if [[ ! $cgroup2 ]]; then
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
@@ -231,16 +224,16 @@ echo write
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


