Return-Path: <linuxppc-dev+bounces-27842-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40003C982E1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Sep 2026 09:16:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hpHdz6l79z30VX;
	Mon, 21 Sep 2026 19:16:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789982167;
	cv=none; b=gWaCOZrL9gf3X+mh6YHb6LS8aQcWlaH88yhL0v/cxRSsaY+NZ+Vn4LbP5u+bXNEks/5JA54JNXp3vhxRbUWHETve+xtfGdtGfLpTBNFUrUp/Y9adz4YGErPsQZT4q62ko7ZtpnzpTaux3pFlP/KBXsSKYxyaJDAc81K/Ba8k/twIppb7zLMHRrgovL1b7nNzuLHOvYaUHNH7johFahlBCFSSItOKuAWyoeXgjdAICFKxEWENOYD4u6SOrBpvSnb9Ebk+fkns0tIVq8yufykNlnjonOQNgZjQrR3iOjZjDFGTIMmWqNcz8y7Pub/0G5qWdW1wrtbZv7IfuepAPPyCGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789982167; c=relaxed/relaxed;
	bh=stUr8pN49GsSi5dmVSoPptxR0f8R6WFZP/LSTKq8Ln8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BL9AbfB2xRcYki8gKjLi5DujUbp6SbJqJzJ4hZ2qvYCefNhTkwFGJyxxV/Tb0dgdpCsZ3875WqRejVuvMbed9ygKhQrA6znE5zo8yuSMmeP6AwD+VnPMGkQVF85Kkb1u+HvCbVYMQB1zi/MCiO+q+TArTFHZ+A1IFlh/ezWmgASjxF4ZdnF1LXCg04tIMEjSrhEGQDp/YYcvAkKRE1Gb0JOt8wkQqSGKeGtgc+wqfWzKTb9CrSJQo8HU1Hc+DRuLkTxZh4FdEU0UOwuwzXjfE933REzPqi8Q5HZFuO0/KKyQ6ZTwwCPZoPR12EZgY/0xijPdv2vjaVcuRuhdsWvd6w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=q7oshqOK; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=q7oshqOK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hpHdz1LcFz2yhD
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2026 19:16:07 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68L7ZMY4829735;
	Mon, 21 Sep 2026 09:02:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=stUr8pN49GsSi5dmVSoPptxR0f8R6WFZP/LSTKq8L
	n8=; b=q7oshqOKInvYOZD65JizZNv/zSI1PRB7qNQMEUcGyeQq2gswP8Vghsa4n
	0AxRo2tvXYmCUPqvjy6ntUjLgJM0Lzg/DyfocRV7pBNmPtQDjwloGQNy89enT0O+
	oSs9dZNgMBkWaOUXnBNNmDCL4K+fkhLA7Lcf/YGMO1JszBc9hWlwDUsWizABgbcx
	g8ASxDoXqMEzeTy6kG9smYyj01LfhaPaxqhSNyc5qCSen27fdB1bmBKwRfXbhKOB
	l/hOrLwelKY5VBePVBHpEbR0suEKg9JWe8XLmwkoSM1UtRIQWvUpkDdnkwVvUsXi
	zIq6W+RmGGDI8bYgZesrGn3Y8C9aQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgrymyu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 09:02:04 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68L7HwSA844286;
	Mon, 21 Sep 2026 09:02:03 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt5qjmhw0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 09:02:03 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68L91x7O42074412
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Sep 2026 09:01:59 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2BBAB20043;
	Mon, 21 Sep 2026 09:01:59 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 38CE820040;
	Mon, 21 Sep 2026 09:01:57 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.124.208.199])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 21 Sep 2026 09:01:56 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Cc: sshegde@linux.ibm.com, christophe.leroy@csgroup.eu,
        linux-kernel@vger.kernel.org, ritesh.list@gmail.com, tglx@kernel.org
Subject: [PATCH v3 0/3] powerpc/irq: Use optimizations for /proc/interrupts
Date: Mon, 21 Sep 2026 14:31:50 +0530
Message-ID: <20260921090153.54745-1-sshegde@linux.ibm.com>
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=V/XoQuni c=1 sm=1 tr=0 ts=6ab0f28c cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=ZHew1V-Ef7zmNSL-XegA:9
X-Proofpoint-ORIG-GUID: SxJrAGq2YLQfcSGYBPcnXW8Ivbir3mD5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDEyMyBTYWx0ZWRfX+SF25W7uY21B
 mvyi93n1KFOOWZNeF/2MIN2VfKNzmND6Qw8Z6vpVmSwwHXOLuzWVM48nyKygu5+Ad8+2yz1+9bY
 +Tikk0J38f7TcSrhl4IWf2HMd+AEZ+a+2kN2Oea5NF15HSDvohlptjHg7KTo+gz8ROxdw7/RR7P
 0xbwTjWTNafd15eusAMqpuIH8Jaiqm9qTC/smvUwiu1g/y4MO6wtLJ0PIVnkZgV1gOYGh77R38N
 28pw78HWvxDN5FHSr2nAcRGWqnyp6Ls5mHayyLFW60SmVBjV6knDEjrbOnopiJG6KJSdaBK0JHC
 lpH7LzmANG25L4FfAF9XUyDo8C/qFWG9WME7re+SSbcgpdFeH3TLsOw4MEXVkncDADubNDAmfhF
 oYpyD/yYC5FnStlt7yzWyxDvOn/5G8mYPJUGoapgipOlaG8bNcyq4QJ3iyAj2V18avcfK08djsr
 Uq7JaSqQF1VqWnBSl2g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDEyMyBTYWx0ZWRfX1ihAq+LSXB1P
 Tk4b243gVCrp3c03A7OW9WTHa8rJ08In8nmtGsSRh3/LHdtJf5ye/20Ihf1TFl2yT28eR8EGR5h
 BjKUoPUPdQZ++hkOFZU4XEnYcozMfzQ=
X-Proofpoint-GUID: hnA4rGDUllBfnQqi-SXIqWIE4-HTdu4v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210123

v2->v3:
- Respin based on 7.3-rc1

v1-> v2:
- Collected the tags (Thanks to Christophe Leroy)
- Rename skip to optional and check optional while printing
  (Christophe Leroy)
- Decided not to add cpu_has_feature(CPU_FTR_DBELL) while printing.
  This feature is mostly true for majority of platforms and adding check
  means more ifdefs in that path. Prinitng "Doorbell interrupts" shouldn't
  cause any issue when feature if off since all entries would be zero.
  (sashiko)

This series is based on work by Thomas Gleixner[1].
Further details can be found in cover-letter of v1.

Base: tip/sched/core at 'e81ee0630837 ("sched/fair: Reset NUMA fault locality after scan period update")'

[1]: https://lore.kernel.org/all/20260517194421.705253664@kernel.org/
[2]: https://lore.kernel.org/all/87jysxw65f.ffs@tglx/
v1: https://lore.kernel.org/all/20260523174016.999456-1-sshegde@linux.ibm.com/
v2: https://lore.kernel.org/all/20260529124045.1208539-1-sshegde@linux.ibm.com/#r

Shrikanth Hegde (3):
  powerpc/irq: Move __softirq_pending out of irq_stat
  powerpc/irq: Make irqstats array based
  powerpc/irq: Suppress unlikely interrupt stats by default

 arch/powerpc/include/asm/hardirq.h |  31 ++++---
 arch/powerpc/kernel/dbell.c        |   2 +-
 arch/powerpc/kernel/irq.c          | 131 +++++++++++++++--------------
 arch/powerpc/kernel/time.c         |   6 +-
 arch/powerpc/kernel/traps.c        |  11 +--
 arch/powerpc/kernel/watchdog.c     |   2 +-
 6 files changed, 95 insertions(+), 88 deletions(-)

-- 
2.52.0


