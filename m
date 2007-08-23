Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B478DDDE9F
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Aug 2007 03:57:39 +1000 (EST)
In-Reply-To: <20070822035539.GB26374@wotan.suse.de>
References: <20070821021143.GB2909@wotan.suse.de>
	<46CB37D4.2080609@austin.ibm.com>
	<d9f43b5c31fde5851a7af1d0f36eb134@kernel.crashing.org>
	<20070822011651.GA6799@wotan.suse.de>
	<dfbba0a8b6a15d1b563bdfcadc49e8eb@kernel.crashing.org>
	<20070822035539.GB26374@wotan.suse.de>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <7dc0bb83644f4cd44b4810a99d0003a1@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [patch 1/2] powerpc: rmb fix
Date: Thu, 23 Aug 2007 19:57:20 +0200
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

>> The powerpc kernel needs to have full sync insns in every I/O
>> accessor in order to enforce all the ordering rules Linux demands.
>> It's a bloody shame, but the alternative would be to make the
>> barriers lots more expensive.  A third alternative would be to
>
> Well lots more expensive compared to what you have now. But what
> you have now is like having those expensive barriers between
> *every* io access.

Yeah.  But I/O reads are very expensive anyway, and the barriers
are used for more than just I/O ordering.

I/O writes are a different thing; ideally, they would use only
eieio, if anything at all.

Maybe the tradeoff isn't optimal.  The I/O primitives didn't have
all those "sync"s in there before, they got added because some bad
interaction with spinlocks was discovered, if my memory isn't failing
me.

>> have barrier ops that do not order everything, but just A vs. B
>> for various choices of A and B (coherent accesses, MMIO accesses,
>> etc.)
>
> The non-smp_ variant is supposed to order everything, AFAIK. Maybe
> you could get more fancy and have PIO vs MMIO etc etc. but it looks
> like this whole area is in a pretty sticky state anyway so let's
> not think about that.

*Thinking* about it is fun.  Trying to get the code merged would be
a different thing ;-)


Segher
