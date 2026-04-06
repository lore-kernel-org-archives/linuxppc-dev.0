Return-Path: <linuxppc-dev+bounces-19398-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0ACAEF4EC9
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Apr 2026 09:21:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fq3jB0yTDz2yjp;
	Mon, 06 Apr 2026 19:21:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775467262;
	cv=none; b=OgScSMJlTFzq7UpEQiWqKPhIcB8RAV2Ods7HG/voVaJJxxB8Ns7kAkwQwlISm5olL5XfHSM1tmcHE5SJq/thyXNIq9NCT5wO84vfI5R92/i+zMtQ0cwBf3XB4/oyB34My5/Uo1VJnrmtYDbuwnrGbkUJ5JHr6/bl/p8TXnyWY36njXQ/o80D8DNTzCU6APYMNHrQwgyih+WSOMkZjTvFIg6IF9wKgtNQl6j2KLMPt4uzldbdwtLZJ7LPNuZwxIaBgmllsjuNOkAdMUjTfySIJFx1zJh1SgFWzt0iYCFhbsQoSCXTg+3EdRHK5f1CSENCs9jFsYqqRhwrJELTEqddtA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775467262; c=relaxed/relaxed;
	bh=OT+OQFCgRq+Kj1jonLnfSvCEwfsneE3cw0acLy20e6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AV948n/HAiAwbqejuJCy4lCdfGag9Pt1HQVpztOXB9Fp/mvdyEjS1xkvYLGEEneNbWpDQAeg/DO94Xs6WehdMfOlLg3vCl5Wv6STT9rdp2iRsnHzk/35lztMdzKeJdumWa1VKPhRnpaEi21aWhT63/Iq6XBZH2yJi7j2OVNEjS93f/tv1ZBuuOK126bdHLhjF/vtuhJvL143tfIsmDsnwJUFYUMd0nFCsuNo8n/1lVxnd69lEIL6EeOqdiCivnLp9shXHkPiEOv1IaSSpFUvvNjVjCU3ognbULLpQxlPsEFDeBoyTZ8JkT0wTa5JJm8g9+SK8tosH+aPUMDnfUVsVQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=LDFARfW0; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=LDFARfW0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fq3j930tqz2yhP
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Apr 2026 19:21:01 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 635HRL7A3181379;
	Mon, 6 Apr 2026 09:19:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=OT+OQFCgRq+Kj1jonLnfSvCEwfsn
	eE3cw0acLy20e6Y=; b=LDFARfW0396bSv3hZUqUyTZWS04rwq41y52Xi+92KxFF
	zMc8SdwWZv4t3a+Lpi/gpkv9TEk+EcZxgD+/kvsncXz31Fo0bx+BdAvZDwt8bUqB
	s9MLeLNYSaf+VfmTM4iZGk+lvAApWCozJhUho+gMqNlFMeGBgZYiwjXNAMX8PekB
	/eVb5/X6rbjka4IfNHA/IElhwuzYzKgVUCES8jqtF4mscDSXbllZMSq/chqncAEY
	F1x1KEtw7OLmp6iZmcXyCUJylhEHCTnkCSFl8FK1HFmMe/CZvGOZAx99ixSKYEcM
	Xr5BZSLsTFCbMhp2iKfPHR7MyIuSNntVMwQquUrEPA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4datap5vnk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Apr 2026 09:19:47 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6365ZcD3020501;
	Mon, 6 Apr 2026 09:19:46 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dbdync2v3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Apr 2026 09:19:46 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6369Jgdb35717392
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Apr 2026 09:19:42 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1790820043;
	Mon,  6 Apr 2026 09:19:42 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A062620040;
	Mon,  6 Apr 2026 09:19:38 +0000 (GMT)
Received: from li-3f69264c-2ce6-11b2-a85c-c3f414d24014.bl1-in.ibm.com (unknown [9.123.3.209])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Apr 2026 09:19:38 +0000 (GMT)
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
Subject: [PATCH v4 00/15] selftests/mm: fix failures and robustness improvements
Date: Mon,  6 Apr 2026 14:49:19 +0530
Message-ID: <cover.1775466329.git.sayalip@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=Bp+QAIX5 c=1 sm=1 tr=0 ts=69d37ab4 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=2xlL1Z9U7jiVjyWPKcYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA2MDA5MCBTYWx0ZWRfX/jT3q5ilpa6R
 aEEHN/YCS8iqXs8PaeYs2AacTfE8kLrbWHvn2HVKMXYuXDsGNHC1S203Oqrhmv5yoBr8zFu1yjy
 uj0ydsdIXafr9J532erS6OTOhxGVibodUczxZ7bTV7mam/CoQd8QIWl3nRvlPeTbw7ORlQX0Bbd
 2Kypj/SSXoa0NjpW9PnO5UmfPCiIzIkAfR3d2Enil/74TvTl09FGWbn0JHT4aNAQvyPCuPayV4Z
 k9DBOFpdfpvzBC+Wx4KEXPgxnJajqgXRLu+wNisH3k6JHsb656K45pQna8SN7OORFUfcZ24G2T1
 IBZrdtpBtytmrtc/cn7B+f5kswfHutwfks85DlEgndt7UR8+WpJtUPfq4oesYWE+XPrZf7GFyNb
 fdthDApML3C0gFmH9CDo7zCPHNADe8qRQKcGjbH1uFmF2qrMyuDFy+pE1cY+UjwAgHnsTvf+3un
 fYVe/H+/KFzyLbH/7/A==
X-Proofpoint-GUID: nuLxCR4AYTgo-aewaKBiI37kGt8DfwD9
X-Proofpoint-ORIG-GUID: rdqO_gI49MAxaHxdkg0qFKKrMoQcTweM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-06_02,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604060090

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

Sayali Patil (15):
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
  selftests/cgroup: extend test_hugetlb_memcg.c to support all huge page
    sizes

 .../selftests/cgroup/test_hugetlb_memcg.c     | 90 ++++++++++++++-----
 .../selftests/mm/charge_reserved_hugetlb.sh   | 45 ++++++----
 tools/testing/selftests/mm/compaction_test.c  |  3 +
 tools/testing/selftests/mm/hugepage-mremap.c  | 42 ++++-----
 .../selftests/mm/hugetlb_reparenting_test.sh  | 59 ++++++------
 tools/testing/selftests/mm/run_vmtests.sh     | 52 +++++++----
 .../selftests/mm/split_huge_page_test.c       | 27 ++++--
 tools/testing/selftests/mm/uffd-stress.c      |  6 +-
 tools/testing/selftests/mm/uffd-wp-mremap.c   | 13 +++
 9 files changed, 220 insertions(+), 117 deletions(-)

-- 
2.52.0


