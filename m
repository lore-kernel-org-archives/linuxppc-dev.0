Return-Path: <linuxppc-dev+bounces-19730-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECAA4ED7B82
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Apr 2026 08:23:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fvy2M6SG1z308l;
	Tue, 14 Apr 2026 18:22:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776154971;
	cv=none; b=DRI5v/ykYygrZGPGv3tfFu6MKMKL5+hX9AZTq+wex+sC6oDb1SkSTGWyTMeUvLUrJDEZuZaxca+a8FnI8XWT//GXH2kLEK9DOkhmwHxUZy59R2qmzVwPBy1BFLpY8Ylv4ZiBxOa/N0uThSZVuruGMFYFzvNjz6rAIlauHuT9qQREiGySpnc45Vqb3/VGHmLS9pfUKXa8vrfiVewkEZcHZj40m6rh1f+V8me/M7e4uKvKazNfUiSgWykrm/FZ6m0arAMzu/vWe8LVedpZjJbnWZwI7SHygXGmORAzs08ydiAdvstXj6gWpDKTWadVJQ2eXTTYomaDmggVpbBiMzJYdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776154971; c=relaxed/relaxed;
	bh=jPQHHk1G3+UbX9ndrHFxBdN2tzOkHCyO7FB2/8YMMoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EdDBwu8/pqRnam7p0g+l+RNdaGw75wJ0fiRdDLLYEhRr4aGStBdm2z5i09Li6o7TMNs6AUBCsKEvV764yFVah+eFhjFHSgl28bHozRn3oJzm7fqJWWh8HnGsM65cFFvzDKbxwbs9OWtQ0tsa8rYyPXOAGXnrQKverchdLfxuSp68BbS2qBVSoieEycZyBX3EEaeTp4CQavK6NDt7bQ7CB0nuJCUhI5dcZBcKUZPsMXXr6CpxraPPX1gpNulJxAC+yPetOMmZL+48WCLPYnL6E3IRBQ0OQnlQvCfI6IO/4MVO3yn4H129v2m/nMX7kOuAB6VpayzX63ipTwaCgM7G4Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=tCpMLFMx; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=tCpMLFMx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fvy2L6PH4z2yFl
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2026 18:22:50 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63DLISFG1859895;
	Tue, 14 Apr 2026 08:22:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=jPQHHk1G3+UbX9ndr
	HFxBdN2tzOkHCyO7FB2/8YMMoI=; b=tCpMLFMxH9gVBM9BzYWudOnaQpsYUwgpC
	wCd9HpuAU3p3UhVVCbo5AJ9wEMiEvU+wVrkQ/bS2bWa+vJXtqlblFXsBJTUxxEJA
	1OuilwxTFPVnKMf1CRqRwViuBuyHakzXZ07XpMiHnBO39tYdWif7ETh7HSmL3YuU
	5mP3c2qTbPdMIyr/+rqyVALDdAUhh+W0bcQErNSfgFCVzOwHunMPOjB23KUAETI3
	GOHYO4J24G1jTM/POR+ODucphHt3ZEbk+8Q7KFAmqWeDAgUDWr3KJ9JweGUQFGDZ
	hefFojCfqSY4TiXeXa+OM1YIxEYgzrdYMoNNFtx8J3s+No+XQunqQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89p9pds-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Apr 2026 08:22:37 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63E3UBEf015158;
	Tue, 14 Apr 2026 08:22:37 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dg0msgrqc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Apr 2026 08:22:36 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63E8MX8p51708318
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Apr 2026 08:22:33 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4617220043;
	Tue, 14 Apr 2026 08:22:33 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 14CC92004B;
	Tue, 14 Apr 2026 08:22:29 +0000 (GMT)
Received: from li-3f69264c-2ce6-11b2-a85c-c3f414d24014.ibm.com.com (unknown [9.39.26.223])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 14 Apr 2026 08:22:28 +0000 (GMT)
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
Subject: [PATCH v5 03/14] selftests/mm: restore default nr_hugepages value via EXIT trap in hugetlb_reparenting_test.sh
Date: Tue, 14 Apr 2026 13:51:57 +0530
Message-ID: <e148e4232d4b802795751a7766fcce8884c6e3c7.1776150071.git.sayalip@linux.ibm.com>
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
X-Proofpoint-GUID: rE0So6VxTRSr-JNZsHW_VohT8S-IPIVv
X-Proofpoint-ORIG-GUID: _c3onDjL4oP2oWKaZ33v_D6t8RMr7XNi
X-Authority-Analysis: v=2.4 cv=WbE8rUhX c=1 sm=1 tr=0 ts=69ddf94e cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=Ikd4Dj_1AAAA:8 a=VnNF1IyMAAAA:8
 a=dU9eaedoi-733nYHt2kA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDA3NyBTYWx0ZWRfX8pR7Jq7VxSXV
 jwjTDKCAtn3iBPFdJ+IkeLmbXZl8xVgk44EEPCAPHg3DO2+l2i3skRw+p1OBJegKJdc5YMV+Pcf
 E6i5yCnYds+6Nf0k65RMmZjyx2DozJt9a5wGN16v2LHbnsZMIge6XgovPDwN3/dKOR7kkIe3RMH
 8a8ROHDrfAJAoH2GEmFJuFWUGDLShJNuY3fm48rFq6gnXBLixGF4oyViRtFrtBo4grTFDCIN2j7
 iWkDsdJ7ATbOe/6tC8Pivvt1NEeDpFb77HEfffAuitfgf+TzzGHhTkXQFJ51JhK5MOMxTWZgW0S
 1XR5NyAgAUF0Z6chLdEdwJpTM3pLzFAZ6x9InNSmOrq0HUG+5NjDsySPZxiSxP4yQH9tbkdXrDF
 LRuwxfmco0iOQ1ke9fFcGxL6Y9+pmjcCPCjLbrKoCle04cm3OaDoqFvUROCSYGAfnLI1L4ogZo1
 2KVKEdenIi/ASrDFS2A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_02,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 phishscore=0 impostorscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604140077

The test modifies nr_hugepages during execution and restores it from
cleanup() and again reconfigure it setup, which is invoked multiple
times across test flow. This can lead to repeated
allocation/freeing of hugepages.

With set -e, failures in cleanup (e.g., rmdir/umount) can also
cause early exit before restoring the original value at the end.

Move restoration to a single EXIT trap so the original value is
restored reliably on all exit paths while avoiding repeated churn.

Fixes: 585a9145886a ("selftests/mm: restore default nr_hugepages value during cleanup in hugetlb_reparenting_test.sh")
Acked-by: Zi Yan <ziy@nvidia.com>
Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Signed-off-by: Sayali Patil <sayalip@linux.ibm.com>
---
 tools/testing/selftests/mm/hugetlb_reparenting_test.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/mm/hugetlb_reparenting_test.sh b/tools/testing/selftests/mm/hugetlb_reparenting_test.sh
index 0dd31892ff67..7ddb370e1572 100755
--- a/tools/testing/selftests/mm/hugetlb_reparenting_test.sh
+++ b/tools/testing/selftests/mm/hugetlb_reparenting_test.sh
@@ -12,6 +12,8 @@ if [[ $(id -u) -ne 0 ]]; then
 fi
 
 nr_hugepgs=$(cat /proc/sys/vm/nr_hugepages)
+trap 'echo "$nr_hugepgs" > /proc/sys/vm/nr_hugepages' EXIT
+
 usage_file=usage_in_bytes
 
 if [[ "$1" == "-cgroup-v2" ]]; then
@@ -56,7 +58,6 @@ function cleanup() {
   rmdir "$CGROUP_ROOT"/a/b 2>/dev/null
   rmdir "$CGROUP_ROOT"/a 2>/dev/null
   rmdir "$CGROUP_ROOT"/test1 2>/dev/null
-  echo $nr_hugepgs >/proc/sys/vm/nr_hugepages
   set -e
 }
 
@@ -240,4 +241,3 @@ if [[ $do_umount ]]; then
   rm -rf $CGROUP_ROOT
 fi
 
-echo "$nr_hugepgs" > /proc/sys/vm/nr_hugepages
-- 
2.52.0


