Return-Path: <xinhui.pan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rdrYj6M2mzDqrZ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 13:16:25 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5S3EIfR133852
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 23:16:24 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23sjuh1run-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 23:16:23 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xinhui.pan@linux.vnet.ibm.com>;
 Tue, 28 Jun 2016 13:16:20 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id D8FBE3578052
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 13:16:17 +1000 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5S3GHVk63963280
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 13:16:17 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5S3GGIq021088
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 13:16:17 +1000
Date: Tue, 28 Jun 2016 11:15:51 +0800
From: xinhui <xinhui.pan@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Boqun Feng <boqun.feng@gmail.com>
CC: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 paulmck@linux.vnet.ibm.com, peterz@infradead.org, mingo@redhat.com,
 mpe@ellerman.id.au, paulus@samba.org, benh@kernel.crashing.org,
 Waiman.Long@hpe.com, will.deacon@arm.com, dave@stgolabs.net
Subject: Re: [PATCH 1/3] kernel/sched: introduce vcpu preempted check interface
References: <1467049290-32359-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <1467049290-32359-2-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <20160627140540.GA19108@insomnia>
In-Reply-To: <20160627140540.GA19108@insomnia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Message-Id: <5771EBE7.3060201@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 2016年06月27日 22:05, Boqun Feng wrote:
> On Mon, Jun 27, 2016 at 01:41:28PM -0400, Pan Xinhui wrote:
>> this supports to fix lock holder preempted issue which run as a guest
>>
>> for kernel users, we could use bool vcpu_is_preempted(int cpu) to detech
>> if one vcpu is preempted or not.
>>
>> The default implementation is a macrodefined by false. So compiler can
>> wrap it out if arch dose not support such vcpu pteempted check.
>>
>> archs can implement it by define arch_vcpu_is_preempted().
>>
>> Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
>> ---
>>   include/linux/sched.h | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/include/linux/sched.h b/include/linux/sched.h
>> index 6e42ada..dc0a9c3 100644
>> --- a/include/linux/sched.h
>> +++ b/include/linux/sched.h
>> @@ -3293,6 +3293,15 @@ static inline void set_task_cpu(struct task_struct *p, unsigned int cpu)
>>
>>   #endif /* CONFIG_SMP */
>>
>> +#ifdef arch_vcpu_is_preempted
>> +static inline bool vcpu_is_preempted(int cpu)
>> +{
>> +	return arch_vcpu_is_preempted(cpu);
>> +}
>> +#else
>> +#define vcpu_is_preempted(cpu)	false
>> +#endif
>> +
>
> I think you are missing Peter's comment here. We can
>
> #ifndef vcpu_is_preempted
> #define vcpu_is_preempted(cpu)	fasle
> #endif
>
> And different archs implement their own versions of vcpu_is_preempted(),
> IOW, no need for an arch_vcpu_is_preempted().
>
yes, right.
just vcpu_is_preempted, no arch_vcpu_is_preempted..
thanks

> Regards,
> Boqun
>
>>   extern long sched_setaffinity(pid_t pid, const struct cpumask *new_mask);
>>   extern long sched_getaffinity(pid_t pid, struct cpumask *mask);
>>
>> --
>> 2.4.11
>>
