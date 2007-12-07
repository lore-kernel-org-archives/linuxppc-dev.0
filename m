Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2520BDDE1C
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2007 14:22:05 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id lB73NjoE004696
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Dec 2007 22:23:45 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lB73M3AW467384
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Dec 2007 22:22:03 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lB73M2VS021467
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Dec 2007 22:22:02 -0500
Date: Thu, 6 Dec 2007 21:19:06 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 19/25] powerpc: Wire up PCI on Bamboo board
Message-ID: <20071206211906.2e1c099f@zod.rchland.ibm.com>
In-Reply-To: <20071206080130.2B29FDE0BA@ozlabs.org>
References: <1196927999.714593.205329520306.qpush@grosgo>
	<20071206080130.2B29FDE0BA@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 06 Dec 2007 19:00:19 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> This adds the device-tree bits & call to ppc4xx_pci_find_bridges()
> to make PCI work on the Bamboo board
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
> 
>  arch/powerpc/boot/dts/bamboo.dts |   40 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 39 insertions(+), 1 deletion(-)
> 
> Index: linux-work/arch/powerpc/boot/dts/bamboo.dts
> ===================================================================
> --- linux-work.orig/arch/powerpc/boot/dts/bamboo.dts	2007-11-30 13:40:21.000000000 +1100
> +++ linux-work/arch/powerpc/boot/dts/bamboo.dts	2007-11-30 13:40:45.000000000 +1100
> @@ -239,10 +239,48 @@
>  				zmii-channel = <1>;
>  			};
>  		};
> +
> +		PCI0: pci@ec000000 {
> +			device_type = "pci";
> +			#interrupt-cells = <1>;
> +			#size-cells = <2>;
> +			#address-cells = <3>;
> +			compatible = "ibm,plb440ep-pci", "ibm,plb-pci";
> +			primary;
> +			reg = <0 eec00000 8	/* Config space access */
> +			       0 eed80000 4	/* IACK */
> +			       0 eed80000 4	/* Special cycle */
> +			       0 ef480000 40>;	/* Internal registers */
> +
> +			/* Outbound ranges, one memory and one IO,
> +			 * later cannot be changed. Chip supports a second
> +			 * IO range but we don't use it for now
> +			 */
> +			ranges = <02000000 0 a0000000 0 a0000000 0 20000000
> +				  01000000 0 00000000 0 e8000000 0 00010000>;
> +
> +			/* Inbound 2GB range starting at 0 */
> +			dma-ranges = <42000000 0 0 0 0 0 80000000>;
> +
> +			/* Walnut has all 4 IRQ pins tied together per slot */

Not a Walnut board.

> +			interrupt-map-mask = <f800 0 0 0>;
> +			interrupt-map = <
> +				/* IDSEL 1 */
> +				0800 0 0 0 &UIC0 1c 8
> +
> +				/* IDSEL 2 */
> +				1000 0 0 0 &UIC0 1b 8
> +
> +				/* IDSEL 3 */
> +				1800 0 0 0 &UIC0 1a 8
> +
> +				/* IDSEL 4 */
> +				2000 0 0 0 &UIC0 19 8
> +			>;
> +		};
>  	};
> 
>  	chosen {
>  		linux,stdout-path = "/plb/opb/serial@ef600300";
> -		bootargs = "console=ttyS0,115200";

Did you remove that for a reason?

josh
