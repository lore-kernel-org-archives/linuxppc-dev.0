Return-Path: <timur@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B5943DDDF2
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Nov 2007 01:58:51 +1100 (EST)
Message-ID: <474447EF.8080405@freescale.com>
Date: Wed, 21 Nov 2007 08:59:59 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 3/3] [POWERPC] Add docs for Freescale DMA & DMA channel
	device	tree nodes
References: <Pine.LNX.4.64.0711202310280.24220@blarg.am.freescale.net>
	<Pine.LNX.4.64.0711202314030.24220@blarg.am.freescale.net>
In-Reply-To: <Pine.LNX.4.64.0711202314030.24220@blarg.am.freescale.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:

> +   * Freescale 83xx DMA Controller
> +
> +    Freescale PowerPC 83xx have on chip general purpose DMA controllers.
> +
> +    Required properties:
> +
> +    - compatible        : compatible list, contains 2 entries, first is
> +			 "fsl,CHIP-dma", where CHIP is the processor
> +			 (mpc8349, mpc8360, etc.) and the second is
> +			 "fsl,elo-dma"

Shouldn't we put some text somewhere that we're calling it the Elo controller 
even though that word isn't used in the reference manual?

> +   * Freescale 85xx DMA Controller

And 86xx.

> +
> +    Freescale PowerPC 85xx have on chip general purpose DMA controllers.
> +
> +    Required properties:
> +
> +    - compatible        : compatible list, contains 2 entries, first is
> +			 "fsl,CHIP-dma", where CHIP is the processor
> +			 (mpc8540, mpc8540, etc.) and the second is
> +			 "fsl,eloplus-dma"
> +    - reg               : <registers mapping for DMA general status reg>
> +    - ranges 		: Should be defined as specified in 1) to describe the
> +			  DMA controller channels.
> +
> +    - DMA channel nodes:
> +	    - compatible        : compatible list, contains 2 entries, first is
> +				 "fsl,CHIP-dma-channel", where CHIP is the processor
> +				 (mpc8540, mpc8560, etc.) and the second is
> +				 "fsl,eloplus-dma-channel"
> +	    - reg               : <registers mapping for channel>
> +	    - interrupts        : <interrupt mapping for DMA channel IRQ>
> +	    - interrupt-parent  : optional, if needed for interrupt mapping
> +
> +  Example:
> +	dma@21000 {

Shouldn't this be dma@21300?

> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "fsl,mpc8540-dma", "fsl,eloplus-dma";
> +		reg = <21300 4>;
> +		ranges = <0 21100 200>;
> +		dma-channel@0 {
> +			compatible = "fsl,mpc8540-dma-channel", "fsl,eloplus-dma-channel";
> +			reg = <0 80>;
> +			interrupt-parent = <&mpic>;
> +			interrupts = <14 2>;
> +		};

The DMA controller and the DMA channels need a "device-id", so that they can 
be identified by number.  Some peripherals, like the SSI, can only use the 
controller and channel number.  This is what I have in my 8610 DTS:

                 dma@21300 {
                         #address-cells = <1>;
                         #size-cells = <1>;
                         compatible = "fsl,mpc8610-dma", "fsl,mpc8540-dma";
         -->             device-id = <0>;
                         reg = <21300 4>; /* DMA general status register */
                         ranges = <0 21100 200>;

                         dma-channel@0 {
                                 compatible = "fsl,mpc8610-dma-channel",
                                         "fsl,mpc8540-dma-channel";
         -->                     device-id = <0>;
                                 reg = <0 80>;
                                 interrupt-parent = <&mpic>;
                                 interrupts = <14 2>;
                         };

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
