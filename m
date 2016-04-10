Return-Path: <xinhui@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [125.16.236.2])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qjZzH5JSQzDq68
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Apr 2016 00:17:47 +1000 (AEST)
Received: from localhost
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xinhui@linux.vnet.ibm.com>;
 Sun, 10 Apr 2016 19:47:44 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3AEHxp412910996
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Apr 2016 19:47:59 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3AEHa3W023472
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Apr 2016 19:47:38 +0530
Message-ID: <570A6078.2050002@linux.vnet.ibm.com>
Date: Sun, 10 Apr 2016 22:17:28 +0800
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
In-Reply-To: <20160408074744.GU3430@twins.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 2016年04月08日 15:47, Peter Zijlstra wrote:
> On Fri, Apr 08, 2016 at 02:41:46PM +0800, Pan Xinhui wrote:
>> From: pan xinhui <xinhui.pan@linux.vnet.ibm.com>
>>
>> Implement xchg{u8,u16}{local,relaxed}, and
>> cmpxchg{u8,u16}{,local,acquire,relaxed}.
>>
>> Atomic operation on 8-bit and 16-bit data type is supported from power7
> 
> And yes I see nothing P7 specific here, this implementation is for
> everything PPC64 afaict, no?
> 
Hello Peter,
	No, it's not for every ppc. So yes, I need add #ifdef here. Thanks for pointing it out.
We might need a new config option and let it depend on POWER7/POWER8_CPU or even POWER9...

> Also, note that you don't need explicit 8/16 bit atomics to implement
> these. Its fine to use 32bit atomics and only modify half the word.
> 
That is true. But I am a little worried about the performance. It will forbid any other tasks to touch the other half word during the load/reserve, right?
I am working on the qspinlock implementation on PPC.
Your and Waiman's patches are so nice. :)

> Also, you might want to invest in some CPP to reduce the endless
> repetition.
> 
Will do that. thanks for your tips.

thanks
xinhui
> Other than that, no objections :-)
> 
