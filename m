Return-Path: <linuxppc-dev+bounces-23895-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8D2DC43458
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jul 2026 06:11:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwl2c2zsFz3c9w;
	Thu, 09 Jul 2026 16:11:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783577464;
	cv=none; b=Q9j6Pr5eV8M9bj8LwwIBQGiIdSJqHdummUA0w5YdcWzYiD6CMt5AS6+H4C3scSaRJouD6G+NSVmcV99L37YCl56LsHGUvh5a1MaDw+jzcdvvPSi3HEZdLEnTt6RmskcFTfMhLsGml/sY+s5rIfUAUYJbnziplVbp2MjcBi4AQbilXb1Na/WviQ+jlZmVxwWHdg3PlPEY02XxkKYJ0B0mxLzF+wjG7CGFK5TbQjXfL7F6NDB+nZX9t8BdkGKcF/OQS5yCmEraICgl6An30G9smuybjR5F3ZQzHDS5ATDAol9LZgOsrF3EqQy3fP9tcl1kKDTWCi62uusTOkNENOcVHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783577464; c=relaxed/relaxed;
	bh=kjXRl/Si9E5WLZ62tWjbR4W3rFr0UY15Wwu7q/ydA68=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ats6SDyeSwGIY86Lt2o8IVf+KOlKPntyHFFGlATeD450NfSNBFqfo9CX5V95aHUI6UFjC1nYShpAf3qi6QodDKkx4+lgsLyF0CHY3BAQsuSucAq8BDwsm4B0MX1OSH7/JPTv7DWEjbvwesAh4I/cWqMeKr7z55bsE0N/QzHvo+VaXoucwjBOJl7XlTcnCywWGTnK0WCw8pKTS6TLI9os4hmTKkOUP5Ekw0vxGcgYIxkbVYFiL9ooYRuWJ5kmbwo8z/B7rub/U0kaqEL+k1wpv3kaz8hducXDQDs8r6WRMdoTVpSUTvL15gRrVuMknzxees3ujw4bsqWgfaP0kA/Deg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=KDXuQf6d; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=nikhilks@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=KDXuQf6d;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=nikhilks@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwl2Z2Clbz3c4D
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 16:11:01 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 668NInXS3801332;
	Thu, 9 Jul 2026 06:10:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=kjXRl/
	Si9E5WLZ62tWjbR4W3rFr0UY15Wwu7q/ydA68=; b=KDXuQf6dvEe+SlsHEXZ7u9
	1uNaNCNoJflsM7yqqAL0HhWukNV+ytypbXDjMLDjqrknA+i2rnD6U1Bo45kUckKR
	/nFYIY0sUD5o+zRNA/ztU6BLJxRoCOmk1Wgq7I8SLwqgNWKNNSEzdda7T8TfVPe/
	YIYVDyEroA8/oxpLvYTLnFO4Jp+Lh55WwKBI+2jegknl5hFqqBRLvVrEjp36h0vg
	NroR+KFSGy5t6EAEtOcBix+DI6hEH8iKwGVwgihQcnFtw3nXAnmZE0vjxwsriOf3
	qtjxraJSzzFqJXcizkItPr+kz4hFFwu67RWezyjIFvWJ9h88Z9KWEcb2ncYHzZug
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6stt0jvt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 06:10:52 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6696508E008707;
	Thu, 9 Jul 2026 06:10:51 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7e0hkqq1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 06:10:51 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6696Al9546268674
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Jul 2026 06:10:47 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 61A2D2004B;
	Thu,  9 Jul 2026 06:10:47 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E2D020040;
	Thu,  9 Jul 2026 06:10:45 +0000 (GMT)
Received: from [9.123.10.251] (unknown [9.123.10.251])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  9 Jul 2026 06:10:45 +0000 (GMT)
Message-ID: <b5f97f5b-4a17-46f7-8830-a9c4c121f0c4@linux.ibm.com>
Date: Thu, 9 Jul 2026 11:40:44 +0530
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
From: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
To: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, adityag@linux.ibm.com, mahesh@linux.ibm.com
References: <20260701182756.273019-1-nikhilks@linux.ibm.com>
 <20260706082708.43918-1-nikhilks@linux.ibm.com>
 <akyQQAiLHI3sVmTz@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <86bee101-6bd4-45a6-a633-34f2a52d5ace@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <86bee101-6bd4-45a6-a633-34f2a52d5ace@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 619dzPPFpr1_wggIbbbPGUS9rhUE1aIY
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDA1MiBTYWx0ZWRfXw2RqKiCCxxhF
 M5v66A7f1y2lzgDxIuBnzoxNuWvBjevWS2BxYjXAXHHuKdStfBPqQmbM3HHvH4FcDsi3/PO9LW9
 jti9AF5qMU/JrxyU+k72BF8KordTxxw=
X-Authority-Analysis: v=2.4 cv=DKW/JSNb c=1 sm=1 tr=0 ts=6a4f3b6c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=9-Dk1aLpORet4t1yA3gA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: kCA3vKp66jXUS8KJu0qz1HqejdlzvEpB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDA1MiBTYWx0ZWRfX4tBuaBrfiXBU
 M3jJy6X0jWFqHBqD+LevfvvxPTWpj6Ivp8yKp+rIhspRy3UHMVLDbsvLdG6/kqigDj8D2CX7+Gz
 QPPwbDo3Q6bwvSMlrP0KC/QdCLtiZBVdo00hyJgE3m7OSszfqd3CWoAJ08FrIIbQF06eOMwKChc
 I/KNSG+YXPvFlHfuD89kb2Zh3AkRLUnXHiqzBYq24mfAhGhYC9mzhtEJ1NSv2NxE3KCrToRn/3Q
 Wlhj0Qx6I+ftNX8M4B1gzCNXTVXnwMU6PnkS1RRi/a1b/FDQ4Hjo1tozQmR21+ZST6RATRIrHxt
 8aaNpyzRTRO+glon74Rni02eadLoYuiyd0L56uSRkUX1o5unKzUQHmMMuzvDccgpeQ1/dnceTXj
 5qsi4QxLVo/j3qzYQ7+y3k545qsdinudw+g2c4+OwwP22+HuosJK12NLprIqAQUQJyhHWNlIF4q
 VKCiVOv6SB28gWXdEug==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_05,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607090052

Hi Mukesh,

Ideally, checkpatch should take care of this, I see no checkpatch errors.

```
./scripts/checkpatch.pl 
v2-0001-powerpc-64s-Clarify-copy_and_flush-cache-sync-loo.patch
total: 0 errors, 0 warnings, 26 lines checked

v2-0001-powerpc-64s-Clarify-copy_and_flush-cache-sync-loo.patch has no 
obvious style problems and is ready for submission.
```

Thanks
~ Nikhil

On 07/07/26 12:48, Nikhil Kumar Singh wrote:
> Hi Mukesh,
>
> Thanks for reviewing the patch and for the suggestion.
> I'd prefer to keep the current alignment as I find it a bit more 
> readable.
>
> Thanks,
> ~ Nikhil
>
> On 07/07/26 11:08, Mukesh Kumar Chaurasiya wrote:
>> On Mon, Jul 06, 2026 at 01:57:08PM +0530, Nikhil Kumar Singh wrote:
>>> The value loaded into r0 in copy_and_flush() represents the number of
>>> 8-byte words processed between cache synchronization operations.
>>>
>>> The existing comment refers to cache line size, which can make it 
>>> appear
>>> that the value is a cache line size in bytes rather than a loop count.
>>> Clarify the comment to explain that the loop processes 8 words (64 
>>> bytes)
>>> per cache synchronization iteration, and that increasing the value 
>>> would
>>> skip cache maintenance for intermediate cache lines.
>>>
>>> This is a comment-only change with no functional impact.
>>>
>>> Signed-off-by: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
>>> ---
>>>   arch/powerpc/kernel/head_64.S | 20 ++++++++++++--------
>>>   1 file changed, 12 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/arch/powerpc/kernel/head_64.S 
>>> b/arch/powerpc/kernel/head_64.S
>>> index 63432a33ec49..a54f6f979173 100644
>>> --- a/arch/powerpc/kernel/head_64.S
>>> +++ b/arch/powerpc/kernel/head_64.S
>>> @@ -713,14 +713,18 @@ p_end: .8byte _end - copy_to_here
>>>   _GLOBAL(copy_and_flush)
>>>       addi    r5,r5,-8
>>>       addi    r6,r6,-8
>>> -4:    li    r0,8            /* Use the smallest common    */
>>> -                    /* denominator cache line    */
>>> -                    /* size.  This results in    */
>>> -                    /* extra cache line flushes    */
>>> -                    /* but operation is correct.    */
>>> -                    /* Can't get cache line size    */
>>> -                    /* from NACA as it is being    */
>>> -                    /* moved too.            */
>>> +4:    li    r0,8            /* r0 is the number of 8-byte words    */
>>> +                    /* to copy per cache sync iteration. */
>>> +                    /* 8 words * 8 bytes = 64 bytes. 64B is    */
>>> +                    /* the current default cache line size.    */
>>> +                    /* This is a loop count, not a byte    */
>>> +                    /* count. Increasing it may skip    */
>>> +                    /* dcbst/icbi for lines in between and */
>>> +                    /* leave stale instructions in icache. */
>>> +                    /* This results in extra cache line    */
>>> +                    /* flushes but operation is correct. */
>>> +                    /* Can't get cache line size from NACA */
>>> +                    /* as it is being moved too.        */
>> The comment looks fine. But the alignement of the comment is still
>> different from earlier. Keep the alignment same as earlier, it looks a
>> little nicer.
>>
>> Regards,
>> Mukesh
>>>         mtctr    r0            /* put # words/line in ctr    */
>>>   3:    addi    r6,r6,8            /* copy a cache line */
>>> -- 
>>> 2.43.5
>>>

