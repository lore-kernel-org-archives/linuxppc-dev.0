Return-Path: <linuxppc-dev+bounces-18210-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C33B9EFCBB6
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Mar 2026 06:26:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZ4py25Klz2xln;
	Mon, 16 Mar 2026 17:26:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773642362;
	cv=none; b=Hcjol1L3iagkOaPksrcqKDNag3hMhIKRpvZWvQYB4EFdyt7j8W8sBJLkhXwp0W6JTA3DQSHK1UPEd+zNuJpKWlaSah8G5SpfYG+Vyv1MUenciO/e0bKurl2TBRYTK78mL7D92nuZ3T7wqiHty2KJ7D0L1Bd99thcaSuB+eWCAyQ0/Knd7dhcP7xTlknj1jPoizeT/fVJhWWlv/UfoSOvNX8YUFBDJbjfSuhGe95WwfexOOB3noGPN1sLxcsUQSXIgAcyg6j3ZbYBfJV0AOincIlM0xTxTKIcruMeltNryupKcMAia/+kbQrMPPoZWHME0vLv6xvrqSuyA0yZM7Dg8g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773642362; c=relaxed/relaxed;
	bh=+0G12t/SBVmeHJF6+zz3RSoBkQHd8n9pIPa06IqoyQc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GioCzePVnGO38S5tz+18PzMai6CHz1EFP1ptzFb4y3GJOQh1XeObF/Btk0rzlLa7BasqalBmhe9RLvxHUAPQrYEnua0RmVPB3zaQJU7QWAKa0EGuwwLj752wVuQ4KvHB9cqkPSg4gO+2dYe9NHjyxNRnaeLFMROY1vjNe/gaeo/97wMuKfcHuPbp5yPVYeJsYePiLEYf2pctGgRtWXOX0yOrvoKlr1rSijZ4gyXOJhr+CY1tbt+rjfZIgTwmu08HaE/0bcQvI1bGaorhUvJMOk5XSWwQnNPQ+DNxX7BV3LOEaCc96BnNlgl4gNB79OAextyVDSPEDEkNFlCio/hQaw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=J2BNWJWu; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sv@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=J2BNWJWu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sv@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZ4px2nZDz2xlP
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Mar 2026 17:26:00 +1100 (AEDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62FLO2gB805941;
	Mon, 16 Mar 2026 06:25:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=+0G12t/SBVmeHJF6+zz3RSoBkQHd8n9pIPa06Iqoy
	Qc=; b=J2BNWJWu4bF+3tek/S8PW6a5qwQYLjeWqeFBHFpLLJwzp3AX1/ZDaIrRr
	g+sZhyH38kI+2oFb4xnuC4B0ugQKaFMSe/Z/5XpbdiCIVus00yirrbjki9y0ojdT
	Pe/i+GUMoNBgL7iS22GKDeUdGDz74u/ldIOx+kzQKFKOvmnwrfkOiOIHZD89s9oi
	yUkR7J2axhEUYtkgzQyZoL9+pkNABSbb83RNz6kctx+AdJj7ZRKEewe1+tVhSUYg
	MID+tUyCYM+HyD4e/GgACH+VLRDjFQjSw1xnnTQs9JlIcdDcP9UgxFSXtzT+NYDg
	f8FHHbVgDOL/nWz7I2uJiudO0sdTg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvw3hpdk2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 06:25:38 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62G4P3Hi004575;
	Mon, 16 Mar 2026 06:25:37 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwj0s3tfq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 06:25:37 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62G6PXGO30343896
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 06:25:34 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D02662004B;
	Mon, 16 Mar 2026 06:25:33 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EA26E20049;
	Mon, 16 Mar 2026 06:25:29 +0000 (GMT)
Received: from li-2fa77bcc-2701-11b2-a85c-cd621c23b6bd.bl1-in.ibm.com (unknown [9.123.13.4])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Mar 2026 06:25:29 +0000 (GMT)
From: Sathvika Vasireddy <sv@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: nathan@kernel.org, masahiroy@kernel.org, kees@kernel.org,
        naveen@kernel.org, jpoimboe@kernel.org, peterz@infradead.org,
        npiggin@gmail.com, maddy@linux.ibm.com, segher@kernel.crashing.org,
        christophe.leroy@csgroup.eu, mingo@kernel.org, mpe@ellerman.id.au,
        sv@linux.ibm.com, nsc@kernel.org
Subject: [RFC PATCH v4 0/6] objtool: Fixup alternate feature relative addresses
Date: Mon, 16 Mar 2026 11:52:31 +0530
Message-ID: <20260316062237.30948-1-sv@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
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
X-Proofpoint-GUID: nYEJmDpLY7HyH9eAZN9vUpMeD8kg7JyA
X-Proofpoint-ORIG-GUID: jDfODcr_XMnMU7nqBxJ61fZD6tbyC3lA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDA0NSBTYWx0ZWRfXwu/RuX7imXF3
 gAY9kdaV+dIJAhJ3K4s8mLLCPvBAroLN7R4neftSHdntKG5dJ9SQDgn7x8r6XVRT0izkhrUGHsq
 8bCRCqw5c0czm89NOIhaeIPcgdSvl3AhXHnnzp3EBwL4PePYTbiezhmlmSK8vOkrC3/O2pR/vGh
 +CWuWw598wy1lER+ik/VtaxeDuZlMrJRd/KZnVkgOKQLLQyIawXVque9oF0GTWemupLFLLTnYzQ
 bAGeCDyrY8DPFdmtQkndahhKiaAhRPv8kL7e6F6+sj6Xhdh6rLFRkzWnm6lyBiIeeGr+qPMYPbS
 w3dg7j/0/MlTbUrSKD2euUpPHaRJWGpTfR0yXbgG/LCaBUVjpJLJhlbAMsFIe6K+bhbgy55/sJo
 OSODXxrQ2pZEZL9X+8SgP70qoW03P8/LnsJBttLRiKsmC3u3/5lufb92gsw/gjueG1l6CgDLCdi
 1mZMnK6Ap//2OM1Pt5g==
X-Authority-Analysis: v=2.4 cv=Hf8ZjyE8 c=1 sm=1 tr=0 ts=69b7a262 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=voM4FWlXAAAA:8 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=1UX6Do5GAAAA:8 a=cBShpBCZYLthc8V9hoIA:9
 a=IC2XNlieTeVoXbcui8wp:22 a=Et2XPkok5AAZYJIKzHr1:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_02,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160045

This patch series implements build-time fixup of alternate feature
relative addresses for powerpc.

Previously, Nicholas Piggin proposed a build-time solution using a
custom PowerPC tool [1], which provided the foundation for this approach.
The current implementation leverages objtool's existing ELF parsing
infrastructure to do the same.

This patchset applies atop powerpc/merge branch.

Links and History:
[1] Original PowerPC tool approach:
    http://patchwork.ozlabs.org/project/linuxppc-dev/patch/20170521010130.13552-1-npiggin@gmail.com/
[2] Initial RFC v1:
    https://lore.kernel.org/linuxppc-dev/20240422092206.147078-1-sv@linux.ibm.com/T/#t
[3] PowerPC instruction decoder borrowed from:
    https://lore.kernel.org/linuxppc-dev/bfa8364da047d8610a09458a1cd924a0566aedbb.1736955567.git.christophe.leroy@csgroup.eu/#Z31tools:objtool:arch:powerpc:decode.c

Testing:
Build and Boot tested on ppc64le, ppc64be, and ppc32be configs.

Changes in V4:
- consolidate emit-relocs remove-section logic for
  CONFIG_ARCH_VMLINUX_NEEDS_RELOCS and CONFIG_HAVE_OBJTOOL_FTR_FIXUP
  configs as suggested by Nathan Chancellor.

Changes in V3:
- Split code into individual patches
- Put objtool call into cmd_link_vmlinux
- Move HAVE_OBJTOOL_FEATURE_FIXUP from arch/Kconfig to 
  arch/powerpc/Kconfig 

Changes in V2:
- Added implementation support for ppc64 LE, BE, ppc32 BE.

Sathvika Vasireddy (6):
  objtool/powerpc: Add build-time fixup of alternate feature branch
    targets
  objtool: Set ELF_F_LAYOUT flag to preserve vmlinux segment layout
  objtool: Fix "can't find starting instruction" warnings on vmlinux
  objtool/powerpc: Skip jump destination analysis and unnanotated
    intra-function call warnings for --ftr-fixup
  kbuild: Add objtool integration for PowerPC feature fixups
  powerpc: Enable build-time feature fixup processing by default

Sathvika Vasireddy (6):
  objtool/powerpc: Add build-time fixup of alternate feature branch
    targets
  objtool: Set ELF_F_LAYOUT flag to preserve vmlinux segment layout
  objtool: Fix "can't find starting instruction" warnings on vmlinux
  objtool/powerpc: Skip jump destination analysis and unnanotated
    intra-function call warnings for --ftr-fixup
  kbuild: Add objtool integration for PowerPC feature fixups
  powerpc: Enable build-time feature fixup processing by default

 Makefile                                  |   7 +
 arch/powerpc/Kconfig                      |   3 +
 arch/powerpc/Makefile                     |   5 +
 arch/powerpc/include/asm/feature-fixups.h |   2 +-
 arch/powerpc/kernel/vmlinux.lds.S         |   8 +-
 arch/powerpc/lib/feature-fixups.c         |  12 -
 scripts/Makefile.lib                      |   4 +-
 scripts/Makefile.vmlinux                  |  11 +-
 tools/objtool/arch/powerpc/decode.c       |  15 +-
 tools/objtool/arch/powerpc/special.c      | 437 ++++++++++++++++++++++
 tools/objtool/builtin-check.c             |   2 +
 tools/objtool/check.c                     |  42 ++-
 tools/objtool/elf.c                       |   4 +
 tools/objtool/include/objtool/builtin.h   |   1 +
 tools/objtool/include/objtool/special.h   |  56 +++
 tools/objtool/special.c                   |  29 ++
 16 files changed, 612 insertions(+), 26 deletions(-)

-- 
2.43.0


