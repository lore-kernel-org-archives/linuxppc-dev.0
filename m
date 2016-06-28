Return-Path: <xinhui.pan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rf1FB5w32zDqnQ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 19:47:42 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5S9dI1N006912
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 05:47:40 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23sjvxm4m0-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 05:47:39 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xinhui.pan@linux.vnet.ibm.com>;
 Tue, 28 Jun 2016 19:47:37 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 89FC72CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 19:47:34 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5S9lYAX21364828
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 19:47:34 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5S9lW06008312
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 19:47:34 +1000
Date: Tue, 28 Jun 2016 17:47:07 +0800
From: xinhui <xinhui.pan@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Heiko Carstens <heiko.carstens@de.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>
CC: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 paulmck@linux.vnet.ibm.com, mingo@redhat.com, mpe@ellerman.id.au,
 paulus@samba.org, benh@kernel.crashing.org, Waiman.Long@hpe.com,
 boqun.feng@gmail.com, will.deacon@arm.com, dave@stgolabs.net,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 1/3] kernel/sched: introduce vcpu preempted check interface
References: <1467049290-32359-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <1467049290-32359-2-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <20160627140043.GO30921@twins.programming.kicks-ass.net>
 <20160628070013.GC3784@osiris>
In-Reply-To: <20160628070013.GC3784@osiris>
Content-Type: text/plain; charset=UTF-8; format=flowed
Message-Id: <5772479B.9000600@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 2016年06月28日 15:00, Heiko Carstens wrote:
> On Mon, Jun 27, 2016 at 04:00:43PM +0200, Peter Zijlstra wrote:
>> On Mon, Jun 27, 2016 at 01:41:28PM -0400, Pan Xinhui wrote:
>>> +++ b/include/linux/sched.h
>>> @@ -3293,6 +3293,15 @@ static inline void set_task_cpu(struct task_struct *p, unsigned int cpu)
>>>
>>>   #endif /* CONFIG_SMP */
>>>
>>> +#ifdef arch_vcpu_is_preempted
>>> +static inline bool vcpu_is_preempted(int cpu)
>>> +{
>>> +	return arch_vcpu_is_preempted(cpu);
>>> +}
>>> +#else
>>> +#define vcpu_is_preempted(cpu)	false
>>> +#endif
>>
>> #ifndef vcpu_is_preempted
>> #define vcpu_is_preempted(cpu)		(false)
>> #endif
>>
>> Is so much simpler...
>>
>> Also, please Cc the virt list so that other interested parties can
>> comment, and maybe also the s390 folks.
>
> The s390 implementation would be to simply use cpu_is_preempted() from
> arch/s390/lib/spinlock.c.
that's great.

> It's nice that there will be a common code function for this!
>
