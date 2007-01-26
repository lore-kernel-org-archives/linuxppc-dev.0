Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net
	[151.189.21.41])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6ED19DE06D
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Jan 2007 19:48:27 +1100 (EST)
In-Reply-To: <m1ejpiw9s8.fsf@ebiederm.dsl.xmission.com>
References: <1169714047.65693.647693675533.qpush@cradle>
	<20070125083417.69895DE3C5@ozlabs.org>
	<20070126064352.GA328@colo.lackof.org>
	<m1ejpiw9s8.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <5A6F70E0-A8AB-4636-8F41-2EC82A3B13B7@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC/PATCH 14/16] MPIC MSI backend
Date: Fri, 26 Jan 2007 09:47:51 +0100
To: ebiederm@xmission.com (Eric W. Biederman)
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

>>> MPIC MSI backend. Based on code from Segher, heavily hacked by me.
>>> Renamed to mpic_htmsi, as it only deals with MSI over  
>>> Hypertransport.
>> ...
>>> +		/* FIXME should we save the existing type */
>>> +		set_irq_type(virq, IRQ_TYPE_EDGE_RISING);
>>
>> What exactly does the "virq" represent here?
>> I'd like to understand if the FIXME comment could be dropped (or  
>> not).

Now that we don't reuse existing PCI vectors on MPIC (or
do you still do that, Michael?) this FIXME can go.

>> I don't get the impression it's related to a PCI IRQ line.
>> Maybe irq_create_mapping() has comments that describe hwirq and virq?
>> If not, it would be useful if those terms were described.

The code you comment on lives in arch/powerpc/.  virq and
hwirq are used in there all over the place.  Have a look.

> I don't have a clue why it is called virq.  But looking at the
> usage it must be a linux irq number as shown in /proc/interrupts and
> as such there need be no connection with hardware.

Well of course it's connected to real hardware.  The virq
numbers are a flat space; hwirqs are not (those are relative
to one certain interrupt controller) so virqs are easier
in use.

> I believe the ppc model is to allocate an interrupt source on their
> existing interrupt controller and use that instead of the normal x86
> case of having the MSI interrupt go transparently to the cpu.

That's not the "PowerPC model".  On PowerPC, there is
really only one external interrupt to the CPU.  This
is usually connected to a "master interrupt controller",
in this case, the MPIC on the U3/U4 system controller.

This specific controller implements MSIs (just like
HT interrupts really) by mapping HT writes to certain
addresses to an IRQ input on the MPIC.  The only thing
this code does is set the sense/polarity for this IRQ
input.

You really don't need to know any of this if what you
care about is x86.  I really wonder how you can call
the x86 case "normal" or what you mean by "transparently"
btw ;-)


Segher
