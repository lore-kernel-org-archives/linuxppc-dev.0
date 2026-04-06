Return-Path: <linuxppc-dev+bounces-19390-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8374EF4EC9
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Apr 2026 09:20:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fq3hp0zfwz2yfl;
	Mon, 06 Apr 2026 19:20:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775467242;
	cv=none; b=OZWc+AGeGOk8k8lVUcTty6wNhKEt1VantEAMLwJT04r22FTSL+v3rufDw/6twH1qkUTOYB49/BuI1i2OSHjp2eDLF6RAIXoNdAeW3wAmuifNDBEux2sqRmtDxAi1uEdxlOzhfoNVqtVqlnd8XwvSrxfvGiH6fSDvEm3Gr+Xj6SvTqG0osYIlFYcya5NhkDIk6lu/A6bdsgXOLM4Zt39WKkjcmVwMByx0MnEQgIZ3l+q2hUuSHpQX0b1l0aC6iWEGr0aSKzxNKiuqdZCGUKuKXnGdtRtAh5nlS6qzkpGndLVxwPI58RfUdcLRfYM0EWZ066KYuBKK8CsC9vNDG+BJrw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775467242; c=relaxed/relaxed;
	bh=Nw9ZkZ2qtFm5sEpfNZ2VZDGfra/1UI4dbSFUj9UhCgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZKbnMUh7HgyUmhrC4zTaj5GYM7ghAE8pQJioPKzRofQCj+YKNlzoBgM8CTGT5x5cgV//zLP1mn7gTqo2Ssx2px2cwEEQ4JQ/4sFqlkm5xl0JKYF9NZb8AAEsGMtmzp/yClSKEtkun/kSHy43PVr2damV4T4oXFM9neQe72h/F6vUr4D0k2ctaIQZNs7ksNShrcxQKflT8alErUyWqiEy/OxRfV5It+1uBee0qRBo7W20+K9eNFXLCJcvq3QnTUzKhOFf2ZB+w1AqSmkgedIiO8sH89VilTntOvj8v/VR6pTYkR128AHxvPgmYCp7YYxVIToI703nTOUVC21NHemF9w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=A+KaU/rW; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=A+KaU/rW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fq3hn35WQz2ySV
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Apr 2026 19:20:41 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6362uv93052743;
	Mon, 6 Apr 2026 09:20:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Nw9ZkZ2qtFm5sEpfN
	Z2VZDGfra/1UI4dbSFUj9UhCgY=; b=A+KaU/rWjoLfdC8ACThoftGnORpTPLVja
	pHYFrxRX5bHxIvIbuUKx9LnMHtySTAv/6EuE4weo2+ZfSYkWW1KiFxSdgqdQzjGE
	iuNucuotCttsCZXCcRODfUwguf5m1kdgFXOg/VzgYZpU9CcDSBsNksUG1W2EN9rh
	fz5VbeIjOo8wWj+1VgefvKOpax63zfCO/RydZD1zX6T2kJAEhtBCTNyJnXyk3f7J
	NU+dMHbxx9dBYbtU0EaKE/Ul8z2TH/BB9aF6wihLh6+irx8ZHUuLw6m0hdTVRqD1
	oIWS2yd2JDAFga0x1u3bQUKNey6paO0E8Qw6mLvmtD1DOg0TK+YvA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4datap5vq2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Apr 2026 09:20:17 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63671mJO006367;
	Mon, 6 Apr 2026 09:20:16 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dbfp1kv2u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Apr 2026 09:20:16 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6369KDi454264174
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Apr 2026 09:20:13 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E0BB720043;
	Mon,  6 Apr 2026 09:20:12 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7E36C20040;
	Mon,  6 Apr 2026 09:20:09 +0000 (GMT)
Received: from li-3f69264c-2ce6-11b2-a85c-c3f414d24014.bl1-in.ibm.com (unknown [9.123.3.209])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Apr 2026 09:20:09 +0000 (GMT)
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
Subject: [PATCH v4 08/15] selftest/mm: align memory size to huge page size in hugepage-mremap test
Date: Mon,  6 Apr 2026 14:49:27 +0530
Message-ID: <6aecfff81bd3e288e66af238f50f35eac0bd4ee7.1775466330.git.sayalip@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=Bp+QAIX5 c=1 sm=1 tr=0 ts=69d37ad2 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=7t5IiW4R7ddU3FUDOzEA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA2MDA5MCBTYWx0ZWRfX93HuP0OgvJW/
 c3p7A5qwju1Z5Im4P47rbK2t2YTssBP286ygxm9qeuUI+rw+Wg/JxWQyCwYtNgbvFRUvKGnRYEJ
 fGGaGvppjaeuRof9RdXJowRqDHKWVhMPnJtGoTK14zTZkH7Nud/didk5UuXpXN0Pqfj6IXtmsZ6
 /Vx+7kHPAfMjhFiYxA2LemJfRkOYoNneWuUVBcHpmattn61DxmGyO2py55DIpvJ7xiYcPlJ89lf
 VrJtGjpLkcVaT9KgPhmRDAbzmg55R43zX24nlJ/+T8EWiL8MFxwNI2h7OqWxvWqFqEs16RZyXIT
 dIKqfokn1HYZS0xsCOjQL6nTbGgOC/kZglOANHOAgnbgStT5bADF4bZBv3CpZSG4Gr3pxNbzhbC
 rdoAH08Trc9ZiTbXQ4R+iWLJaa4tgXId5O3i0nM1S8pFkvvA/jSVJlMI+A9AMSgg1DZbZo6ZDN1
 kTi4Jvtk83segJsY0hA==
X-Proofpoint-GUID: YE8RH6-T8ap1Ln54ZpQjoOMHN1rEKJNh
X-Proofpoint-ORIG-GUID: eqEvO35RqkYaRN0wbx7743G22Ks-VQsN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-06_02,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604060090

The hugepage-mremap selftest uses a default mapping size of 10MB
when no argument is provided. This size is not guaranteed to be
aligned to the system hugepage size, which can cause munmap() to fail
and mremap() to succeed where a failure is expected.

Align the mapping length to the runtime hugepage size using
default_huge_page_size() to ensure the mapping is properly
aligned. Also handle the case where
default_huge_page_size() returns 0 by skipping the test.

Before patch:
  running ./hugepage-mremap
  ------------------------------
  TAP version 13
  1..1
  Map haddr: Returned address is 0x7eaa40000000
  Map daddr: Returned address is 0x7daa40000000
  Map vaddr: Returned address is 0x7faa40000000
  Address returned by mmap() = 0x7fffaa600000
  Mremap: Returned address is 0x7faa40000000
  First hex is 0
  First hex is 3020100
  Bail out! mremap: Expected failure, but call succeeded
  Planned tests != run tests (1 != 0)
  Totals: pass:0 fail:0 xfail:0 xpass:0 skip:0 error:0
  [FAIL]
not ok 1 hugepage-mremap # exit=1

After patch:
  running ./hugepage-mremap
  -------------------------
  TAP version 13
  1..1
  Map haddr: Returned address is 0x7eaa40000000
  Map daddr: Returned address is 0x7daa40000000
  Map vaddr: Returned address is 0x7faa40000000
  Address returned by mmap() = 0x7fff13000000
  Mremap: Returned address is 0x7faa40000000
  First hex is 0
  First hex is 3020100
  ok 1 Read same data
  Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
  [PASS]
ok 1 hugepage-mremap

Fixes: f77a286de48c ("mm, hugepages: make memory size variable in hugepage-mremap selftest")
Signed-off-by: Sayali Patil <sayalip@linux.ibm.com>
---
 tools/testing/selftests/mm/hugepage-mremap.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/testing/selftests/mm/hugepage-mremap.c b/tools/testing/selftests/mm/hugepage-mremap.c
index b8f7d92e5a35..f66e4d806477 100644
--- a/tools/testing/selftests/mm/hugepage-mremap.c
+++ b/tools/testing/selftests/mm/hugepage-mremap.c
@@ -32,6 +32,7 @@
 
 #define PROTECTION (PROT_READ | PROT_WRITE | PROT_EXEC)
 #define FLAGS (MAP_SHARED | MAP_ANONYMOUS)
+#define ALIGN(x, a) (((x) + ((a) - 1)) & ~((a) - 1))
 
 static void check_bytes(char *addr)
 {
@@ -110,6 +111,7 @@ int main(int argc, char *argv[])
 {
 	size_t length = 0;
 	int ret = 0, fd;
+	size_t hpage_size;
 
 	ksft_print_header();
 	ksft_set_plan(1);
@@ -126,6 +128,14 @@ int main(int argc, char *argv[])
 		length = DEFAULT_LENGTH_MB;
 
 	length = MB_TO_BYTES(length);
+
+	hpage_size = default_huge_page_size();
+	if (!hpage_size)
+		ksft_exit_skip("Unable to determine huge page size\n");
+
+	/* Ensure length is hugepage aligned */
+	length = ALIGN(length, hpage_size);
+
 	fd = memfd_create(argv[0], MFD_HUGETLB);
 	if (fd < 0)
 		ksft_exit_fail_msg("Open failed: %s\n", strerror(errno));
-- 
2.52.0


