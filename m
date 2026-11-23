Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81619606A32D
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Nov 2026 12:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=BUwZHsMM
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jY5Mb4lbwz2xyj;
	Mon, 23 Nov 2026 23:48:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795438091;
	cv=none; b=d0XaLvuUDaWRwOFd6gpzJcQO5M1pYavm4RmHcaCwFVgYQmMac3y/anCCEPAaEd/yLqHf2m29bdMV+Cr/xOkmyvylk3fPlL75L4QdDvjZhZaDO1lfQByO2+3Xwgheo4inwdNVyPvL9oNfVW8LtYZqgFDRZy/EzjJbAAOCGJRpvYNvhFBN+8WBjYKxXAM4CXkM9Ca+xZGO87NwFnbPTlPVqwX4hpjquHMFd4NnVTfGFNBdjmSnH1YN4hBeEkDDbRLLw9qHr8wlYe2v4kLWXufv4O0g+X39RvwozNGO4JboiTq/AlKFdRJpqsoZ8NMgnZEVmlmnVpIdqTYGFK5hTBiP/A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795438091; c=relaxed/relaxed;
	bh=d/Z0vUg/xEbWIM0w4egf1KXaQZ+WOY8AjsMj/fZc1b0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=al0uCs9B/Sv/VgG7T8xqbhxVIICsQPjpsq008wcFnZk7IETqT3fETqab0KF7xhXHjlt1RLQBdcfvDdliNOYN8kgXn6Rh9QozPjYr6WHWB+yJoni6XfuxXAlSXS9Wm7+bY7oa+IHi5NjYkZVFqqrt5pv8g+3QNwqg6K+EuGJ5WLtAE5D4QYF/4afsWEJdKashtzVwEO41skDav9gBPOmW/ZVUsASRCeHrHNN7Cxw5XPwRLM50Fw/WosTPHNrRmHmaOmzLKl311bfeNJFZTwqZFCZJqmypzMZJGB428HOMoxZ2eyVoCmiU4SQIzHamqfwoeehv9UZqKsCrw7ogQmpZuw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=BUwZHsMM; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=BUwZHsMM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jY5MZ3C83z2xdb
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2026 23:48:09 +1100 (AEDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANCZB2X1981967;
	Mon, 23 Nov 2026 12:47:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=d/Z0vUg/xEbWIM0w4egf1KXaQZ+WOY8AjsMj/fZc1
	b0=; b=BUwZHsMMEs49L/zwmB12uvhbfzlOw7GR/6xdhzOYPEQphOy5blUjBKL4S
	QWhORBl2BXfCuBoblrRcJuPsfTKVYUzC7oOh1Q8pueAoeesEaswpJ41nl6x8vELK
	ud7Yw3HYxdgj2Rd5VQtCstCnrcA0xa9JCKnQ1eqbjaEKNSnlnbglfBe5Bifvtvy5
	AaXbv21i6O6RaNpcCpjRtqvRv+76SpRBUkTPzGvnFF95jz3R2aTN1MPOz64ShhDK
	zUKZdc35vVQMYFhMqMF7ikuEluXCjBsEOYGgBWT+jNiQd3vZ8N54j4qUNqsIqixz
	pfMYg2Tv5IWB0q9duQ/bRdV3isqwQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34g336nu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 12:47:46 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANCJeQb1159456;
	Mon, 23 Nov 2026 12:47:45 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j3p0vex9n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 12:47:45 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ANClfuG51380670
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Nov 2026 12:47:41 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 606CE2004E;
	Mon, 23 Nov 2026 12:47:40 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5810D20040;
	Mon, 23 Nov 2026 12:47:35 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.39.24.192])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Nov 2026 12:47:35 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, peterz@infradead.org,
        tim.c.chen@linux.intel.com
Cc: sshegde@linux.ibm.com, christophe.leroy@csgroup.eu,
        linux-kernel@vger.kernel.org, ritesh.list@gmail.com,
        kprateek.nayak@amd.com, yu.c.chen@intel.com, vineethr@linux.ibm.com,
        vincent.guittot@linaro.org, srikar@linux.ibm.com, npiggin@gmail.com,
        mpe@ellerman.id.au
Subject: [PATCH v3 0/4] powerpc/topology: Introduce llc_override kernel parameter
Date: Mon, 23 Nov 2026 18:17:26 +0530
Message-ID: <20261123124730.1466978-1-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=SoQFe/O0 c=1 sm=1 tr=0 ts=6b0435f3 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=dBynatHyQikd6B6G4x0A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA1MCBTYWx0ZWRfXxMLLHAugSTZP
 GlttXXSOvd4EeTpFHnTzDEENZUoj6IoNctfj0moCOjSYGVenps/mY1cwoMcB+S+sfyEDnV3HHhd
 3MxmgJa3LUBBD5UuUgTIpayT4VIOYI4=
X-Proofpoint-ORIG-GUID: PwNgRZtd7mRzn3KWQasn2k6X2BBOy3rN
X-Proofpoint-GUID: 1atbfizsNdZfmjtDsIBaCNZF_Zlc4sOH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA1MCBTYWx0ZWRfX1k4Bf+sTuA/d
 Gj1dEyj5UYg8LAU9WAxMvogYipU/KQLpxfw7KqHvaUWFbHKtQBOY5faWPQPcIaJnubHZtKnhLI0
 GHw3YhC3zsstuioEdQXujCOSSUp9DCjnk1oywwuUKB7JInOt4ZRe5ZwZ0f3Edk4Ujr8uo9JVG6/
 n8FxbGZyWtSbu1OmVNQQw9DdXpWJg6AkDdRQ2kAx3HVNAD4C8SrUprua+e3HvgZ9dnHLj+ExfF6
 3Lz11LjQwcrRfKho0mBHjFz9TdB2ApYXH2haywV8xvQjwYmx6NS6M8JXsBFFF8ZeVZVzpD4mvqe
 o8brmjLZAEZMc2kaL5Zif8DVLmPYm8HYPJyrhL206yqqX63xu141YqF/ldztG382n9kmKIvjF0K
 iRyxtWCGrtugw+q0KJ/Ya7+9XEJKZ0DaywSzV2JlpSXghiu0+Tz5D1wz16P8/bolcLgvH1hr6Pu
 8Vxmh8D8t3zSlquWw1Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_02,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230050
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Depends on generic cacheinfo series[1] to be applied,
[1]: https://lore.kernel.org/all/20261118163639.890546-1-sshegde@linux.ibm.com/
That patch is under discussion and likely need some changes specially
for DLPAR related stuff. Meanwhile, sending this updated series out.

Provide an option for users to enable cache aware scheduling on powerpc
via a command line parameter.

Verified that cache aware scheduling is taking effecting by observing that
llc_balance happens and mm_sched_llc is pointing to the right llc id after
running threads and size checks succeed.

More details of the problem and context is in cover-letter of v1.
v1: https://lore.kernel.org/all/20261012102037.2477378-1-sshegde@linux.ibm.com/
v2: https://lore.kernel.org/all/20261023131646.2907938-1-sshegde@linux.ibm.com/

v2->v3:
- Move to generic cacheinfo so that get_effective_llc_bytes populates
  the right value. Thanks to Chen Yu, Tim Chen for pointing out that
  llc_bytes was 0.
- Make llc_override __ro_after_init and remove READ/WRITE_ONCE
  (Chen Yu, Tim Chen)
- Merge patches around domain flags and arch_llc_mask (Tim Chen)
- Ensure parameter is of nop on shared processor LPAR (New patch)

v1->v2:
- Move to kernel parameters from debugfs. This helps to keep
  llc_id consistent which doesn't change across sched domain
  rebuilds. (Tim Chen)
- Update arch_llc_mask to reflect the override (Tim Chen)
- Limit only to mc, pkg (Srikar Dronamraju)

PS: Selftests related to Cache aware Scheduling will be taken up
subsequently, as that is more complicated.

Shrikanth Hegde (4):
  powerpc/topology: Introduce llc_override kernel parameter
  powerpc/topology: Update flags and llc_mask based on llc_override
  Documentation/powerpc: Add details about llc_override
  powerpc: Skip llc_override on SPLPAR

 .../admin-guide/kernel-parameters.txt         | 15 ++++
 arch/powerpc/include/asm/topology.h           |  8 +-
 arch/powerpc/kernel/smp.c                     | 74 +++++++++++++++++--
 3 files changed, 86 insertions(+), 11 deletions(-)

-- 
2.52.0


