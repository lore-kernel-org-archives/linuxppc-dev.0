Return-Path: <linuxppc-dev+bounces-26713-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C51C2C79F82
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Sep 2026 03:53:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hf95Z0hTdz2xqp;
	Tue, 08 Sep 2026 13:53:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788839602;
	cv=none; b=n3pt60Y3WOImaR/F/A2jseFsZYjrbr+9RAahYyNyD2fqIi2GVBRS4f6LH7OMfQUZeaJrY0X9NSvECt8L4hCkzoAEJB6EEKzgxPOzisdJuHL3+yUIQUOZenWYM6+vMGuu5Y/vIZJ/FzLkrWHLe1Vj2aSSdJ9RnHzxg9uq170a1SZPrJwJrMsUW6Q1U7DimGdujeJJO9aMcPeeUD26ptdHl/6pqhOX5OKAWNCqwOcyfoyLPonH+p88saUtx8IOnIkn92w/bbLLJ3K3ZxXZm/vlk1AXC75ZfPnfGqJidlvfP6JuX17uGyw/pmNVyy0XBvLFyGly5z5FZPRfQODdlka7hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788839602; c=relaxed/relaxed;
	bh=3uBMiZS8f0vKQfyxRDmopcFiYNmVAX97oSfRAF+7MNo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A6mNVbd7pwL3o1KHkobzneefn+O7Nydqes3SmYiqAP8y8VU1ta9/41jJLcicd1z/aZxMoVUbwCgjBXJlEG0x/ZHD1zy2PUIR+LXl5YoNfTUC4LCkePymKo+/tHMt+ONtw6MtGg/Lug9Xey0TgrBG9Zy6aLJlSuP1pj6X+zVKs7Ifhp2YMo0E43Obfl/QYKHW+JyUB3Jwjx6DBP9ShFBJbKNcFZNnyM/5u/sFcj9XJvuAq/LMn5rc6tr4jd5dTXtXK2BArSZ1yqTp+uhEHt2x5TmebJnxqDfwKGTDZIvwdOeeWJfVwuztWb3GTL1K/i8JDJYD0G6Gtl1ERqrex8vOPA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bgBZT+MP; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bgBZT+MP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hf95X69Nqz2xYh
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Sep 2026 13:53:19 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68801sj73379399;
	Tue, 8 Sep 2026 03:53:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=3uBMiZ
	S8f0vKQfyxRDmopcFiYNmVAX97oSfRAF+7MNo=; b=bgBZT+MPbk2hPy05k/VJIk
	YJvmy1T8y3nA9+Lnq/wVqadhCsU0DZdPZ4Fr82suN8Un6wnzNZH8w3iq10if+A+h
	LFcwjoBwrlK8fTIZckmUlFES6expDsgh/Cu4abKzx9DBZXCbKBl9xbWdHzuJYqdr
	BJxCg0inDpMAMoAG1o9inc9Ub7XMGB3BFShFvg+/8HIaG3t2jxE/z2IRWb/s6bGp
	DHdHx4yCg3GQgu3bqSK2Sn6THUC1IxugJy9tbZfXzoDEvF2k5JHaFzMU6lqsZAi2
	tcfdgEJwPh7YmZ+QMVt/I1Kfg82LJmpH6U+e5uLGs0ZeY8OH8qRBcBbbhxPNgoqg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbf3va0f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Sep 2026 03:53:05 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6883fHhT023138;
	Tue, 8 Sep 2026 03:53:04 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ggxwh1ba5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Sep 2026 03:53:04 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6883r2Lr12124926
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 8 Sep 2026 03:53:02 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 69A325805D;
	Tue,  8 Sep 2026 03:53:02 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B7E358043;
	Tue,  8 Sep 2026 03:52:58 +0000 (GMT)
Received: from [9.123.0.173] (unknown [9.123.0.173])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  8 Sep 2026 03:52:57 +0000 (GMT)
Message-ID: <690cdbec-d771-4aaa-bb0a-e057af5fd9cb@linux.ibm.com>
Date: Tue, 8 Sep 2026 09:22:56 +0530
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
To: Shrikanth Hegde <sshegde@linux.ibm.com>,
        =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
Cc: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
        npiggin@gmail.com, chleroy@kernel.org, mkchauras@linux.ibm.com,
        mkchauras@gmail.com, ruanjinjie@huawei.com, ritesh.list@gmail.com,
        riteshh@linux.ibm.com, linux-kernel@vger.kernel.org
References: <20260907070058.26338-1-venkat88@linux.ibm.com>
 <ap53KNdFJWaUw8GM@kunlun.suse.cz>
 <a5836b4f-16ad-462c-bfa9-d523915239ea@linux.ibm.com>
 <df5947b9-ba3f-48b1-81d1-fb4cf93ddd16@linux.ibm.com>
Content-Language: en-GB
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
In-Reply-To: <df5947b9-ba3f-48b1-81d1-fb4cf93ddd16@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: lFW-7BnXC7FPCPhrm-dbid1SeIlIrQjj
X-Proofpoint-GUID: pRZCwAaiveYDRuQcqOpGm8c-uOq7jcCw
X-Authority-Analysis: v=2.4 cv=DbEnbPtW c=1 sm=1 tr=0 ts=6a9f86a1 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=HVQ2MUg0zB031LN6mvgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDAzNSBTYWx0ZWRfX4m5/JDAOt0kA
 veb7+X797Oyd1jpQSQiiiOUR6+jZd2nlu9hbPZWEPQDaJR/V7dnWfwUxsNiuBQVVUlt1aDF7PRc
 8OuLxprCD5X9bZNUTrtv9wAtuboI9LSjT1VC+bqCDepZFehfMzdz93PufjZh+/N5IcRCrVKJkjK
 Ev6bd/FWlnup95UUdW+BoHlwdb/5Zh4PQw7j7eoHm42hsPo0umQgKjTwXza7Q+62VvI/BgBVf6i
 NlyKviq6XEFlkiZ/Dtr5HRpRk8ydrNJbhHfFsaQ7Z4rX7GChVE1l8h4UUpvHejgl0NSIbroGZ7m
 z9pz+Xr7ZeTB4UdpYnDkAYUrFJHrFyHMuMW9Eewk7cAJgWckAeD9mwSEFxBgggKjglUGhcw6YqJ
 Ik4ga0kOztKoUshZKIMqsiuasVdPsDoL1/829kk//FhWTLLZ9o1PxHrz7gXH2H7t20IXg+YZxo4
 iB/VcWU9f4DvNPdumJQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDAzNSBTYWx0ZWRfXwjArrGfFazP2
 MubkMov5w15MEAR9Uc9MFDA0P5LMQftkiDAGFiYr0UQusA96Plm0U50EsWEcuPiEDw+0rCFncYC
 pp2c5AAc4OBOz+nLdU7p7s//pXsJhVE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_07,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 adultscore=0 spamscore=0
 clxscore=1015 suspectscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080035


On 07/09/26 10:57 pm, Shrikanth Hegde wrote:
>
>
> On 9/7/26 2:24 PM, Venkat Rao Bagalkote wrote:
>>
>> On 07/09/26 2:04 pm, Michal Suchánek wrote:
>>> Hello,
>>>
>>> On Mon, Sep 07, 2026 at 12:30:58PM +0530, Venkat Rao Bagalkote wrote:
>>>> radix_enabled() uses a jump label which is only valid after
>>>> mmu_feature_keys_init() is called. Before that point, on a pSeries
>>>> hash guest, early_check_vec5() clears MMU_FTR_TYPE_RADIX in
>>>> cur_cpu_spec->mmu_features but the jump label has not yet been 
>>>> patched,
>>>> so radix_enabled() incorrectly returns true.
>>>>
>>>> Replace radix_enabled() with early_radix_enabled() which does a plain
>>>> bitmask check against cur_cpu_spec->mmu_features and is correct at all
>>>> times, including before jump label initialization.
>>> Any Fixes: here?
>>
>>
>> Hello Michal,
>>
>> Yes, this can have.
>>
>> Fixes: 118178e62e2e ("powerpc: move NMI entry/exit code into wrapper")
>>
>> As commit  originally introduced !radxi_enabled() check in NMI 
>> wrapper path.
>>
>>
>
> looks like it did movement of code, rather than introducing.
>

Hello Shrikanth,

Yes, you are right. commit 118178e62e2e, just consolidated NMI wrapper 
logic from arch/powerpc/kernel/mce.c into interrupt.h.

Tracing it further back, radix_enabled() check for pseries hash guest in 
real-mode NMI was originally introduced in

commit: 8d0e21012743 ("powerpc/mce: Avoid nmi_enter/exit in real mode on 
pseries hash")

I can add Fixes: 8d0e21012743, and send V2, if that works.

Regards,

Venkat.

>> Regards,
>>
>> Venkat.
>>
>>>
>>> Thanks
>>>
>>> Michal
>>>
>>>> Add the missing #include <asm/mmu.h> since early_radix_enabled() is
>>>> declared there.
>>>>
>>>> Signed-off-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
>>>> ---
>>>>   arch/powerpc/include/asm/interrupt.h | 5 +++--
>>>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/arch/powerpc/include/asm/interrupt.h 
>>>> b/arch/powerpc/include/asm/interrupt.h
>>>> index 1b45a49e9bed..36a654e780f7 100644
>>>> --- a/arch/powerpc/include/asm/interrupt.h
>>>> +++ b/arch/powerpc/include/asm/interrupt.h
>>>> @@ -71,6 +71,7 @@
>>>>   #include <asm/kprobes.h>
>>>>   #include <asm/runlatch.h>
>>>> +#include <asm/mmu.h>
>>>>   #ifdef CONFIG_PPC_IRQ_SOFT_MASK_DEBUG
>>>>   /*
>>>> @@ -290,7 +291,7 @@ interrupt_handler long func(struct pt_regs 
>>>> *regs)            \
>>>>           state = irqentry_nmi_enter(regs);            \
>>>>       } else if (IS_ENABLED(CONFIG_PPC_BOOK3S_64) &&            \
>>>>              firmware_has_feature(FW_FEATURE_LPAR) &&        \
>>>> -           !radix_enabled()) {                    \
>>>> +           !early_radix_enabled()) {                \
>>>>           /* no nmi_entry for a pseries hash guest        \
>>>>            * taking a real mode exception */            \
>>>>       } else if (IS_ENABLED(CONFIG_KASAN)) { \
>>>> @@ -307,7 +308,7 @@ interrupt_handler long func(struct pt_regs 
>>>> *regs)            \
>>>>           irqentry_nmi_exit(regs, state);                \
>>>>       } else if (IS_ENABLED(CONFIG_PPC_BOOK3S_64) &&            \
>>>>              firmware_has_feature(FW_FEATURE_LPAR) &&        \
>>>> -           !radix_enabled()) {                    \
>>>> +           !early_radix_enabled()) {                \
>>>>           /* no nmi_exit for a pseries hash guest \
>>>>            * taking a real mode exception */            \
>>>>       } else if (IS_ENABLED(CONFIG_KASAN)) { \
>>>> -- 
>>>> 2.45.2
>>>>
>>>>
>
>

