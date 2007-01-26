Return-Path: <ebiederm@xmission.com>
Received: from ebiederm.dsl.xmission.com (ebiederm.dsl.xmission.com
	[166.70.28.69])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0D065DE130
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Jan 2007 03:33:27 +1100 (EST)
From: ebiederm@xmission.com (Eric W. Biederman)
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC/PATCH 14/16] MPIC MSI backend
References: <1169714047.65693.647693675533.qpush@cradle>
	<20070125083417.69895DE3C5@ozlabs.org>
	<20070126064352.GA328@colo.lackof.org>
	<m1ejpiw9s8.fsf@ebiederm.dsl.xmission.com>
	<5A6F70E0-A8AB-4636-8F41-2EC82A3B13B7@kernel.crashing.org>
Date: Fri, 26 Jan 2007 09:32:33 -0700
In-Reply-To: <5A6F70E0-A8AB-4636-8F41-2EC82A3B13B7@kernel.crashing.org>
	(Segher Boessenkool's message of "Fri, 26 Jan 2007 09:47:51 +0100")
Message-ID: <m1r6thvjdq.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Grant Grundler <grundler@parisc-linux.org>,
	Greg Kroah-Hartman <greg@kroah.com>,
	Kyle McMartin <kyle@parisc-linux.org>, linuxppc-dev@ozlabs.org,
	Brice Goglin <brice@myri.com>, shaohua.li@intel.com,
	linux-pci@atrey.karlin.mff.cuni.cz, "David S.Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Segher Boessenkool <segher@kernel.crashing.org> writes:

>> I don't have a clue why it is called virq.  But looking at the
>> usage it must be a linux irq number as shown in /proc/interrupts and
>> as such there need be no connection with hardware.
>
> Well of course it's connected to real hardware.  The virq
> numbers are a flat space; hwirqs are not (those are relative
> to one certain interrupt controller) so virqs are easier
> in use.

Any sane architecture will allocate the irq numbers this way.  However
they are the linux abstraction of the hardware and as such a useful
mapping to the hardware is not required.  ia64 is the strong culprit
in this regard, and simply picks the next free number it can use
when a device asks for an irq.

>> I believe the ppc model is to allocate an interrupt source on their
>> existing interrupt controller and use that instead of the normal x86
>> case of having the MSI interrupt go transparently to the cpu.
>
> That's not the "PowerPC model".  On PowerPC, there is
> really only one external interrupt to the CPU.  This
> is usually connected to a "master interrupt controller",
> in this case, the MPIC on the U3/U4 system controller.

Thanks that brings thing into a little more perspective.

> This specific controller implements MSIs (just like
> HT interrupts really) by mapping HT writes to certain
> addresses to an IRQ input on the MPIC.  The only thing
> this code does is set the sense/polarity for this IRQ
> input.
>
> You really don't need to know any of this if what you
> care about is x86.  I really wonder how you can call
> the x86 case "normal" or what you mean by "transparently"
> btw ;-)


The minimum silicon version of the destination of an MSI really only
needs the ability to record that it happened.  A prioiri setup of the
controller (in hardware) for each individual MSI source interrupt
seems to imply extra hardware logic, and limit the total number of
MSI's the system can handle for no apparent reason.  For that
reason I expect more systems to do things closer to how x86 does it.
If for no other reason than because it is less logic to validate.

On x86 the only hardware we have to deal with is the 8 bit number
delivered to the cpu at interrupt time and the MSI registers.  All of
the rest of the x86 logic needed to translate MSI interrupts to
processor bus messages and the like has no registers we can set and
always behaves exactly the same way so is for all intents and purposes
transparent.  The PCI-HT bridge logic for MSI is the most visible our
logic for MSI ever becomes.  As for the destination window it is an
architecturally defined target with fixed meanings for all of the bits
on every system.  So by transparent I mean that we don't have to
perform any per irq setup in the hardware except the pci card to make
MSI's work.

The big difference here between what you have and what x86 has
is that on x86 I can easily setup a pool of locations usable
by MSI allocate a location, and then independently associate
that with an MSI irq.  Apparently PPC cannot do that, although
from what little I have heard about the MPIC just now I don't 
understand why not.  Any clue where I can find a MPIC datasheet?

I care about more than x86 but x86 and derivatives is the platform
I primarily work with, have test hardware for, and understand all
of the details of.  To make an abstraction that works across all
platforms and to help maintain that I need to understand all of the
relevant details so I do care about ppc.  Especially when I have ppc
people I can work with.

Likewise what is different about x86 needs some explaining so it becomes
clear why msi_ops do not handle what x86 is doing today.  The big
difference there comes with irq migration because when we migrate an
irq we must reprogram the msi registers on the cards themselves,
likewise when we mask an irq we must mask it using the msi registers.

>From that comes our need for a data structure to map from an irq to a
msi data structure in a generic fashion, because we don't just program
the pci card and forget about it.  From those requirements comes our
need for a little bit more complete support of the features of the
hardware that Michaels implementation.

Eric
