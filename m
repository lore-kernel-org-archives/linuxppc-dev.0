Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E2784DE1A9
	for <linuxppc-dev@ozlabs.org>; Thu, 22 May 2008 06:12:15 +1000 (EST)
In-Reply-To: <20080521160146.GI8897@wotan.suse.de>
References: <20080521141056.GC8897@wotan.suse.de>
	<20080521141231.GD8897@wotan.suse.de>
	<1211383592.8297.195.camel@pasglop>
	<20080521153420.GG8897@wotan.suse.de>
	<1211384580.8297.199.camel@pasglop>
	<20080521160146.GI8897@wotan.suse.de>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <7dc38d9080603be9c25b8f649e5df0a0@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [patch 2/2] powerpc: optimise smp_wmb
Date: Wed, 21 May 2008 22:12:03 +0200
To: Nick Piggin <npiggin@suse.de>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> From memory, I measured lwsync is 5 times faster than eieio on
> a dual G5. This was on a simple microbenchmark that made use of
> smp_wmb for store ordering, but it did not involve any IO access
> (which presumably would disadvantage eieio further).

This is very much specific to your particular benchmark.

On the 970, there are two differences between lwsync and eieio:

1) lwsync cannot issue before all previous loads are done; eieio
does not have this restriction.

Then, they both fly through the execution core, it doesn't wait
for the barrier insn to complete in the storage system.  In both
cases, a barrier is inserted into both the L2 queues and the
non-cacheable queues.  These barriers are both removed at the
same time, that is, when both are the oldest in their queue and
have done their thing.

2) For eieio, the non-cacheable unit waits for all previous
(non-cacheable) stores to complete, and then arbitrates for the
bus and sends an EIEIO transaction.

Your benchmark doesn't do non-cacheable stores, so it would seem
the five-time slowdown is caused by that bus arbitration (and the
bus transaction).  Maybe your cacheable stores hit the bus as well,
that would make this worse.  Your benchmark also doesn't see the
negative effects from 1).

In "real" code, I expect 2) to be pretty much invisible (the store
queues will never be completely filled up), but 1) shouldn't be very
bad either.  So it's a wash.  But only a real benchmark will tell.

> Given the G5 speedup, I'd be surprised if there is not an improvment
> on POWER4 and 5 as well,

The 970 storage subsystem and the POWER4 one are very different.
Or maybe these queues are just about the last thing that _is_
identical, I dunno, there aren't public POWER4 docs for this ;-)

> although no idea about POWER6 or cell...

No idea about POWER6; for CBE, the backend works similar to the
970 one.

Given that the architecture says to use lwsync for cases like this,
it would be very surprising if it performed (much) worse than eieio,
eh? ;-)  So I think your patch is a win; just wanted to clarify on
your five-time slowdown number.

HTH,


Segher
