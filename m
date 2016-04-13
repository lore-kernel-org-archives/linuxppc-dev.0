Return-Path: <xinhui@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [125.16.236.1])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qlLpQ4CxnzDq5k
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Apr 2016 21:16:14 +1000 (AEST)
Received: from localhost
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xinhui@linux.vnet.ibm.com>;
 Wed, 13 Apr 2016 16:46:12 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3DBFtFN38273192
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Apr 2016 16:45:55 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3DBFVej007056
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Apr 2016 16:45:39 +0530
Message-ID: <570E2A45.9080702@linux.vnet.ibm.com>
Date: Wed, 13 Apr 2016 19:15:17 +0800
From: Pan Xinhui <xinhui@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Peter Zijlstra <peterz@infradead.org>
CC: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Boqun Feng <boqun.feng@gmail.com>, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] powerpc: introduce {cmp}xchg for u8 and u16
References: <570752AA.9050603@linux.vnet.ibm.com>
 <20160408074744.GU3430@twins.programming.kicks-ass.net>
 <570A6078.2050002@linux.vnet.ibm.com> <20160412143023.GH1087@worktop>
In-Reply-To: <20160412143023.GH1087@worktop>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Peter,

On 2016年04月12日 22:30, Peter Zijlstra wrote:
> On Sun, Apr 10, 2016 at 10:17:28PM +0800, Pan Xinhui wrote:
>>
>> On 2016年04月08日 15:47, Peter Zijlstra wrote:
>>> On Fri, Apr 08, 2016 at 02:41:46PM +0800, Pan Xinhui wrote:
>>>> From: pan xinhui <xinhui.pan@linux.vnet.ibm.com>
>>>>
>>>> Implement xchg{u8,u16}{local,relaxed}, and
>>>> cmpxchg{u8,u16}{,local,acquire,relaxed}.
>>>>
>>>> Atomic operation on 8-bit and 16-bit data type is supported from power7
>>>
>>> And yes I see nothing P7 specific here, this implementation is for
>>> everything PPC64 afaict, no?
>>>
>> Hello Peter,
>> 	No, it's not for every ppc. So yes, I need add #ifdef here. Thanks for pointing it out.
>> We might need a new config option and let it depend on POWER7/POWER8_CPU or even POWER9...
> 
> Right, I'm not sure if PPC has alternatives, but you could of course
> runtime patch the code from emulated with 32bit ll/sc to native 8/16bit
> ll/sc if present on the current CPU if you have infrastructure for these
> things.
> 
seems interesting. I have no idea about how to runtime patch the code. I will try to learn that.
If so, we need change {cmp}xchg into uninline functions?

>>> Also, note that you don't need explicit 8/16 bit atomics to implement
>>> these. Its fine to use 32bit atomics and only modify half the word.
>>>
>> That is true. But I am a little worried about the performance. It will
>> forbid any other tasks to touch the other half word during the
>> load/reserve, right?
> 
> Well, not forbid, it would just make the LL/SC fail and try again. Other
> archs already implement them this way. See commit 3226aad81aa6 ("sh:
> support 1 and 2 byte xchg") for example.
> 
thanks for your explanation. :)

I wrote one similar patch as you suggested.

I paste the new __xchg_u8's alpha implementation here. it need rewrite to be understood easily...
It does work, but some performance tests are needed later.

static __always_inline unsigned long
__xchg_u8_local(volatile void *p, unsigned char val)
{
        unsigned int prev, prev_mask, tmp, offset, _val, *_p;

        _p = (unsigned int *)round_down((unsigned long)p, sizeof(int));
        _val = val;
        offset = 8 * ( (unsigned long)p - (unsigned long )_p) ;
#ifndef CONFIG_CPU_LITTLE_ENDIAN
        offset = 8 * (sizeof(int) - sizeof(__typeof__(val))) - offset;
#endif
        _val <<= offset;
        prev_mask = ~((unsigned int)(__typeof__ (val))-1 << offset);

        __asm__ __volatile__(
"1:     lwarx   %0,0,%3\n"
"       and %1,%0,%5\n"
"       or %1,%1,%4\n"
        PPC405_ERR77(0,%2)
"       stwcx.  %1,0,%3\n"
"       bne-    1b"
        : "=&r" (prev), "=&r" (tmp), "+m" (*(volatile unsigned int *)_p)
        : "r" (_p), "r" (_val), "r" (prev_mask)
        : "cc", "memory");

        return prev >> offset;
}

>> I am working on the qspinlock implementation on PPC.
>> Your and Waiman's patches are so nice. :)
> 
> Thanks!, last time I looked at PPC spinlocks they could not use things
> like ticket locks because PPC might be a guest and fairness blows etc..
> 
> You're making the qspinlock-paravirt thing work on PPC, or doing
> qspinlock only for bare-metal PPC?
> 
I am making the both work. :)
qspinlock works on PPC now. I am preparing the patches and will send them out in next weeks :)

The paravirt work is a little hard.
currently, there are pv_wait() and pv_kick(). but only pv_kick has the parameter cpu(who will hold the lock as soon as the lock is unlocked). 
We need parameter cpu(who holds the lock now) in pv_wait,too.

thanks
xinhui
