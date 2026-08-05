Return-Path: <linuxppc-dev+bounces-25412-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F467C55174
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Aug 2026 06:24:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hFL3G3sl2z2xpn;
	Wed, 05 Aug 2026 16:24:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785911050;
	cv=none; b=ap/swM1PctjQu+z7H6Ta/dYpd8BGvrW1FpIbrFE2NSNJFUAo1YBYp0iqa7d1CRKrKSSitq/AMhC0YRXNZvgtV94SK/iYtannhR3uWiDE0HCpnUAkexWUNnHfbG/c6ZrSaj6+0KcS5lSLim8pqq3CabpTUM9tqCDghla33JzSku0BRWtDEIZnX9a0fELVGFOfzO5rC/7yI0cjtpbGpz9Ba24pCxQlp2UcybVNExVCfZqSm9IB9p/VbQsqE1MpQoRa7IhMIIGcxEg2MrvNlW0qyvDGK2yoLLO+eUnpjiRmriDzbgaGaWnZTBewrZc61jkK7DH3yRsBAspPu6id1A48Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785911050; c=relaxed/relaxed;
	bh=c1+8lM3tj6KEd56E+b8j+kaVjbePjJ36xGoT3DVX5RI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XrkqlOUdJvandlDf7KXhOLh3veIXLkzmgZ4GRClielI4XtQEOT+B701Fkh+0QHVbQNmrv7Y2fP9GLrh8EJ8wElbkKgPMuc0xBLl5bvspCPzFDnfFz0B48sUwPdYFkgBkTQADjXDGVYfS4vCU9Gyv1BHsI4cPf2+miUaX+c1ItJyH8LCR/ezEZRboT/AplihZ/lFV7WoCJAPZxPuqrhF3x8hPYRJkma8RsUnioYzU82IPodqRahhPF8VnWvumCbrzt+ZpLk/59n0ujb0Y/K9Uz0anXPWwsmCgWgBfPh9RGyID08wmEvEStC7Z4gkx4KaFBfaOP935kLqCPJqUNjuSHA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=jMy3EkWx; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=jMy3EkWx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hFL3F3ptTz2xl5
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Aug 2026 16:24:09 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6755m0mv2973666;
	Wed, 5 Aug 2026 06:23:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=c1+8lM
	3tj6KEd56E+b8j+kaVjbePjJ36xGoT3DVX5RI=; b=jMy3EkWxtrLtTjGu5Yvc/o
	aj41F/GeK1zn0kZasviGYDacx83DPaxzqtaGM/rt4V5r+oWTPKtGSQ7Ck/DizTcK
	S9XALXCuGFavG6f/6yMLy7+oBl+3QN4X0kYs+sujGHvyLOx5ssTuQ7AuLOdUKaqP
	5aTmBTf5XFEUQ21ezbIzvo5KQ9ihxSczHoPrfNZUJebWF98iP8VAWvqhSu/00RIt
	lUgR71xsxBinv7H7EFhHNIDm6mcmjzkA9gPC1WtLuPPpNzDfczjfzAVCPYwOrR2J
	b+HPUMbEDb5WQKXLlH3IMaujfTwVStO/17AuMJCMjZXj1Ui5hjMCgz7ZA41JkpyQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8a41m0v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 06:23:51 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6756BJa3009159;
	Wed, 5 Aug 2026 06:23:50 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbgd43p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 06:23:50 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6756Nj2639649768
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Aug 2026 06:23:45 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 450DD20043;
	Wed,  5 Aug 2026 06:23:45 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4B41320040;
	Wed,  5 Aug 2026 06:23:42 +0000 (GMT)
Received: from [9.123.6.250] (unknown [9.123.6.250])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Aug 2026 06:23:42 +0000 (GMT)
Message-ID: <1e9ba55b-9126-419e-9dc1-c560822b11db@linux.ibm.com>
Date: Wed, 5 Aug 2026 11:53:41 +0530
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
To: Sourabh Jain <sourabhjain@linux.ibm.com>, mahesh@linux.ibm.com,
        maddy@linux.ibm.com, mpe@ellerman.id.au, christophe.leroy@csgroup.eu,
        gregkh@linuxfoundation.org, oohall@gmail.com, npiggin@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        tyreld@linux.ibm.com, vaibhav@linux.ibm.com, sbhat@linux.ibm.com,
        ganeshgr@linux.ibm.com, haren@linux.ibm.com, thuth@redhat.com
References: <20260721033815.5300-1-nnmlinux@linux.ibm.com>
 <20260721033815.5300-6-nnmlinux@linux.ibm.com>
 <09563f43-9514-4fc2-9e90-f9ad9f528bea@linux.ibm.com>
Content-Language: en-US
From: Narayana Murty N <nnmlinux@linux.ibm.com>
In-Reply-To: <09563f43-9514-4fc2-9e90-f9ad9f528bea@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=E6P9Y6dl c=1 sm=1 tr=0 ts=6a72d6f8 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=DA49UyA9n3PBBVtv_i8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 1Es3EXTjr-rHEwG-17giIJ2Qp1kjtq3u
X-Proofpoint-GUID: xbJGgcVPvUiycpV_UHPlVfKRSIAkX4rS
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA0NyBTYWx0ZWRfXwzt0q0PtfU/O
 G8fBO1xxotDd4cGF8+IygV+oH2t1RtZauH2Xbi9GCNhn011ZQCFbbUX0u0RA0BcmGyachdFByB4
 +tWnbk5tNr5nc4TjcTHNU6RCvWpPeoE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA0NyBTYWx0ZWRfX5PcjtYtSFGqk
 PmyEHB20hRaUUzMEDD29T7I3TK6RPjd3+n3zTa5STI0pNKo5pYxwmS+nRstZoaLu9g6LdD1Qm82
 FvdnVUTs49CW3+iBsgam3MIAns6mMSH3zWsn45MK9dyVHSThpeJPfJtljdWJDGgEku2mNHMPV8c
 mvCR/9A/ocbFisEupaVNLAbKqJAvg/Tw8abJtjFm4lmGefiiJblUCEnSzaiM3T/liJK5Ys3OE6v
 U1NG++eiPm0gtFG7eLkkatW0T4iN2Hmx7HqDxwasAcWVYhFWln9y4F+76TQqoEZCPifNt645HKw
 RMUde5D6NScSW21JeeAar7rc3FNAC3KgU7KAW1prP9cOhh1fzAJsProZd0137b55zDGoYXIbnNW
 Ugceg1bGBYgmyAvrZetF7Su/gWQb7EoydAvQk6b5Rcv54nsEOt0VdBvMuQva51zuJhmjSANkDVI
 4rn8sUoJ2DyguqcI3+w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_02,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608050047

Hi Sourabh,

On 05/08/26 12:01 AM, Sourabh Jain wrote:
>
>
> As per the title this series is about RTAS-based error injection on 
> pSeries.
>
> Then why do we have powernv/opal patch part of this series?
>
> - Sourabh Jain
>
The guest running on povernv host also a pseries guest. VFIO will take 
care of
translating the calls to respective platforms. So as a platform 
comparability
the changes are made in this series.

Regards,
Narayana.

>
> On 21/07/26 09:08, Narayana Murty N wrote:
>> The EEH error-injection interface passes the generic userspace ABI
>> values EEH_ERR_TYPE_32 and EEH_ERR_TYPE_64 to the platform backend.
>>
>> The PowerNV backend currently compares those generic values directly
>> with OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR and
>> OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR64. Although the corresponding values
>> are currently numerically identical, this implicitly couples the
>> generic EEH ABI to the OPAL firmware encoding.
>>
>> Explicitly translate the generic EEH error types to their OPAL
>> equivalents in pnv_eeh_err_inject(). Keep the platform-specific
>> encoding within the PowerNV backend and reject unsupported generic
>> types with -EINVAL.
>>
>> No userspace ABI values are changed.
>>
>> Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
>> ---
>>   arch/powerpc/platforms/powernv/eeh-powernv.c | 36 +++++++++++++++++---
>>   1 file changed, 32 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c 
>> b/arch/powerpc/platforms/powernv/eeh-powernv.c
>> index db3370d1673c..b0bcd014a133 100644
>> --- a/arch/powerpc/platforms/powernv/eeh-powernv.c
>> +++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
>> @@ -1169,11 +1169,39 @@ static int pnv_eeh_err_inject(struct eeh_pe 
>> *pe, int type, int func,
>>       struct pnv_phb *phb = hose->private_data;
>>       s64 rc;
>>   -    if (type != OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR &&
>> -        type != OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR64) {
>> -        pr_warn("%s: Invalid error type %d\n",
>> +    /*
>> +     * Map generic EEH error-type ABI values to OPAL-specific type 
>> codes.
>> +     * EEH_ERR_TYPE_32 and EEH_ERR_TYPE_64 are the only types 
>> supported by
>> +     * OPAL.  Additional generic types defined in the UAPI header 
>> are valid
>> +     * for pSeries RTAS but unsupported here; return -EOPNOTSUPP for 
>> those.
>> +     * Unknown or invalid values return -EINVAL.
>> +     *
>> +     * Note: currently OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR  == 0 ==
>> +     * EEH_ERR_TYPE_32 and OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR64 == 1 ==
>> +     * EEH_ERR_TYPE_64, but the explicit switch makes the coupling
>> +     * visible and allows the values to diverge independently.
>> +     */
>> +    switch (type) {
>> +    case EEH_ERR_TYPE_32:
>> +        type = OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR;
>> +        break;
>> +    case EEH_ERR_TYPE_64:
>> +        type = OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR64;
>> +        break;
>> +    case EEH_ERR_TYPE_RECOVERED_SPECIAL_EVENT:
>> +    case EEH_ERR_TYPE_CORRUPTED_PAGE:
>> +    case EEH_ERR_TYPE_CORRUPTED_DCACHE_START:
>> +    case EEH_ERR_TYPE_CORRUPTED_DCACHE_END:
>> +    case EEH_ERR_TYPE_CORRUPTED_ICACHE_START:
>> +    case EEH_ERR_TYPE_CORRUPTED_ICACHE_END:
>> +    case EEH_ERR_TYPE_CORRUPTED_TLB_START:
>> +    case EEH_ERR_TYPE_CORRUPTED_TLB_END:
>> +        pr_warn("%s: EEH error type %d not supported by OPAL\n",
>>               __func__, type);
>> -        return -ERANGE;
>> +        return -EOPNOTSUPP;
>> +    default:
>> +        pr_warn("%s: unsupported EEH error type %d\n", __func__, type);
>> +        return -EINVAL;
>>       }
>>         if (func < OPAL_ERR_INJECT_FUNC_IOA_LD_MEM_ADDR ||
>


