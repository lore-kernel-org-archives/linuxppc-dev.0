Return-Path: <linuxppc-dev+bounces-20172-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF011FF8868
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Apr 2026 14:21:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g45N02pmnz2xcD;
	Tue, 28 Apr 2026 00:21:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777286938;
	cv=none; b=QrpUCKYRnuBC/3N7mIkraXCUPm9ZFm3khzuE4FuJ5nBB1mW95jVdaHxyGYNZJ5z8ISHZgoNCtJ8lhQNwRgyvCmxmhdUGbprulYIg+kLatVNXt6Ei0+slHw/+1zGrslCvAT7OrLzopzgaLAPXBx+7g1DwTflOQsjlJzW/Q5Rjeabk6R4E1cDZ/lJiPrpFdQh7j7LlQEmnmNd/iJvu2e8HF4ukg6VPxYo/te8uvAQcED5ikUdtIiSEXgxYCmsQ9lSGVBMANhCbIjVRVoMfwCXJiiHHcI/7tvedeWBrqj2gCgvTu6q0xQzZA6Z858Rh/2CIjF3H85GYtWlcUB4hBrV+vw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777286938; c=relaxed/relaxed;
	bh=GgFq8k94DJnhQjVxRzwzzM5CQ9n+B/KDyqhHDEdSFK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=igI7MOnQULZYdlSAmvCxv1DtIoBZxpC7iLbOiBgRAvzJkzmR1pdmfejfZDi1rS5r3KVC4YnoQpyYI5c2UJwOw7WyiHorNr3Jhj99dKyfuE8zFFgOU4LpyJUbmOOqoHFk6wfwJ3xV+YaVNKzmuOjJujMQ8nHn8YXWk9LuAxC3xrFxSckjH41VevCuD5k+0uIgqbknjE86CFs9k1vrdkFTWvfc/qKmWjcXbURVKxSqI6gVwLGpThuZkS/l+ZZxeBGcMQlGoXn7QoLAc66QQvYH/0BPw8r4RMDgwKwvdBvRkCsQOlrSDKscvuZGDcPlcYwp+gJG55jpmfhE8GAT8wz4UA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Hq4HHKnN; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=anushree.mathur@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Hq4HHKnN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=anushree.mathur@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g40fx5Mxxz2y2B
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2026 20:48:57 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63R9t4we1672847;
	Mon, 27 Apr 2026 10:48:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=GgFq8k
	94DJnhQjVxRzwzzM5CQ9n+B/KDyqhHDEdSFK4=; b=Hq4HHKnNQEAKQUydDQ/tLJ
	kEsn9y0Kp8JY8uQYEzX0w6Ldz2yZOk6o0KGI33siGuWjmpaWbiWVR0mSzDUyQGhz
	7cyiU67SfBTnXrkavsLcfkDEzfGNPiq5gvH4R0kGnGizLmIBwMcQ9W+ptatjemBW
	69os2KRiOU/P7wXGlPzPeUNboQ8p4xew7cwIqbC22gXQXscj0xTlvFPZptXkLy8u
	wvDacO6ZWzqcURtLTjbBdwmzhDnl+Y+w3XrOaHS7fqHBb96/Nlq7PiUreZj9ydUf
	WA1g/k7iKwRZDYCLVPyezzNfDXXQ0gz+d4s4M++oheiYFbhiGO9CdYr6vM1PcqSg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drnb4yxa0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Apr 2026 10:48:46 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63RAcsYh025383;
	Mon, 27 Apr 2026 10:48:45 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ds7xq4wtb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Apr 2026 10:48:45 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63RAmhPl41222676
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Apr 2026 10:48:43 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B47E58065;
	Mon, 27 Apr 2026 10:48:43 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B13D58052;
	Mon, 27 Apr 2026 10:48:39 +0000 (GMT)
Received: from [9.61.240.94] (unknown [9.61.240.94])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Apr 2026 10:48:39 +0000 (GMT)
Message-ID: <a599a37c-99ab-45b7-9b9c-1f809d4d5e94@linux.ibm.com>
Date: Mon, 27 Apr 2026 16:18:37 +0530
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
Subject: Re: [PATCH v2] pseries/kexec: skip resetting CPUs added by firmware
 but not started by the kernel
To: Vishal Chourasia <vishalc@linux.ibm.com>,
        Shivang Upadhyay <shivangu@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Srikar Dronamraju <srikar@linux.ibm.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        "Nysal Jan K.A."
 <nysal@linux.ibm.com>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <20260330062206.170437-1-shivangu@linux.ibm.com>
 <da6f75a7-8a68-46a9-9897-1aef11d33829@linux.ibm.com>
 <3075019f74969b25e3ab7f6b3f51ee54ed455aaf.camel@linux.ibm.com>
 <0732de44-964c-4e0f-b4fd-dcc631ba70fa@linux.ibm.com>
Content-Language: en-US
From: Anushree Mathur <anushree.mathur@linux.ibm.com>
In-Reply-To: <0732de44-964c-4e0f-b4fd-dcc631ba70fa@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=AqDeGu9P c=1 sm=1 tr=0 ts=69ef3f0e cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=pGLkceISAAAA:8
 a=9QMS5lc2VQEYQecy0VUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDExNCBTYWx0ZWRfX7UE6cPUVzrcq
 a2NjPPup3AI7rmtjGHdvDJIuvV44RXz1ZRc8m8AOCHpk124OrG8nTQtJOs3CULnmjfCeu5WE03k
 EDFDMTB679+k9ke+/pdxEDS0KBMF/GqGkpgcqCA/qmcncGJW53TE0jo2FGm6wSYpsMk8ciTemq/
 GqMFiW46jQPjC9d27I0pPqtEAnAC9S7fRdi/IJA2swHvLrXe/ND8X1lJGzzqOTz3da21dqpYzwn
 LiFc4IFtkDp6wMZ9FWNNxT0ZmV8Jjyzikxa6K2ACG51d7srovUjZgLdMb7NNZuZickI23qHuCcL
 8HOoroni1wMSwHs+chIju/L4ode9nZ1AaMfdb+BHel4ThlIMt6Z3kUucPbI+2a56t1K/qBm4iOb
 hswWzBxqg1/7fmXJs6VjN0DQkdwlrUyclJK5bIPMTBv8P7wJY9NMPjITuJ/rlDmDMVbfFjkj3pN
 ThSPQ0hZiSFztnBd2xw==
X-Proofpoint-GUID: C9z-uKdVDSl3_qnmQ53EnIJixOCGAqSh
X-Proofpoint-ORIG-GUID: -zUrTSFPV03gthasgi8Dt9hP_d5EvlHC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0 clxscore=1011
 lowpriorityscore=0 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270114



On 07/04/26 3:55 PM, Vishal Chourasia wrote:
> On 07/04/26 15:49, Shivang Upadhyay wrote:
>> Hi,
>> Thanks for your review.
>>
>> On Mon, 2026-04-06 at 14:22 +0530, Vishal Chourasia wrote:
>>> Hi Shivang,
>>>
>>> Thanks for working on this issue.
>>> A few questions and concerns about the approach:
>>>
>>> 1. Was this issue only observed with QEMU-based virtualization, or
>>> does
>>> it also reproduce on PowerVM/phyp? The commit message and sample logs
>>> don't clarify this. If this is QEMU-specific, I think we should fix
>>> this
>>> in QEMU rather than working around it in the kernel.
>> Currently this is only happening in Qemu (both tcg and kvm mode). But I
>> think this should be reproducible on phyp also. Ill confirm wheather it
>> is really the case or not.
>>
>>> 2. The approach taken here moves away from the PAPR interface. The
>>> kernel currently uses H_SIGNAL_SYS_RESET_ALL_OTHERS, which is the
>>> architecturally defined hcall for this purpose. Replacing it with a
>>> per-CPU loop that checks internal kernel state (paca cpu_start)
>>> breaks
>>> the clean abstraction between guest and
>>> QEMU's sPAPR implementation should behave the same way. The
>>> hypervisor
>> Yeah it is a valid concern about ownership for this resets. Ill try to
>> see if this fix is possible in qemu itself.
>>
>>> (QEMU) should maintain a list of CPUs that have been
>>> activated/online/started and given to the guest. When
>>> H_SIGNAL_SYS_RESET_ALL_OTHERS is called, QEMU should only reset those
>>> CPUs that the guest has actually started. Unless the guest makes the
>>> RTAS start-cpu call for a CPU, QEMU should not include that CPU in
>>> the
>>> set of CPUs to be reset.
>>>
>>> I think discussing this would help determine the right fix location.
>>>
>>> Can you refer to the following commit in QEMU to see if help in this
>>> case.
>>>
>>> commit fb802acdc8b162084e9e60d42aeba79097d14d2b
>>> Author: Nicholas Piggin <npiggin@gmail.com>
>>> Date:   Tue Mar 18 15:03:48 2025 +1000
>>>
>>>       ppc/spapr: Fix RTAS stopped state
>>>
>> Thanks for this reference. cpu->quiesced state was introduced in this
>> patch, for modelling "RTAS stopped" state.
>>
>> as per the commit message:
>> A KVM spapr guest boots with all secondary CPUs defined to be in the
>> RTAS stopped" state. In this state, the CPU is only responsive to the
>> start-cpu RTAS call.
>>
>> So, we should be able to use this to check wheather cpu is started or
>> not. Only other concern here would be about phyp's implementation for
>> this.
>
> Yes, something like this.
>
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
>
> index 032805a8d0..8c51372cf8 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1105,6 +1105,9 @@ static target_ulong 
> h_signal_sys_reset(PowerPCCPU *cpu,
>                      continue;
>                  }
>              }
> +
> +            if (c->env.quiesced) continue;
> +
>              run_on_cpu(cs, spapr_do_system_reset_on_cpu, 
> RUN_ON_CPU_NULL);
>          }
>          return H_SUCCESS;
>
>>
>> Thanks.
>> ~Shivang.
>>
>> Hi Vishal/Shivang,
>>
>> I have tested this qemu patch mentioned here, after applying this the 
>> issue is getting fixed.
>>
>> Thank you!
>> Anushree Mathur
>>


