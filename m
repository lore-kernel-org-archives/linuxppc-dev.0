Return-Path: <xinhui@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qqSNl0cxQzDq5v
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 13:41:43 +1000 (AEST)
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xinhui@linux.vnet.ibm.com>;
 Wed, 20 Apr 2016 13:41:41 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id C045A2BB0066
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 13:41:21 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3K3fDUJ43778300
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 13:41:21 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3K3ejqp008337
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 13:40:46 +1000
Message-ID: <5716F9FD.4050100@linux.vnet.ibm.com>
Date: Wed, 20 Apr 2016 11:39:41 +0800
From: Pan Xinhui <xinhui@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Boqun Feng <boqun.feng@gmail.com>
CC: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 peterz@infradead.org, paulmck@linux.vnet.ibm.com, tglx@linutronix.de
Subject: Re: [PATCH V2] powerpc: Implement {cmp}xchg for u8 and u16
References: <5715D04E.9050009@linux.vnet.ibm.com>
 <20160419091818.GA69264@boquns-mbp.cn.ibm.com>
In-Reply-To: <20160419091818.GA69264@boquns-mbp.cn.ibm.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hello, boqun

On 2016年04月19日 17:18, Boqun Feng wrote:
> Hi Xinhui,
> 
> On Tue, Apr 19, 2016 at 02:29:34PM +0800, Pan Xinhui wrote:
>> From: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
>>
>> Implement xchg{u8,u16}{local,relaxed}, and
>> cmpxchg{u8,u16}{,local,acquire,relaxed}.
>>
>> It works on all ppc.
>>
> 
> Nice work!
> 
thank you.

> AFAICT, your work doesn't depend on anything that ppc-specific, right?
> So maybe we can use it as a general approach for a fallback
> implementation on the archs without u8/u16 atomics. ;-)
> 
>> Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>> Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
>> ---
>> change from V1:
>> 	rework totally.
>> ---
>>  arch/powerpc/include/asm/cmpxchg.h | 83 ++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 83 insertions(+)
>>
>> diff --git a/arch/powerpc/include/asm/cmpxchg.h b/arch/powerpc/include/asm/cmpxchg.h
>> index 44efe73..79a1f45 100644
>> --- a/arch/powerpc/include/asm/cmpxchg.h
>> +++ b/arch/powerpc/include/asm/cmpxchg.h
>> @@ -7,6 +7,37 @@
>>  #include <asm/asm-compat.h>
>>  #include <linux/bug.h>
>>  
>> +#ifdef __BIG_ENDIAN
>> +#define BITOFF_CAL(size, off)	((sizeof(u32) - size - off) * BITS_PER_BYTE)
>> +#else
>> +#define BITOFF_CAL(size, off)	(off * BITS_PER_BYTE)
>> +#endif
>> +
>> +static __always_inline unsigned long
>> +__cmpxchg_u32_local(volatile unsigned int *p, unsigned long old,
>> +			unsigned long new);
>> +
>> +#define __XCHG_GEN(cmp, type, sfx, u32sfx, skip, v)			\
>> +static __always_inline u32						\
>> +__##cmp##xchg_##type##sfx(v void *ptr, u32 old, u32 new)		\
>> +{									\
>> +	int size = sizeof (type);					\
>> +	int off = (unsigned long)ptr % sizeof(u32);			\
>> +	volatile u32 *p = ptr - off;					\
>> +	int bitoff = BITOFF_CAL(size, off);				\
>> +	u32 bitmask = ((0x1 << size * BITS_PER_BYTE) - 1) << bitoff;	\
>> +	u32 oldv, newv;							\
>> +	u32 ret;							\
>> +	do {								\
>> +		oldv = READ_ONCE(*p);					\
>> +		ret = (oldv & bitmask) >> bitoff;			\
>> +		if (skip && ret != old)					\
>> +			break;						\
>> +		newv = (oldv & ~bitmask) | (new << bitoff);		\
>> +	} while (__cmpxchg_u32##u32sfx((v void*)p, oldv, newv) != oldv);\
> 
> Forgive me if this is too paranoid, but I think we can save the
> READ_ONCE() in the loop if we change the code into the following,
> because cmpxchg will return the "new" value, if the cmp part fails.
> 
> 	newv = READ_ONCE(*p);
> 
> 	do {
> 		oldv = newv;
> 		ret = (oldv & bitmask) >> bitoff;
> 		if (skip && ret != old)
> 			break;
> 		newv = (oldv & ~bitmask) | (new << bitoff);
> 		newv = __cmpxchg_u32##u32sfx((void *)p, oldv, newv);
> 	} while(newv != oldv);
> 
>> +	return ret;							\
>> +}
a little optimization. Patch V3 will include your code, thanks.

>> +
>>  /*
>>   * Atomic exchange
>>   *
>> @@ -14,6 +45,19 @@
>>   * the previous value stored there.
>>   */
>>  
>> +#define XCHG_GEN(type, sfx, v)						\
>> +		__XCHG_GEN(_, type, sfx, _local, 0, v)			\
>                                          ^^^^^^^
> 
> This should be sfx, right? Otherwise, all the newly added xchg will
> call __cmpxchg_u32_local, this will result in wrong ordering guarantees.
> 
I mean that. But I will think of the ordering issue for a while. :)

>> +static __always_inline u32 __xchg_##type##sfx(v void *p, u32 n)	\
>> +{									\
>> +	return ___xchg_##type##sfx(p, 0, n);				\
>> +}
>> +
>> +XCHG_GEN(u8, _local, volatile);
> 
> I don't think we need the "volatile" modifier here, because READ_ONCE()
> and __cmpxchg_u32_* all have "volatile" semantics IIUC, so maybe we can
> save a paramter for the __XCHG_GEN macro.
> 
such cleanup work can be done in separated patch. Here I just make the compiler happy.

thanks
xinhui
> Regards,
> Boqun
> 
>> +XCHG_GEN(u8, _relaxed, );
>> +XCHG_GEN(u16, _local, volatile);
>> +XCHG_GEN(u16, _relaxed, );
>> +#undef XCHG_GEN
>> +
>>  static __always_inline unsigned long
>>  __xchg_u32_local(volatile void *p, unsigned long val)
>>  {
>> @@ -88,6 +132,10 @@ static __always_inline unsigned long
>>  __xchg_local(volatile void *ptr, unsigned long x, unsigned int size)
>>  {
>>  	switch (size) {
>> +	case 1:
>> +		return __xchg_u8_local(ptr, x);
>> +	case 2:
>> +		return __xchg_u16_local(ptr, x);
>>  	case 4:
>>  		return __xchg_u32_local(ptr, x);
>>  #ifdef CONFIG_PPC64
>> @@ -103,6 +151,10 @@ static __always_inline unsigned long
>>  __xchg_relaxed(void *ptr, unsigned long x, unsigned int size)
>>  {
>>  	switch (size) {
>> +	case 1:
>> +		return __xchg_u8_relaxed(ptr, x);
>> +	case 2:
>> +		return __xchg_u16_relaxed(ptr, x);
>>  	case 4:
>>  		return __xchg_u32_relaxed(ptr, x);
>>  #ifdef CONFIG_PPC64
>> @@ -226,6 +278,21 @@ __cmpxchg_u32_acquire(u32 *p, unsigned long old, unsigned long new)
>>  	return prev;
>>  }
>>  
>> +
>> +#define CMPXCHG_GEN(type, sfx, v)				\
>> +	__XCHG_GEN(cmp, type, sfx, sfx, 1, v)
>> +
>> +CMPXCHG_GEN(u8, , volatile);
>> +CMPXCHG_GEN(u8, _local, volatile);
>> +CMPXCHG_GEN(u8, _relaxed, );
>> +CMPXCHG_GEN(u8, _acquire, );
>> +CMPXCHG_GEN(u16, , volatile);
>> +CMPXCHG_GEN(u16, _local, volatile);
>> +CMPXCHG_GEN(u16, _relaxed, );
>> +CMPXCHG_GEN(u16, _acquire, );
>> +#undef CMPXCHG_GEN
>> +#undef __XCHG_GEN
>> +
>>  #ifdef CONFIG_PPC64
>>  static __always_inline unsigned long
>>  __cmpxchg_u64(volatile unsigned long *p, unsigned long old, unsigned long new)
>> @@ -316,6 +383,10 @@ __cmpxchg(volatile void *ptr, unsigned long old, unsigned long new,
>>  	  unsigned int size)
>>  {
>>  	switch (size) {
>> +	case 1:
>> +		return __cmpxchg_u8(ptr, old, new);
>> +	case 2:
>> +		return __cmpxchg_u16(ptr, old, new);
>>  	case 4:
>>  		return __cmpxchg_u32(ptr, old, new);
>>  #ifdef CONFIG_PPC64
>> @@ -332,6 +403,10 @@ __cmpxchg_local(volatile void *ptr, unsigned long old, unsigned long new,
>>  	  unsigned int size)
>>  {
>>  	switch (size) {
>> +	case 1:
>> +		return __cmpxchg_u8_local(ptr, old, new);
>> +	case 2:
>> +		return __cmpxchg_u16_local(ptr, old, new);
>>  	case 4:
>>  		return __cmpxchg_u32_local(ptr, old, new);
>>  #ifdef CONFIG_PPC64
>> @@ -348,6 +423,10 @@ __cmpxchg_relaxed(void *ptr, unsigned long old, unsigned long new,
>>  		  unsigned int size)
>>  {
>>  	switch (size) {
>> +	case 1:
>> +		return __cmpxchg_u8_relaxed(ptr, old, new);
>> +	case 2:
>> +		return __cmpxchg_u16_relaxed(ptr, old, new);
>>  	case 4:
>>  		return __cmpxchg_u32_relaxed(ptr, old, new);
>>  #ifdef CONFIG_PPC64
>> @@ -364,6 +443,10 @@ __cmpxchg_acquire(void *ptr, unsigned long old, unsigned long new,
>>  		  unsigned int size)
>>  {
>>  	switch (size) {
>> +	case 1:
>> +		return __cmpxchg_u8_acquire(ptr, old, new);
>> +	case 2:
>> +		return __cmpxchg_u16_acquire(ptr, old, new);
>>  	case 4:
>>  		return __cmpxchg_u32_acquire(ptr, old, new);
>>  #ifdef CONFIG_PPC64
>> -- 
>> 2.4.3
>>
> 
