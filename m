Return-Path: <linuxppc-dev+bounces-21279-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 359C9CD343F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 May 2026 06:49:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gLfBh0K71z2xnK;
	Thu, 21 May 2026 16:48:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779346124;
	cv=none; b=DXWkK9jcSH6TU8ZXZQ6DaOO4OhZ1UXlNLqRyIXCdtj6luI8uilZxB7/D1YY/gqQXpa1u6CmUIjVW9MNRo6WazQBd/cns2MbynMXsRI0fblScTE+5q23j3UE30zEGb8czcMSfErVCXMJm6G88yWXIOrPbSQvcKUhtjyYoxjMB9eBMNiFofCZ5se2kYV506WtlV63Mb55PxP8VZW5Oqu4GIe7uEl0kEqEJyweX9JAkLgEFNVCtxirIgLuxZkULlxjUgd3JvIgBmC2Y84sN0QBKUrqvY9G5nq4+9rw5zuJUULKns+/7UcJTbYz5AC40fMoQQPGg+dInxfySBwhfRfb3Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779346124; c=relaxed/relaxed;
	bh=c75aam0Ymf20+UpHFk7pH2xwhCNVScu6l+3UVxdrvZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ul5jlIrnQbT4qRwM9tr6e7aHo3yNh7gH39uD5cRvzOTbTKxn2dcHnIDcGwgj9rz+z9E1/QM7Q2STnUiREydeyMLR1pWhS3wv/F1N7VFZ+82vbND22g1YAQsh1Ki3FAowu7Cx2garxdTi8okMQ/u23HDDzcecYBbpei6dMrQJrLX4aD9+Swkkjw0Q3C61tW5IkjuEslq7az4OMfTBG9DxzUAuNgN+BW1qAZ1eOHcGHWCKzZT3ClkJgjB7AnB9w7QiLRfFf+9fNHypZYSNfgvdw1NQIH0EDELsE3mpWqtcdbHkfLIHHS0+CR3b99/4po5YfvhTFAVJWTf2b++TWnKrYg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=gBO+Kf5I; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=gBO+Kf5I;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gLfBg0vkHz3bww
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2026 16:48:42 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L2lBOm069628;
	Thu, 21 May 2026 06:48:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=c75aam0Ymf20+UpHF
	k7pH2xwhCNVScu6l+3UVxdrvZE=; b=gBO+Kf5I274AG57O6OQdAaXfl1n4iN762
	zICNnGqq4pu0bn+cw5BS+iB5PExV1yrY/NkvVHOJRguwuYuauVMY9ZCD87JuVeDU
	BrwPEvI4y5Iqj1jmYLA1g4OHG644sfUBLMbc45KQlHHJ2ji4kl0ApjyDLZ7OjKJK
	8FfmKLb8o2U3U7NmPcN19DYtjCFFCLWVOg/2GUCLSt3h4de0Tlyn6f4oTR7IVZYp
	JUFxW1Lc1fOc5WEx1U1R3fn7j4FsYg4mHr3eNm1gKpfUZ+uIvJv2l+gw9h57cYFL
	FPCDanC5GvwHAbKPCvlAutbz6K7KIju3EzNbmK+14yr70pDdwRmtA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h8mwfwg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 06:48:29 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64L6d6in003597;
	Thu, 21 May 2026 06:48:28 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e754gjkug-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 06:48:28 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64L6mPxp48824634
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 May 2026 06:48:25 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 330D320043;
	Thu, 21 May 2026 06:48:25 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 43BBE20040;
	Thu, 21 May 2026 06:48:22 +0000 (GMT)
Received: from li-3f69264c-2ce6-11b2-a85c-c3f414d24014.bl1-in.ibm.com (unknown [9.123.3.209])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 21 May 2026 06:48:22 +0000 (GMT)
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
Subject: [PATCH v7 10/13] selftests/mm: skip uffd-wp-mremap if UFFD write-protect is unsupported
Date: Thu, 21 May 2026 12:17:50 +0530
Message-ID: <c3c5af76d71d5f4446f773f4de94882efc33ebe4.1779296493.git.sayalip@linux.ibm.com>
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
X-Proofpoint-GUID: w3CxwwPr800L2Lw7kCvtEmxLurTbiHzo
X-Authority-Analysis: v=2.4 cv=GYMnWwXL c=1 sm=1 tr=0 ts=6a0eaabe cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=njH7lnjfnPuJvX8OOgMA:9
X-Proofpoint-ORIG-GUID: im54uowdCAl_43vhwGui22KJhSluskMK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA2MiBTYWx0ZWRfX3jD4vaifPvzr
 5Mp2iMho1gyyXWLaDQz3bREV2Ilk+rlomm6P3jjo7qVO37XuU15J3OhVsHuqshqDgiKGwhkAcIz
 /aE+n7iP2kGCboZ5umA3w0sXANwezvTxM7cA2IhL75bwQIrrKfi1T6lTjdzTO14FB3fnvgRp64X
 zkiVcIGnqF6F66jLg443RfuXm61C0/BxScyE+H84s6uvYzdT9pLoLjEERqgULOCVesidOj0BVIp
 VXE51Q3ARI1M7FenoMOTHRZJovtCpOf0A84eSQ2pV1NDQChmL12b3nPykdxk+YIk8hJR5h2jCVy
 9/M0nc8neARN834hE60ls9FVYOc74Bk2deDeulgRwpvN1S8a6y86zOKuoz75neW4vKbjXavEF/D
 Ckg2awmcbj14aSlU0ZVkO3cb7lJ6VffClToo+adirO3a6RPSFwLF016s3NUpC/vk6JZH7kiZXug
 1e9vB2vQ78MkRUVR68g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210062

The uffd-wp-mremap test requires the UFFD_FEATURE_PAGEFAULT_FLAG_WP
capability. On systems where userfaultfd write-protect is
not supported, uffd_register() fails and the test reports failures.

Check for the required feature at startup and skip the test when the
UFFD_FEATURE_PAGEFAULT_FLAG_WP capability is not present,
preventing false failures on unsupported configurations.

Before patch:
 running ./uffd-wp-mremap
 ------------------------
  [INFO] detected THP size: 256 KiB
  [INFO] detected THP size: 512 KiB
  [INFO] detected THP size: 1024 KiB
  [INFO] detected THP size: 2048 KiB
  [INFO] detected hugetlb page size: 2048 KiB
  [INFO] detected hugetlb page size: 1048576 KiB
 1..24
  [RUN] test_one_folio(size=65536, private=false, swapout=false,
  hugetlb=false)
 not ok 1 uffd_register() failed
  [RUN] test_one_folio(size=65536, private=true, swapout=false,
  hugetlb=false)
 not ok 2 uffd_register() failed
  [RUN] test_one_folio(size=65536, private=false, swapout=true,
  hugetlb=false)
 not ok 3 uffd_register() failed
  [RUN] test_one_folio(size=65536, private=true, swapout=true,
  hugetlb=false)
 not ok 4 uffd_register() failed
  [RUN] test_one_folio(size=262144, private=false, swapout=false,
  hugetlb=false)
 not ok 5 uffd_register() failed
  [RUN] test_one_folio(size=524288, private=false, swapout=false,
  hugetlb=false)
 not ok 6 uffd_register() failed
 .
 .
 .
 Bail out! 24 out of 24 tests failed
  Totals: pass:0 fail:24 xfail:0 xpass:0 skip:0 error:0
 [FAIL]
not ok 1 uffd-wp-mremap # exit=1

After patch:
 running ./uffd-wp-mremap
 ------------------------
 1..0 # SKIP uffd-wp feature not supported
 [SKIP]
ok 1 uffd-wp-mremap # SKIP

Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Signed-off-by: Sayali Patil <sayalip@linux.ibm.com>
---
 tools/testing/selftests/mm/uffd-wp-mremap.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/testing/selftests/mm/uffd-wp-mremap.c b/tools/testing/selftests/mm/uffd-wp-mremap.c
index 90ac410c6c6f..c973d6722720 100644
--- a/tools/testing/selftests/mm/uffd-wp-mremap.c
+++ b/tools/testing/selftests/mm/uffd-wp-mremap.c
@@ -19,6 +19,17 @@ static size_t thpsizes[20];
 static int nr_hugetlbsizes;
 static unsigned long hugetlbsizes[10];
 
+static void check_uffd_wp_feature_supported(void)
+{
+	uint64_t features = 0;
+
+	if (uffd_get_features(&features))
+		ksft_exit_skip("failed to get available features (%d)\n", errno);
+
+	if (!(features & UFFD_FEATURE_PAGEFAULT_FLAG_WP))
+		ksft_exit_skip("uffd-wp feature not supported\n");
+}
+
 static int detect_thp_sizes(size_t sizes[], int max)
 {
 	int count = 0;
@@ -338,6 +349,8 @@ int main(int argc, char **argv)
 
 	hugepage_save_settings(true, true);
 
+	check_uffd_wp_feature_supported();
+
 	pagesize = getpagesize();
 	nr_thpsizes = detect_thp_sizes(thpsizes, ARRAY_SIZE(thpsizes));
 	nr_hugetlbsizes = hugetlb_setup(1, hugetlbsizes, ARRAY_SIZE(hugetlbsizes));
-- 
2.52.0


