Return-Path: <linuxppc-dev+bounces-18006-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CEFFFD88F3
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Mar 2026 04:16:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fVyB01tdqz3c9r;
	Wed, 11 Mar 2026 15:16:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773202600;
	cv=none; b=eoVlKqvezYqc8LM/V2uDRc4LLU8BzLtigI22IaTd3WsolXimTsWVm/aX+O8kv9H8yAn+IVNQocD2YoIEfZO/ZHzUqlorS33px3oFllzYDWzldBHsql4veP6vQcsRYpB2ncblsvapIGMKTvFiFTMoHg2kH9SrvYAjVahWQEukPN+XRUwk9NeRekefIvjHiBsJHjtpgD4cStadzJlnZ7ybrQpJN3e/b3Ydy1HjZXcFpDWIbhF2jD2j07dLqljFdi/oZj7/MEndV0DIqBnHW1aFBYVF48u3ya4pPYahi2E/W7g3qoBqN8sEcxZie13iZHRdCr3nej3VBZtmqtkm4dEwXA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773202600; c=relaxed/relaxed;
	bh=12p7mzrAhcVQaw28wUWNcz3hlvW745f7EZVrwfRL9aI=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=aU8HtxDwo4im9jOxj0I00UUIoJc7XVV50ATHbcUeGmSaenuPMtL5Uy8qaJ0YBmdySWlp/1WW7oYjrFG8p+VAgDCvCqokHqiCyyG5lv3IcjRDtDzVVoXDmxZnGzc/vTzfCsTC3STHKOA6RCpCwkdtUNKuzfkr9giy6QnW7E6YW0ExBgHZ+9E+9hI7hZJHdMhlg1CnpQ5rD+MB0p25LpSzhqiKoe+WGePn6P0qmMhxypH49D82wqZyBB2VLNliJrvsjkDE0SNefQaBQJtCoYwSaXq2wfAZUh2Yhs5ovuK4rsOlevg7B2cWHAiXhh2ajDay5y9U+xUOBr99IuwZeXd4hA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Ecrw8X5H; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Ecrw8X5H;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fVy9z22Stz3bTf
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2026 15:16:38 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62ANNZqj1549095;
	Wed, 11 Mar 2026 04:16:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=12p7mzrAhcVQaw28wUWNcz3hlvW7
	45f7EZVrwfRL9aI=; b=Ecrw8X5H8yy5bJYI0QtOko+l3DrHg9u5gU3PYgS5xsPA
	42Uy+eBU/dlTG/d+DjilZ2Q9R1AuwtYSGEjLv6w0ctJN4n7xEiYNV/SaO2p0lcz1
	q7EdCQ6zO95jfS5YIf0aiLPpZnajRqOxXrVgfV+5d0+kz28SST4djLt2MyeQ7vXM
	QIfFqFZIVeMcy1n1szrUum8Nl67hVL7qX1t1TFaopFlLPl1Fpqo9tr9Pg/0kxMVW
	k9yH0yQNqvyl+EmIjsQCv3YR0ydurow6MbqDw0rOXX7iKsbJxI2nk9bm9EddRdc/
	LdZ0DiWCjfv+my2b4+INZmIrxlQO5V7lKIp8LeAw7Q==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcywe3w1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 04:16:19 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62B1D1d3015581;
	Wed, 11 Mar 2026 04:16:18 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4crybnc04d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 04:16:18 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62B4GGZU29688356
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Mar 2026 04:16:16 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C20E858055;
	Wed, 11 Mar 2026 04:16:16 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 756FC58043;
	Wed, 11 Mar 2026 04:16:11 +0000 (GMT)
Received: from [9.43.124.195] (unknown [9.43.124.195])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Mar 2026 04:16:11 +0000 (GMT)
Message-ID: <c9b0a57d-e628-4cd7-be9b-5057045aec15@linux.ibm.com>
Date: Wed, 11 Mar 2026 09:46:09 +0530
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
Cc: chleroy@kernel.org, christophe.leroy@csgroup.eu, hbathini@linux.ibm.com,
        j.ne@posteo.net, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
        namcao@linutronix.de, nathan@kernel.org, naveen@kernel.org,
        npiggin@gmail.com, robh@kernel.org, sourabhjain@linux.ibm.com
From: Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-7.0-2 tag
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDAzMSBTYWx0ZWRfX8DDaz7iIfVZO
 olJ89OhtuYZY3h/X4CWvNC4/MrLgOx6kf1L2Yma6fgooCAxNnyCVGjIQSOBQ7wMJiUYadiWl2ce
 OCCzH34aebwRpPJ5fHVNL3uTHlo4rBa8GaZ+PgNVIY61oEyngIl8L/7hIFlyh+t5Y4PshJYz6JM
 KJR+6xqsAlQtTTO2dDdzFo60Hj15J/3y6mmsHCWis+kU3pJ4QmzPCFjx06drN62Dy00yBj6hkDf
 rGND4gU5lkSPLVT26eW0qM6sWtALKHMwqwmUX1FrKGB192IN08pyHaX0ZmXVGFwF6rdR90oC89m
 pc1k/nhIfHaIr37uu0YhXof/OOCMavT2Lj6Fc+kcduOdT0VYeSMaQTWQY4yxe9UyA7xqrt/NhRB
 N93i/TssqRZY33Mzb1FZMrsco2+0C1sT+QjqXcDWENAsg//PwsnPQsTuWnr7Z5xn8Y2Se9o5/0e
 eE8lijsypkvGXdDJmGg==
X-Authority-Analysis: v=2.4 cv=QaVrf8bv c=1 sm=1 tr=0 ts=69b0ec93 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=F-IznfbTT3TXwy3nawYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: -Jyn1J2t3a6aj2PQa-lqbM7g5yZFXIGA
X-Proofpoint-ORIG-GUID: 4X-ImNIrTSvMjjALSMkvu0tCpB_kS6Dj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 clxscore=1015 adultscore=0
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110031

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Hi Linus,

Please pull powerpc fixes for 7.0:

The following changes since commit 11439c4635edd669ae435eec308f4ab8a0804808:

   Linux 7.0-rc2 (2026-03-01 15:39:31 -0800)

are available in the git repository at:

https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git 
tags/powerpc-7.0-2

for you to fetch changes up to 35e4f2a17eb40288f9bcdb09549fa04a63a96279:

   powerpc/pseries: Correct MSI allocation tracking (2026-03-07 16:02:28 
+0530)

- ------------------------------------------------------------------
powerpc fixes for 7.0 #2

  - Correct MSI allocation tracking
  - Always use 64 bits PTE for powerpc/e500
  - Fix inline assembly for clang build on PPC32
  - Fixes for clang build issues in powerpc64/ftrace
  - Fixes for powerpc64/bpf JIT and tailcall support
  - Cleanup MPC83XX devicetrees
  - Fix keymile vendor prefix
  - Fix to use big-endian types for crash variables

Thanks to: Abhishek Dubey, Christophe Leroy (CS GROUP), Hari Bathini, Heiko
Schocher, J. Neuschäfer, Mahesh Salgaonkar, Nam Cao, Nilay Shroff, Rob 
Herring
(Arm), Saket Kumar Bhaskar, Sourabh Jain, Stan Johnson, Venkat Rao 
Bagalkote,

- ------------------------------------------------------------------
Christophe Leroy (1):
       powerpc/e500: Always use 64 bits PTE

Christophe Leroy (CS GROUP) (1):
       powerpc/uaccess: Fix inline assembly for clang build on PPC32

Hari Bathini (9):
       powerpc64: make clang cross-build friendly
       powerpc64/ftrace: fix OOL stub count with clang
       powerpc64/ftrace: workaround clang recording GEP in 
__patchable_function_entries
       powerpc64/bpf: do not increment tailcall count when prog is NULL
       powerpc64/bpf: fix the address returned by bpf_get_func_ip
       powerpc64/bpf: use consistent tailcall offset in trampoline
       powerpc64/bpf: remove BPF redzone protection in trampoline stack
       powerpc64/bpf: fix handling of BPF stack in exception callback
       powerpc64/bpf: fix kfunc call support

J. Neuschäfer (7):
       dt-bindings: powerpc: Add Freescale/NXP MPC83xx SoCs
       powerpc: 83xx: km83xx: Fix keymile vendor prefix
       powerpc: dts: mpc8313erdb: Use IRQ_TYPE_* macros
       powerpc: dts: mpc8315erdb: Use IRQ_TYPE_* macros
       powerpc: dts: mpc8315erdb: Rename LED nodes to comply with schema
       powerpc: dts: mpc8315erdb: Add missing #cells properties to SPI bus
       powerpc: dts: mpc83xx: Add unit addresses to /memory

Nam Cao (1):
       powerpc/pseries: Correct MSI allocation tracking

Rob Herring (Arm) (2):
       powerpc: dts: fsl: Drop unused .dtsi files
       powerpc/prom_init: Fixup missing #size-cells on PowerMac 
media-bay nodes

Sourabh Jain (2):
       powerpc/kexec/core: use big-endian types for crash variables
       powerpc/crash: adjust the elfcorehdr size


  Documentation/devicetree/bindings/powerpc/fsl/fsl,mpc83xx.yaml         
                         |  93 ++++++++++
  arch/powerpc/Kconfig                                 |   4 +-
  arch/powerpc/boot/dts/asp834x-redboot.dts                             
      |   2 +-
  arch/powerpc/boot/dts/fsl/interlaken-lac-portals.dtsi                 
                  | 156 -----------------
  arch/powerpc/boot/dts/fsl/interlaken-lac.dtsi                         
          |  45 -----
  arch/powerpc/boot/dts/fsl/pq3-mpic-message-B.dtsi                     
              |  43 -----
  arch/powerpc/boot/dts/fsl/qoriq-fman3-0-10g-1-best-effort.dtsi         
                         |  80 ---------
  arch/powerpc/boot/dts/mpc8308_p1m.dts                                 
  |   2 +-
  arch/powerpc/boot/dts/mpc8308rdb.dts                                 
|   2 +-
  arch/powerpc/boot/dts/mpc8313erdb.dts                                 
  |  61 ++++---
  arch/powerpc/boot/dts/mpc8315erdb.dts                                 
  | 119 +++++++------
  arch/powerpc/boot/dts/mpc832x_rdb.dts                                 
  |   2 +-
  arch/powerpc/boot/dts/mpc8349emitx.dts                                 
|   2 +-
  arch/powerpc/boot/dts/mpc8349emitxgp.dts                               
   |   2 +-
  arch/powerpc/boot/dts/mpc8377_rdb.dts                                 
  |   2 +-
  arch/powerpc/boot/dts/mpc8377_wlan.dts                                 
|   2 +-
  arch/powerpc/boot/dts/mpc8378_rdb.dts                                 
  |   2 +-
  arch/powerpc/boot/dts/mpc8379_rdb.dts                                 
  |   2 +-
  arch/powerpc/include/asm/nohash/32/pgtable.h                           
       |   4 +-
  arch/powerpc/include/asm/nohash/32/pte-85xx.h                         
          |  59 -------
  arch/powerpc/include/asm/pgtable-types.h                               
   |   2 +-
  arch/powerpc/include/asm/uaccess.h                                 |  
  2 +-
  arch/powerpc/kernel/head_85xx.S                                  |  46 
+----
  arch/powerpc/kernel/prom_init.c                                  |   3 +-
  arch/powerpc/kernel/trace/ftrace.c                                 |  
26 ++-
  arch/powerpc/kexec/core.c                                  |  17 +-
  arch/powerpc/kexec/file_load_64.c                                  |  
14 +-
  arch/powerpc/net/bpf_jit.h                                 |   5 -
  arch/powerpc/net/bpf_jit_comp.c                                  | 127 
++++++--------
  arch/powerpc/net/bpf_jit_comp64.c                                  | 
181 ++++++++++++++++----
  arch/powerpc/platforms/83xx/km83xx.c                                 
|   4 +-
  arch/powerpc/platforms/Kconfig.cputype                                 
|   4 +-
  arch/powerpc/platforms/pseries/msi.c                                 
|   2 +-
  arch/powerpc/tools/{gcc-check-fpatchable-function-entry.sh => 
check-fpatchable-function-entry.sh} |   0
  arch/powerpc/tools/ftrace-gen-ool-stubs.sh                             
     |   4 +-
  35 files changed, 460 insertions(+), 661 deletions(-)
  create mode 100644 
Documentation/devicetree/bindings/powerpc/fsl/fsl,mpc83xx.yaml
  delete mode 100644 arch/powerpc/boot/dts/fsl/interlaken-lac-portals.dtsi
  delete mode 100644 arch/powerpc/boot/dts/fsl/interlaken-lac.dtsi
  delete mode 100644 arch/powerpc/boot/dts/fsl/pq3-mpic-message-B.dtsi
  delete mode 100644 
arch/powerpc/boot/dts/fsl/qoriq-fman3-0-10g-1-best-effort.dtsi
  delete mode 100644 arch/powerpc/include/asm/nohash/32/pte-85xx.h
  rename arch/powerpc/tools/{gcc-check-fpatchable-function-entry.sh => 
check-fpatchable-function-entry.sh} (100%)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEqX2DNAOgU8sBX3pRpnEsdPSHZJQFAmmw7BcACgkQpnEsdPSH
ZJS4bxAAl+2NnQUWKOt0ST85Hc7kZt47efcXkYaQ42ps2WRrPeDABHFlqyslLgFR
QfRAqDOj1hgnSqZAEQuzUCslL4WdnGLY7MyRD3c0F1w4Tb8k21Gt8izyxaZFP6yp
rYM1+dCRJQ8VNGyqWF1WFCLZidbVBBrS8fS/rM4KebQJfppXZFpcONguXP1MEmh9
RcA1Hb/faFogg+EmqwTHgav9mOiHNI23eNiMjCtGFzb8WFb59GZzAUTldvAUyVtV
oeO3WtUxwmYGC+ED31TBFBeB2Wq0AAHbAr8jwg05Kv9lkLLkZ5AOWB0UcxiRWlza
DFc4TyzUYHIUHWipyx3HAEYY1wDn/RzN5NL6WwPORmBvMYImkEuYGrONV72yuBnt
D8LTCcHnwLyZQDasK08ouevfsyJURU0Hxq/HQiANJxzbtTvVDU+pZ1OfKOQBIZfg
0fVhuBYZj2oRezvN4CEfPiCV3YWHco8MV0b44laF/L52Y+erqnFnWayqB+QBwEzV
YvgkhPcYHrWjmo9ZlPFxjjd7/JvC+c0fYn3igBz3xHQfwT6N45x9vxDfMo8Pj45K
SwGgWqwaZVaZUlOpJCDFoaIMak8+JemOfqKr+k7PN2iojydlzqevVnygT6riEmyR
uVSQ3uyE25QStXhayP/H6kMMzWRr57jN1Z5VvrOTE96LNgNipTs=
=e6Ya
-----END PGP SIGNATURE-----

