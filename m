Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BB156DDE11
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Mar 2008 08:39:54 +1000 (EST)
In-Reply-To: <18416.813.635397.559197@cargo.ozlabs.ibm.com>
References: <200803101606.39184.laurentp@cse-semaphore.com>
	<200803251914.24021.laurentp@cse-semaphore.com>
	<47EA4741.2050402@ru.mvista.com>
	<200803271013.32612.laurentp@cse-semaphore.com>
	<20080327100304.GC10397@localhost.localdomain>
	<7c44646510c3b98075de9aa57cad0bce@kernel.crashing.org>
	<18416.813.635397.559197@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <56851566f85e117c42b078dd2d6a2028@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: OF compatible MTD platform RAM driver ?
Date: Mon, 31 Mar 2008 00:39:21 +0200
To: Paul Mackerras <paulus@samba.org>
Cc: ben@simtec.co.uk, linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> For RAMs we
>>> need something to indicate that it's memory but intended for 
>>> secondary
>>> storage, not as main memory.
>>
>> How it is intended to be used is not a property of the hardware, so
>> that information doesn't belong in the device tree at all.  The Linux
>> platform code should handle this, I imagine.
>
> There must be some reason why it is not intended to be used as main
> memory.  Presumably it has something different about it compared to
> "normal" RAM, and that difference could perfectly well be expressed in
> the device tree.

Sure, that's a different thing.  It might sit on a bus that doesn't
do cache coherency, or maybe it's just slow (or sits on a slow bus).
All these things can be usefully expressed in the device tree (but
typically are not, it is left to the client code to know this stuff
implicitly).

It's still the (platform) probe code its responsibility to figure
out what (if anything) to do with any device.  And "main memory"
is probed differently (via /chosen/memory, for example) anyway.
Well, actually, Linux searches for all nodes with device_type "memory",
which should work fine as well [*].

So, all in all, I think we should just give these "auxiliary memory"
devices a name of "ram" c.q. "rom", and some "reg", and that should
be all that is needed: the main memory probe stuff won't consider
these nodes, and the (platform) device probe code can do whatever it
wants (create mtd devices, I guess).


Segher


[*] It seems to me the longtrail workaround code in prom_init.c is
incorrect though: it will match any node with name "memory" that
doesn't have a device_type?
