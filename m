Return-Path: <linuxppc-dev+bounces-20140-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D96ECFF8850
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Apr 2026 04:47:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g3rf81qNJz2yGX;
	Mon, 27 Apr 2026 14:47:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777265264;
	cv=none; b=mOYbSHQi5LBTt7xsoT7+n88ldVl2XIULd8w6Qyp5/tQf+c9sUXAE22bg8o2YF4t9IjLvgveFooTqQabPzDdGw+gCFNlWZVakRWP/X1V4UMQQGWhnLlnFviBqoQ3Ep/UvpA+OinZ5zQ2rImrkJw38hvQ5ASevBnbIDKzaWxJwxYVlg7F5RnFmkmxJrm0HSrIteQ3qdcyTApTcBCqLjBNM4jPHYMchcNlGB2iSH0GnQmWTg1hvAoW3LnwyOlYmVr8aLKb4uLvrHgV4YCItUWkLeT+TCp5YrHYZr1i7i9lz5VbQ3DnZTaWxkJaIggTIoFuwlhjXLWBH4o4VgZJiSOayEw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777265264; c=relaxed/relaxed;
	bh=ztxgKuiH2FH9hJWybffBdEiG48+XqIii1xNCcQtd86Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WDHVd6uLkl/TdxEVslaxf59woNu5iF0P+YscyMhFPMFC/CXrur1gr3i83mXdiI82LvPP5Y/o3V01UzGe3TjBWBtYYok3zVz1Kv5V2PoV9TuwnKVxfG0arN5euFxX0abmonSzHLQmGWV3zjrFrExNj7tJfvpYlzC8wjJk1xsVOk2wFRY+AptzApi9EyK+IGYW8ElyMUhXAu9OF0DvO7lEBfdIR/vyJHQ0Fb+BaEkUBdTjdOrME+9DMKiyYQN3BeecYA/j7ztaBJ5ZkZlLV/nGC3pHff2LrmJjJP2yrBVQPZxSJby1DMj80Szs0LYibqfqomBhXG38K2StaJy5RGC1Aw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=YPv3Mprf; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=YPv3Mprf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g3rf573bTz2xlm
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2026 14:47:41 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63QNUGax3241446;
	Mon, 27 Apr 2026 04:47:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=ztxgKuiH2FH9hJWybffBdEiG48+XqIii1xNCcQtd8
	6Y=; b=YPv3MprfROdglEPlQOzwzS+vikLSAPfDdY1WET+gRhKzWQc7zaqUE+v11
	3f4ALjIvDXvkUK1C08ZDz6WoGVxi5sNNydXSnXQIP7eV3E+xNZAvSil/pknHnasi
	Zj6gOXPKA9qgJRqxdr9t/WkpnF8iehZt4GWoy2/ZHPLhb/7m4mfvtVItTK5CbyF1
	IUmdVKfu3wv7uxAJP27gN8ZZNad2hESxWPBqq+bjYQ+n9nM1Hf5JUKwf/Vv3iRvs
	LMce6owX1jLZGmiufw9kVj1xDpuZPDmsBXl5ifNy/gabJIztFX7pQy/q+oxEg2vI
	U1upQ/DDhhQcMAKRUxYRqlDf5JlMg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn44eqyj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Apr 2026 04:47:37 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63R4cgbg028399;
	Mon, 27 Apr 2026 04:47:36 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ds8xjupep-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Apr 2026 04:47:36 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63R4lWwi33685830
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Apr 2026 04:47:32 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 346FE20043;
	Mon, 27 Apr 2026 04:47:32 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8C2FC20040;
	Mon, 27 Apr 2026 04:47:30 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com (unknown [9.123.5.233])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Apr 2026 04:47:30 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, yury.norov@gmail.com,
        linux@rasmusvillemoes.dk, linux-kernel@vger.kernel.org
Cc: sshegde@linux.ibm.com, chleroy@kernel.org
Subject: [PATCH v2 0/4] powerpc: A few misc cpumask changes
Date: Mon, 27 Apr 2026 10:17:11 +0530
Message-ID: <20260427044715.559137-1-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
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
X-Proofpoint-ORIG-GUID: SmNpPUv2_AW7Xm7owQTI4Ed8x1sHt-Kb
X-Authority-Analysis: v=2.4 cv=Ft81OWrq c=1 sm=1 tr=0 ts=69eeea69 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=Ikd4Dj_1AAAA:8
 a=N3WTiZj0RGK2lvMjpU4A:9
X-Proofpoint-GUID: _Q6zQkDiUU735vOFKOWp4g2O-hfUv0JZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDA0MiBTYWx0ZWRfX8npLWAyXSfmE
 l7HSUXQN+qYiFbFA+gvHIQqa7edx1AOIjbkCKXafkIqiRFAi4y6/pdNZQ14lvQUpbhZIQam9nfW
 g2Su7tkAIpTLXcJvWimrstjHOsuNKi1C+L4qCXPNZdu5W852bsaGd3XsawekiTVF505EVbQDNee
 1nEGiXiNKvuKByxiohOL2IFxuzYuU1eGwYJzA2kHzaFG4JZpe+oKzv+PGrBwDIWEIxQyGzvya+y
 fUvDi8VeVW14ygUeQeTALif4txf00/IYEoRvpb1fC7q3idiqqvkCo+LiTrPju0TlbMIvMbVbpVx
 hOIkcQsWXooblTxrQZgCODu1mrFVWGS1ym4+dmZwpZNnFQvmsfHaMkgK27hB1Zr6RP466/+LkDJ
 jJRzgIPTsfI02qjMa4QurfMboKpR1Ka7/YCyMTYTdKhv7GuncaGog/xUNTOp7xtnBhc3KiN2IP0
 sUv80tkM80io4gOs4Sw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270042

These are some miscellaneous code refactors around using cpumask
APIs. They are mainly aimed at code simplification.

Changes since v1:
- Dropped the changes done in xive_find_target_in_mask. Those changes are
  done by Yury Norov already.
- Collected the tags. Thanks to Yury Norov. 
- Added new patch to use cpumask_intersects instead of using
  temp_mask to achieve the same goal.
- Added new patch to print the warning when target CPU not found
  as discussed in [2]. This patch is kept separate since this adds
  a new warning in case of failure. So one may perceive it as functional
  change.

v1[1]: https://lore.kernel.org/all/20260327063129.127302-1-sshegde@linux.ibm.com/
[2]:   https://lore.kernel.org/all/20260319033647.881246-1-ynorov@nvidia.com/

Based on tip/master at: (dffc5753ba4c "Merge branch into tip/master: 'timers/clocksource'")

Shrikanth Hegde (4):
  powerpc: Use cpumask_next_wrap instead
  powerpc: Simplify cpumask api usage for cpuinfo display
  powerpc/perf: Use cpumask_intersects api for checking disable path
  powerpc/xive: Add warning if target CPU not found

 arch/powerpc/kernel/irq.c             | 5 +----
 arch/powerpc/kernel/setup-common.c    | 7 ++-----
 arch/powerpc/mm/book3s64/hash_utils.c | 4 +---
 arch/powerpc/perf/imc-pmu.c           | 6 ++----
 arch/powerpc/sysdev/xive/common.c     | 1 +
 5 files changed, 7 insertions(+), 16 deletions(-)

-- 
2.47.3


