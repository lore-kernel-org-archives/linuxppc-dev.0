Return-Path: <linuxppc-dev+bounces-18905-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8995F10BA431
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Mar 2026 07:17:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhsRX5ScGz3fBV;
	Fri, 27 Mar 2026 18:17:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774595864;
	cv=none; b=Igcd7gj0PSaaC39r39jH2od4wii9xOOSg1Woj6RRpZAtSuXpBlsPOWaXFwzlUI1NeJf4cX9uTJGBLX6pTP2xrXahxmbYkMrdj6rwzhZtdEEuZOfrsh8ZeVZmUraiGRuD2v62s/mazeYdOmU4L+aPjWamFZOYQXklhGkS9R4ZwmAQqQ7WVXEOn7gncy4MxWwbR7v6ETrNfidy1ZHaiIQ9Dmg+ZNJURPqhxxN2Ba8HJKnCdY0m2Du/mNcMGqbfidvov7to21ERjHQQwLuXgG5ZCLkefMCS44cmeCyBMFJetuTOAuYwPOfHbByCtSc1mEGQvXYZ/Y8toXCNofRQn1yyQA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774595864; c=relaxed/relaxed;
	bh=fRRRjYlWxAolMESkMa1LtUUUU2Rcp6x5tvyIVsuFgbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CwFO9GIh+hPX0onxwGUjmEiu/PfGZa1TQii2rK2d+U6Ooue/gT5uEthqkEdJJwc9+NGB+0cR+NyNhRYrH9A6qv6Jyqwg29WfxOdYEfERJvgEyNcs6IUM2duw3g0KPURBs24dIaACuAlTWU/+J7+4Qp3ShXebC/hAcNCj7If/HkwYUinoZM5uZNn0CXHnouK7wx3WNKPkZmb8RGth3ucfKPMI09EHuqLBxdDpXpEuTxuyADWbCVRaXGhJiRQIkOvQY911CcJJre/4YDA0xjZ3MQ0qFWmuGk1Hg5ze1nXH/nZK0wcyuCCp+BqUwlQCDPY8EWKZwf5AD6WFxD/ca7FyTg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=MeFWO7Zm; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=MeFWO7Zm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhsRW6kFgz3f8M
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Mar 2026 18:17:43 +1100 (AEDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62QNaHvu3599991;
	Fri, 27 Mar 2026 07:17:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=fRRRjYlWxAolMESkM
	a1LtUUUU2Rcp6x5tvyIVsuFgbE=; b=MeFWO7ZmasnjfsQ9JZC+ealf6rAYQGsCt
	jLxSQF0Eb1NY1EVl1pEpk0ED6/qpwO36/ZMi9wjrrUclGD4izc6YldukJKK2+Pfw
	cFXnMb9rmJTYB2+UZ9rDpAg8oNFzSIWY6m1FHLgp1V0p212/38fPOYi8OTB0NEhx
	I0XgxulgS9n+qpBZGwtNxUgP+4xYFmAYEgNTIu08HknvvPR/JL76lF64Eh9tq+n1
	3YSlLuGmKopXiSiy5z9IJxHZYKD6JJoY7Lzyh2kdaGk7fZu1ul7R0nBlwt787Boo
	xdED2Zs2rAdXXxkOqaxTqX60wplI+SGLO1L5hktLkuC64iNh2vUgA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ktv7us2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Mar 2026 07:17:33 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62R703lh012185;
	Fri, 27 Mar 2026 07:17:32 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d27vkeaa4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Mar 2026 07:17:32 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62R7HUEb42729946
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Mar 2026 07:17:30 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7D10D2004D;
	Fri, 27 Mar 2026 07:17:30 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4203720043;
	Fri, 27 Mar 2026 07:17:27 +0000 (GMT)
Received: from li-3f69264c-2ce6-11b2-a85c-c3f414d24014.ibm.com.com (unknown [9.124.208.5])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Mar 2026 07:17:27 +0000 (GMT)
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
Subject: [PATCH v3 04/13] selftest/mm: fix cgroup task placement and drop memory.current checks in hugetlb_reparenting_test.sh
Date: Fri, 27 Mar 2026 12:45:58 +0530
Message-ID: <1ac1cac332a692e8d2dd70922bb09c0582340143.1774591179.git.sayalip@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: nClAz5ZwK--x8O9PZsjdr8Q-McgxQ6Fp
X-Authority-Analysis: v=2.4 cv=aMr9aL9m c=1 sm=1 tr=0 ts=69c62f0d cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=VzA434MTnXPm7y74YIgA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDA0OSBTYWx0ZWRfX+g1VmU4Asptm
 ANGogRNCkIBLPD3mUxT7GW3ywiXj58+b1eTDUb7FthFEpZgPNfc+AQhpol+hc/9J/B48Bq5UZb2
 740knBX9CusAkQGHpmu06rDOAZcqdQiulVEnUaN2Yic5CEEM/GDUg0YF260s8fDJvhi+wmHT0Oq
 Ws5szmbYeeRI0y9CWCwsKr7NaSmHoHh3mlUbj2xBYtBqYa3sv6UtlNxSdE/a/LAGqu6pM9TsF/C
 jBvN09Fcl/8sYWil9QFNv8+oGBPk486GDaFdsOFBHlXaq2s0sQZhmpZV4Z961HNvND6ejTcWA7z
 Nmi0+MqkiSak6+ROVsme10ab4frCQNPsXoe3ut4VUUpVPM53pclPzNomXrym0DbnzA+FW6pZqOE
 mJil+RdcI9w39xXkFke+CJDFyDFStGw7BR/5sCrbwianQjAFkeaC977yjGJSeJ9YbdjFCTPprvb
 Gzawrg2bQ4uihEP5lIw==
X-Proofpoint-GUID: aWkKOPYTflOioW1srNbD4X76iJFqi4P5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_04,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603270049

Launch write_to_hugetlbfs as a separate process and move only its PID
into the target cgroup before waiting for completion. This avoids moving
the test shell itself, prevents unintended charging to the shell, and
ensures hugetlb and memcg accounting is attributed only to the intended
workload.

Add a short delay before the hugetlb allocation to avoid a race where
memory may be charged before the task migration takes effect, which
can lead to incorrect accounting and intermittent test failures.

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
 .../testing/selftests/mm/write_to_hugetlbfs.c |  5 ++-
 2 files changed, 22 insertions(+), 25 deletions(-)

diff --git a/tools/testing/selftests/mm/hugetlb_reparenting_test.sh b/tools/testing/selftests/mm/hugetlb_reparenting_test.sh
index 073a71fa36b4..1e87ac67d43e 100755
--- a/tools/testing/selftests/mm/hugetlb_reparenting_test.sh
+++ b/tools/testing/selftests/mm/hugetlb_reparenting_test.sh
@@ -104,22 +104,17 @@ function assert_with_retry() {
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
@@ -153,18 +148,17 @@ write_hugetlbfs() {
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
+  # Spawn write_to_hugetlbfs in a separate task to ensure correct cgroup accounting
+  ./write_to_hugetlbfs -p "$path" -s "$size" -m 0 -o -d & pid=$!
+  echo "$pid" > "$cg_file"
+  wait "$pid"
   echo
 }
 
@@ -202,21 +196,21 @@ if [[ ! $cgroup2 ]]; then
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
@@ -230,16 +224,16 @@ echo write
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
 
diff --git a/tools/testing/selftests/mm/write_to_hugetlbfs.c b/tools/testing/selftests/mm/write_to_hugetlbfs.c
index ecb5f7619960..6b01b0485bd0 100644
--- a/tools/testing/selftests/mm/write_to_hugetlbfs.c
+++ b/tools/testing/selftests/mm/write_to_hugetlbfs.c
@@ -83,7 +83,7 @@ int main(int argc, char **argv)
 	setvbuf(stdout, NULL, _IONBF, 0);
 	self = argv[0];
 
-	while ((c = getopt(argc, argv, "s:p:m:owlrn")) != -1) {
+	while ((c = getopt(argc, argv, "s:p:m:owlrnd")) != -1) {
 		switch (c) {
 		case 's':
 			if (sscanf(optarg, "%zu", &size) != 1) {
@@ -118,6 +118,9 @@ int main(int argc, char **argv)
 		case 'n':
 			reserve = 0;
 			break;
+		case 'd':
+			sleep(1);
+			break;
 		default:
 			errno = EINVAL;
 			perror("Invalid arg");
-- 
2.52.0


