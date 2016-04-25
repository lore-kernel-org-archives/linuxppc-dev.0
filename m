Return-Path: <xinhui@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qthpx37KgzDq5y
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Apr 2016 20:12:09 +1000 (AEST)
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xinhui@linux.vnet.ibm.com>;
 Mon, 25 Apr 2016 20:12:08 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 8F06E2BB005E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Apr 2016 20:11:55 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3PABlMW3801344
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Apr 2016 20:11:55 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3PABLYk019682
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Apr 2016 20:11:22 +1000
Message-ID: <571DED2B.8060600@linux.vnet.ibm.com>
Date: Mon, 25 Apr 2016 18:10:51 +0800
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
 <5718F32B.3050409@linux.vnet.ibm.com>
 <20160421161354.GI3430@twins.programming.kicks-ass.net>
In-Reply-To: <20160421161354.GI3430@twins.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 2016年04月22日 00:13, Peter Zijlstra wrote:
> On Thu, Apr 21, 2016 at 11:35:07PM +0800, Pan Xinhui wrote:
>> yes, you are right. more load/store will be done in C code.
>> However such xchg_u8/u16 is just used by qspinlock now. and I did not see any performance regression.
>> So just wrote in C, for simple. :)
> 
> Which is fine; but worthy of a note in your Changelog.
> 
will do that.

>> Of course I have done xchg tests.
>> we run code just like xchg((u8*)&v, j++); in several threads.
>> and the result is,
>> [  768.374264] use time[1550072]ns in xchg_u8_asm
>> [  768.377102] use time[2826802]ns in xchg_u8_c
>>
>> I think this is because there is one more load in C.
>> If possible, we can move such code in asm-generic/.
> 
> So I'm not actually _that_ familiar with the PPC LL/SC implementation;
> but there are things a CPU can do to optimize these loops.
> 
> For example, a CPU might choose to not release the exclusive hold of the
> line for a number of cycles, except when it passes SC or an interrupt
> happens. This way there's a smaller chance the SC fails and inhibits
> forward progress.
I am not sure if there is such hardware optimization.

> 
> By doing the modification outside of the LL/SC you loose such
> advantages.
> 
> And yes, doing a !exclusive load prior to the exclusive load leads to an
> even bigger window where the data can get changed out from under you.
> 
you are right.
We have observed such data change during the two different loads.
