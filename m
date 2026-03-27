Return-Path: <linuxppc-dev+bounces-18902-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA00910BA432
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Mar 2026 07:17:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhsRL2Ms3z3bd0;
	Fri, 27 Mar 2026 18:17:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774595854;
	cv=none; b=VAuyE546F8fy6wiRstE4Oyp86wB58aSwGY9e4W4+L/hw8sgai0edRAOEUnBsNgT83RP4bvxwaw2EbsVCUAUn/pn+2UsToDjvLERuOqslqzNyImWlFcxdz0ZX5EaKxkKFiLATKTCI8XlaGHbA4KVJA29VAOusDNeOG74d4DS5EkA5p37EHVYnNyK4c5nkHST9Ho4sRNqSD4Dc7WEWhEiKs5JYUYS2HYfQQojqjBuEa4PNZBgX1iaV5kfSjsfwDU7yVYBT7axfBE+EHWIQGpb/o4wqgd1NnUVeOiyrFVaMEF1YfbWgx0LvJNVyTdxmbKzvW2wGCS/SeRWRN4din+XvWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774595854; c=relaxed/relaxed;
	bh=qX2aWPBs2Uk6pGE5wyoOhNupuU+Rbe2RXQHAKSeaRCY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f+CggoBPFr6owUWcSnIEJhtLwFp0qvFGHKW8ZCLBb9hCuCDRGi4nfaxd7rk8fuxfRdqdpoKbWvo1hcDAEBx4q+1xRpsWHhbm+pe0Ih44NumYAKc7KltFXgMLiQQtue1WAZscU7HggIF4/4/7v/PmmuQ4Bb8a9dJVpVL9FhuykUt8lKrwAr2ZwPUd0YyVDB4rF3M2UmFTZUi7UIjHo9QZLn02UFZI1HQEQdtvXKkpIoSJmD7XgC0FGFMmFeY6he1bMB2hxD1fvY9B9IHozoqh7fcN3Jdv5XiIlujoNOSr4XQGAJ4vwW0bgszZ8/OvbtEt2m/Y6MWzso9JnW9omkAHyA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=HO3jS68e; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=HO3jS68e;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhsRK1Lzzz309P
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Mar 2026 18:17:32 +1100 (AEDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62R3mNcS768705;
	Fri, 27 Mar 2026 07:17:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=qX2aWPBs2Uk6pGE5wyoOhNupuU+Rbe2RXQHAKSeaR
	CY=; b=HO3jS68eIUOzX2ESFw4MoKnKhee6iOLtsuixoYu7JrgsOeWb4Ur7gL6F+
	VANEWJ02BF/9P6Z2g10HQyrpf2+E4ddU3QAEs7HBAxotoCV1TOuqfQoQoCJvJ9ta
	y3NNJMzxJ1GdLSaybKBm2+yuzBGUiC29vL70UfDNeMurA2YS/utesENdruTF2HKP
	H2lJIzjEE2jWlImZtFgbXYbOwB9GtVE4vBCyyETvHo3iC6nvGM8S3RHzdeH4y0MF
	SLL2zC4cQCqhQmO5tADHydKH9BuC/1hU/pQ9CzfnrgNmiaKd+RRD7ZjOG3ma8eqS
	vmTR9A8cT27TWu+wtwHQVp/u3ZSUQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kxqs17h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Mar 2026 07:17:17 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62R6NHBG008732;
	Fri, 27 Mar 2026 07:17:16 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d26nnxgnt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Mar 2026 07:17:16 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62R7HEhe46137610
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Mar 2026 07:17:14 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8B7112004E;
	Fri, 27 Mar 2026 07:17:14 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 04A5620043;
	Fri, 27 Mar 2026 07:17:11 +0000 (GMT)
Received: from li-3f69264c-2ce6-11b2-a85c-c3f414d24014.ibm.com.com (unknown [9.124.208.5])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Mar 2026 07:17:10 +0000 (GMT)
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
Subject: [PATCH v3 00/13] selftests/mm: fix failures and robustness improvements
Date: Fri, 27 Mar 2026 12:45:54 +0530
Message-ID: <cover.1774591179.git.sayalip@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: bTG2_VkCQGmT433W2bPMIOzx_4gkdGVL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDA0OSBTYWx0ZWRfX22Wd5wAjRkfh
 52EBF1DLYZnsXdmn4tKgwNY57eHTiah8Fukg1+amifZJsMDAEU1zwsINmynIrJvVOKJAOqPhkqW
 qHrZRIQ3n9k4Xrhrnt3hfAKYJhddJ/5lR5ORfnXzzoCmhWQQv4pJ0eq1BbtO7XMEQB0aGKRUiJr
 pS3ik2mK3rUsRV6hGO4BIC+q5IQjA7LKGsh8oaHh1nCnfSqQ6gOLKED82fPDsq9BVUuABlqYgTD
 0S+awKBZmjcnuejWCAI1rLYVpMTXIpJogYvwkAEvjYp93NgqpjBTlydyBJXn4tknUa8sla0l7EI
 yd0ZqLxSB3tYKzRDwi1YQM//LGkR6YcDle0k0w1silMtdbM/626cgIp295+MlntKF8uQ0Fe4Nyd
 XeKNbMHB6yH5sinyHd+fRB79jvQni6Ni84d2JquFMXoS0Nl8ZHHei0gbXDFCTu4cX0hlD2gbxHn
 ikiYQHdv4sGSwitDpsg==
X-Authority-Analysis: v=2.4 cv=bLEb4f+Z c=1 sm=1 tr=0 ts=69c62efe cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=ibztMZabhZb7YLjfUOMA:9
X-Proofpoint-GUID: AhEwzDl57hOrQJRz74vzJkQQkwuK9cJn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_04,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603270049

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
v2->v3
  - selftests/mm: skip uffd-wp-mremap if UFFD write-protect is unsupported:
    Rename function to check_uffd_wp_feature_supported() as suggested
    in review.
  - selftest/mm: fix cgroup task placement and drop memory.current checks
    in hugetlb_reparenting_test.sh:
    Drop memory.current validation from the hugetlb reparenting test.
    Keep tolerance at 7MB (reverting earlier increase to 8MB in v1).

v2: https://lore.kernel.org/all/cover.1773305677.git.sayalip@linux.ibm.com/

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
  selftest/mm: fix cgroup task placement and drop memory.current checks
    in hugetlb_reparenting_test.sh
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
 .../selftests/mm/hugetlb_reparenting_test.sh  | 56 ++++++++--------
 tools/testing/selftests/mm/run_vmtests.sh     | 59 +++++++++++------
 .../selftests/mm/split_huge_page_test.c       |  5 +-
 tools/testing/selftests/mm/uffd-stress.c      |  6 +-
 tools/testing/selftests/mm/uffd-wp-mremap.c   | 13 ++++
 .../testing/selftests/mm/write_to_hugetlbfs.c |  5 +-
 10 files changed, 181 insertions(+), 108 deletions(-)

-- 
2.52.0


