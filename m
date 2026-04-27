Return-Path: <linuxppc-dev+bounces-20171-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F84EFF8868
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Apr 2026 14:21:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g45Mg596Hz2xcD;
	Tue, 28 Apr 2026 00:21:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777287345;
	cv=none; b=bpBAz9JndsjvBao8615LtXazg+zhMJLx63Z/gV0+XyrObpLXb0MHf87ob7cizBqjMPRThCEmwTkt1JIPg4y7JdNns+icYKWnJc0zrt5fGXj1KxeBnPKdBrDv8m2JuaXnT9XVP+5z4NtESlbCI0fmP/wY38A7g9v6kP7K7lsCU4Ea5PsIy4vWiHBhz2lSaLa1MAg79ZAAdF2tBs4eU7cbjyeu0xfn4rUBW6HWkdNh/zAJ6huqV0z4jsU5rXCztHJFbbBWSS+jil4n571z3vCyVmpf+oqGDMwNPZGKOyexjzMY4DbBwL2SgTGoiopSkWX1PiOMKWe9Murt5ySESYMgUA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777287345; c=relaxed/relaxed;
	bh=uvzTMxkV/XE92xkNTeViIJTfsF+11Z7yKzXtzAT5MjY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YKF/parSom5OPgJ74FiMRBlgbgpETfGkv2cWa2Y5hnAXtEl94dJ9OuR8blSToIvubkIFEXLQ6vwEVuyptcq9G+Z+IOA3hQBLuCcgqzFwjoG+7rFbZ+KVeAWr/SqaW1n27MbJAbuVmxKmRCsbDFd0hS1LINZcIzjQfHd5McvVLIDYUiPko1CFss1/gkQZkH+zRJIwspEKYKRlnsW9G2YpU91HLq6C29pA+fqWEwK5Ymlcq5xAv1LrwAE7ekiCJ2qHNW0MZWFDq4RHrimXkFgL9yC6Qpj76QfnncYXr4cxG/a6gZsf1rJCwoIuGA4mIVL+Svno8MdpQvV6eYsL8bX+Qw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ZDXC+RCa; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=anushree.mathur@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ZDXC+RCa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=anushree.mathur@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g40pm1pg0z2y2B
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2026 20:55:43 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63QMHE8c3239715;
	Mon, 27 Apr 2026 10:55:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=uvzTMx
	kV/XE92xkNTeViIJTfsF+11Z7yKzXtzAT5MjY=; b=ZDXC+RCaWWoSmaxHKySsFC
	R8q9w2fGJAsiDmIOuGohfKsUegw4XGGzPey6n+LLrJttI+8UwY86x5qALlsCD999
	p9kznZFF4w0n5mc3PywI0lF/K6IRbN6hONh+U1FwKns8DGK+TOCZ9uzcW6Xe0yun
	Hm/EH1fw807ZfnfVWWY+RUxDdn/LNAIxia0HThFAhararYj6XgL1OaLE4GGlaEJt
	DD16i7GEWCKC+F5204qnTQ7q1he1aLn+aATPdB70gl5t6wpgcQ8iQljBGNLoAHs8
	cdoXsyjjsw0OhWpRUpGKWt/6JI/OO9d8sqdRt5ITNsQ5VBscRSwM1U+ATejbcDqQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drk1jfe8n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Apr 2026 10:55:32 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63RArsjG001092;
	Mon, 27 Apr 2026 10:55:31 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dsamy4k9p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Apr 2026 10:55:31 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63RAtUIu30999138
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Apr 2026 10:55:30 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 79F0158065;
	Mon, 27 Apr 2026 10:55:30 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5447A58056;
	Mon, 27 Apr 2026 10:55:26 +0000 (GMT)
Received: from [9.61.240.94] (unknown [9.61.240.94])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Apr 2026 10:55:26 +0000 (GMT)
Message-ID: <32d1324d-cfe1-4380-9c5c-91da4b1e2457@linux.ibm.com>
Date: Mon, 27 Apr 2026 16:25:24 +0530
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDExNCBTYWx0ZWRfXxV3KYKWDKFd3
 Hj5ZwKlOnonVdpmHzjkMxxBCQpUFLDmt4DRcLwa7NfrXvfrpYx39HHd1t8CEao4d9JzBoWOVLea
 ejHyBufryMpQofnB7/EgkFxVbMf0lDtvdX+fH6Xptr4jBOv79agtBJRWDGrMclGPgC4XiQZ7IxI
 NuUqRk35fq9s3exa0wNLMGtkGxVNoapGTzSBQygKrQis7t3xRMYqD/lKRXG/7ShfKEclxNYVW5L
 waWn+X3teLQ2vAeygW1dlqcMwetOceBASGuFrx3dK0RhmQWJroWU9YJyVBF7yH3m+uy4QcQ6k2L
 pIsav6WtzQntShbgKZVJQJGMtCgfI1L2xUX/vwQt/9OMJ0oATsVg6J5dUdJu/z9R7oglzYtE4It
 IoDKCVHGbsyWcQglbs1Jew4a+qGLCf0xwdBT/KUD2FSUn135HYBmmRHU2yqgVjPzcMxS9hemy7M
 VFAs/1AgVQCIrhT48Ig==
X-Proofpoint-GUID: wpSnAxKzXMpzmavP8zIS3Vd7Bdov71f7
X-Proofpoint-ORIG-GUID: 4gxXAtu1Ls5tVUw-rK7U9PFB__2JqR-p
X-Authority-Analysis: v=2.4 cv=MohiLWae c=1 sm=1 tr=0 ts=69ef40a4 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=pGLkceISAAAA:8
 a=9QMS5lc2VQEYQecy0VUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604270114



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
>>
>>


Hi Vishal/Shivang,

I have tested this qemu patch mentioned here, after applying this the 
issue is getting fixed. Will update all the logs once the new patch is 
sent out to qemu mailing list!

Thank you!
Anushree Mathur


