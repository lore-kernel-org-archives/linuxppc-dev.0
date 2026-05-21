Return-Path: <linuxppc-dev+bounces-21268-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A08FCD4F3D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 May 2026 06:34:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gLdt055Vfz2xSN;
	Thu, 21 May 2026 16:34:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779345256;
	cv=none; b=fS5789fwQDPiTaTyJsbnE4tGKltq8yzrE4Ns9YGtMRBfFzLm3KS8xB+d7byWGcr8Ho1r7nYUNN0NAXgtGljbJTymmAyu6Xi7qKiZiX8vCUL13vRadpgxLXJHV7W32EpRB35k4rphNexdcDKYLEW/Ni+P7ViaDLRd0Lb+7CGa4TYgbJU/uawEdIykE9mkHXIRDVt8IguKOFc/IYwu9i3UPv2Uyk8a+p8sX6dNgV1OvKGSTOpTkhofImkR5/2y0aZHZYOKXMYiMuXC3XAEDnXi8mIly/VL4ebbtaZkHRu4sjvoY2LUYTMw2iGX6Nf4zBvi5I31tGKwzpzwQrx6dwvREw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779345256; c=relaxed/relaxed;
	bh=g9WVnCA24T2oL88dvdbZWW8RyQkE/CjsO7VzbhzZYnU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aKRFh4eRgEVEh99Y/Wx5EMyE1Y+NcIwlTOXNujT48534QDa6/RxwDtCFdWuXAMtcPkxA/iR2V4EH85YUoHE7hqHRn3mFNS34oVugThXnQzBTqFlE0KxnEquMmzr7pTo+sL+4C5mHUMwxaT2oIiZuq9YTznypdvbJMarkEK7ZGnZk/mcZhbMNG5ReaQTX6Ov3ycOvKlhKMPdVRIolYLPlKmDXKNPXirU1/OnVrLgzJI0Yaev8uQRI93X3JkMdJ12YCMRJcsIW//TESTHvkdkagWjRxTBjaGNVFujJ2NHYHndYjzR+JSfPOiur5M4OnBlfKQtCTleNgef4EruENuNIAg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=O/BSAGw/; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=O/BSAGw/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gLdsy6jzHz2xQD
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2026 16:34:14 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64KNlX7S3300127;
	Thu, 21 May 2026 06:33:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=g9WVnCA24T2oL88dvdbZWW8RyQkE
	/CjsO7VzbhzZYnU=; b=O/BSAGw/6S0sC1qAt/fNchCv+7+gnycgBItLhI/GrG5P
	4iL18vwuR3R3DrNzBG32bOO4huPvgXDDgCpX1P/vCQgerNTrtE8YXjqJmDYQ57Fp
	PLM8nLDNCsGtOLneBXtCNXrfVKaHWHa1XUTUp52UwcHdX0cBQuCWs14LCkjMgHjx
	+Cp0071z4yFUkpH1vx4MeGfI7hEXN6vpyFJaKvZzqGZ0I+050lFzoTGpRAMhqtmR
	SvCJ1fRaK6jDnRrvSKHDkhnLbwwAu45Pmf0fgZ+EVB2Ol2BfMIPp7IxuWBUyI0zd
	G1Z1bL9Hi8NNwIjOK0XZtPKUpd/qOIpTVOfasY++BA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h8mwe7m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 06:33:54 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64L6O5lR030810;
	Thu, 21 May 2026 06:33:53 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e72wqb0qt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 06:33:53 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64L6XmJr26149286
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 May 2026 06:33:49 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 11ED92004D;
	Thu, 21 May 2026 06:33:48 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EE07120040;
	Thu, 21 May 2026 06:33:42 +0000 (GMT)
Received: from li-3f69264c-2ce6-11b2-a85c-c3f414d24014.bl1-in.ibm.com (unknown [9.123.3.209])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 21 May 2026 06:33:42 +0000 (GMT)
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
Subject: [PATCH v7 00/13] selftests/mm: fix failures and robustness improvements
Date: Thu, 21 May 2026 12:03:26 +0530
Message-ID: <cover.1779296493.git.sayalip@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: hz_YckkSsHYZrecc5lNdrGv9IQuwwQhn
X-Authority-Analysis: v=2.4 cv=GYMnWwXL c=1 sm=1 tr=0 ts=6a0ea752 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=8uJy_1Y6CBqRYfEKyIkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10
X-Proofpoint-ORIG-GUID: Yk5UnuRzX8TjhS7V9Py9-Hz9jIEhf8mK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA1NyBTYWx0ZWRfX40wz7CRbj800
 Ic8o853IFxhsWyXDz5rrXeWdj6/jw1+vJevkZD7uap/q64XNI2ebKact6M0CrsRKExFbg07Bn21
 nMJewHLLwwORDvOIlJqrMxg1p8K++JmYXiUODQP30CuC0MQ6MLYtKDv07G0VBeaJc1/uogs6BRW
 whN23xeZI9OPD4W1egQy2iPkCr9GkAGFTy9OjMKuyGbmhyb4d0FvT3CIbG2gIWjDU3oq+9yd/hv
 I04CdNnJ3qG9qMaU/qhvkPIojPDHVliceZ65uBCLNBtlJT9YA9rwnX1gWbJO+SeYQXFKBQdhmmo
 14cwti/DbfGchvps2bn1E6tGA7mb4cZYjat86fji07Oht08nlQZF6c1DB7Gtwb8+KhdEM6+/MoT
 qsZKALSAtOgARSogvGHH2d25H19Z9xDnu3ldQSVxPlTzbgro7uA+eLahyPuCUCRjyGRKVUtFh8J
 hsu4iAloysIyGSFRgVg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210057


Hi all,

Powerpc systems with a 64K base page size exposed several issues while
running mm selftests. Some tests assume specific hugetlb configurations,
use incorrect interfaces, or fail instead of skipping when the required
kernel features are not available.

This series fixes these issues and improves test robustness.

Please review the patches and provide any feedback or suggestions for
improvement.

Thanks,
Sayali

---
v6->v7
  - Rebased onto the latest mm-new branch, top commit of the base is
    commit 0cec77cfd531 ("mm/filemap: fix page_cache_prev_miss() when no hole is found")
  - Dropped "selftest/mm: align memory size to huge page size in
    hugepage-mremap test":
    Similar patch has already been merged.
  - For "selftests/mm: skip uffd-stress test when nr_pages_per_cpu is zero":
    Changed format specifier of bytes to %zu as per review
    comment.
  - For "selftests/mm: move hwpoison setup into run_test() and silence
    modprobe output for memory-failure category":
    Added condition to avoid executing the test pipeline for skipped tests and assign
    ret directly.

v6: https://lore.kernel.org/all/cover.1777877814.git.sayalip@linux.ibm.com/
---
v5->v6
  - For "selftests/mm: restore default nr_hugepages value via exit trap
    in charge_reserved_hugetlb.sh":
    Extended trap to include INT and TERM in hugetlb tests to ensure
    nr_hugepages is restored on signal-based exits.
  - For "selftests/mm: restore default nr_hugepages value via exit trap
    in hugetlb_reparenting_test.sh":
    Extended trap to include INT and TERM in hugetlb tests to ensure
    nr_hugepages is restored on signal-based exits.
  - For "selftests/mm: fix cgroup task placement and drop memory.current
    checks in hugetlb_reparenting_test.sh":
    Updated the subshell invocation to pass variables as positional arguments
    instead of interpolating them into the command string as per review comment.
  - For "selftests/mm: move hwpoison setup into run_test() and silence modprobe
    output for memory-failure category":
    Updated the condition to avoid unconditional module removal and ensures it is
    only unloaded if loaded by the test.

v5: https://lore.kernel.org/all/cover.1776150071.git.sayalip@linux.ibm.com/
---
---
v4->v5
  - For "selftests/mm: move hwpoison setup into run_test() and silence modprobe
    output for memory-failure category":
    Renamed LOADED_MOD to LOADED_HWPOISON_INJECT_MOD as per review comment.
  - Dropped "selftests/cgroup: extend test_hugetlb_memcg.c to support all huge
    page sizes":
    Due to intermittent failures observed on some systems.
  - Added Tested-by from Venkat for all patches.
  - Added Reviewed-by from Zi yan for patches 7,8 and 13.
  - Added Acked-by from Zi yan for patches 1 and 3.

v4: https://lore.kernel.org/all/cover.1775466329.git.sayalip@linux.ibm.com/
---
v3->v4

  - selftests/mm: restore default nr_hugepages value via EXIT
    trap in charge_reserved_hugetlb.sh:
    Updated to use an EXIT trap to restore the original nr_hugepages
    once at script termination, ensuring reliable restoration on all
    exit paths.

  - selftest/mm: fix cgroup task placement and drop memory.current checks
    in hugetlb_reparenting_test.sh:
    Updated to use a deterministic synchronization method by migrating the
    workload process within a wrapper subshell before calling exec() to 
    ensure correct cgroup accounting.

  - selftest/mm: align memory size to huge page size in hugepage-mremap
    test:
    Update test code directly to align memory allocations to the hugepage
    size, rather than modifying run_vmtests.sh. This replaces the previous
    commit “adjust hugepage-mremap test size for large huge pages” with
    a cleaner, direct approach in the test itself.

  - selftests/mm: ensure destination is hugetlb-backed in hugepage-mremap:
    Updated to remove MAP_POPULATE flag for the mmap call as per review
    comment.

  - selftests/mm: skip uffd-wp-mremap if UFFD write-protect is unsupported:
    Updated as per review comment to initialize features to zero and exit
    on all uffd_get_features() failures, avoiding spurious test errors.

  - selftests/mm: move hwpoison setup into run_test() and silence
    modprobe output for memory-failure category:
    Declared LOADED_MOD as local variable and avoided a redundant 
    skip message when the module is not found.
    Updated logic to set exitcode to ksft_skip only when no failure has
    been recorded.

  - selftests/cgroup: extend test_hugetlb_memcg.c to support all huge
    page sizes:
    Updated to skip on memory constraints instead of returning
    EXIT_FAILURE.
    Updated the logic to fully account for the scenario when the
    per-CPU stock is empty and a refill charges MEMCG_CHARGE_BATCH. 
    Updated to avoid overflow on 32-bit systems for memory.max value.

  - Included "selftests/mm: restore default nr_hugepages value via
    EXIT trap in hugetlb_reparenting_test.sh"

  - Included "selftests/mm: free dynamically allocated PMD-sized
    buffers in split_huge_page_test"

  - Included "selftests/mm: clarify alternate unmapping in compaction_test"

  - Dropped "selftests/mm: fix double increment in linked list cleanup in
    compaction_test":
    The behaviour is intentional.

v3: https://lore.kernel.org/all/cover.1774591179.git.sayalip@linux.ibm.com/

---
v2->v3
  - selftests/mm: skip uffd-wp-mremap if UFFD write-protect is unsupported:
    Rename function to check_uffd_wp_feature_supported() as suggested in review.
  - selftest/mm: fix cgroup task placement and drop memory.current checks
    in hugetlb_reparenting_test.sh:
    Drop memory.current validation from the hugetlb reparenting test.
    Keep tolerance at 7MB (reverting earlier increase to 8MB in v1).
  - Included "selftests/mm: allow PUD-level entries in compound testcase of hmm
    tests" patch:
    Extend the compound testcase checks to accept PUD-level mappings.
  - Included "selftests/mm: replace hardcoded THP size with runtime PMD page size in
    hmm tests" patch:
    Use read_pmd_pagesize() instead of TWOMEG and cap maximum THPs in
    benchmarks to avoid integer overflow.

v2: https://lore.kernel.org/all/cover.1773305677.git.sayalip@linux.ibm.com/

---
v1->v2
  - For "selftests/mm: ensure destination is hugetlb-backed in hugepage-mremap":
    update FLAGS definition to MAP_HUGETLB | MAP_SHARED | MAP_POPULATE and
    used it for mmap() calls as suggested during review.

v1: https://lore.kernel.org/all/cover.1773134177.git.sayalip@linux.ibm.com/
---

Sayali Patil (13):
  selftests/mm: restore default nr_hugepages value via exit trap in
    charge_reserved_hugetlb.sh
  selftests/mm: fix hugetlb pathname construction in
    charge_reserved_hugetlb.sh
  selftests/mm: restore default nr_hugepages value via exit trap in
    hugetlb_reparenting_test.sh
  selftests/mm: fix hugetlb pathname construction in
    hugetlb_reparenting_test.sh
  selftests/mm: fix cgroup task placement and drop memory.current checks
    in hugetlb_reparenting_test.sh
  selftests/mm: size tmpfs according to PMD page size in
    split_huge_page_test
  selftests/mm: free dynamically allocated PMD-sized buffers in
    split_huge_page_test
  selftest/mm: register existing mapping with userfaultfd in
    hugetlb-mremap
  selftests/mm: ensure destination is hugetlb-backed in hugetlb-mremap
  selftests/mm: skip uffd-wp-mremap if UFFD write-protect is unsupported
  selftests/mm: skip uffd-stress test when nr_pages_per_cpu is zero
  selftests/mm: move hwpoison setup into run_test() and silence modprobe
    output for memory-failure category
  selftests/mm: clarify alternate unmapping in compaction_test

 .../selftests/mm/charge_reserved_hugetlb.sh   | 45 +++++++++-----
 tools/testing/selftests/mm/compaction_test.c  |  3 +
 tools/testing/selftests/mm/hugetlb-mremap.c   | 32 +++-------
 .../selftests/mm/hugetlb_reparenting_test.sh  | 60 +++++++++---------
 tools/testing/selftests/mm/run_vmtests.sh     | 62 ++++++++++++-------
 .../selftests/mm/split_huge_page_test.c       | 27 +++++---
 tools/testing/selftests/mm/uffd-stress.c      |  6 +-
 tools/testing/selftests/mm/uffd-wp-mremap.c   | 13 ++++
 8 files changed, 151 insertions(+), 97 deletions(-)

-- 
2.52.0


