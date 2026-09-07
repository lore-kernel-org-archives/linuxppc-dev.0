Return-Path: <linuxppc-dev+bounces-26660-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10820C79F89
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Sep 2026 08:54:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hdgqT2W5qz2y2L;
	Mon, 07 Sep 2026 18:54:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788771269;
	cv=none; b=Tj5/xT7Dtl7KED47qe4Z6XlxvOX8X+RTq7/PwZJBBi3UUGrVE1OpgRFBiPQ28p/4SNO0oSG4KQGpiYgKftIUg+Q/s008JMP44VVBBq/xu5rdEK6B7dZckFhKHUqpOr/jIxW96Y/8F96MYHz0085ZYG7kmdC9zHQWo22KePvyNIRN3MkyddHOoOs1QwZ5ija6ycCm4o+dVm639STS+TEsi/pBCuRZj7q8poy2t8SCQrOtNIL0/qKcyv1UeEtOeLwL7/Wbb5EpE88x9JGyvosb0h29+Q/VzthwxIaw2Su1bKN9xZ5TltGpNMvRHCtTRNEG50ANXUIklQlUIfF3gnTgzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788771269; c=relaxed/relaxed;
	bh=Iyjt0KEA5cNC1uu+BHKCwY6ievqsbI+ncRS6Ogb2U4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ok0PsBbVj6iLVvSv/xVM/Lqv/tRW7/JieqsMZ4yN38N3G0EqD30wGxSEpWADK08EU82otFC+5/UySTm3gCDxmKIRfYUm/DcEtbw/VNlzObNGWviiByZGtaLO55qUWUbip/jbAeheT3E5+06jaYTvU+nMBC6TVo7NU1d23dHQD8XU62ZVHPwRBu+w2JKg2fKm4Fmu4J1WOxVwnroE03Q8MZ+eubQcBrlZ4TMO1zjfS0BcvuRv7ZPPrOlmm+maiPQl6e92CAJSqWbjBs6Xl5uta/WMJzJb3HQFKJYL+arUb/ZMyUw7924dU6WZfX2pmosLIp3arvMf59U7SLxsbLBd4A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=cVXwyC99; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=cVXwyC99;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hdgqS47dfz2xpv
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Sep 2026 18:54:28 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6877Vqxq1293194;
	Mon, 7 Sep 2026 08:54:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Iyjt0K
	EA5cNC1uu+BHKCwY6ievqsbI+ncRS6Ogb2U4Y=; b=cVXwyC992vIImzQ1ixMJbQ
	4Rer8E+21oaHO4seLxFbHbl7apZsh1XCt/sTizQWa6A9ESFN45FCLC++SBtMZpcl
	Fi+Ff/bNNvNxcI8bhcI3ykovELqX2pfHjQcEfAL16fsonZP7EmQT3qxk5su7SOln
	dip7bIRUtOMMIZa5sv1bVio3NzkzqUy3OFsa/UEc+SXKnDkz7YG+uSkETZQfStCM
	Dia154E88+yjvU11alN4MoMEQD+/TQP9Wylbi+LbNP5lfzf5iwZrrOmkX5PX2NIL
	mSK491gtNINEGtxW043/shZWXUS7V7bhaTMSLjxFUqOb0wyNVyMNHT5jnDQ4dw6A
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbf3qnqb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Sep 2026 08:54:15 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6878fGfK030002;
	Mon, 7 Sep 2026 08:54:14 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ggymg4r81-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Sep 2026 08:54:14 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6878rVpo23790228
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 7 Sep 2026 08:53:31 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A8BFE5805F;
	Mon,  7 Sep 2026 08:54:12 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ACEFC5805E;
	Mon,  7 Sep 2026 08:54:08 +0000 (GMT)
Received: from [9.61.246.56] (unknown [9.61.246.56])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  7 Sep 2026 08:54:08 +0000 (GMT)
Message-ID: <a5836b4f-16ad-462c-bfa9-d523915239ea@linux.ibm.com>
Date: Mon, 7 Sep 2026 14:24:06 +0530
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
To: =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
Cc: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
        npiggin@gmail.com, chleroy@kernel.org, mkchauras@linux.ibm.com,
        mkchauras@gmail.com, sshegde@linux.ibm.com, ruanjinjie@huawei.com,
        ritesh.list@gmail.com, riteshh@linux.ibm.com,
        linux-kernel@vger.kernel.org
References: <20260907070058.26338-1-venkat88@linux.ibm.com>
 <ap53KNdFJWaUw8GM@kunlun.suse.cz>
Content-Language: en-GB
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
In-Reply-To: <ap53KNdFJWaUw8GM@kunlun.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: OlV0i-teob4AjdM4_b3bvm4ga3dFnXJW
X-Proofpoint-GUID: zEiZ-Y4rduKT_VMhq2ulve9k1yQMX4-V
X-Authority-Analysis: v=2.4 cv=DbEnbPtW c=1 sm=1 tr=0 ts=6a9e7bb8 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=w_NVU3Cj0BvD-z1ETa0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDA5MiBTYWx0ZWRfX9g489ajcu5GM
 kenfKNpVpJ253NSK5q7EVsErBsK1EtS3sVVAhl3VSpMQ2iXpKcbUQJJfr+3MyVWkqjgR6ii9o9o
 iDf31CAkryM6V3SWSwJj4Qc7aricJMdv0jUucBXR6adAnCbyzEBwn3ysmSTNVo62KN8AMyU0geZ
 9GJtNGuzcHPrl7qjeP1vf+0dCSke2txRfuuYT0t0hqZVOMKF3qbC2FVc52p8iqUca6GB8Pq2hww
 VwTsijMh75efKuHUl6lc/5O/R5T670ndg0zD5XpZmmVo0FS+GGkZK7GDKMoC+QgTpZu+EBSFPpn
 yGlpAi5TNc75jQFD3mkobeeUns4qDlqAjPv//xISZdsk8vsEt9XXs4T6oLuB9QpVIQdyaB5oowB
 BCR9iWdwxk/zdg3QJfrexI6+FhKOQ7BbOdEHHVnK2k3Cs61+SXDT4FG4BMxJbSXG3EYIspC79E7
 4P7p0JqGHW3RObaQfPw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDA5MiBTYWx0ZWRfX9RuCQrVx7itC
 ftcDlE/7N7nMqtUTG7hgweXgzsqvlT0X9DrrQS1xKPqOulKcMbxwGdF86mnZii/JqvrHZBsb0hJ
 VP5xiNn4BMaUWBe80Qn3Y9B+M6ZH5uM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 adultscore=0 spamscore=0
 clxscore=1011 suspectscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070092


On 07/09/26 2:04 pm, Michal Suchánek wrote:
> Hello,
>
> On Mon, Sep 07, 2026 at 12:30:58PM +0530, Venkat Rao Bagalkote wrote:
>> radix_enabled() uses a jump label which is only valid after
>> mmu_feature_keys_init() is called. Before that point, on a pSeries
>> hash guest, early_check_vec5() clears MMU_FTR_TYPE_RADIX in
>> cur_cpu_spec->mmu_features but the jump label has not yet been patched,
>> so radix_enabled() incorrectly returns true.
>>
>> Replace radix_enabled() with early_radix_enabled() which does a plain
>> bitmask check against cur_cpu_spec->mmu_features and is correct at all
>> times, including before jump label initialization.
> Any Fixes: here?


Hello Michal,

Yes, this can have.

Fixes: 118178e62e2e ("powerpc: move NMI entry/exit code into wrapper")

As commit 118178e62e2e originally introduced !radxi_enabled() check in 
NMI wrapper path.


Regards,

Venkat.

>
> Thanks
>
> Michal
>
>> Add the missing #include <asm/mmu.h> since early_radix_enabled() is
>> declared there.
>>
>> Signed-off-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
>> ---
>>   arch/powerpc/include/asm/interrupt.h | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/interrupt.h b/arch/powerpc/include/asm/interrupt.h
>> index 1b45a49e9bed..36a654e780f7 100644
>> --- a/arch/powerpc/include/asm/interrupt.h
>> +++ b/arch/powerpc/include/asm/interrupt.h
>> @@ -71,6 +71,7 @@
>>   
>>   #include <asm/kprobes.h>
>>   #include <asm/runlatch.h>
>> +#include <asm/mmu.h>
>>   
>>   #ifdef CONFIG_PPC_IRQ_SOFT_MASK_DEBUG
>>   /*
>> @@ -290,7 +291,7 @@ interrupt_handler long func(struct pt_regs *regs)			\
>>   		state = irqentry_nmi_enter(regs);			\
>>   	} else if (IS_ENABLED(CONFIG_PPC_BOOK3S_64) &&			\
>>   		   firmware_has_feature(FW_FEATURE_LPAR) &&		\
>> -		   !radix_enabled()) {					\
>> +		   !early_radix_enabled()) {				\
>>   		/* no nmi_entry for a pseries hash guest		\
>>   		 * taking a real mode exception */			\
>>   	} else if (IS_ENABLED(CONFIG_KASAN)) {				\
>> @@ -307,7 +308,7 @@ interrupt_handler long func(struct pt_regs *regs)			\
>>   		irqentry_nmi_exit(regs, state);				\
>>   	} else if (IS_ENABLED(CONFIG_PPC_BOOK3S_64) &&			\
>>   		   firmware_has_feature(FW_FEATURE_LPAR) &&		\
>> -		   !radix_enabled()) {					\
>> +		   !early_radix_enabled()) {				\
>>   		/* no nmi_exit for a pseries hash guest			\
>>   		 * taking a real mode exception */			\
>>   	} else if (IS_ENABLED(CONFIG_KASAN)) {				\
>> -- 
>> 2.45.2
>>
>>

