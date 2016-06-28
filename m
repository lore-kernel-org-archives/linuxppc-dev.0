Return-Path: <xinhui.pan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rdvkP6S4DzDqn7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 15:39:09 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5S5XnBt082617
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 01:39:07 -0400
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [125.16.236.4])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23skk0bjpc-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 01:39:06 -0400
Received: from localhost
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xinhui.pan@linux.vnet.ibm.com>;
 Tue, 28 Jun 2016 11:09:03 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 626EA3940064
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 11:09:00 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5S5cp3f15729122
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 11:08:52 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5S5cm6g004569
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 11:08:58 +0530
Date: Tue, 28 Jun 2016 13:38:19 +0800
From: xinhui <xinhui.pan@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Boqun Feng <boqun.feng@gmail.com>
CC: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 paulmck@linux.vnet.ibm.com, peterz@infradead.org, mingo@redhat.com,
 mpe@ellerman.id.au, paulus@samba.org, benh@kernel.crashing.org,
 Waiman.Long@hpe.com, will.deacon@arm.com, dave@stgolabs.net
Subject: Re: [PATCH 2/3] powerpc/spinlock: support vcpu preempted check
References: <1467049290-32359-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <1467049290-32359-3-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <20160627145832.GB19108@insomnia> <5771F166.5060604@linux.vnet.ibm.com>
 <20160628050356.GA25008@insomnia>
In-Reply-To: <20160628050356.GA25008@insomnia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Message-Id: <57720D4B.8090406@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 2016年06月28日 13:03, Boqun Feng wrote:
> On Tue, Jun 28, 2016 at 11:39:18AM +0800, xinhui wrote:
> [snip]
>>>> +{
>>>> +	struct lppaca *lp = &lppaca_of(cpu);
>>>> +
>>>> +	if (unlikely(!(lppaca_shared_proc(lp) ||
>>>> +			lppaca_dedicated_proc(lp))))
>>>
>>> Do you want to detect whether we are running in a guest(ie. pseries
>>> kernel) here? Then I wonder whether "machine_is(pseries)" works here.
>>>
>> I tried as you said yesterday. but .h file has dependencies.
>> As you said, if we add #ifdef PPC_PSERIES, this is not a big problem. only powernv will be affected as they are built into same kernel img.
>>
>
> I never said this it not a big problem ;-)
>
> The problem here is that we only need to detect the vcpu preemption in
> a guest, and there could be several ways we can detect whether the
> kernel is running in a guest. It's worthwhile to try find the best one
> for this. Besides, it's really better that you can make sure we are
> runing out of options before you introduce something like
> lppaca_dedicated_proc().
>
> I have a feeling that yield_count is non-zero only if we are running in
> a guest, if so, we can use this and save several loads. But surely we
> need the confirmation from ppc maintainers.
>
yes, on powernv, print the lppaca.yield_count and it is always zero. looks like only hypervisor and os can touch/modify it.


> Regards,
> Boqun
>
