Return-Path: <linuxppc-dev+bounces-25173-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9337C54F54
	for <linuxppc-dev@archiver.kernel.org>; Fri, 31 Jul 2026 08:03:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hBJTt1mfcz2xg8;
	Fri, 31 Jul 2026 18:03:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785484994;
	cv=none; b=gFV6kKlLHsVjtbWcvXrd1JslOyFgAngqashC4BO5csjIrdlCZG3lHPE/VHGMKlDMdpaUVgATJItls+83oXVUrA85oMhiFWaCkZeyPQPgkXou5Y6X0x4erODJkB5nSzE35Vbj5rKzxbFvtsu0BUXOCvpMhdPqg3MFLa8fEMRpQ/B9rArkIqdJtydjm2dEKbGcXbfh2I97p6e6VVCGW6mgTRcx+ZynlvdwM7oiQ1ps3FGAhCrmysGUxgEABy29th/vASMrOTFNjyiPf6glmu2TLOHF008rv82pA220p65BT7YtzoRfUmLvD9Xkq6QxprSnS7T+pDqWl7CGECDeOoVv2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785484994; c=relaxed/relaxed;
	bh=djgo2jg+/VqHj2o+e2CqLoyQfJPLpcK3m4va8704NHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TmHC7qwhV9grIdvdMhoF2lbs1/m93igoUzq6/Tivcf3LuE7Tvrrnrry81+6zcnBwS7uzU6+NvN9HbVPnScXZE/sqzN9rATjyOL28SD9Jcouy4/JffIMrBOW8NExNryNNZWX9EzPNyWRHqvfqyh0r/6moan4RKJ7HzOkDMukisnkYuwds84Y7Nn+Nafee01ILiKwowIkF34rk4cpZ5Qdm6gckH7yjXHXzxx4GtWc9oFZPwf/kPw0EXIqt7Iom+XpHoyMJkLzt91kD8GVqjWouHEmX0hC8Tfo8bQJkG7gFaiOiC9hmk7jZskkjbA5i7ykrEwyz2rWoyr8c4mL3JgYbVg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Y83WawHl; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Y83WawHl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hBJTs1YB7z2xLq
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2026 18:03:12 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66V5IC5Z3253837;
	Fri, 31 Jul 2026 08:02:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=djgo2j
	g+/VqHj2o+e2CqLoyQfJPLpcK3m4va8704NHE=; b=Y83WawHld0AW23qHLcG3W3
	7uC1PYeCMnMDqs1OvGAMLmEmdRRMj3JDVs+5NlALJtPTrm37cG+ZicBtmmqvw4bb
	Pch3RnOqArMdKzqUm6DPrlQ7VXH0MZBPowPH/2AT+zK7SSSLhW+f6nvUwYwmfn93
	nX3h5Z8xXr4HEa9ijJoIxqjgTpBaTY2gZcVHUn7W7s9bHegjkPpBk3dPsY8j0cTV
	6+D93u5W4mn+MxANDjtBmTfBhwnhI9P7hpBE0QHadgBaoJ/sTHetO9gRtL0Ub+65
	0u9ArgdU3haIZnOH7x6Tb8iKhnCgiih050aKCvWACROzOCKS7H+UQpiNFMEhujIw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuycuwt9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 08:02:33 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66V7v4Rg001445;
	Fri, 31 Jul 2026 08:02:32 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn7fqq7ha-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 08:02:32 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66V82UkB15991246
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 08:02:31 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D52FB20043;
	Fri, 31 Jul 2026 08:02:30 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 41C5B20040;
	Fri, 31 Jul 2026 08:02:28 +0000 (GMT)
Received: from [9.124.209.55] (unknown [9.124.209.55])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Jul 2026 08:02:28 +0000 (GMT)
Message-ID: <4be922b5-7dc2-48c1-938c-de02245bc5e2@linux.ibm.com>
Date: Fri, 31 Jul 2026 13:32:27 +0530
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
Subject: Re: [PATCH v4 1/1] powerpc: enable dynamic preemption
To: Jirka Hladky <jhladky@redhat.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: paulmck@kernel.org, maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
        mpe@ellerman.id.au, npiggin@gmail.com, bigeasy@linutronix.de,
        will@kernel.org, linux-kernel@vger.kernel.org
References: <CAE4VaGBwMp3Ke1+Bt11-v6CCE0h=mPm8k_Cf8DazFSQNT9Mz8g@mail.gmail.com>
 <c0f51eda-21c4-4e9d-95e9-75b2740c3f43@linux.ibm.com>
 <500d8e8c-088c-4e6d-ab53-868ade6b0eda@paulmck-laptop>
 <CAE4VaGDGS8wkZj4SF5XVC3-1yDmvJxjUjThTPqVw3kxg56ssQA@mail.gmail.com>
 <e013e88a-6137-4de8-9dfd-925b707f2e01@linux.ibm.com>
 <CAE4VaGAJ9mT8-V=GRPYj8h0RXuNf6S5icrmqeOOFDnkpPMQjaw@mail.gmail.com>
 <a1e04751-eab5-465b-8238-c9f4cd40e472@linux.ibm.com>
 <CAE4VaGCaN6uBBGqbGAsxudSxMC0JdXYn2vpuDJZPFR3xxJgMYA@mail.gmail.com>
 <29a407ab-268e-4443-96dc-8f5f933cb63c@linux.ibm.com>
 <CAE4VaGDzVa3+MKUbwH4LFj_mHZ721fd=7cWEd+G5=eVNWLePsg@mail.gmail.com>
 <529b8d9f-54a0-4ec2-9886-83cd528e5e04@paulmck-laptop>
 <CAE4VaGDJxcu_zgDyrSW=j9WzLEpNsQ9A9Rza-F5PLZq03kJYew@mail.gmail.com>
 <57d9de4a-65aa-44cf-9024-de4e5bdd1971@linux.ibm.com>
 <972db4f1-406b-477b-895e-59ffc643e384@kernel.org>
 <CAE4VaGD0Ekz+5s26iTW=UV4PuBkUm9AzorBgAVGJBjttH7sMWQ@mail.gmail.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <CAE4VaGD0Ekz+5s26iTW=UV4PuBkUm9AzorBgAVGJBjttH7sMWQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: Zzv-a9yxYUjkVjkt7e82Si-Z1YAjT8bk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA1NSBTYWx0ZWRfX56C9ifWkB6d2
 qlmsMGT+at9af0Yrfj8xN+ZNI+9mo9oUBBHnSnKtC6mIc3peHc/u7VRDWQfazC5yXIDBULOVmP2
 r6DDTM+54B71ZYsok8t4S6+DZB/Lw6/U7tYtOMHaaZsJ15nLfJzvfZxsFGaafpycc/kLKeTqn1R
 NJWGkrH76Q+xs7Iuw0QWwqUYk+Y6n0G9bAFQkwQBxD1/gmMBIWLWVdSaEEBJk9iakcQUnjxCUOC
 V9liD6DmltNNdobN6ei4/ldNyXlcp39DbxNlNpVlqSVEpq8Hw7om4zmzfIm6miz+Tbxo5J7Z2qG
 Qs1H1H6yiMmli0svTHFWd+W2/NHJHY/6zLvhigbsFRBLtXqpJ2QRXrcBl+kT57JtxfC84e0U/Km
 nSeWXtjmBjT1I+ZsoELxxeWfIVm8KhqqQy3z8F8BXqF/lEZswgj0arC245RVrsk3aIz+Pw0fs57
 mDfW02RC7BzsdPIZJzg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA1NSBTYWx0ZWRfXzh6cY7XkKGu4
 Ums9z9K38kSh+ieShXdQ8WHfvSlsd0jF9n7Vx3BpnfyviJFCX1ZzRfUA6m9jU5MtAgdoh78J1II
 wYUmgp02vEc9OZpR1eZWkU3htMDwDHo=
X-Authority-Analysis: v=2.4 cv=AZeB2XXG c=1 sm=1 tr=0 ts=6a6c569a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=oHPdpl245dM498GvQYYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: NYe4f62dOEyqXzb4Lte0WSUnzbpKS-5v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_02,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310055

Hi.

On 7/31/26 12:48 PM, Jirka Hladky wrote:
> On Fri, Jul 31, 2026 at 7:03 AM Christophe Leroy (CS GROUP)
> <chleroy@kernel.org> wrote:
>>
>>
>>
>> Le 30/07/2026 à 19:10, Shrikanth Hegde a écrit :
>>> Hi Jirka, Paul,
>>>
>>>
>>> +cc will
>>>
>>> On 7/30/26 8:38 PM, Jirka Hladky wrote:
>>>> On Thu, Jul 30, 2026 at 4:53 PM Paul E. McKenney <paulmck@kernel.org>
>>>> wrote:
>>>>> But is this really a fundamental RISC cost?  For example, does arm64
>>>>> see the same performance issues?
>>>>
>>>> We tested arm64 (Ampere Altra Max) with the same controlled
>>>> experiment -- two 6.18 kernels, both voluntary, differing only in
>>>> PREEMPT_DYNAMIC:
>>>>
>>>> Arch     PREEMPT_DYNAMIC   kill bogo-ops/sec   Delta
>>>> -------  ---------------   -----------------   -----
>>>> ppc64le  off               108,836
>>>> ppc64le  on                 68,197             -37.3%
>>>> aarch64  off                 5,538
>>>> aarch64  on                  5,082              -8.2%
>>>>
>>>> arm64 sees -8.2% vs ppc64le's -37.3%. So arm64 is affected but
>>>> much less severely.
>>>
>>> Ouch!. But that's good to know.
>>
>> Might be a stupid question, but what is your .config ?
>> Are you sure it doesn't contain CONFIG_DEBUG_PREEMPT ?
> 
> I have double-checked that and it's not set:
> # CONFIG_DEBUG_PREEMPT is not set
> 
> Thanks
> Jirka
> 

Coming into numbers, I did notice later, arm64 numbers are almost 20x less.
I believe you are having similar core count or benchmark is same.

But if we compare the time taken for each operations, it tells a different story.
		
	    PREEMPT_DYNAMIC
ppc64le 	off 		108836 ops/s =   9.19 us/op
ppc64le 	on   		68197 ops/s  =  14.66 us/op
delta                                           +5.47 us/op

aarch64 	off   		5538 ops/s = 180.57 us/op
aarch64 	on    		5082 ops/s = 196.77 us/op
delta                         		     +16.20 us/op

PS: I tried porting some of those changes in arm64 to powerpc to split preempt count into
two. but i don;t see much improvement there. If i see get better numbers i will reply with
that.

