Return-Path: <linuxppc-dev+bounces-23177-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23F55C43327
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jun 2026 09:33:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqHxy21fcz2xPL;
	Tue, 30 Jun 2026 19:33:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782811990;
	cv=none; b=QBQ6FquUAJwpz3kgP/GNW9IMhuatuHeCHNbGKbJolIoqYO0XM/yzjyCnU6JchU+YIgFYFvPcQYfdr1zH0hBEG8gjjlNo0hLraxrsEr4QDBEZi5vh4Vpm+MT1s8YN5kEVgLEHbkoAoUOeCTujoHdMf15WCt9icOotrXWXDZCdmf6+BUwsi1ZsVEIVp9LdUypwY01WpdpekqcqbIZ8OTX7EwHqFqWQOJE2bK24CuSmlUdFUfh4H8XGOXFfEv5hBSkBx4+/b1LPw0gRVTaHd2sQKFKzia9OeEYK0q88J88vnm9GmJtprg8+xy3A2ymIk473VnQvKwzHKbeDyjOmNRrDNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782811990; c=relaxed/relaxed;
	bh=D8Xum+/XKl8zuM90nMa1ZrI3HjGlq/7zbVgI4GO/dys=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eTwnx7jBmji35fluzxwci1Ujwr9mnu2mw+H+VxI5SBzAQ733f9ycCdSuOymSnGJtcq+DzLyNlnU++mYpoJ2xpIYcKNTXCMUSjIqjE6cIXuFs76tko777o0ixiiOmuxbuYq4WhGmUKgN3D2Ei/HiQBlow++GFTCRXcglbt7OnfKAW1OAjIZI+vkel8poCIO5o96LGqLWexoJIHk4VPuHVH5h09A0AFnRgCLMpoDLMItB/BRybDDRXMpwOYku0GI5cTRWeIHCLJ4YmTmzQALZ3C4btvKlrDvsoDuEu+vPkXZomamqgRZx2WfSQ7jWHhBQbFDGulJmm8QF8kE1LsVPSvg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=lfXw4+sK; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=lfXw4+sK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqHxw4jtcz2xF8
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jun 2026 19:33:07 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U5mD451137062;
	Tue, 30 Jun 2026 09:32:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=D8Xum+/XKl8zuM90nMa1ZrI3HjGlq/7zbVgI4GO/d
	ys=; b=lfXw4+sKDRkVo+yZf75uJXb6Yx6FSRAoMkVzN+fSqX5sSjqD1dqcYpxzb
	FH82lEG6x3wfot5KAhHvVIlaTTCBFlqk4LuLzG5EjK2kJ7kBBm4MZEawlXYpAcnd
	Lc3lQ86eqfViEDL81KlepwRp5LIN9gUS9xf0i1s80Qtd6Z3kE1fT99QdsxFuifvP
	cqWHq0icMrGIhKn0Z7mgqAE9HmcMxot6zTWQW1vX58OrsZljFG0E5EvZb1FFa0p1
	7DP3/JXy1OB48AIIFSbllHmVikeBvYAi2qNXEZr8Eu3BdQE/QL8UNDPgAyoReYMv
	ySeOw/B9yha9KAQDe738DAnhW5Lng==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26n5nxmc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 09:32:52 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65U9Jg64008817;
	Tue, 30 Jun 2026 09:32:51 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2ruq9nsu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 09:32:51 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65U9Wm4E59703592
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jun 2026 09:32:48 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 29F5D20043;
	Tue, 30 Jun 2026 09:32:48 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EAE4920040;
	Tue, 30 Jun 2026 09:32:43 +0000 (GMT)
Received: from li-3f69264c-2ce6-11b2-a85c-c3f414d24014.ibm.com.com (unknown [9.39.22.200])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Jun 2026 09:32:43 +0000 (GMT)
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
Subject: [PATCH v2 0/3] selftests/mm: avoid false failures in hugetlb and KSM tests
Date: Tue, 30 Jun 2026 15:02:32 +0530
Message-ID: <cover.1782811071.git.sayalip@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDA4MyBTYWx0ZWRfXy+goAH0TvE1k
 dfbVd+MWgW4+3teakz3eH/cFcTfeDvfr339/fZD0qX4NglDCWZKNFd50QHSkjJPbVA4mKIGKiQh
 SL7hnOnqoc8c16NT1araFZMDufPWiQ09sF+1xmXL8wyqfPaJaN4WU8sneXJJmKi2go4y6CbyUpk
 OAxfDAIocMBzGvNT7LbqXT2w1o4jjoKB+9OQn7kCkiA5EAg6FguedYBjv7upZ78lzVp02AJBQYb
 pa8zZByKgf2R5tc4WcaOnPYrmHTGXgn8AoltbnVPSO4m68uDMy3JnLFBp8CIaAyA2xpanQiSkcd
 B8fkiSshTwwl7k3CKCEN7hGT1cEVyGrotdTrPUVCS+thCWliUpPfgzFpd6VN4G5C37DZjdaiocM
 vZkYaIjpWH31IZ0o1MFauXWc1Cy4JyHfgmqwWl6AeacOVZACAtbwnSEh7dCpMz4SIkkUzX3dwwW
 dhaCYaXTTCzAWRMHMAA==
X-Authority-Analysis: v=2.4 cv=V45NF+ni c=1 sm=1 tr=0 ts=6a438d45 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=_V4-DM0ed6H3iwi1ae8A:9
X-Proofpoint-ORIG-GUID: sWru1B2hQQYViISMjebu6H-eIuuJ2fJd
X-Proofpoint-GUID: ggRZ1wWx35-VpUVVZk4dSDPgik26JuYV
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDA4MyBTYWx0ZWRfXzVAooNWIk4RR
 15AfbStBvgsQaDxH97Z1TZ0BXl7i4mUJTyzDu5OGb7tXHyHNExLTeIO+17rwTTRu40wTNPsYy6L
 Ewiw+hr6ijfQOYzwGuTI26aXttKkv9w=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300083

Hi all,

This series fixes issues in the hugetlb and KSM MM selftest categories
that can report failures when the prerequisites for the tests are not
satisfied.

Patch 1 updates the hugetlb selftest helpers to handle -EINVAL when
attempting to configure gigantic HugeTLB pages via nr_hugepages. 
PowerPC hash MMU pSeries systems expose gigantic hugepage sizes 
but do not allow runtime allocation of such pages,
causing the sysfs write to fail. Handle this case gracefully and
continue running the test instead of aborting.

Patch 2 fixes the KSM NUMA merge test on systems with memoryless NUMA
nodes. The test currently relies on the number of configured NUMA nodes
and may attempt allocations on nodes that have no memory, resulting in
spurious failures. Use the existing helpers to identify
NUMA nodes that contain memory and skip the test when fewer than two
such nodes are available.

Patch 3 fixes a pre-existing operator precedence issue in ksm_tests,
where a ternary expression combined with logical OR operators could be
evaluated differently than intended. Added parentheses to ensure the
correct evaluation order.

These changes improve handling of unsupported test configurations and
unmet test prerequisites, avoiding spurious failures.

Thanks,
Sayali
---

V1 -> V2:
- For "selftests/mm: handle EINVAL when configuring gigantic hugepages":
  Added a dedicated hugetlb_write_num() helper to handle the expected EINVAL
  returned by gigantic hugepage configuration, in the 
  hugepage setup code rather than modifying the generic write_file() helper.
- For "selftests/mm: fix ksm NUMA merge test for systems with memoryless NUMA nodes":
  Updated implementation as per David's review comment to build upon 
  existing helpers get_next_mem_node().
- Added new patch "selftests/mm: fix ternary operator precedence in ksm_tests"
  to address a pre-existing issue identified during Sahiko's review.

V1: https://lore.kernel.org/all/cover.1782365671.git.sayalip@linux.ibm.com/

---

Sayali Patil (3):
  selftests/mm: handle EINVAL when configuring gigantic hugepages
  selftests/mm: fix ksm NUMA merge test for systems with memoryless NUMA
    nodes
  selftests/mm: fix ternary operator precedence in ksm_tests

 .../testing/selftests/mm/hugepage_settings.c  | 32 ++++++++++++++++++-
 .../testing/selftests/mm/hugepage_settings.h  |  1 +
 tools/testing/selftests/mm/ksm_tests.c        | 28 ++++++++--------
 3 files changed, 47 insertions(+), 14 deletions(-)

-- 
2.52.0


