Return-Path: <linuxppc-dev+bounces-23767-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF9F9C44501
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2026 06:59:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gw8984kCSz2xll;
	Wed, 08 Jul 2026 16:59:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783493980;
	cv=none; b=VkaDP38FVL0xBtCF7L45Ld2543UCh18adtut1JMh4lPGgVnlYkAUvWV2lPccJljEfOdp9b1dSChSVDXLSr7ho3hS/OqRcBn0QTAEEJNPkA8zSnsN3sdeoGrrx3O8J026aOsndJ1g5l+wLeeYpBzmFDOM4BSKiWMgY0sqi2FcQHLZwQZDgB2XJYBnkCJU1mzlxSbGPRlc6E6A2pl7+CpJwMENOYbli+4AZHioB74Q+AyaoB8xxNEhJwZA2fLdhcaEFx9/CX9CINdtFd6iqbqO0XRq7nKxHCSb2GEWjNJA8SJzXTyLRIc4MxXWHdihZT9ar7X2W8qdfxXzx6AU4StqGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783493980; c=relaxed/relaxed;
	bh=SsVDbaxlApNyEIKakZ6DuVBmV/2sKJEYi6us2+0Q1qU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RK0no6unPhpNvk/aZixM7bFKQubDdOtwyrTz5cFStk7Gc+6j8XflYLbgdUwcOh2/FIpgzL5zeZ5hAkFa/OxC3cOOy0RO5PRFFyT/9QafZYAYfvvQ/rPNXaGb9MZgu7ThVIR183s2pcDsaAySiK7oULR+KFQCgN0XC/bBU9Y8PPFDxxAI+Iiir4rCiKrX9jDZ1xnZn3GoflYCy2TaBIiTDjKG3GXFtOd0QNpNq9tnao4RPGH43+QuEZg8SK40LYn8UTweqVY9tzSpaeI9l21pvaGFmXcOwxpAWB0HWaDIHYwYuzN7Dtqki0tm1Xa1QwWcFwxe2zT62WP/jUb+sYMyaw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Sl8pgYrq; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Sl8pgYrq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gw8975xmlz2xKh
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 16:59:39 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 667MmWLp920747;
	Wed, 8 Jul 2026 06:59:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=SsVDbaxlApNyEIKakZ6DuVBmV/2sKJEYi6us2+0Q1
	qU=; b=Sl8pgYrq3ADYRyRG/uHsdHepp/kPvPycL7mPA/XfWTxwWXnR22PFigT2e
	VIR1SvLENVDRf70fA96yUn4yJMBzEmzOsvMTMegpQLPRxE5pDpz2KiiGFnNf6RXU
	bIivEwWcT6/XUT6jWwlvFoHavrtvPzkOeVs+JZIcnlbif8wPoW+1FQ2TApyYv5+G
	LcXyIE8WOFGWiUjO1d8s70qnqV6xA4jiajiSuFyVi4HQD3WG2WhP5SzrhR1043ZP
	bv2q6UJqCULw4gv+1Tha8qxowsOMtuNc9/m5ohV1QXpCFs6969GPq0QFZ4JHhVVB
	SADW2oSoWMh+NqYuPlPIZDtleStPg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sp3u5er-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2026 06:59:19 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6686nZBZ009362;
	Wed, 8 Jul 2026 06:59:18 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7f6y63sd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2026 06:59:18 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6686xE3x51380730
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Jul 2026 06:59:14 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 494222004D;
	Wed,  8 Jul 2026 06:59:14 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 95CA920043;
	Wed,  8 Jul 2026 06:59:10 +0000 (GMT)
Received: from li-3f69264c-2ce6-11b2-a85c-c3f414d24014.bl1-in.ibm.com (unknown [9.123.3.209])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  8 Jul 2026 06:59:10 +0000 (GMT)
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
Subject: [PATCH v3 0/3] selftests/mm: avoid false failures in hugetlb and KSM tests
Date: Wed,  8 Jul 2026 12:29:04 +0530
Message-ID: <cover.1783446924.git.sayalip@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=KsJ9H2WN c=1 sm=1 tr=0 ts=6a4df547 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=dIJUXHJssPmyVruG4BkA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDA2MyBTYWx0ZWRfX0F5MFB5eM4kc
 tMesEeflz+3BAkmpi5TapmtE5v5ZFOBWiA9i2aA6WoBOoC+ElulcGgZ+INfKnjd35aiGySeinhv
 kXqSkJTdmb5c0xpCqFm2Wyn3pz8RcyI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDA2MyBTYWx0ZWRfX2rY/0FQRL3NV
 mS3kzUg8IGKV9Pj9FStS27+H5/62OUpzN0QrNuAwWh2OdvBjQcnneAPRuAZY6F26PA+aFhv9hWq
 dR3T7NIJB9DQgNKY2ig4WRjx3j1iIY+XJ91bTJ4iY6+RH7he33qlhI/yb/LSKlijO3MaNlTBohj
 UQsqgOM4w6ZYq0O2vOugaGxXdcmHNA4oiVCy/lpi98hkrw13w/lLPE1jLx6nPoCMtw0RuRBGkEE
 Gg9/FvpAWibOijWwDIwPRRHDW1JVtYNaV+nGOPaUJOipB+5B0rPEVYaB9A3SkQipwO5846RGtC9
 sqYHMaWBxXwF5B2mowl6P1T1KqV6ea71M8iSYhpXnOMZgoJx11sHtXY5k1NYjobn52pYQHziv7j
 sRtkf2n37OhwaxboShjFoyGO2kYCFF+7ZNS6SENM1skpBKvx8tOY1MBPjo17dxaqnqAzWa0M9ND
 Z9xOcDhckWgFQGdSWlg==
X-Proofpoint-ORIG-GUID: PSuWbsLmgZVv-t8ijao20URokJlRqGvk
X-Proofpoint-GUID: VW-XIngojpvDJ0MK-njfKsLTYVG7YB7r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_06,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080063

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

V2 -> V3:
- For "selftests/mm: handle EINVAL when configuring gigantic hugepages":
  Reworked the implementation to use internal helper functions with an 
  ignore_einval flag, as suggested by David Hildenbrand.
  Added __write_file() and __write_num() helpers to optionally ignore
  -EINVAL from sysfs writes.
  Added write_num_ignore_einval() wrapper for callers that need to tolerate
  unsupported hugepage configurations.

V2: https://lore.kernel.org/all/cover.1782811071.git.sayalip@linux.ibm.com/

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

 .../testing/selftests/mm/hugepage_settings.c  |  2 +-
 tools/testing/selftests/mm/ksm_tests.c        | 28 ++++++++++---------
 tools/testing/selftests/mm/vm_util.c          | 26 ++++++++++++++---
 tools/testing/selftests/mm/vm_util.h          |  1 +
 4 files changed, 39 insertions(+), 18 deletions(-)

-- 
2.52.0


