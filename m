Return-Path: <linuxppc-dev+bounces-25321-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AE6CC55843
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Aug 2026 05:54:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDjRl6Xkzz2yMl;
	Tue, 04 Aug 2026 15:54:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785822883;
	cv=none; b=SvwLd2rtjPJbXRYsEJThLHaV/HHRd6dngthfwtn8kBupVBNSxL5854JeFUl+ckuDzM5LR64Cx71l719TFBFajQEGkia/sefSfkmQR77K/bK3PqFsmBIC/iGwl8kkTg5FZ605BWmgU2/SNPkXVwFcSu6n/RL3IitT9stn5m7X46J6okllXRpvHg6KhtkkTjmHXVcfbB/DZqgt5znu9Vak7wz/E97TU40hAX1DHtuwklyYce3HFxu73A6L5yONS6kfqWwujqTdj2tuBgi5cfwOAIeaMqPaWqagfov00s0M8y3Yix2diPwIc12RMJDgKvEvQdIqX03u5Kq/AqUuVlo+Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785822883; c=relaxed/relaxed;
	bh=Hskofb5pAb8uFaaum58+UTOp5Pqus+OpoxsFY+UKpDg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ahdSlt9/uKRJe5gwVVsRsXOS0IkV+Yxik6xRxf2BDgE0vcBp34zqqbI5xmzZMbkJzhD9w4/Xwf7nW+34sdAmmyksKQvGvHCZcpTPCLGzFXI53PNzDBFPar6/29fXYXorh5C8TVADK3I0B5RoN0R14d75l5+QGfFpmBOea8m17nKG7yTkEKkVojPoWKQbpHki/s+priap2/qOLJxmH4trj122YwgiGzO/e5iYH/p4yX+PiszkmsSLR7weFzhrgDhscpG/psfIwu02tAB5uj1CG2445yzcZprPk4HkFsQEIDIWtfk6g2KAUgxRY3su1Zn71EAbjPVHcOB3jEZgogD7+Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=kXVywLIg; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=kXVywLIg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDjRk5qMdz2y1Y
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2026 15:54:42 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6741IFvv3577892;
	Tue, 4 Aug 2026 05:54:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Hskofb
	5pAb8uFaaum58+UTOp5Pqus+OpoxsFY+UKpDg=; b=kXVywLIg76I82xsKssl34K
	dW+K9tH/jKP+psidlsrdThsU9LNAWinhgldnyWvAbklYfJTbX0CaFm+QpWQCfCFU
	ZMi0UyiEY2ufiVNy/69c4uTf69kYXPWIXL+BeGYnwYtTtjjEkRIDajujOsiSpUWI
	adibCc0GBHzjv8ak+hLYlJuwO/vbtVNDjFkScgmL3lsjMUlSP9co87BB+wkrtQpf
	jSUC3IT+wzh8SbqLD+m8uGC8be22xBMOjJm/QLfm/0b20chh+AGaSCitS9Ipx8rd
	quXPAFLZfoA3X3FHHMsvYEmmS7Z6UqI73RiJgXgu+KHMsZr1j1c6nkA5xZqsen9g
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs77g441y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 05:54:30 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6745fGYV007981;
	Tue, 4 Aug 2026 05:54:30 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswtygdjm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 05:54:29 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6745sOj131982004
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Aug 2026 05:54:24 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 51FC820043;
	Tue,  4 Aug 2026 05:54:24 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6901A20040;
	Tue,  4 Aug 2026 05:54:21 +0000 (GMT)
Received: from [9.123.6.250] (unknown [9.123.6.250])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Aug 2026 05:54:21 +0000 (GMT)
Message-ID: <402be22e-05da-4e0e-9bb1-fa37addb72c6@linux.ibm.com>
Date: Tue, 4 Aug 2026 11:24:20 +0530
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
Subject: Re: [PATCH v2 1/5] powerpc/rtas: Handle special return format for
 RTAS_FN_IBM_OPEN_ERRINJCT
To: Sourabh Jain <sourabhjain@linux.ibm.com>, mahesh@linux.ibm.com,
        maddy@linux.ibm.com, mpe@ellerman.id.au, christophe.leroy@csgroup.eu,
        gregkh@linuxfoundation.org, oohall@gmail.com, npiggin@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        tyreld@linux.ibm.com, vaibhav@linux.ibm.com, sbhat@linux.ibm.com,
        ganeshgr@linux.ibm.com, haren@linux.ibm.com, thuth@redhat.com
References: <20260527072433.94510-1-nnmlinux@linux.ibm.com>
 <20260527072433.94510-2-nnmlinux@linux.ibm.com>
 <79ade62b-6e94-4219-b7fb-95cc3b80c957@linux.ibm.com>
Content-Language: en-US
From: Narayana Murty N <nnmlinux@linux.ibm.com>
In-Reply-To: <79ade62b-6e94-4219-b7fb-95cc3b80c957@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA0MyBTYWx0ZWRfX/9+8EWOIoJsC
 OwjDy4VUWC9F1JnYhH10+ZKXZEKItv1srzTtdh2PlZHMnHyoRdXC73e41BfZ9z4lkdkW7LXvpwl
 sfDIm8URj+pLc6khuPNljWCI0f0fAcxCpnOuUcCeSaPVVHCMKgkcFb15bsqKka7Cw86ze/w+sOr
 WomaQVpauI0NMur5EgZKspOpb1lY4L5MGdvJfulskUWrbGwEkYAA72dJpq9BnkSKvMSkmtu2R8n
 4Yp57J36voYZdhMBUzU9WCsFK/lx0KWo/sPxhE6wOxVkeo7tbXrH2xe1b46g4tk/nKcMl3Q9VsP
 prtibCdnLtx5NJAJ083xEy0z2FEue6FkLDOIpaSkJ5bIdiSclKmcnubnpwovRg2J70PaX1Xfai2
 /1qslVHQNnjc4B2RSNre5q6NyN5RJO/jBC4usHGqMP4FkGuENQnomGj94dQKQqvHapKG5b1JJWs
 Gj+TrNxuFXCawRruEIg==
X-Authority-Analysis: v=2.4 cv=WIFPmHsR c=1 sm=1 tr=0 ts=6a717e97 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=1mVJ_uiqAAAA:8
 a=VnNF1IyMAAAA:8 a=w6lZcthf9PlRyvyvgAIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=h67g7WpEjx8dfGT80pje:22
X-Proofpoint-GUID: OdiF2F5A0wuUPp6QZl-W2H7UkUeBFR37
X-Proofpoint-ORIG-GUID: cjJx45rXCA4OaRNWnGsv1aMgeK3Nt1a1
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA0MyBTYWx0ZWRfX2c3AMK4oG/7G
 RC4ztxaKQg9dcxzh6cKH3ArhdzOCcRZ5Xpf3LMtthKPvz9xir9Effmuyg0tYTHUMbYnxt+i3jcN
 7gH2H25+VWtPGQQj5OqaXRbhuKBZ0b0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_01,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040043

Hi Sourabh,

Thanks for the review.

On 07/06/26 4:49 PM, Sourabh Jain wrote:
>
>
> On 27/05/26 12:54, Narayana Murty N wrote:
>> RTAS_FN_IBM_OPEN_ERRINJCT returns results in special format:
>>    rets[0] = session token (output)
>>    rets[1] = status code
>>    rets[2..] = additional outputs (if any)
>>
>> Unlike standard RTAS calls where:
>>    rets[0] = status code
>>    rets[1..] = outputs
>>
>> This patch adds special handling for OPEN_ERRINJCT to:
>> 1. Check correct status position (rets[1]) for __fetch_rtas_last_error()
>
> You can consider fixing the same for the RTAS syscall.
>> 2. Copy all rets[0..nret-1] to outputs[] (including token at rets[0])
>> 3. Return status from rets[1] instead of rets[0]
>>
>> Reference: OpenPOWER PAPR documentation
>>        https://files.openpower.foundation/s/XFgfMaqLMD5Bcm8
>> Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
>> ---
>>   arch/powerpc/kernel/rtas.c | 47 ++++++++++++++++++++++++++++++++------
>>   1 file changed, 40 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
>> index 8d81c1e7a8db..a2dd94eed9d0 100644
>> --- a/arch/powerpc/kernel/rtas.c
>> +++ b/arch/powerpc/kernel/rtas.c
>> @@ -1183,7 +1183,7 @@ int rtas_call(int token, int nargs, int nret, 
>> int *outputs, ...)
>>       unsigned long flags;
>>       struct rtas_args *args;
>>       char *buff_copy = NULL;
>> -    int ret;
>> +    int ret = 0;
>>         if (!rtas.entry || token == RTAS_UNKNOWN_SERVICE)
>>           return -1;
>> @@ -1213,15 +1213,48 @@ int rtas_call(int token, int nargs, int nret, 
>> int *outputs, ...)
>>       va_rtas_call_unlocked(args, token, nargs, nret, list);
>>       va_end(list);
>>   +    /*
>> +     * Special handling for RTAS_FN_IBM_OPEN_ERRINJCT:
>> +     * Per PAPR, ibm,open-errinjct has a unique return format:
>> +     *   rets[0] = injection session token (output parameter)
>> +     *   rets[1] = status code
>> +     *
>> +     * This differs from standard RTAS calls which return:
>> +     *   rets[0] = status code
>> +     *   rets[1..] = output parameters
>> +     *
>> +     * We must extract status from rets[1] (not rets[0]) to correctly
>> +     * detect errors and trigger __fetch_rtas_last_error() when 
>> status == -1.
>> +     */
>>       /* A -1 return code indicates that the last command couldn't
>> -       be completed due to a hardware error. */
>
> The above comment should be moved to next if block, if (ret == -1).
>
>> -    if (be32_to_cpu(args->rets[0]) == -1)
>> +     * be completed due to a hardware error.
>> +     */
>> +    if (token == rtas_function_token(RTAS_FN_IBM_OPEN_ERRINJCT) && 
>> nret > 1)
>> +        ret = be32_to_cpu(args->rets[1]);
>> +    else if (nret > 0)
>> +        ret = be32_to_cpu(args->rets[0]);
>> +
>> +    if (ret == -1)
>>           buff_copy = __fetch_rtas_last_error(NULL);
>>   -    if (nret > 1 && outputs != NULL)
>> -        for (i = 0; i < nret-1; ++i)
>> -            outputs[i] = be32_to_cpu(args->rets[i + 1]);
>> -    ret = (nret > 0) ? be32_to_cpu(args->rets[0]) : 0;
>> +    /* Copy all return values to caller's outputs buffer if provided */
>> +    if (nret > 1 && outputs != NULL) {
>> +        if (token == rtas_function_token(RTAS_FN_IBM_OPEN_ERRINJCT)) {
>> +            /* Special case: rets[0]=token, rets[1]=status, 
>> rets[2..]=outputs */
>> +            for (i = 0; i < nret; ++i)
>> +                outputs[i] = be32_to_cpu(args->rets[i]);
>> +        } else {
>> +            /* Normal case: rets[0]=status, rets[1..]=outputs */
>> +            for (i = 0; i < nret - 1; ++i)
>> +                outputs[i] = be32_to_cpu(args->rets[i + 1]);
>
> I am surprised that status is never copied to the output buffer even 
> though it is part
> of the output as per PAPR. But status is copied for ibm,open-errinjct, 
> which is okay.
>
For normal RTAS calls, |rtas_call()|returns |rets[0]|, the firmware 
status, as its function

return value and copies only |rets[1..]|into the caller's 
|outputs[]|buffer. I intended to

preserve this existing API.

For |ibm,open-errinjct|, I will follow the same API convention: return 
the status from |rets[1]|,

copy the session token from |rets[0]|to |outputs[0]|, and copy any 
additional output values from |
|

|rets[2..]|to the subsequent entries in |outputs[]|. Therefore, the 
status does not need to

be copied into |outputs[]|.

>> +        }
>> +    } else {
>> +        /* Either no outputs to copy (nret <= 1) or caller
>> +         * didn't provide output buffer ensure ret contains
>> +         * the status code for standard RTAS calls.
>> +         */
>> +        ret = (nret > 0) ? be32_to_cpu(args->rets[0]) : 0;
>
> What is the need to find ret again? Isn't it already done above?
You are right. |ret|has already been determined above, so the 
|else|block is unnecessary.
>
>
>> +    }
>>         lockdep_unpin_lock(&rtas_lock, cookie);
>>       raw_spin_unlock_irqrestore(&rtas_lock, flags);
>


