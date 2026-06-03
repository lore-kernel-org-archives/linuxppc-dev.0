Return-Path: <linuxppc-dev+bounces-21946-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15B1FCD6E4A
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Jun 2026 06:17:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gVct55VBYz2yNn;
	Wed, 03 Jun 2026 16:17:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780467421;
	cv=none; b=mzSvCTZ34PidLSvQxLqTk7DiscLmfVc9YLfZ57dubhV0/Z8l2sBrqN3cjcz3ldcUZrQrBBaMEWlrCngfA+KNk54JjbKp4f43yRygktP7/C3sP2fU2f5ET8zsKT9MVA8QhAA0lMR7iq/fbdJlRWG56zkwH15uo9QVoUscNshkD6fZKH8gXA+Iw/gF5g3avrWeBb3wyJwHohdEMrELtYL9vcE/d7a+z1ssHcLObLM7cuXhWBnkj26hlyZMcgpHEQ1IQbhkT4IFtCNeVkuC+iV3nNbJNro87cdCIFngfr5+6VKaG43ORkIv+skchAnFgjqxKHSTbqfD9hE+JiNDmHm8sA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780467421; c=relaxed/relaxed;
	bh=CkQYBe7FeNtFLB0ir236mIaN1woD3oHh9cr9TmHtpN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lVwyGnGGwFlHpQ92v1qCe9dV5OIZ43NI1pIK8DHkF9ah2PKeFxzexRsvr3j/SzLmbcafV+rR1Z87Knsq4EvsYYulv8zgqf4k8GUD3bhnw3cUrSuj0aOw6xPNsEEgX4hYGTNgj9QR+qM+pI17MEOBSRM++IC1z6tR8493u/rAW1WFvJsCE+tlBkO3XaI0U8PC93BmRLGGDJDS5OdKIyUrg0Q/iLvAzQ/pYVz7xtjL1LEjjgPA+k5NSxMtmfikI1bfg7fTHLUrDyWGxTI1BwgFsYqw+tw2d4Ksa7sQ5Rk2VRk3/RHAy963qSxg2jRmN3LaD0Pebwvc+r6LCj03BloY0g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=cHcc+jjz; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=cHcc+jjz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gVct471Qwz2xc2
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Jun 2026 16:17:00 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 652HRGPT1773281;
	Wed, 3 Jun 2026 06:16:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=CkQYBe
	7FeNtFLB0ir236mIaN1woD3oHh9cr9TmHtpN0=; b=cHcc+jjzL9iWT2unT8ocri
	3y29Lrfy4lTqpA31300tVJFlvzKnxuo/9up2/B/ino5AfycBRWE3AbTEWFniBZZg
	R9s2w3Fs6XqNesYiHZVPb1og4WXAlLZXD2tzea5nNq11JG8eI3NSAImegbcFZTDN
	zHOZgWOVaviOq06Ezdop+0SVdFStckD0xDrrSTOHuyWP1uCSlTFcYVKBNt6Lu7lt
	CsEXJA+eCDWb5dTZ3t6C/7TqPlpwVML4Z8o+dISnpctLW1fqypznGp47Dopk8Keh
	TLftk56+e7YngXCEXnh5cklWXTY31b/IAWwqqiy4sFFm8H3O9Qr547Ukz2eHHo7Q
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqd49hfa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 06:16:57 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 653696Tw006069;
	Wed, 3 Jun 2026 06:16:56 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egbqherbk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 06:16:56 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6536GqlK53936618
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Jun 2026 06:16:52 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5B1F520040;
	Wed,  3 Jun 2026 06:16:52 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 18DF320043;
	Wed,  3 Jun 2026 06:16:50 +0000 (GMT)
Received: from [9.124.223.153] (unknown [9.124.223.153])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  3 Jun 2026 06:16:49 +0000 (GMT)
Message-ID: <9bc1db05-b371-4d71-8ebd-071d3871743e@linux.ibm.com>
Date: Wed, 3 Jun 2026 11:46:49 +0530
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
Subject: Re: [PATCH 3/3] powerpc/kexec: fix double get_cpu() imbalance in
 kexec_prepare_cpus
To: Aboorva Devarajan <aboorvad@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Christophe Leroy <chleroy@kernel.org>, linux-kernel@vger.kernel.org,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Ritesh Harjani <ritesh.list@gmail.com>
References: <20260518050855.1147242-1-aboorvad@linux.ibm.com>
 <20260518050855.1147242-4-aboorvad@linux.ibm.com>
 <45af9f95-da07-45b6-babe-dbae0f7eb318@linux.ibm.com>
 <786b3540efcd83eed95f5e4fb2e7bd9fbd917474.camel@linux.ibm.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <786b3540efcd83eed95f5e4fb2e7bd9fbd917474.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDA1NiBTYWx0ZWRfX3dmwqoad8N7w
 GUfrokh52I9zxToR39vwXiLeiMUNvFjIqfvfWtxKQnYoiLA1Opc90iotfuwXmfSqvP2FldKCIBd
 9ErLhZDFNW83Aq95CXD8TWb2090b17BbR/xjjyDlkTeyHqK1T7tHlfbRAIYQmncD/E5RLlIuVfH
 EQbpQT4qQfCHWgzav3i6m+/6bIDcdsv0pyymSx3zt3CAVOWt48PhZZQaRrnRjK7LKLbaBdXphXb
 /M4XAZWkE/04PbiSBCk8DQDZRWzzHXT/EtRifVGBiDrbgZmkHZSQS3nO+wJGgRYp7MVp+DFZBfs
 kUSIa+UGk8fQIrpkvNSJgbQ3jVerAa92WaHM/nTsaTVSfTYFx5gcWE/8m6j4ZoRWkDmBSHOgYw3
 ptEyJA93WrfcilYumKn0V8QXuu+sLbR5aPcTm6SMQRnSp7AN8GEneoupI4/1g6KQ79KWumhpI+7
 Z3beheny7SXyp6aJGiw==
X-Proofpoint-GUID: kyOtBSmGjybcFQuo_9l8BDmEjUI3jfut
X-Proofpoint-ORIG-GUID: stGjfMkAW5TY5htlhz8qkZmeIr7imzKu
X-Authority-Analysis: v=2.4 cv=DZknbPtW c=1 sm=1 tr=0 ts=6a1fc6d9 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=5o-TtcKsp_UZ7LzfvmsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030056



On 6/3/26 11:44 AM, Aboorva Devarajan wrote:
> Hi Shrikanth,
> 
> On Mon, 2026-05-18 at 11:32 +0530, Shrikanth Hegde wrote:
>> Hi Aboorva.
>>
>> On 5/18/26 10:38 AM, Aboorva Devarajan wrote:
>>> kexec_prepare_cpus_wait() calls get_cpu() internally to obtain the
>>> current CPU id. kexec_prepare_cpus() calls kexec_prepare_cpus_wait()
>>> twice -- once for KEXEC_STATE_IRQS_OFF and once for
>>> KEXEC_STATE_REAL_MODE -- but only issues a single put_cpu() at the end,
>>> leaving preempt_count elevated by one extra nesting level.
>>>
>>> In practice the imbalance does not trigger a 'scheduling while atomic'
>>> splat because the kexec path is a one-way trip: IRQs are already
>>> disabled, no schedule() occurs after the leak, and
>>> default_machine_kexec() overwrites preempt_count with HARDIRQ_OFFSET
>>> before jumping into kexec_sequence() which never returns. However the
>>> bookkeeping is still wrong.
>>>
>>> Lift the get_cpu()/put_cpu() pair into kexec_prepare_cpus() so it is
>>> called exactly once, and pass the CPU id to kexec_prepare_cpus_wait()
>>> as a parameter. This keeps preempt_count correctly balanced.
>>>
>>> Fixes: 1fc711f7ffb01 ("powerpc/kexec: Fix race in kexec shutdown")
>>> Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
>>> ---
>>>    arch/powerpc/kexec/core_64.c | 15 ++++++++-------
>>>    1 file changed, 8 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/arch/powerpc/kexec/core_64.c b/arch/powerpc/kexec/core_64.c
>>> index 825ab8a88f18e..9d7e5a1e6e5b8 100644
>>> --- a/arch/powerpc/kexec/core_64.c
>>> +++ b/arch/powerpc/kexec/core_64.c
>>> @@ -164,12 +164,11 @@ static void kexec_smp_down(void *arg)
>>>    	/* NOTREACHED */
>>>    }
>>>    
>>> -static void kexec_prepare_cpus_wait(int wait_state)
>>> +static void kexec_prepare_cpus_wait(int wait_state, int my_cpu)
>>>    {
>>> -	int my_cpu, i, notified=-1;
>>> +	int i, notified = -1;
>>>    
>>>    	hw_breakpoint_disable();
>>> -	my_cpu = get_cpu();
>>>    	/* Make sure each CPU has at least made it to the state we need.
>>>    	 *
>>>    	 * FIXME: There is a (slim) chance of a problem if not all of the CPUs
>>> @@ -246,6 +245,8 @@ static void wake_offline_cpus(void)
>>>    
>>>    static void kexec_prepare_cpus(void)
>>>    {
>>> +	int my_cpu;
>>> +
>>>    	wake_offline_cpus();
>>>    	smp_call_function(kexec_smp_down, NULL, /* wait */0);
>>>    	local_irq_disable();
>>> @@ -254,7 +255,8 @@ static void kexec_prepare_cpus(void)
>>>    	mb(); /* make sure IRQs are disabled before we say they are */
>>>    	get_paca()->kexec_state = KEXEC_STATE_IRQS_OFF;
>>>    
>>> -	kexec_prepare_cpus_wait(KEXEC_STATE_IRQS_OFF);
>>> +	my_cpu = get_cpu();
> 
>> raw_smp_processor_id() is better here. All it needs is get current cpu?
>> caller does irq_disable above and that renders call for get_cpu un-necessary.
> 
> Agreed, get_cpu() is not needed here. kexec_prepare_cpus() already does
> local_irq_disable()/hard_irq_disable() before calling
> kexec_prepare_cpus_wait(), so we only need the current cpu id.
> 
> I will go ahead with smp_processor_id() rather than
> raw_smp_processor_id() to stay consistent with Patch 2 and to keep the
> CONFIG_DEBUG_PREEMPT check.


If the irq's are disabled then use raw_smp_processor_id() in both the places.
For patch2, just put a comment saying irq's are disabled when its get there.

> 
>>>    
>>> @@ -262,13 +264,12 @@ static void kexec_prepare_cpus(void)
>>>    	 * Before removing MMU mappings make sure all CPUs have entered real
>>>    	 * mode:
>>>    	 */
>>> -	kexec_prepare_cpus_wait(KEXEC_STATE_REAL_MODE);
>>> +	kexec_prepare_cpus_wait(KEXEC_STATE_REAL_MODE, my_cpu);
>>> +	put_cpu();
>>>    
>>>    	/* after we tell the others to go down */
>>>    	if (ppc_md.kexec_cpu_down)
>>>    		ppc_md.kexec_cpu_down(0, 0);
>>> -
>>> -	put_cpu();
>>>    }
>>>    
>>>    #else /* ! SMP */
> 
> Regards,
> Aboorva


