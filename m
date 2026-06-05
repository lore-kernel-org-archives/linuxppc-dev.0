Return-Path: <linuxppc-dev+bounces-22095-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3056CCD6E75
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Jun 2026 03:03:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gWmTj5q9xz2xnK;
	Fri, 05 Jun 2026 13:03:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780628601;
	cv=none; b=l5I2tAGdb95ez8th+iEqJFSMwBCzHWEuySjrBdkVjgyuVL65svJE/4B3soNY7X9z4KNJrxKw6EOje44eNGeM+izYurYC1PySoElZnS4ilMpEm5W8ULVc4QDh4HdQF23nVPW8uQUavWXVs/I+aa4JKpmzC2Y7GJrob67/JWxyC+J+YyjGp6L3xbx0KTdUgFTnMRF5/334pGT1jIWxwGkCmQn6E013f3g8daRBBPvi+04fqgj5yZO3ywx8oI9bUiJsV3jdjpoS1d7w9huKY/OmNx1DJoH5trxlxCtn9KscocTSAInm6ZsVcqJOUiwsQHQZdVJEEksgmtDWp9wc9tgPmA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780628601; c=relaxed/relaxed;
	bh=1LBuc+3pyc8efrTBKmQQr2T0qkUMTNMJ/V1mI15xt+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W18GqOGe7pDiwBbBw5INan/teHf/tbCr71DP3MQgqs4bCWYTXG0B1BBCb/4z2+j+2I7yoduaoWMnQMvw8B7DNmR2XBoZJfKCVhEg+EVhjXjBekU3rW/adE5a2M9/Y2YU+bNgtB80YWxP6JCHaTxPivWHe1DJZij0wSuLv7lVlrs+oK7b+rfkvcE2/gLqcCp60v0uF3/yn53kjrm83R0RqQKeOSTucbEbyDyh1shqWRpxew6jvyOX+PE8W9xXKgzeWcaeZ5+eqYy+m0q7J9ZKQESVrrmCzFiVDDzuoQ5yGpZo8amjsE5AV8+D0lZAEFgLBZfoKOQI2KmA+cEF3oqDtQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=izXXA7AK; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=izXXA7AK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gWmTh4Tvbz2xk7
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Jun 2026 13:03:19 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 654NjCN83938571;
	Fri, 5 Jun 2026 03:03:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=1LBuc+
	3pyc8efrTBKmQQr2T0qkUMTNMJ/V1mI15xt+U=; b=izXXA7AKF68/EgiC+uLEW/
	MjDGP0kS4HSGqLsbdP6Bs6SSBwojr4wrZutxLnDmylrzn/9m2XQyOtDWsePX3BTk
	o/xbzLayVPCJz7XsmWuWzL/yz3dk9YmnG3DtVuoYD+Xn9EoUKzQchegr8/cQsvlK
	YJcdf6Ke2HssXx+Up/7tloH385dWfn9IBL/CNG6jxvYntD4lvH1nkZ2w6AAB1KWg
	sChqWpAgq2p1nEYcHf3x1yr8WHIgmbQ4Ev9lvpkm6kNhUkc0rKjN2M+lx/tyn7n5
	u1ZoVw3uryg813vBPg8JZzhwl3a06gcbxoai7wxuTQ4e8dufBRyudrHRvquO43ng
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqd4jpuc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jun 2026 03:03:16 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6552sA1X022395;
	Fri, 5 Jun 2026 03:03:15 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egb7kfwfx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jun 2026 03:03:15 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65533D9V46792990
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Jun 2026 03:03:13 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 78C6A20043;
	Fri,  5 Jun 2026 03:03:13 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3D81520040;
	Fri,  5 Jun 2026 03:03:12 +0000 (GMT)
Received: from [9.39.24.83] (unknown [9.39.24.83])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  5 Jun 2026 03:03:11 +0000 (GMT)
Message-ID: <d56bebd8-bd0e-4e3d-b44f-6c2ca27ab5a9@linux.ibm.com>
Date: Fri, 5 Jun 2026 08:33:11 +0530
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
Subject: Re: [PATCH] powerpc/vtime: Initialize starttime at boot for native
 accounting
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, maddy@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org
Cc: frederic@kernel.org
References: <20260604132429.297665-1-sshegde@linux.ibm.com>
 <e69ad352-6835-414b-845b-03f45fdd9a45@kernel.org>
 <644eed72-fe6b-4639-88d3-dcbba1f8209b@kernel.org>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <644eed72-fe6b-4639-88d3-dcbba1f8209b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDAyMyBTYWx0ZWRfXw6RLXxmg8flN
 +AvB5oVkL2TSPeyjquTkwWTfwKsZF0VhUsQOyZnVN+6UBbOZ20pN7pgLJMZxtBnAYeWp7JeYtcj
 t+zSbQz9ncSXaY9GEce7KF7HtrSzwbRsAP/zHol28lbx765YEWzbzb1rwa0ei9uk2p8OQCbCHtM
 vXZH2zgm53NF+0sclQPmgXqWDc7pTzuazDGZmRV6wAtEu9tp9VjnKTPXSZFH3oUIxGmddgmNk/s
 TTOIEzPJ6QJqqkcawgHNyf1vu1uOl9AnHya0to/m0IFSGfQoJrUbr7b2FfGpA9u7GK3RKlsrak7
 wLIVvhtkMtzfPOJMBmWZCLgPYN1/HfV1PbUb3isBjIODw+6cLrr6UIjexS+Sye5GD+P2zL4kB7x
 bE2D6F5cwpCWBqH4w8wTW3SNrhJrd9Sj53KVHtyoaf4kU6sJtfrO8bpE1pL29cFC+NlQ/hkWBP9
 Us8uImJzxW6YGBz0Y+w==
X-Proofpoint-GUID: ORyRp0i2UjY4FAsOZ7T3ai_ZmfnJ3v8R
X-Proofpoint-ORIG-GUID: ORyRp0i2UjY4FAsOZ7T3ai_ZmfnJ3v8R
X-Authority-Analysis: v=2.4 cv=DZknbPtW c=1 sm=1 tr=0 ts=6a223c74 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=zg1bwRFHo5kqdLu9r80A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_07,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606050023

Hi Christophe. Thanks for taking a look and review.

On 6/4/26 8:42 PM, Christophe Leroy (CS GROUP) wrote:
> 

>>> Also, does this warrant Fixes tag? I found these two likely candidates.
>>> Likely this issues exists since beginning.
>>> c223c90386bc powerpc32: provide VIRT_CPU_ACCOUNTING
>>
>> You say system has 240 CPU so I suppose this is not ppc32. That commit 
>> wsa not supposed to change anything for ppc64, did you identify 
>> anything special in that commit related to ppc64 ?

Yes. this was ppc64.

>>
>>> b38a181c11d0 powerpc/time: isolate scaled cputime accounting in 
>>> dedicated functions.
>>
>> This one is also pure code re-organisation, unless you've been able to 
>> spot a particular issue ?
> 
> Maybe commit cf9efce0ce31 ("powerpc: Account time using timebase rather 
> than PURR")
> 
> It removed snapshot_timebases() and I can't see anything to replace it.
> 

Yes. But this patch is dependent on Frederic's series.
backporting that is going to be difficult. So i am thinking to avoid putting Fixes tag.


> 
>>
>>>
>>>   arch/powerpc/kernel/time.c | 4 +++-
>>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
>>> index 3460d1a5a97c..11145c40183d 100644
>>> --- a/arch/powerpc/kernel/time.c
>>> +++ b/arch/powerpc/kernel/time.c
>>> @@ -377,7 +377,6 @@ void vtime_task_switch(struct task_struct *prev)
>>>       }
>>>   }
>>> -#ifdef CONFIG_NO_HZ_COMMON
>>>   /**
>>>    * vtime_reset - Fast forward vtime entry clocks
>>>    *
>>> @@ -394,6 +393,7 @@ void vtime_reset(void)
>>>   #endif
>>>   }
>>> +#ifdef CONFIG_NO_HZ_COMMON
>>>   /**
>>>    * vtime_dyntick_start - Inform vtime about entry to idle-dynticks
>>>    *
>>> @@ -933,6 +933,7 @@ static void __init set_decrementer_max(void)
>>>   static void __init init_decrementer_clockevent(void)
>>>   {
>>>       register_decrementer_clockevent(smp_processor_id());
>>> +    vtime_reset();
>>>   }
>>>   void secondary_cpu_time_init(void)
>>> @@ -948,6 +949,7 @@ void secondary_cpu_time_init(void)
>>>       /* FIME: Should make unrelated change to move snapshot_timebase
>>>        * call here ! */
>>>       register_decrementer_clockevent(smp_processor_id());
>>> +    vtime_reset();
>>>   }
>>>   /*
>>
> 

Sorry i should have put this earlier, But this applies on top of tip/timers/nohz
at 6199f9999a9b (origin/timers/nohz) sched/cputime: Handle dyntick-idle steal time correctly
(In case anyone tried applying on powerpc tree, it would fail)

