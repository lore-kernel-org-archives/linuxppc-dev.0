Return-Path: <linuxppc-dev+bounces-19737-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94DC8ED7B84
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Apr 2026 08:23:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fvy2y48Cvz30gY;
	Tue, 14 Apr 2026 18:23:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776155002;
	cv=none; b=Tbz0FwiMwyVXbhl5XUB6wb/+mqFA/tyZxn3s5VVw1gDhqZmjH4/cKVi/IYMCeTXXJkqFIDq+y1+3TAoIqwnGcFzzCEfNj17/nVPyK23lGhf/FBKNwnpz9q7HRSQfbA390t3ahbZ7wZgbUejztnEypW2YCK6K0bvi5E86uSG6LXEkbuOZrWCekVy4RKa0YJ5BhMuQe2IM9d+ADYvCTGeEF+k5aa2ueHmZY+Fv7qAyn6ZrGLutka/SBIMTdDmWIAikP23MBPBJTUVq7UoVBKCqrqnjPDAuiEpuEj9Z2xpGp7Jr0eZR0RgsC1tZSBt51hPftMgaXNhuYjPgb8ZYCY8lGw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776155002; c=relaxed/relaxed;
	bh=G5jNpn3lA4nxxcFeRR2Yggf97NPpXqcmij/yD8SCbb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W2LUF2p08m95+XjufI/lGTNHCsBiG31zl/Pzz9k5e1NVKYVW+5W+0kcWF1ATbaEJm9jc24+1YadzI7N4XDsIGFsepMl0TwLQScCs8FC3x8uqQiK3RM+DUZPAlnt6kF8YKGB+a4v9Tc6pe9cLdtMvpzsVLRtTkQZMap7Y1kz2iLxO93/baaa5M/fdaZ/f5TRsDiysGspOR1uHnAx+/3RNIhhaX/7BbTCpEW0dz+oHx6pxTZn7SR6DZPYtTLhc1HdthNpuEqAHPPLGpLAV6+t47yFafej/2uuk8x61X9j+1coKD+g84oBMFjFgNeKrOrWoOOphHLwRm6WENYTJrrHNsg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=f9Gsu120; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=f9Gsu120;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fvy2x6Bmlz30dt
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2026 18:23:21 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63DLI5JE1804464;
	Tue, 14 Apr 2026 08:23:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=G5jNpn3lA4nxxcFeR
	R2Yggf97NPpXqcmij/yD8SCbb8=; b=f9Gsu120RA4G3PScADizqrDRLYNux2LTH
	KU2aXemvHHmaD4/w+QX64yeoT2w37NyzjrAFiLw1qlVH7ZUo84S1V1wE48r6p+qr
	a3CPzzHUm56J/WvL8RQg451RbWFXAox396awKxQi99yzC7Lf+yYX5BRGq5FCU/fx
	50HXJM4Ue5vvElGncpu8e32Y0kr9Mu4YM/9hRDtFyYQkmOBob6CH3P2WNUqLGkH9
	xLakfr9Ckm8uZUw6FqZ+neh8FZHDh3EZB94w47WNLIuCacLJQTXFPJ5x/B7MzDno
	n55UhRvPL/hJmVhslCp7z174FfBEE9N4txJyNJ2h+d8MAEaXbp6YA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89k1phn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Apr 2026 08:23:08 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63E3XB4R031854;
	Tue, 14 Apr 2026 08:23:08 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dg10y8qvg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Apr 2026 08:23:07 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63E8N46456099104
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Apr 2026 08:23:04 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3A8B520040;
	Tue, 14 Apr 2026 08:23:04 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3491920043;
	Tue, 14 Apr 2026 08:23:00 +0000 (GMT)
Received: from li-3f69264c-2ce6-11b2-a85c-c3f414d24014.ibm.com.com (unknown [9.39.26.223])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 14 Apr 2026 08:22:59 +0000 (GMT)
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
Subject: [PATCH v5 10/14] selftests/mm: ensure destination is hugetlb-backed in hugepage-mremap
Date: Tue, 14 Apr 2026 13:52:04 +0530
Message-ID: <a4c1dd0e2b83cc06ea84bd04e6a86ca6d51efb67.1776150071.git.sayalip@linux.ibm.com>
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
X-Proofpoint-GUID: bPe9bIAhS9SAlYQHEgyhU1p4k79fCvkr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDA3NyBTYWx0ZWRfX+qNJGZcil+9a
 /XxnS0SMY2MuN9+v5DB7CW4/tDvLGRvUXUbntkasH5nsBwInoNscmpLAg/brPUSuieqYFba9TIt
 ObXs65NvS6SQoiG2s3PBxCfWwgflPed/FTTQvYfwI+liHWYWPpxlyrIcHhzUdHRV/HvPr+4SgIg
 IBtaGBab83QpXCSiYWNHR9B8Brdx0kWNGoJo45QOulB02CAd9Nl+q+9EUvC5845og3almBhMsNI
 pmNsEdtKyMb9geVQ04hTN4rG3lejOCbVWwzLtR43jMUIXTQ/50g2VYq6W8y2y6r2KgcFxl+oMz7
 gRY9jTcTxqFV4WeFNP4xTzdgeb6RrZJC7ZnyDg1rbgd36R+3zRfFc0qODXhUXlrr582NlCyPfGw
 kVulyubQkimTE4wcTuwtGM6uZeCEIyHR3DShHevD5+Np8e0B8NWvCqfsjwoeOcpD1uEadePfZmP
 en4xOvJYB9xkrfRY+AQ==
X-Proofpoint-ORIG-GUID: ZBAQ1omQCUgXLDS5ZAbMLQS91NFm54W5
X-Authority-Analysis: v=2.4 cv=W60IkxWk c=1 sm=1 tr=0 ts=69ddf96d cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=gVE5Qc0x_BWLnb-D2gsA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_02,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604140077

The hugepage-mremap selftest reserves the destination address using a
anonymous base-page mapping before calling mremap() with MREMAP_FIXED,
while the source region is hugetlb-backed.

When remapping a hugetlb mapping into a base-page VMA may fail with:

    mremap: Device or resource busy

This is observed on powerpc hash MMU systems where slice constraints
and page size incompatibilities prevent the remap.

Ensure the destination region is created using MAP_HUGETLB so that both
source and destination VMAs are hugetlb-backed and compatible.

Update the FLAGS macro to include MAP_HUGETLB | MAP_SHARED
so that both mappings are hugetlb-backed and compatible.
Also use the macro for the mmap() calls to avoid repeating
the flag combination.

This ensures the test reliably exercises hugetlb mremap instead of
failing due to VMA type mismatch.

Fixes: 12b613206474 ("mm, hugepages: add hugetlb vma mremap() test")
Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Signed-off-by: Sayali Patil <sayalip@linux.ibm.com>
---
 tools/testing/selftests/mm/hugepage-mremap.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/mm/hugepage-mremap.c b/tools/testing/selftests/mm/hugepage-mremap.c
index 68c35d1d8a5f..a442d01908cc 100644
--- a/tools/testing/selftests/mm/hugepage-mremap.c
+++ b/tools/testing/selftests/mm/hugepage-mremap.c
@@ -31,7 +31,7 @@
 #define MB_TO_BYTES(x) (x * 1024 * 1024)
 
 #define PROTECTION (PROT_READ | PROT_WRITE | PROT_EXEC)
-#define FLAGS (MAP_SHARED | MAP_ANONYMOUS)
+#define FLAGS (MAP_HUGETLB | MAP_SHARED)
 #define ALIGN(x, a) (((x) + ((a) - 1)) & ~((a) - 1))
 
 static void check_bytes(char *addr)
@@ -131,23 +131,20 @@ int main(int argc, char *argv[])
 
 	/* mmap to a PUD aligned address to hopefully trigger pmd sharing. */
 	unsigned long suggested_addr = 0x7eaa40000000;
-	void *haddr = mmap((void *)suggested_addr, length, PROTECTION,
-			   MAP_HUGETLB | MAP_SHARED | MAP_POPULATE, fd, 0);
+	void *haddr = mmap((void *)suggested_addr, length, PROTECTION, FLAGS, fd, 0);
 	ksft_print_msg("Map haddr: Returned address is %p\n", haddr);
 	if (haddr == MAP_FAILED)
 		ksft_exit_fail_msg("mmap1: %s\n", strerror(errno));
 
 	/* mmap again to a dummy address to hopefully trigger pmd sharing. */
 	suggested_addr = 0x7daa40000000;
-	void *daddr = mmap((void *)suggested_addr, length, PROTECTION,
-			   MAP_HUGETLB | MAP_SHARED | MAP_POPULATE, fd, 0);
+	void *daddr = mmap((void *)suggested_addr, length, PROTECTION, FLAGS, fd, 0);
 	ksft_print_msg("Map daddr: Returned address is %p\n", daddr);
 	if (daddr == MAP_FAILED)
 		ksft_exit_fail_msg("mmap3: %s\n", strerror(errno));
 
 	suggested_addr = 0x7faa40000000;
-	void *vaddr =
-		mmap((void *)suggested_addr, length, PROTECTION, FLAGS, -1, 0);
+	void *vaddr = mmap((void *)suggested_addr, length, PROTECTION, FLAGS, fd, 0);
 	ksft_print_msg("Map vaddr: Returned address is %p\n", vaddr);
 	if (vaddr == MAP_FAILED)
 		ksft_exit_fail_msg("mmap2: %s\n", strerror(errno));
-- 
2.52.0


