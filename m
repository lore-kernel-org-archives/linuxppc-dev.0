Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-08.arcor-online.net (mail-in-08.arcor-online.net
	[151.189.21.48])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8BB7ADDE08
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Feb 2007 18:19:46 +1100 (EST)
In-Reply-To: <200702212325.l1LNPBwL007793@ld0164-tx32.am.freescale.net>
References: <200702212325.l1LNPBwL007793@ld0164-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <9841c5ba165e4bec773366568b3d4195@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: document new interrupt-array property
Date: Thu, 22 Feb 2007 08:19:32 +0100
To: Stuart Yoder <b08248@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Added description of an interrupt-array property. This
> is needed to cleanly describe the interrupt properties
> of devices with interrupts routed to multiple
> interrupt controllers.

I don't really like the idea of adding a new redundant
property to handle this non-problem; but assuming you _do_
really want to add new properties, here are some comments.

> +The the device tree represents the busses and


The the.

> +In addition, a logical 'interrupt tree' exists which
> +represents the interrupt routing and topology of the
> +hardware.

The logical topology only, not necessarily the physical.
And it's not necessarily a tree, you might want to mention
that here, not everyone reads the references :-)

> Devices that generate interrupts have
> +a property with a value which is a phandle to the
> +parent node in the interrupt tree.

Most don't actually, there only is an "interrupt-parent"
property if you don't get to your interrupt parent by
simply walking up in the device tree until you hit an
interrupt controller (possibly applying interrupt maps
along the way).  [All non-root interrupt controllers are
also required to have an "interrupt-parent" property,

> +The interrupt tree model is fully described in the the
> +document "Open Firmware Recommended Practice: Interrupt
> +Mapping Version 0.9".  The document is available at:
> +http://playground.sun.com/1275/practice.

Don't tuck the full stop onto the URL, it makes it hard to
select it.  One good way is to put < > around the URL.

> Each device which generates
> +interrupts should have the following properties:
> +
> +	- interrupt-parent : contains the phandle of the interrupt
> +          controller which handles interrupts for this device
> +          (Note: if interrupt-parent is not specified the interrupt
> +           parent is assumed to be the device tree parent)

Many interrupt devices _shouldn't_ have this property.

> +	- interrupts : a list of tuples representing the interrupt
> +          number and the interrupt sense and level for each interrupt
> +          for this device.

That combination is called an "interrupt specifier", and it
can contain more information (or even different information)
than just number and sense/level.

> +   Devices connected to openPIC-compatible controllers should encode

It's spelled OpenPIC.

> +The interrupt-array property consists of an arbitrary number
> +of 2-tuples consisting of a interrupt parent phandle and
> +an interrupt specifier.

It would be nicer to keep the "interrupts" property and
add a property "interrupt-parents" with the same number
of entries, that encodes the same as "interrupt-parent"
but per interrupt.  You keep more in line with the
"normal" stuff and I suspect it's less code to parse as
well.

> +   ethernet@25000 {
> +       #address-cells = <1>;
> +       #size-cells = <0>;
> +       device_type = "network";
> +       model = "TSEC";

"model" should be more specific, please don't show bad
practice in examples :-)

> +In the example, the interrupt-array defines three
> +interrupts-- interrupt 0x13 and 0x14 go to the pic0 interrupt
> +controller and interrupt 18 goes to pic1.

0x18

> +Note: the number of cells needed to represent the
> +interrupt-specifier is determined by the #interrupt-cells
> +property of the interrupt parent.

Wrong place to document this?  It's true for all interrupt
specifiers.


Segher
