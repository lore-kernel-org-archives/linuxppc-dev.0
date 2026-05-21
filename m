Return-Path: <linuxppc-dev+bounces-21272-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 954BFCD4F3D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 May 2026 06:48:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gLfBL02hjz2xSN;
	Thu, 21 May 2026 16:48:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779346105;
	cv=none; b=nvdrIRXvsXbjbKkhhhcywDkTk2pSipAam6W2O1eIGwIsPqGujrdazlsONJs6Jq7KGEPCD6/mbj9+o1VLB7hqaYDgeapi7cSHXN67aqrfJCjLmrC8isptmIsvd+p6keJu8sTdh0rMz++3obhlttYMZebujqbx7HpFjovuPJbU8oc9qyHCJJPZzg6XIZljKafqikttz8WCpxdyd01N/2vSGu3ivXeJ0nXxPtP7PkqqGSm8xlQTinKzZ/M1I6Vnjl5jPdJ23MjMIJmaZD7+gsi3DFgGjNj1zNbp/Y7tB5RVFXZ8jbSrWXVQPcpx2W3oZ4GM2YMG+SMm4fcY+4nuIz24Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779346105; c=relaxed/relaxed;
	bh=wuvm835NB4tDr/INmAj8E4pEfzootxPjtudzVh0pFns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZGdOE/WDlH1rGlVUPz9BnZFPc/iZKo8zkjAXKM3z8oFO1OA04qCyzVi0zAZ0vhPNwTz0grlGiEHZVUD+LA4OtmYo4SrQ0qVFBxFBJ+x3IM23B/sJ7qvL+E/ckDYCcmUWCHBnQab9NE5iJb2/mVY8R0/4ufBbyKVchqDZ+uKqX6Ey3/H9ij5OGJlSEIDZgRt+Ftu3j2O1SKCtu6MW7DqPro0k1URY0pF0z2g/QJDgfertOG6JLwDSnbfXCirfrp6W/s+H7+u04krBTZNoVTK7GKtTvetywCHGub4WqnXDthTOeLOeIPN0h5Otorke1J40k0zcNHxQAUMiz0KWjT6E+w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=S1uj1feU; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=S1uj1feU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gLfBK0RkFz2xQD
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2026 16:48:24 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L4nxT93913287;
	Thu, 21 May 2026 06:48:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=wuvm835NB4tDr/INm
	Aj8E4pEfzootxPjtudzVh0pFns=; b=S1uj1feUmJDrzF8biPNYlSJlwZkvySj8A
	c0vtK40B9uOmElM3p/wooq7GMGYq6O2axnTQdeTfYIc5yRVBI0r/oSHBs15AlUiI
	W0XT9VyPCe11iuqYYMoD71j8p1oc4Wrf5h1ffu+WUBtwCccw9T3PZ8/uyUyUs2S3
	Tb/HVjajSRP8Im2Aj6ick5a5gjw06U3UR67kK8DfbXJc3BSRr9ZfHUSsES/hkZHy
	cBuNh2GYPstp3O+keUytMtW297WUFXcv2JJFCJFaqeWub0Ow92dFUu0mpMejWmzo
	cvaSZfvT/SrFG+sBTOHwgQTAXKDFLLnl8NG2gzQjTlRj8H5IUzGaA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h9y5k63-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 06:48:06 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64L6dBB8018365;
	Thu, 21 May 2026 06:48:05 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e75kyajd9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 06:48:05 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64L6m12e40829320
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 May 2026 06:48:01 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 986E120043;
	Thu, 21 May 2026 06:48:01 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C819E20040;
	Thu, 21 May 2026 06:47:58 +0000 (GMT)
Received: from li-3f69264c-2ce6-11b2-a85c-c3f414d24014.bl1-in.ibm.com (unknown [9.123.3.209])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 21 May 2026 06:47:58 +0000 (GMT)
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
Subject: [PATCH v7 03/13] selftests/mm: restore default nr_hugepages value via exit trap in hugetlb_reparenting_test.sh
Date: Thu, 21 May 2026 12:17:43 +0530
Message-ID: <29db637c3c6ba6c168f6b33f59f059a0b39c35c8.1779296493.git.sayalip@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA2MiBTYWx0ZWRfXyUiUAcSTpt4k
 fKUdI3XYMIKIt4FLxvFnjj4gx0nrIHMwvIuiRoKid+KvpYf6WGbDD3kPCTnYTm3yCLmk35LXTRm
 iuXfha/wH0vkSdb4evkhsq8OPAjEXAHZkPSC+q2b2d6bumllxqxXpiDfdQkc7x8DCeLlWZAgBJE
 w7fan0s7Q7EA/SYpjatFm0lTkRPdCENRA+aaj8iCsGkIuSgvu03gcAnldNRM/hGiZqeMc0mv90Y
 BRgqeP80klWcc0LukWJ2iliF08qtjfpwNEVqPCy8pOBDu9+AKecPbVNUm+kxxMUrbt8LKVt0sz7
 okVb5RXHIUdycvRtXSKdqISkIjLOkbKubtsoV3IbcfwzFzTaZ4OsjhYITf3h1Eprn6KstEM/ZxV
 pVVyxVBjkqiX8O1N+z9mtuxABQDQ/QbuTtHguCjRzkKSv1Z0ojbLyDYeFHPHqkMXywdSRr68Rh/
 xhoKAMrco2mu0fIwvbw==
X-Authority-Analysis: v=2.4 cv=BNuDalQG c=1 sm=1 tr=0 ts=6a0eaaa6 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=Ikd4Dj_1AAAA:8 a=VnNF1IyMAAAA:8
 a=dU9eaedoi-733nYHt2kA:9
X-Proofpoint-ORIG-GUID: G9G2dDS_3HjUZVGRrb2MsSArkdyVZq6t
X-Proofpoint-GUID: 6N2rSNS9x34ORBswSKiOSH2EjL8vY8sw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210062

The test modifies nr_hugepages during execution and restores it from
cleanup() and again reconfigure it setup, which is invoked multiple
times across test flow. This can lead to repeated
allocation/freeing of hugepages.

With set -e, failures in cleanup (e.g., rmdir/umount) can also
cause early exit before restoring the original value at the end.

Move restoration of the original nr_hugepages value to a trap handler
registered for EXIT, INT, and TERM signals so it is always restored on
all exit paths. This also avoids unnecessary allocation churn across
repeated cleanup/setup cycles.

Fixes: 585a9145886a ("selftests/mm: restore default nr_hugepages value during cleanup in hugetlb_reparenting_test.sh")
Acked-by: Zi Yan <ziy@nvidia.com>
Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Signed-off-by: Sayali Patil <sayalip@linux.ibm.com>
---
 tools/testing/selftests/mm/hugetlb_reparenting_test.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/mm/hugetlb_reparenting_test.sh b/tools/testing/selftests/mm/hugetlb_reparenting_test.sh
index 0dd31892ff67..11f914831146 100755
--- a/tools/testing/selftests/mm/hugetlb_reparenting_test.sh
+++ b/tools/testing/selftests/mm/hugetlb_reparenting_test.sh
@@ -12,6 +12,8 @@ if [[ $(id -u) -ne 0 ]]; then
 fi
 
 nr_hugepgs=$(cat /proc/sys/vm/nr_hugepages)
+trap 'echo "$nr_hugepgs" > /proc/sys/vm/nr_hugepages' EXIT INT TERM
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


