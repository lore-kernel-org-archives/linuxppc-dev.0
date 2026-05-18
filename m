Return-Path: <linuxppc-dev+bounces-21065-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE1CACD4F50
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 May 2026 06:56:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJpVv2dH0z3c1Q;
	Mon, 18 May 2026 16:56:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779087383;
	cv=none; b=HrJ/l3dFIww17vtzbryctygbpKygM3oHB+rU3TtFXOo2Iy9/oNFquUzl5YXZxaADHVFuVM5wH0wEz8pCg0ogtV32fuBXgs2dr7umoVbSrN3If3gBv8tzJeU1KfxDvi6CCkP69yGEdwXVHlivb/96U1Dd90GxfLivKH4Sdco8ZJaTlIbLA2xu4whYUOLNeQTTEjZTw+rIuq37bAV8D32qQDJYOr5a/L5MTVxzMZjyYqdBmIEODYoxilTahymLeggqzBweNKT1hCYSQiu7s8yuEcvPeR64MdeXrMN1rHntaSf5mW8DKPaij33Xazm2uJinfAcccEnqnlNn3i9XcXSdUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779087383; c=relaxed/relaxed;
	bh=onqOyhZb2dqALa/PK26QtSPJP3ASH1XwwYA0yviasds=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nf8wJiogBpN+hhIb6TTlWtjxFhR3hv2l4jwHhCV3SVmFmK0yvvvw81CwTpQj8QoLNzqFms01rzTsd4a1pEBHiU6PFbgSG+fAzL5Rit/Kza7gGs8hgmMCvTnaG1tkwFFwtfZScjBvAFU6sq33OK4Re3SjUu2cS+IuCWi/JwA7ZJzYtbmilMQlgq218iL5Y5Jw57dePc/V327Vhh73349qxFZK/UYNFQQW6IFwuNmZXeUY76y6b4i/exR1cqvx54NxxHpi5VgBueVkhyPr7wWdfeo5+gnEmFU/OX9Uq/fhT1k/WAiuyFe5OgLVoq3mKxwflbwnYylhpgH6ZLUEVxKSXw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=llWNcmEL; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=llWNcmEL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJpVs4FvGz3br5
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2026 16:56:21 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64HKsOaU621007;
	Mon, 18 May 2026 06:56:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=onqOyhZb2dqALa/PK26QtSPJP3ASH1XwwYA0yvias
	ds=; b=llWNcmELpB5zBcidWEsgKKTIv1kghrhfuQvVjwU3iCQdcu1JbYlxgaDlv
	/0aNW5+Gb0x6JmHdL9A3KG9X2C1J4K0/LXNbbznypdn7shZ47/l5FaGcbS96xsJs
	msgkjBo16ej5Z/wUHw30hIvGm6dNc4kHUir4Uz5EqUtdfeTIoyzQS+Iz7Mo4AL3K
	oLEp+jdbCSn1nyWRJ49iWRUvL4wTDdA7pMTcADQ3sDaFFq1ZP4onGKUxUg71NED0
	i7DI+ONg2fSDIXl0dh++T6pLdwvg1USrOEzc4PvRfwKA+u7v0dEA59FcTgt/uC3k
	z6n68ds2OMGjyheBX1ubTU5WnBv6w==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h74pnx4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 06:56:18 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64I6sDD6021052;
	Mon, 18 May 2026 06:56:17 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e754g4dyw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 06:56:17 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64I6uDHG45089232
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 May 2026 06:56:14 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D92832004E;
	Mon, 18 May 2026 06:56:13 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 959ED2004F;
	Mon, 18 May 2026 06:56:12 +0000 (GMT)
Received: from li-3f69264c-2ce6-11b2-a85c-c3f414d24014.bl1-in.ibm.com (unknown [9.123.3.209])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 18 May 2026 06:56:12 +0000 (GMT)
From: Sayali Patil <sayalip@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com
Cc: linux-kernel@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>
Subject: [PATCH v2 0/2] LKDTM powerpc enhancements - Part2
Date: Mon, 18 May 2026 12:26:03 +0530
Message-ID: <cover.1778975974.git.sayalip@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=ffCdDUQF c=1 sm=1 tr=0 ts=6a0ab813 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=MKFrxBcpSIOW1YpQlXUA:9
X-Proofpoint-ORIG-GUID: i_3zAT675-O8HNPkAH35XiLLTNdJMxJg
X-Proofpoint-GUID: DDPcPMOlm1KQxuKzktCEr30StVgYwlHZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDA2MiBTYWx0ZWRfX4ftI1OVd25Fb
 E27LSVgskFimzahsH56c+eGqNX8kM5G9Um5jYHAUIrPEPlQBbM7nkEc+8Arpleui/XDbPUV+kB7
 omOLaGeDjZAMVrMmWfzJt74xtiVPhTe3ZKe1vli7brI8vnAuZPpHdh/oTSpLNt1jQa0o2wb5/JX
 LYHscOpy0j9OMdBTHdUutX2HPXYjnvVFFaWwbxlIblMPrpzAsTp8KrPHLc6xaRLGlBaAT0IC1rM
 +fqbOsvxacIH52Z5p57bQyQpmNTK6Chn259UbblzMx6kqKbNtPV+FjuOcBpkRbS1G4CO5qHZaTH
 to33tFR2BKgf/1qCX3JGxocUIFPcD7cmELMNV4h/knzihd9VZRw1IBsbrzu3Ybc8wdlY76WKPQZ
 JSxSyQwE0KiMpt0lNP6G7nQRSv5roX8/lfXtr8w8JpHhYCTdqE6spKBjqIsQ4eGHZGWLTNyq3+p
 mQQTfr6X4WhLyvJc2aA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_01,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180062

Hi all,

This series adds a new LKDTM trigger PPC_RADIX_TLBIEL, to validate
machine check handling on radix MMU systems and improves reliability of
the PPC_SLB_MULTIHIT test by adding isync instructions after slbmte
operations.

Please review the patches and provide any feedback or suggestions
for improvement.

Thanks,
Sayali

---

v1->v2
 - Split the patch series into two parts.
 - Updated "lkdtm/powerpc: add PPC_RADIX_TLBIEL test for radix MCE
   validation" as per review comments:
   Wrapped Hash-MMU specific functions with #ifdef CONFIG_PPC_64S_HASH_MMU.
   Guarded powerpc_crashtypes registration with #ifdef CONFIG_PPC_BOOK3S_64
   Updated comment explaining the MCE trigger condition for radix MMU.

v1: https://lore.kernel.org/all/cover.1778057685.git.sayalip@linux.ibm.com/
---

Sayali Patil (2):
  lkdtm/powerpc: add isync after slbmte to enforce SLB update ordering
  lkdtm/powerpc: add PPC_RADIX_TLBIEL test for radix MCE validation

 drivers/misc/lkdtm/Makefile             |  2 +-
 drivers/misc/lkdtm/core.c               |  2 +-
 drivers/misc/lkdtm/powerpc.c            | 49 +++++++++++++++++++++++++
 tools/testing/selftests/lkdtm/tests.txt |  1 +
 4 files changed, 52 insertions(+), 2 deletions(-)

-- 
2.52.0


