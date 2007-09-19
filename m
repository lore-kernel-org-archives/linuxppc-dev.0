Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 61FFADDE25
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Sep 2007 10:25:36 +1000 (EST)
In-Reply-To: <20070917130005.GA29654@ru.mvista.com>
References: <20070917130005.GA29654@ru.mvista.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <19e5f15308dfb8e60e2e49379666d00a@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/3] usb: ehci-ppc-of dts bindings.
Date: Wed, 19 Sep 2007 02:25:09 +0200
To: Valentine Barshak <vbarshak@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org, linux-usb-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> +  l) USB EHCI controllers
> +
> +  Required properties:
> +  - device_type : should be "usb".

No device_type please.  The published USB binding doesn't define
one on purpose.

> +  - compatible : should be "ehci".

Just "ehci" isn't enough -- compare to OHCI, which is the name for
a kind of USB host controller as well as for a kind of Firewire
host controller.

Maybe "usb-ehci" is best -- can anyone think of a better name?

> +  - reg : Offset and length of the register set for the device

Address and length.  You also should declare here how the optional
EHCI register blocks should be encoded (the USB debug port, etc.)

> +  - interrupts : <a b> where a is the interrupt number and b is a
> +    field that represents an encoding of the sense and level
> +    information for the interrupt.

This is incorrect; not all interrupt domains use two cells, and
not all that do have this meaning for those cells.

Instead, you should just say how many interrupts should be here,
and which is which in the EHCI standard.

> +  - interrupt-parent : the phandle for the interrupt controller that
> +    services interrupts for this device.

Not every EHCI node needs this; just don't mention this at all,
interrupt mapping is fully defined for all devices elsewhere
already (in the "interrupt mapping" recommended practice).

> +  If device registers are implemented in big endian mode, the device
> +  node should have "big-endian" property.
> +  If controller implementation operates with big endian descriptors,
> +  compatible should also have "ehci-be-desc"

Ah, I understand what this is about, finally.

Don't put this in "compatible"; instead, do a "big-endian-descriptors"
property similar to the "big-endian" property.  That last one should
maybe be "big-endian-registers" here then, to avoid confusion.

Or make "big-endian" mean both big-endian registers *and* big-endian
descriptors.

I have no opinion which is best; it depends on what configurations
actually exist, and how popular those are.

> +	ehci@e0000300 {
> +		device_type = "usb";
> +		compatible = "ibm,ehci-440epx", "ehci-be-desc", "ehci";
> +		interrupts = <1a 4>;
> +		interrupt-parent = <&UIC0>;
> +		reg = <0 e0000300 ff>;

Length should be 100 here.

> +		big-endian;
> +	};


Segher
