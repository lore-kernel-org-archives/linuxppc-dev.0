Return-Path: <linuxppc-dev+bounces-24920-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 519DFC53219
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Jul 2026 06:02:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h8PyC5LKfz2yRl;
	Tue, 28 Jul 2026 16:02:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785218563;
	cv=none; b=XgGye2ytcYIcIogPEztHPzTW1D1b/DTSHc3Km2/dlJdkw+Jh39yXGUUsqznMhBEgsG+U7rJ/tSlD2+90+sbvcc3JDK+5F7CNRcuWkT4sJy8mYKvaozKSQDEqx/jzYT+Vg9mys/KbiRoaXYPD3MpU364/XB7Xd4kkHnhekkX6UZRyL4L3zIc+JyueaylcuWYkAZaoV/QS9/zrx2qhLoft6ZcvLOAGu4WwUVv0zZSpzyooiw2mFLztSQetit/9b1cRWQnAJ5RyE4mtUGjGOOnHTIESvRcf43Oty6m41ai0b+mRxBluE0oFw0rSWhIMWpy+9gbF7neyuGS+VezkDmhBig==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785218563; c=relaxed/relaxed;
	bh=1hTpZjmY+KevXXfF9+2W2a/kfJia4NBZ1slSnQmPFMo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aEapfMIETsO2cwhcbM8Wh+1os7BkAF6SiVe3aiBVPqI1Mfo8J1R5yh3sjqeLidLQ8ktEzQndc6QyF7NjYnQ+lN+7DOyNlTzNfwyjVQv1GufY9GzPjFPUll4XbCgCRNh6cL8Xgvxs+kbayB19DFKYZQdmyKeI5bmaEfol0lLJeGniNZp32TWAwi12RCsI6ZISp5dUsYDQ6lW/7X1w7r1ZIsZEZoNAG2qbJGBqOBVh/rEyqAIc41IOLWLFFUrzcFaqi0c5s2gfQ0Mf0MvptRdhO+3FlwFsL/kpM8B8HBVVj51W+MbL7eTHzWIVKsgH/pU1rpoIXdCptOkA4dhtCqRYHQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=lsopRFf+; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=lsopRFf+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h8Py95Kdsz2xRs
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2026 16:02:41 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66S3lgs44032412;
	Tue, 28 Jul 2026 06:02:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=1hTpZj
	mY+KevXXfF9+2W2a/kfJia4NBZ1slSnQmPFMo=; b=lsopRFf+kBLXnMTaSiRWMF
	kB9++f06empUiNWWi3nUh7/+dfv2HVY8dm4utBCpEmZbaUJbux9ccGJKCMCaW0iQ
	lH0evUGAF00xzl0rslM7THk3kIVSB9D+kXLZPZb5FGIslkEe4/jEQOAXdg847w3A
	ouLBKkZskk/9J6V7U2hFv665pmfBMWKlbj6uBHVAVoKNOO0jtJptN/pQdW0CxT7Y
	UIGtE5G0+kS42nVbHbNx6lPDOa36xUn5HaNvpLt7Md0KzjMBs4mN+KaMh5CUoyXU
	ncdpquGJN1eqsz4CXMHIb7ZucMZv55FCEgBj0JNCm9mhPL9OE17g1+x4CETw3aIw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyj35jj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 06:02:20 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66S5uJXu012881;
	Tue, 28 Jul 2026 06:02:19 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn7fq8pkw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 06:02:19 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66S62ITR57868586
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jul 2026 06:02:18 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A94C45804E;
	Tue, 28 Jul 2026 06:02:18 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2CD8A5803F;
	Tue, 28 Jul 2026 06:02:15 +0000 (GMT)
Received: from [9.43.35.153] (unknown [9.43.35.153])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Jul 2026 06:02:14 +0000 (GMT)
Message-ID: <b671b001-8120-4f50-90c8-3d0abf01300e@linux.ibm.com>
Date: Tue, 28 Jul 2026 11:32:12 +0530
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
Subject: Re: [PATCH] powerpc/ps3: Remove unused struct table in setup_areas()
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Thorsten Blum <thorsten.blum@linux.dev>,
        Geoff Levand <geoff@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20260712151300.3664-3-thorsten.blum@linux.dev>
 <a7f327e0-072b-41c9-ba95-361c948ddfa9@kernel.org>
Content-Language: en-US
From: Madhavan Srinivasan <maddy@linux.ibm.com>
In-Reply-To: <a7f327e0-072b-41c9-ba95-361c948ddfa9@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA1MSBTYWx0ZWRfX+3Bw5ZS7yUNu
 bn9OJj+nfdS5FroJwZfFrM5XEMMlZOGPR1pWGsSTgZxWcnQDGqmAL7ijxI2rsn4dd76pcaiOTXr
 GCw4TyW8xYdFlk4nqdhcuaONHJfENcQ=
X-Proofpoint-GUID: AKHND-7KOqfyc7BOFRFvNyeaMny4DSv6
X-Proofpoint-ORIG-GUID: 5oLaDeBnrxAJaU2Ev6CtIVrbg8fp3L9O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA1MSBTYWx0ZWRfX+nFOKjOCEYA+
 WIDUFOugF7Qv7wTJHZ8p8i3h5HARwjYvZU9D5/Fz9oGmLOL8DWhbbymjNjdgScO5MKX6n4pBv+u
 shTHYT9iCIrD2L02Ex0PI7GQFJWfDmiwq/gxoQ/K6Wtlpe6csDuE+zNZrhPZPNkgKqbkp+ULzHm
 jbZKik0y0kQlf7IHawGXEQuN/dv1P9mOtVNJAmLUSOQd9SXNYX0foH9btKrynwGOSGlF8sSB2Dv
 dysZi6AUMZLgE+uPccGkKH+9KJ/5GSaSYSgucJE3ZyNywqSI/vdq3D58w1R2Er+/4fZwqcrEo6/
 kEDBYB38Esa/Qxyh9LZHhHZkcw/bRHSyrWBXRpsXTqmAKUqyoSiSEIVrBshTwM/S6QxVqetrOA+
 qK2kHl7l7iyXZlsbabbQ+JOssDrGjDufPqLRAc+3x4g0UkFkgiW0sNyYIuUhJwYM7kbOoHV1v+S
 BiI4+yGFtfotQu/cRMQ==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a6845ec cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=sFLIR6f07ms7oJQzlQoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607280051


On 7/27/26 6:47 PM, Christophe Leroy (CS GROUP) wrote:
>
>
> Le 12/07/2026 à 17:13, Thorsten Blum a écrit :
>> The local table structure is not used - remove it.
>>
>> Remove % in the comment while at it.
>>
>> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
>
> Looks like it's never been used since commit de91a5342995 ("[POWERPC] 
> ps3: add spu support") that introduced it.
>
>
> Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
>
> I have no opinion about the %0 versus 0, is it worth the change ?
FYI.. I have added this patch as-is to my fixes-test
not waiting for v2
Maddy
>
>
>> ---
>>   arch/powerpc/platforms/ps3/spu.c | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/arch/powerpc/platforms/ps3/spu.c 
>> b/arch/powerpc/platforms/ps3/spu.c
>> index e817def7f424..c904f9fa1caa 100644
>> --- a/arch/powerpc/platforms/ps3/spu.c
>> +++ b/arch/powerpc/platforms/ps3/spu.c
>> @@ -185,13 +185,11 @@ static void spu_unmap(struct spu *spu)
>>    * The current HV requires the spu shadow regs to be mapped with the
>>    * PTE page protection bits set as read-only.
>>    *
>> - * Returns: %0 on success or -errno on error.
>> + * Returns: 0 on success or -errno on error.
>>    */
>>     static int __init setup_areas(struct spu *spu)
>>   {
>> -    struct table {char* name; unsigned long addr; unsigned long size;};
>> -
>>       spu_pdata(spu)->shadow = ioremap_prot(spu_pdata(spu)->shadow_addr,
>>                             sizeof(struct spe_shadow),
>> pgprot_noncached_wc(PAGE_KERNEL_RO));
>

