Return-Path: <linuxppc-dev+bounces-26298-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E4E5C624A4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Aug 2026 14:47:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYWzv6Zldz2y2J;
	Tue, 01 Sep 2026 00:47:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788187643;
	cv=none; b=Dng1ZZsuPm0s6k9O7/QqEUPSR+sNGltW7qHiaK7YLwdXS1kvI3TscW0gPVTATZobaq7slljt1PuoduZQwcWMJdgmmeSxlBHfcXK5sfagam+M5YRlefYIyziglXHxcCc5VZjf3+pYVG9btCmaaZLrvLfTChCXiW68byvo7sUCPlDR7QVT/vHVl2cf4PphQRoyShusuYMtGRNykTGnIUfc5AnsiZBJiAMyEsldFZya7UAVyACUGgiCd7R6eaXzZ6oL2bplTqxvtGHBRaXHLCRrNKOYKLGKOYkJIfdWs9+jR9TO5Us05E/XKVfSBpukIjz7R6CPGphiRw4YNXWrbVtB7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788187643; c=relaxed/relaxed;
	bh=i5ct4mP4gEGxsavC+ivSbXKJco08ebR0qikna7vzZeM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HrVmxbyBobtEQKwHhS5gycOo+p2R2uOsgSzQ7IIHxM26qP1Rbhv2HnY+OosjgPZ7OhR4es3nbNF3cfJIgVkb+2evcu26mkklQpGxC9+bF6eTK+NZYXlSqd0kcP+jaKDDwGjy1rdoFo4eD9FjJiFWHJMxYhRVDPJFuZelK4my5mlmrPD0C8T6UDYa9YeQ2CQ6P51x2k4UTKjTcrgt8a8GQ9p5agw6iBsmWAB9QBRQaG4wERgkMF5fAeveu06ZdpadRNIfxhTvEM+q23ITaCWtdoZVZXCQqq7DbE87bGtMgfIvnuj5zaBsug/8qIE5+OQyF3b90FIeGyx1UlXcbiBWIw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=pP5pKGD4; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=pP5pKGD4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYWzs3DkXz2xLf
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Sep 2026 00:47:20 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VEZEoX2414997;
	Mon, 31 Aug 2026 14:47:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=i5ct4m
	P4gEGxsavC+ivSbXKJco08ebR0qikna7vzZeM=; b=pP5pKGD4xm5Wu7iCRxJctZ
	QyAecobxYvdWByetfaGlZ5AfV17HPdi7pCl9IpFn1z3UhaGeK6UYfYYDpFCa0BJO
	ziYZ21SgTjjlxAEsPi+J7YFo3Duz/p/8AMhR0h7AUgWkpai0aPK5aNdBM06kdMr8
	qz/gIm6Zgpjw443g14J8FG4PVN359QNkJDUi9YtJhqnk3uGOzH/TN5x6u9GMM1GN
	8EnafGJNKdR/OOjztZDa06VSeJP2oPEIPC75M7x9++p8lcTdHYN4R41heS2QX3J/
	9G/yA7hVoQcFeyuAx67quhjD5P626aJUgBBeKAIJiwlDmLs2a3dJ7JL+sUDiBuTw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbmuhj4ha-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 14:47:07 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VEfd85003378;
	Mon, 31 Aug 2026 14:47:06 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcarjxf0j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 14:47:06 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67VEl0fb44958204
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 14:47:00 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA91220043;
	Mon, 31 Aug 2026 14:47:00 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4C0BF20040;
	Mon, 31 Aug 2026 14:46:57 +0000 (GMT)
Received: from [9.124.217.83] (unknown [9.124.217.83])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 14:46:57 +0000 (GMT)
Message-ID: <410a3225-3ec8-408d-af93-15f7cc6f1629@linux.ibm.com>
Date: Mon, 31 Aug 2026 20:16:56 +0530
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
Subject: Re: [PATCH v3 1/5] powerpc/rtas: Handle ibm,open-errinjct return
 format
To: Sourabh Jain <sourabhjain@linux.ibm.com>, mahesh@linux.ibm.com,
        maddy@linux.ibm.com, mpe@ellerman.id.au, christophe.leroy@csgroup.eu,
        gregkh@linuxfoundation.org, oohall@gmail.com, npiggin@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        tyreld@linux.ibm.com, vaibhav@linux.ibm.com, sbhat@linux.ibm.com,
        ganeshgr@linux.ibm.com, haren@linux.ibm.com, thuth@redhat.com
References: <20260721033815.5300-1-nnmlinux@linux.ibm.com>
 <20260721033815.5300-2-nnmlinux@linux.ibm.com>
 <c4e58e48-a7a6-44b7-8984-7f03b3251160@linux.ibm.com>
Content-Language: en-US
From: Narayana Murty N <nnmlinux@linux.ibm.com>
In-Reply-To: <c4e58e48-a7a6-44b7-8984-7f03b3251160@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: gAtS3PWsQIGK500B1FtiPpHa0grdAXCt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEyNSBTYWx0ZWRfX2t3CfuC+JWep
 4P8bowchaySaORhQFTt7gAMlYXi2oP9tXJJzOp2BBHhqGikmkEi2ckUs3TppOet09lXbkW6j/Th
 StIfXZs6cBMGHgZT5OnCqbctnZdhZU/V92xgdctKjZs+oI/OQE8odL+tH4EpoIOVWO8uMt4Z8QN
 6C54FcmnhB3tFcPzAxBtG6RyWosHDTbIxlm637W4vC73viGAc7pgD1fRuA0g5mOC+C42kyIt9OB
 TPAjwH1IR6Q+hzBvH+d8Ttbzj2mSQIO5satdqg6weQLYxGqM20XHFkMZhNmli0I+J6CN6aAupMS
 4Zn62rcpZudcysDVBZD+L/r9m8316q8XWWlyHzZAuoysZkFAN4TCyvU9nHV6hPDW0i33mmf+vF+
 MxYTnUqoeIjZocPZtAs4oeWr8ZycmOCLMcfRassMQurwxRkJnfk4LxJhPxUuzKvEK5bhOeF2Fkq
 NWNWk8k6kaqRE9NzTAA==
X-Authority-Analysis: v=2.4 cv=Osl/DS/t c=1 sm=1 tr=0 ts=6a9593eb cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=1mVJ_uiqAAAA:8
 a=VnNF1IyMAAAA:8 a=o-ATCx0ry3g-RqrqluQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=h67g7WpEjx8dfGT80pje:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEyNSBTYWx0ZWRfX89MMWzcIPZT9
 FMhtRN/eVE/FOdtvEicC1E3wwxFrAnR7X0oS9gAFlNWzhUekttgeS3Dc6LvXmhYoBfonASUKhBv
 RiCzpbLI1tMBP6Tu9Fei86ukyy8xILs=
X-Proofpoint-ORIG-GUID: cGrvrxASN7C3l5rfwwzgKDEvzkrb4GrB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310125

Hi Sourabh,

Thanks for the review.

On 04/08/26 11:22 AM, Sourabh Jain wrote:
> 
> 
> On 21/07/26 09:08, Narayana Murty N wrote:
>> PAPR specifies that ibm,open-errinjct has a unique return-cell layout:
>>
>>    rets[0] = injection session token (output parameter)
>>    rets[1] = status code
>>
>> This differs from every other RTAS call, where:
>>
>>    rets[0] = status code
>>    rets[1..] = output parameters
>>
>> As a result, the existing rtas_call() convention — return value is the
>> RTAS status, outputs[] receives the non-status output values — must be
>> preserved while correctly extracting status from rets[1] for this one
>> call.
>>
>> Add rtas_token_is_open_errinjct() and rtas_status_from_args() helpers.
>> rtas_status_from_args() selects the correct status cell based on the
>> token, and the output-copy loop in rtas_call() is updated so that for
>> ibm,open-errinjct:
>>
>>    rtas_call() return = rets[1]   (RTAS status)
>>    outputs[0]        = rets[0]   (session token)
>>
>> For all other calls the behaviour is unchanged: return value is rets[0]
>> and outputs[] receives rets[1..nret-1].
>>
>> The sys_rtas userspace path is not modified: copy_to_user() still
>> copies raw RTAS return cells (rets[0..nret-1]) to userspace.
>>
>> Callers passing a single output int (nret == 2) are safe because we
>> write at most nret-1 values into outputs[], never all nret cells.
>>
>> Also move the '/* A -1 return code...*/' comment to immediately precede
>> the if (ret == -1) check it describes, and remove the redundant stale
>> else branch that re-assigned ret.
>>
>> Reference: OpenPOWER PAPR documentation
>>             https://files.openpower.foundation/s/XFgfMaqLMD5Bcm8
>>
>> Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
>> ---
>>   arch/powerpc/kernel/rtas.c | 51 ++++++++++++++++++++++++++++++++------
>>   1 file changed, 44 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
>> index 8d81c1e7a8db..27d53f34494d 100644
>> --- a/arch/powerpc/kernel/rtas.c
>> +++ b/arch/powerpc/kernel/rtas.c
>> @@ -1117,6 +1117,29 @@ static bool token_is_restricted_errinjct(s32 
>> token)
>>              token == rtas_function_token(RTAS_FN_IBM_ERRINJCT);
>>   }
>> +/**
>> + * rtas_token_is_open_errinjct() - Test whether @token identifies 
>> ibm,open-errinjct.
>> + */
>> +static bool rtas_token_is_open_errinjct(int token)
>> +{
>> +    return token == rtas_function_token(RTAS_FN_IBM_OPEN_ERRINJCT);
>> +}
> 
> The above function is a god candidate for an inline function.

Agreed. I updated this in v4 and made the helper static inline.

>> +
>> +/**
>> + * rtas_status_from_args() - Extract the RTAS status code from a 
>> completed
>> + *                           call's return-cell array.
>> + *
>> + * For ibm,open-errinjct the status lives in rets[1]; for every other
>> + * RTAS function it lives in rets[0].
>> + */
>> +static int rtas_status_from_args(int token, struct rtas_args *args, 
>> int nret)
>> +{
>> +    if (rtas_token_is_open_errinjct(token) && nret > 1)
> 
> Do we know what RTAS returns when nret is less than 2 for the ibm,open- 
> errinjct RTAS call?
> 
> I assume RTAS treats this as a parameter error. However, since there is 
> no rets buffer available
> to store the status code, I'm not sure how RTAS would convey the 
> parameter error back to the kernel.
> 
> The way the RTAS status code is extracted when nret is less than 2 for 
> the ibm,open-errinjct RTAS
> call seems problematic me, especially when nret == 1. When nret == 1, 
> this function returns args->rets[0],
> which is supposed to contain the session token.
> 
> Are we sure that RTAS places the call status in rets[0] when nret == 1 
> for the ibm,open-errinjct RTAS call?
> 
The rets[0] contains a status for
ibm,open-errinjct when fewer than two return cells are provided. For this
RTAS call, rets[0] is the session token and rets[1] is the status. So if
nret < 2, the kernel cannot reliably extract the status.

I fixed this in v4 by treating ibm,open-errinjct with nret < 2 as an
invalid rtas_call() usage instead of falling back to rets[0]. That avoids
mistaking a session token for a status code.

For normal callers using nret == 2, the behavior remains:

rtas_call() return value = rets[1] status
outputs[0] = rets[0] session token

The sys_rtas() path remains unchanged and continues to expose the raw RTAS
return cells to userspace.

> - Sourabh Jain
> 
>> +        return be32_to_cpu(args->rets[1]);
>> +
>> +    return nret > 0 ? be32_to_cpu(args->rets[0]) : 0;
>> +}
>> +
>>   /**
>>    * rtas_call() - Invoke an RTAS firmware function.
>>    * @token: Identifies the function being invoked.
>> @@ -1213,15 +1236,29 @@ int rtas_call(int token, int nargs, int nret, 
>> int *outputs, ...)
>>       va_rtas_call_unlocked(args, token, nargs, nret, list);
>>       va_end(list);
>> -    /* A -1 return code indicates that the last command couldn't
>> -       be completed due to a hardware error. */
>> -    if (be32_to_cpu(args->rets[0]) == -1)
>> +    ret = rtas_status_from_args(token, args, nret);
>> +
>> +    /*
>> +     * A -1 return code indicates that the last command couldn't
>> +     * be completed due to a hardware error.
>> +     */
>> +    if (ret == -1)
>>           buff_copy = __fetch_rtas_last_error(NULL);
>> -    if (nret > 1 && outputs != NULL)
>> -        for (i = 0; i < nret-1; ++i)
>> -            outputs[i] = be32_to_cpu(args->rets[i + 1]);
>> -    ret = (nret > 0) ? be32_to_cpu(args->rets[0]) : 0;
>> +    if (nret > 1 && outputs != NULL) {
>> +        if (rtas_token_is_open_errinjct(token)) {
>> +            /*
>> +             * ibm,open-errinjct: rets[0]=session token, rets[1]=status.
>> +             * Expose session token in outputs[0]; skip rets[1] 
>> (status).
>> +             */
>> +            outputs[0] = be32_to_cpu(args->rets[0]);
>> +            for (i = 1; i < nret - 1; ++i)
>> +                outputs[i] = be32_to_cpu(args->rets[i + 1]);
>> +        } else {
>> +            for (i = 0; i < nret - 1; ++i)
>> +                outputs[i] = be32_to_cpu(args->rets[i + 1]);
>> +        }
>> +    }
>>       lockdep_unpin_lock(&rtas_lock, cookie);
>>       raw_spin_unlock_irqrestore(&rtas_lock, flags);
> 


Thanks,
Narayana

