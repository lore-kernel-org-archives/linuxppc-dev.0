Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 46ECCDDE30
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Jan 2007 09:18:54 +1100 (EST)
In-Reply-To: <1167687230.23340.147.camel@localhost.localdomain>
References: <1167679875.22068.350.camel@pmac.infradead.org>
	<1167682254.23340.131.camel@localhost.localdomain>
	<32106685eb2ecb2fb4adcf6e51f71482@kernel.crashing.org>
	<1167687230.23340.147.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <c71e551a57d1b8fa5b1fb9a63a4b82e2@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Fix Maple PATA IRQ assignment.
Date: Mon, 1 Jan 2007 23:17:57 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, David Woodhouse <dwmw2@infradead.org>,
	alan@lxorguk.ukuu.org.uk, jgarzik@pobox.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> Or does it have
>>> the ide strapped to native mode ?
>>
>> It's not a strapping, it's a purely software thing -- see the PCIIDE
>> specification.
>
> I know the PCI IDE spec, but there are a number of chips out there that
> cannot be changed without a strap.

Sure, but not the 8111.

> In this case, it's easy to test
> though we'll need fixups in the device-tree to indicate the change in
> routing, or a quirk.
>
> The thing is, there -is- a cascaded 8259 in there,

But it's disabled, the HT APIC is used instead.

> and that's where the
> IRQ14 and IRQ15 end up in legacy mode (edge sensitive even) iirc, 
> unless
> they are aslo routed to the APIC directly, but in anyway it's hidden by
> the firmware.
>
> So we can have a quirk in the Maple code to reconfigure that all in
> native mode.

It's probably best to trust the OF device tree, and only do
quirks if that turns out to be wrong.  David says that's exactly
what his patch does, so...  :-)

> Or keep the hook and use it in libata. It makes sense I think in
> general. I reckon other platforms might have good use of being able to
> "remap" those IRQs 14 and 15 from IDE controllers in legacy mode.

Yeah.

> I've
> seen plenty of cases where  they are kept in that mode just to keep the
> IRQs non-shared.

Bad idea IMHO, but hey, can't fix the hardware in software ;-)


Segher
