Return-Path: <linuxppc-dev+bounces-21276-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E4ABCD5BA6
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 May 2026 06:48:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gLfBY4jwzz3bpm;
	Thu, 21 May 2026 16:48:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779346117;
	cv=none; b=f6/wX0Ek0Psz++fyxf6H5B1wLP9uyuXh3dDSh5iQePrI2WK+mZadVcP76WHa+3s2jMHo+GxYx1+LY2Cw0+yh7aVJ0NS6onAV8uF+uF2cOFNzpCt2pHF/WXZ1B6SIzmKpIpPOx00U8jk6yQ2GTv6E+K3tR2etAZM8BZVlqjq7vceOA6DqJx9+hQSlStGbcMeMroRC7oVCZYmfAzpLMTZ2V30iTfhTpZbJ3VFhBzbMoGb+80dQwieYNMc6UC3v2ok+6fQ6xAYuXluFSp5j4/JrHgVa3IaQzxJOPJNZZmU/QhDwlsFgGfz3T3ARN/eg9Yk4Q84/+vfjHqRUFcQ5An9jww==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779346117; c=relaxed/relaxed;
	bh=EU7FDm+SK0SeHUIOaPNtoHigI+RGvZfT8tjdC0pN70s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bFPxAeXo6cpdZVfx7B+b4mYskBeQX/dSZmxY3anvvLATt5icgCAt6DY8zRhLzOI53CNWTc6XUy9FJapu+LWQ5Obd+t8oVFzz/nWb8lz6mtR2aY1GfOoTYuQhJBQ4EtZgPwknXMZxYHRGBf0UFr6zPxYjfuhdee2XMLM5LbS66ChgM2IoY6RUO4REIK9X6jSN38TkeT1v5HLpQ003F0/VyVUdq6Z0SJ3hRJjmEtQeVKdpuliQLSEJWR7enASgFu1E2mIoPqI1xl1kcRBSY98c+GWHO5ru/4AjXEhlKMUq9JV0XgUqYVOrxk7N2jws6/DzECcht3hDCjy/6vbWjqGQyQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=pPL0Sjfy; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=pPL0Sjfy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gLfBY07dgz2xfB
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2026 16:48:36 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L4nxTA3913287;
	Thu, 21 May 2026 06:48:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=EU7FDm+SK0SeHUIOa
	PNtoHigI+RGvZfT8tjdC0pN70s=; b=pPL0SjfylPTPLVwBJhpsk474c+FZ698HU
	DzS0mTv2zdOIis3+OmDX1iLHL4O26DHKY3txk/ysrhXnd4CorxYvXcfDHzcCUPSa
	Dl5yQTRKzbmpo42MdG8VEXz3S+QZNPM5FPcVSaTWyHR3ZvCGufkgbzAxnuPSHU1f
	Vtww9Khj/Ukysi00h3BbfFjSzgzPpIXf6iFBmh4/5VOdygXKuV2XYXmUV4Y8R1kd
	ahxiouK7ILOqCt+KEM6pylXAilb3/msaGWFU6CXS+bLnwnb3Iemf+JLTFjMGAQAI
	c8eKExq2P/e2KRxKTNaBHKSldEQKpOf3GwOghl3pHcFcWdWfh2jhw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h9y5k72-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 06:48:19 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64L6dFse003635;
	Thu, 21 May 2026 06:48:18 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e754gjktq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 06:48:18 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64L6mF2U51184088
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 May 2026 06:48:15 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1AE3E2004D;
	Thu, 21 May 2026 06:48:15 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D931D20040;
	Thu, 21 May 2026 06:48:11 +0000 (GMT)
Received: from li-3f69264c-2ce6-11b2-a85c-c3f414d24014.bl1-in.ibm.com (unknown [9.123.3.209])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 21 May 2026 06:48:11 +0000 (GMT)
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
Subject: [PATCH v7 07/13] selftests/mm: free dynamically allocated PMD-sized buffers in split_huge_page_test
Date: Thu, 21 May 2026 12:17:47 +0530
Message-ID: <060c673b376bbeeed2b1fb1d48a825e846654191.1779296493.git.sayalip@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA2MiBTYWx0ZWRfX0lB5NLz0sG5H
 rlke4dn0jGafkRW+w3KSwTlA+yIFvS0fM9dxQQcNqj3ZXWCA6v+1OEEzaUv92KNbBBW23Go3/8o
 dEU0AzDyQhRbxhZEgqisleSZ9Ifra+eQS9CCYPXYVuYMJgKusRjjkA9nGmCdLMl5y9W/0mVKO5h
 ZfwJlqsvWgpc5XXtezbEu/JlsvZd/XKIM5uJNcFFaMAei2g6QEqRep8mcPepnoeMreqginMjUnu
 ToUlZNWLFvBS55iHsX5vo04CXooBRm20nfUMSzf7l0kwOsEaSWkWjB+Hh0BPtQdpPEoadGIG6EV
 gz8kvgoxGdyC35Wig3hWfwqYAYBTAjf+S6uHOxRBpSeK8GUb50cCGYyk9Rna0E16wUazvaj+HSn
 s9omu+nDAjMvbwPF3aybAQa8mvWfCc43BlFfjcVt4DIXRdoqdq/dOsq1xqhuOah0ijVECaFopxR
 vPGz5dsgtXAwItyimFw==
X-Authority-Analysis: v=2.4 cv=BNuDalQG c=1 sm=1 tr=0 ts=6a0eaab4 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=Ikd4Dj_1AAAA:8 a=VnNF1IyMAAAA:8
 a=9VAv6nXQuNVwvrTyzFEA:9
X-Proofpoint-ORIG-GUID: LZztiJkIpvWA-ajeXgRT9hYCTADlW0SK
X-Proofpoint-GUID: pvfvNl9zkJM7djLOppnCP9NcadwCTh0-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210062

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
index 4066de6e8ae0..7a8b64cf4aad 100644
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


