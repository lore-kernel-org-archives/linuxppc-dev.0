Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 04F2CDDE08
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Aug 2007 13:30:18 +1000 (EST)
In-Reply-To: <20070822011651.GA6799@wotan.suse.de>
References: <20070821021143.GB2909@wotan.suse.de>
	<46CB37D4.2080609@austin.ibm.com>
	<d9f43b5c31fde5851a7af1d0f36eb134@kernel.crashing.org>
	<20070822011651.GA6799@wotan.suse.de>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <dfbba0a8b6a15d1b563bdfcadc49e8eb@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [patch 1/2] powerpc: rmb fix
Date: Wed, 22 Aug 2007 05:29:50 +0200
To: Nick Piggin <npiggin@suse.de>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> If this isn't causing any problems maybe there
>>> is some loigic we are overlooking?
>>
>> The I/O accessor functions enforce the necessary ordering
>> already I believe.
>
> Ah, it looks like you might be right, IO should appear to go in-order, 
> in
> which case the rmb() would simply need to order cacheable loads. 
> Interesting
> way to do things... are drivers simply not up to scratch enough to 
> allow
> out of order IO?

The powerpc kernel needs to have full sync insns in every I/O
accessor in order to enforce all the ordering rules Linux demands.
It's a bloody shame, but the alternative would be to make the
barriers lots more expensive.  A third alternative would be to
have barrier ops that do not order everything, but just A vs. B
for various choices of A and B (coherent accesses, MMIO accesses,
etc.)

> Anyway, this raises another question -- if IO accessors have the right
> ordering, why is wmb() not an lwsync as well? There appears to be many
> more wmb() calls than rmb()...

Input MMIO accessors are {sync, load, stall pipeline until load came 
back}.
That's a full ordering on both sides.

Output MMIO on the other hand is done with {sync, store}.  Now since
wmb() has to order MMIO writes vs. main memory writes, we need a full
sync here.  On some (most, all?) CPUs an eieio is actually enough btw.
The barrier insn could be put at the end of all MMIO write ops too,
but I believe that would be more expensive (in execution time; in code
size it definitely would be, of course).


Segher
