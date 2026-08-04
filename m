Return-Path: <linuxppc-dev+bounces-25334-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16E4CC55184
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Aug 2026 06:43:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDkWk5Gckz2yYs;
	Tue, 04 Aug 2026 16:43:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785825794;
	cv=none; b=YNPflEw6AZkTlDdJPmvN4i38PwtmM9i3tQZszS7sOIAZE7oiGIHGCddLTktBlw/HRvjiBcvDV9q8icAn/NK13Xcr2DdGXSO9xaSL5HkVQyMojeHTZRNyf6Wf/z2mUPY+SuHlUJjjfHZ6aYdw4BPIIjljXkWbS3xqV3PeO1Loh5cB+qym2hZyE9jCgj3MYIy7BXfZ9KJh67s2IJaUzHfiOk2PDbzTq0aeMTwFT0diXsSVKHuOZ3zm4oahfnzDKqF299gckSHt1DEQjQ14tWFIQpMCwJWRInWEaqN1w+wmWq323VFxPA6AVQ6nZIk2G9zgjqsMsfPqv8rt4Pp4BD2bYg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785825794; c=relaxed/relaxed;
	bh=E46BuBe1ir96BTE4VsFEW/3HS0Yksm0TaZJIPPYEmh4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H5n3U3a+k8y2KY2QClKqbteJqfNhrYW2Cc9pmWaQUT+SbSctoM+vBO5o0XXXcOygvaHn3yRXDyoeQgBtfAwImX7PwSq5lancUbnfj8nJbIp1tz1Ec7hWUzJHUS6/t/KFMBQL8kxfTm57d0DJMXtGLKhLHXnFII++APyvZC8CmZrs97fqEs/9X6VOxfIOXaG9Q3D6WXnFrSNxXsbhSHrXJiEN/gwEz29zkEGlTY3ty6amNEcxkkUpBJJXnSDkIuCRRar2N3fs7mhfA5avpkmB8uCCjSwnfKcLZitM6ZLRC3YceEeEe9FR0ypaVXxnS/X/UjXFnm9JEY46SkQNrVpHwQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NGI0dv8G; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NGI0dv8G;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDkWj6cV9z2xpn
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2026 16:43:13 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6741JoTM3575520;
	Tue, 4 Aug 2026 06:43:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=E46BuB
	e1ir96BTE4VsFEW/3HS0Yksm0TaZJIPPYEmh4=; b=NGI0dv8G3inNu4xeUuUTd6
	Fg6NkZjghZd6qxI0bgxxO0GyRRTrKvqeUhuIymlY+pEl7LGss1QqfSzjek0DZPnU
	oVENUQtcyZW7zJQv/DAz1MNp6bhG0JEfyS4w7aETNHAbvcxUK6arjgGyHcFJVuGY
	s7sJRc8qTv0+ODNsm4+Zf0yastHirxP4xPdXEkSOR627hWdTzEuMqdT9F688JNF9
	VAF2W2ahYiw2K3bIz/0a3/DM/gm2QJxPODr0hX1ezhxoT77FmMib0pR0da5Sq3sr
	30ksk+Uc8wwCv4lLm4VD0nZPtnlYyDVjq9v9HBjoSC6PC8HqxRKbEaXgbAHR+rFg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs67hmdar-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 06:43:01 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6746fRwf016774;
	Tue, 4 Aug 2026 06:43:00 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsv4k0su9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 06:43:00 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6746gsbi31982324
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Aug 2026 06:42:54 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 96D5F20043;
	Tue,  4 Aug 2026 06:42:54 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D670820040;
	Tue,  4 Aug 2026 06:42:49 +0000 (GMT)
Received: from [9.123.6.250] (unknown [9.123.6.250])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Aug 2026 06:42:49 +0000 (GMT)
Message-ID: <6b52e126-e756-4323-856d-7f607d3ff12c@linux.ibm.com>
Date: Tue, 4 Aug 2026 12:12:48 +0530
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
Subject: Re: [PATCH v2 5/5] powerpc/powernv: Map EEH error types to OPAL error
 injection types
To: Sourabh Jain <sourabhjain@linux.ibm.com>, mahesh@linux.ibm.com,
        maddy@linux.ibm.com, mpe@ellerman.id.au, christophe.leroy@csgroup.eu,
        gregkh@linuxfoundation.org, oohall@gmail.com, npiggin@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        tyreld@linux.ibm.com, vaibhav@linux.ibm.com, sbhat@linux.ibm.com,
        ganeshgr@linux.ibm.com, haren@linux.ibm.com, thuth@redhat.com
References: <20260527072433.94510-1-nnmlinux@linux.ibm.com>
 <20260527072433.94510-6-nnmlinux@linux.ibm.com>
 <6e1ec392-ad56-4625-9b44-2def6065bbc1@linux.ibm.com>
Content-Language: en-US
From: Narayana Murty N <nnmlinux@linux.ibm.com>
In-Reply-To: <6e1ec392-ad56-4625-9b44-2def6065bbc1@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA0OCBTYWx0ZWRfX9ZSuQfBaIldW
 Po+6JEYH7wt8nF97CpnTEWVRKk9E/arDym1mIrjlNKl0a3DEEOpyqp6BIQGb8GlyysGC5Qxyb7G
 mxJSn6gNRcnLPmVrHoS3IGJDL7Ea6tk=
X-Authority-Analysis: v=2.4 cv=I7VVgtgg c=1 sm=1 tr=0 ts=6a7189f5 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=8L8SCsDQS6Sdzd3lfRIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA0OCBTYWx0ZWRfX0yXPfrP0z205
 SclU8GVWd9W7fp3C+9G2eqmge/TuvumtpQAtCJpsdJFsT4y7sJUamsDJaYDW7uXh+NBL4b3FyuZ
 gKNcX19M+xqhk/Cb9mvlL5R8kY8DqyzYYfgR8pWylku6ulWzpqeQNMYZumZk1QOmSeY5mIsbAxQ
 2aUoTxfd7coxR95hKo8phqg66ISX/6FOKhEzAftJSITCFquJ4uVfag5vuPtSrdR3UcYVXDRtEha
 m6OLPkV2fI+1EaPhtnwysp2sNfPVcJ1FMS8krlwpvu+8q+rw+CBP2FILwoxZ4kcQldGNdmlZoZp
 8yuZsVKpLmVj6zuV0Oxi24HXzaOPZSSaWilqY0VjVY1Eqd+P3BtHabGXWB+Zo0SJWVNp8oAsZxG
 yQlxtYTuRFXU1ldoQ6BlAZoTcK3tfHTaqGQAAKRdq/VwaSsnRfWhUDtE1r9S0X5ISfTVUkk4wMb
 6LonaieltZCZO6GTATQ==
X-Proofpoint-ORIG-GUID: 4opSXf2SpfPPpI6fLZIvPdmqCifVmSh6
X-Proofpoint-GUID: DjX4SLU-qoo153eCtN4hqNukqaiWkBsW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_01,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040048

Hi Sourabh,

On 07/06/26 7:16 PM, Sourabh Jain wrote:
> With the cover letter, this patch series seems to be about RTAS/pseries.
>
> I am not able to understand why powernv changes are part of this
> patch series. Could you please explain why they are included here? 
Thanks for raising this.
Although most of the series implements RTAS error injection for pseries,
it also updates the generic EEH error types used through the 
|VFIO_EEH_PE_INJECT_ERR|interface.
Userspace passes the generic |EEH_ERR_TYPE_32|or |EEH_ERR_TYPE_64|value 
through VFIO.
On PowerNV, |pnv_eeh_err_inject()|must translate that generic EEH value 
to the corresponding
platform-specific value:
|EEH_ERR_TYPE_32 -> OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR EEH_ERR_TYPE_64 -> 
OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR64|
Without this translation, the generic error types introduced for the 
VFIO/EEH interface would
be passed directly to OPAL and could be interpreted incorrectly.
I have clarified this dependency in the v3 cover letter and PowerNV 
patch description:
[PATCH v3 5/5] powerpc/powernv: Map generic EEH error types to OPAL types
Thanks,
Narayana
> On 27/05/26 12:54, Narayana Murty N wrote:
>> Add a mapping layer in pnv_eeh_err_inject() to translate generic EEH
>> error types to OPAL-specific error injection types. This decouples the
>> VFIO error injection interface from OPAL implementation details.
>>
>> Map EEH_ERR_TYPE_32 to OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR and
>> EEH_ERR_TYPE_64 to OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR64. Return -EINVAL
>> for unsupported error types.
>>
>> This provides better abstraction between the generic EEH layer and
>> platform-specific implementation.
>>
>> Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
>> ---
>>   arch/powerpc/include/uapi/asm/eeh.h          | 20 ++++++++++++++++++--
>>   arch/powerpc/platforms/powernv/eeh-powernv.c | 11 +++++++++--
>>   2 files changed, 27 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/powerpc/include/uapi/asm/eeh.h 
>> b/arch/powerpc/include/uapi/asm/eeh.h
>> index 86645cab2827..d88d82796905 100644
>> --- a/arch/powerpc/include/uapi/asm/eeh.h
>> +++ b/arch/powerpc/include/uapi/asm/eeh.h
>> @@ -16,8 +16,24 @@
>>   #define EEH_PE_STATE_UNAVAIL        5    /* Unavailable        */
>>     /* EEH error types and functions */
>> -#define EEH_ERR_TYPE_32            0       /* 32-bits error    */
>> -#define EEH_ERR_TYPE_64            1       /* 64-bits error    */
>> +#define EEH_ERR_TYPE_FATAL                  0x1   /* Fatal error */
>> +#define EEH_ERR_TYPE_RECOVERED_RANDOM       0x2   /* Recovered 
>> random event */
>> +#define EEH_ERR_TYPE_RECOVERED_SPECIAL      0x3   /* Recovered 
>> special event */
>> +#define EEH_ERR_TYPE_CORRUPTED_PAGE         0x4   /* Corrupted page */
>> +#define EEH_ERR_TYPE_CORRUPTED_SLB          0x5   /* Corrupted SLB */
>> +#define EEH_ERR_TYPE_TRANSLATOR_FAILURE     0x6   /* Translator 
>> failure */
>> +#define EEH_ERR_TYPE_32                     0x7   /* 32-bit IOA bus 
>> error */
>> +#define EEH_ERR_TYPE_PLATFORM_SPECIFIC      0x8   /* Platform 
>> specific */
>> +#define EEH_ERR_TYPE_CORRUPTED_DCACHE_START 0x9   /* Corrupted 
>> D-cache start */
>> +#define EEH_ERR_TYPE_CORRUPTED_DCACHE_END   0xA   /* Corrupted 
>> D-cache end */
>> +#define EEH_ERR_TYPE_CORRUPTED_ICACHE_START 0xB   /* Corrupted 
>> I-cache start */
>> +#define EEH_ERR_TYPE_CORRUPTED_ICACHE_END   0xC   /* Corrupted 
>> I-cache end */
>> +#define EEH_ERR_TYPE_CORRUPTED_TLB_START    0xD   /* Corrupted TLB 
>> start */
>> +#define EEH_ERR_TYPE_CORRUPTED_TLB_END      0xE   /* Corrupted TLB 
>> end */
>> +#define EEH_ERR_TYPE_64                     0xF   /* 64-bit IOA bus 
>> error */
>> +#define EEH_ERR_TYPE_UPSTREAM_IO_ERROR      0x10  /* Upstream IO 
>> error */
>> +
>> +/* EEH supported function types */
>>   #define EEH_ERR_FUNC_MIN        0
>>   #define EEH_ERR_FUNC_LD_MEM_ADDR    0    /* Memory load */
>>   #define EEH_ERR_FUNC_LD_MEM_DATA    1
>> diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c 
>> b/arch/powerpc/platforms/powernv/eeh-powernv.c
>> index db3370d1673c..ee156d397e93 100644
>> --- a/arch/powerpc/platforms/powernv/eeh-powernv.c
>> +++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
>> @@ -1169,8 +1169,15 @@ static int pnv_eeh_err_inject(struct eeh_pe 
>> *pe, int type, int func,
>>       struct pnv_phb *phb = hose->private_data;
>>       s64 rc;
>>   -    if (type != OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR &&
>> -        type != OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR64) {
>> +    /* Map generic EEH Type to OPAL Type */
>> +    switch (type) {
>> +    case EEH_ERR_TYPE_32:
>> +        type = OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR;
>> +        break;
>> +    case EEH_ERR_TYPE_64:
>> +        type = OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR64;
>> +        break;
>> +    default:
>>           pr_warn("%s: Invalid error type %d\n",
>>               __func__, type);
>>           return -ERANGE;
>


