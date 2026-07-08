Return-Path: <linuxppc-dev+bounces-23823-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C635C43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2026 14:34:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwLFk0Jp1z2xpn;
	Thu, 09 Jul 2026 00:34:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783521257;
	cv=none; b=NJMcINxrvIf2Z/w0/djXCkw4GzJbC+9IQ4MoKyacXbDjMYfVUdf1MxmprxP0D4/R0pMyo60pkRCIVEeHTlrbVwEl8P9FQgLtf51ofpMNfyJC9yfsU9u3kz19M+8dClhebuPI8lIPBPqDuyhr02xhQCTVC4TEChb7igyXQYvBaQlcmaAhCCW5C/OETe+ItIkESTHE6Up6X4X09S/NVLM/A7BMqLVAEJ7XrNH3i2hIKFBZDGtv0uOMlTQs7qX0pI64IWExaJHIK+AOUb5kp+Wk2X6hR3JWN7bX/Rc0s24NzrwO+YYeEfGvCfodr0YXPGxd32YjwI6fDVYMtEFWlgg3Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783521257; c=relaxed/relaxed;
	bh=OG35xiU8oDKZ++YQo/FcKSoqtCG7NgxNxaaD0e+Tgwc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g1yS7KG7Gq/P9Qb5B9NJtCCz3krfjovBjczE5boeTAn7B/skQjmIE7il5Sw/xsZEVjgKA4IlIz9aOVJ1GVnK3PTWOAZ7hiX8AjmCW5XhgJFCuTQox57zLEIiwLSduf7MmGONk5xwuC2KysLAhbgun2GmW8VWbZW7EmNI1d/kSH7TzpREHAcPf1y0FMZM9uUDoO1Ge7P2ok9GXA7FmVGzOAoLtFzhEKVcjRon/IqJXF8n5MWZSJwlI2Sc8GxABgac7fgZggc1xiVw4w39vTxp+8WyunWkQWblAdk3cmMwfIjDPwzFrKimhThoHeStQ7FfVbi6Xpg4vIHqcjBB/ie68Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=YfPfTvm2; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=YfPfTvm2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwLFj1Jq0z2xll
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 00:34:16 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 668CIRB73748426;
	Wed, 8 Jul 2026 14:34:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=OG35xiU8oDKZ++YQo/FcKSoqtCG7NgxNxaaD0e+Tg
	wc=; b=YfPfTvm2HTHwNQN5d/euiyxNuTDpzqOwzjo5fEHoKfel/V/LzdwxE9X1v
	IECqptNuuf+jpU/1KfjvoDZ57R3UfRZNkNYUa9AsGIUSejdWLgbkf1393dKuFVw6
	M12V2xHgXaDlEOyBS7GmIrSdPKxRKgBQonaX5C+9f0uXyQiI3wgAqrNbGzcWmdrU
	bCAX/pIUCF4GAHX10XiPakExVcsqW2yH+TYg/McisBHipE9HbG45LOc1pVwZrOpM
	tU5e+O4dy981o/kxvDzVT9Kqsx1TUn5sRhbE57D/liXwfaRzm932U7SVAi5iuMuz
	Yk7s6PSCDowUOEO7ftyqw9JAyHSxQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6suqvjrn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2026 14:34:09 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 668EJaKa005969;
	Wed, 8 Jul 2026 14:34:08 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7cvw8kdf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2026 14:34:08 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 668EY45o50397470
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Jul 2026 14:34:04 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 395E820043;
	Wed,  8 Jul 2026 14:34:04 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D5E752004D;
	Wed,  8 Jul 2026 14:34:01 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.bl1-in.ibm.com (unknown [9.123.14.142])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  8 Jul 2026 14:34:01 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au
Cc: npiggin@gmail.com, chleroy@kernel.org, ritesh.list@gmail.com,
        shivangu@linux.ibm.com, hbathini@linux.ibm.com, mahesh@linux.ibm.com,
        adityag@linux.ibm.com, venkat88@linux.ibm.com,
        Sourabh Jain <sourabhjain@linux.ibm.com>
Subject: [PATCH v2 0/4] powerpc/kdump: Support high crashkernel reservation
Date: Wed,  8 Jul 2026 20:03:53 +0530
Message-ID: <20260708143357.673251-1-sourabhjain@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDE0MCBTYWx0ZWRfXzfRIOvVBmiHZ
 t0XG2TMNGQWitkrwt5hdlrlDr9oeYYZmGiYJf4+T9QzIzvg+Ra/BZZvHepJOV7wuqcCcHr9cdJ9
 CPZJ3mRAbc10dpyqwuNAeIUUngtsCGI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDE0MCBTYWx0ZWRfX6Np4HiPnUtb1
 ux/2BGtdO6NQbEdFq9s+McS0pvYH0+Lkur3Wpw5i1LZ5vLwtWWZeLuoTCI4D6fkzxOMeyKL3UbG
 y3tpD/Phy3m3BMrumOKgQlwFfc+/XGZgnalhTmoW3WZAFtF29w+oSlaMBVaxVovDqg0wo1bWo8I
 68kvaX5pii4NagkLpKYxJ1m2sR5uOVeFiyhS86R3p0KvHEsA0R+Q8BzBNDTs8McNUDXyd8YfW2A
 k7773l7fx7Fr8Y1onQ1v/dVggGgBFKKmCKBtgrAX2n6f3rI2YXnoIlbOxil2c5lougTJIJpQXeg
 D7YkoUtOOyeF6FLP2cuONZulWmHRlCqKHA7YR2blp5sLPU4iAg4fyAcWXhCJv+J+1ZaM6UkSbrM
 p9zCyLhS3YuckbvWxjaVvcJ6I6IArUbv6LIy6cdxUy4afbdB2d0YB/zZxcVGFC5EMcbpaFdPv2E
 twuI2pNejv2IQPQ+MCA==
X-Proofpoint-GUID: Zb2FO2ZZyBbuWVHLfPb7buJzb999dOPx
X-Authority-Analysis: v=2.4 cv=Oot/DS/t c=1 sm=1 tr=0 ts=6a4e5fe1 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=i-beMt_H-CDrQD4t-OIA:9
X-Proofpoint-ORIG-GUID: FbMkmd9A6uiY4t2i4lmC6PsIaHgCOOLV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_02,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080140

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

Changes since v1:
https://lore.kernel.org/all/20251027151338.819957-1-sourabhjain@linux.ibm.com/

- Detect 64-bit RTAS capability using "ibm,rtas-64-capable" instead of
  relying on instantiate-rtas-64 failure handling
- Add proper 64-bit RTAS argument structure conversion and return value
  handling
- Add dedicated 64-bit RTAS entry path
- Read the actual "linux,rtas-64" DT property value instead of checking
  only property presence
- Simplify rtas_64 initialization and tracking

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
 arch/powerpc/include/asm/rtas.h          | 11 ++++++
 arch/powerpc/kernel/prom.c               | 28 +++++++-------
 arch/powerpc/kernel/prom_init.c          | 20 ++++++++--
 arch/powerpc/kernel/rtas.c               | 48 ++++++++++++++++++++++--
 arch/powerpc/kernel/rtas_entry.S         | 17 ++++++++-
 arch/powerpc/kexec/core.c                | 45 ++++++++++++++++------
 arch/powerpc/kexec/elf_64.c              | 10 +++--
 arch/powerpc/kexec/file_load_64.c        |  5 ++-
 arch/powerpc/kexec/ranges.c              | 24 ++++++++++--
 arch/powerpc/mm/init_64.c                | 27 ++++++++-----
 15 files changed, 202 insertions(+), 50 deletions(-)

-- 
2.52.0


