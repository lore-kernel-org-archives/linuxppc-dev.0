Return-Path: <linuxppc-dev+bounces-26693-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1EDEC79F99
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Sep 2026 17:27:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hdvCT70yzz2xYg;
	Tue, 08 Sep 2026 03:27:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788802053;
	cv=none; b=JH4q4W0sr1dL/5j8FF1ixNAyQOkD63KAiUhtW3bbgYYwN1i3UpaGNtTeJUnESSzcEHj10ykEsH7g1zegSEETgyoL3s65o1J4YklBwe14uE1KK88mcjbtfINWxail6QWLZzalhWrnAsOfFpSYAkYtJFtW2++STnvi8LECNkDcWb/t8oNn/2UH4NLXCxdDd8ZpqREk8LdX1Un2oFwlqjzCrZyAJmSF+kBpkpD8tSNNUZwso5Sg3e8eYsZ+4lpRMnNqe/OyoII+Zjn+QHL2HfPAn9sy6JOWFDallE6Mv395QMPM0YfdYh0T0ZqZpa5tj2yBvh+739ATK2/bqDPDP9hZPw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788802053; c=relaxed/relaxed;
	bh=hhs5p1zJpM3bR2IGL3baC3tD1qlK1pM0VAN2fKfUc+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GwuE3jGPMNNSiJgs4eglzMPBUf0QhNMTLck/tmMpyYCllBipH+dcYnWMI+wUyWc0LMV0mN5GPc4OvW+iETp0qcTu4OG1p47kseOXb9j9HJdNRTjIu+BbmuUSW6tWTMigv71wLVIpWIR6BQT4YjukQPwS2jPjG2E7EpPSU4GwV0QK7QXX5b8aCfgZ2SfFfWhWaUV9EuHIPdJYuMCkP9JFnpefwIURLa6n2yNEe3lgDwzZqCyWfxTQsd9Owx4cbKoFLNyFdSo/UwxEVkqoUp97hVRgBDdaNm4dgC0b/J9QhamPfXQjO9WKopjTs8X3dMOB+EAJZlC4afgAD9rj61CS3Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=SiyDg1Lu; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=SiyDg1Lu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hdvCS6MMdz2xKh
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Sep 2026 03:27:31 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 687E1k8t2157866;
	Mon, 7 Sep 2026 17:27:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=hhs5p1
	zJpM3bR2IGL3baC3tD1qlK1pM0VAN2fKfUc+0=; b=SiyDg1LuMlGqC0ZA8hH07l
	eMDc8zFqvZOP1KJIxVgJY931EW9U16eUyRks7xxl5WWdWXY0/xHJKHH1gRNow8A9
	vrVj/ZoM+psnzrYOOBysaZr99FflKOqtw1ZYFrn1Tc+/KYxAZ4DcGzuJKd39CsNJ
	VJSSgA3Fz82vaRnR/HjvtlqQRHpd9/HRpc+ZNX8B1gcY+G90HjNP8ENS3ElPB/iU
	UwyiudVLKa/WRJpje4Vos/oZMDX5Xt0AGtHyZhtYghq+vodTLON2+/zyJ+7AwZKm
	4y/h+r6Wz0cfYlMjO3FDns5Zp2+jTDfj8zBiBll3oqzfeOWfDohRE3106UsNzOXw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbhkj29g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Sep 2026 17:27:14 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 687HQXVj007500;
	Mon, 7 Sep 2026 17:27:13 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ggwsvy8kw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Sep 2026 17:27:12 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 687HR8iQ32702852
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 7 Sep 2026 17:27:08 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 724E020043;
	Mon,  7 Sep 2026 17:27:08 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 871E020040;
	Mon,  7 Sep 2026 17:27:05 +0000 (GMT)
Received: from [9.39.28.108] (unknown [9.39.28.108])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  7 Sep 2026 17:27:05 +0000 (GMT)
Message-ID: <df5947b9-ba3f-48b1-81d1-fb4cf93ddd16@linux.ibm.com>
Date: Mon, 7 Sep 2026 22:57:04 +0530
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
Subject: Re: [PATCH] powerpc/interrupt: Use early_radix_enabled() in NMI
 real-mode guard
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
        =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
Cc: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
        npiggin@gmail.com, chleroy@kernel.org, mkchauras@linux.ibm.com,
        mkchauras@gmail.com, ruanjinjie@huawei.com, ritesh.list@gmail.com,
        riteshh@linux.ibm.com, linux-kernel@vger.kernel.org
References: <20260907070058.26338-1-venkat88@linux.ibm.com>
 <ap53KNdFJWaUw8GM@kunlun.suse.cz>
 <a5836b4f-16ad-462c-bfa9-d523915239ea@linux.ibm.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <a5836b4f-16ad-462c-bfa9-d523915239ea@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDE4OSBTYWx0ZWRfX71JifSkIUusH
 1yw7VBpSbbLIwezKgBPIdHy3BcpWX34KQZ58O7B3OKoVAlpD2Bg5XCq7H0ffdZuLByktVoqfzsg
 ADA0MKnU2hIFQERnyiuuLKZa4DMRFUY=
X-Proofpoint-ORIG-GUID: MebTg2ywpPR6UVBvhVx6TMS4L-f2EBOZ
X-Authority-Analysis: v=2.4 cv=NMDlPU6g c=1 sm=1 tr=0 ts=6a9ef3f2 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=HVQ2MUg0zB031LN6mvgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDE4OSBTYWx0ZWRfX63rwbmSapRKo
 urMOvG239Wfu3fo9oZRRzWTUQkJREL4K36tBL8Yk59BiGqG6z1ONWcs2npzKpSxqbpv9HAs2Hsu
 5zrftLfWz8bc8u/W63fdBpnwhZl1PXjNgRLtHIKMKCrQndhNLiGvMmqmObo7xmHlx6tIxwlw8SB
 fI4TqKWcbLQDLIzyWP/DMQznehCZM4EG5km1q55H6zozJj2Q0KLIjsGyG2pL1Q1eAweMNCi6/NC
 Rj2rlOY6sESa9f+c/TUDTXWnDNikazXjZUnRsEP55Z3VIdH4Lx+AamMubh7CpVoSXxIhw6sgozj
 RmoqgspfHvF6wXkkfeFJZ3vT5U0wq7nxcphsDzYwSCi1oo3hvaS/QQgae/PiU3BUS3E2OHAe88Q
 F/f1ADFdHvfLDVGSuHMtvrJRpWlL1LWbEOcU4ipM0TTKY5vhYQr5qtOwRE47/BQlCpHXiTzpHQi
 qsDU0nZMU51iH3j7uiQ==
X-Proofpoint-GUID: af2ZZRWflN_PlbouzaK14-1EyfmafJe8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_04,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070189



On 9/7/26 2:24 PM, Venkat Rao Bagalkote wrote:
> 
> On 07/09/26 2:04 pm, Michal Suchánek wrote:
>> Hello,
>>
>> On Mon, Sep 07, 2026 at 12:30:58PM +0530, Venkat Rao Bagalkote wrote:
>>> radix_enabled() uses a jump label which is only valid after
>>> mmu_feature_keys_init() is called. Before that point, on a pSeries
>>> hash guest, early_check_vec5() clears MMU_FTR_TYPE_RADIX in
>>> cur_cpu_spec->mmu_features but the jump label has not yet been patched,
>>> so radix_enabled() incorrectly returns true.
>>>
>>> Replace radix_enabled() with early_radix_enabled() which does a plain
>>> bitmask check against cur_cpu_spec->mmu_features and is correct at all
>>> times, including before jump label initialization.
>> Any Fixes: here?
> 
> 
> Hello Michal,
> 
> Yes, this can have.
> 
> Fixes: 118178e62e2e ("powerpc: move NMI entry/exit code into wrapper")
> 
> As commit 118178e62e2e originally introduced !radxi_enabled() check in NMI wrapper path.
> 
> 

looks like it did movement of code, rather than introducing.

> Regards,
> 
> Venkat.
> 
>>
>> Thanks
>>
>> Michal
>>
>>> Add the missing #include <asm/mmu.h> since early_radix_enabled() is
>>> declared there.
>>>
>>> Signed-off-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
>>> ---
>>>   arch/powerpc/include/asm/interrupt.h | 5 +++--
>>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/powerpc/include/asm/interrupt.h b/arch/powerpc/include/asm/interrupt.h
>>> index 1b45a49e9bed..36a654e780f7 100644
>>> --- a/arch/powerpc/include/asm/interrupt.h
>>> +++ b/arch/powerpc/include/asm/interrupt.h
>>> @@ -71,6 +71,7 @@
>>>   #include <asm/kprobes.h>
>>>   #include <asm/runlatch.h>
>>> +#include <asm/mmu.h>
>>>   #ifdef CONFIG_PPC_IRQ_SOFT_MASK_DEBUG
>>>   /*
>>> @@ -290,7 +291,7 @@ interrupt_handler long func(struct pt_regs *regs)            \
>>>           state = irqentry_nmi_enter(regs);            \
>>>       } else if (IS_ENABLED(CONFIG_PPC_BOOK3S_64) &&            \
>>>              firmware_has_feature(FW_FEATURE_LPAR) &&        \
>>> -           !radix_enabled()) {                    \
>>> +           !early_radix_enabled()) {                \
>>>           /* no nmi_entry for a pseries hash guest        \
>>>            * taking a real mode exception */            \
>>>       } else if (IS_ENABLED(CONFIG_KASAN)) {                \
>>> @@ -307,7 +308,7 @@ interrupt_handler long func(struct pt_regs *regs)            \
>>>           irqentry_nmi_exit(regs, state);                \
>>>       } else if (IS_ENABLED(CONFIG_PPC_BOOK3S_64) &&            \
>>>              firmware_has_feature(FW_FEATURE_LPAR) &&        \
>>> -           !radix_enabled()) {                    \
>>> +           !early_radix_enabled()) {                \
>>>           /* no nmi_exit for a pseries hash guest            \
>>>            * taking a real mode exception */            \
>>>       } else if (IS_ENABLED(CONFIG_KASAN)) {                \
>>> -- 
>>> 2.45.2
>>>
>>>


