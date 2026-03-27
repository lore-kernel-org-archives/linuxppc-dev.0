Return-Path: <linuxppc-dev+bounces-18908-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0893E10BA431
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Mar 2026 07:18:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhsRm6vwdz3fDt;
	Fri, 27 Mar 2026 18:17:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774595876;
	cv=none; b=MrzbfN6fiiiRNMvpeEGbSvh7asaamF0EydaKjvRkAQD+OV+mQ0BecsvjS6rW2SbJpnkTDgxmCXGedZnTEsi8RxtR7Gg+T1HJIosDgGkuVaiWjy/iRrc0qXAX4JEIsh1+3sRIJBcunyJOdAG4zPQWphZexvLOxFpuApIwNg7On3ssMho0d5c0kiW30sSUo7Hr50S4Y1TdJ2nkL+FVHguYVw6MNgcxSbKU8mfCyq0XqKtTZ8cZoQeEaM0groK8OxdDmqPZB2hLgKVr1JosJ+kFObDlqhnz21Q1pdwvole0FqAOSrLZ/JrGSIZPsRQLmryH2HYvlc3H2FyCdLLY1/xPTw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774595876; c=relaxed/relaxed;
	bh=t+6DwwlR9UdzBRLUYUT8hsxyw/0+r3+JFoRe2sMRrZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WWTXtzHC4fRNoKC4tMfXO9wfJamj1O5YQt8k6lIECifrMIGwqhWP3uGRfkVEB9UsOZ8eGjCFWtjtcviKZ4uybo1d344KI8R+3yCbItLDaeG9YMxqVhysIFCRcWeL37p2x5GCiWRs80UcGWKNP3mx7zC7oL6DyCK5w6H/6PKxtfMZfRi3zvCE0vstvbD+14x9l13n/M0FzuPhg0Jk+X94KuHkmrWELo0ooqU48TigpRJm+l+HuXZsSfV6QDuI8WN/Y2oAMPA+oZdtHLYMooFWNc9X1hnAEbxLqve0v9BHjW/m40plbygmPgDQIoQD23cXVDJn1gllENlIbwNsAVafZg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qOuLJrgJ; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qOuLJrgJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhsRm1fKdz3fHC
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Mar 2026 18:17:56 +1100 (AEDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62R4nIZJ504443;
	Fri, 27 Mar 2026 07:17:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=t+6DwwlR9UdzBRLUY
	UT8hsxyw/0+r3+JFoRe2sMRrZo=; b=qOuLJrgJgIwLIdMzQuyTmq/iZFEoj2q7q
	A8RAS1ekZk52W2Eu1/F71oxeHyMh0iBdUyxcMKDEWOT19EuKf4jmqobSHBg+G0Ur
	Lu49IlG382vIm833rRRiRSjTt1upiA8t2+9SBnIbTqNs893wCzAafKNOu+X6mNfm
	hXyVIqtL5MyUabP0SmWaWuxUzEXqkEb0p0YHlkUSM19TzFbxtq3Zew9DMyTOwlaq
	+/RcvV87Y6AT+J5WyTyGQq3AtJmIzwXlyBkV5qXpH+dDSUEDkeuOkVqkeQ8/u4HU
	loJu/Mnll3EHaE/WJOVGK7+hCPIpuaQ3w6FL2hrMHfwb2dHDmBHXw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kxqs19c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Mar 2026 07:17:43 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62R6YJ3u026695;
	Fri, 27 Mar 2026 07:17:42 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d275m6dn9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Mar 2026 07:17:42 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62R7HcOd58458370
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Mar 2026 07:17:38 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3F40920040;
	Fri, 27 Mar 2026 07:17:38 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BCFA02005A;
	Fri, 27 Mar 2026 07:17:34 +0000 (GMT)
Received: from li-3f69264c-2ce6-11b2-a85c-c3f414d24014.ibm.com.com (unknown [9.124.208.5])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Mar 2026 07:17:34 +0000 (GMT)
From: Sayali Patil <sayalip@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>
Cc: David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>,
        Michal Hocko <mhocko@kernel.org>, Oscar Salvador <osalvador@suse.de>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Dev Jain <dev.jain@arm.com>, Liam.Howlett@oracle.com,
        linuxppc-dev@lists.ozlabs.org, Sayali Patil <sayalip@linux.ibm.com>,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [PATCH v3 06/13] selftest/mm: adjust hugepage-mremap test size for large huge pages
Date: Fri, 27 Mar 2026 12:46:00 +0530
Message-ID: <fd252496169a91c80e339910978f21c3f4aac9f7.1774591179.git.sayalip@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: L5swmakLYAAb2i1yttyT_RRgNGQ3yBaE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDA1MyBTYWx0ZWRfX6/BORxD/4xpe
 PBhUm+p5K/KQwGqlOoEIq+o4Jf2X7QVQ4vQ7/AFlJgwg3mhXW2LL9kvDhBqTsGdZO2qZbm2XUZf
 AmWINRue8qSGBKepB/fem0obBpaPEgPamTRgVyLFTyWevy7gwsQVkd74QDoXwtcyZ06Czq+MEpp
 oHLdJpqjIxwBB43TVirAZwO0jkH88zsMM92yHcpWRwqXDMgzFkL5NukaqS9ecgNXxP6yjeE+RVA
 Ri246/8nP7/5U0Ob+h9VB42Mbt5T+vCiY5K35sf5PDXeO8wRp6GH4ID7AkezIX532gRKyx+NBER
 sAFAzIAa5516K1rivz53O5b+SRROtvcodoyAsXkskO1v+6stPGFuYz/ek/+TJfd0tVmpmxWWG+z
 Bk0cUjtigckJqpMCVku5sPxroQdoYKHuHu5eUiY7W+aWGRQMYS+MLkNuyX7RNTIVOwJit1l3+lx
 /GwKVa9W/qjPOdDdOTA==
X-Authority-Analysis: v=2.4 cv=bLEb4f+Z c=1 sm=1 tr=0 ts=69c62f17 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=Ikd4Dj_1AAAA:8 a=VnNF1IyMAAAA:8
 a=JhalB4xO2WXAR1P85RoA:9 a=aORTNHwJY3_lF7LJ:21
X-Proofpoint-GUID: 1NJj7SxDloow8wpbQh8JR6ygMBA_lmwo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_04,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603270053

The hugepage-mremap selftest uses a default size of 10MB, which is
sufficient for small huge page sizes. However, when the huge page size
is large (e.g. 1GB), 10MB is smaller than a single huge page.
As a result, the test does not trigger PMD sharing and the
corresponding unshare path in mremap(), causing the
test to fail (mremap succeeds where a failure is expected).

Update run_vmtest.sh to use twice the huge page size when the huge page
size exceeds 10MB, while retaining the 10MB default for smaller huge
pages. This ensures the test exercises the intended PMD sharing and
unsharing paths for larger huge page sizes.

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
 running ./hugepage-mremap 2048
 ------------------------------
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
 ok 1 hugepage-mremap 2048

Fixes: f77a286de48c ("mm, hugepages: make memory size variable in hugepage-mremap selftest")
Acked-by: Zi Yan <ziy@nvidia.com>
Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Signed-off-by: Sayali Patil <sayalip@linux.ibm.com>
---
 tools/testing/selftests/mm/run_vmtests.sh | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
index afdcfd0d7cef..eecec0b6eb13 100755
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -293,7 +293,18 @@ echo "$shmmax" > /proc/sys/kernel/shmmax
 echo "$shmall" > /proc/sys/kernel/shmall
 
 CATEGORY="hugetlb" run_test ./map_hugetlb
-CATEGORY="hugetlb" run_test ./hugepage-mremap
+
+# If the huge page size is larger than 10MB, increase the test memory size
+# to twice the huge page size (in MB) to ensure the test exercises PMD sharing
+# and the unshare path in hugepage-mremap. Otherwise, run the test with
+# the default 10MB memory size.
+if [ "$hpgsize_KB" -gt 10240 ]; then
+	len_mb=$(( (2 * hpgsize_KB) / 1024 ))
+	CATEGORY="hugetlb" run_test ./hugepage-mremap "${len_mb}"
+else
+	CATEGORY="hugetlb" run_test ./hugepage-mremap
+fi
+
 CATEGORY="hugetlb" run_test ./hugepage-vmemmap
 CATEGORY="hugetlb" run_test ./hugetlb-madvise
 CATEGORY="hugetlb" run_test ./hugetlb_dio
-- 
2.52.0


