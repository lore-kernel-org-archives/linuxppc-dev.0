Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 83CBCDDEED
	for <linuxppc-dev@ozlabs.org>; Sat, 10 May 2008 08:27:51 +1000 (EST)
Subject: Re: [PATCH] POWERPC: Support ISA legacy addresses in
	of_address_to_resource()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nate Case <ncase@xes-inc.com>
In-Reply-To: <1210368679.13845.315.camel@localhost.localdomain>
References: <1210289192.13845.281.camel@localhost.localdomain>
	<1210307480.1421.132.camel@pasglop>
	<1210368679.13845.315.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sat, 10 May 2008 08:27:45 +1000
Message-Id: <1210372065.1421.217.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> m to memory or something like that.
> 
> Your suspicion is correct in a way -- this allows IO port addresses to
> make their way to 'struct resource' so that drivers can use inb(),
> outb(), etc.  After some thought, I'm not sure if a device tree using
> I/O port addresses for a legacy node is considered a bug or not.
> 
> Here is the failure case
 
.../...

Your isa node is at the root of the device-tree and not behind some kind
of PCI bridge ?

In that case, I suspect that you do need a range property that converts
ISA IO addresses to toplevel memory addresses.

That is, you keep the "1" at the beginning of the reg property of ISA
devices that use ISA IO ports, but you make the bridge range property
convert from IO to memory.

Now, that might expose different issues with of_address_to_resource()
but then we can fix them.

One thing we can do for example, is to make it find legacy ISA based on
the base of the ISA bridge and turn them back into IO ports.

Ben.
