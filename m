Return-Path: <linuxppc-dev+bounces-25068-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99441C54FD2
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2026 06:15:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9f8S16j8z2xnp;
	Thu, 30 Jul 2026 16:15:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785392152;
	cv=none; b=GJ3BQWGqsQGXbpqzXN97qocz5zSa5o+GUGq5+m8w9kcwQk8qtiPnjxm/E5oQxm/bz1yV7801wZfebOUUgeimB6e6x8FWIMm4Y99dOx3+J1VQr46ExJE9B5CpkP2pfa0nQFfrRdg8VEdX6RVm+S8udKU7nXPDZUTiBhv60PbZQ6KOhBlMlbBFIZ/arhmC/obAKuHDIF/s/PLOIQ2n0uVLdNmvvh0iu1Rjepqc8Bn49WBcZ/gxLKT9xOhVXN+dE40hIatc1d18OcMQWVwZe7fg1xlJKmjCrBxUo4R3MSM94dKET3lm5CVwlgS2TFQNYA/t//2hFCXfHdHFdSSZY7oX1A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785392152; c=relaxed/relaxed;
	bh=1UWZ5HzLpArpF1NvNWQyxPnxDX63GzUIYSpa+Zo8rV8=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=JjtPJx5xobSlHvy/rOHZKmepATXmkS++JQKP8sqUeZyo6Nw21BGUeKpZ+2pHIAwbDwR3XaP679DFSVB9Qlu1bVVloTDQaNmBseIfK8te8AgPsSLuWtQu0N1YSo5ud57ID5AX3o6VPuNv48S4wQfgfCnxcP53YG+E7Z1oX5UI0PxP/MVhZOI01BvnVCclanASFAw4qNJImg6f3IpQYi+nwde8KbwZbmp9mLp51HjreI8aIAtMXD5tfOzQy6AVexgZHgSc/aXspQXU738gIHDMyAmxjcZhofiXq/8uOel5vtYQY+AoOh5cVXlp4vAWAXs5kgOtjFVcxKi2CYCmTj8CzA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=SXBdV9tj; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=SXBdV9tj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9f8Q41plz2xF8
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 16:15:49 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66U3lYg81933410;
	Thu, 30 Jul 2026 06:15:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=1UWZ5HzLpArpF1NvNWQyxPnxDX63
	GzUIYSpa+Zo8rV8=; b=SXBdV9tjD+r+TJ3njD3e2/MH0Gu5vuRNz3edH84sb8Fa
	4qzCfDvK228/4dRxobaK0wNdTB4R6tDYaIxUChe7LSXdjS9NoeJkdQgP2EnTa8md
	hfaSDI1ciSiqAJa+0O6e4eGsr/JYIzRym49TGzKyxQpJ5NeU1YHMsKYWVynxLDZs
	HOQ9/8fJ5iu3e+5MsQS+QdPWXfXutDaRZkRQJIg6a46vzRjpvz4EzvQ05NrmDR4+
	KT0NGwCeR2Ich7xKvzh4VXbgF9pNxjdDwa8+ANNK6O5LBJXO7JbxLSR6UZ1Bmp/N
	jifN8zaQZ83uQPLNV+RzfY6G5t0R2XikZ9mO2VAURw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0xxb1e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 06:15:32 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66U6BK8a027403;
	Thu, 30 Jul 2026 06:15:31 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn7uwa5ub-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 06:15:31 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66U6FUpr25887234
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jul 2026 06:15:31 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E15FD5805C;
	Thu, 30 Jul 2026 06:15:30 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 391AD58051;
	Thu, 30 Jul 2026 06:15:27 +0000 (GMT)
Received: from [9.43.53.144] (unknown [9.43.53.144])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Jul 2026 06:15:26 +0000 (GMT)
Message-ID: <1db2ecc0-b7c2-4647-87c7-592fa50bbfa3@linux.ibm.com>
Date: Thu, 30 Jul 2026 11:45:25 +0530
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
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, mkchauras@gmail.com, mpe@ellerman.id.au,
        naveen@kernel.org, npiggin@gmail.com, thorsten.blum@linux.dev,
        vaibhav@linux.ibm.com
From: Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-7.2-3 tag
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: LT8vJEaJyTl1GkM0eZCfGtwS-o7eMGz4
X-Proofpoint-ORIG-GUID: OOqgP9nOsglPD8MF5yDBPo__J5v5PfuV
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDAzOCBTYWx0ZWRfX338Teg1jqsZE
 2O4kkqAjqm9jsCgD+9u1xA2eltMcUhB217ml5d24JO/fyWp319HCRMlCYodWp3OcofFGoSEk1s1
 k2dRIOYqnoTitI7W6XKjDzHpgEdzudU=
X-Authority-Analysis: v=2.4 cv=dYuwG3Xe c=1 sm=1 tr=0 ts=6a6aec05 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=laZXK5Ch3hIqo7tLcRgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDAzOCBTYWx0ZWRfX9pPpZwJbmwiP
 4mbX9PjWB6qVHVSTBaw+o7hoqHExz2S5brEMO5/18DwY7spoeH5KY/tGY6LKML1CULbmiCkHs8+
 wpcD5u47+bdtHF6OmAoNe9SefVYZqCKlDT2qB9YT2LdFblMMjcc9VnP3YefrAumw+5yMyv7jNRZ
 jlk6ij8mzSMA+q+67Lm9096aNJcnmoGi4FItf2pdKw11ZgKdNiyhG8p6EkIdftv1mBhtJDDcj04
 tiH2jYzGcxDmKt4xyabltgU+0+CPEQX3VcCESZ4HeMlw5HdXiMmVYTpR2Nb3nsTb9UU0YMRQOw6
 aeqYpQuqgZob+mMUA22JiaZqCfQPEgX1o7FMldogyEhaBvR9cHPcsKeBcw+gL3qLsvODfELyJ7l
 YOVbo/Kn6Vr9SJ9IYT5AKwbURh+tk6MToXagQMLvtyaGxB823hIK977dxTjl9czjsM+P76nmv2A
 zlyjB0if2/maKJtJGMA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_01,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300038

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512


Hi Linus,

Please pull some more powerpc fixes for 7.2:

Notable out of area changes:
   # 5732bd17feb9 MAINTAINERS: Demote myself to reviewer

This pull request has patch from Michael Ellerman that updates
the MAINTAINER file to demote himself from maintainer to reviewer
for powerpc tree.

Thanks

The following changes since commit f5098b6bae761e346ebcd9da7f95622c04733cff:

   Linux 7.2-rc5 (2026-07-26 14:45:48 -0700)

are available in the git repository at:

https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git 
tags/powerpc-7.2-3

for you to fetch changes up to 5732bd17feb9ddf843591c4d038eb6de1f8daf4c:

   MAINTAINERS: Demote myself to reviewer (2026-07-29 17:53:21 +0530)

- ------------------------------------------------------------------
powerpc fixes for 7.2 #3

  - Ensure vpa,slb_shadow & dtl are unregistered during crash
  - fix nap return address corruption on async interrupt exit in 970 
platform
  - Fix exit_flags field placement in pt_regs for ptrace
  - Fix map failure path in dma_ioc0_map_pages() in ps3 platfrom
  - MAINTAINERS: Demote myself to reviewer
  - misc fixes and cleanup

Thanks to:
Amit Machhiwal, Andreas Schwab, Anushree Mathur, Athira Rajeev, Christophe
Leroy (CS GROUP), Dmitry V. Levin, Geert Uytterhoeven, John Ogness, Michael
Ellerman, Mukesh Kumar Chaurasiya (IBM), Ritesh Harjani (IBM), Thorsten 
Blum,
Vaibhav Jain

- ------------------------------------------------------------------
Michael Ellerman (1):
       MAINTAINERS: Demote myself to reviewer

Mukesh Kumar Chaurasiya (IBM) (2):
       powerpc/970: fix nap return address corruption on async interrupt 
exit
       powerpc: Fix exit_flags field placement in pt_regs for ptrace

Thorsten Blum (7):
       powerpc/boot: Fix simpleboot CPU node lookup check
       powerpc/boot: Fix treeboot-currituck CPU node lookup check
       powerpc/boot: Fix treeboot-akebono CPU node lookup check
       powerpc/ps3: Remove unused struct table in setup_areas()
       powerpc/ps3: Fix map failure path in dma_ioc0_map_pages()
       powerpc/perf: Use strstarts() to simplify is_thread_imc_pmu()
       powerpc/serial: Fix include guard comment

Vaibhav Jain (2):
       powerpc/pseries: Ensure vpa,slb_shadow & dtl are unregistered 
during crash
       powerpc/pseries: Skip vpa_init() for boot cpu in smp_setup_cpu()


  MAINTAINERS                             |  2 +-
  arch/powerpc/boot/simpleboot.c          |  2 +-
  arch/powerpc/boot/treeboot-akebono.c    |  2 +-
  arch/powerpc/boot/treeboot-currituck.c  |  2 +-
  arch/powerpc/include/asm/entry-common.h | 15 +++++----
  arch/powerpc/include/asm/interrupt.h    |  1 +
  arch/powerpc/include/asm/ptrace.h       |  3 --
  arch/powerpc/include/asm/serial.h       |  4 +--
  arch/powerpc/include/asm/thread_info.h  |  1 +
  arch/powerpc/include/uapi/asm/ptrace.h  | 14 +++------
  arch/powerpc/kernel/interrupt.c         | 32 ++++++++++++--------
  arch/powerpc/kernel/ptrace/ptrace.c     |  1 -
  arch/powerpc/kernel/signal.c            |  2 +-
  arch/powerpc/perf/imc-pmu.c             |  5 +--
  arch/powerpc/platforms/ps3/mm.c         |  1 +
  arch/powerpc/platforms/ps3/spu.c        |  2 --
  arch/powerpc/platforms/pseries/kexec.c  | 13 +++++---
  arch/powerpc/platforms/pseries/smp.c    |  7 ++++-
  18 files changed, 55 insertions(+), 54 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEqX2DNAOgU8sBX3pRpnEsdPSHZJQFAmpq634ACgkQpnEsdPSH
ZJR9DA/8CNX7Alwr/aJlwwrcJ+YR4VrNYArpOMN6QELTmDyt/ZXANyVteJW7EZEy
Lca9BHYoixYSuRDEgp/VX7uoK3QOwNTNvaN/JsYOWP+Sfyt8tyol1ms5+ENABJh/
h/Y6FGlEbJucaiPo2m8lNwomLq+uR1LwxsWVmAXUQ9kYxroz9anLx7B/StDM/C+L
IuKF/0W+GZx5/HPPBjyBnpW4AQ6vauaEQuMRgmDdtVOcDbnOqSy1l7odVVexh2Wk
TYj/7NGz9Sg6QkzqjtX/k+s2sc/CxY9Nk7e0Bp5BWUI/csRi2JQMhu4kJorhK4pY
WGWtAjrOi+TcXOVv3JXCt7YSftosJJLoDNVQnC+MX+EV1/RHLCnjcawHrHXLE+Ve
v60RigJwun/RPr4lQAoJ9TbSEof8liaxomKkPersv1xlsEs8iNRBmYayu8iKrO3k
On8jBU9O5fyQNiM67U/U81d7dkvtSuNW+W/5jXSwcXAWr81yc5VSz1ujll9z88G3
SIeNHgfd71H2SlxB577Po8IYus+Usco7fuod8cvreGCMA736I7bkm0ZfbrhhkFuk
pDuZuy23rJu0S4BPG7osPmJp27sJwZr6cIfprScRhWjXaTPw4X14mYhbno4z/u5i
P56zIYjSE378nEdR972Pup2W8dMTtntEy9MHXnWLtXyxoZmFK/s=
=2rAc
-----END PGP SIGNATURE-----

