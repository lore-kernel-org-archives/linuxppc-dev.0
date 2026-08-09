Return-Path: <linuxppc-dev+bounces-25650-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81628C5AD4E
	for <linuxppc-dev@archiver.kernel.org>; Sun,  9 Aug 2026 12:01:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hHxLh1L86z2xd2;
	Sun, 09 Aug 2026 22:01:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786276892;
	cv=none; b=K4d1rSO96UUqigIGlQaqgWcGIq1ciGbOoGqPYGZOY3B7QwEbgKsxVVOXlNHHkc39uETUnoM0RpHhS1rGH5WDbg4QS4fdli/pLWTnqYNwEm6gF1UKByuc+KmgkBgkQjDMlucx0TpImoyEtj7tbU1bJwyONzdmLkRpFO/z/juECACcNae8/AhqEwIb0OPN6Dl0qMV91KEaJD/5P1DuIKPoGcdkOmZrH+kWt7R7Py0S/yp9B7s+X960pEMLqekVeUojDyAM/DQ/Sel2E+xywvvdIMTyGxOADwsb43z5yffTsDVzKP05RoIUJ1/PTDdkawxzAWCId/bxiJ1qFWoBQniT8w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786276892; c=relaxed/relaxed;
	bh=PZNso8M0WCQotXFrWX+MQSJY/WVGUHb+aagWN7VJTWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QvHk8vLK/c/QhQLJ4oS4VLCoNUfOgKS26/F5NcCxQdGFxFc5ofC44B9GMwbo2ZK5Jc2s5fvngQxQYrmMh5176BuOm7mqA20gWDZXIUbCYE41OMYY/4Aj2RCrmpnkrHpddU+ypwGr5DnA5X/fflWde0YOl7d3JZz4tf7MEsTyJWJDd4Onm5XzhNQQA3h7dVHWzjG2fXBFD+vDTLTWxjtuLfmh6PUSn14Nw3YMYr6NZnPFRo8Tlb5cx/y0XSxaG1gQwn6l0fEK6qiAasEm2DJZ2R82Nl/U1wjP50ARL1kgQVq7UHFH5J+JVAi1EfeKgb5NDVs8jllCv6Z5u9rF+Z5e/A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=XVhQhlI0; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=XVhQhlI0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hHxLg3Jn9z2xLq
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 09 Aug 2026 22:01:31 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67992DJ2700353;
	Sun, 9 Aug 2026 12:01:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=PZNso8
	M0WCQotXFrWX+MQSJY/WVGUHb+aagWN7VJTWM=; b=XVhQhlI0aKkiH98Z5uR310
	SdJ+rodsNY41juDNMhRPc3ZdVcnRfLL8FocZl1rpAAZqAYmv/WAMg/LgzdhM3/qD
	bi1Qbfekpiv8FAi+8fHz2A1A77FTGGEF2IH/MDgKB/D2PUXBsAv4wdHhWAdF+9sl
	YijZ6A8L/8j9/cxVkyrGy8kdd3SgMu8jQ2ryqqw4nOxaxcIWbFP33Qt+XwAr3WfT
	NAYS7qVgCLG4eD8Fx2FmfOz+rbZiGIQ6ZTyB3O/xvjCBl0BBppoNRFUmyMDtr4E8
	k9KkGGZdtG+7HIsQhKDBz8pr0GS3hCDTUUadS1wqrud82wK3uLCMqvu+K9z10o0Q
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvjym3qm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 09 Aug 2026 12:01:12 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 679BuLjb001858;
	Sun, 9 Aug 2026 12:01:11 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxg9gs5qq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 09 Aug 2026 12:01:11 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 679C16qD53412120
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 9 Aug 2026 12:01:06 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 300132004B;
	Sun,  9 Aug 2026 12:01:06 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7DF7E20040;
	Sun,  9 Aug 2026 12:01:01 +0000 (GMT)
Received: from [9.39.25.10] (unknown [9.39.25.10])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  9 Aug 2026 12:01:01 +0000 (GMT)
Message-ID: <da980fd2-cab1-4834-b4d5-49bdffa29726@linux.ibm.com>
Date: Sun, 9 Aug 2026 17:30:59 +0530
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
Subject: Re: [PATCH v3 5/5] powerpc/powernv/eeh: Map VFIO EEH error injection
 to OPAL
To: Narayana Murty N <nnmlinux@linux.ibm.com>, mahesh@linux.ibm.com,
        maddy@linux.ibm.com, mpe@ellerman.id.au, christophe.leroy@csgroup.eu,
        gregkh@linuxfoundation.org, oohall@gmail.com, npiggin@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        tyreld@linux.ibm.com, vaibhav@linux.ibm.com, sbhat@linux.ibm.com,
        ganeshgr@linux.ibm.com, haren@linux.ibm.com, thuth@redhat.com
References: <20260721033815.5300-1-nnmlinux@linux.ibm.com>
 <20260721033815.5300-6-nnmlinux@linux.ibm.com>
 <09563f43-9514-4fc2-9e90-f9ad9f528bea@linux.ibm.com>
 <1e9ba55b-9126-419e-9dc1-c560822b11db@linux.ibm.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <1e9ba55b-9126-419e-9dc1-c560822b11db@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA5MDEwMiBTYWx0ZWRfX8nHEAuaD1uvh
 fDu9k0OmypGTKF+iLZknX2ijGFEDegF89hdK1crV7C5O5e/ivZulWM6issXKTLPxHk7jeqGmUMX
 rzvGWGa9+8nYDvpUm0/9j6MQpjuGzS4KDuZkgbZGj0ktKuXHfIXBquW3WUNSzCKO0Bn6e2qJcBE
 pptzVW5TkojcI9EdlLk3cSpDvUFtaOEywC9mK84B2ZF7BS1Q6XXTBJWXzlfr275P+PLHW55SJPB
 r9ZakJ0z413XsuTWDnmMXD/C+6OA39Dy2/gORFQMUq/SpH15crVELm9/N8nxNvHigGFEQ1LoGAI
 W6VNYVT6kMXc15yvXGsgjvSFdsrdZSO/7s3KEDuAqleyVCKRHh1Bwjt6V6xAjCEXUE7UgpiU7zJ
 FPeHvdnLorcwawnmq3t6kVIsaRzaKujgHb7ETMZB6ennXAI6fQvafAPiLt8Zl42msQ7dvZQeW2m
 tVhyZiEp8h46TaXKWPA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA5MDEwMiBTYWx0ZWRfXxPv+e4oTJqaz
 kdAbGRLdNb1wDT93NzjLt/qPNTgwQ1MLZmweru45IQnHClanqaNXK9A2n6IDsHnwPB9ct6CEJoP
 rqPfJL3k7oskpA1c53yhrBaCme027wc=
X-Authority-Analysis: v=2.4 cv=RqD16imK c=1 sm=1 tr=0 ts=6a786c09 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=R0wg1pFwKw7Bkwto0rUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: u5Rt_fc_cfoOX_qq0CArAMWzFMcF-NLJ
X-Proofpoint-ORIG-GUID: fvz1QgexrT6UhtfAo-K0icULxs3w9JXF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-09_03,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608090102



On 05/08/26 11:53, Narayana Murty N wrote:
> Hi Sourabh,
>
> On 05/08/26 12:01 AM, Sourabh Jain wrote:
>>
>>
>> As per the title this series is about RTAS-based error injection on 
>> pSeries.
>>
>> Then why do we have powernv/opal patch part of this series?
>>
>> - Sourabh Jain
>>
> The guest running on povernv host also a pseries guest. VFIO will take 
> care of
> translating the calls to respective platforms. So as a platform 
> comparability
> the changes are made in this series.

Oh, okay. These changes are for a pSeries guest running on a PowerNV 
platform.
Thanks for the clarification.

- Sourabh Jain

>
> Regards,
> Narayana.
>
>>
>> On 21/07/26 09:08, Narayana Murty N wrote:
>>> The EEH error-injection interface passes the generic userspace ABI
>>> values EEH_ERR_TYPE_32 and EEH_ERR_TYPE_64 to the platform backend.
>>>
>>> The PowerNV backend currently compares those generic values directly
>>> with OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR and
>>> OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR64. Although the corresponding values
>>> are currently numerically identical, this implicitly couples the
>>> generic EEH ABI to the OPAL firmware encoding.
>>>
>>> Explicitly translate the generic EEH error types to their OPAL
>>> equivalents in pnv_eeh_err_inject(). Keep the platform-specific
>>> encoding within the PowerNV backend and reject unsupported generic
>>> types with -EINVAL.
>>>
>>> No userspace ABI values are changed.
>>>
>>> Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
>>> ---
>>>   arch/powerpc/platforms/powernv/eeh-powernv.c | 36 
>>> +++++++++++++++++---
>>>   1 file changed, 32 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c 
>>> b/arch/powerpc/platforms/powernv/eeh-powernv.c
>>> index db3370d1673c..b0bcd014a133 100644
>>> --- a/arch/powerpc/platforms/powernv/eeh-powernv.c
>>> +++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
>>> @@ -1169,11 +1169,39 @@ static int pnv_eeh_err_inject(struct eeh_pe 
>>> *pe, int type, int func,
>>>       struct pnv_phb *phb = hose->private_data;
>>>       s64 rc;
>>>   -    if (type != OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR &&
>>> -        type != OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR64) {
>>> -        pr_warn("%s: Invalid error type %d\n",
>>> +    /*
>>> +     * Map generic EEH error-type ABI values to OPAL-specific type 
>>> codes.
>>> +     * EEH_ERR_TYPE_32 and EEH_ERR_TYPE_64 are the only types 
>>> supported by
>>> +     * OPAL.  Additional generic types defined in the UAPI header 
>>> are valid
>>> +     * for pSeries RTAS but unsupported here; return -EOPNOTSUPP 
>>> for those.
>>> +     * Unknown or invalid values return -EINVAL.
>>> +     *
>>> +     * Note: currently OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR  == 0 ==
>>> +     * EEH_ERR_TYPE_32 and OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR64 == 1 ==
>>> +     * EEH_ERR_TYPE_64, but the explicit switch makes the coupling
>>> +     * visible and allows the values to diverge independently.
>>> +     */
>>> +    switch (type) {
>>> +    case EEH_ERR_TYPE_32:
>>> +        type = OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR;
>>> +        break;
>>> +    case EEH_ERR_TYPE_64:
>>> +        type = OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR64;
>>> +        break;
>>> +    case EEH_ERR_TYPE_RECOVERED_SPECIAL_EVENT:
>>> +    case EEH_ERR_TYPE_CORRUPTED_PAGE:
>>> +    case EEH_ERR_TYPE_CORRUPTED_DCACHE_START:
>>> +    case EEH_ERR_TYPE_CORRUPTED_DCACHE_END:
>>> +    case EEH_ERR_TYPE_CORRUPTED_ICACHE_START:
>>> +    case EEH_ERR_TYPE_CORRUPTED_ICACHE_END:
>>> +    case EEH_ERR_TYPE_CORRUPTED_TLB_START:
>>> +    case EEH_ERR_TYPE_CORRUPTED_TLB_END:
>>> +        pr_warn("%s: EEH error type %d not supported by OPAL\n",
>>>               __func__, type);
>>> -        return -ERANGE;
>>> +        return -EOPNOTSUPP;
>>> +    default:
>>> +        pr_warn("%s: unsupported EEH error type %d\n", __func__, 
>>> type);
>>> +        return -EINVAL;
>>>       }
>>>         if (func < OPAL_ERR_INJECT_FUNC_IOA_LD_MEM_ADDR ||
>>
>


