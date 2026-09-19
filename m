Return-Path: <linuxppc-dev+bounces-27784-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98BA2C982CC
	for <linuxppc-dev@archiver.kernel.org>; Sat, 19 Sep 2026 13:47:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hn9lz65YYz2xYg;
	Sat, 19 Sep 2026 23:47:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789808602;
	cv=none; b=kMI8fZU9sNOYlO38W38j8eLtwsXGqYyVPXgNayRl31YRicDj4WpO3xxFjJuQ9xCygDT1ziO/uxDGmTWCp4PUIiCZh8s2PJ1Wgd9vlxnGEWuFcl2+k2Liu18fbDZxk5pdGx4IAh3gAOzc5/91/3gTiS1WIA5xFPd7As9k3dbCzRvbo88pJXJYTiDFpD6KCmeHLg9hw/auLOhHRnyhjDimbj+29aNPiswLz55/lZdudk95JpTQRY4Td/lNaAMJFc+UYg3Jxk3vxzQUFp0omz7db702wuauhm2u8tSVfVdX36ViCBXR89BPJIfKvG2rBjtBjzLkQVD0UM+PolhXVFmhdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789808602; c=relaxed/relaxed;
	bh=nwstIVpgPU5fGdnMm71IxbWqi0Y0oEWw+0hRDoe6eu8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=br2Kq1VLmwpFM/TvErhFAH2vlEYpsjaPBF6DELUOf+rfh6ndvpxSQWLzrwztZfrOmdO09krDVeWkWOkBd8cMtUNzC3A+Epvsy4wla8+H1GjzgEDiqmuO7n9sVFUB2jWjjCiWx1B/mwtO8wwXPZfzMAxAdjIZ7TzoETL5RK/3pQ8fLNywuMw+aQUX5cmudG9erjNY7oSepzKuT46mWqzzNd360GFSLltGEZLOzpuEnOdTE+Pj6bl22bx1xrz3R/NGyWCCQyPpfQkkfeirQseffK59h+1uB0c+yiMn3DFD3CVTIBmo50+chxyPleGfX8MMouyyo0zvp5BupAUrtrjxww==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fKmO1RSb; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=anushree.mathur2@ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fKmO1RSb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=anushree.mathur2@ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hn3S92t9qz2xJJ
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Sep 2026 19:03:21 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68J75kGw2314674;
	Sat, 19 Sep 2026 09:03:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=nwstIV
	pgPU5fGdnMm71IxbWqi0Y0oEWw+0hRDoe6eu8=; b=fKmO1RSbiGipvzt+wNl56D
	iKMNJKIQb5cGyjeoR1Tk8qRkFPvnV39F3e6ZgNIcNuPVEF2wzO0/DIRa9wTISUlF
	l0jD1Fpfk9hD48uWQMYHa5bb6n7+Sl57iyuMTQiKGIhr0Gg47LhHpeo1NZ2A6LZm
	U6RBSb++BwCa1eas5tjYqDZ0h2+4g9ea3wMrJ4+zFOQPhGjtmkSPQRQCYYMF83nu
	R69Zq3rSw1kUmhEoTenulrAtQrh0bVXyyf9kzQiq64IAnN7EqS2R3doIptwu66Qw
	5KJvy+dDTilUMc8YLJlHTyAyA4Ff4xmT6XqwLA2+G8wHZtaBq6B06/uqSjIiev1g
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgq0ms7-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 19 Sep 2026 09:03:10 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68J6lUAJ1933827;
	Sat, 19 Sep 2026 09:03:10 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gsjym0s61-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 19 Sep 2026 09:03:10 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68J939tH59245052
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 19 Sep 2026 09:03:09 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E817858059;
	Sat, 19 Sep 2026 09:03:08 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5D68158058;
	Sat, 19 Sep 2026 09:03:04 +0000 (GMT)
Received: from [9.61.240.148] (unknown [9.61.240.148])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
	Sat, 19 Sep 2026 09:03:04 +0000 (GMT)
Message-ID: <0d3d7fe2-deda-4caa-8237-f8f4efc6483b@ibm.com>
Date: Sat, 19 Sep 2026 14:33:01 +0530
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
From: Anushree Mathur <anushree.mathur2@ibm.com>
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
 <edbbfb46-53c7-4fc2-b9ea-c0676479fc47@ibm.com>
Content-Language: en-US
In-Reply-To: <edbbfb46-53c7-4fc2-b9ea-c0676479fc47@ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=G+OJgNk5 c=1 sm=1 tr=0 ts=6aae4fcf cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=1XWaLZrsAAAA:8 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=Peq01IYdYfpa89gBVw0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE5MDEyMiBTYWx0ZWRfXxi1yy4rvAVBm
 093bcaJtyBIFgim24urK0NOwi6okzOxy/SK37HqmGS8OTaNuvz7LcQd6DjYZuB1NehrBmATs+kr
 yDGUS7bS3zCpGLWWMxLCWRIvDptyZwpDDM8T3kDqbUJObXfD+ALkBUMTITIMUldV28PCNlcyIyc
 4NSJU119/ninF8uId6uv55eyuJG5ipPiuJIIiv+exaPuqNMc1QrcU7ZdgzR+tmpM8lIWw9/R7tM
 gIhkIk5UtI2if+1RJtrxUJiu2L24kWFnOLbcscT/S6G+L0ZW6HgR6rUXZYN6v9R11omqMPOBDM/
 WmZBTtvaRtW5Vb/mtFBTJ4CG/ErWdg0fPjAyUj/9iAmpa351Yf7wYzo8a8O7c+bu+VFrgjahKdI
 ROent5ZrYvSKMp4H2M3ErhLVS4mw6NdLwhspSMW1NCC8sOp+KKm3X1PPWMSWPLP7AtsA9wVMkYX
 o/mliV3xo67ZWQVkj2g==
X-Proofpoint-ORIG-GUID: 5xLPe1jobdVw3JyHLTxTgRszxWpaiI7J
X-Proofpoint-GUID: N2YXDqDQKrpKiJ1o_KKNEktCUtXw_sFR
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE5MDEyMiBTYWx0ZWRfX44cc/bplIYPT
 O8ODgu/9G/CljxsUWKSWb6aIdDIMyzmys35Jjm/5je2wXHfZJ/Dtd8maTOx9FK6d0buNRO6WDGd
 07W5t0+7ixHjTAqZWqkTe/eFLmPFosU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-19_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 clxscore=1011 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609190122


On 19/09/26 2:29 PM, Anushree Mathur wrote:
>
> On 11/09/26 10:18 AM, Ritesh Harjani (IBM) wrote:
>> PATCH v3 -> PATCH v4:
>> ==================
>> - Rebased on top of Sean's new page allocator patch series v2 [1]
>>    This allowed to drop and patch-2 since it will now come from Sean's
>>    v2.
>> - Addressed review comments from Sean - squashed patches 6-10 in 
>> patch-1 of
>>    this.
>> - Dropped patch-5 to print vcpu_id when KVM_CREATE_VCPU ioctl fails.
>> - Added additional patch-3 to this series to allow dirty_log_test to 
>> run on all
>>    big-endian machines.
>>
>> [1]: 
>> https://lore.kernel.org/kvm/20260902164123.2546762-1-seanjc@google.com/
>> [v3]: 
>> https://lore.kernel.org/linuxppc-dev/2d2c46be7f051c7f1c645afaec67f57067d37a81.1781093720.git.ritesh.list@gmail.com/
>>
>> Testing updates:
>> ================
>> I have done some fair amount of testing of the selftests both on real 
>> HW and
>> using various combinations on qemu (powernv+LE (default), 
>> pseries+cap-nested-hv,
>> pseries+cap-nested-papr, powernv+BE). There were few powerpc kvm 
>> kernel fixes
>> which were identified as part of this work. I will send those patches 
>> separately
>> as those anyway needs to go in separately.
>>
>> <pasted snippet of cover letter from previous versions>
>> =======================================================
>>
>> Hi All,
>>
>> This series primarly adds KVM selftests support for powerpc (64-bit, 
>> BookS,
>> radix MMU).
>>
>> This patch series is originally Nick's work. I have mainly only 
>> rebased it on
>> the latest upstream tree. Since the rebase required few changes to 
>> all the four
>> patches (Patch 1-4), I have dropped the earlier Acked-by from Michael 
>> Ellerman.
>>
>> Since the last series was posted three years ago [1], I am resetting 
>> the version
>> to RFC. This rebase was done as part of a larger effort to improve 
>> the selftests
>> infrastructure for Linux on PowerPC tree. Thanks to Harsh and Maddy 
>> for their
>> help on this.
>>
>> Nicholas Piggin (1):
>>    KVM: PPC: selftests: add support for powerpc
>>
>> Ritesh Harjani (IBM) (2):
>>    KVM: PPC: selftests: powerpc enable kvm_create_max_vcpus test
>>    KVM: selftests: Use LE bitops for dirty bitmaps on all big-endian
>>      hosts
>>
>>   MAINTAINERS                                   |   2 +
>>   tools/testing/selftests/kvm/Makefile          |   2 +-
>>   tools/testing/selftests/kvm/Makefile.kvm      |  10 +
>>   tools/testing/selftests/kvm/dirty_log_test.c  |  12 +-
>>   .../testing/selftests/kvm/include/kvm_util.h  |   9 +
>>   .../selftests/kvm/include/powerpc/hcall.h     |  17 +
>>   .../kvm/include/powerpc/kvm_util_arch.h       |  22 +
>>   .../selftests/kvm/include/powerpc/ppc_asm.h   |  32 ++
>>   .../selftests/kvm/include/powerpc/processor.h |  39 ++
>>   .../selftests/kvm/include/powerpc/ucall.h     |  21 +
>>   .../selftests/kvm/kvm_create_max_vcpus.c      |   8 +-
>>   tools/testing/selftests/kvm/lib/guest_modes.c |  20 +-
>>   tools/testing/selftests/kvm/lib/kvm_util.c    |   8 +
>>   .../selftests/kvm/lib/powerpc/handlers.S      |  93 ++++
>>   .../testing/selftests/kvm/lib/powerpc/hcall.c |  45 ++
>>   .../selftests/kvm/lib/powerpc/processor.c     | 512 ++++++++++++++++++
>>   .../testing/selftests/kvm/lib/powerpc/ucall.c |  22 +
>>   17 files changed, 862 insertions(+), 12 deletions(-)
>>   create mode 100644 tools/testing/selftests/kvm/include/powerpc/hcall.h
>>   create mode 100644 
>> tools/testing/selftests/kvm/include/powerpc/kvm_util_arch.h
>>   create mode 100644 
>> tools/testing/selftests/kvm/include/powerpc/ppc_asm.h
>>   create mode 100644 
>> tools/testing/selftests/kvm/include/powerpc/processor.h
>>   create mode 100644 tools/testing/selftests/kvm/include/powerpc/ucall.h
>>   create mode 100644 tools/testing/selftests/kvm/lib/powerpc/handlers.S
>>   create mode 100644 tools/testing/selftests/kvm/lib/powerpc/hcall.c
>>   create mode 100644 tools/testing/selftests/kvm/lib/powerpc/processor.c
>>   create mode 100644 tools/testing/selftests/kvm/lib/powerpc/ucall.c
>>
>> -- 
>> 2.39.5
>>
> Hi Ritesh,
> Thanks for working on this enablement. I have tested kvm selftests 
> after applying this patch on top of Sean's patch as mentioned and even 
> I applied this patch for the kvm_create_max_vcpus issue as rc=-56 
> "https://lore.kernel.org/linuxppc-dev/cover.1789099725.git.ritesh.list@gmail.com/" 
> But still few tests got failed. Providing a summary below:
>
> System details where I tested this : PowerVM P11 (ppc64le) KVM enabled 
> lpar!
>
> Test Results:
> =============
>
> PASS: demand_paging_test
> PASS: dirty_log_test (dirty-log mode, 4K + 64K pages, 32 iterations)
> PASS: guest_print_test
> PASS: kvm_binary_stats_test (4/4 subtests)
> PASS: kvm_page_table_test (4K + 64K pages)
> PASS: set_memory_region_test
> PASS: memslot_modification_stress_test (4K + 64K pages)
> PASS: memslot_perf_test
> PASS: dirty_log_perf_test (4K + 64K pages)
>
> SKIP: irqfd_test
>   - kvm_arch_has_default_irqchip() not yet implemented for PowerPC
>
> SKIP: vm_types_test
>   - KVM_CAP_VM_TYPES not supported on PowerPC
>
> Failures seen for the following tests
>
> FAIL: kvm_create_max_vcpus
>   - RFC patch-3 partially helps: KVM_CAP_MAX_VCPU_ID correctly
>     capped from 16384 to 2048.
>   - But vCPU creation still fails with rc=-44 below the 2048 limit.
>   - dmesg: KVM: Create Guest vcpu hcall failed, rc=-44
>
> for the above test in dmesg I saw the following error everytime I ran 
> this test
>
> dmesg -w
> [ 2640.213798] KVM: Create Guest vcpu hcall failed, rc=-44
> [ 2923.048989] KVM: Create Guest hcall failed, rc=-44
> [ 3650.642771] KVM: Create Guest vcpu hcall failed, rc=-44
>
> FAIL: hardware_disable_test
>   - KVM_CREATE_VM fails with ENOMEM
>   - dmesg: KVM: Create Guest vcpu hcall failed, rc=-44
>   - Likely the same underlying hcall issue as kvm_create_max_vcpus.
>
> FAIL: access_tracking_perf_test
>   - Too many idle pages (245385 out of 262144)
>   - errno=4 (Interrupted system call)
>   - page_idle tracking may not be fully supported on PowerPC yet.
>
>
> I believe these issues might be real kernel issue. If you plan to send 
> fixed please feel free to add my Reported-by:
>
> Reported-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
>
> Thank you,
> Anushree Mathur 

Here are some more detailed logs for the Failed selftests:

./kvm_create_max_vcpus
Random seed: 0x62af7ca
KVM_CAP_MAX_VCPU_ID: 2048
KVM_CAP_MAX_VCPUS: 2048
Testing creating 2048 vCPUs, with IDs 0...2047.

==== Test Assertion Failure ====
   lib/kvm_util.c:1388: vcpu->fd >= 0
   pid=3808 tid=3808 errno=12 - Cannot allocate memory
      1    0x0000000010008667: __vm_vcpu_add at kvm_util.c:1388 
(discriminator 18)
      2    0x0000000010004093: test_vcpu_creation at 
kvm_create_max_vcpus.c:32
      3    0x0000000010003c93: main at kvm_create_max_vcpus.c:59
      4    0x00007fffae42b4fb: ?? ??:0
      5    0x00007fffae42b77b: ?? ??:0
   KVM_CREATE_VCPU failed, rc: -1 errno: 12 (Cannot allocate memory)


./hardware_disable_test
Random seed: 0x7c401041

==== Test Assertion Failure ====
   lib/kvm_util.c:193: vm->fd >= 0
   pid=5544 tid=5544 errno=12 - Cannot allocate memory
      1    0x00000000100069cb: vm_open at kvm_util.c:193 (discriminator 3)
      2    0x000000001000b95f: ____vm_create at kvm_util.c:404
      3    0x000000001000c403: __vm_create at kvm_util.c:513
      4    0x0000000010004037: vm_create at kvm_util.h:1126
      5     (inlined by) run_test at hardware_disable_test.c:78
      6     (inlined by) main at hardware_disable_test.c:148
      7    0x00007fff95c2b4fb: ?? ??:0
      8    0x00007fff95c2b77b: ?? ??:0
   KVM_CREATE_VM failed, rc: -1 errno: 12 (Cannot allocate memory)

./access_tracking_perf_test
Random seed: 0x50130229
lru_gen: Could not open /sys/kernel/mm/lru_gen/enabled
Using page_idle for aging
Testing guest mode: PA-bits:52,  VA-bits:52,  4K pages
guest physical test memory: [0xfffffbfff0000, 0xfffffffff0000)

Populating memory             : 0.324930580s
Writing to populated memory   : 0.007850148s
Reading from populated memory : 0.008390886s

==== Test Assertion Failure ====
   access_tracking_perf_test.c:164: idle_pages_warn_only
   pid=5558 tid=5560 errno=4 - Interrupted system call
      1    0x0000000010004cdf: too_many_idle_pages at 
access_tracking_perf_test.c:164
      2     (inlined by) pageidle_mark_vcpu_memory_idle at 
access_tracking_perf_test.c:229
      3     (inlined by) vcpu_thread_main at access_tracking_perf_test.c:339
      4    0x000000001000f5f7: vcpu_thread_main at memstress.c:277
      5    0x00007fff822b8063: ?? ??:0
   vCPU0: Too many pages still idle (245400 out of 262144)

Thank you,
Anushree Mathur


