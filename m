Return-Path: <linuxppc-dev+bounces-18910-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1415D10BA432
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Mar 2026 07:18:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhsRv03glz3fBv;
	Fri, 27 Mar 2026 18:18:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774595882;
	cv=none; b=fUCE2sHJUIsck82Pc9AYO4nrVa4igiUz8uyAm2/ZlwEGCVH5/dzuZrUNVb2tYLmlfSEBnnLww1OZrbxjrb3jE/k6+NO2Dfti/DdTxrj/7q5T5K+MF+vO0AFTv5lxGmkCO69VNUOL1Bjd+jl2va4taEfzz7dhlFD6AlLf5SzwoIK9PI8AcmHfMAxOAfqcQCakE3g0AqbZ2QiB3xeHmFpHfNXWAN4BZEdKI3J0bNoO68dbNvhBcdMdz2V7Mdc5Hrq2VDQJNv2ZG93USXuhzVzrYhujtIz75JVqtVFqM4JukAwkiuxIgRv2/0XFTb4LKs2C9A6VkxAqH+GiWxv/uetYBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774595882; c=relaxed/relaxed;
	bh=BUL4pKTSEe0gAqr+Km+xx8EMdADlTk5q1TiL0S+Zbos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gowm8CLUZ8Dxe5EXOMMf9cmfdPdawUZUjEJRQga881UtyhXbCNUA6k+4dFsHN+Y+37Q8Vj7+DUxLrJV7j0IZMGy2DvHCOFWrIdCykHRiMB+k1oei5GrWyvD7EuuE1j26iSVPjh4MLqQ2h56vMO1xUurwLKTP47IR+LWt/pCxFhJWgFlGxW1jms6hEY27TbaJmXroiWvSjdyq4qp/UyanKIBlDgiTkcLnO1AqZdQ7XX9deF/G6EZk0DVUUIciH5ZQdIwljzI7HZsPL8F28tguQwYJdZUayXDZT/8hWFZghQgX+SA34VfTZUrVALQAtDQpzKxEx7kCW0VT5WWvhwlvew==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=plpbXOhg; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=plpbXOhg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhsRt15Gvz3fK1
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Mar 2026 18:18:01 +1100 (AEDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62R3e8WX3644267;
	Fri, 27 Mar 2026 07:17:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=BUL4pKTSEe0gAqr+K
	m+xx8EMdADlTk5q1TiL0S+Zbos=; b=plpbXOhgRck8m9Ou24Q9O6kfgyY1tZxEW
	FrPAEchrfAaHNVupiChJNUjgh1mqVUCkBtlM+fJedIIHGMXA59REsJQudk39Qh0P
	XiG7t4y4ll3vQLNKRMIzpKlTVbQ8pAU50+t/DuVHjypjjEn8hj/pITrNt4rd/WNM
	EooD4QbcpHzPfuPj4rgbBILtqJ4fd0ffxGpmV5C2i5Mor++RngNfaovIqKjPQHbv
	rJw6lK1q5xoc+IbRpytI5n8wyu+uGA/sc9zQXHXZHNM3bhrXw+YM0/ZRRAnBCrTW
	sY94er4Pg2KG/IUbeDPQuF/Cz+4251/Ei0EaEMi4pJF6tHmqCWnlA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ky0fs8x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Mar 2026 07:17:52 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62R7Cgcd004399;
	Fri, 27 Mar 2026 07:17:51 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d28c2e8qb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Mar 2026 07:17:51 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62R7HnRI36045108
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Mar 2026 07:17:49 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA67F20043;
	Fri, 27 Mar 2026 07:17:49 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E8082004D;
	Fri, 27 Mar 2026 07:17:46 +0000 (GMT)
Received: from li-3f69264c-2ce6-11b2-a85c-c3f414d24014.ibm.com.com (unknown [9.124.208.5])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Mar 2026 07:17:46 +0000 (GMT)
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
Subject: [PATCH v3 09/13] selftests/mm: skip uffd-wp-mremap if UFFD write-protect is unsupported
Date: Fri, 27 Mar 2026 12:46:03 +0530
Message-ID: <5bc0fe27cdd316ef6f776bf9b52b6c0de4bef54f.1774591179.git.sayalip@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1774591179.git.sayalip@linux.ibm.com>
References: <cover.1774591179.git.sayalip@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDA1MyBTYWx0ZWRfXy74mYcYDtW9E
 66faNfVZecpGCcdK8XEu/3mVuDu8n3p83cekWLWd9D8b2FK9nSFVx/4Q71xL0M2WlEVOtGUkAWV
 rxHkk0TVItCPjtxNanBTViXsfbGdt9wPxFVEy/1q8wVKdcIjGAsw8PedtraXmxUo+yHdmMv+3vW
 Xaucssvchl/c+t9rLLCwR8OA6J2JX/rw1oPNmGururSiCU83JURHgTRLlKCdRD4Wby1LfzgOics
 q84t3IieEzdrDFb5JY64JuhDYlHueG4E4JptigDqHaXsu716VnAhdMgLyyauVGKZVfkR51NwlHZ
 IgrXZhncyDCveKlYwfn5hKih3Nq05eLfu9JUlpIruxvskamtWMLQZLoHA6hh6Ue+We83DpiPKuO
 9pXyzxxNvg1YLCYtQ6TpfLmzCEjMzddRIOIno9/yrSTYR76BtI78eaTYPNNOQ7TxT0ECmwAgLqn
 lVVaiNAakvfDcAsivqw==
X-Authority-Analysis: v=2.4 cv=JK42csKb c=1 sm=1 tr=0 ts=69c62f21 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=Ikd4Dj_1AAAA:8 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=43jm8jFf0dXJBzv0ducA:9
X-Proofpoint-ORIG-GUID: mFA_b2akFxD__gB1wEB5-Q8CztuGwVMc
X-Proofpoint-GUID: x7FQ4wwcmolayTjYtuQNTUgsPo3mnvAR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_04,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 adultscore=0
 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603270053

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

Acked-by: Zi Yan <ziy@nvidia.com>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Sayali Patil <sayalip@linux.ibm.com>
---
 tools/testing/selftests/mm/uffd-wp-mremap.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/testing/selftests/mm/uffd-wp-mremap.c b/tools/testing/selftests/mm/uffd-wp-mremap.c
index 17186d4a4147..6edbd09f0ca6 100644
--- a/tools/testing/selftests/mm/uffd-wp-mremap.c
+++ b/tools/testing/selftests/mm/uffd-wp-mremap.c
@@ -19,6 +19,17 @@ static size_t thpsizes[20];
 static int nr_hugetlbsizes;
 static size_t hugetlbsizes[10];
 
+static void check_uffd_wp_feature_supported(void)
+{
+	uint64_t features;
+
+	if (uffd_get_features(&features) && errno == ENOENT)
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


