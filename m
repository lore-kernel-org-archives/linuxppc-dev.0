Return-Path: <linuxppc-dev+bounces-19728-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B6F1ED7B84
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Apr 2026 08:22:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fvy2D1K9Xz2ySC;
	Tue, 14 Apr 2026 18:22:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776154964;
	cv=none; b=YsSVAh4Sg0zNIeZgH8eRhaSc1CVp2tuT/t4MEZ9a2kyTcl3hetkDolCS7/yHMVqHTBCF9SB7tOKadhEdAa2LMa/OtpYazJctPvlpcJO3gxmDtDeDFlodDkUncabdhtA9YVH5tVCkcIEeUqV9s8yupCizThCe2mLjM6j/Mb8l77PisXVRjKnHT45HTObWKwVOu3mAyP4uT7GBEbH6tEKzUvmuhaXA6Rd5iltFjR5E+LbNB0ccyBb8B0u9PEA9IGBpNKWoKq6NmIuJNDkhAxr6mlUWrWVWV3Xw3u7CSYIhBwAuyDkFlYR6HWIxeIifmFpzazpd4W8X9fWfAfLhmVAKhw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776154964; c=relaxed/relaxed;
	bh=KBXRqsCIn8h/3rzrFZKuuM++OVd7xx4Hu7KIt2JCVmo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jEvLpO1bhYf+K85arZF71eiTFF0MdjJJ9zdRTj8azXTR/4s5ba0BS3jnNMtMk8k20ZWT8gNcHxblkXQTyY3h+dnlkO5Dmuf8siT3RT3azTtlVTQso6QcHcP1q4JurtK2URrUiqwQFSEE178i5Sy1jI6EsNJUVajBH60EKvMWiOkxPHIsHG7CckXJpPo5jtjQtk7zSMhOdylfyWPPdQ5Gx1VBZa4R5jhxkfttFDSfVBUHT6hVXs+IuDnqSDWxweLQHE6nF8VZrvcOocAEkHbNvXoOfq1GeVZAKOtHE+o7t3tmAY2MusGMGbpltm2OTlZcGCLWpXtjYe6VhAIneAMUvA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NbfhKnaV; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NbfhKnaV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fvy2B4hMdz2yFl
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2026 18:22:41 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63DLJABm2131790;
	Tue, 14 Apr 2026 08:22:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=KBXRqsCIn8h/3rzrFZKuuM++OVd7
	xx4Hu7KIt2JCVmo=; b=NbfhKnaVvZ8DPq+7glV1TGqUGcrmSe6PeptJ4vHZJ5BH
	WThISMBV5EWUmkFSnyuTrA2D+F9xyvlV6JFwriuig+R21xLp8BzLHH4aXf9YIwo/
	0kUr4MDXTu1Fos3LgFn7zlXgMFcCfzP6APyi674qitz10+98K/iw2zqzkdQtvFgd
	NT7uYmfFSp1nRNh+Bd2rEfdG1GVjVlZq2HxNCq4kBA/ZPZYHkcNzokoiUDLJK0lu
	4xWsugGVLjgIfxU4KTkZrJLmg/WJkEPTx4Dz2BReY3Q68WU4g1E+VoEjvlGoqNxo
	P5kqE3/q5fiziTwoiLqDmpL6IlyBs6BVHruPHSijfg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89n9skm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Apr 2026 08:22:24 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63E4suMp004179;
	Tue, 14 Apr 2026 08:22:23 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dg24k8hq7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Apr 2026 08:22:23 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63E8MJXe42271026
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Apr 2026 08:22:19 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8A66F2004B;
	Tue, 14 Apr 2026 08:22:19 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 87DD520043;
	Tue, 14 Apr 2026 08:22:15 +0000 (GMT)
Received: from li-3f69264c-2ce6-11b2-a85c-c3f414d24014.ibm.com.com (unknown [9.39.26.223])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 14 Apr 2026 08:22:15 +0000 (GMT)
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
Subject: [PATCH v5 00/14] selftests/mm: fix failures and robustness improvements
Date: Tue, 14 Apr 2026 13:51:54 +0530
Message-ID: <cover.1776150071.git.sayalip@linux.ibm.com>
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
X-Proofpoint-GUID: zWoXD6XUmjoLTnR7xU2iec6uZxOh_aQG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDA3NyBTYWx0ZWRfX+sic54XNyzNF
 mC+4+oiB5KkZOdTG95yoWHAWLR4WUE5UcESOYmkZb7QCKzXvDdvCO95TVsu9KtXUm9stM6qCuHe
 NNOkQjahKd+jL2MjgkkAdLYdfc8uzOrg/vNKrEIKut1V86xDWZ8PgYSX7weH8bMJTazQI+LA6h6
 BeyPQlMJZ1ELbxIdCQb4Z9OvZEh9hy0Am9MLYrrAGhECP6nbp3Pmpz9BaKygfcQfm9HWZCLyWM7
 j/OgFe5TMGHnakdkbfbz909Ku4KVxrJN2oWJPcRJMUfP60pii3zxliyXfsGSzq3vlvEZBrfStfK
 TwyWmcuwOjsdryMCv1l257kFGCzwJbkzsGq4ZeKQrYXP8l0O5ADONkT2o4BUosMSILnvzSsdvCI
 MIBPNFIVxmiQL5ohZAxGdbsu7ZseauEXpQcB9pmBJFFN48w55ukAYa7YRVz4lmHliu6xgo1frCo
 9kIL2L7RU7B6/kUAvrg==
X-Proofpoint-ORIG-GUID: tXqzASruBBomLQ_hhi1ZKef3W-ljOAFj
X-Authority-Analysis: v=2.4 cv=FY4HAp+6 c=1 sm=1 tr=0 ts=69ddf941 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=2xlL1Z9U7jiVjyWPKcYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_02,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 bulkscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604140077

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

Sayali Patil (14):
  selftests/mm: restore default nr_hugepages value via EXIT trap in
    charge_reserved_hugetlb.sh
  selftests/mm: fix hugetlb pathname construction in
    charge_reserved_hugetlb.sh
  selftests/mm: restore default nr_hugepages value via EXIT trap in
    hugetlb_reparenting_test.sh
  selftests/mm: fix hugetlb pathname construction in
    hugetlb_reparenting_test.sh
  selftests/mm: fix cgroup task placement and drop memory.current checks
    in hugetlb_reparenting_test.sh
  selftests/mm: size tmpfs according to PMD page size in
    split_huge_page_test
  selftests/mm: free dynamically allocated PMD-sized buffers in
    split_huge_page_test
  selftest/mm: align memory size to huge page size in hugepage-mremap
    test
  selftest/mm: register existing mapping with userfaultfd in
    hugepage-mremap
  selftests/mm: ensure destination is hugetlb-backed in hugepage-mremap
  selftests/mm: skip uffd-wp-mremap if UFFD write-protect is unsupported
  selftests/mm: skip uffd-stress test when nr_pages_per_cpu is zero
  selftests/mm: move hwpoison setup into run_test() and silence modprobe
    output for memory-failure category
  selftests/mm: clarify alternate unmapping in compaction_test

 .../selftests/mm/charge_reserved_hugetlb.sh   | 45 +++++++++-----
 tools/testing/selftests/mm/compaction_test.c  |  3 +
 tools/testing/selftests/mm/hugepage-mremap.c  | 42 ++++++-------
 .../selftests/mm/hugetlb_reparenting_test.sh  | 59 ++++++++++---------
 tools/testing/selftests/mm/run_vmtests.sh     | 52 ++++++++++------
 .../selftests/mm/split_huge_page_test.c       | 27 ++++++---
 tools/testing/selftests/mm/uffd-stress.c      |  6 +-
 tools/testing/selftests/mm/uffd-wp-mremap.c   | 13 ++++
 8 files changed, 152 insertions(+), 95 deletions(-)

-- 
2.52.0


