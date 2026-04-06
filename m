Return-Path: <linuxppc-dev+bounces-19391-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 988D9EF4EC9
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Apr 2026 09:20:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fq3hq0mkdz2yqs;
	Mon, 06 Apr 2026 19:20:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775467243;
	cv=none; b=DpmXoZf6NP4AHnXNZamrE0dux4hMDAJ/QbB9rKujCYl/59uqUPYaFsoqAgCSfVQX18gtsbIJXZT5Xb+HxkadJLuFxzUkNfN8UXIGTdVT4/7sGjhWwMBj4j8CFK9qJs+qW2glRyaKfKuo2YE0XZUgr7tzb2zExM8byrfGxMXXggajAzG00RH33N02SVLJsZhSpGPStZdBEU0HEXjAHrxRGqTMyTsgk8UbMjZhPiKNOaDxSvEGfjz/46dBT7Jnaa5d8vPMQNlV4GdworRnY5xTBMcuwNzDYx29gXEOxOawhUe8YEDwoaRfyITYLIvPz9lzAicJGQs/iKfK5iCBpibQTA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775467243; c=relaxed/relaxed;
	bh=4EhSDCaShB3rwYDRoPDml275sLaBm682LiODn0nNoJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=be7JWNhZcGKlzAUqqZTioREcOMzMANLGcVaqjVAcwVHjHgp6RhN6eNyo1X5sOm8x52rmSQy4yrh6KGIuiKyNpjXi6DKzXfIbVmoNe83+IXDplRHxvoCXzO7wv6zv/dTvf8/IFcCe7XGbmxcrLKpEP0wrqswVbDRJ+ANcGe3+z4kYW1369/lWID/P5DdHYHKlIRWQBw+5l+/hPWE+vi6OHESpkoMTLh/e5UjkJKGJoaa5MA9fX6XfxJcTaxaqx+quPJMkkPw0NMKLclMuBp5iagi9dPdRK5kmgdiH9zzxAlrk2mMKocj1cO5nmUFt3ar5frJAFtVOHsiRoolbv5Linw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=SlYAUe+A; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=SlYAUe+A;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fq3hp239lz2ypm
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Apr 2026 19:20:42 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 635LkWpi3666020;
	Mon, 6 Apr 2026 09:20:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=4EhSDCaShB3rwYDRo
	PDml275sLaBm682LiODn0nNoJA=; b=SlYAUe+AeupJfmqPHmLhxTv4QT36LOWMi
	ohq/Wr7hohSFUcOOvuqr41B8QyTMQQvIZTkzpYtZUXTrDIPFsO+HG5PTnBDbKR6t
	N+/or0IKpaINK0iTBTIxf4EXRRFhI71sovPEIAWCsZmJiub3Lyw44y1az56RlVKm
	ZlaVFfq2cYX/xYG0ryrUDhm+9gIbh2Wv37GAks9e+9fBUgLBc0P/YsqbhAIN50Nh
	hgfvUHaIDmhjAkNd1xB1wsfbWLRsU7kFsAxV2qo2yP1GV7ktVlguAGXe7kyUbmsy
	CE+s98FhB3E90RHxRswjQAsUzH8I9aAorGtThZUMYsPceg0PvpeLw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4datap5vqn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Apr 2026 09:20:28 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6364sT4L021109;
	Mon, 6 Apr 2026 09:20:27 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dbdbyc5hc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Apr 2026 09:20:27 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6369KN4F24052118
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Apr 2026 09:20:23 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 90ACE20043;
	Mon,  6 Apr 2026 09:20:23 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F6F120040;
	Mon,  6 Apr 2026 09:20:20 +0000 (GMT)
Received: from li-3f69264c-2ce6-11b2-a85c-c3f414d24014.bl1-in.ibm.com (unknown [9.123.3.209])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Apr 2026 09:20:20 +0000 (GMT)
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
Subject: [PATCH v4 11/15] selftests/mm: skip uffd-wp-mremap if UFFD write-protect is unsupported
Date: Mon,  6 Apr 2026 14:49:30 +0530
Message-ID: <80239ca37ad96216eb5d9768cf5373e7246626ff.1775466330.git.sayalip@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=Bp+QAIX5 c=1 sm=1 tr=0 ts=69d37add cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=smpEqqgnm6pLQfsEXf8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA2MDA5MCBTYWx0ZWRfXytqH8299SKPD
 PVQJKEJHCkWQbxYxPj/MoPmMhEO8RC1kHq3SmCPnK1lGXik11ZxKObaVcuWaZoyVkVAGhFfQ7Vd
 6rO4L2mg4Xfbcqd+pBX5Cp3x4Q0503GX36ok1hhEbYMDJysN1cARN5WxrSaNCCDZhLF1f92W0tn
 2DyXNa08oxLTzsCsoZzyh7k2/ujiAe5JX0h0mnbcxMGly/DpQdCg9qUxbsWBG3/cFXRbWgXq2Dp
 +5uHuk/txcYSiiQeO1rAQ0H9v41HRewWrM70Jzool8QdLz6qr5Qt+78ajPvW5oIrJ3ATQIzPNBO
 j2oQ2dGaU3hzYNcjtn4Cnj48FDEbo7MGx0TWvHEnC87q8LeDlgcPUkz8+E0UcX2uPT5nyQOmSyQ
 wOw7711hK93/86KPxFJqrG9t0wol3d9rYiCkN/m8NdoF4kSxgVpj+synVwHUh/MY+tpF3AHFTSU
 4gBehsWBAIpujgZSt5A==
X-Proofpoint-GUID: TrWGYxJH8XCEQHRv6-L2CCTECgip6Ygn
X-Proofpoint-ORIG-GUID: AFSrbBGVTCsL7NYa1mLGsp1tKkwjbZIc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-06_02,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604060090

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

Signed-off-by: Sayali Patil <sayalip@linux.ibm.com>
---
 tools/testing/selftests/mm/uffd-wp-mremap.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/testing/selftests/mm/uffd-wp-mremap.c b/tools/testing/selftests/mm/uffd-wp-mremap.c
index 17186d4a4147..8f288484d5f5 100644
--- a/tools/testing/selftests/mm/uffd-wp-mremap.c
+++ b/tools/testing/selftests/mm/uffd-wp-mremap.c
@@ -19,6 +19,17 @@ static size_t thpsizes[20];
 static int nr_hugetlbsizes;
 static size_t hugetlbsizes[10];
 
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
@@ -336,6 +347,8 @@ int main(int argc, char **argv)
 	struct thp_settings settings;
 	int i, j, plan = 0;
 
+	check_uffd_wp_feature_supported();
+
 	pagesize = getpagesize();
 	nr_thpsizes = detect_thp_sizes(thpsizes, ARRAY_SIZE(thpsizes));
 	nr_hugetlbsizes = detect_hugetlb_page_sizes(hugetlbsizes,
-- 
2.52.0


