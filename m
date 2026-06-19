Return-Path: <linuxppc-dev+bounces-22788-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3DB4CD98E6
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Jun 2026 07:18:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ghTTX1Rs6z2ySW;
	Fri, 19 Jun 2026 17:18:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781853504;
	cv=none; b=HheZwep8jWiWV4IP5+cK1KYclDZiv/qDc3LtdVxzWuePoObnE9dfvZhFO6iOW1aT97OdlgE0gf6kgYwMyba1ggkCseyuEx6ka6Nx8vUbU4S0oDuww0CtmbO43AyXr9D5TAR2q6WVdHRDRqApcftAxEv1DGwy91T0zmRCY3cPW9Dox8jfoB2qPtRvphT9lgCoxNI6f7Chyj2+Hx35h17YsftVHWF0LFn31LbdJ02tf27Z9YlwGYu4u9lpBPMxDoNWw8ppY+ONtJP+bFcPRSbJkgkJC9aha6lOQ9AsFUYE/rZSb6ypL/bLWXlOw4ZODLYWxxampvHLV7JS8fcXkcJJ9g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781853504; c=relaxed/relaxed;
	bh=+3Z5OUE17VpwV5vUskJQUQxScpJQwXygbh7b7HMdcxc=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=WylSP/BeU6auygLDOHM39JbRqSl2czly6nHn9GXXlMAhtGPDT4nFY15La/XHiJp6BnPIL+YmqN9RpMrII9rzXWqLvPtvIXzQ3hFW0vBOfz7cV42wyEWcssmeq+05AYwPdDzZZgE9scDYJVI6rPbKHT5Ayq1AmBWINaK0EWLatDUl3pKfa+NXS+JKekbKiZm6afVwN1RjFnbMEZcMc6tvQorj0g9SRrnYljl956w7pJ354R1CMVWUSjyUzvi2Ww8TDnW4R+9/8Q5lTzL6ttx+ZxIJkMNSNEfS6gk/YaBAaUvvqGu4b/9OMReSam1AVbMDghQIfgdVS3INg6VyxouCag==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ndhKM9Mj; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ndhKM9Mj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ghTTV4xjpz2xHK
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jun 2026 17:18:22 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65J3K5jv1058480;
	Fri, 19 Jun 2026 07:18:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=+3Z5OUE17VpwV5vUskJQUQxScpJQ
	wXygbh7b7HMdcxc=; b=ndhKM9MjtIAOMEdxNHocnIzqgByq4VxjrWVI8MCGPJCG
	CK0PodYNkjkLO5Vx2Q6QfYaA/axFqRSYBNUnIDnqA3GhHdjXpyNHol0vQIUXgvdx
	VqS4dESNex2B63IirYPBIfnt3D4T6uzTgOm2QvLE8I39sKqIdncb2wMwidxyllS4
	WNMrMIRoAQSamWfEd7wvfzhg16+YTa2VascMleNvL3MMWacA4JHdEZOl12f3wJLC
	muth76li3qxaaEIbGJfIL+cB22qgLozsHJ0ODkD5vWc9dyeUtTYqDozKfH+WdNaS
	zfPg/D6CekoXWIDg3ysT1SNM8av9FDQlXSPukDQJ+Q==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqxm1ma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jun 2026 07:18:00 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65J74dU1015329;
	Fri, 19 Jun 2026 07:17:59 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ev172fnka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jun 2026 07:17:59 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65J7Hw8J7865052
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jun 2026 07:17:58 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4686058057;
	Fri, 19 Jun 2026 07:17:58 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7063258058;
	Fri, 19 Jun 2026 07:17:50 +0000 (GMT)
Received: from [9.43.110.79] (unknown [9.43.110.79])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 19 Jun 2026 07:17:50 +0000 (GMT)
Message-ID: <aafc00a7-e59e-440a-b33d-566ff4275700@linux.ibm.com>
Date: Fri, 19 Jun 2026 12:47:31 +0530
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
Cc: aboorvad@linux.ibm.com, adri.vero.dev@gmail.com, amachhiw@linux.ibm.com,
        bartosz.golaszewski@oss.qualcomm.com, chleroy@kernel.org,
        christophe.leroy@csgroup.eu, ebiggers@kernel.org,
        hbathini@linux.ibm.com, j.ne@posteo.net, leitao@debian.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        mchauras@linux.ibm.com, mkchauras@gmail.com, mkchauras@linux.ibm.com,
        mpe@ellerman.id.au, naveen@kernel.org, npiggin@gmail.com,
        sayalip@linux.ibm.com, shivangu@linux.ibm.com, skb99@linux.ibm.com,
        sshegde@linux.ibm.com, thorsten.blum@linux.dev
From: Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-7.2-1 tag
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=OcSoyBTY c=1 sm=1 tr=0 ts=6a34ed29 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=_-fFxzzEJECdKiBGjdIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDA2NiBTYWx0ZWRfX5SZQiGYBDdBY
 S4PfTiYPoeaHHAp03vo+t18GZQDqMhnOzATepkGoOsL3l80rT+yt4D8cjcdCNTa+euSYk+uJziE
 u26+hLncEwK6mF2xHeXpJK7jDp9SdVLW/m/fAfLJRRLa8dV5L7e63+raEZfOFQYC5gyEMSpT70L
 qzjAsXL8qhy5r0tMWyuIdFRUJoNROHyM+mCcA4qu6M6biQEU5fFljVYL2tT3L+8uW3BWNINqLsP
 FnBz8B7MI9KZ+0Odnvj7VZBiMb5VpSWOuQjnUl5C+hdypFvHTcQ7j1atkRh7qvxGJnyQvvW8153
 jsyb+yhyrW19RkT/UvJA07nNCqi/S4Y6qKaQcg4WlsFl08BGGpgSPl5Fm1UNo4YY/Bu/bPA8cDV
 DK3dLXVP/hIl5/9s8INxPLeF1F3kT2KYz867TpY/O9uZRTDYl2ys/33rTaDdS5QLjN0Hu9K1lrK
 8rbn6ADbxcVVblarWKg==
X-Proofpoint-GUID: Uw7pNnuUmMwSrto4N1pQ2GlJnef1rGW3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDA2NiBTYWx0ZWRfXzxVxZhrdhqeL
 6Whvz2uaahvWFayg49dmlE29Tc0HPB7uAMUlt+AIVqwtM+GBQ+f5/yZPVQAd7+cyBGN7vTQcicR
 kxlR1/ht6v17JkmtCAvwV60lIyMSqPc=
X-Proofpoint-ORIG-GUID: 29CbA9mXg_xEDj0r6zjKDSsTVTI9cknM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_01,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190066

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Hi Linus,

Please pull powerpc updates for 7.2:

Notable out of area changes:
   MAINTAINERS: powerpc: update VMX AES entries # a5779442addf

Thanks

The following changes since commit 5200f5f493f79f14bbdc349e402a40dfb32f23c8:

   Linux 7.1-rc4 (2026-05-17 13:59:58 -0700)

are available in the git repository at:

https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git 
tags/powerpc-7.2-1

for you to fetch changes up to 42f252f5a646866a95f025863c8b201042494ba1:

   powerpc/fadump: define MIN_RMA in bytes rather than MB (2026-06-16 
15:08:25 +0530)

- ------------------------------------------------------------------
powerpc updates for 7.2

  - Enable GENERIC_ENTRY feature

  - Add missing property in DTS for mpc83xx platform

  - Enable building of DTB based on platfrom Kconfig

  - Add powerpc64 JIT support for timed may_goto

  - Add timeout to RTAS busy-wait loops

  - Simplify cpumask api usage for cpuinfo display

  - implement get_direction() in cpm1 (8xx platform)

  - MAINTAINERS file update for power VMX AES entries

  - Fixes to handle preempt count

  - Restore KUAP registers on syscall restart exit

  - define MIN_RMA in bytes rather than MB

  - misc fixes and cleanups

Thanks to:
Aboorva Devarajan, Adriano Vero, Amit Machhiwal, Anushree Mathur, Bartosz
Golaszewski, Christophe Leroy (CS GROUP), David Gow, Jinjie Ruan, J.
Neuschäfer, Linus Walleij, Mahesh Salgaonkar, Mukesh Kumar Chaurasiya (IBM),
Ritesh Harjani (IBM), Saket Kumar Bhaskar, Samir M, Sayali Patil, 
Shirisha G,
Shivang Upadhyay, Shrikanth Hegde, Sourabh Jain, Thorsten Blum, Venkat Rao
Bagalkote, Yury Norov,

- ------------------------------------------------------------------
Aboorva Devarajan (3):
       powerpc/perf: fix preempt count underflow in fsl_emb_pmu_del
       powerpc/powernv: fix preempt count leak in 
pnv_kexec_wait_secondaries_down
       powerpc/kexec: fix double get_cpu() imbalance in kexec_prepare_cpus

Adriano Vero (1):
       powerpc/fadump: Add timeout to RTAS busy-wait loops

Amit Machhiwal (1):
       powerpc/boot: Allow text relocations for pseries wrapper with 
binutils 2.46+

Bartosz Golaszewski (1):
       powerpc/8xx: implement get_direction() in cpm1

Christophe Leroy (CS GROUP) (1):
       powerpc: Simplify access_ok()

J. Neuschäfer (3):
       powerpc: dts: mpc8315erdb: Add missing model property
       powerpc: dts: Add missing model properties
       powerpc: dts: Build devicetrees of enabled platforms

Mukesh Kumar Chaurasiya (8):
       powerpc: rename arch_irq_disabled_regs
       powerpc: Prepare to build with generic entry/exit framework
       powerpc: introduce arch_enter_from_user_mode
       powerpc: Introduce syscall exit arch functions
       powerpc: add exit_flags field in pt_regs
       powerpc: Prepare for IRQ entry exit
       powerpc: Enable GENERIC_ENTRY feature
       powerpc: Remove unused functions

Mukesh Kumar Chaurasiya (IBM) (1):
       powerpc: Restore KUAP registers on syscall restart exit

Saket Kumar Bhaskar (1):
       powerpc64/bpf: Add powerpc64 JIT support for timed may_goto

Sayali Patil (1):
       powerpc/fadump: define MIN_RMA in bytes rather than MB

Shivang Upadhyay (1):
       ppc/fadump: invoke kmsg_dump in fadump panic path

Shrikanth Hegde (5):
       powerpc: Use cpumask_next_wrap instead
       powerpc: Simplify cpumask api usage for cpuinfo display
       powerpc/perf: Use cpumask_intersects api for checking disable path
       powerpc/xive: Add warning if target CPU not found
       powerpc/entry: Disable interrupts before irqentry_exit

Thorsten Blum (5):
       MAINTAINERS: powerpc: update VMX AES entries
       powerpc: use sysfs_emit{_at} in sysfs show functions
       powerpc/rtas: Replace one-element array with flexible array member
       powerpc: Fix indentation and replace typedef with struct name
       powerpc/pseries/lparcfg: Replace deprecated strcpy in 
parse_system_parameter_string


  MAINTAINERS                                     |   4 +-
  arch/powerpc/Kconfig                            |   1 +
  arch/powerpc/boot/dts/Makefile                  |  73 +++
  arch/powerpc/boot/dts/fsl/Makefile              |  43 ++
  arch/powerpc/boot/dts/mpc8308_p1m.dts           |   1 +
  arch/powerpc/boot/dts/mpc8308rdb.dts            |   1 +
  arch/powerpc/boot/dts/mpc8315erdb.dts           |   1 +
  arch/powerpc/boot/dts/mpc836x_rdk.dts           |   1 +
  arch/powerpc/boot/dts/mpc8377_rdb.dts           |   1 +
  arch/powerpc/boot/dts/mpc8377_wlan.dts          |   1 +
  arch/powerpc/boot/dts/mpc8378_rdb.dts           |   1 +
  arch/powerpc/boot/dts/mpc8379_rdb.dts           |   1 +
  arch/powerpc/boot/hack-coff.c                   |   2 +-
  arch/powerpc/boot/rs6000.h                      |  84 ++-
  arch/powerpc/boot/wrapper                       |   1 +
  arch/powerpc/include/asm/entry-common.h         | 534 ++++++++++++++++++++
  arch/powerpc/include/asm/hw_irq.h               |   4 +-
  arch/powerpc/include/asm/interrupt.h            | 386 +++-----------
  arch/powerpc/include/asm/kasan.h                |  15 +-
  arch/powerpc/include/asm/prom.h                 |   4 +-
  arch/powerpc/include/asm/ptrace.h               |   6 +-
  arch/powerpc/include/asm/rtas-types.h           |   5 +-
  arch/powerpc/include/asm/signal.h               |   1 -
  arch/powerpc/include/asm/stacktrace.h           |   6 +
  arch/powerpc/include/asm/syscall.h              |   5 +
  arch/powerpc/include/asm/thread_info.h          |   1 +
  arch/powerpc/include/asm/uaccess.h              |  26 +
  arch/powerpc/include/uapi/asm/ptrace.h          |  14 +-
  arch/powerpc/kernel/cacheinfo.c                 |  13 +-
  arch/powerpc/kernel/eeh_sysfs.c                 |   8 +-
  arch/powerpc/kernel/fadump.c                    |  14 +-
  arch/powerpc/kernel/interrupt.c                 | 255 ++--------
  arch/powerpc/kernel/iommu.c                     |   3 +-
  arch/powerpc/kernel/irq.c                       |   5 +-
  arch/powerpc/kernel/prom_init.c                 |   2 +-
  arch/powerpc/kernel/ptrace/ptrace.c             | 142 +-----
  arch/powerpc/kernel/security.c                  |  13 +-
  arch/powerpc/kernel/setup-common.c              |  15 +-
  arch/powerpc/kernel/signal.c                    |  25 +-
  arch/powerpc/kernel/syscall.c                   | 119 +----
  arch/powerpc/kernel/sysfs.c                     |  23 +-
  arch/powerpc/kernel/traps.c                     |   2 +-
  arch/powerpc/kernel/watchdog.c                  |   2 +-
  arch/powerpc/kexec/core_64.c                    |   4 +-
  arch/powerpc/mm/book3s64/hash_utils.c           |   4 +-
  arch/powerpc/net/Makefile                       |   4 +
  arch/powerpc/net/bpf_jit_comp.c                 |   5 +
  arch/powerpc/net/bpf_jit_comp64.c               |  62 ++-
  arch/powerpc/net/bpf_timed_may_goto.S           |  57 +++
  arch/powerpc/perf/core-book3s.c                 |   5 +-
  arch/powerpc/perf/core-fsl-emb.c                |   3 +-
  arch/powerpc/perf/hv-24x7.c                     |  18 +-
  arch/powerpc/perf/hv-gpci.c                     |   5 +-
  arch/powerpc/perf/imc-pmu.c                     |   6 +-
  arch/powerpc/perf/kvm-hv-pmu.c                  |   3 +-
  arch/powerpc/perf/vpa-pmu.c                     |   3 +-
  arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c  |   3 +-
  arch/powerpc/platforms/8xx/cpm1.c               |  26 +
  arch/powerpc/platforms/cell/spu_base.c          |   5 +-
  arch/powerpc/platforms/powernv/idle.c           |   3 +-
  arch/powerpc/platforms/powernv/opal-dump.c      |  11 +-
  arch/powerpc/platforms/powernv/opal-elog.c      |   9 +-
  arch/powerpc/platforms/powernv/opal-flash.c     |   4 +-
  arch/powerpc/platforms/powernv/opal-powercap.c  |  12 +-
  arch/powerpc/platforms/powernv/opal-psr.c       |  12 +-
  arch/powerpc/platforms/powernv/setup.c          |   3 +-
  arch/powerpc/platforms/powernv/subcore.c        |   3 +-
  arch/powerpc/platforms/ps3/setup.c              |   3 +-
  arch/powerpc/platforms/pseries/cmm.c            |   5 +-
  arch/powerpc/platforms/pseries/dlpar.c          |   3 +-
  arch/powerpc/platforms/pseries/ibmebus.c        |   5 +-
  arch/powerpc/platforms/pseries/lparcfg.c        |  24 +-
  arch/powerpc/platforms/pseries/papr_scm.c       |   5 +-
  arch/powerpc/platforms/pseries/power.c          |   3 +-
  arch/powerpc/platforms/pseries/pseries_energy.c |   3 +-
  arch/powerpc/platforms/pseries/rtas-fadump.c    |  80 +--
  arch/powerpc/platforms/pseries/rtas-fadump.h    |   6 +
  arch/powerpc/platforms/pseries/suspend.c        |   3 +-
  arch/powerpc/platforms/pseries/vas-sysfs.c      |   3 +-
  arch/powerpc/platforms/pseries/vio.c            |  29 +-
  arch/powerpc/sysdev/fsl_mpic_timer_wakeup.c     |   3 +-
  arch/powerpc/sysdev/xive/common.c               |   1 +
  82 files changed, 1242 insertions(+), 1068 deletions(-)
  create mode 100644 arch/powerpc/include/asm/entry-common.h
  create mode 100644 arch/powerpc/net/bpf_timed_may_goto.S
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEqX2DNAOgU8sBX3pRpnEsdPSHZJQFAmo07IkACgkQpnEsdPSH
ZJT2DxAAuc2sasoQHNYTY+JxNk8Wyqtut3CYO1uq5ieHJoOfZtcgvNfs/OiW6bYY
02R2UMMxM7S0Ur3xZcDsykYqoHgidcqlMWnoBJFLKsCIh+cwlDRGsbI7jpFKoxi5
RgzwaasbBEHUnNONlNu7PmL3xb1vAIOSq5oBtaqbMYp7H8Z6yvFf2jCQH4ftkOjy
ga1gyKzo2c9MTr8R2saVUd39kpQRsgs/0p1yOuE1GxLwM3mwf2dd585dILjPL3wh
GXtDMqQceSVd0LWEJrQhe87vCs7suDQXuGBlNn8l7qP7wK4R9ISJJDqYF+zXEB/m
p3p3lcLO90mRFSjZslJmwH6+2aIT+7LTOIURu4IWjUCUMeopuXIE5E+VlLlx0M6x
OG/vPLMKy+sUPD9Kf6JtV2Ms6DmYYKKit/TgU4/ErnolSaHsoNINJkwuWUaggg/i
uw1LYOIIzYUSmivWDzAk58BNjMLzDYmauPyFaf1n95xeGy8dTbqjFJuksGIKNv6i
RyICLpxHGmB5Pg8i9Fu6xe+sQTXRuwTV1HWX65M3EvCBVO+6O1kpLxqdfk9WPfUL
4+DKv7miVVGTE5LQPk9X6i3ekLYHhxNjYOcUYHz0Y1q5tUdJSYkyhW2kKNDUkyTh
KwtzEfkAPm+CjKvr2S2M2oh0adGgcp3W66AFrZYwlov2BCavFoY=
=nZuM
-----END PGP SIGNATURE-----

