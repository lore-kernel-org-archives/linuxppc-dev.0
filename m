Return-Path: <linuxppc-dev+bounces-25899-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 107A1C5CFC1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Aug 2026 04:46:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hNgKQ5HYZz2xrC;
	Mon, 17 Aug 2026 14:46:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786942010;
	cv=none; b=gBoc6kFWMe5Ot1zYgFAZq9nvEbymSdniCwFvHgo8UZfiIgWtkxrjrW/S7vx+rOVH13aJo3FxUzndDLIn3P+K6gc6Lku03m+8me5buqYmiYvyzRG+h/aop5K6Evioiy9ZfrIquLpsxhGT0c9eNETTIpNzlJrgj9Gt5gn4fObMb9Zrm1x6bcPNL5y1T0fMgDiL/2RFz6kOHZOPwqbHXjpd0lc+JxulmoRL1h/wG7PTln3/wUe3GoAQXj1G+lTsUdKN5SZWfdXyPlON4PtrL12YvNUnDomuPxfICRQIc+Fbm89w5wctkfnBO7yd4ua3ivhEeJ+vNLwOb7DYNGydOzBmww==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786942010; c=relaxed/relaxed;
	bh=Knh53XrASzCa0gTLBfv4tTy3nmEOY3Jw5jqftGqrLGQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=JWdAAp8lzvnTHopFoRr5V4ghmUfeV8hymR2HFGIDGBOQDJiY+fCc3OPbYs+j3HnBXgZEMh0C2/eKlmWhnS93Wzu0wppPvKyd7u/D5hwoGJA29EKYW9XIMbP3epNpitK9rLFrhGKkxygqq2mNRTTKI3jVEVNO3vUSAmbcRaWboarWcQIzmZXfvtRYUt0J+cTFMesuOg1hhXmgFdbjqhvYw1vigFWURFSjqxvdSYrUxEcFAgoMf5OljN3bPwjOftYbPLLR7J1Y2sFQzgdaYQH+YgbMmlfl9yjx9qQc9rDCQh9QUZGz0rnGB7x1+nUUmtPKNQ72AE+A0vQ2G/fO2hbwZw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=sG/SowBN; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=sG/SowBN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hNgKP3PNMz2xl5
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2026 14:46:48 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67GLVsHw3685338;
	Mon, 17 Aug 2026 04:45:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=Knh53XrASzCa0gTLBfv4tTy3nmEO
	Y3Jw5jqftGqrLGQ=; b=sG/SowBN9ET80rjjwO4KrEymunXXdXvZ5Kr9f9q5XNi/
	1knwZ1JAqt1ICJ2nEdjxpCpc7DnuhK16XXVGiP6hN8xKHhhp2e+rz39NH6XMuyO6
	A1mkws9frQQjBGoXDJKQ+6nSHqvK7ULegKR3ybEXIRfelEn8Vw/B4G4vhUZ0D7/e
	Io2cfFmjmghe/cKgzBo0wAWjOdqliR17Y/eZklJBgKt4IZxMmhNB07mO2WGWKHR0
	0KtgXJYJYie+N2IrOyB2Ga+eIY3+/xtAoERoVbc6AYomIVm7XwtBGTOH6mDTLf1p
	G/PQ4CfjvpPqC1L6w7ZK5Txtbm7SKQfkUFqusBnaFQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fm3g91x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Aug 2026 04:45:46 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67H4fUh3031480;
	Mon, 17 Aug 2026 04:45:45 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g32tvve9x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Aug 2026 04:45:45 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67H4j5gr27263596
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Aug 2026 04:45:05 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AAA6D58061;
	Mon, 17 Aug 2026 04:45:43 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0F2E65805D;
	Mon, 17 Aug 2026 04:45:34 +0000 (GMT)
Received: from [9.123.14.9] (unknown [9.123.14.9])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 17 Aug 2026 04:45:33 +0000 (GMT)
Message-ID: <a0c34d36-fa5c-494f-8525-13e0af8a40f0@linux.ibm.com>
Date: Mon, 17 Aug 2026 10:15:32 +0530
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
Cc: amachhiw@linux.ibm.com, atrajeev@linux.ibm.com, bp@alien8.de,
        chleroy@kernel.org, christophe.leroy@csgroup.eu, gary@garyguo.net,
        gautam@linux.ibm.com, gbatra@linux.ibm.com, gouhao@uniontech.com,
        linkmauve@linkmauve.fr, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, mahesh@linux.ibm.com,
        mkchauras@gmail.com, mpe@ellerman.id.au, mwalle@kernel.org,
        naveen@kernel.org, nikhilks@linux.ibm.com, npiggin@gmail.com,
        ritesh.list@gmail.com, rosenp@gmail.com, ruanjinjie@huawei.com,
        skb99@linux.ibm.com, sourabhjain@linux.ibm.com, sshegde@linux.ibm.com,
        thorsten.blum@linux.dev, vishalc@linux.ibm.com,
        yanfei.xu@bytedance.com
From: Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-7.3-1 tag
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 6SJHMjOUHQGx1TPbB-PeKM5KrLdmMjL8
X-Proofpoint-ORIG-GUID: 32R13kwQl0YjO_viKBRf1uAub1hqL9GF
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDAzMSBTYWx0ZWRfX6myTqWDWDiER
 Xfh3IOci3s6MtT3N8dMJS3YCZAaxzUPeqFXsouOQjdtmFF/H95MVhsp/deuxDG9M+7UNhC52woV
 ZJtHCsgDNw1hUdK47gV5m7aokjjuCv4=
X-Authority-Analysis: v=2.4 cv=WtQb99fv c=1 sm=1 tr=0 ts=6a8291fb cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=qNABUOcEAAAA:8 a=FJSKCLtgCbpyOlTXmhMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Ytm653ucTKQjCvbzLygB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDAzMSBTYWx0ZWRfX5gWbItHgSgOt
 Xjv8KKSpt7Vjj1epOaQxACVG/xhjzH7W2eIdZVobsVr1tYO4x164Do/wfv0Iq1DIWR+WGz4/LGx
 UKJ78X47O+UQ21Utwdo/XVZU3fKV2cQWNvydOrXr3c4Qi3T5nogRj28Doa0/HZG+xGTNK9WA2DL
 WfB4o2l5z900idwUfisiPP/XPDYO8X9pfbKpBU15PWCvI5v+/7ZoTBmplxKctNgI1M2D8F8A7xL
 wqcRtZyfRTiX0GmiTHw5CE/CiHqpd/kRJntZ3a7SYFjsUji5KACuwQyfZ2jC3qUjFq+UDu+zTiu
 wUnXtyGRjzhICVmF0Q9pKh6xc7r4sBLt5Y18IJV/pzVuIMYTiioRivHPNbwsEWOFtwBDgyDCwXw
 F86i2/bXmRSmD3Doddi/kuIkCEJaT+gY+B4/1dbk74oY7Zg5PvzU1/W6H8Cjepu7lxElkONc3A9
 Bot2BJ6ifenmUcdP0gw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1011 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608170031

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Hi Linus,

Notable out of area changes:
   Documentation/virt/kvm/api.rst    # c1721e584244
   drivers/gpio/Kconfig            # 595f5f25a96a
   drivers/watchdog/pseries-wdt.c    # 516a25491845
   include/uapi/linux/kvm.h        # ac3e65ddddf3
   rust/Makefile                # bc87cbdb952e
   rust/compiler_builtins.rs        # c93c194e4ee7
   rust/helpers/helpers.c        # be809b60cbb6
   scripts/min-tool-version.sh        # e299147cdc8e
   drivers/gpio/gpio-ppc44x.c        # 98a39710fc8d

There is one trivial conflict in include/uapi/linux/kvm.h with the 
kvm-arm tree.
More info
https://lore.kernel.org/linux-next/ans20_e3b_8XJsvA@sirena.org.uk/

Thanks

Please pull powerpc updates for 7.3:

The following changes since commit f5098b6bae761e346ebcd9da7f95622c04733cff:

   Linux 7.2-rc5 (2026-07-26 14:45:48 -0700)

are available in the git repository at:

https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git 
tags/powerpc-7.3-1

for you to fetch changes up to 1304643a1c20badbb91b86a5084dd76cb7620c05:

   powerpc/pseries/iommu: switch to Default DMA window during kdump 
(2026-08-11 10:32:18 +0530)

- ------------------------------------------------------------------
powerpc updates for 7.3

  - powerpc: Enable Rust for ppc64le

  - ppc4xx gpio driver updates

  - Add power12 base enablement support

  - Validate arch_compat against host compatibility mode

  - Simplify bootx_scan_dt_build_struct() in powermac platform

  - powerpc: implement get_direction() in cpm2

  - Use cpu_relax() in ps3_create_spu()

  - Add NULL guard for cause_ipi in smp_muxed_ipi_message_pass

  - fixes to handle pseries watchdogs in kdump path

  - powerpc/irq: Fix missing r2 clobber in PCREL inline assembly

  - ppc44x: Set GPIO chip parent

  - KVM: PPC: Introduce KVM_CAP_PPC_COMPAT_CAPS and wire up ioctl BY: 
Amit Machhiwal

  - KVM: powerpc: Use generic xfer to guest work function

  - Enable to run posix cpu timers in task context

  - misc fixes and cleanups

Thanks to:
Aditya Gupta, Alice Ryhl, Amit Machhiwal, Andrew Morton, Anushree Mathur,
Athira Rajeev, Bartosz Golaszewski, Cédric Le Goater, Christian König,
Christophe Leroy (CS GROUP), Gary Guo, Gaurav Batra, Gautam Menghani, 
Gou Hao,
Hari Bathini, Harsh Prateek Bora, jiazhenyuan, Jinjie Ruan, Link Mauve, 
Linus
Walleij, Mahesh Kumar G Mahesh Salgaonkar, Michael Walle, Michal Suchánek,
Mukesh Kumar Chaurasiya (IBM), Nicholas Piggin, Nikhil Kumar Singh, 
Praveen K
Pandey, Ritesh Harjani (IBM), Rosen Penev, Saket Kumar Bhaskar, Shrikanth
Hegde, Sourabh Jain, Thorsten Blum, Vaibhav Jain, Venkat Rao Bagalkote, 
Vishal
Chourasia, Wentao Guan, Yanfei Xu

- ------------------------------------------------------------------
Amit Machhiwal (5):
       KVM: PPC: Book3S HV: Validate arch_compat against host 
compatibility mode
       KVM: PPC: Introduce KVM_CAP_PPC_COMPAT_CAPS and wire up ioctl
       KVM: PPC: Book3S HV: Implement compat CPU capability retrieval 
for KVM on PowerVM
       KVM: PPC: Book3S HV: Add support for compat CPU capabilities for 
KVM on PowerNV
       KVM: PPC: Document KVM_PPC_GET_COMPAT_CAPS ioctl

Athira Rajeev (1):
       powerpc/perf: Add power12 Base Performance Monitoring support

Christophe Leroy (CS GROUP) (1):
       powerpc: implement get_direction() in cpm2

Gaurav Batra (1):
       powerpc/pseries/iommu: switch to Default DMA window during kdump

Gou Hao (5):
       powerpc/xive: make xive IPI allocation NULL-safe
       powerpc/xive: add error return value to xive_smp_probe()
       powerpc/xive: propagate IPI init errors to prevent use-after-free
       powerpc/xive: defer setting cause_ipi until IPI init succeeds
       powerpc/smp: add NULL guard for cause_ipi in 
smp_muxed_ipi_message_pass

Jinjie Ruan (3):
       powerpc/crash: Fix possible memory leak in update_crash_elfcorehdr()
       powerpc/kexec_file: Fix null-ptr-def in extra size calculation
       powerpc/kexec_file: Prevent kexec range truncation

Link Mauve (2):
       rust: Make __udivdi3() and __umoddi3() panic
       rust: Add PowerPC support

Madhavan Srinivasan (1):
       powerpc64/bpf: Fix build break in bpf_jit_emit_func_call_rel()

Mahesh Salgaonkar (1):
       powerpc/pseries: Limit PVR list to 16 entries for CAS negotiation

Michael Walle (1):
       powerpc/configs: enable CONFIG_RAS to fix EDAC support

Mukesh Kumar Chaurasiya (IBM) (6):
       rust: Fix "multiple candidates for rmeta dependency core" error
       dma-resv: Fix undefined symbol when CONFIG_DMA_SHARED_BUFFER is 
disabled
       powerpc/jump_label: adjust inline asm to be consistent
       rust/powerpc: Set min rustc version for powerpc
       powerpc: Enable Rust for ppc64le
       powerpc/syscall: Fix syscall skip handling for seccomp and ptrace

Nicholas Piggin (1):
       powerpc: Add Power12 raw mode

Nikhil Kumar Singh (1):
       powerpc/64s: Clarify copy_and_flush() cache sync loop comment

Ritesh Harjani (IBM) (1):
       powerpc: Add Power12 architected mode

Rosen Penev (9):
       powerpc/44x: Set GPIO chip parent
       gpio: move ppc4xx gpio driver from arch/powerpc to drivers/gpio
       gpio: ppc44x: update all 4xx to 44x
       gpio: ppc44x: Use module platform driver helper for GPIO
       gpio: ppc44x: Use platform resource helper for GPIO MMIO
       gpio: ppc44x: Convert GPIO to generic MMIO
       gpio: ppc44x: drop PPC-specific IO helpers
       gpio: ppc44x: fix undefined behavior in GPIO_MASK2 macro
       gpio: ppc44x: use dev_name() for chip label

Saket Kumar Bhaskar (2):
       powerpc64/bpf: Fix build break for arch_bpf_timed_may_goto
       powerpc/irq: Fix missing r2 clobber in PCREL inline assembly

Shrikanth Hegde (1):
       powerpc: enable to run posix cpu timers in task context

Sourabh Jain (3):
       powerpc/pseries: Move H_WATCHDOG definitions to a common header
       powerpc/pseries: Handle and log pseries-wdt registration failures
       powerpc/crash: stop watchdogs before booting kdump kernel

Thorsten Blum (15):
       powerpc/kexec_file: use snprintf to simplify setup_kdump_cmdline
       powerpc/boot: drop redundant assignment in serial_edit_cmdline
       powerpc: rtas: use get_user to simplify manage_flash_write
       powerpc/pseries: Simplify attribute description check in papr_init()
       powerpc/rtasd: Use struct_size() to simplify log_rtas_len()
       powerpc/pseries/ras: Use struct_size() to simplify 
fwnmi_get_errinfo()
       powerpc/dt_cpu_ftrs: Avoid separate strlen() in scan_callback()
       powerpc/ps3: Use cpu_relax() in ps3_create_spu()
       powerpc/powermac: Simplify bootx_scan_dt_build_struct()
       powerpc/powernv: Avoid strlen() in pnv_restart()
       powerpc/pseries: Avoid strlen() in do_{remove,update}_property()
       powerpc/boot: Remove unused sprintf()
       powerpc/serial: Use generic BASE_BAUD in asm/serial.h
       KVM: PPC: booke: Use min() in watchdog_next_timeout()
       KVM: PPC: Use min() in kvm_vm_ioctl_check_extension()

Vishal Chourasia (1):
       KVM: powerpc: Use generic xfer to guest work function

Yanfei Xu (1):
       KVM: PPC: Validate irqchip index in MPIC routing


  Documentation/virt/kvm/api.rst                            |  77 ++++
  arch/powerpc/Kconfig                                      |   3 +
  arch/powerpc/Makefile                                     |   7 +
  arch/powerpc/boot/serial.c                                |   1 -
  arch/powerpc/boot/stdio.c                                 |  11 -
  arch/powerpc/boot/stdio.h                                 |   3 -
  arch/powerpc/configs/44x/warp_defconfig                   |   2 +-
  arch/powerpc/configs/85xx-hw.config                       |   1 +
  arch/powerpc/configs/ppc44x_defconfig                     |   2 +-
  arch/powerpc/include/asm/cpu_setup.h                      |   2 +
  arch/powerpc/include/asm/cputable.h                       |  17 +-
  arch/powerpc/include/asm/jump_label.h                     |  23 +-
  arch/powerpc/include/asm/kvm_ppc.h                        |   1 +
  arch/powerpc/include/asm/mmu.h                            |   1 +
  arch/powerpc/include/asm/papr-watchdog.h                  |  64 +++
  arch/powerpc/include/asm/prom.h                           |   3 +-
  arch/powerpc/include/asm/reg.h                            |  17 +-
  arch/powerpc/include/asm/serial.h                         |   4 +-
  arch/powerpc/include/asm/synch.h                          |   6 +-
  arch/powerpc/include/asm/syscall.h                        |   6 +
  arch/powerpc/include/asm/thread_info.h                    |   1 +
  arch/powerpc/include/asm/xive.h                           |   4 +-
  arch/powerpc/include/uapi/asm/cputable.h                  |   2 +
  arch/powerpc/include/uapi/asm/kvm.h                       |  18 +
  arch/powerpc/kernel/cpu_setup_power.c                     |  43 ++
  arch/powerpc/kernel/cpu_specs_book3s_64.h                 |  36 ++
  arch/powerpc/kernel/dt_cpu_ftrs.c                         |  44 +-
  arch/powerpc/kernel/head_64.S                             |  20 +-
  arch/powerpc/kernel/irq.c                                 |  16 +-
  arch/powerpc/kernel/prom_init.c                           |  46 +-
  arch/powerpc/kernel/rtas_flash.c                          |  27 +-
  arch/powerpc/kernel/rtasd.c                               |  19 +-
  arch/powerpc/kernel/setup-common.c                        |   1 +
  arch/powerpc/kernel/smp.c                                 |   3 +
  arch/powerpc/kernel/syscall.c                             |   3 +
  arch/powerpc/kexec/crash.c                                |   2 +-
  arch/powerpc/kexec/file_load.c                            |  14 +-
  arch/powerpc/kexec/file_load_64.c                         |   2 +-
  arch/powerpc/kexec/ranges.c                               |  12 +-
  arch/powerpc/kvm/Kconfig                                  |   1 +
  arch/powerpc/kvm/book3s_hv.c                              | 119 ++++-
  arch/powerpc/kvm/booke.c                                  |   3 +-
  arch/powerpc/kvm/mpic.c                                   |   3 +-
  arch/powerpc/kvm/powerpc.c                                | 125 +++++-
  arch/powerpc/mm/book3s64/hash_native.c                    |  22 +-
  arch/powerpc/mm/init_64.c                                 |   4 +-
  arch/powerpc/net/bpf_jit_comp64.c                         |   6 +-
  arch/powerpc/net/bpf_timed_may_goto.S                     |   2 +-
  arch/powerpc/perf/Makefile                                |   2 +-
  arch/powerpc/perf/core-book3s.c                           |   2 +
  arch/powerpc/perf/internal.h                              |   1 +
  arch/powerpc/perf/power12-events-list.h                   |  78 ++++
  arch/powerpc/perf/power12-pmu.c                           | 466 
++++++++++++++++++++
  arch/powerpc/platforms/44x/Kconfig                        |   7 -
  arch/powerpc/platforms/44x/Makefile                       |   2 +-
  arch/powerpc/platforms/44x/gpio.c                         | 210 ---------
  arch/powerpc/platforms/powermac/bootx_init.c              |   4 +-
  arch/powerpc/platforms/powernv/setup.c                    |   2 +-
  arch/powerpc/platforms/powernv/smp.c                      |   8 +-
  arch/powerpc/platforms/ps3/spu.c                          |  10 +-
  arch/powerpc/platforms/pseries/iommu.c                    |  23 +-
  arch/powerpc/platforms/pseries/papr_platform_attributes.c |   6 +-
  arch/powerpc/platforms/pseries/ras.c                      |  16 +-
  arch/powerpc/platforms/pseries/reconfig.c                 |   4 +-
  arch/powerpc/platforms/pseries/setup.c                    |  28 +-
  arch/powerpc/platforms/pseries/smp.c                      |   8 +-
  arch/powerpc/sysdev/cpm_common.c                          |  13 +
  arch/powerpc/sysdev/xive/common.c                         |  28 +-
  drivers/gpio/Kconfig                                      |   7 +
  drivers/gpio/Makefile                                     |   1 +
  drivers/gpio/gpio-ppc44x.c                                | 208 +++++++++
  drivers/watchdog/pseries-wdt.c                            |  53 +--
  include/uapi/linux/kvm.h                                  |   3 +
  rust/Makefile                                             |  56 ++-
  rust/compiler_builtins.rs                                 |   6 +
  rust/helpers/helpers.c                                    |   2 +
  scripts/min-tool-version.sh                               |   2 +
  77 files changed, 1613 insertions(+), 492 deletions(-)
  create mode 100644 arch/powerpc/include/asm/papr-watchdog.h
  create mode 100644 arch/powerpc/perf/power12-events-list.h
  create mode 100644 arch/powerpc/perf/power12-pmu.c
  delete mode 100644 arch/powerpc/platforms/44x/gpio.c
  create mode 100644 drivers/gpio/gpio-ppc44x.c
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEqX2DNAOgU8sBX3pRpnEsdPSHZJQFAmqCkUkACgkQpnEsdPSH
ZJQuXg//dxEnKbVm3pRj+IkeOl5ZeC02XoVY8ydbojXUBqx3YMfFlo6Qdx5c3yAw
CU6jsiQt4HA+sj1/ltk5Ksj3VpcbdRVosHt6jfCk0T+Jm/dHNu6SMJ7edKEyvnGJ
x/buh2BYLW4nU3nyLEAUHAZFM2qwXW6n+oudDX1eR3MWOrE+mSrafif7xfyPfQot
pUPQSWeJIdJcgFN3Oxs2U+0aH6m22TGYgeSDoPreOLOJ1FnxO/aQSHAV0VxmLYde
Q4o5/evBon6FclwF7ZIiRnOHU5eNMkqIivzIn/GgIMuDjBvjAcwSDfYLIP57V7wN
vCUm4CvLiU48SIjSoIWZTCbwDTiHB40u/DLLscmsiSwjfYENgjvMpqjLTM3GilLa
Cv6qD7uqGHbMMh+xRPYZaOvaPQpUZiGS/4+1hem3wKZ/+VJKVnGcl/Wmud1OSx4I
ennpL0AaO230cgXtV2/efgVeRqA3IoBiOW90JsXeITdqrBdnpYCWP9QB4F0nnkFp
VSrMkNFi9xhQY/UejAtXMXYAn/j2HYpebsLd6OicQ21Gk4bDbtayDwi8vNw1b6CI
KAHl1+tlXSzMiitLMCe1UIdohbj7+dUzOPXQQo2OZ9iYjdlef1bjYjRdR0189Ckb
HncdgQHbKZZTo+3md/A7PtGl7HexVqjuUNtB5nNZQz91QD6BDxE=
=chRB
-----END PGP SIGNATURE-----

