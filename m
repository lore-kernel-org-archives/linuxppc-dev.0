Return-Path: <dgibson@ozlabs.org>
Date: Thu, 1 Feb 2007 11:25:34 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Klossner <andrew@cesa.opbu.xerox.com>
Subject: Re: I don't understand #size-cells = <0>
Message-ID: <20070201002534.GD29213@localhost.localdomain>
References: <200702010022.l110MCan009105@pogo.cesa.opbu.xerox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200702010022.l110MCan009105@pogo.cesa.opbu.xerox.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 31, 2007 at 04:22:12PM -0800, Andrew Klossner wrote:
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

The #address-cells and #size-cells properties apply to children of the
node they appear in, but not in the node itself.  So the "reg" here
uses the #address-cells and #size-cells values from its parent.

This is so that a bridge to a different bus (say, PCI<->USB) can have
a reg property in the format of its parent bus for the control
registers, but define a new address format for things on the
subordinate bus.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
