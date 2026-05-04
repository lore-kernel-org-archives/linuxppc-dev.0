Return-Path: <linuxppc-dev+bounces-20405-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C6EAFF885A
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 May 2026 08:26:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g8F8d1Wlvz2yrD;
	Mon, 04 May 2026 18:25:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777883153;
	cv=none; b=b4g8AwUVrLK/tbq40XHIID69xNOb7SXyvc1Bqbf8rLfhgxOUy9OI+lnDMLlFHMJ6VZVPrmzjIHHQy+cSugw29KxEIjn+M27PE/tv+fv6cOqGBP5iJnv/adpjaCS5q8pacDXSg5siB2iPddARpzqu1PfuI0M3Jt7Q17MJ8sgaVqf21nMISooJc46ZlBgURPNrP4b/8dRQGyQPUDxaHfps0i41q3ncpEakZDSxmZxHBEX1GI1Zf0L80XDuVoLOGmW0jP7ZGsM8YXK5KRMDeBTpKjH27vcVwlZlSDrwXp1DPjFySFUpKAuIqkG/O0PDBK/53RQa5EWk9/JFAAjZtrFrag==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777883153; c=relaxed/relaxed;
	bh=uCeyz74EmYofYeqL3Urq7QausJraeZ1cxOiTgZXAkeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f6dg2E7O9APsr395J7f06r4MZyT8ETcU6VChNFbxSQlxdtg+T4VhcZvHStHGwcd0+XFekDYZXCSWu1UVvxQtLiPR0u7Z5Cb8Z73+v37L5Gtl6/pSdRP5j72K5IbDlmYMhxSx+fDSv4uuFMAZHZCdwyB5QSuBMVyLIiM7c7kjIulqWPm7WVXQI5RGx1i0ICsOv0I7ytAmBBcH47dJHBtsARpnsr01t9X7EfkHsJdwBqdnvNw5N9t8lByMPAtBm9VhhddiEn1OfK2FwSA6u0wnoxc5jh9OQY7dXctCooDGOuLXXw0Fg9FoY8eVFE/M8BDhGxZawxMYpyyZTgvgGcsP6g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Fnm0Md/y; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Fnm0Md/y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g8F8c23KSz2yZ6
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 May 2026 18:25:52 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 643IrjgW2799040;
	Mon, 4 May 2026 08:25:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=uCeyz74EmYofYeqL3
	Urq7QausJraeZ1cxOiTgZXAkeQ=; b=Fnm0Md/yyzl/ggFyBOD+XznTaPE8Ma5vW
	bjUQIap9ktpztVFjjAws05U+VfZn4DUHeM8GLi3J0fX4qcgM06whk4P1Hg8+MFkT
	dlh4G0RBAWe4VbSmqMrohvvn1/8OE9fIs702riLTFNI64tmOFwEmoK69hj2oXeVP
	lldgZos0DDXG9ZIN8WfCRuFbzZkdrV0Nq8d6Y1aD2j8bpZbqdevKRNo3HIXn8fPK
	Xu9zXL2h3OCuXpjnEBOLJ9Xn/FIeY/6XakRsdRj+M6+Pkmpr9+N3tr9QbEvQJOjn
	ozRyeox6uRGksl/x21WDsc58Ny57lgY/bJM72C9M0Mep2VJs4iD4w==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9w65y25-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 May 2026 08:25:33 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6448OQJY000508;
	Mon, 4 May 2026 08:25:33 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwukq4fre-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 May 2026 08:25:32 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6448PTqX15991210
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 4 May 2026 08:25:29 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 774DF2005A;
	Mon,  4 May 2026 08:25:29 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6878320040;
	Mon,  4 May 2026 08:25:26 +0000 (GMT)
Received: from li-3f69264c-2ce6-11b2-a85c-c3f414d24014.bl1-in.ibm.com (unknown [9.123.3.209])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  4 May 2026 08:25:26 +0000 (GMT)
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
Subject: [PATCH v6 07/14] selftests/mm: free dynamically allocated PMD-sized buffers in split_huge_page_test
Date: Mon,  4 May 2026 13:54:44 +0530
Message-ID: <284a28bcb68ffeba32a63cdfc5644975815973a3.1777877814.git.sayalip@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1777877814.git.sayalip@linux.ibm.com>
References: <cover.1777877814.git.sayalip@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=XPQAjwhE c=1 sm=1 tr=0 ts=69f857fe cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=Ikd4Dj_1AAAA:8 a=VnNF1IyMAAAA:8
 a=9VAv6nXQuNVwvrTyzFEA:9
X-Proofpoint-ORIG-GUID: 3NARXhqaVgACSO_I13XtfUEikqObqf1c
X-Proofpoint-GUID: zqv2kH9Cun2FQ6nxcdQ-98MLNnIB45J-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDA4NyBTYWx0ZWRfX+zyGMht+WxUk
 ChqxGYmpjLR006zp5rDvGaCuk9pky04zC6g4zhSs0tblFmA/3rrpNBu2jqDwibBwo6XhOHVE2Il
 5SQRSm+6m7FAoeGX5hH8dJ9RHkZ/7vtUcDey9P3+oTccNBNHcufVz9H3Mp9y/fLAmgTvDWYjVhp
 854jDdQsQNH6/4ykJyvia2gfIBJKIKYiRu1p8QJp9d4/SAmNTtMNvaQuXOt37XslcskCwS/w05e
 JGoR/j9uYkUwwuQL2XRX1UI6VY2X3xs+c+rU1SM0VTyIf2yKHZsxRoSrJnHOu5iWJplnqrdxZnQ
 vXZzkvtGhbE6xXMTj6riWlnsGp+xjZQVfr6UR/IdeGopTY4RlBocYMfFDKxtd+nXFFBhS57uB86
 BLB52hQX+uEQABEbltpyBS7W6rJJ/4yjz+2YfkN9nXu1U6CtVONhyD/ipkgUCSMy1mzexu7bRnq
 q1bJRJfwsnAiBk+od2Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_03,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605040087

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
Reviewed-by: Zi Yan <ziy@nvidia.com>
Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Signed-off-by: Sayali Patil <sayalip@linux.ibm.com>
---
 .../selftests/mm/split_huge_page_test.c       | 22 ++++++++++++++-----
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
index 02938f38b880..ee256afecd8f 100644
--- a/tools/testing/selftests/mm/split_huge_page_test.c
+++ b/tools/testing/selftests/mm/split_huge_page_test.c
@@ -473,12 +473,15 @@ static void split_file_backed_thp(int order)
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
 
@@ -494,8 +497,10 @@ static void split_file_backed_thp(int order)
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
@@ -547,10 +552,13 @@ static void split_file_backed_thp(int order)
 
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
@@ -563,8 +571,10 @@ static void split_file_backed_thp(int order)
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


