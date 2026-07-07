Return-Path: <linuxppc-dev+bounces-23680-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5727EC44500
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2026 07:32:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gvXxh5k2lz3brt;
	Tue, 07 Jul 2026 17:32:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783409560;
	cv=none; b=CNkS/6AUHZfVjMvK54f1wDJpZrpKEjATRwaT9wfzItRyO8vBVZBhhqF/ae/HjgpFGqn1gdxTryagvkVuIF1NsaEf/DU2c0FciIziSqIeeCcuM7/6lNQ+J0pxyeZ9/rEBgb9nL0YcxEl4gzeeseif/aI2gaTuHNezLAiBZU8mt2VwbMXHeRaZLk4IxjMiAJyHoAv5olObjXDwlEUHi/gS6nQpiaZB7xf8ZAkYuHS5nuVipzvyjtwzf1yrmMb8RUi8qA8XHf6b0rqOh6EO60/rCX32aMcDEDmwkWOxul4zyrJ8B0h9N26BaMA2ZV2caSSRW0duSdoJn9sRRYCN+g8vRg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783409560; c=relaxed/relaxed;
	bh=mO/PC7arUvA+fcxxe3so7PQuim0CJamBIem3M16Sa1M=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XS2uzkCBzmBfwxFQOj0mB2lP89Ti7odOuXMVjbIQF6zGdN7xqwt85rYRfy5tmV+Ugr1Ez4HfplC6UeXsqO3L/OqAeWWyt7Yg31U28EDoR0ePW9WxuO8pGWseuGxKP9N/ecGSDdCVy0GJE5qQ4NyTBCTy2LHYLwP+JvfH6PGb3IFtYOKzPakJ5rdgAd6UaW9UxAF+Ge41qEz0m+5A2pjr6FCU8MyRJbmcc+n9oOuVSpiYYF0og1j99BgAmEI/As+N4+LYaBbEkdVC/fSvBCEDqfyfHM/FYaSDwfbgigk01oHlnfpGZlyd0eAWehHMeBnPfGAf0eUXFRlpykf2/Kpyeg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Z04kE1eZ; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=nikhilks@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Z04kE1eZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=nikhilks@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gvXxg6C0Wz2yR5
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Jul 2026 17:32:39 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6674IUH51630234
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Jul 2026 07:32:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=mO/PC7
	arUvA+fcxxe3so7PQuim0CJamBIem3M16Sa1M=; b=Z04kE1eZEioQAPIIkbazzP
	T/lUh1ru6DX73hShIM468Wct/GjkSk67McBCEXFx175g8D+LKsFOTkSxvIPkrHeI
	1NbheN4+QXaSAV5A2b9lOMpoNU3WQSgFi6di/kGZqjEQtBpgfAx9oPJziV176v8p
	sr49H5HiNmWc/knuti/ljtzs5/cqEC4J3/C01gHeTFFcam2dLbOBxFzfG7Xt9Upa
	5vHzXgeNSn1fmkT5ehyH+YM9G29hz7HPcjnw9XG8IRipTXUuOLv61vLum7YPJVXG
	KdptZLAQP4SOjYhGo9fUp40hs6Z033HSJqSX81Nk+ucDAZg/vwnOV7ZJdjtkIFkQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6stsp6m6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Jul 2026 07:32:36 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6677Jbbk008573
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Jul 2026 07:32:36 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7e0h9esh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Jul 2026 07:32:36 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6677WYl327132414
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Jul 2026 07:32:34 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 33D3E2004E
	for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Jul 2026 07:32:34 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5E35120049
	for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Jul 2026 07:32:33 +0000 (GMT)
Received: from [9.67.174.189] (unknown [9.67.174.189])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP
	for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Jul 2026 07:32:32 +0000 (GMT)
Message-ID: <181d1951-b5f9-4057-92d9-57184a0b03b9@linux.ibm.com>
Date: Tue, 7 Jul 2026 13:02:30 +0530
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
Subject: Re: [PATCH v2] powerpc/64s: Clarify copy_and_flush() cache sync loop
 comment
To: linuxppc-dev@lists.ozlabs.org
References: <20260701182756.273019-1-nikhilks@linux.ibm.com>
 <20260706082708.43918-1-nikhilks@linux.ibm.com>
 <akyQQAiLHI3sVmTz@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <86bee101-6bd4-45a6-a633-34f2a52d5ace@linux.ibm.com>
 <akypcnslC8r_XG6D@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
Content-Language: en-US
From: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
In-Reply-To: <akypcnslC8r_XG6D@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Wnx3DPj8Ul2kYYilcAjAQq068sPzSdnC
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA2OSBTYWx0ZWRfXw+QQjrsFRjKn
 z6OWaRbGk7MLGCQwZzlw9xUXfBO1LnO/xA/bDZxrm+m/zr8I5gDBPdLBVeracps6/anC+iboclR
 DU0ta9CUxCuN+rZGEs197/8lUxcj3Kk=
X-Authority-Analysis: v=2.4 cv=DKW/JSNb c=1 sm=1 tr=0 ts=6a4cab94 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=Sayd59aYMkcJtQUyeB8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Wnx3DPj8Ul2kYYilcAjAQq068sPzSdnC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA2OSBTYWx0ZWRfX7PLGmqmUHXiw
 ohzhVm+xkb5kf8zRhWW07Eua3DjANTpdRmuUrczKoNniSV38q5vtnBUlhSvtRkePljDGlJ2I0BR
 Msuz+ej/QgmQhDAUpO2NbQW2s8llg9dxcBPORxFaJk7bY8ZzH+dntjvZRZzXVBdDpuBSawavtgK
 /6vAYAMtMVAwItUGkmdkb+Zhvk9vevVGevpEg0Ouzf7JsL/eIDbNHmiK2YY3+IoV3cLjguTANUe
 yV5Hkv1HJ1SVgF101LBGQdmJkataF55xKPmvK64Kzegg0+42EHSohvIwerJtJVLGqdrfGRBT/yy
 QchwgUjFkTi93PAJ1umknVcuZUnnFudIEAwnGJTH/rD6oeNhuZOhJJCbDl4gbApQ0V/hf8j7Fxa
 KwHOmd1/KUYjDsrkUheWYzp9KM7dcrPSA8BS9zfsl2Qh3ZeWcP53J5s/vOBudz7BwFbBQ2z9CHq
 Yc4iJzwUSq8ioFv3FEg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607070069

Hi Mukesh,

Thanks for the clarification, sorry I missed that part. I'll update the 
comment to follow the 80-column limit and keep the alignment consistent 
in the next revision.

Thanks,
~ Nikhil

On 07/07/26 12:54, Mukesh Kumar Chaurasiya wrote:
> On Tue, Jul 07, 2026 at 12:48:57PM +0530, Nikhil Kumar Singh wrote:
>> Hi Mukesh,
>>
>> Thanks for reviewing the patch and for the suggestion.
>> I'd prefer to keep the current alignment as I find it a bit more readable.
>>
>> Thanks,
>> ~ Nikhil
>>
> There is a reason we keep the character limit to 80 chars. Please go
> through these coding guidelines.
>
> https://docs.kernel.org/process/coding-style.html
>
> Regards,
> Mukesh
>
>> On 07/07/26 11:08, Mukesh Kumar Chaurasiya wrote:
>>> On Mon, Jul 06, 2026 at 01:57:08PM +0530, Nikhil Kumar Singh wrote:
>>>> The value loaded into r0 in copy_and_flush() represents the number of
>>>> 8-byte words processed between cache synchronization operations.
>>>>
>>>> The existing comment refers to cache line size, which can make it appear
>>>> that the value is a cache line size in bytes rather than a loop count.
>>>> Clarify the comment to explain that the loop processes 8 words (64 bytes)
>>>> per cache synchronization iteration, and that increasing the value would
>>>> skip cache maintenance for intermediate cache lines.
>>>>
>>>> This is a comment-only change with no functional impact.
>>>>
>>>> Signed-off-by: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
>>>> ---
>>>>    arch/powerpc/kernel/head_64.S | 20 ++++++++++++--------
>>>>    1 file changed, 12 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
>>>> index 63432a33ec49..a54f6f979173 100644
>>>> --- a/arch/powerpc/kernel/head_64.S
>>>> +++ b/arch/powerpc/kernel/head_64.S
>>>> @@ -713,14 +713,18 @@ p_end: .8byte _end - copy_to_here
>>>>    _GLOBAL(copy_and_flush)
>>>>    	addi	r5,r5,-8
>>>>    	addi	r6,r6,-8
>>>> -4:	li	r0,8			/* Use the smallest common	*/
>>>> -					/* denominator cache line	*/
>>>> -					/* size.  This results in	*/
>>>> -					/* extra cache line flushes	*/
>>>> -					/* but operation is correct.	*/
>>>> -					/* Can't get cache line size	*/
>>>> -					/* from NACA as it is being	*/
>>>> -					/* moved too.			*/
>>>> +4:	li	r0,8			/* r0 is the number of 8-byte words	*/
>>>> +					/* to copy per cache sync iteration.	*/
>>>> +					/* 8 words * 8 bytes = 64 bytes. 64B is	*/
>>>> +					/* the current default cache line size.	*/
>>>> +					/* This is a loop count, not a byte	*/
>>>> +					/* count. Increasing it may skip	*/
>>>> +					/* dcbst/icbi for lines in between and	*/
>>>> +					/* leave stale instructions in icache.	*/
>>>> +					/* This results in extra cache line	*/
>>>> +					/* flushes but operation is correct.	*/
>>>> +					/* Can't get cache line size from NACA	*/
>>>> +					/* as it is being moved too.		*/
>>> The comment looks fine. But the alignement of the comment is still
>>> different from earlier. Keep the alignment same as earlier, it looks a
>>> little nicer.
>>>
>>> Regards,
>>> Mukesh
>>>>    	mtctr	r0			/* put # words/line in ctr	*/
>>>>    3:	addi	r6,r6,8			/* copy a cache line		*/
>>>> -- 
>>>> 2.43.5
>>>>

