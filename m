Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 84BB767B7E
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Sep 2006 09:17:36 +1000 (EST)
Subject: Re: [POWERPC] convert string i/o operations to C
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Matt Sealey <matt@genesi-usa.com>
In-Reply-To: <45104304.3000205@genesi-usa.com>
References: <20060919222351.d27a1a06.sfr@canb.auug.org.au>
	<20060919182953.GK29167@austin.ibm.com>
	<20060919135259.303706d3.kim.phillips@freescale.com>
	<45103DF0.9050409@genesi-usa.com>
	<9E674786-9AF3-4322-B642-7BAA58462B74@kernel.crashing.org>
	<45104304.3000205@genesi-usa.com>
Content-Type: text/plain
Date: Wed, 20 Sep 2006 09:17:15 +1000
Message-Id: <1158707835.6002.177.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: sfr@canb.auug.org.au, paulus@samba.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> But it couldn't hurt, right? There has to be an application note per-CPU 
> on the correct sequence of operations for such an access (I seem to have 
> collected a directory full for firmware development), it seems a little 
> odd to pick and choose one instruction over another for one thing, and 
> then say you need to do it to support the 601 of all things, and run 
> this code against the G3/G4/G5 which perhaps doesn't care or is more 
> intelligent about it (or is guaranteed to have a more intelligent host 
> bridge at least).
> 
> Maybe I'm talking crap, please say so :D

No, your basic idea is valid. One of the thing we are tackling doing is
to add to our cpu feature "nop'ing out" mecanism something closer to
what x86 does nowadays which is to have alternate sequence of
instructions depending on the CPU.

I just think however that the MMIO loads aren't a very high priority
spot for such an optimisation :) Spinlocks are more interesting and we
are looking into doing something like x86 where you don't need to build
a UP kernel, the SMP kernel will automatically replace the spinlocks
with simple preempt_disable/enable at boot if running on only one CPU.
We could do similar things with some barriers etc...

Ben.
