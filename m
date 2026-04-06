Return-Path: <linuxppc-dev+bounces-19399-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC43FEF4ECA
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Apr 2026 09:21:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fq3jD1FzBz2yjw;
	Mon, 06 Apr 2026 19:21:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775467264;
	cv=none; b=my2QHOWUtxJVnP62mbqKrs9TBbZZsuOivdSlNw+bSo02lLpHl7RmZAnoxQUBlX3wmZEEmi2gi8jUkB4oAPB8svphSnW4bCSFmhCwUWyGhgJJxSEwyIatgbelBVU4421yrZ0N/wfxv7X9r7VHCX87nfCt9QmuJtPI2aM+EHm8jbJVEWp/mNNDcj5/NJRQMI+HxuAlAFhJPYUUkWVO8w3Fqi73Yc66+kXzi4Rqv8T36pV31L2rxVOPHYRcb8TT48BcxGSwP4FdwGi7HXhceDCKN6JnHBUazWcrvLMNwrkM0UV8Dxp1vsd9dmD1Y/Ekup8dhk8AzOcrKgddmRbQPJlhBg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775467264; c=relaxed/relaxed;
	bh=Gw+rjcKVM5h6GXjQfCYysJfzzPt4h5VbBFTgu6oDlxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iNw/gDRVYcBHeAmGsAd7q1ab3KBLAftN/fbRml4HUNPS2MAl9PipRX/o65eHpaFuMBloeXrgH52EUCF9m/pAulnqbZW12Wm8R1dOWAwNIdLdK6+4f/kMC8/tcqPzWdxSbbiY1TEzwPX3ZubOPXtC15cRT/06Z7fXn5bon7CYDqmU4160/uRq36jm/tKMEYGNg+ocxV5V0oFpRoz3ar/xnNeZHtzNrPieuSvj2gT+muJEVHbqJ4ygiFpqJUdXaBjfWAFpQPXje+wNqnrLGaIJTycwgYp+RC4za8OYXjzfmqvZbb6cBmKjdrAH84DiEWLIpCrqJ8AUO7/ljS8MR2XqQg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=AePv7Mh6; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=AePv7Mh6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fq3jC3Plxz2yhP
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Apr 2026 19:21:03 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 635HrobP3217351;
	Mon, 6 Apr 2026 09:19:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Gw+rjcKVM5h6GXjQf
	CYysJfzzPt4h5VbBFTgu6oDlxM=; b=AePv7Mh6wpi2Ed/SBNZJotX5rwyc0O+jF
	SAXfk9LfzF/c2OGiHrJOejx2ejRWqXITtv5AEm0xyQAO28r+nZmEsr1wSN9NNZwM
	8WByYFGgucrBIzac9VrEf78nNVcrR2jr+56RBFck+/9kIR0l+At2YXRCUORGoNEw
	w/L3XztUrez4u/9R1Id0BBoE2x5/B78qRsoIgsQ+BnYv030v1fRXZEgk6qIpB5+0
	gzvBNbAa/Hcowou+7NEM2uwRiv9L5mqhX+NLxCbQBg6eGX65kPP52vKE00vW6eqS
	e7D98FLTJj1I43XFxrmlEKiVuiUdC0xEw0NSMHnUTk+eZdTDWvrGQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4datc2nwgu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Apr 2026 09:19:50 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6364jCgR018517;
	Mon, 6 Apr 2026 09:19:49 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dbcysv7at-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Apr 2026 09:19:49 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6369JkDX28246616
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Apr 2026 09:19:46 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 15E3220040;
	Mon,  6 Apr 2026 09:19:46 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7A83A20043;
	Mon,  6 Apr 2026 09:19:42 +0000 (GMT)
Received: from li-3f69264c-2ce6-11b2-a85c-c3f414d24014.bl1-in.ibm.com (unknown [9.123.3.209])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Apr 2026 09:19:42 +0000 (GMT)
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
Subject: [PATCH v4 01/15] selftests/mm: restore default nr_hugepages value via EXIT trap in charge_reserved_hugetlb.sh
Date: Mon,  6 Apr 2026 14:49:20 +0530
Message-ID: <8beb895ae46c3e817e80cdd5386933cdcf8e233f.1775466329.git.sayalip@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA2MDA5MCBTYWx0ZWRfXzyKLtulSDSth
 IFqReIpcfgL8hR7NqxmS2WDI6atp0Tuwnpsep9+D7WP5qLtCinM6WdACbnC2x7ZZgR/4Z9mpqbP
 upl/AOBOoEiCZyb33rW9p1as55zdcD6nUk0vuJsWgJ6U78oM0IULBQo1hPPUHawmgr2B0rUOn1h
 QqqvTCNv3d+tRb77WvDuPh/AqVxnA8D6oPBsNd4+p/wFa/mtiWv9UvMVGqqbm+DABCRgT01TdjP
 9MBEN6AOsPnSRR+IHqw/1aXEGvOJSHKSbwAsK0hAkDVdzJ+4mvWIWk7nre7dHhoGRR/hL083x0n
 2s1jdLxeEHgRbQZ1LUn6zzYheeBIBY/tBnAPmp8DanxWJavbaDkq2klA/IFelFNhhqSPEXezsxS
 s1xpsAKk0SBvswls3ZZTPIvXRUxqUw0ws+JjRw5SCxH0xbo940n0DYnAaW7pCy9MLvhwAGhpbK5
 K3zpVns/DplhG1DRvgw==
X-Proofpoint-GUID: nK63GTggKdNRTYW7Z81LZfRvqmynf4OA
X-Proofpoint-ORIG-GUID: J-QzRBArbcHki7t0X32IBjJIHzxx8zwY
X-Authority-Analysis: v=2.4 cv=HJvO14tv c=1 sm=1 tr=0 ts=69d37ab7 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=C3DWCGp_6AllTJ2cH5YA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-06_02,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 malwarescore=0 spamscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604060090

cleanup() resets nr_hugepages to 0 on every invocation, while the test
reconfigures it again in the next iteration. This leads to repeated
allocation and freeing of large numbers of hugepages, especially when
the original value is high.

Additionally, with set -e, failures in earlier cleanup steps (e.g.,
rmdir or umount returning EBUSY while background activity is still
ongoing) can cause the script to exit before restoring the original
value, leaving the system in a modified state.

Use an EXIT trap to restore the original nr_hugepages once at
script termination. This avoids unnecessary allocation churn and
ensures the original value is reliably restored on all exit paths.

Fixes: 7d695b1c3695b ("selftests/mm: save and restore nr_hugepages value")
Signed-off-by: Sayali Patil <sayalip@linux.ibm.com>
---
 tools/testing/selftests/mm/charge_reserved_hugetlb.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/mm/charge_reserved_hugetlb.sh b/tools/testing/selftests/mm/charge_reserved_hugetlb.sh
index 447769657634..ca33ec83ebf2 100755
--- a/tools/testing/selftests/mm/charge_reserved_hugetlb.sh
+++ b/tools/testing/selftests/mm/charge_reserved_hugetlb.sh
@@ -12,6 +12,7 @@ if [[ $(id -u) -ne 0 ]]; then
 fi
 
 nr_hugepgs=$(cat /proc/sys/vm/nr_hugepages)
+trap 'echo "$nr_hugepgs" > /proc/sys/vm/nr_hugepages' EXIT
 
 fault_limit_file=limit_in_bytes
 reservation_limit_file=rsvd.limit_in_bytes
@@ -65,7 +66,6 @@ function cleanup() {
   if [[ -e $cgroup_path/hugetlb_cgroup_test2 ]]; then
     rmdir $cgroup_path/hugetlb_cgroup_test2
   fi
-  echo 0 >/proc/sys/vm/nr_hugepages
   echo CLEANUP DONE
 }
 
@@ -594,4 +594,3 @@ if [[ $do_umount ]]; then
   rmdir $cgroup_path
 fi
 
-echo "$nr_hugepgs" > /proc/sys/vm/nr_hugepages
-- 
2.52.0


