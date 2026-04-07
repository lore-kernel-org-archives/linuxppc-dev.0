Return-Path: <linuxppc-dev+bounces-19434-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32530FEEF2E
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Apr 2026 13:09:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fqmkF5p5Wz2yZ3;
	Tue, 07 Apr 2026 23:09:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775567365;
	cv=none; b=eGjUtN7RdEpevk5xiRp2VwznO5FZAGmnOJJVJ15GCAuheeqTTMeyr4/sYK546kCbCx+B+6RaNWgPod9LdsFOFkkxcwbM2tJJ6FLPs/oHZSbxrx0OQ8UAcpkKEMxrfC8yySIFo1jP7PKLfAWWqGwVtD2YnBIX1b7uvBhtDK+KPIrISBYOqmPZMIE78lDl5FShcS45u9LxX4UDvFmMqVxLygPA3bkEANB5kaqSJi3IcqvLT0zcf9RRcNi8QK+iaiGSCIMPtBWjPVwcwb/WfvenHJbPBk+Kq4N8yGqgh7wItxUTo21Urz1DsCdnX3e3cAiZti3+CYa0Jkwx1dtZJd8lZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775567365; c=relaxed/relaxed;
	bh=FItEFcj0rTvSsv8dNr4j3B9MFFiOFkMEo1S6fzbKUeY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=agA8qagEOrPbCaAvA/Kgnhav7888WfnDviHscZPcgOCi9CD1WyWvGvbrKxv+lVkMp+IXd5OuK5O7T4aJ2IsxttfciWzZdoEk1MBaIh5Y6XhFnId7tqAJj4+nNVPPaV0jSYv7B6iENdzZZf8TUD2ueyC5iRP+rTVxLZ73URUc2ku47EhM8/BPFhxObZV4Kcrj+WQlebz0WYCJ6DA8zpYQgGKa/gWIgMRwRZhgvHcTzpECY1albSeH67l3YixyRn2b9aqJjrUrTBa+lctZH7ky/BLb4cBWJ5+1R98MTcVM0KgyrwVSbnSErzyXfmYcOaD4jPbcAfj5N4GyDmVTMsrOIQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=EtvohyZF; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=EtvohyZF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fqmkD4Z8xz2ySS
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Apr 2026 23:09:23 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 636LmvGM2212549;
	Tue, 7 Apr 2026 13:09:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=FItEFc
	j0rTvSsv8dNr4j3B9MFFiOFkMEo1S6fzbKUeY=; b=EtvohyZFpZqHp5LtqmW+jI
	Rk2YZAqXZ3Ge2dylErZdACDpvwbMur3JhYiZTzozAdClEv8YWexLCXXUneBEWWPT
	ItAzvwcrsfwbu2UeGjndO3S06hbixT49cT5L9UjxwWUH+Gs5MKADxDA69FdphI5S
	tzik5zyq7v8Y3IaVwX/us/jvDdB1aGmVH6ogfZ/IdflSIylQ2rvG5ge5nqBkf8ia
	DIftP86yageKmUAIeMtJL1UdntSkLdYkrMHLjeD5PGJN3bNRpL9ezDPaj5SK9/Cl
	UeLvq9fpM4j//q/AKzMWGwHoneESYbtpeplJXMD/+A3k4wjf7TpQlrWoJds3N+FQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2hasyt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 13:09:05 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 637BQMZM013902;
	Tue, 7 Apr 2026 13:09:05 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dcmf438yr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 13:09:05 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 637D94gv8323876
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Apr 2026 13:09:05 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CD64758055;
	Tue,  7 Apr 2026 13:09:04 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 387D05804B;
	Tue,  7 Apr 2026 13:08:59 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.61.247.154])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  7 Apr 2026 13:08:58 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
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
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH v4 00/15] selftests/mm: fix failures and robustness
 improvements
From: Venkat <venkat88@linux.ibm.com>
In-Reply-To: <cover.1775466329.git.sayalip@linux.ibm.com>
Date: Tue, 7 Apr 2026 18:38:46 +0530
Cc: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>,
        David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>,
        Michal Hocko <mhocko@kernel.org>, Oscar Salvador <osalvador@suse.de>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Dev Jain <dev.jain@arm.com>, Liam.Howlett@oracle.com,
        linuxppc-dev@lists.ozlabs.org, Miaohe Lin <linmiaohe@huawei.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2CAD5B1A-7FD2-4C5C-9279-A3131EF60D86@linux.ibm.com>
References: <cover.1775466329.git.sayalip@linux.ibm.com>
To: Sayali Patil <sayalip@linux.ibm.com>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDEyMCBTYWx0ZWRfX1ak3vKXmOqHg
 g2dbfUiNW5cdhKvh7bMuFP6rK7s65G7isGJ77Uvw+TDXQTVNTIY1t6I3iKoXdI6uCI8iiVNwhpA
 KPJK9PRsu5BWtPLNQ1bWSS8zNe+PBZ7Db/P502/GRaRXn3wqzkWsffFv4Z51rDviyftnwRA6oI9
 5huuHs89lPYdaodJ1rOAUVgI2I2GaJDMB2I0sYWaHisj4bXxmEiAKkdTPG/p039zmITgwXJfAAf
 uwgyzOePSxrwHByR/J7uYr7UturMTUR3pq6P4QWrV2WD9bOr1R6EO0rpp+6ZE9nvQkZEFK6FaMN
 t3JN0BHhe5440zxKU+bmETvrd+bvkDW3RSikAH/spVd74t73RMNg1fK+31/6Gu/34tO9/9NSray
 QRbJ2Yrsyvk3SnE9lBGLGjXyaZOIzN7lyQiPltUZIGYnRO3rd0vQFiHYw7uYEejhOwO6eAm3k2P
 Noz1thdoH0niTjadW2Q==
X-Proofpoint-GUID: 36-U94uf4L4vh9ztE91hE3oUw1FjIAGo
X-Authority-Analysis: v=2.4 cv=a/wAM0SF c=1 sm=1 tr=0 ts=69d501f2 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=UB1gz0I0rgZDmcXxxXkA:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
X-Proofpoint-ORIG-GUID: CvfsEvoqX-LOpTSFK1gUxWWMwfWEeSSw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1011 spamscore=0 impostorscore=0 priorityscore=1501
 phishscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070120


Hi Sayali,

I tested the full series, and overall it looks good. In particular, the
series resolves the issue reported in v2 [1], and the other patches in
the series behaved as expected during my testing.

[1]: =
https://lore.kernel.org/all/cf815c21-138e-44c8-986d-d8496503ee32@linux.ibm=
.com/

The only concern I observed is specific to patch 15/15. On systems using
1GB huge pages, I noticed below failure.

  ./test_hugetlb_memcg
  # Hugepage size: 1048576 kB
  # memory usage should go back down.
  # expected memory: 4194304
  # actual memory:   8388608
  not ok 1 test_hugetlb_memcg

Apart from this case, the rest of the series tested cleanly for me. =
Based
on that, it seems that dropping patch 15/15 independently makes sense.

Hence for the series,

Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>

Regards,
Venkat

> On 6 Apr 2026, at 2:49=E2=80=AFPM, Sayali Patil =
<sayalip@linux.ibm.com> wrote:
>=20
> Hi all,
>=20
> Powerpc systems with a 64K base page size exposed several issues while
> running mm selftests. Some tests assume specific hugetlb =
configurations,
> use incorrect interfaces, or fail instead of skipping when the =
required
> kernel features are not available.
>=20
> This series fixes these issues and improves test robustness.
>=20
> Please review the patches and provide any feedback or suggestions for
> improvement.
>=20
> Thanks,
> Sayali
>=20
> ---
> v3->v4
>=20
>  - selftests/mm: restore default nr_hugepages value via EXIT
>    trap in charge_reserved_hugetlb.sh:
>    Updated to use an EXIT trap to restore the original nr_hugepages
>    once at script termination, ensuring reliable restoration on all
>    exit paths.
>=20
>  - selftest/mm: fix cgroup task placement and drop memory.current =
checks
>    in hugetlb_reparenting_test.sh:
>    Updated to use a deterministic synchronization method by migrating =
the
>    workload process within a wrapper subshell before calling exec() to=20=

>    ensure correct cgroup accounting.
>=20
>  - selftest/mm: align memory size to huge page size in hugepage-mremap
>    test:
>    Update test code directly to align memory allocations to the =
hugepage
>    size, rather than modifying run_vmtests.sh. This replaces the =
previous
>    commit =E2=80=9Cadjust hugepage-mremap test size for large huge =
pages=E2=80=9D with
>    a cleaner, direct approach in the test itself.
>=20
>  - selftests/mm: ensure destination is hugetlb-backed in =
hugepage-mremap:
>    Updated to remove MAP_POPULATE flag for the mmap call as per review
>    comment.
>=20
>  - selftests/mm: skip uffd-wp-mremap if UFFD write-protect is =
unsupported:
>    Updated as per review comment to initialize features to zero and =
exit
>    on all uffd_get_features() failures, avoiding spurious test errors.
>=20
>  - selftests/mm: move hwpoison setup into run_test() and silence
>    modprobe output for memory-failure category:
>    Declared LOADED_MOD as local variable and avoided a redundant=20
>    skip message when the module is not found.
>    Updated logic to set exitcode to ksft_skip only when no failure has
>    been recorded.
>=20
>  - selftests/cgroup: extend test_hugetlb_memcg.c to support all huge
>    page sizes:
>    Updated to skip on memory constraints instead of returning
>    EXIT_FAILURE.
>    Updated the logic to fully account for the scenario when the
>    per-CPU stock is empty and a refill charges MEMCG_CHARGE_BATCH.=20
>    Updated to avoid overflow on 32-bit systems for memory.max value.
>=20
>  - Included "selftests/mm: restore default nr_hugepages value via
>    EXIT trap in hugetlb_reparenting_test.sh"
>=20
>  - Included "selftests/mm: free dynamically allocated PMD-sized
>    buffers in split_huge_page_test"
>=20
>  - Included "selftests/mm: clarify alternate unmapping in =
compaction_test"
>=20
>  - Dropped "selftests/mm: fix double increment in linked list cleanup =
in
>    compaction_test":
>    The behaviour is intentional.
>=20
> v3: =
https://lore.kernel.org/all/cover.1774591179.git.sayalip@linux.ibm.com/
>=20
> ---
> v2->v3
>  - selftests/mm: skip uffd-wp-mremap if UFFD write-protect is =
unsupported:
>    Rename function to check_uffd_wp_feature_supported() as suggested =
in review.
>  - selftest/mm: fix cgroup task placement and drop memory.current =
checks
>    in hugetlb_reparenting_test.sh:
>    Drop memory.current validation from the hugetlb reparenting test.
>    Keep tolerance at 7MB (reverting earlier increase to 8MB in v1).
>  - Included "selftests/mm: allow PUD-level entries in compound =
testcase of hmm
>    tests" patch:
>    Extend the compound testcase checks to accept PUD-level mappings.
>  - Included "selftests/mm: replace hardcoded THP size with runtime PMD =
page size in
>    hmm tests" patch:
>    Use read_pmd_pagesize() instead of TWOMEG and cap maximum THPs in
>    benchmarks to avoid integer overflow.
>=20
> v2: =
https://lore.kernel.org/all/cover.1773305677.git.sayalip@linux.ibm.com/
>=20
> ---
> v1->v2
>  - For "selftests/mm: ensure destination is hugetlb-backed in =
hugepage-mremap":
>    update FLAGS definition to MAP_HUGETLB | MAP_SHARED | MAP_POPULATE =
and
>    used it for mmap() calls as suggested during review.
>=20
> v1: =
https://lore.kernel.org/all/cover.1773134177.git.sayalip@linux.ibm.com/
> ---
>=20
> Sayali Patil (15):
>  selftests/mm: restore default nr_hugepages value via EXIT trap in
>    charge_reserved_hugetlb.sh
>  selftests/mm: fix hugetlb pathname construction in
>    charge_reserved_hugetlb.sh
>  selftests/mm: restore default nr_hugepages value via EXIT trap in
>    hugetlb_reparenting_test.sh
>  selftests/mm: fix hugetlb pathname construction in
>    hugetlb_reparenting_test.sh
>  selftests/mm: fix cgroup task placement and drop memory.current =
checks
>    in hugetlb_reparenting_test.sh
>  selftests/mm: size tmpfs according to PMD page size in
>    split_huge_page_test
>  selftests/mm: free dynamically allocated PMD-sized buffers in
>    split_huge_page_test
>  selftest/mm: align memory size to huge page size in hugepage-mremap
>    test
>  selftest/mm: register existing mapping with userfaultfd in
>    hugepage-mremap
>  selftests/mm: ensure destination is hugetlb-backed in hugepage-mremap
>  selftests/mm: skip uffd-wp-mremap if UFFD write-protect is =
unsupported
>  selftests/mm: skip uffd-stress test when nr_pages_per_cpu is zero
>  selftests/mm: move hwpoison setup into run_test() and silence =
modprobe
>    output for memory-failure category
>  selftests/mm: clarify alternate unmapping in compaction_test
>  selftests/cgroup: extend test_hugetlb_memcg.c to support all huge =
page
>    sizes
>=20
> .../selftests/cgroup/test_hugetlb_memcg.c     | 90 ++++++++++++++-----
> .../selftests/mm/charge_reserved_hugetlb.sh   | 45 ++++++----
> tools/testing/selftests/mm/compaction_test.c  |  3 +
> tools/testing/selftests/mm/hugepage-mremap.c  | 42 ++++-----
> .../selftests/mm/hugetlb_reparenting_test.sh  | 59 ++++++------
> tools/testing/selftests/mm/run_vmtests.sh     | 52 +++++++----
> .../selftests/mm/split_huge_page_test.c       | 27 ++++--
> tools/testing/selftests/mm/uffd-stress.c      |  6 +-
> tools/testing/selftests/mm/uffd-wp-mremap.c   | 13 +++
> 9 files changed, 220 insertions(+), 117 deletions(-)
>=20
> --=20
> 2.52.0
>=20


