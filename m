Return-Path: <linuxppc-dev+bounces-19702-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89EF8F34C58
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Apr 2026 14:21:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fvV2G0nkKz2ytT;
	Tue, 14 Apr 2026 00:21:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776090070;
	cv=none; b=f1hOESWsfhXfhVeRi+QnDZmc/FTdg3BNlYRLPTIdwIxI/Lz+o1mjZQXnTO8EvDL+/JrkLrikGPU/Gvvkmf3oR3rfXVqcrzdBC/eU4MX1kxBwAhJVk0J9tc4TszIG2TC6IcV8wDRXThxPHox1aBkMumfso8hcCZBc+o/52CNQ3zZvGhtSD9tX092lskJa5EDVcLPGInFnpItkm8yFAcfpTMUmbeAGgKfpnEuiBYVwlNN8pdDtA8mha3R9yFuSrk9aChokRsTObyHNzpv8z4RGdZFBoJkPD1Hx+4g1HiXLNHM0vC8dazFu2ZHLbVI/x+2LCDswmRz1MvdnLPXehroMOA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776090070; c=relaxed/relaxed;
	bh=JtZQASNJi8c2QJWTVuvzuyC5UYsstZMbwMtbvYXzqxM=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=PZNMeg6YT6YX6t1/9HUKR0iI8BFvENXMqOIBQxoIeaQ80zsi1BWFEs5e1znyeqSGn2xRX9FhT+6KMBz1Unu2tr9etqIS8OXft+nSgR7TevNoZFdl0zwS/tfF+CF3642ezPandBuLs6jSob7Y0lDzQKA4geDrok8TQARZcnxNc5xV7jDB+HXk1M/dSVL6XTSG9SJNZqgSdkG3fZAaLNT7w0eCEJR9IV8EGlqZZHhP3XfQumlhvbhZi0BFoWAPPYMfXRszwKqNuVW21HpwgMF7NJkmIx55ymrMbBaNMo57vH2qBa6LvU9Th/C/U7hnmmC+qoGXSirlosYImz48jss51Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=msM6MGpd; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=msM6MGpd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fvV2D4syHz2yrl
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2026 00:21:08 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63D9kDsV1848205;
	Mon, 13 Apr 2026 14:20:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=JtZQASNJi8c2QJWTVuvzuyC5UYss
	tZMbwMtbvYXzqxM=; b=msM6MGpdgru1wC+p3FhSc3Lxny7A9tfyb5w2/O1FrbVd
	e1d9f2qhHUChKC7MU2pURWObpNlMuwKT0NAkGSUKyBL/m42P+4kZ6j3BIWQEqBn2
	Fhu1btG8Sq0KfTf74/Wl4Oc7a9Tu/TeH7gRzj/+0k/XBrPsqXO+szwBxMZRmQXD0
	mnVykdqTG89shjf2dF8DTSVyuzov4OxljUE47468G63TViavWVZYCyWA3sMeNNUM
	2wezoAjWg1O4VqmpMH5t0pedKUJlUMsCk3Et6HTqxQ9wH9JEmDH++uxLZjKUcsbH
	yKWegH0djhJFOmZ37vqTd2GKHLK3twebAH/ea0GFZA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dfcqeysg8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Apr 2026 14:20:37 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63DCoXae031138;
	Mon, 13 Apr 2026 14:20:37 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dg10y5kk1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Apr 2026 14:20:37 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63DEKZYf25756238
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Apr 2026 14:20:36 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9D0CE58050;
	Mon, 13 Apr 2026 14:20:35 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F10258045;
	Mon, 13 Apr 2026 14:20:27 +0000 (GMT)
Received: from [9.43.116.243] (unknown [9.43.116.243])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Apr 2026 14:20:26 +0000 (GMT)
Message-ID: <f027ade2-63e3-4d9f-8737-eaf295c8535a@linux.ibm.com>
Date: Mon, 13 Apr 2026 19:50:25 +0530
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
Cc: adubey@linux.ibm.com, ajd@linux.ibm.com, amachhiw@linux.ibm.com,
        chleroy@kernel.org, christophe.leroy@csgroup.eu,
        hbathini@linux.ibm.com, j.ne@posteo.net, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, naveen@kernel.org,
        nichen@iscas.ac.cn, nilay@linux.ibm.com, npiggin@gmail.com,
        rdunlap@infradead.org, ritesh.list@gmail.com,
        sourabhjain@linux.ibm.com, sshegde@linux.ibm.com, ynorov@nvidia.com,
        yury.norov@gmail.com
From: Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-7.1-1 tag
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDE0MSBTYWx0ZWRfX/1lipqUG0ioo
 ebP6GI5stURWm9anUb5AUnVQcdbp7Xpktjp5gWBxshBRk3+maqGsHmNn7GrprHSrw2Ql755vM59
 ZzMnNql2G1NAgPMFk4rWjIjtuG5oakHshmvBAxogEsaw2P4xJKGtXOi7/H9XIO70AagvumnECcB
 fPwLwzmbHFF/JQXzM1eb0QTo317AjRUuqp6p7woh7gReW9JZ6XIbMSxsKDb79N1MRVZksWasR/A
 XOxajYSpeg4Bsa9BKKMBigU37jrphV95OmQ8K56eDs/GOxzs7lEhX92svhDAHJaiuCJaBJ/nS7R
 4jMs6tVdJLayVLTP4YvlrNW+UoWvhqfaA86CaBRhvRujyxFa+V/pnESFyr1GrrnyYoJ+qf8ihRV
 QagZ7B2e9HemhM/nIXFyuoBD0XxANAPBNkF9Lom1rXCWV8Mp9K3U0Gce8u78RQe8PmsQ1qee+U7
 n4KZ/+x6mIz5hdCtp4A==
X-Proofpoint-GUID: 3I50_3BlWDBKQ6JKsdHAOk_JUYIAC2C8
X-Proofpoint-ORIG-GUID: psEjseBZQ4QxzS0_f5Ya5obyhThfoJ5h
X-Authority-Analysis: v=2.4 cv=YemNIQRf c=1 sm=1 tr=0 ts=69dcfbb6 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=qNABUOcEAAAA:8 a=Fon3XCLwWw9CSsqamtEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Ytm653ucTKQjCvbzLygB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 malwarescore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604130141

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Hi Linus,

Please pull powerpc updates for 7.1:

There are couple of pending conflict with the tip tree and bpf-next tree,
the obvious resolutions are correct, but are described here for reference
(tip tree) 
https://lore.kernel.org/linux-next/ac_R8cR5A-YtcRpi@sirena.org.uk/ and
(bpf-tree) 
https://lore.kernel.org/linux-next/adTxB7PjvXi5N4EB@sirena.org.uk/

Thanks

Notable out of area changes:

   .mailmap                                                  # 
b80777aef570 mailmap: Add entry for Andrew Donnellan
   drivers/cpuidle/cpuidle-*                                 # 
64ed1e3e728a cpuidle: powerpc: avoid double clear when breaking snooze
   drivers/vfio/pci/vfio_pci_core.c                          # 
948b71aa81cd drivers/vfio_pci_core: Change PXD_ORDER check from switch 
case to if/else block
   tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c   # 
66cad93ad325 selftest/bpf: Enable instruction array test for powerpc
   tools/testing/selftests/bpf/prog_tests/*                  # 
e640bcd1bf83 selftests/bpf: Enable private stack tests for powerpc64
   tools/testing/selftests/bpf/progs/verifier_gotox.c        # 
e1f7a0e196e2 selftest/bpf: Enable gotox tests for powerpc64

The following changes since commit f338e77383789c0cae23ca3d48adcc5e9e137e3c:

   Linux 7.0-rc4 (2026-03-15 13:52:05 -0700)

are available in the git repository at:

https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git 
tags/powerpc-7.1-1

for you to fetch changes up to b80777aef570ac561977d7210d04890f9df7e484:

   mailmap: Add entry for Andrew Donnellan (2026-04-09 10:54:22 +0530)

- ------------------------------------------------------------------
powerpc updates for 7.1

  - powerpc support for huge pfnmaps

  - Cleanups to use masked user access

  - Rework pnv_ioda_pick_m64_pe() to use better bitmap API

  - Convert powerpc to AUDIT_ARCH_COMPAT_GENERIC

  - Backup region offset update to eflcorehdr

  - Fixes for wii/ps3 platform

  - Implement JIT support for private stack in powerpc

  - Implement JIT support for fsession in powerpc64 trampoline

  - Add support for instruction array and indirect jump in powerpc

  - Misc selftest fixes and cleanups

Thanks to:
Abhishek Dubey, Aditya Gupta, Alex Williamson, Amit Machhiwal, Andrew
Donnellan, Bartosz Golaszewski, Cédric Le Goater, Chen Ni, Christophe 
Leroy (CS
GROUP), Hari Bathini, J. Neuschäfer, Mukesh Kumar Chaurasiya (IBM), Nam Cao,
Nilay Shroff, Pavithra Prakash, Randy Dunlap, Ritesh Harjani (IBM), 
Shrikanth
Hegde, Sourabh Jain, Vaibhav Jain, Venkat Rao Bagalkote, Yury Norov (NVIDIA)

- ------------------------------------------------------------------
Abhishek Dubey (9):
       powerpc64/bpf: Implement JIT support for private stack
       selftests/bpf: Enable private stack tests for powerpc64
       powerpc64/bpf: Implement fsession support
       powerpc32/bpf: Add fsession support
       powerpc/bpf: Add support for instruction array
       selftest/bpf: Enable instruction array test for powerpc
       powerpc64/bpf: Add support for indirect jump
       selftest/bpf: Enable gotox tests for powerpc64
       powerpc32/bpf: fix loading fsession func metadata using PPC_LI32

Amit Machhiwal (1):
       selftests/powerpc: Suppress -Wmaybe-uninitialized with GCC 15

Andrew Donnellan (1):
       mailmap: Add entry for Andrew Donnellan

Chen Ni (3):
       powerpc/52xx/media5200: Consolidate chained IRQ handler 
install/remove
       powerpc/52xx/mpc52xx_gpt: consolidate chained IRQ handler 
install/remove
       powerpc/44x/uic: Consolidate chained IRQ handler install/remove

Christophe Leroy (1):
       powerpc/audit: Convert powerpc to AUDIT_ARCH_COMPAT_GENERIC

Christophe Leroy (CS GROUP) (5):
       powerpc/futex: Use masked user access
       powerpc/ptrace: Convert gpr32_set_common_user() to scoped user access
       powerpc/align: Convert emulate_spe() to scoped user access
       powerpc/sstep: Convert to scoped user access
       powerpc/net: Inline checksum wrappers and convert to scoped user 
access

J. Neuschäfer (4):
       powerpc: Move GameCube/Wii options under EMBEDDED6xx
       powerpc: wii: Add unit address to /memory
       powerpc: wii: Fix GPIO key name pattern
       powerpc: wii: Fix LED name pattern

Nilay Shroff (1):
       powerpc/xive: fix kmemleak caused by incorrect chip_data lookup

Randy Dunlap (3):
       powerpc/ps3: fix ps3.h kernel-doc warnings
       powerpc: kgdb: fix kernel-doc warnings
       powerpc/ps3: spu.c: fix enum and Return kernel-doc warnings

Ritesh Harjani (IBM) (12):
       powerpc/pgtable-frag: Fix bad page state in pte_frag_destroy
       powerpc/64s: Fix unmap race with PMD migration entries
       powerpc/64s: Fix _HPAGE_CHG_MASK to include _PAGE_SPECIAL bit
       powerpc/64s/tlbflush-radix: Remove unused radix__flush_tlb_pwc()
       powerpc/64s: Move serialize_against_pte_lookup() to hash_pgtable.c
       powerpc/64s: Kill the unused argument of exit_lazy_flush_tlb
       powerpc/64s: Rename tlbie_va_lpid to tlbie_va_pid_lpid
       powerpc/64s: Rename tlbie_lpid_va to tlbie_va_lpid
       powerpc/64s: Make use of H_RPTI_TYPE_ALL macro
       powerpc: Print MMU_FTRS_POSSIBLE & MMU_FTRS_ALWAYS at startup
       drivers/vfio_pci_core: Change PXD_ORDER check from switch case to 
if/else block
       powerpc/64s: Add support for huge pfnmaps

Shrikanth Hegde (1):
       cpuidle: powerpc: avoid double clear when breaking snooze

Sourabh Jain (2):
       powerpc/crash: fix backup region offset update to elfcorehdr
       powerpc/crash: Update backup region offset in elfcorehdr on 
memory hotplug

Yury Norov (2):
       Revert "powerpc/xive: Fix the size of the cpumask used in 
xive_find_target_in_mask()"
       powerpc/xive: rework xive_find_target_in_mask()

Yury Norov (NVIDIA) (2):
       powerpc: pci-ioda: use bitmap_alloc() in pnv_ioda_pick_m64_pe()
       powerpc: pci-ioda: Optimize pnv_ioda_pick_m64_pe()


  .mailmap  |   3 +
  arch/powerpc/Kconfig  |   6 +-
  arch/powerpc/boot/dts/wii.dts   |   8 +-
  arch/powerpc/include/asm/book3s/64/pgtable.h  |  43 ++++-
  arch/powerpc/include/asm/book3s/64/tlbflush-radix.h   |   1 -
  arch/powerpc/include/asm/checksum.h   |  22 ++-
  arch/powerpc/include/asm/futex.h  |   6 +-
  arch/powerpc/include/asm/kexec.h  |  14 +-
  arch/powerpc/include/asm/pgtable.h  |  14 ++
  arch/powerpc/include/asm/ps3.h  |  15 +-
  arch/powerpc/include/asm/unistd32.h   |   7 +
  arch/powerpc/kernel/Makefile  |   3 -
  arch/powerpc/kernel/align.c   |  75 ++++----
  arch/powerpc/kernel/audit.c   |  87 ----------
  arch/powerpc/kernel/compat_audit.c  |  49 ------
  arch/powerpc/kernel/kgdb.c  |   3 +-
  arch/powerpc/kernel/ptrace/ptrace-view.c  |  64 ++++---
  arch/powerpc/kernel/setup-common.c  |   4 +
  arch/powerpc/kexec/crash.c  |  64 +++++++
  arch/powerpc/kexec/file_load_64.c   |  29 +---
  arch/powerpc/lib/Makefile   |   3 +-
  arch/powerpc/lib/checksum_wrappers.c  |  39 -----
  arch/powerpc/lib/sstep.c  |  77 ++++-----
  arch/powerpc/mm/book3s64/hash_pgtable.c   |  21 +++
  arch/powerpc/mm/book3s64/internal.h   |   2 -
  arch/powerpc/mm/book3s64/pgtable.c  |  40 +----
  arch/powerpc/mm/book3s64/radix_tlb.c  |  61 +++----
  arch/powerpc/mm/pgtable-frag.c  |   1 +
  arch/powerpc/net/bpf_jit.h  |  10 +-
  arch/powerpc/net/bpf_jit_comp.c   | 179 ++++++++++++++++++--
  arch/powerpc/net/bpf_jit_comp32.c   |  35 ++++
  arch/powerpc/net/bpf_jit_comp64.c   |  64 ++++++-
  arch/powerpc/platforms/44x/uic.c  |   4 +-
  arch/powerpc/platforms/52xx/media5200.c   |   4 +-
  arch/powerpc/platforms/52xx/mpc52xx_gpt.c   |   3 +-
  arch/powerpc/platforms/embedded6xx/Kconfig  |  31 ++--
  arch/powerpc/platforms/powernv/pci-ioda.c   |  27 +--
  arch/powerpc/platforms/ps3/spu.c  |  10 +-
  arch/powerpc/sysdev/xive/common.c   |  47 ++---
  drivers/cpuidle/cpuidle-powernv.c   |   5 +-
  drivers/cpuidle/cpuidle-pseries.c   |   5 +-
  drivers/vfio/pci/vfio_pci_core.c  |  19 +--
  tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c   |   2 +-
  tools/testing/selftests/bpf/prog_tests/struct_ops_private_stack.c  | 
30 ++--
  tools/testing/selftests/bpf/progs/struct_ops_private_stack.c  |   6 -
  tools/testing/selftests/bpf/progs/struct_ops_private_stack_fail.c  |  6 -
  tools/testing/selftests/bpf/progs/struct_ops_private_stack_recur.c |  6 -
  tools/testing/selftests/bpf/progs/verifier_gotox.c  |   4 +-
  tools/testing/selftests/powerpc/vphn/Makefile   |   2 +-
  49 files changed, 690 insertions(+), 570 deletions(-)
  create mode 100644 arch/powerpc/include/asm/unistd32.h
  delete mode 100644 arch/powerpc/kernel/audit.c
  delete mode 100644 arch/powerpc/kernel/compat_audit.c
  delete mode 100644 arch/powerpc/lib/checksum_wrappers.c
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEqX2DNAOgU8sBX3pRpnEsdPSHZJQFAmnc+vEACgkQpnEsdPSH
ZJSdXQ/+Jok7hUBsTZ9kyFr5FKLeQc9/6K3AIFDWdKWyTlYPPYJsVtH6DVkxtnKC
w9IpkoUMGWNS0HzWGHWScQBOB2hlI1wNdbgW65i/x5En/A3qFRlNCdJJvmJa/TTA
/amvMLPon+CKGbIvyPxlEo4btzDBIvnw+7rrdorTW/pWB54Tv2kBaAApwzLQw12k
wFa2JN+u9Ru3/4+gyZk6PUMvCBO2lP2LjyefsCyma9UGjzkGg85DBNo9Przdd8Eq
8v2Y+07FaSoVhpuE1zm28vBqRNneHH7AU7w3Jvuy2JX1pn6+hLK17SBkzM8VTixT
xc0HHWDUH4qJ98tOdT4s4wvHBExJjkckM0p9EMpuSLLtmNEswdXstnUXOt7BPYXy
AcQl1Hjv5FoyPPvFCsi8yecCWvKFx1AUIE8r278sj51Go9n4qF/m1CEXVIIw58EG
FmNUa12k2t6I66k9HpztCgPvvlzQqz5N2NuTojUx2iRqOpjx6sbjsEslOoBmRmZH
vjrmbHqbXCgII672/FEC9a0N2Ex/su9uStlU+X8jAyqOKygBtuyjiheMD1euITAO
67T3LD9uS7OdV+T52OCIbn53gIvm28S3cCyIbX32AGWzfYkMoPhHw5ZPkaRG6nus
ztt0kd6YUb06JKAzMX9w42GwCDxDjw/gVKTTdWy8NoyAy+CBVGA=
=i7ew
-----END PGP SIGNATURE-----

