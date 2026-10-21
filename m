Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E6D606A31D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Oct 2026 04:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=rlZBEJi4
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j8cJv6p1rz2xKN;
	Wed, 21 Oct 2026 15:49:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792558191;
	cv=none; b=ginSMZl1MJeZtyNjrwJmm+22yR6NbXlj8iqYNedR3UyaBXfu1kQHWzscgjnaNR4+kcd69jzOqj3Crgzl1QhUbI9+r75RLO7Ar56A3GDdIUAjJVymcDxN+KLdM1MnB7zvum6Xamvt+nEcGzQYAwtswTw7XyqUcODOkV0sjdwhypTvP2Ofuzyp8a+9jxLfScO69vM1V9Ql77EceEcLxqlysuflIN/2oFh11S7Ol7QBs9UZTJcY8gnZnVDmal9lO5QiLPxPg7S7iftOzDYvIh6xsHJd0Px626zLiQJO4UmlaSFmJkkdGFhLG1y+pC9f0NbsIUVn3Eu4tYXJ0cQtIgAlAg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792558191; c=relaxed/relaxed;
	bh=7oaTt4Ln2aGDPNKw4Gdo/Lhjck9YtGnDde/QeKvPTws=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Ca1NAfnPRl6DkhR7QZHlIMXk6KYTgVFJKPgA88zc50EsDCbhm5qIJIEoSGq/Ci65EamFWu90Nnk/NrHzG7Bdtb3rGWfWiLqZG0B/+JK/lNDZWzBpTQ3S+GDYPkNpzS+P0i2rHWPi8hlgctihR4LAskhyYPgTGZ1BNn9MNJgMyQp7KMkOhVVEcm/fOdmsAoYeukvRSEl9wiWQhhzM0OGuA/q31riyqSqhJHVCauFoI4Ioqa1hbH0AHKDnWfFRWj/i9ZYJ9N5NtM9CrAd4rdbJSpwaa2Ib36k1HxYUl3nKpqZWdQW9S3ZvzAXzqyaN5Ga5aO6TNv8New9jx4awgzz8Lw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=rlZBEJi4; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=rlZBEJi4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j8cJt4wDFz2xK7
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2026 15:49:49 +1100 (AEDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69L2ExMm2449468;
	Wed, 21 Oct 2026 04:49:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=7oaTt4Ln2aGDPNKw4Gdo/Lhjck9Y
	tGnDde/QeKvPTws=; b=rlZBEJi4LaPkyf/FFMPQ+8iibpWk3Der+Z63EkLpHd8L
	eU0NkYOmyWVYedl/5WoIh0AXX+UgdMPqj8RBkY7lcHK4lzZxcxTJaU7l3ygQtIYR
	5ZwqZlvakK4wMRewst4NRyn+UNTtW/cRicr7g89/L9WKaE8D2WmzTylOESS8mbRK
	iSPGCtjhYkJxIeASHtrIvL7faEjqt0qIdfmQHIkiO93a0qgCX4sqM9XxRQJjIc2q
	PN+O7CiqRpNFdqcHSkXdQqWXOYvnU4y+V2u36Wpns0vx3W0phdBRILhobiew4u7h
	SucJl05apr8UlF3EjYlLtQYWB0CpwPk1L8P7yyKZrA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw5bey08-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 21 Oct 2026 04:49:23 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69L2JudM2374709;
	Wed, 21 Oct 2026 04:49:22 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4he7bs3jnv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Oct 2026 04:49:22 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69L4nKOv57934110
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Oct 2026 04:49:20 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5C59858045;
	Wed, 21 Oct 2026 04:49:20 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EC93758052;
	Wed, 21 Oct 2026 04:49:09 +0000 (GMT)
Received: from [9.43.124.72] (unknown [9.43.124.72])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 21 Oct 2026 04:49:09 +0000 (GMT)
Message-ID: <2331292e-1a40-44ef-8776-9155e8e41f03@linux.ibm.com>
Date: Wed, 21 Oct 2026 10:19:07 +0530
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: adubey@linux.ibm.com, amachhiw@linux.ibm.com, blum@kernel.org,
        christophe.leroy@csgroup.eu, dmitry.torokhov@gmail.com,
        gautam@linux.ibm.com, gbatra@linux.ibm.com, hbathini@linux.ibm.com,
        kaylovefoss@gmail.com, kmehltretter@gmail.com, linkmauve@linkmauve.fr,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        mkchauras@gmail.com, mpe@ellerman.id.au, naveen@kernel.org,
        npiggin@gmail.com, shivangu@linux.ibm.com, srikar@linux.ibm.com,
        sshegde@linux.ibm.com, ssrish@linux.ibm.com, venkat88@linux.ibm.com,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
From: Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-7.4-1 tag
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: yzreIHjv_1zo5byFWxo_enJvkCMN-weV
X-Proofpoint-ORIG-GUID: NmScilQInxlo1E6dsLgESBIpBZP5WD0j
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAxOCBTYWx0ZWRfX6oYaHQRd26TI
 /mC3odd1m8mjJBnOJwXlaVA6pky0PVStKwF/4fql5O0rQWIJjWkiUlgZRpew8MGuqEbeEdAUM0t
 uN/9IFIm41MbowORxwvupSUJU/zLk40=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAxOCBTYWx0ZWRfX+xUFMTPzdWSH
 JRg4yvHFskXOBz5CGTxccqHTYfbVjKjWwYV1rmGwSAU1ka9j7bWwyaTMqHdRH3kHR4uHzF/yK+m
 /xHQNrFlszaVGPzlYkj2pgeJKq12kudQDAFcVAWvugKg7/nAiCjIGj096Dev+IuVBElgzpQJde/
 bWFF45SscUSOhmY2pes+JpzcJKz/vhcoG5u0UFEt7eyZYIpR4GuUrZpLJAAD5MP+A89lYg4WFbK
 cbfLjCD/WWjKEkMS0Z+abFn07yU7AhFaiOT65S6CJUB+H+TPGC4kVbDwlRyzC1KYarAycpvRH8o
 CL0OO8ozGk9h2FCXzTSmiyFFW9uzoSdkMHWeMiIG8XNfaL7OLhsvWThiFKAKLmEVO2C1s9OXJTG
 86gTP4GGH3GUnnWc3wJ6GpIqQl4cOmYhkkyDRy5805JK09o/OE1GazhlI6XxRYseTohLFAM2tlT
 95sjle54gRu+fmQsHDQ==
X-Authority-Analysis: v=2.4 cv=Gb2CDgXL c=1 sm=1 tr=0 ts=6ad84453 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=_wwuUL6Yo3K-ZoUOV3AA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0 phishscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610210018
X-Spam-Status: No, score=-20.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Hi Linus,

Please pull powerpc updates for 7.4:

Notable out of area changes:
   Documentation/ABI/testing/ppc-memtrace        # cb3502d2e57a
   update PKS documentation and MAINTAINERS entry    # 0499ab96527a

Thanks

The following changes since commit 93f51579e7df248780214094418f205253383cc5:

   Linux 7.3-rc4 (2026-09-20 13:48:15 -0700)

are available in the git repository at:

https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git 
tags/powerpc-7.4-1

for you to fetch changes up to 129f5d395fd66b6587a5ac156b232cca060d6512:

   powerpc/numa: Support coregroup on PowerNV (2026-10-12 11:24:19 +0530)

- ------------------------------------------------------------------
powerpc updates for 7.4

  - powerpc/numa: Support coregroup on PowerNV

  - powerpc/irq: Move __softirq_pending out of irq_stat

  - powerpc/512x: Remove pdm360ng platform setup in favor of mpc512x_generic

  - powerpc/ps3: Simplify control flow in ps3_{virq,irq_plug}_setup()

  - KVM: PPC: Book3S HV: Add preempt_disable() around virtual-mode HPTE 
bit-lock users

  - powerpc/syscall: Avoid atomic test_and_clear_thread_flag on fast path

  - pseries/plpks cleanup and fixes

  - Misc fixes and cleanup

Thanks to:
Abhishek Dubey, Amit Machhiwal, Anushree Mathur, Bui Nguyen Nhu Quynh,
Christophe Leroy (CS GROUP), Dmitry Torokhov, Gaurav Batra, Gautam Menghani,
Geert Uytterhoeven, Greg Joyce, Hari Bathini, Harsh Prateek Bora, Karl
Mehltretter, Link Mauve, Michal Suchánek, Mukesh Kumar Chaurasiya (IBM), 
Nayna
Jain, Ritesh Harjani (IBM), R Nageswara Sastry, Saket Kumar Bhaskar, Samir
Mulani, Shivang Upadhyay, Shrikanth Hegde, Sourabh Jain, Srikar Dronamraju,
Srish Srinivasan, Thorsten Blum, Vaibhav Jain (IBM), Venkat Rao Bagalkote,
Yeswanth Krishna Tellakula,

- ------------------------------------------------------------------
Abhishek Dubey (5):
       powerpc64/bpf: fix compare instruction emitted for tailcall
       powerpc64/bpf: fix percpu private stack leak on JIT failure
       powerpc/bpf: fix buffer overflow in JIT for large BPF programs
       powerpc/bpf: fix alignment of long branch trampoline address
       powerpc/bpf: Move out dummy_tramp_addr after Long branch stub

Amit Machhiwal (3):
       KVM: PPC: Book3S HV: Add SRCU protection for virtual-mode HPT hcalls
       KVM: PPC: Book3S HV: Add preempt_disable() around virtual-mode 
HPTE bit-lock users
       KVM: PPC: Fix get_d_signext() 12-bit displacement for 
paired-single D-form

Bui Nguyen Nhu Quynh (1):
       KVM: PPC: Fix callback check in kvmppc_gsm_refresh_info

Dmitry Torokhov (3):
       powerpc/dts: mpc5121: Move GPIO controller properties to SoC dtsi
       powerpc/dts: pdm360ng: Convert ADS7845 touchscreen to DT bindings
       powerpc/512x: Remove pdm360ng platform setup in favor of 
mpc512x_generic

Gaurav Batra (1):
       powerpc/pseries/iommu: Add TCEs for 16GB pages when RAM is pre-mapped

Gautam Menghani (2):
       KVM: PPC: Book3S HV: Add missing mappings for tracing exits
       KVM: PPC: Book3S HV: Free the queue pages in error path

Karl Mehltretter (1):
       docs: ABI: Fix powerpc memtrace Kconfig symbol

Link Mauve (2):
       powerpc/sstep: Consistently use one define to check arch bit width
       powerpc/sstep: Don’t define variables we won’t be using

Mukesh Kumar Chaurasiya (IBM) (3):
       powerpc: fix NMI exit ordering: restore soft masks after 
irqentry_nmi_exit()
       powerpc/kasan: fix r2 corruption in mem*() on GENERIC_ENTRY with 
old compilers
       powerpc/syscall: Avoid atomic test_and_clear_thread_flag on fast path

Shivang Upadhyay (1):
       powerpc/fadump: collect dump when CPU_STATE_DATA is less than 
reserved

Shrikanth Hegde (4):
       powerpc/irq: Move __softirq_pending out of irq_stat
       powerpc/irq: Make irqstats array based
       powerpc/irq: Suppress unlikely interrupt stats by default
       powerpc/ftrace: Don't restore r13 during ftrace_regs_caller

Srikar Dronamraju (3):
       powerpc/numa: Simplify find_primary_domain_index
       powerpc/numa: Allow cpu_to_coregroup_id without PPC_SPLPAR
       powerpc/numa: Support coregroup on PowerNV

Srish Srinivasan (12):
       pseries/plpks: fix error handling in plpks_read_var()
       pseries/plpks: fix error code for wrapping key reads
       pseries/plpks: validate input to plpks_signed_update_var()
       pseries/plpks: clear sensitive PLPKS buffers
       pseries/plpks: clear sensitive buffers in wrapping operations
       pseries/plpks: clear signed update authentication buffer
       pseries/plpks: clear SED key data after use
       pseries/plpks: fix self-reference in plpks_var initializer
       pseries/plpks: hide wrapping_features when unsupported
       pseries/plpks: make narrowing conversions explicit
       pseries/plpks: rename the default wrapping key macro
       pseries/plpks: update PKS documentation and MAINTAINERS entry

Thorsten Blum (2):
       powerpc/ps3: Simplify control flow in ps3_{virq,irq_plug}_setup()
       powerpc/sysfs: Remove redundant wait time clamps

Venkat Rao Bagalkote (1):
       powerpc/interrupt: Use early_radix_enabled() in NMI real-mode guard


  Documentation/ABI/testing/ppc-memtrace         |   2 +-
  Documentation/arch/powerpc/papr_hcalls.rst     |  16 +--
  MAINTAINERS                                    |   2 +-
  arch/powerpc/boot/dts/ac14xx.dts               |  13 --
  arch/powerpc/boot/dts/mpc5121.dtsi             |   6 +-
  arch/powerpc/boot/dts/pdm360ng.dts             |   8 +-
  arch/powerpc/include/asm/hardirq.h             |  31 +++--
  arch/powerpc/include/asm/interrupt.h           |   7 +-
  arch/powerpc/include/asm/kasan.h               |  15 ---
  arch/powerpc/include/asm/string.h              |  21 +---
  arch/powerpc/include/asm/topology.h            |  15 ++-
  arch/powerpc/kernel/cputable.c                 |  14 +--
  arch/powerpc/kernel/dbell.c                    |   2 +-
  arch/powerpc/kernel/irq.c                      | 131 ++++++++++----------
  arch/powerpc/kernel/prom_init.c                |  10 +-
  arch/powerpc/kernel/prom_init_check.sh         |  15 +--
  arch/powerpc/kernel/syscall.c                  |   6 +-
  arch/powerpc/kernel/sysfs.c                    |   4 +-
  arch/powerpc/kernel/time.c                     |   6 +-
  arch/powerpc/kernel/trace/ftrace_entry.S       |   6 +
  arch/powerpc/kernel/traps.c                    |  11 +-
  arch/powerpc/kernel/watchdog.c                 |   2 +-
  arch/powerpc/kvm/book3s_hv.c                   |  76 ++++++------
  arch/powerpc/kvm/book3s_paired_singles.c       |   7 +-
  arch/powerpc/kvm/book3s_xive.c                 |   4 +-
  arch/powerpc/kvm/guest-state-buffer.c          |   2 +-
  arch/powerpc/kvm/trace_book3s.h                |   4 +-
  arch/powerpc/lib/copy_32.S                     |  10 +-
  arch/powerpc/lib/mem_64.S                      |   7 +-
  arch/powerpc/lib/memcpy_64.S                   |   4 +-
  arch/powerpc/lib/sstep.c                       | 111 +++++++++--------
  arch/powerpc/mm/numa.c                         |  85 +++++++++----
  arch/powerpc/net/bpf_jit.h                     |  20 ++-
  arch/powerpc/net/bpf_jit_comp.c                | 100 +++++++++++----
  arch/powerpc/net/bpf_jit_comp32.c              |   7 +-
  arch/powerpc/net/bpf_jit_comp64.c              |  15 +--
  arch/powerpc/platforms/512x/Kconfig            |   3 +-
  arch/powerpc/platforms/512x/Makefile           |   1 -
  arch/powerpc/platforms/512x/mpc512x_generic.c  |   1 +
  arch/powerpc/platforms/512x/pdm360ng.c         | 126 -------------------
  arch/powerpc/platforms/ps3/interrupt.c         |  22 +---
  arch/powerpc/platforms/pseries/iommu.c         |  67 ++++++----
  arch/powerpc/platforms/pseries/plpks-sysfs.c   |  20 ++-
  arch/powerpc/platforms/pseries/plpks.c         |  51 ++++----
  arch/powerpc/platforms/pseries/plpks_sed_ops.c |  12 +-
  arch/powerpc/platforms/pseries/rtas-fadump.c   |  18 ++-
  46 files changed, 544 insertions(+), 572 deletions(-)
  delete mode 100644 arch/powerpc/platforms/512x/pdm360ng.c
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEqX2DNAOgU8sBX3pRpnEsdPSHZJQFAmrYQ6wACgkQpnEsdPSH
ZJTPDw//QGC0T2n98V0QtOQDcRKCHWKORfXtAcuzK9c50tR8fIpqW9/Xox8DAdG6
AJtSWqGDnTahpQg4O2bjq3NgE5yYW4ghmAWVqCwL8P/j97YM436123EUTEw6M5ai
kk1rjswxMltyGAVlNrVbYxJ5edCmqUE2oYKxioy7UAgKtO9gSGgsBgoogCB/0tq0
Z1BqmTmPrlkcVkY0hTXgqF+Q0JELVR0IZ5Jivk++jUWVBOLvMSHVYMWFKR5l5K5D
vk+ffkzS69xVtOXQcAb6smpaTpb4PSG0QSWe90vXNOAkQCFRg3P+o6bgO57C0ZC8
AETdvsBjMl3cMq/bhZGREqareSX+kI/3gP0lto8lQ1DDpbHePwrYcrOqOCk/TPnZ
rum6AXhHwpLZmMsIqk1K3Q9px1ghcnyjnl7GVAwfB4OrKPa8IzL4+X2b2X/EBlTt
tA5SKrL4z8CNkqI7ibFYAEB8UliYkG3kD3qvLo+W+rNFzCcsRI/O4VEu2keetQUF
lRE+HwUEZOEJgD5MhGSziJkq/IqErvyEIUINvTCuT6aEylGL0JSRLpZ0Jcse/8LG
wiJP1blocWHLHzSr2ZfGbhmSyEzKgLYV8a/QhmZV/FZCkWMN7OL2JvwYAPpNC/rp
C6RZLQwS06xAPZJOzKCfsBDyHPByQUKO/XSz5BqVlU9a3rF1ZZY=
=9+Nb
-----END PGP SIGNATURE-----

