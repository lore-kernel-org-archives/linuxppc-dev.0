Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 65871DDEC4
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Jan 2007 08:36:13 +1100 (EST)
Subject: Re: [PATCH] Fix Maple PATA IRQ assignment.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <32106685eb2ecb2fb4adcf6e51f71482@kernel.crashing.org>
References: <1167679875.22068.350.camel@pmac.infradead.org>
	<1167682254.23340.131.camel@localhost.localdomain>
	<32106685eb2ecb2fb4adcf6e51f71482@kernel.crashing.org>
Content-Type: text/plain
Date: Tue, 02 Jan 2007 08:33:50 +1100
Message-Id: <1167687230.23340.147.camel@localhost.localdomain>
Mime-Version: 1.0
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

On Mon, 2007-01-01 at 21:44 +0100, Segher Boessenkool wrote:
> > I'm not sure you can switch it to native mode in sw... worth double
> > checking though. All boards based on 8111 on powerpc have this problem,
> > I think. What of the js20 and js21 with IBM firmware ?
> 
> At least with SLOF, we use native mode.
> 
> > Or does it have
> > the ide strapped to native mode ?
> 
> It's not a strapping, it's a purely software thing -- see the PCIIDE
> specification.

I know the PCI IDE spec, but there are a number of chips out there that
cannot be changed without a strap. In this case, it's easy to test
though we'll need fixups in the device-tree to indicate the change in
routing, or a quirk.

The thing is, there -is- a cascaded 8259 in there, and that's where the
IRQ14 and IRQ15 end up in legacy mode (edge sensitive even) iirc, unless
they are aslo routed to the APIC directly, but in anyway it's hidden by
the firmware.

So we can have a quirk in the Maple code to reconfigure that all in
native mode. That will mean a bit more IRQ sharing since both IDE
channels will suddenly share PIRQA though... along with whatever else
uses that pin. Maybe not the best solution...

Or keep the hook and use it in libata. It makes sense I think in
general. I reckon other platforms might have good use of being able to
"remap" those IRQs 14 and 15 from IDE controllers in legacy mode. I've
seen plenty of cases where  they are kept in that mode just to keep the
IRQs non-shared.

> Lots of controllers get the interrupt thing wrong though -- but
> AMD8111 isn't one of those.

Ben.
