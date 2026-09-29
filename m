Return-Path: <linuxppc-dev+bounces-28471-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF530CA5FA1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Sep 2026 08:37:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvBPR1hPsz2xrL;
	Tue, 29 Sep 2026 18:37:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790671035;
	cv=none; b=Lo9i9QgQLtvzgzag9u9ajcjLhb4PHsL0bK9D7JTxTLoff/XjgQkr8Pp8dEscAtxfU0QR7hzyNPbEnoqlddw1ixpnsXmSQSZEfdEsWroxugai454zzdTsn43PJINpd4d6/WwOLas/KtgHXqjRZu3xeAdN3T9M36Pu+emTW6wLV1ky0BTvE6W8aNe/+fWdIeyD4sf6gJw3UPYwEgqGxTVsYiyXOFLgtbnjO14UX/Ckl8FUEZf3nWkgvv2Z8rnUyvUQ+SomU5mQyUBeMZ1ZpBexBeDhe+UkuQw0PoXNBW6XHjJgBBnQBvNarfMmZulOvR/KA3yglVCDjGhowdcJnw4yaw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790671035; c=relaxed/relaxed;
	bh=4vrzOyjPA7ldOtLXw/BE0uyKQpbgDMLRHa4qTUbBM6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J/e5TI/jPzsUyQK8lyTheFoFuA6ennH6KGtzLDJyd1yHYv42FaJRbcQpmiCWPYmq7jMWNCn7bBrpQxABbVcN2E30AGpH5Qgv9/RjhiMqKuo6YVXpBoHV3cfhuvbsF+RV5s7C4p+mUQLnLJLSyGFL0x7u5uqbljgsWv4Dj9STDjGqnuS1BKnL3vGLnIJC10OxRhsSREhFTXYtUc/dRngebUScJYSAMr/oGrpkJ5aE1HeqzgnPoALhfZmSKuSYfPJr16AfyYVQaemXsE5wtLnYOrqljuSXGVcGvdHHwrDuUBeIBRv4fL+0mhDr7R20Q9qEoO93ba6hGbo+DczJcSAKqg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=WerkkZ7Z; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=anushree.mathur2@ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=WerkkZ7Z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=anushree.mathur2@ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvBPQ3fzlz2xSV
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2026 18:37:14 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68T46e9d3047828;
	Tue, 29 Sep 2026 05:49:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=4vrzOy
	jPA7ldOtLXw/BE0uyKQpbgDMLRHa4qTUbBM6M=; b=WerkkZ7ZELXhhVLStIbDkh
	wleORl5HERR4FPHDir9ID0c1x1QSi0qKGvc4nrDmTynO2JUgTiGPKvQV3wO2o80W
	z7EjL0HCxAp1oPQzo7d8GybyeU8HtUwF7oRUPMChH2IeDN+3i0vGcLDQrQiEHrTH
	q5hNkadtvwqVY2FR5CoXStDil4wh6iUglmJUJmWT5UqZdEFYrZ2/e/v04egJj2NH
	Uh9y5btBMgkOBhL+9aRd1t+OJLvFVaLhkPpx0zl5bu8pmSvwW19xYKslmL6k6hjj
	uh8B2jeNkx3sr0P4QIAwNP2ZXt4MOE1/81b3B1XF9oEcGeQBLSfC6oJ7kr0PeAbw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5s55cte-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 05:49:45 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68T4HdKm1144180;
	Tue, 29 Sep 2026 05:49:44 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gxrrw8gxn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 05:49:44 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68T5nh3J34603332
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Sep 2026 05:49:43 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DC3AD5803F;
	Tue, 29 Sep 2026 05:49:42 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 44CFF58064;
	Tue, 29 Sep 2026 05:49:38 +0000 (GMT)
Received: from [9.39.21.128] (unknown [9.39.21.128])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 29 Sep 2026 05:49:37 +0000 (GMT)
Message-ID: <a911b4fa-0127-4e0c-b75f-faa4fcd4bb87@ibm.com>
Date: Tue, 29 Sep 2026 11:19:34 +0530
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
Subject: Re: [PATCH v5 0/9] KVM: selftests: add powerpc support
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>, linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy
 <chleroy@kernel.org>,
        Anushree Mathur <anushree.mathur@linux.ibm.com>,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
        Harsh Prateek Bora <harshpb@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, linux-kernel@vger.kernel.org
References: <cover.1790101179.git.ritesh.list@gmail.com>
Content-Language: en-US
From: Anushree Mathur <anushree.mathur2@ibm.com>
In-Reply-To: <cover.1790101179.git.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAyMiBTYWx0ZWRfX6b5v73kfCOIo
 zpmmFNA4z10EX7PyChu2HzYtphWRWRgLeRpasOMZMLT/TMChFm/XXOKnybpYpJ1Tr69Bq7TMPxJ
 oQSuqtQGut3lj4w2v+JWSFO+WPlFfwU=
X-Authority-Analysis: v=2.4 cv=HJ5WhYtv c=1 sm=1 tr=0 ts=6abb5179 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=1XWaLZrsAAAA:8 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=jOkkM83qFFQpFIJ7UXAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: RCTVYOR588ge0I1mOQSuemdjpKrNpuh1
X-Proofpoint-ORIG-GUID: SOuAjewg1uGhEhaYg9pyAKagCK0kRaQR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAyMiBTYWx0ZWRfXz30sp1MWA2on
 AnmZTm0jjPS0GMwArGoJOcZJLcSx76mCOFbxRTI0WhhP0DYPwR+a4eJ6nGhQHf4QM+5g1757ZQJ
 tgKxC8zbOsM7uyK6hyMW9d6On1XlJ1lfULnH1PT2umotSh46tltrLvS0+fXrNk4fbH3FTRkLpdr
 GTbRKKsHJUgjcSmV0XAzUQ7Gg91Hsh9HjOXDHmyMKv5SYtRFYZaz8coYFEb4o3zLoyUlcGYElkn
 p5rg4Z7DFRXfnuJtuWgdg0xatPhTgY9M7pEVXCnzcjbAoJ/ASPVO++875qY+LOD6q3JPjqAKdYt
 xEsJAK9fegnYHANwnxiygR91CO9q/gd/8cAwlUiW0wg8Of7COXTZcOVOKk1YDCHDAcZj3TwZXtP
 +6WVbTKQn8ivNGoCH3p1trHb7sx1cR+xclJO7+Y6AAZxF4cUcci1/iFmnHwHfeqY8OO9QqC+Oeo
 e3Ip1YgqpSBgZPGzSXA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290022


On 22/09/26 11:58 PM, Ritesh Harjani (IBM) wrote:
> Patch v4 -> v5:
> ==============
> - Fixed the issues reported by Anushree while running on kvm on powervm
>    (nested).
> - Fixed memslot_perf_test on powerpc.
>
> PATCH v3 -> PATCH v4:
> ==================
> - Rebased on top of Sean's new page allocator patch series v2 [1]
>    This allowed to drop and patch-2 since it will now come from Sean's
>    v2.
> - Addressed review comments from Sean - squashed patches 6-10 in patch-1 of
>    this.
> - Dropped patch-5 to print vcpu_id when KVM_CREATE_VCPU ioctl fails.
> - Added additional patch-3 to this series to allow dirty_log_test to run on all
>    big-endian machines.
>
> [1]: https://lore.kernel.org/kvm/20260902164123.2546762-1-seanjc@google.com/
> [v3]: https://lore.kernel.org/linuxppc-dev/2d2c46be7f051c7f1c645afaec67f57067d37a81.1781093720.git.ritesh.list@gmail.com/
>
> Testing updates:
> ================
> I have done some fair amount of testing of the selftests both on real HW and
> using various combinations on qemu (powernv+LE (default), pseries+cap-nested-hv,
> pseries+cap-nested-papr, powernv+BE). There were few powerpc kvm kernel fixes
> which were identified as part of this work. I will send those patches separately
> as those anyway needs to go in separately.
>
> <pasted snippet of cover letter from previous versions>
> =======================================================
>
> Hi All,
>
> This series primarly adds KVM selftests support for powerpc (64-bit, BookS,
> radix MMU).
>
> This patch series is originally Nick's work. I have mainly only rebased it on
> the latest upstream tree. Since the rebase required few changes to all the four
> patches (Patch 1-4), I have dropped the earlier Acked-by from Michael Ellerman.
>
> Since the last series was posted three years ago [1], I am resetting the version
> to RFC. This rebase was done as part of a larger effort to improve the selftests
> infrastructure for Linux on PowerPC tree. Thanks to Harsh and Maddy for their
> help on this.
>
>
> Nicholas Piggin (1):
>    KVM: PPC: selftests: add support for powerpc
>
> Ritesh Harjani (IBM) (8):
>    KVM: selftests: Enable kvm_create_max_vcpus test for powerpc
>    KVM: selftests: Don't limit LE dirty-bitmap bitops to s390x
>    KVM: selftests: Split out a KVM_CREATE_VCPU helper that can fail
>    KVM: selftests: Make kvm_create_max_vcpus tolerate ENOMEM
>    KVM: selftests: Limit the number of VM creates in hardware_disable_test
>    KVM: PPC: selftests: Make nested case on pseries LPARs as resource constrained
>    KVM: PPC: selftests: Skip idle-page check when running nested on pseries LPAR
>    KVM: selftests: Move memslot_perf_test off the 256M ELF load address
>
>   MAINTAINERS                                   |   2 +
>   tools/testing/selftests/kvm/Makefile          |   2 +-
>   tools/testing/selftests/kvm/Makefile.kvm      |  10 +
>   .../selftests/kvm/access_tracking_perf_test.c |  11 +
>   tools/testing/selftests/kvm/dirty_log_test.c  |  12 +-
>   .../selftests/kvm/hardware_disable_test.c     |   7 +-
>   .../testing/selftests/kvm/include/kvm_util.h  |  13 +
>   .../selftests/kvm/include/powerpc/hcall.h     |  17 +
>   .../kvm/include/powerpc/kvm_util_arch.h       |  22 +
>   .../selftests/kvm/include/powerpc/ppc_asm.h   |  32 ++
>   .../selftests/kvm/include/powerpc/processor.h |  46 ++
>   .../selftests/kvm/include/powerpc/ucall.h     |  21 +
>   .../selftests/kvm/kvm_create_max_vcpus.c      |  29 +-
>   tools/testing/selftests/kvm/lib/guest_modes.c |  20 +-
>   tools/testing/selftests/kvm/lib/kvm_util.c    |  39 +-
>   .../selftests/kvm/lib/powerpc/handlers.S      |  93 ++++
>   .../testing/selftests/kvm/lib/powerpc/hcall.c |  45 ++
>   .../selftests/kvm/lib/powerpc/processor.c     | 522 ++++++++++++++++++
>   .../testing/selftests/kvm/lib/powerpc/ucall.c |  22 +
>   .../testing/selftests/kvm/memslot_perf_test.c |   2 +-
>   20 files changed, 942 insertions(+), 25 deletions(-)
>   create mode 100644 tools/testing/selftests/kvm/include/powerpc/hcall.h
>   create mode 100644 tools/testing/selftests/kvm/include/powerpc/kvm_util_arch.h
>   create mode 100644 tools/testing/selftests/kvm/include/powerpc/ppc_asm.h
>   create mode 100644 tools/testing/selftests/kvm/include/powerpc/processor.h
>   create mode 100644 tools/testing/selftests/kvm/include/powerpc/ucall.h
>   create mode 100644 tools/testing/selftests/kvm/lib/powerpc/handlers.S
>   create mode 100644 tools/testing/selftests/kvm/lib/powerpc/hcall.c
>   create mode 100644 tools/testing/selftests/kvm/lib/powerpc/processor.c
>   create mode 100644 tools/testing/selftests/kvm/lib/powerpc/ucall.c
>
> --
> 2.39.5
>
>
Hi Ritesh,
Thanks for working on the fixes, I tested this series (v5) on top of 
Sean's pre-enabling series (v2) [1]
on two real PowerPC systems. All patches applied cleanly and the tests
work correctly on both PowerVM LPAR and PowerNV bare-metal.

[1]: https://lore.kernel.org/kvm/20260902164123.2546762-1-seanjc@google.com/



Full test suite summary (make run_tests):
-----------------------------------------
                                    LPAR    bare-metal
   demand_paging_test               PASS      PASS
   dirty_log_test                   PASS      PASS
   dirty_log_perf_test              PASS      PASS
   guest_print_test                 PASS      PASS
   hardware_disable_test            PASS      PASS
   kvm_binary_stats_test            PASS      PASS
   kvm_create_max_vcpus             PASS      PASS
   kvm_page_table_test              PASS      PASS
   set_memory_region_test           PASS      PASS
   memslot_modification_stress_test PASS      PASS
   memslot_perf_test                PASS      PASS
   access_tracking_perf_test        PASS      PASS
   irqfd_test                       SKIP      SKIP
   vm_types_test                    SKIP      SKIP
   --------------------------------------------------
   Total                         12 PASS   12 PASS
                                  2 SKIP    2 SKIP


Per-patch validation:
---------------------
Patch 1 [KVM: PPC: selftests: add support for powerpc]
   All 14 tests built and ran successfully on PowerPC — the core
   infrastructure (lib/powerpc/processor.c, handlers.S, ucall.c,
   hcall.c) works correctly on both systems.

Patch 2 [KVM: selftests: Enable kvm_create_max_vcpus test for powerpc]
   kvm_create_max_vcpus ran successfully on both systems.

Patch 3 [KVM: selftests: Don't limit LE dirty-bitmap bitops to s390x]
   dirty_log_test ran successfully on both systems for both 4K and
   64K page modes (big-endian dirty-bitmap bitops working correctly).

Patch 4 [KVM: selftests: Split out a KVM_CREATE_VCPU helper that can fail]
   KVM_CREATE_VCPU helper exercised by kvm_create_max_vcpus on both
   systems — clean failure path confirmed on LPAR (ENOMEM at vCPU 72).

Patch 5 [KVM: selftests: Make kvm_create_max_vcpus tolerate ENOMEM]
   LPAR:       Created 72 vCPUs before ENOMEM at id 72 — test
               completed gracefully without crash or assert.
   bare-metal: Successfully created all 2048 vCPUs — no ENOMEM hit.

Patch 6 [KVM: selftests: Limit the number of VM creates in 
hardware_disable_test]
   hardware_disable_test ran successfully on both systems without
   hitting OOM — VM create limiting working correctly on LPAR.

Patch 7 [KVM: PPC: selftests: Make nested case on pseries LPARs as 
resource constrained]
   access_tracking_perf_test correctly identified the LPAR as a
   resource-constrained nested environment and adjusted accordingly.

Patch 8 [KVM: PPC: selftests: Skip idle-page check when running nested 
on pseries LPAR]
   LPAR:
     Skipping idle page count sanity check, because the test is run nested
     [idle-page check correctly skipped on nested pseries LPAR]
   bare-metal:
     [No skip message — idle-page sanity check ran in full on PowerNV]

Patch 9 [KVM: selftests: Move memslot_perf_test off the 256M ELF load 
address]
   memslot_perf_test ran successfully on both systems — ELF load
   address conflict with PPC's 256M region resolved correctly.

Notes on SKIPs:
---------------
   - irqfd_test:   PowerPC has no in-kernel irqchip.
                   1..0 # SKIP - Requirement not met: 
kvm_arch_has_default_irqchip()
                   Pre-existing, unrelated to this series.

   - vm_types_test: KVM_CAP_VM_TYPES is x86-only (SEV-SNP/TDX).
                   1..0 # SKIP - Requirement not met: 
kvm_has_cap(KVM_CAP_VM_TYPES)
                   Pre-existing, unrelated to this series.


Please feel free to add :

Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>

Thank you,
Anushree Mathur

