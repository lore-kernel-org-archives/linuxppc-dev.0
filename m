Return-Path: <linuxppc-dev+bounces-18105-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37147105A594
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Mar 2026 12:27:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fWn0x0cnDz3cPm;
	Thu, 12 Mar 2026 23:26:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773318401;
	cv=none; b=gE6igKKWjcxrq2TTZTiHgv++emOFQQOBR82+8Bvnejn5hyLLm0+45ck+GsuxaEoicaY6rpYRFOYPxh/0wSA6xofC0XaGAa7yWT84LTZQPW3BKUvQf4JDDWa1kho57rkjZYulsKnav8vvSNF7wEeXf2kS8xKk3AcKnOwo3C4IqfY84QlrY9+zWQQ1Qws2xXO1NcxO+N59Yx/DTcj+Vpaaw6TCoInRCtI8hdUcRzNQxiHMywMpZ1nBgq9tw/n02btJg/3cdZ5ofOLj1dVW3PVltjx+9b7ro7NFoWrOX4T6Td68LQiIn74E0XrTa9FdDejqD9622Ugp3rzfbpg2wpKo/A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773318401; c=relaxed/relaxed;
	bh=eccxQEZlyQcYu1LXiKrtsRTxSTUY5DFMNv8Ohe4wGJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zj3OWKhkabjGPFmcc8dUIc6RSuHvplIC7tr7Sp1BIu2RrbvDbeq6yeTOAip11mvUZx/4q05QQEP2cmXy+HI9Y5iH5Q4eajZYDjqzRG5d7vbqmJe3qULubbWrgWcCzKCa4TAiJJ8nMiGshG9agCiAp6lJOtwZtMLg1TolylZ6aK43aqFc5xtBXZiYE4vsB81eZOAJsA7HvSlM3807rc9Rd8ytbFzaGJQheiM6GTr1KkoPV8TYSLT7vFA2GAz8YBfkGIRP6ifR5N0N9ifvqmvykoJbDMidpbSFwQsieP1zSmTXMcm0zxurSunqtVBVEYmNu+Tv0aukn6KlGTXRcOdaEQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Q/KNVxLD; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Q/KNVxLD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fWn0w20Szz3cG3
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2026 23:26:40 +1100 (AEDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62BMWWnu2206305;
	Thu, 12 Mar 2026 12:26:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=eccxQEZlyQcYu1LXi
	KrtsRTxSTUY5DFMNv8Ohe4wGJY=; b=Q/KNVxLDXrkkP9/pNdNXHptumVrGlOStm
	JGmg5u7fzEL6lrqtugj0PYUFaHaVZ7UzyK/XkMMvCSwsxOozMA3YvrkG2ifYBlIJ
	5/BvrwSBAYvfXEey2IW4xng+YEhxBJGHUxlPO22DRtMHReWCwUlWWemGQQrsccSS
	YIw/6xa9kXOiHnI5D7qIMB3yYbogydxgagtF5/SZChTFf/ZBB49xuwvTOMfrjeWh
	uGqm4ZcBfbOzbQXcKHUvkFfrAROy2PUZVIywac8fG1oBkTBnNltV7XHsUl07viIf
	g/6FkhG9gxkT2Vja7IBfW4N49AnllTrc8j/IIF5ZDrUfSPO6GuOiQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cuh98ag6f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Mar 2026 12:26:31 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62C9aRDp014797;
	Thu, 12 Mar 2026 12:26:30 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cuha8a8sv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Mar 2026 12:26:30 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62CCQSKe38470040
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Mar 2026 12:26:28 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9F7F72005A;
	Thu, 12 Mar 2026 12:26:28 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D789520043;
	Thu, 12 Mar 2026 12:26:25 +0000 (GMT)
Received: from li-3f69264c-2ce6-11b2-a85c-c3f414d24014.in.ibm.com (unknown [9.109.243.201])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 12 Mar 2026 12:26:25 +0000 (GMT)
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
Subject: [PATCH v2 08/13] selftests/mm: ensure destination is hugetlb-backed in hugepage-mremap
Date: Thu, 12 Mar 2026 17:55:35 +0530
Message-ID: <a9e12dcb25b9be4f146063669b1eb3ff9b776c23.1773305677.git.sayalip@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1773305677.git.sayalip@linux.ibm.com>
References: <cover.1773305677.git.sayalip@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=M+pA6iws c=1 sm=1 tr=0 ts=69b2b0f7 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=Ikd4Dj_1AAAA:8 a=VnNF1IyMAAAA:8
 a=iEzYaluDCQLbEJLwxn0A:9
X-Proofpoint-GUID: S_9XJG97zMrLLLjAS3IyCBFw6A-CremB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEyMDA5NSBTYWx0ZWRfX3HCPWO+DXxmr
 liSzTlBYYZLZkkDJocmEEIgPm6rmsUgplafMKC59hUxdhI5XkwLO3Tuiz/oJ+3k0gT8ztDeMdY1
 8VPVn7EblMzpLegETLvRZRxA4MczTFr+jzfS4msfDDBkO134DwubkbBuaUg+A+YZwTiBa81sxBC
 zl9XVgkLkiGSQ+/qfPQkvjjxGCtMnnsxlfYoAOqIC3ZR3Hn9WUghL0ejB0NiGYA/p2jSCxi1hrX
 lpXSpRhbQFk3gb5jfcPFY1Xob/pU4PwTiW55jnk3NSl3Go0qTtIUt+7STaauOQaJRatHeN+Wf4+
 ne6Usv/UsanLDha2MKUSWdV/JKOrlPkVuIHNBaHchpLUlSV8mnSruoLE0nWWPiwVl0n55SBIFsc
 y2lDFaAFAsgZUOIcSkwDQAPfHXi+wzc/0Rmu1hWSBKWlEwCjBvZyzYy8+ujvMgYw8y1Dr/IoH1N
 lSHgmbA+XQibG/6a4Xw==
X-Proofpoint-ORIG-GUID: VriZh5lXVojveniFsXZub6QuWBZEomFB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-12_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603120095

The hugepage-mremap selftest reserves the destination address using a
anonymous base-page mapping before calling mremap() with MREMAP_FIXED,
while the source region is hugetlb-backed.

When remapping a hugetlb mapping into a base-page VMA may fail with:

    mremap: Device or resource busy

This is observed on powerpc hash MMU systems where slice constraints
and page size incompatibilities prevent the remap.

Ensure the destination region is created using MAP_HUGETLB so that both
source and destination VMAs are hugetlb-backed and compatible. Also add
MAP_POPULATE to the destination mapping to prefault hugepages,
matching the behaviour used for other hugetlb mapping in the test and
ensuring deterministic behaviour.

Update the FLAGS macro to include MAP_HUGETLB | MAP_SHARED |
MAP_POPULATE so that both mappings are hugetlb-backed and compatible.
Also use the macro for the mmap() calls to avoid repeating
the flag combination.

This ensures the test reliably exercises hugetlb mremap instead of
failing due to VMA type mismatch.

Fixes: 12b613206474 ("mm, hugepages: add hugetlb vma mremap() test")
Acked-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: Sayali Patil <sayalip@linux.ibm.com>
---
 tools/testing/selftests/mm/hugepage-mremap.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/mm/hugepage-mremap.c b/tools/testing/selftests/mm/hugepage-mremap.c
index e611249080d6..48c24a4ba9a7 100644
--- a/tools/testing/selftests/mm/hugepage-mremap.c
+++ b/tools/testing/selftests/mm/hugepage-mremap.c
@@ -31,7 +31,7 @@
 #define MB_TO_BYTES(x) (x * 1024 * 1024)
 
 #define PROTECTION (PROT_READ | PROT_WRITE | PROT_EXEC)
-#define FLAGS (MAP_SHARED | MAP_ANONYMOUS)
+#define FLAGS (MAP_HUGETLB | MAP_SHARED | MAP_POPULATE)
 
 static void check_bytes(char *addr)
 {
@@ -121,23 +121,20 @@ int main(int argc, char *argv[])
 
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


