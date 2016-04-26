Return-Path: <xinhui@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [125.16.236.8])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qvLcW3FHgzDq5k
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Apr 2016 21:35:22 +1000 (AEST)
Received: from localhost
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xinhui@linux.vnet.ibm.com>;
 Tue, 26 Apr 2016 17:05:19 +0530
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay07.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3QBZFvo28508354
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Apr 2016 17:05:15 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3QBZCsQ020568
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Apr 2016 17:05:14 +0530
Message-ID: <571F5268.3030304@linux.vnet.ibm.com>
Date: Tue, 26 Apr 2016 19:35:04 +0800
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
 <571DED2B.8060600@linux.vnet.ibm.com>
 <20160425153710.GG3448@twins.programming.kicks-ass.net>
In-Reply-To: <20160425153710.GG3448@twins.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 2016年04月25日 23:37, Peter Zijlstra wrote:
> On Mon, Apr 25, 2016 at 06:10:51PM +0800, Pan Xinhui wrote:
>>> So I'm not actually _that_ familiar with the PPC LL/SC implementation;
>>> but there are things a CPU can do to optimize these loops.
>>>
>>> For example, a CPU might choose to not release the exclusive hold of the
>>> line for a number of cycles, except when it passes SC or an interrupt
>>> happens. This way there's a smaller chance the SC fails and inhibits
>>> forward progress.
> 
>> I am not sure if there is such hardware optimization.
> 
> So I think the hardware must do _something_, otherwise competing cores
> doing load-exlusive could life-lock a system, each one endlessly
> breaking the exclusive ownership of the other and the store-conditional
> always failing.
> 
Seems there is no such optimization.

We haver observed SC fails almost all the time in a contention tests, then got stuck in the loop. :(
one thread modify val with LL/SC, and other threads just modify val without any respect to LL/SC.

So in the end, I choose to rewrite this patch in asm. :)

> Of course, there are such implementations, and they tend to have to put
> in explicit backoff loops; however, IIRC, PPC doesn't need that. (See
> ARC for an example that needs to do this.)
> 
