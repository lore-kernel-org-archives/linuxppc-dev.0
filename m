Return-Path: <linuxppc-dev+bounces-26060-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8455C5DF81
	for <linuxppc-dev@archiver.kernel.org>; Mon, 24 Aug 2026 08:12:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hT3YQ6Hk5z2y2c;
	Mon, 24 Aug 2026 18:12:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787559146;
	cv=none; b=Egq+ra+09jfN8np6jkruYZNtJ3cGppl/ROT/oAza8c/akZ08fdxo17nSGeIbc/Pl+mpVUmKJRFAaZoZlnNezcg8NpP89LMAT7dMhavUBltipQRmfuPAtNzhZ7IgfrZWmxxfjABDXNTnXIFwUPnHzPjXdE/0d0j38dseC57Wsp8kyrCG4AydkPZL7/f6/dFhENwXhhz8xvQ+3egFosFlz+wEKdvp9SmuEDcHWqse/FRBmDtqRrMada13+tOgUbzmAeMe47DGHDwS7toFhyrr8yesqX6TCEhFeInt77l1HeAlq8cIOiyORVvzdLhkkGrNSGAs5ArKfP0sgkC3X503pUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787559146; c=relaxed/relaxed;
	bh=IpWgB2KgZcYND5XoA0aUFnKH18wuRF3r/kUL80/QL5s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nvJP2CNxM/koZxlwP5/uBpvgVEtPehOvDeACBdjpEicmp8mH0TGFskLAOuf7f6CybMD3C/7wCuWNhmuV/0IqYYeIJCAc2rO8qwNZBNri+3I3EDE9tjqn3LlgzfJ/eXCRENL3n5o4MxZ5mbKqsH0GfIZnoC7P+icpebH0H6UaEnlIl1YxaFqGtZ8uaFoXUn65ndOQbLP7pPT4MWZTwUm9nF/z9PI0ndZG48CS2sHaBNtE6r+SHjLupIDRGWxQKB5jrnb9GXjE4xxdLOtuWCrgDQUKGIxuSR35QJQ+NDoY3JXqiKvcWg/nm1OacHdGYkUF5so++7v9CxiSDA6Z3vTa6Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DeWtX5Ed; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DeWtX5Ed;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hT3YP35Xmz2xnQ
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Aug 2026 18:12:24 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67O5Vc4a1014072;
	Mon, 24 Aug 2026 08:12:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=IpWgB2KgZcYND5XoA0aUFnKH18wuRF3r/kUL80/QL
	5s=; b=DeWtX5EdWCsWULejw37PWDN0JWbUnyJ1asireNvxV1IXbSB6m0/GJ5K1T
	MWr9rpvItyLz4kxc60++9jhwygBJGgatgKi4/h2d302IBsT1zgvQ44yduT6LsgZJ
	+6R+2hwakJjC2P5AEYTpr19Zi1/zdfBMQVoWoSzkz5v8OOb7wyXChD4nhj6bRcsh
	fKnTl6B9g2jzsPYeB3YJY+fvJogmGb5H927/kehYXRkizzxJqOGjR1i8oUeMrq6h
	tadYy1GsazrGVXhO4fXVtioqT/hgN79In2dIz5EOyVEGod0FfL1daZxXEUrXXxtI
	12pHeXn+ccAFNcVxHLTCG/43TQ51Q==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73dwyugy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 08:12:07 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67O8BMUg032705;
	Mon, 24 Aug 2026 08:12:06 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7qkgvp2w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 08:12:06 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67O8C21544040578
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Aug 2026 08:12:02 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8FE3920043;
	Mon, 24 Aug 2026 08:12:02 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D365F2004D;
	Mon, 24 Aug 2026 08:11:59 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.bl1-in.ibm.com (unknown [9.123.14.142])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Aug 2026 08:11:59 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
        ritesh.list@gmail.com
Cc: npiggin@gmail.com, chleroy@kernel.org, shivangu@linux.ibm.com,
        hbathini@linux.ibm.com, mahesh@linux.ibm.com, adityag@linux.ibm.com,
        venkat88@linux.ibm.com, Sourabh Jain <sourabhjain@linux.ibm.com>
Subject: [PATCH v3 0/4] powerpc/kdump: Support high crashkernel reservation
Date: Mon, 24 Aug 2026 13:41:58 +0530
Message-ID: <20260824081202.264913-1-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA3MCBTYWx0ZWRfX2t6VNYtuSZLz
 l5zd+WWpQjW0lgJzQToun1wXx0UDAqYMMyZKRJ4hlElM7am7HgT1wej34XefXLHkYcYwJIhulZA
 IBw6mkJC7ZBsP+FZblP+2sl0yGUuOPM=
X-Authority-Analysis: v=2.4 cv=AYuB2XXG c=1 sm=1 tr=0 ts=6a8bfcd7 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=jzlt8AeeEYGqjmcDYdcA:9
X-Proofpoint-ORIG-GUID: MqdLxUMoYOOqZvhYGjjjD5mjBEoTm8kJ
X-Proofpoint-GUID: 3Zk8zT-jJa7huiyS4rpmeEAa7u2UQ2_h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA3MCBTYWx0ZWRfXzqLxmZP4ldvp
 9AVGs8rzaty7RlSVJvF5D8C1uixkmGAxSgAsWzjtADFAo1bNUTgApO+gJ0Tajp6qKzBdKKgBTXG
 KaNtgFIYBdalGBugefQgGcxBiFLUXrYlsHFKPFAx1MS6saJy/OFkIkvGm82Jkc2mFTsAiVCZBNR
 pCESmQ2FWrwyy/Rj7K2+hgtrW6DZgOQZQoJYvuH4f1bygN26Zsp/PrbNS6qJnTf4rZn3VWm/yqb
 CKulIMoRXKt3AsbzwrK7G4HkuTxWedRPDHhzwrQLc9VHeRpEfD7iYYukE/WZdIs/BUM1/vJJr1h
 ekNmsBJ+dzgcMvNVGW0cRPuOvjLhSJjaxYyTvMmurTEXNRkNRgLyN5KzTVWO4rfslNjKmF0E1uu
 HMKt4VAprxoPDQ2u3VQvJ2gYRAhInXy/w2teCCwDeM1DYt3Ol3H8TGgEiiXQk/OH2zf/6f7yDiN
 /ApInZlHAp49JHwd6EQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_02,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608240070

Add support for reserving crashkernel memory in higher address ranges
using the crashkernel=xxM,high command-line option.

With this feature, most of the crashkernel memory for kdump is reserved
in high memory regions, while only a small portion (64 MB) is reserved
in low memory for RTAS usage. This helps free up low memory for other
components that require allocations in that region.

For example, if crashkernel=2G,high is specified, the kernel reserves
2 GB of crashkernel memory near the end of system RAM and an additional
64 MB of low memory (below 1 GB) for RTAS to function properly.

Currently, this feature is supported only on PPC64 systems with:
64-bit RTAS support
Radix MMU enabled

HASH MMU is currently not supported because kexec segments are loaded
into higher memory by default when using high crashkernel reservation,
and HASH MMU does not support booting kernels loaded at higher memory
addresses.

To support this feature:

- CPU feature discovery is moved before crashkernel reservation so the
  MMU type is known before selecting crashkernel regions. (Patch 01/04)
- RTAS argument handling, allowing RTAS to correctly return to kernel
  addresses above 4 GB. (Patch 02/04)

This patch series leverages the new firmware capability property
("ibm,rtas-64-capable") to enable 64-bit RTAS support and significantly
changes RTAS call handling. Feedback is requested, particularly on the
overall approach and implementation of the 64-bit RTAS support.

- The approach used for enabling 64-bit RTAS support
- The handling and conversion of RTAS arguments for 64-bit RTAS calls
- The RTAS call flow and MSR handling in 64-bit mode

The new DT property "ibm,rtas-64-capable" is currently not described in
PAPR.

v1:
https://lore.kernel.org/all/20251027151338.819957-1-sourabhjain@linux.ibm.com/

v2:
https://lore.kernel.org/all/20260708143357.673251-1-sourabhjain@linux.ibm.com/
- Detect 64-bit RTAS capability using "ibm,rtas-64-capable" instead of
  relying on instantiate-rtas-64 failure handling
- Add proper 64-bit RTAS argument structure conversion and return value
  handling
- Add dedicated 64-bit RTAS entry path
- Read the actual "linux,rtas-64" DT property value instead of checking
  only property presence
- Simplify rtas_64 initialization and tracking

v3:
- Fix minor format issues 1/4
- Handle the kexec where prom_init() is not called 2/4
- Single API to find high crash kernel support 4/4

Sourabh Jain (4):
  powerpc/mmu: do MMU type discovery before crashkernel reservation
  powerpc: move to 64-bit RTAS
  powerpc/kdump: consider high crashkernel memory if enabled
  powerpc/kdump: add support for high crashkernel reservation

 arch/powerpc/include/asm/book3s/64/mmu.h |  1 +
 arch/powerpc/include/asm/crash_reserve.h |  6 +++
 arch/powerpc/include/asm/kexec.h         |  1 +
 arch/powerpc/include/asm/mmu.h           |  1 +
 arch/powerpc/include/asm/rtas-types.h    |  8 ++++
 arch/powerpc/include/asm/rtas.h          | 10 +++++
 arch/powerpc/kernel/prom.c               | 29 +++++++-------
 arch/powerpc/kernel/prom_init.c          | 20 ++++++++--
 arch/powerpc/kernel/rtas.c               | 48 ++++++++++++++++++++++--
 arch/powerpc/kernel/rtas_entry.S         | 17 ++++++++-
 arch/powerpc/kexec/core.c                | 48 ++++++++++++++++++------
 arch/powerpc/kexec/elf_64.c              | 10 +++--
 arch/powerpc/kexec/file_load_64.c        |  5 ++-
 arch/powerpc/kexec/ranges.c              | 24 ++++++++++--
 arch/powerpc/mm/init_64.c                | 26 ++++++++-----
 15 files changed, 204 insertions(+), 50 deletions(-)

-- 
2.55.0


