Return-Path: <xinhui.pan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rds4m0LK9zDqlj
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 13:39:51 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5S3cvhE092921
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 23:39:50 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23sn8vqp84-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 23:39:49 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xinhui.pan@linux.vnet.ibm.com>;
 Tue, 28 Jun 2016 13:39:47 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 392D13578053
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 13:39:45 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5S3djsn57147524
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 13:39:45 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5S3dh5c028207
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 13:39:45 +1000
Date: Tue, 28 Jun 2016 11:39:18 +0800
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
 <20160627145832.GB19108@insomnia>
In-Reply-To: <20160627145832.GB19108@insomnia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Message-Id: <5771F166.5060604@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 2016年06月27日 22:58, Boqun Feng wrote:
> Hi Xinhui,
>
> On Mon, Jun 27, 2016 at 01:41:29PM -0400, Pan Xinhui wrote:
>> This is to fix some holder preemption issues. Spinning at one
>> vcpu which is preempted is meaningless.
>>
>> Kernel need such interfaces, So lets support it.
>>
>> We also should suooprt both the shared and dedicated mode.
>> So add lppaca_dedicated_proc macro in lppaca.h
>>
>> Suggested-by: Boqun Feng <boqun.feng@gmail.com>
>> Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
>> ---
>>   arch/powerpc/include/asm/lppaca.h   |  6 ++++++
>>   arch/powerpc/include/asm/spinlock.h | 15 +++++++++++++++
>>   2 files changed, 21 insertions(+)
>>
>> diff --git a/arch/powerpc/include/asm/lppaca.h b/arch/powerpc/include/asm/lppaca.h
>> index d0a2a2f..0a263d3 100644
>> --- a/arch/powerpc/include/asm/lppaca.h
>> +++ b/arch/powerpc/include/asm/lppaca.h
>> @@ -111,12 +111,18 @@ extern struct lppaca lppaca[];
>>    * we will have to transition to something better.
>>    */
>>   #define LPPACA_OLD_SHARED_PROC		2
>> +#define LPPACA_OLD_DEDICATED_PROC      (1 << 6)
>>
>
> I think you should describe a little bit about the magic number here,
right.

> i.e. what document/specification says this should work, and how this
> works.
>
yep, I need add some comments here. for example, this bit is firmware reserved...
thanks, will do that.

>>   static inline bool lppaca_shared_proc(struct lppaca *l)
>>   {
>>   	return !!(l->__old_status & LPPACA_OLD_SHARED_PROC);
>>   }
>>
>> +static inline bool lppaca_dedicated_proc(struct lppaca *l)
>> +{
>> +	return !!(l->__old_status & LPPACA_OLD_DEDICATED_PROC);
>> +}
>> +
>>   /*
>>    * SLB shadow buffer structure as defined in the PAPR.  The save_area
>>    * contains adjacent ESID and VSID pairs for each shadowed SLB.  The
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
>> +#define arch_vcpu_is_preempted arch_vcpu_is_preempted
>> +static inline bool arch_vcpu_is_preempted(int cpu)
>
> This function should be guarded by #ifdef PPC_PSERIES .. #endif, right?
> Because if the kernel is not compiled with guest support,
> vcpu_is_preempted() should always be false, right?
>
oh, I forgot that. thanks for pointing it out.

>> +{
>> +	struct lppaca *lp = &lppaca_of(cpu);
>> +
>> +	if (unlikely(!(lppaca_shared_proc(lp) ||
>> +			lppaca_dedicated_proc(lp))))
>
> Do you want to detect whether we are running in a guest(ie. pseries
> kernel) here? Then I wonder whether "machine_is(pseries)" works here.
>
I tried as you said yesterday. but .h file has dependencies.
As you said, if we add #ifdef PPC_PSERIES, this is not a big problem. only powernv will be affected as they are built into same kernel img.

> Regards,
> Boqun
>
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
