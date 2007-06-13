Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net
	[151.189.21.41])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 55E09DDF7F
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jun 2007 15:02:27 +1000 (EST)
In-Reply-To: <1181638939310-git-send-email-wei.zhang@freescale.com>
References: <11816389393593-git-send-email-wei.zhang@freescale.com>
	<1181638939310-git-send-email-wei.zhang@freescale.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <39c7d60cebf03badd106d7f75a08f449@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/5] Add the explanation and sample of RapidIO DTS sector
	to the document of booting-without-of.txt file.
Date: Wed, 13 Jun 2007 07:02:17 +0200
To: Zhang Wei <wei.zhang@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> +   k) RapidIO
> +
> +   Required properties:
> +
> +    - device_type : Should be "rapidio"

There is no OF binding, so no.

> +    - compatible : Should be "fsl,rapidio-v0.0" or "fsl,rapidio-v1.0"
> +      and so on. The version number is got from IP Block Revision
> +      Register of RapidIO controller.

It's better to use real device names, just like everyone
else.

> +    - #address-cells : Address representation for "rapidio" devices.
> +      This field represents the number of cells needed to represent
> +      the RapidIO address of the registers.  For supporting more than
> +      36-bits RapidIO address, this field should be <2>.

More than 32 bit?

> +    - interrupt-parent : the phandle for the interrupt controller that
> +      services interrupts for this device.

Not required, depends on the interrupt tree of the system.

> +    - interrupts : <a b> where a is the interrupt number and b is a
> +      field that represents an encoding of the sense and level
> +      information for the interrupt.

No.  The format of an "interrupts" entry is defined by
the interrupt domain this device sits in, not by the
device itself.

> For this sector, interrupts order should be
> +      <err_irq bell_outb_irq bell_inb_irq msg1_tx_irq msg1_rx_irq
> +      msg2_tx_irq msg2_rx_irq ... msgN_tx_irq msgN_rx_irq>.

That's to be defined in the binding for your specific device,
not in a more generic rapidio binding.

> +		#address-cells = <2>;

You want a #size-cells as well.

Hope this helps,


Segher
