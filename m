Return-Path: <linuxppc-dev+bounces-18103-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CDE5105A595
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Mar 2026 12:27:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fWn0q5Htsz3cGC;
	Thu, 12 Mar 2026 23:26:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773318395;
	cv=none; b=AL/5p9L61Oyv35EdFrnoyYMKLJGBsEdPTqJi2qA56RjEAXaUOJIwrHIKw8H3pIDItWCCmxn0/s474yjeVy2Rx6dWlrfclJnBnBdSFXHpiPcPMW8mAm+quacqqBchIMmJ3mdGfDbJ8GygPGjuMlVqTLtic2uPVNz6m8TgoU7S7j7uAtlJH3UfsbjEN83aWURsVH7hStnSNeGZVOoto5Z7JFyQ+btWl6U+H2ub6+aWVQoFDa2FTKmnfRMre9UCGEZbAMLju8vBg9f6FkhF7vUyi3jJL0zBVbC+fPjLUngifseBHdkhgFhV8rR0p6GtXS0s3eiZCRQQiUiKq0Jn7GE3xw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773318395; c=relaxed/relaxed;
	bh=S35teiWtc8PSRbxJ3q6EYGplmQn3z8ekylo+btqP9Iw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UJyD55N5VL/55hzyVMV22WWwtaOUmSKY/PTtVEQaLGOBRXdgD7x40GHXhDcIO6NWvfJ77C4qRQzp+WKj0krF7BFXYbHfY2lpGa0/mpQ7JuP6oHt4aRXANNaz+1uTsqRs0WNcng+evHMKLiF+r0oUPN5uXkMECBQAeCjqAJJ60ry3hPfIBW5EOY+/EyLawgU9RdrbBx4fI7pIjZjTrQSGagzmwKh6p7jPA3CSbvEsheXZmw0PO4rHkX06WGRhbDX3oiih20Bgl9d8vv8qdSEWq8BZTCyXGvY1zKmKmWkg5gTSxj4EMUcaEWsdFpSffrB4c+DozYSTKhB/7sXXdx50HQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=penDa6sF; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=penDa6sF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fWn0q0RQkz3cG9
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2026 23:26:34 +1100 (AEDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62BMWWns2206305;
	Thu, 12 Mar 2026 12:26:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=S35teiWtc8PSRbxJ3
	q6EYGplmQn3z8ekylo+btqP9Iw=; b=penDa6sFpLqlc2Z31F8g2yk/03aZy+1Gi
	tgQIUIdx4UShRLHxL9Zu1r3gOVp57D8DL5QC/67dQ5xJjbv7ta9jHYktTZ8WqCXp
	WqRc/aDw4r92KKyPWZmDpFc8zVuESdjftmA0jlakOoIRiayrD0AvUzsihX2yxxwy
	0WN3anSkL01A12mCLA16FyX607ipQJV0I+XCPqO/eBQQ1SZHMvtykkL1bEVYwWa2
	GK05i3N8fTBfqoIdDFkqYCLLVAaN/U/9EOdJfwZMSb/WwwqDwbCQqhvpWGIxBb1g
	fkOGtFIKHcIz6NAsJRXvukahrmXYKOBKnMCLZDxMjlY0VuGdky+YA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cuh98ag5v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Mar 2026 12:26:25 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62C9UJcX006091;
	Thu, 12 Mar 2026 12:26:24 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cuha9j8tk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Mar 2026 12:26:24 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62CCQMCl29950494
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Mar 2026 12:26:22 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4991B2005A;
	Thu, 12 Mar 2026 12:26:22 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 43C6D2004E;
	Thu, 12 Mar 2026 12:26:19 +0000 (GMT)
Received: from li-3f69264c-2ce6-11b2-a85c-c3f414d24014.in.ibm.com (unknown [9.109.243.201])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 12 Mar 2026 12:26:19 +0000 (GMT)
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
Subject: [PATCH v2 06/13] selftest/mm: adjust hugepage-mremap test size for large huge pages
Date: Thu, 12 Mar 2026 17:55:33 +0530
Message-ID: <0ea624c4bf022425b50c50cf8f5e3023106db9c1.1773305677.git.sayalip@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=M+pA6iws c=1 sm=1 tr=0 ts=69b2b0f1 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=Ikd4Dj_1AAAA:8 a=VnNF1IyMAAAA:8
 a=XJxsNr-lJcu-CM6y12UA:9 a=aORTNHwJY3_lF7LJ:21
X-Proofpoint-GUID: q-RMTPH_tpU5SGw3Wa58CTuUEtnfEFr8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEyMDA5NSBTYWx0ZWRfXzF31PZH6Y4lD
 kXY93iUgJyvyhsXwZvaOkgU4KwIJ8VLjOemqa5LF9be7uk8CA/jMETKo1NyTYjl7SQoMSs+sDod
 pGB78vL8LI2/aat6tGqQcYZsDszaAgJRzQYY0DI9nQwNxxEChK0IQRZi6AhZGPBIHKLYesMbmFp
 DsKXtPZS4VWXH/6hwxM7VbBUZKA7pHk50kDRgwCUwovb0xIE+dWRffqP68RZbrsd8zpKLO7C8YG
 dQw9uqIVl+1HyDEsVF9JMLoMKpSQVczDwYQsKaHjuwPp4vL+tFT2He6KZHeq6Ii3AXb52XbcGwv
 HNF9TIFjkQ0HQW6TChEyjyvJkqcXye6PbmIedEXRqPPVwU02/elkSWp59CxSIWmj3saPN2lrvlw
 RVmYaq9p4+w6+125oYSNdrV/fqIMmt4SI/cBppwUyE3sVwbMUTBjnUp7clyZmXHz8+Gl/z1nrn1
 KedyC/odVT0wiD8XApg==
X-Proofpoint-ORIG-GUID: _7HmwtI68tYGFC3JcMC5MakMfFyyxV-a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-12_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603120095

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


