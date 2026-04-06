Return-Path: <linuxppc-dev+bounces-19403-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E279BEF4EC9
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Apr 2026 09:25:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fq3pK4Srbz2yr6;
	Mon, 06 Apr 2026 19:25:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775467529;
	cv=none; b=U0iyxSVXQqz7SON8mZmyWvQ/n8RLqMSMK9o5difi4l0drnPv099t9h8YboyC05eK2Ens6Mz/CtcC/toGWQBa2LhHJiQ86aIlY8qmfQvPB58fgWFD3x27JCPyNDmLKFpNCRe0lNjNCumSiXa9PBg/XN3JeGXr1DmWRsoyX6f3Ra1M5z5s39Vp9EL8THSAtLbFEn9e0lYntbPz2qHIIvObf0po4iFxb50H3E2c6J0wySv3/gVh3DKowtwPIe6nV2GIzley8ZDtRiGfXe1Gy97rSjwGcx9TxTD1vqmCPAnADWImIou+GDrnb3f0iaHr7M2+DlXd8farPgcj6/Hgk7WwRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775467529; c=relaxed/relaxed;
	bh=CSvmaAj6V5ARHCiQk029wh6wu3HanW0BDVcs/Uzd7Cs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SaDM/6dFwrhHfGJuoW49BhPhc6hfR8KLWErPRugY8MzJVmjBGO8nVr2y6GEtfs33DbacF1wf09BrcowFtqKEuJmtTaNcuNXuDBEAGgHiYQp04dCD8ZEtH5oshrHHyIMCOL+zamXu32mL5IRfjO72P9cJG/e9ykUz7ZYmolt9eW8OrspHzSZ2OmCjXAtYn8S+YHcT0ERrwjtPN0A/gH7G7n40zJlrCI/bNFHKLL1RV1L4NsP0qNZLO/DgfsPj2K6D+vsfl8KfYBGteACIVxHxP/+txgPO/8L4LIPfLEHRmht01OTK58ClmXXhWJJaH2GPSqpYH/yKKJOlBTDjkGxrxQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=R1qgUStS; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=R1qgUStS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fq3pJ5wm1z2yr0
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Apr 2026 19:25:28 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 635EQPZC2819363;
	Mon, 6 Apr 2026 09:20:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=CSvmaAj6V5ARHCiQk
	029wh6wu3HanW0BDVcs/Uzd7Cs=; b=R1qgUStS8RZ/VnFx9mLUUtsH5+qq1crIO
	pCMadfppUhwV15dRgz/CWGWT4LzSc0Zt6pO2abE+WoBj0QZKpC6bWU0M22vkUcMf
	p+rydwoDZdi2P1TURTA4LMhNlgXSZ5RFe4l+5POR5ohQVfiH4hQd/IP5OjBi2Y3/
	o45x6CLsiqEXRqh6Wd0fl6XfF28m4GKw3qFGkLjCTBLUDNCDIhwPkhw8fl+dkUvp
	Ye5DwitGqJDQTusMKkyJ7yjOFIHa+AE00zbeop/DnzZ+6Ja7Y9vXSp6Z4IldWnZA
	Rgm4F1HYAwC/cI9cVxALrFgEXjSjd1MgKOIvMmW5FORd+ETkpcEbA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dat9rdenx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Apr 2026 09:20:14 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6365xCrv020514;
	Mon, 6 Apr 2026 09:20:13 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dbdync2w9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Apr 2026 09:20:13 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6369K90R24183080
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Apr 2026 09:20:09 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2A1B620043;
	Mon,  6 Apr 2026 09:20:09 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CFBC320040;
	Mon,  6 Apr 2026 09:20:05 +0000 (GMT)
Received: from li-3f69264c-2ce6-11b2-a85c-c3f414d24014.bl1-in.ibm.com (unknown [9.123.3.209])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Apr 2026 09:20:05 +0000 (GMT)
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
Subject: [PATCH v4 07/15] selftests/mm: free dynamically allocated PMD-sized buffers in split_huge_page_test
Date: Mon,  6 Apr 2026 14:49:26 +0530
Message-ID: <a61c264c824d140a948db64b2e1036bc4229d163.1775466330.git.sayalip@linux.ibm.com>
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
X-Proofpoint-GUID: F0fUoqfGsny2Ii1mqseYYZJuov0AU2po
X-Proofpoint-ORIG-GUID: -BTSCnmXb2KuszdYrQuMq8hlBjmqgjBL
X-Authority-Analysis: v=2.4 cv=bLYb4f+Z c=1 sm=1 tr=0 ts=69d37ace cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=-_7HawjV-lAcONoB0f4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA2MDA5MCBTYWx0ZWRfX45R/R63BZB0M
 N4kN9iZYf2Wd+fJiNbYB/PkWr4elj9brr2+1sQtJQE005JXM9XEWNh8HrZd6/GH44+1HWXr+RFK
 yC8rrT2gu8plX5gpd9SW+M9otqvQbpsTuAtjVVjoE1O5exeMMw6PPN8ecQDE3ftUW4Ytx6dqcij
 xrsDCPeYndmpS0ridYE5GalFNlU84cARlDhF7hqh5SQRQpF6PSAMDM4XodRjXBtuYJ/VYFMC82i
 U+tmYte0KC5TJ8erW88J5uAuc2bOcZEqp9Bf6EwghwC9Wgo/DLc3QZfX1P95dqu79ug9c64lr61
 UeFrwgC6PpqsLmj4eCDoZbEO77AZKzAIhPr1FNKd/NW7N+29IsuQVtqJir2JPZca5IvldW0uTOl
 5161Swyfhv8IxppT1By0JxBsyVsQazRa+3uOgJRiww4rH7nrsgKru+X2B2dYf8dX//RYjlc8YN/
 zkmcqyMJNs+0kqWw7Eg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-06_02,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604060090

Dynamically allocated buffers of PMD size for file-backed
THP operations (file_buf1 and file_buf2) were not freed on
the success path and some failure paths. Since the
function is called repeatedly in a loop for each split order,
this can cause significant memory leaks.

On architectures with large PMD sizes, repeated leaks
could exhaust system memory and trigger the OOM killer
during test execution.

Ensure all allocated buffers are freed to maintain
stable repeated test runs.

Fixes: 035a112e5fd5 ("selftests/mm: make file-backed THP split work by writing PMD size data")
Signed-off-by: Sayali Patil <sayalip@linux.ibm.com>
---
 .../selftests/mm/split_huge_page_test.c       | 22 ++++++++++++++-----
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
index 57e8a1c9647a..98319cfaf9a8 100644
--- a/tools/testing/selftests/mm/split_huge_page_test.c
+++ b/tools/testing/selftests/mm/split_huge_page_test.c
@@ -487,12 +487,15 @@ static void split_file_backed_thp(int order)
 	unsigned long size = 2 * pmd_pagesize;
 	char opts[64];
 	ssize_t num_written, num_read;
-	char *file_buf1, *file_buf2;
+	char *file_buf1 = NULL, *file_buf2 = NULL;
 	uint64_t pgoff_start = 0, pgoff_end = 1024;
 	int i;
 
 	ksft_print_msg("Please enable pr_debug in split_huge_pages_in_file() for more info.\n");
 
+	if (!tmpfs_loc)
+		ksft_exit_fail_msg("mkdtemp failed\n");
+
 	file_buf1 = (char *)malloc(pmd_pagesize);
 	file_buf2 = (char *)malloc(pmd_pagesize);
 
@@ -508,8 +511,10 @@ static void split_file_backed_thp(int order)
 	snprintf(opts, sizeof(opts), "huge=always,size=%lu", size);
 	status = mount("tmpfs", tmpfs_loc, "tmpfs", 0, opts);
 
-	if (status)
-		ksft_exit_fail_msg("Unable to create a tmpfs for testing\n");
+	if (status) {
+		ksft_print_msg("Unable to create a tmpfs for testing\n");
+		goto out;
+	}
 
 	status = snprintf(testfile, INPUT_MAX, "%s/thp_file", tmpfs_loc);
 	if (status >= INPUT_MAX) {
@@ -561,10 +566,13 @@ static void split_file_backed_thp(int order)
 
 	status = umount(tmpfs_loc);
 	if (status) {
-		rmdir(tmpfs_loc);
-		ksft_exit_fail_msg("Unable to umount %s\n", tmpfs_loc);
+		ksft_print_msg("Unable to umount %s\n", tmpfs_loc);
+		goto out;
 	}
 
+	free(file_buf1);
+	free(file_buf2);
+
 	status = rmdir(tmpfs_loc);
 	if (status)
 		ksft_exit_fail_msg("cannot remove tmp dir: %s\n", strerror(errno));
@@ -577,8 +585,10 @@ static void split_file_backed_thp(int order)
 	close(fd);
 cleanup:
 	umount(tmpfs_loc);
-	rmdir(tmpfs_loc);
 out:
+	free(file_buf1);
+	free(file_buf2);
+	rmdir(tmpfs_loc);
 	ksft_exit_fail_msg("Error occurred\n");
 }
 
-- 
2.52.0


