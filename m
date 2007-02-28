Return-Path: <dgibson@ozlabs.org>
Date: Wed, 28 Feb 2007 11:56:15 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Stuart Yoder <b08248@freescale.com>
Subject: Re: [RFC] powerpc: Document new property called interrupt-parents
Message-ID: <20070228005615.GE11775@localhost.localdomain>
References: <200702272254.l1RMsjt2030709@ld0164-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200702272254.l1RMsjt2030709@ld0164-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Feb 27, 2007 at 04:54:45PM -0600, Stuart Yoder wrote:
> 
> Document new property called interrupt-parents which can
> be used to represent interrupts for devices that route
> interrupts to more than one interrupt controller.

Well, whatever Segher says, I'm still very concerned about the
potential for extra difficulty in debugging with this approach.

> 
> Signed-off-by: Stuart Yoder <stuart.yoder@freescale.com>
> ---
> 
>  This is based on the discussions on the list last week and
>  this week.  I realize there are still differences of opinion
>  on interrupts-array vs interrupt-parents but I think the
>  differences between the two options are not that significant.
> 
>  Note: this patch depends on the patch updating the interrupt info
>  in booting-without-of.txt
> 
>  Documentation/powerpc/booting-without-of.txt |   65 +++++++++++++++++++++++++-
>  1 files changed, 63 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
> index 0238a64..89e1c4a 100644
> --- a/Documentation/powerpc/booting-without-of.txt
> +++ b/Documentation/powerpc/booting-without-of.txt
> @@ -1759,7 +1759,68 @@ phandle to the parent node.
>  If the interrupt-parent property is not defined for a node, it's
>  interrupt parent is assumed to be it's device tree_ parent.

Update to say it's assumed be the device tree parent if neither
interrupt-parent nor interrupt-parents exists.

> -3) OpenPIC Interrupt Controllers
> +3) interrupt-parents property
> +-----------------------------
> +
> +For devices that generate interrupts to multiple interrupt
> +controllers, the  interrupt-parent representation
> +is not sufficient because it only describes a single
> +interrupt parent. The 'interrupt-parents' property should be used
> +to represent this (note the plural in the property name).
> +
> +The interrupt-parents property consists of one or more 
> +interrupt parent phandle values each representing the interrupt
> +parent for the corresponding interrupt specifier in the interrupts
> +property:
> +
> +  interrupt-parents = <parent-phandle0 parent-phandle1 ... parent-phandleN>
> +  interrupts = <int-specifier0 int-specifier1 ... int-specifierN>
> +
> +It is required that the number of interrupts encoded in the interrupt-parents
> +property exacly match the number of interrupt specifiers in the interrupts
> +property.
> +

[snip]

> +In the example, the interrupts property and the interrupt-parents
> +property defines three interrupts-- interrupt 0x13 and 0x14 go to
> +the pic0 interrupt controller and interrupt 0x18 goes to pic1.

This is potentially misleading: the interrupt numbers are properties
of the pic, not of the device.  Better to say that for this device,
the first two interrupt lines are routed to irqs 0x13 and 0x14 on
pic0, and the third is routed to irq 0x18 on pic1.  On a board with 3
PICs, it would also be valid to have a device with:
	interrupts = <0x10 0x4 0x10 0x4 0x10 0x4>;
	interrupt-parents = <&pic0 &pic1 &pic2>;

> +Note: each interrupt parent in the interrupt-parents array can
> +potentially specify a different value for #interrupt-cells.  The number
> +of #interrupt-cells for each parent must be determined to correctly
> +parser the interrupts property.

I suggest your example actually show this case, since it's the more
general.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
