Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC5C606A33A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2026 01:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Zm1GgbSd
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTkn54R4tz2xlY;
	Wed, 18 Nov 2026 12:40:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794966009;
	cv=none; b=hmcmoozEVM6of4lXdN9e/yW/T5yfUtpinY6RQRSP2QB5oPDKQfMfNHM4AsmtP4HI9XrQLhezPTvO7/jKEvd4FrqT7XPLr6uoEPr9mJu4Rwgli+9x/R+UBFgHMo5mY4USM8ISyO3xC7BkyvqO9nvz09X/Ss7Hjc1s4/YWDkVjZWIE6KaiIfswyG5YDhobkILeCDe/my8L+73EIKzTm07G/Pk0UtzMWBaNxgSIHIryjZgKqdD4Wp52O/JNf6XxRFwIOjjWPXrg3X9Pfzejj4fh8rV9hVf9LjygThU3OwSVWJ0Xe+cHJRDxCTfwMAWtlHDMKcecikRpwDupWEzGKqM18g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794966009; c=relaxed/relaxed;
	bh=L6q1Id6Yjw/qKVMjz81RdBpCrMrsXpt90S8flFNX/zk=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=SwkilyU/j1/3CiZ3lXlAYo4jDK3nXTmTdIcpO07h13LO0Cc31xBfQyd8U+A1CcjxDXBT0AkuUKHXpK/YQl4KO1XjQKaMPWAWGNOOumpzjMRMphPPinmlyPosMHqJwUp4jHyqkKlkACLme/U85KuUoNfwxCUtsVkRgHVPv5+ATyyKiaBMBbM8AGNYqhOlQGNIlCT+4g9b88bgupTKkPxFma+bcISgIxCbN+fhtZbmaq1uMVzis+myytO6l4lvapRGJL1VCAVdHF/NrmzstDzMFBxrwDKMOTctu2mMYXUfc6czuMUIS6o8DajPEmKqAiFhToQHoqTXAX9oOb6FAmNdKw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Zm1GgbSd; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Zm1GgbSd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTkn36l5hz2xNC
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 12:40:07 +1100 (AEDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHMvSK52009607;
	Wed, 18 Nov 2026 01:39:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=L6q1Id6Yjw/qKVMjz81RdBpCrMrs
	Xpt90S8flFNX/zk=; b=Zm1GgbSdr2jRzCarRGYpP964kU+kV0QUqkLOmiDnlKnF
	8eLbWCsqYX1AFw81QhHKsGb/WjTWwH8v5GGE/E4lZpiVlJOAzMZ1fZq46zzYdmFV
	WYbUsf+piDrSuzMzEq1zPZrTrEh593J+noG4tL8tpY6i0lEdrb89khr6JGvWlFc8
	0AqhqDUb5MrN/nYdbUkVWcW20cl6dV1Uq3vNUkWTD9K38ODVbiTFUQzPknirZueP
	QGWtab7LAerBPw1C0r/x2Z38aR9rZ+Ybq/8ie5P2izKu4Lm5WmsPSs4w57DZyTde
	pb+Tl5sluzut0yi/OsO+Tlc0TI+O9HYPogirsUKOGA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105rgcua-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 01:39:45 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHMo0u42523290;
	Wed, 18 Nov 2026 01:39:44 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hyxwt6ny2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 01:39:44 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AI1dhWL30147228
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Nov 2026 01:39:43 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 22E0E5803F;
	Wed, 18 Nov 2026 01:39:43 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4F4465804E;
	Wed, 18 Nov 2026 01:39:35 +0000 (GMT)
Received: from [9.43.63.250] (unknown [9.43.63.250])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Nov 2026 01:39:34 +0000 (GMT)
Message-ID: <6aec7d43-7c12-413e-a73a-3275a1ac79ad@linux.ibm.com>
Date: Wed, 18 Nov 2026 07:09:33 +0530
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
Cc: amachhiw@linux.ibm.com, brads@mainlining.org, christophe.leroy@csgroup.eu,
        gautam@linux.ibm.com, info@xenosoft.de, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, luiz.capitulino@linux.dev,
        maddy@linux.ibm.com, mdshahid03@gmail.com, mpe@ellerman.id.au,
        mpe@kernel.org, nathan@kernel.org, naveen@kernel.org,
        npiggin@gmail.com, sashal@kernel.org, yaojiale02@163.com,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>
From: Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-7.4-2 tag
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: US7J12UYlWhqabawuB-m5hoj1z_kaM01
X-Authority-Analysis: v=2.4 cv=e8uT2qp/ c=1 sm=1 tr=0 ts=6afd01e2 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=Mo48iAHoWTUKEd3wlQ4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDAwNSBTYWx0ZWRfX2/m0BxrnM3pN
 gXMKxa9ge49bg/bUIQFoB9VZ2YI1ACzRdD9E78FNVHvHcyArdHUI5huzU13dfvqkrKJHolLNUkt
 LyibWtLVGsGe54WPjU+w9mH0SdIk0IA=
X-Proofpoint-ORIG-GUID: 57ekJ4xXDJmO4g4NntKcJd3lpVbRwmD3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDAwNSBTYWx0ZWRfXwqVqG0zj8XTP
 Wek4f0kFToSkhxl80Erco9CAgODZMZIq6oWf2QrOqqdF7wXs7kCOKplLilI6L1HGL4t7vXkdmZI
 2LCuPuyxRqTuvooDEUpxUauRhozVnEgZLGicdRBFYYhr83l/atSNwS1vtgDyTmBwZ9p2MGZzlXm
 IgRn51uqRVLTkoQL5W0oczRSVPzHUJ3lx/sbvAJ4t0yo8Ply5qT6B76LgG0wk2FQ4UvpjR1BIGA
 qzshVAVtshntyQcgT+Zn3WqdYCwJST7O5V7RlvFR7qNqZtwIxvtjAnBwXG0CKyEbo18OxmQAOF/
 hPN9U6iDIqQU7JW2f3aCTj+MTm/dqKqerEz0XJSj0tuWAVbpbf6/rBEBIedO/fpcQTmz/3OvSvA
 2D6WFxRz+Vx4fbJsVMDzAew2MjsYq7VfLJSgBJXXc6y/bjE86ytx0Q0TRTcJQSV4cn4K31vT8Ev
 C3BHHNfleGtnhURLz/g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_05,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611180005
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

Please pull powerpc fixes for 7.4:

Notable out of area changes:
  selftests/powerpc: override EMIT_TESTS instead of the emit_tests rule 
# 6648db997a0b

The following changes since commit 7475ea8b58616b33c04afb976cf0fbaad9dd63fb:

   Linux 7.4-rc2 (2026-11-08 16:22:20 -0800)

are available in the git repository at:

https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git 
tags/powerpc-7.4-2

for you to fetch changes up to 9500416c8aa7c271b85be6a0d5856da62b60223a:

   powerpc/perf/vpa-dtl: use GFP_ATOMIC for DTL buffer allocation 
(2026-11-11 17:33:20 +0530)

- ------------------------------------------------------------------
powerpc fixes for 7.4 #2

  - powerpc/smp: Handle of_property_count_u32_elems() error in 
parse_thread_groups()
  - powerpc/pasemi: Defer Nemo IRQ initialization
  - powerpc/watchdog: disable watchdog when watchdog_thresh=0
  - powerpc32/modules: Reserve a PLT entry for ftrace_regs_caller
  - powerpc KVM fixes
  - misc fixes and cleanups

Thanks to: Amit Machhiwal, Bradley Morgan, Christian Zigotzky, 
Christophe Leroy
(CS GROUP), Gautam Menghani, Jiale Yao, Luiz Capitulino (Red Hat), Michael
Ellerman, Mohammad Shahid, Nathan Chancellor, Ritesh Harjani (IBM), Sasha
Levin, Shrikanth Hegde, Timothy Pearson

- ------------------------------------------------------------------
Amit Machhiwal (1):
       KVM: PPC: Book3S HV: Disable preemption around host-side HPT lock 
users

Bradley Morgan (1):
       powerpc32/modules: Reserve a PLT entry for ftrace_regs_caller

Christian Zigotzky A-EON Open Source (1):
       powerpc/pasemi: Defer Nemo IRQ initialization

Gautam Menghani (5):
       KVM: PPC: Book3S HV: Ensure that calls to idr_alloc are synchronized
       KVM: PPC: Book3S HV: XICS: Update irq_type for cleanup to work
       KVM: PPC: Book3S HV: XICS: Avoid NULL ptr deref in 
kvmppc_xive_cleanup_vcpu()
       KVM: PPC: Book3S HV: Take SRCU read lock around 
kvmppc_h_page_init() call
       KVM: PPC: Book3S HV: Avoid spurious interrupts caused by LPCR_MER bit

Jiale Yao (1):
       powerpc/eeh: NUL-terminate force recovery input

Luiz Capitulino (Red Hat) (1):
       powerpc/watchdog: disable watchdog when watchdog_thresh=0

Mohammad Shahid (1):
       powerpc/perf/vpa-dtl: use GFP_ATOMIC for DTL buffer allocation

Nathan Chancellor (1):
       powerpc/smp: Handle of_property_count_u32_elems() error in 
parse_thread_groups()

Sasha Levin (1):
       selftests/powerpc: override EMIT_TESTS instead of the emit_tests rule


  arch/powerpc/kernel/eeh.c                    |  6 ++--
  arch/powerpc/kernel/module_32.c              |  3 ++
  arch/powerpc/kernel/smp.c                    |  2 ++
  arch/powerpc/kernel/watchdog.c               |  3 ++
  arch/powerpc/kvm/book3s_64_mmu_hv.c          | 33 +++++++++++++++++--
  arch/powerpc/kvm/book3s_hv.c                 |  4 ++-
  arch/powerpc/kvm/book3s_hv_nested.c          | 34 ++++++--------------
  arch/powerpc/kvm/book3s_xive.c               |  5 +--
  arch/powerpc/perf/vpa-dtl.c                  |  2 +-
  arch/powerpc/platforms/pasemi/pasemi.h       |  6 ++++
  arch/powerpc/platforms/pasemi/pci.c          |  5 +++
  arch/powerpc/platforms/pasemi/setup.c        | 12 +++----
  tools/testing/selftests/lib.mk               |  6 +++-
  tools/testing/selftests/powerpc/Makefile     |  3 +-
  tools/testing/selftests/powerpc/pmu/Makefile |  3 +-
  15 files changed, 84 insertions(+), 43 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEqX2DNAOgU8sBX3pRpnEsdPSHZJQFAmr9AScACgkQpnEsdPSH
ZJQ+fw/9EpxF83GtdFyyKaWVVpf2a6xEUURBMNJ0L84BK29xx3kWp2fRvIiGo9dz
4koXN6OtNwerai3seOa8+B7ZEyIQ+O5oPENomGl/hYKLGWZXuMFmnF6WvOcTsRYP
RHGO4WPuZTYVr9IwCQG1XIbDJ8yU0KRySXMTf5mmv4FRP8HZ//V4HhQojNu5vZW5
sTzN5T3AbtHAxPvtIA2UNHLvfEzV+4FQ1UgR5EMswUM9uv+ssU0FZWO1U34bPw/I
1Kw0wbWFvR1KvMtzChbcNOagwoQU3TPZ5BuCrkFHRb1imGSVKC5RLs6PtTT2BGd2
cBmODItuF7Jnz1SfylgrPlKMBwi0PMEQNqC3i0sE4/WYM9Q1Ueqdb9D+FwxNf9pG
qE+gWn7fdQ2vva98WbJ8Xuhuug4kbLJaIwpVry/Nr024UZknflU5Ivk/kezBT47p
jDog/bPQ0PhTsFfOzyweSzAHrQaBByQgxaOikld62vjSULAyxsKxCcQ+cFbsvNW6
rlWFV4ritXf9fcJZOcuS0SJaNon0Q0tTxK7mADQk0Ez6wmXlq0T/AgwyDV9d4OHo
q6xVrrYf9JbG7jzzu76MhWaZ/aZY8t9ckvxqtdGVvFmkO3hUJrvVgX1xuQBr2HOW
M1sG8qYlqoHhyKcEXn0iGpSCxHFkA/ca0IuGOu0aK3IabIBxEm8=
=wO8j
-----END PGP SIGNATURE-----

