Return-Path: <xinhui.pan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rdrl3253zzDqFD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 13:24:31 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5S3Nr4H005570
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 23:24:29 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23sjuh1xds-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 23:24:29 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xinhui.pan@linux.vnet.ibm.com>;
 Tue, 28 Jun 2016 13:24:26 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 260D63578052
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 13:24:24 +1000 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5S3OOan10027492
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 13:24:24 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5S3OMjm021701
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 13:24:23 +1000
Date: Tue, 28 Jun 2016 11:23:57 +0800
From: xinhui <xinhui.pan@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Peter Zijlstra <peterz@infradead.org>
CC: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 paulmck@linux.vnet.ibm.com, mingo@redhat.com, mpe@ellerman.id.au,
 paulus@samba.org, benh@kernel.crashing.org, Waiman.Long@hpe.com,
 boqun.feng@gmail.com, will.deacon@arm.com, dave@stgolabs.net
Subject: Re: [PATCH 2/3] powerpc/spinlock: support vcpu preempted check
References: <1467049290-32359-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <1467049290-32359-3-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <20160627141735.GC30909@twins.programming.kicks-ass.net>
In-Reply-To: <20160627141735.GC30909@twins.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Message-Id: <5771EDCD.5070400@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 2016年06月27日 22:17, Peter Zijlstra wrote:
> On Mon, Jun 27, 2016 at 01:41:29PM -0400, Pan Xinhui wrote:
>> diff --git a/arch/powerpc/include/asm/spinlock.h b/arch/powerpc/include/asm/spinlock.h
>> index 523673d..ae938ee 100644
>> --- a/arch/powerpc/include/asm/spinlock.h
>> +++ b/arch/powerpc/include/asm/spinlock.h
>> @@ -52,6 +52,21 @@
>>   #define SYNC_IO
>>   #endif
>>
>> +/* For fixing some spinning issues in a guest.
>> + * kernel would check if vcpu is preempted during a spin loop.
>> + * we support that.
>> + */
>
> If you look around in that file you'll notice that the above comment
> style is inconsistent.
>
> Nor is the comment really clarifying things, for one you fail to mention
> the problem by its known name. You also forget to explain how this
> interface will help. How about something like this:
>
> /*
>   * In order to deal with a various lock holder preemption issues provide
>   * an interface to see if a vCPU is currently running or not.
>   *
>   * This allows us to terminate optimistic spin loops and block,
>   * analogous to the native optimistic spin heuristic of testing if the
>   * lock owner task is running or not.
>   */
thanks!!!

>
> Also, since you now have a useful comment, which is not architecture
> specific, I would place it with the common vcpu_is_preempted()
> definition in sched.h.
>
agree with you. Will do that. I will also add Suggested-by with you.
thanks

> Hmm?
>
>> +#define arch_vcpu_is_preempted arch_vcpu_is_preempted
>> +static inline bool arch_vcpu_is_preempted(int cpu)
>> +{
>> +	struct lppaca *lp = &lppaca_of(cpu);
>> +
>> +	if (unlikely(!(lppaca_shared_proc(lp) ||
>> +			lppaca_dedicated_proc(lp))))
>> +		return false;
>> +	return !!(be32_to_cpu(lp->yield_count) & 1);
>> +}
>> +
>>   static __always_inline int arch_spin_value_unlocked(arch_spinlock_t lock)
>>   {
>>   	return lock.slock == 0;
>> --
>> 2.4.11
>>
>
