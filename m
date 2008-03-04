Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3E90EDDE2E
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Mar 2008 14:40:04 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m243dvfb017422
	for <linuxppc-dev@ozlabs.org>; Mon, 3 Mar 2008 22:39:57 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m243dvi2108612
	for <linuxppc-dev@ozlabs.org>; Mon, 3 Mar 2008 22:39:57 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m243duIU004116
	for <linuxppc-dev@ozlabs.org>; Mon, 3 Mar 2008 22:39:57 -0500
Date: Mon, 3 Mar 2008 21:37:18 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Hollis Blanchard <hollisb@us.ibm.com>
Subject: Re: Bamboo PCI interrupt issues
Message-ID: <20080303213718.12291eee@zod.rchland.ibm.com>
In-Reply-To: <1204588953.7921.13.camel@basalt>
References: <1204588953.7921.13.camel@basalt>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: kvm-ppc-devel <kvm-ppc-devel@lists.sourceforge.net>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 03 Mar 2008 18:02:33 -0600
Hollis Blanchard <hollisb@us.ibm.com> wrote:

> I'm having two problems with PCI interrupts as described in bamboo.dts.
> Here is are the properties in question:
> 
> 	/* Bamboo has all 4 IRQ pins tied together per slot */
> 	interrupt-map-mask = <f800 0 0 0>;
> 	interrupt-map = <
> 		/* IDSEL 1 */
> 		0800 0 0 0 &UIC0 1c 8
> 
> 		/* IDSEL 2 */
> 		1000 0 0 0 &UIC0 1b 8
> 
> 		/* IDSEL 3 */
> 		1800 0 0 0 &UIC0 1a 8
> 
> 		/* IDSEL 4 */
> 		2000 0 0 0 &UIC0 19 8
> 	>;
> 
> 
> First, the 440EP[1] and Bamboo[2] user manuals indicate that PCI IRQ 0-3
> -> board IRQ 2-5 -> UIC IRQ 25-28. However, the device tree has that
> reversed, so PCI IRQ 0 appears as UIC IRQ 28 (0x1c).

Actually, the device tree is right.  I got annoyed with myself for not
knowing how this works so I went and figured it out.

2000 0 0 0 is device #4.  According to the specs, device #4 has AD(14)
asserted during type 0 configuration.  Looking at the board schematics,
PCI slot 0 has it's IDSEL line tied to AD(14).  So:

dev #4 -> PCI 0 -> board IRQ 2 -> UIC IRQ 25.

which is exactly what the device tree has.

> Second, the sensitivity seems to be wrong. All these interrupts have the
> sensitivity encoded as 8, which means "high to low edge" in the OpenPIC
> binding. Now, 440EP has a UIC, rather than an OpenPIC, but there is no
> UIC binding AFAICS.

There isn't.  It uses the sense numbers from linux/irq.h.  Which means
8 is level, low.  This matches exactly what the board manual says for
IRQ2-5 on page 69.

> When I change the 8 to a 4 ("active high level"), I see the proper
> values in the UIC polarity register, and PCI interrupts start working in
> KVM.

That's odd.

> Is anybody using Bamboo PCI support right now? Does it actually work?

I plugged in an old 3Com ethernet card tonight.  Slot 0.  It was
assigned dev #4 IRQ 25.  Using the device tree as-is, I could see
interrupts happening in /proc/interrupts but ethernet traffic failed.

Then I changed the sense level to 4 as you suggested, and my card hung
hard on the first ethernet traffic.  I've no idea if we're dealing with
a crappy card or a crappy driver but the device tree seems to be
working ok.  If I can find a different card to test with I will.

Ben, do you have any input here?

josh
