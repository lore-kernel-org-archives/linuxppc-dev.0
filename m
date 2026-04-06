Return-Path: <linuxppc-dev+bounces-19388-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BF20EF4ECA
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Apr 2026 09:20:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fq3hc5b7Mz2yfS;
	Mon, 06 Apr 2026 19:20:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775467232;
	cv=none; b=Z7te6DcUZ7oDiRjESKpLftV3YY5NJ7obaFhm6kxzQFCK4YSRt4H5PshVvQkfEcTlCFvnSf4FNVW3fPt/lKKErhXP5vEVFE5MD69tPu7Ew5Ul3NgYBzHUh7HZmotyJ+bPhj//SR1kHdrL6Y9Ix29AlAhbt4iWEdjIWt5MxhcaJPnb3g8eMXmXti9+mIv67E74m1ix+4dH877ryH58Ozj0Ybh/xqJZjt0xiIh1kVQz16Rqbc7dH+AWk19hOyqnh02hm45CiVcK4DfcI4ic2jWjQrw7MmrbDl8uFdX3YMsNBWlkXM9e3//ZBKLPSC3OZGBLPuqN7yfrkWIOxq3+Ofe3ng==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775467232; c=relaxed/relaxed;
	bh=BE2EUKU/McYWqo37ghWd6Kx9zwh5R4g+dFW5eL2I394=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OH5JperDHo7aNnpbKh1tEWgphmjnhvD2FgjE2tBiaBqHcmRnG6rh+X/lUb2fe4jl7WO9thVupwfdhWLZMD3DEYmRWc7AOCj2sYJsMagvyNPcuG6Kw7S3RLAOHryQ7sWtpxFJ1vkQMJIl80BVKZzyL34W1MWb5cjTqJUEllb8CfsHX4D8VRbLMKRQKdwfVt7naC+/WYjvuy8LCb5EcfBm91ca7Aa40/yeU7BxQtqjtOHYU9/NxX3B01+ulbD1gCKsoYkUXPaUPDbZHnTseeFOPPCe7M3+EcMAcF0rknh0hRK4sgm0K9fZYYMdWLXklE37JedKsxban2kflBL305J/ig==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=gjg7yGsB; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=gjg7yGsB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fq3hb5X6bz2ySV
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Apr 2026 19:20:31 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 635NsWYM3879301;
	Mon, 6 Apr 2026 09:20:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=BE2EUKU/McYWqo37g
	hWd6Kx9zwh5R4g+dFW5eL2I394=; b=gjg7yGsBRkoF7CHo65fX+pLrIWM+OOSgy
	zqlDQhYqlezV2pGIRoepQHzM43iQWNXysqWSXzK6l4JEHdeeq7QshpAiN3DUkigh
	DNhXnSuBfsJICk58vGs5LswJEmg6KjSOGiSSw9zUYOR6zIrd6Yb1XGhF6PTnBCv/
	8VLR3BBne7RDQp9jIz1B8MX2OuIn8fTVUQcvaE5jJmZLlQcIVQULBei69Uc0odHZ
	VmBtiR6S/lJngJz909fbkUTg01cDfqzNyckGO6fkezmBVdAJy/VYURxgSn2i70ma
	NMMkoO86qIy5Sj//A2XrXX8ZGkDFG565A8nYZ7/OsKvuCfVqVZdxg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dat9rdems-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Apr 2026 09:19:59 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63646psp018571;
	Mon, 6 Apr 2026 09:19:58 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dbcysv7b0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Apr 2026 09:19:58 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6369JsKr42729738
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Apr 2026 09:19:54 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 447AA20043;
	Mon,  6 Apr 2026 09:19:54 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7762B20040;
	Mon,  6 Apr 2026 09:19:50 +0000 (GMT)
Received: from li-3f69264c-2ce6-11b2-a85c-c3f414d24014.bl1-in.ibm.com (unknown [9.123.3.209])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Apr 2026 09:19:50 +0000 (GMT)
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
Subject: [PATCH v4 03/15] selftests/mm: restore default nr_hugepages value via EXIT trap in hugetlb_reparenting_test.sh
Date: Mon,  6 Apr 2026 14:49:22 +0530
Message-ID: <e148e4232d4b802795751a7766fcce8884c6e3c7.1775466329.git.sayalip@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1775466329.git.sayalip@linux.ibm.com>
References: <cover.1775466329.git.sayalip@linux.ibm.com>
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
X-Proofpoint-GUID: W7LetLeRBK4_w-4UpW93fUvAyuxjOU07
X-Proofpoint-ORIG-GUID: G6LyCCgjL_tmGz3AUnWmYTvfJ_jmTIYE
X-Authority-Analysis: v=2.4 cv=bLYb4f+Z c=1 sm=1 tr=0 ts=69d37abf cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=dU9eaedoi-733nYHt2kA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA2MDA5MCBTYWx0ZWRfX41v18ENz44Zy
 r2Qcb5Z0AFbmVskgq/xuF2WLv8FzVjzo/Dvz6OSGz4RHEbYvZdgZPmIfnGSaOUi38C7/0ib0bsl
 bXwYTHdAaBxhwM9aOXnAEMKo//dOnm8AkVYynRa2Dg1vYFHa9ttw0IHprVYEvHkHex/3oJpm+la
 1/GcOS3fCt/DExCJlCPxKAJb1lVi6UL6vdQN6MBvlvy1zmhQ15gHTg52tgmDfvLgEUp8plCADgG
 212iGeaOWIyKSpCPTuN/F3m/76OyCYv7GDcPlvqv67tv7CRAVQsaJei9eK0ytLkJnr7ee5XYkw4
 KSqW2XyUdRSvSle6yTziS+/rfJ7TP8XwNuQ1+8EK9vkEXxdWHHjg3RwkqnaQWHIBk05IL16jRVF
 5SgWdUf1fpGsBM7pR5eoBM6l46QslyoTiS2cegLSEI3dusjc/C/U6nehmmX2V0QzIfYk92aOJbX
 TLSkaT3fxMiJO4JLiSQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-06_02,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604060090

The test modifies nr_hugepages during execution and restores it from
cleanup() and again reconfigure it setup, which is invoked multiple
times across test flow. This can lead to repeated
allocation/freeing of hugepages.

With set -e, failures in cleanup (e.g., rmdir/umount) can also
cause early exit before restoring the original value at the end.

Move restoration to a single EXIT trap so the original value is
restored reliably on all exit paths while avoiding repeated churn.

Fixes: 585a9145886a ("selftests/mm: restore default nr_hugepages value during cleanup in hugetlb_reparenting_test.sh")
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


