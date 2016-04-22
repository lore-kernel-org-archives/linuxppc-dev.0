Return-Path: <xinhui@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qrf3v4NFJzDqBD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2016 12:01:15 +1000 (AEST)
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xinhui@linux.vnet.ibm.com>;
 Fri, 22 Apr 2016 12:01:13 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 41646357805C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2016 12:00:32 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3M20GYl60031044
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2016 12:00:30 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3M1xoPg021428
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2016 11:59:51 +1000
Message-ID: <5719857A.5080201@linux.vnet.ibm.com>
Date: Fri, 22 Apr 2016 09:59:22 +0800
From: Pan Xinhui <xinhui@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Boqun Feng <boqun.feng@gmail.com>
CC: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, paulmck@linux.vnet.ibm.com,
 tglx@linutronix.de
Subject: Re: [PATCH V3] powerpc: Implement {cmp}xchg for u8 and u16
References: <5715D04E.9050009@linux.vnet.ibm.com>
 <571782F0.2020201@linux.vnet.ibm.com>
 <20160420142408.GF3430@twins.programming.kicks-ass.net>
 <5718F32B.3050409@linux.vnet.ibm.com> <20160421155257.GA20657@insomnia>
In-Reply-To: <20160421155257.GA20657@insomnia>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2016年04月21日 23:52, Boqun Feng wrote:
> On Thu, Apr 21, 2016 at 11:35:07PM +0800, Pan Xinhui wrote:
>> On 2016年04月20日 22:24, Peter Zijlstra wrote:
>>> On Wed, Apr 20, 2016 at 09:24:00PM +0800, Pan Xinhui wrote:
>>>
>>>> +#define __XCHG_GEN(cmp, type, sfx, skip, v)				\
>>>> +static __always_inline unsigned long					\
>>>> +__cmpxchg_u32##sfx(v unsigned int *p, unsigned long old,		\
>>>> +			 unsigned long new);				\
>>>> +static __always_inline u32						\
>>>> +__##cmp##xchg_##type##sfx(v void *ptr, u32 old, u32 new)		\
>>>> +{									\
>>>> +	int size = sizeof (type);					\
>>>> +	int off = (unsigned long)ptr % sizeof(u32);			\
>>>> +	volatile u32 *p = ptr - off;					\
>>>> +	int bitoff = BITOFF_CAL(size, off);				\
>>>> +	u32 bitmask = ((0x1 << size * BITS_PER_BYTE) - 1) << bitoff;	\
>>>> +	u32 oldv, newv, tmp;						\
>>>> +	u32 ret;							\
>>>> +	oldv = READ_ONCE(*p);						\
>>>> +	do {								\
>>>> +		ret = (oldv & bitmask) >> bitoff;			\
>>>> +		if (skip && ret != old)					\
>>>> +			break;						\
>>>> +		newv = (oldv & ~bitmask) | (new << bitoff);		\
>>>> +		tmp = oldv;						\
>>>> +		oldv = __cmpxchg_u32##sfx((v u32*)p, oldv, newv);	\
>>>> +	} while (tmp != oldv);						\
>>>> +	return ret;							\
>>>> +}
>>>
>>> So for an LL/SC based arch using cmpxchg() like that is sub-optimal.
>>>
>>> Why did you choose to write it entirely in C?
>>>
>> yes, you are right. more load/store will be done in C code.
>> However such xchg_u8/u16 is just used by qspinlock now. and I did not see any performance regression.
>> So just wrote in C, for simple. :)
>>
>> Of course I have done xchg tests.
>> we run code just like xchg((u8*)&v, j++); in several threads.
>> and the result is,
>> [  768.374264] use time[1550072]ns in xchg_u8_asm
> 
> How was xchg_u8_asm() implemented, using lbarx or using a 32bit ll/sc
> loop with shifting and masking in it?
> 
yes, using 32bit ll/sc loops.

looks like:
        __asm__ __volatile__(
"1:     lwarx   %0,0,%3\n"
"       and %1,%0,%5\n"
"       or %1,%1,%4\n"
       PPC405_ERR77(0,%2)
"       stwcx.  %1,0,%3\n"
"       bne-    1b"
        : "=&r" (_oldv), "=&r" (tmp), "+m" (*(volatile unsigned int *)_p)
        : "r" (_p), "r" (_newv), "r" (_oldv_mask)
        : "cc", "memory");


> Regards,
> Boqun
> 
>> [  768.377102] use time[2826802]ns in xchg_u8_c
>>
>> I think this is because there is one more load in C.
>> If possible, we can move such code in asm-generic/.
>>
>> thanks
>> xinhui
>>
