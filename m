Return-Path: <linuxppc-dev+bounces-18097-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7201B105A591
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Mar 2026 12:26:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fWn0T4cCJz3cFN;
	Thu, 12 Mar 2026 23:26:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773318377;
	cv=none; b=hfyVBkUzVe6cA64rNVplcaE4Xh2WZG7sKqX5VcgqeT2N+FX9AmdKns3vXuBQPvy10FpJDdfW75OtVf1qUpHzA8CSBwNcckm0cgGgvkek1agnQes8+XUKiOwcvL+LJOG0AnT5PusociWHqW5pSHFJ1YEPK0D3OBiUesB90oR7b0b0udU68z8cfqn1q+8sp+NaE0ZlWhs/U2Sign/VzfQvF8AJ3qXsoJXAAXLwDf6j1lKkuLNuVgPDHVnyhJSeaRbneIPgwmh5p9E3+fokl3wYXuVKeQmkaDzX07NAGRiXFEjHWZEiW8e+szE04wfohrLN5+yLCmI/w1giNqUPJQqgKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773318377; c=relaxed/relaxed;
	bh=IaLbxO8utFixXJID+in4wpuw7n/xPqaFliR9xg+Vo/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eHbgleZ66XjOjxY2nUn9PSJl7Yu58dwFlh0OMWFkqVFV3W+kBa5fFpvLOw8FMzIWvxMRXnbb9EGhh65/CTtJ/8eYutxF7/GuWhSE0L0TBn4mQUzePEIC27+0ABBwMSu3nEIINFdlJiFrCQLq08t/86z1eJ7etnVAkt18pW9QOeuhDe0jqowW7cJ9RkHC5obLw9jANgAtyyyrB4uhCVYHr66Oma3LF5xB63af7rynprzYJUsKKXwppTTr3uZWBpOuAkzdLHzSbziGkrQucWGh23c3zxROybbCoqwAtssLNNpZDtTlneFQl71kp3ivRGk/vvpqq5ELFZmnHeoMfciu8A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=TwBrSu6Q; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=TwBrSu6Q;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fWn0S3Lfcz3cCJ
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2026 23:26:15 +1100 (AEDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62BMWIEb2581500;
	Thu, 12 Mar 2026 12:26:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=IaLbxO8utFixXJID+in4wpuw7n/xPqaFliR9xg+Vo
	/Q=; b=TwBrSu6QMf2LO9tJ+5qqw5YF90QbKuaJQMRTe+9KBJYWOruUhq7kGyWAl
	FX9g3Mtnx8Ctki8AqWmdAZqarmB7K7yfVoRMw9n+h/apvK78ulIz4G32BdqR+dU3
	l5ybZlbHiSRsWyTkToLXd5yUtBTGM94UuEym+YbQcqV05opzHaYel8xWIT6WgSOA
	F+GT/poM0yQWI89/7qktD5w/mNNTNQxqRAxwgsdedOJBpFvMtFq2JRV/dz8qRd+p
	B/vis1g8d+cZrHg0anSFjolyMnbjRmYn68U70yAjRaJ/8i472Ya0qHNNktbVhsSB
	qfHzv/YZEqw2zVSesy59Tj2RJagJA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cuh94tmqj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Mar 2026 12:26:04 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62C9dkw1008838;
	Thu, 12 Mar 2026 12:26:03 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cuha7296q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Mar 2026 12:26:03 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62CCQ08T49611250
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Mar 2026 12:26:01 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D53112004E;
	Thu, 12 Mar 2026 12:26:00 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D5FD02004D;
	Thu, 12 Mar 2026 12:25:54 +0000 (GMT)
Received: from li-3f69264c-2ce6-11b2-a85c-c3f414d24014.in.ibm.com (unknown [9.109.243.201])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 12 Mar 2026 12:25:54 +0000 (GMT)
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
Subject: [PATCH v2 00/13] selftests/mm: fix failures and robustness improvements
Date: Thu, 12 Mar 2026 17:55:27 +0530
Message-ID: <cover.1773305677.git.sayalip@linux.ibm.com>
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
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=QKtlhwLL c=1 sm=1 tr=0 ts=69b2b0dc cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=4qS8iJCPjNy_d4tN1AgA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEyMDA5NSBTYWx0ZWRfX/NZHFqG8TEXT
 UQU1BfuJk55ozXWIhDLV3GzlZ+BfqItW0P9S0AXPm0lcT3Sbx2Wcq84HbZEE574MHbrIj33akVP
 o2LkZ7Sp00H0CzU3F02iMQOuWn9FtN/yl05q2nUaWbFRDYTykURlv59qQeV5n9IC3TqnZYzTeyG
 9r0CTLLNDugGPxnyr0dsrViciUL41vw/h1lF65Kinnq+jHc7xOAUeFQj4ptPc7jv0XqG+vqM3+p
 NMz4ggV9aw/OC5B8HnIUx6qfl/mGD6Df3IP9j6ulJGPXXtGy0YQVRLx450SpFDFTQDQMH+ZRcNL
 +FdVavhWK0fDzoNhUcq2I4FIE6ebZvbxMZ7n2SdUKvqFQf2MS0ji7IRZoaI868MzN2mlrNmGpBh
 UoQlPbJ/FimdreDTT2lXp1PTZsF7P7Ht3YwenrMvy8zWW969VOjTv554xGahuhly90hGVIKU+CC
 R33xrQ2WzJqW6BbBYcA==
X-Proofpoint-ORIG-GUID: ICKPdNTKlEdscOpeOVNgxjJbHMgrb33i
X-Proofpoint-GUID: Si-Z5Z9mkqEgNksK3q47qN2wjUZehhGu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-12_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603120095

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
v1->v2
  - For "selftests/mm: ensure destination is hugetlb-backed in hugepage-mremap":
    update FLAGS definition to MAP_HUGETLB | MAP_SHARED | MAP_POPULATE and
    used it for mmap() calls as suggested during review.

v1: https://lore.kernel.org/all/cover.1773134177.git.sayalip@linux.ibm.com/
---

Sayali Patil (13):
  selftests/mm: restore default nr_hugepages value during cleanup in
    charge_reserved_hugetlb.sh
  selftests/mm: fix hugetlb pathname construction in
    charge_reserved_hugetlb.sh
  selftests/mm: fix hugetlb pathname construction in
    hugetlb_reparenting_test.sh
  selftest/mm: fix cgroup task placement and tolerance in
    hugetlb_reparenting_test.sh
  selftests/mm: size tmpfs according to PMD page size in
    split_huge_page_test
  selftest/mm: adjust hugepage-mremap test size for large huge pages
  selftest/mm: register existing mapping with userfaultfd in
    hugepage-mremap
  selftests/mm: ensure destination is hugetlb-backed in hugepage-mremap
  selftests/mm: skip uffd-wp-mremap if UFFD write-protect is unsupported
  selftests/mm: skip uffd-stress test when nr_pages_per_cpu is zero
  selftests/mm: fix double increment in linked list cleanup in
    compaction_test
  selftests/mm: move hwpoison setup into run_test() and silence modprobe
    output for memory-failure category
  selftests/cgroup: extend test_hugetlb_memcg.c to support all huge page
    sizes

 .../selftests/cgroup/test_hugetlb_memcg.c     | 66 ++++++++++++++-----
 .../selftests/mm/charge_reserved_hugetlb.sh   | 44 +++++++++----
 tools/testing/selftests/mm/compaction_test.c  |  3 -
 tools/testing/selftests/mm/hugepage-mremap.c  | 32 +++------
 .../selftests/mm/hugetlb_reparenting_test.sh  | 31 +++++----
 tools/testing/selftests/mm/run_vmtests.sh     | 59 +++++++++++------
 .../selftests/mm/split_huge_page_test.c       |  5 +-
 tools/testing/selftests/mm/uffd-stress.c      |  6 +-
 tools/testing/selftests/mm/uffd-wp-mremap.c   | 13 ++++
 .../testing/selftests/mm/write_to_hugetlbfs.c |  5 +-
 10 files changed, 171 insertions(+), 93 deletions(-)

-- 
2.52.0


