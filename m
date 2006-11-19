Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A3BFA67BF4
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Nov 2006 08:08:39 +1100 (EST)
Subject: Re: [PATCH] 2.6.18-rt7: PowerPC: fix breakage in threaded fasteoi
	type IRQ handlers
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
In-Reply-To: <4560C409.9030709@ru.mvista.com>
References: <200611192243.34850.sshtylyov@ru.mvista.com>
	<1163966437.5826.99.camel@localhost.localdomain>
	<20061119200650.GA22949@elte.hu>
	<1163967590.5826.104.camel@localhost.localdomain>
	<4560BDF5.400@ru.mvista.com>
	<1163968376.5826.110.camel@localhost.localdomain>
	<4560C121.30403@ru.mvista.com>
	<1163968885.5826.116.camel@localhost.localdomain>
	<4560C409.9030709@ru.mvista.com>
Content-Type: text/plain
Date: Mon, 20 Nov 2006 08:08:43 +1100
Message-Id: <1163970524.5826.128.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Ingo Molnar <mingo@elte.hu>,
	linux-kernel@vger.kernel.org, dwalker@mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


>     I'm not sure it's feasible. The idea behind level/edge flows is to 
> eliminate the interrupt priority I think. That's why they EOI ASAP (with the 
> level handler masking IRQ before that) -- this way the other interrupts may 
> come thru.

Well, the idea behind the level/edge flow is not exactly that afaik.
It's more like having tailored handlers for level/edge on PICs that are
not intelligent to auto-mask with a priority mecanism (ie. dumb PICs
which are very common in the embedded field, and for example, on ARM
where genirq takes its roots).

>     I used to think that fasteoi was intended for SMP PICs which are 
> intelligent enough to mask off the interrupts pending delivery or handling on 
> CPUs and unmask them upon receiving EOI -- just like x86 IOAPIC does.

In general, PICs that are intelligent enough to mask off, wether using
something as you describe or using priorities. I don't feel the need of
going through hoops to allow lower or same priority interrupts in.
First, if you really need an interrupt to be serviced quick, then you
can just give it a higher priority. In the general case however, I do
-not- want to allow interrupts to stack up. Imagine a big IBM machine
with hundreds interrupt lines, what happens to the kernel stack if we
let them interrupt each other ?

>  This 
> way, the acceptance of the lower priority interrupts shouldn't be hindered on 
> the other CPUs. Maybe the scheme is different for OpenPIC (I know it has the 
> different interrupt distribution scheme from IOAPIC)?

I don't think there is a real need to let lower priority interrupts in
on a CPU that is currently handling a higher priority one.

In the case of RT, though, with delayed delivery, then, the option to
mask and EOI right away is always possible.

Ben.
