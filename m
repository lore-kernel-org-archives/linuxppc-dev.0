Return-Path: <xinhui@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qrNBg6xpyzDqgC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2016 01:36:11 +1000 (AEST)
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xinhui@linux.vnet.ibm.com>;
 Fri, 22 Apr 2016 01:36:09 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id DD0F13578056
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2016 01:36:04 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3LFZu1X4587870
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2016 01:36:04 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3LFZVUs007032
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2016 01:35:32 +1000
Message-ID: <5718F32B.3050409@linux.vnet.ibm.com>
Date: Thu, 21 Apr 2016 23:35:07 +0800
From: Pan Xinhui <xinhui@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Peter Zijlstra <peterz@infradead.org>
CC: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 boqun.feng@gmail.com, paulmck@linux.vnet.ibm.com, tglx@linutronix.de
Subject: Re: [PATCH V3] powerpc: Implement {cmp}xchg for u8 and u16
References: <5715D04E.9050009@linux.vnet.ibm.com>
 <571782F0.2020201@linux.vnet.ibm.com>
 <20160420142408.GF3430@twins.programming.kicks-ass.net>
In-Reply-To: <20160420142408.GF3430@twins.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2016年04月20日 22:24, Peter Zijlstra wrote:
> On Wed, Apr 20, 2016 at 09:24:00PM +0800, Pan Xinhui wrote:
> 
>> +#define __XCHG_GEN(cmp, type, sfx, skip, v)				\
>> +static __always_inline unsigned long					\
>> +__cmpxchg_u32##sfx(v unsigned int *p, unsigned long old,		\
>> +			 unsigned long new);				\
>> +static __always_inline u32						\
>> +__##cmp##xchg_##type##sfx(v void *ptr, u32 old, u32 new)		\
>> +{									\
>> +	int size = sizeof (type);					\
>> +	int off = (unsigned long)ptr % sizeof(u32);			\
>> +	volatile u32 *p = ptr - off;					\
>> +	int bitoff = BITOFF_CAL(size, off);				\
>> +	u32 bitmask = ((0x1 << size * BITS_PER_BYTE) - 1) << bitoff;	\
>> +	u32 oldv, newv, tmp;						\
>> +	u32 ret;							\
>> +	oldv = READ_ONCE(*p);						\
>> +	do {								\
>> +		ret = (oldv & bitmask) >> bitoff;			\
>> +		if (skip && ret != old)					\
>> +			break;						\
>> +		newv = (oldv & ~bitmask) | (new << bitoff);		\
>> +		tmp = oldv;						\
>> +		oldv = __cmpxchg_u32##sfx((v u32*)p, oldv, newv);	\
>> +	} while (tmp != oldv);						\
>> +	return ret;							\
>> +}
> 
> So for an LL/SC based arch using cmpxchg() like that is sub-optimal.
> 
> Why did you choose to write it entirely in C?
> 
yes, you are right. more load/store will be done in C code.
However such xchg_u8/u16 is just used by qspinlock now. and I did not see any performance regression.
So just wrote in C, for simple. :)

Of course I have done xchg tests.
we run code just like xchg((u8*)&v, j++); in several threads.
and the result is,
[  768.374264] use time[1550072]ns in xchg_u8_asm
[  768.377102] use time[2826802]ns in xchg_u8_c

I think this is because there is one more load in C.
If possible, we can move such code in asm-generic/.

thanks
xinhui
