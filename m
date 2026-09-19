Return-Path: <linuxppc-dev+bounces-27783-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E938CC982CC
	for <linuxppc-dev@archiver.kernel.org>; Sat, 19 Sep 2026 13:39:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hn9b03x59z2xST;
	Sat, 19 Sep 2026 23:39:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789808422;
	cv=none; b=diLlGbTV0BPHHDD9f6rl0qloJYB7a4AQ/TBBYLME67+T0UEw2Im7gEEgdTDiiGnMKISDBPE+H+dN8wIW2l7KSw1jlDJ+fc0ABzWG/S8rrWSv0jpIUgrLBU9kHXM2SxCFDE9/V1TudYPY06bcjAhunySP/pLVItHplLOYTsGSmhs8k7GshwgBauBog2wKU+V03WY11aSYcof+DdMOvQHV8UmbNoLIC6uY6xSbMtL+ieOiWazuwosiCcoA26laTEhkWN9A4AemCY793DtZzjucu4AxWp3flG3Rl094VzlvMoZrDlgWp6fOLdXOKI6LegEVUFhKX7jrU9vPFid8V9dxYg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789808422; c=relaxed/relaxed;
	bh=0Xaks4xNJdIstXbVmfi6R5OkPxFifTAt3YNQLEMR7iQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EisA1w5DstqZQLrxIwgVY7Vy6B2uc4co+aCZ6yVNEgwPBdvPQtcQaMoV5zrU7XquEyatWXuzYlHOBGYIyisBmBq3aMpMGHqWGmKn8VWMYdGcgKwfG1BQo+ADDtRixz04PkfxGAY2hzdExE2IbQVy1CbcXtqFMRHketLCwIu9QGF+Ui9ipRPri7OV/FEVtKFxPc3I7qvwzV8+g/EZEaaDHhF6sTyr5yA7jDfncBijkWAJR0h+nY2wIbqi/vN0bAZl29tO9Oq11OgKboG7qXzW6giXOCTuIijQ+C8LaPp8xjqIP+HhGsus/FFpG4GL4SMin7T7YIwx658K24Ajf56MzQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=rFzzeqAh; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=anushree.mathur2@ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=rFzzeqAh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=anushree.mathur2@ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hn3Nj4BDSz2xJJ
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Sep 2026 19:00:20 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68J75VL63331651;
	Sat, 19 Sep 2026 09:00:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=0Xaks4
	xNJdIstXbVmfi6R5OkPxFifTAt3YNQLEMR7iQ=; b=rFzzeqAhEAsq2zl0U1TWkk
	4GaeqjlbXuApmGmaiT/f7osX2kA5Af2BRqpEPFOojof2rRSPzAo3xgtfFGBMbbVK
	J+omGGTRH5pzmTWfsZv969FIssg7HXocKzb5UwWBZ7qIZ+9TTcvpAP0Ca0gKeUNh
	dpgwCXentca7k7pvclX7HJXU6HR0A17gkM3u7yEBXmRrlclTfPBhT3u74hrGEEnG
	ihJ4lOYucOTv3cs/+IVNyr9ft5xzo0+eGEycOwHiPZVaMoZGkX96TKRdd6q1sB6H
	Tw7u3OQtEw6XpD69GKch+Mx1SKIOUQpaCQIh50hiGS8qZLHEFQuzPph7DevtyeQA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske10n4j-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 19 Sep 2026 09:00:00 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68J6lZok2008179;
	Sat, 19 Sep 2026 09:00:00 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gsk3ggpqs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 19 Sep 2026 09:00:00 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68J8xxfu17957610
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 19 Sep 2026 08:59:59 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E6A685805C;
	Sat, 19 Sep 2026 08:59:58 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4CB5D58058;
	Sat, 19 Sep 2026 08:59:54 +0000 (GMT)
Received: from [9.61.240.148] (unknown [9.61.240.148])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
	Sat, 19 Sep 2026 08:59:53 +0000 (GMT)
Message-ID: <edbbfb46-53c7-4fc2-b9ea-c0676479fc47@ibm.com>
Date: Sat, 19 Sep 2026 14:29:51 +0530
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
Subject: Re: [PATCH v4 0/3] KVM: selftests: add powerpc support
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <chleroy@kernel.org>,
        Anushree Mathur <anushree.mathur@linux.ibm.com>,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
        Harsh Prateek Bora <harshpb@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <cover.1789097569.git.ritesh.list@gmail.com>
Content-Language: en-US
From: Anushree Mathur <anushree.mathur2@ibm.com>
In-Reply-To: <cover.1789097569.git.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: nbyZhj10j4HSmrVirrZNE6vYozTVfAlN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE5MDEyMiBTYWx0ZWRfXxHeZ/+jmKAxM
 TnHQO+FYUGAQisd8y/YAHMCF+AnkWE/Hn3MYQOlLLQ/0fNJmZs7zzkYc54A0y9xoYQs+5DJBAHo
 t/Fx48Qk9J8zM7F6kNdSGQ5JqCDs7xiR96NMkJgLvTikLJka8PHvu6EXp1L8GZgO8zR98m2cgTX
 raOh09zdwtzxRvS6hdCKBAXCjfWsU/h1AbvrgXY4oPkR5wrRkKM6fE0fdUMWF1lMi0kKhBDDKVv
 r7bVE78ZCGn+oq/E6Osov7skyp1pLhpA1qRgcSiwm7I0e17VWKslyDyvWEcTdMwPpQjGa81VU1w
 I/2AvDjza84607aNlslcnNhYHLWXXxA7kStfk+OIoCDbIfZMu3BcjgTYrmdOu06aXcGR4NZRZyy
 jkj2smXFtu5BQn3q232wTc2gnrfCG0UuZdK5RBq3ce8o9a3V3uxeAoCc1suyYD6NMz49fZ0+PQn
 M88URShiUyFA9IlQePw==
X-Authority-Analysis: v=2.4 cv=O/KsLx9W c=1 sm=1 tr=0 ts=6aae4f11 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=1XWaLZrsAAAA:8 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=slw3on1wiaYrNECQpKkA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE5MDEyMiBTYWx0ZWRfX9+bf4muBJ1HJ
 u7hAP0Qz9BFYBzr8+Qd6F6QBXyuVoRIM/PyXz1mxxI6LUCGYcKg9hsxX9i+cDWzKUJO9epQ4Olq
 VcJnLlIGu9WM1dDLwVbD+/DxYtmdLf8=
X-Proofpoint-GUID: BlFKGXdZLDZzyN2VUSB3kEmvHnNTbQy8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-19_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609190122


On 11/09/26 10:18 AM, Ritesh Harjani (IBM) wrote:
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
> Nicholas Piggin (1):
>    KVM: PPC: selftests: add support for powerpc
>
> Ritesh Harjani (IBM) (2):
>    KVM: PPC: selftests: powerpc enable kvm_create_max_vcpus test
>    KVM: selftests: Use LE bitops for dirty bitmaps on all big-endian
>      hosts
>
>   MAINTAINERS                                   |   2 +
>   tools/testing/selftests/kvm/Makefile          |   2 +-
>   tools/testing/selftests/kvm/Makefile.kvm      |  10 +
>   tools/testing/selftests/kvm/dirty_log_test.c  |  12 +-
>   .../testing/selftests/kvm/include/kvm_util.h  |   9 +
>   .../selftests/kvm/include/powerpc/hcall.h     |  17 +
>   .../kvm/include/powerpc/kvm_util_arch.h       |  22 +
>   .../selftests/kvm/include/powerpc/ppc_asm.h   |  32 ++
>   .../selftests/kvm/include/powerpc/processor.h |  39 ++
>   .../selftests/kvm/include/powerpc/ucall.h     |  21 +
>   .../selftests/kvm/kvm_create_max_vcpus.c      |   8 +-
>   tools/testing/selftests/kvm/lib/guest_modes.c |  20 +-
>   tools/testing/selftests/kvm/lib/kvm_util.c    |   8 +
>   .../selftests/kvm/lib/powerpc/handlers.S      |  93 ++++
>   .../testing/selftests/kvm/lib/powerpc/hcall.c |  45 ++
>   .../selftests/kvm/lib/powerpc/processor.c     | 512 ++++++++++++++++++
>   .../testing/selftests/kvm/lib/powerpc/ucall.c |  22 +
>   17 files changed, 862 insertions(+), 12 deletions(-)
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
Hi Ritesh,
Thanks for working on this enablement. I have tested kvm selftests after 
applying this patch on top of Sean's patch as mentioned and even I 
applied this patch for the kvm_create_max_vcpus issue as rc=-56 
"https://lore.kernel.org/linuxppc-dev/cover.1789099725.git.ritesh.list@gmail.com/" 
But still few tests got failed. Providing a summary below:

System details where I tested this : PowerVM P11 (ppc64le) KVM enabled lpar!

Test Results:
=============

PASS: demand_paging_test
PASS: dirty_log_test (dirty-log mode, 4K + 64K pages, 32 iterations)
PASS: guest_print_test
PASS: kvm_binary_stats_test (4/4 subtests)
PASS: kvm_page_table_test (4K + 64K pages)
PASS: set_memory_region_test
PASS: memslot_modification_stress_test (4K + 64K pages)
PASS: memslot_perf_test
PASS: dirty_log_perf_test (4K + 64K pages)

SKIP: irqfd_test
   - kvm_arch_has_default_irqchip() not yet implemented for PowerPC

SKIP: vm_types_test
   - KVM_CAP_VM_TYPES not supported on PowerPC

Failures seen for the following tests

FAIL: kvm_create_max_vcpus
   - RFC patch-3 partially helps: KVM_CAP_MAX_VCPU_ID correctly
     capped from 16384 to 2048.
   - But vCPU creation still fails with rc=-44 below the 2048 limit.
   - dmesg: KVM: Create Guest vcpu hcall failed, rc=-44

for the above test in dmesg I saw the following error everytime I ran 
this test

dmesg -w
[ 2640.213798] KVM: Create Guest vcpu hcall failed, rc=-44
[ 2923.048989] KVM: Create Guest hcall failed, rc=-44
[ 3650.642771] KVM: Create Guest vcpu hcall failed, rc=-44

FAIL: hardware_disable_test
   - KVM_CREATE_VM fails with ENOMEM
   - dmesg: KVM: Create Guest vcpu hcall failed, rc=-44
   - Likely the same underlying hcall issue as kvm_create_max_vcpus.

FAIL: access_tracking_perf_test
   - Too many idle pages (245385 out of 262144)
   - errno=4 (Interrupted system call)
   - page_idle tracking may not be fully supported on PowerPC yet.


I believe these issues might be real kernel issue. If you plan to send 
fixed please feel free to add my Reported-by:

Reported-by: Anushree Mathur <anushree.mathur@linux.ibm.com>

Thank you,
Anushree Mathur


