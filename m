Return-Path: <linuxppc-dev+bounces-17964-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32A5FFD2D81
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Mar 2026 13:46:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fVZtR3S88z3bjb;
	Wed, 11 Mar 2026 00:46:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773150415;
	cv=none; b=VMGe5VnBBk56uUzYa8QJkRVAw5L7gmhX4QoWXfVaV7Sz/OmmgZIIZEUPHOPXyV7qZ3pm+2UR0J5fz/1hPZB+tPRndkWFdh9UqDrrAhCDn3wCVp0Al8+RLkd+cTFL2OzRGJ/Nn6Vr9n8vsfugTHtce318LKOd7REJvFhy7INc32o2kgCyIk/V1lUhGp/lZkRe4Dqc1aW50dQCeEc3mTLityi5XhHaZTU+lRn9pCtmIzPBGX9TpD6c55uHrM8agUlfBkNuaYPaQEOhzbj38FSgmz7ALXlTr8IbGiDqK/P1a9NbIkXwQhrEHb7B0bg4I2Q6ciFzdnnsCGMhvYaRA/wUPw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773150415; c=relaxed/relaxed;
	bh=+r1/kWU/ZhoiFi0HIKuxYURswD1WxrctwpOtF8ptAWc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ColQNuxFpErpgdN1CDRHMsEhiXe/dpjOP6kNvOY9hVKK/Huu5GkG/uQJDmqN0GC79GThqNYfPDeY3UkmzeYchW/yDgsoTfFpRMVsIxqACDKIithKLmTGLo0u7zSesQi1NSsV4cKiQJYVMLDl/tGPmt5c2Q03GOtv1Te+owZ+t4DZJmfuE9as85jupfuDajvp47a1O7A2hr8hi8KmsDKye5XGJNOzuw46LaTa1EkvyUDAsmEY4M4036hycmVjmav3ZKqVFfQK00/iy9iSMUOdj9h59y2oaJghbLul8zjcLQGoM7iLqnh9KESDvUrd2ewOseyPONTvxCcbf6smb26y+w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=lQFEzD3d; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=lQFEzD3d;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fVZtQ0qx9z30Lw
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2026 00:46:53 +1100 (AEDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62A9B1KU1597685;
	Tue, 10 Mar 2026 13:46:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+r1/kW
	U/ZhoiFi0HIKuxYURswD1WxrctwpOtF8ptAWc=; b=lQFEzD3dieKGkGmdvSLLPt
	QJo7Fe4lLUnv5o1eLiY5o/+u3s9z0iMsgssnDmBOgNwLDZo1mVy8jVpu7VMwJcYp
	okhAAlSaH5dr+VSUWGbRMteRFvR8gaAw0MRO6POBxGZUaxSEI2WqEBun253bvYWO
	0E0BvyXta2nYwL51k2vtCy2GMn84X/f2b1aOZqlfrZ+EdXxf977/PltVk7hy/AXI
	hxz2csi4VIxu7ANcdo+sQ9f6z2Bo5Y7jXUF39uzyGLNNzMgjt/hVHkKkisHXByLN
	hVkJqYzVGZSpdPyzfMs5rn5U8LsPyVzBjDbIQoEoLdKM+xQxW23nF3C6nngOh49A
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcunaseq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Mar 2026 13:46:47 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62AAt39g029306;
	Tue, 10 Mar 2026 13:46:47 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4csp6unxd1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Mar 2026 13:46:47 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62ADkj2W26477080
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Mar 2026 13:46:46 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A94DD58045;
	Tue, 10 Mar 2026 13:46:45 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EA93958050;
	Tue, 10 Mar 2026 13:46:42 +0000 (GMT)
Received: from [9.61.246.162] (unknown [9.61.246.162])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 10 Mar 2026 13:46:42 +0000 (GMT)
Message-ID: <f42fc693-b5be-4b3f-9bb2-7aab5b8bc599@linux.ibm.com>
Date: Tue, 10 Mar 2026 19:16:41 +0530
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
Subject: Re: [PATCH v2 00/10] Misc powerpc selftests kernel fixes and cleanups
Content-Language: en-GB
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
        Christophe Leroy <chleroy@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Sayali Patil <sayalip@linux.ibm.com>,
        Aboorva Devarajan <aboorvad@linux.ibm.com>,
        Donet Tom <donettom@linux.ibm.com>
References: <cover.1773078178.git.ritesh.list@gmail.com>
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
In-Reply-To: <cover.1773078178.git.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: KyIzHA5ToXL8i1f1QzSFVYBzTmtWQOI4
X-Authority-Analysis: v=2.4 cv=Hp172kTS c=1 sm=1 tr=0 ts=69b020c8 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=OD7_wTj3uD1QJsR5MugA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDExOCBTYWx0ZWRfX6p1rhjmUAOiJ
 2s65X+CYU08hiG6bS+Bbnl37Xh0qr58YYFxZa4VPazzceU4jC08+UVBnSv5gMAh7L4P5+xfc918
 PfSODKrxuREQ7pyUpYDPJX7ZIL55aq1Y9Ah59wsoRWCJyhIDlAir7iyM+6uWLDOiISt8SfHsCCT
 QDTasTBvSjuo86en9OxckCwpSWPU4SE5yg8Dl5Q9DKUNpgKo6yJU8kZG8BAlmHvQs4dPLvS5ELR
 KdqhgW+Tj0bYcPpLS59h+fTSGKPwA6weC3HTSUiTBz8KCKoX0XCFta+CyWmRNFgghT7Tpn80v8P
 RhX7tRHZKazwI71XCt7b02Zfo4jKqajpiWa/1q5kRK432EgUdbZteTNn55bWOyAPTJ/kU/FyWJc
 6X2VyfmvvB9giLCT/I8WRfvdesiuIfzsWU/tI6ZN+2NEMXR6vIJ2vQ8Hn35kwsjpPtNsi94B997
 IuOiSCtxFMq0NlHTVTA==
X-Proofpoint-ORIG-GUID: 0ueR_sQNWBE3hRoD0l-dHFAgfsaUhL7j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100118


On 09/03/26 11:44 pm, Ritesh Harjani (IBM) wrote:
> v1->v2:
>
> - dropped debug_vm_pgtable patch which adds a testcase to simulate the
>    failure scenario. Since it belongs to linux-mm, I will send that out
>    separately.
> - Modified Patch-2 in this series to also cover PMD device migration
>    entry (in addition to PMD THP migration entry). Hence dropped the
>    previous RB tag.
> - Added a new Patch-3 to fix another selftests WARNING.
> - Fixed commit subject of Patch-10.
> - Changed subject pre-fix of few patches to be consistent with others
>    (powerpc/64s)
> - Added RB tags
>
> This patch series addresses selftests issues w.r.t warnings or
> VM_BUG_ONs seen mainly on book3s64 powerpc kernel. This also carries
> cleanups and refactoring changes which I identified while reviewing
> other's patches and/or during code walkthrough.
>
> Suggestions and feedback are welcome!
>
> Ritesh Harjani (IBM) (10):
>    powerpc/pgtable-frag: Fix bad page state in pte_frag_destroy
>    powerpc/64s: Fix unmap race with PMD migration entries
>    powerpc/64s: Fix _HPAGE_CHG_MASK to include _PAGE_SPECIAL bit
>    powerpc/64s/tlbflush-radix: Remove unused radix__flush_tlb_pwc()
>    powerpc/64s: Move serialize_against_pte_lookup() to hash_pgtable.c
>    powerpc/64s: Kill the unused argument of exit_lazy_flush_tlb
>    powerpc/64s: Rename tlbie_va_lpid to tlbie_va_pid_lpid
>    powerpc/64s: Rename tlbie_lpid_va to tlbie_va_lpid
>    powerpc/64s: Make use of H_RPTI_TYPE_ALL macro
>    powerpc: Print MMU_FTRS_POSSIBLE & MMU_FTRS_ALWAYS at startup
>
>   arch/powerpc/include/asm/book3s/64/pgtable.h  | 20 +++++-
>   .../include/asm/book3s/64/tlbflush-radix.h    |  1 -
>   arch/powerpc/kernel/setup-common.c            |  4 ++
>   arch/powerpc/mm/book3s64/hash_pgtable.c       | 21 +++++++
>   arch/powerpc/mm/book3s64/internal.h           |  2 -
>   arch/powerpc/mm/book3s64/pgtable.c            | 40 +++---------
>   arch/powerpc/mm/book3s64/radix_tlb.c          | 61 ++++++++-----------
>   arch/powerpc/mm/pgtable-frag.c                |  1 +
>   8 files changed, 79 insertions(+), 71 deletions(-)
>
Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>

I applied the patch series on top of mainline and verified that the kernel
builds and boots successfully.

I also ran the following test suites on both RADIX (POWER11) and HASH 
(POWER9)
MMU configurations:

   - tools/testing/selftests/mm
   - tools/testing/selftests/memory-hotplug
   - tools/testing/selftests/powerpc/mm
   - tools/testing/selftests/powerpc/cache_shape
   - tools/testing/selftests/powerpc/copyloops

In addition, I executed basic sanity and stress tests, including:
stutter, eatmemory, hugepage_sanity, fork_mem, memory_api mprotect,
vatest, and several transparent-hugepage sanity checks.

All tests passed without regressions.

Regards,
Venkat

