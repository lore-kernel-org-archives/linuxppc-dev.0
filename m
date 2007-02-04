Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 26294DDE2D
	for <linuxppc-dev@ozlabs.org>; Mon,  5 Feb 2007 10:43:20 +1100 (EST)
Subject: Re: I don't understand #size-cells = <0>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Klossner <andrew@cesa.opbu.xerox.com>
In-Reply-To: <200702010022.l110MCan009105@pogo.cesa.opbu.xerox.com>
References: <200702010022.l110MCan009105@pogo.cesa.opbu.xerox.com>
Content-Type: text/plain
Date: Mon, 05 Feb 2007 10:43:05 +1100
Message-Id: <1170632585.2620.45.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-01-31 at 16:22 -0800, Andrew Klossner wrote:
> I'm porting the kernel to an 8548-based board whose boot loader does
> not provide a device tree, so I'm rolling my own.
> 
> Rev 0.5 of booting-without-of.txt says:
> 
> 	"reg" properties are always a tuple of the type "address size"
> 	where the number of cells of address and size is specified by
> 	the bus #address-cells and #size-cells.
> 
> but in the examples, we see
> 
> 		reg = <22000 1000>;
> 		#address-cells = <1>;
> 		#size-cells = <0>;
> 
> The number of cells of address is 1.  The number of cells of size is 0.
> 1+0=1, so how can the reg property have a tuple of size 2?

Regardless of #size-cell of #address-cell, you are getting one basic
assumption wrong: those properties don't apply to the node itself but to
-children- of that node.

They are typically in a bus node to define the format of the "reg"
properties of nodes -under- that bus node.

Now, there are a few cases where #size-cells is 0, mostly it is an
unofficial and common way to say that devices on that bus aren't mmio
mapped. For example, take an i2c bus. Devices decode one and only one
address (ok, maybe 2, but the concept of "range" is irrelevant) and
there is no direct MMIO translation. This is typically a case where
#size-cells is 0. Another common example is /cpus (which is the parent
for all cores in the system). The cpus themselves have a reg property
that contain their physical ID, there is no concept of ranges of
addresses, thus #size-cell is 0.

Ben.
