Return-Path: <dgibson@ozlabs.org>
Date: Thu, 28 Jun 2007 10:24:38 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Zhang Wei <wei.zhang@freescale.com>
Subject: Re: [PATCH 1/5 v2] Add the explanation and a sample of RapidIO DTS
	sector to the document of booting-without-of.txt file.
Message-ID: <20070628002438.GB15298@localhost.localdomain>
References: <11829333481420-git-send-email-wei.zhang@freescale.com>
	<11829333481977-git-send-email-wei.zhang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <11829333481977-git-send-email-wei.zhang@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jun 27, 2007 at 04:35:44PM +0800, Zhang Wei wrote:
> Add the explanation and a sample of RapidIO DTS sector to the document of booting-without-of.txt file.
> 
> Signed-off-by: Zhang Wei <wei.zhang@freescale.com>
> ---
>  Documentation/powerpc/booting-without-of.txt |   34 ++++++++++++++++++++++++++
>  1 files changed, 34 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
> index b49ce16..98692ca 100644
> --- a/Documentation/powerpc/booting-without-of.txt
> +++ b/Documentation/powerpc/booting-without-of.txt
> @@ -1727,6 +1727,40 @@ platforms are moved over to use the flattened-device-tree model.
>   		partition-names = "fs\0firmware";
>   	};
>  
> +   k) RapidIO
> +
> +   Required properties:
> +

Should probably recommend a name for the node here, as well.  "srio" I
guess, from the example below.

> +    - compatible : Should be "fsl,rapidio-delta" for Freescale
> +      PowerPC RapidIO controller.
> +    - #address-cells : Address representation for "rapidio" devices.
> +      This field represents the number of cells needed to represent
> +      the RapidIO address of the registers.  For supporting more than
> +      32-bits RapidIO address, this field should be <2>.
> +      See 1) above for more details on defining #address-cells.
> +    - reg : Offset and length of the register set for the device
> +    - ranges : Should be defined as specified in 1) to describe the
> +      translation of addresses for memory mapped RapidIO memory
> +      space.
> +    - interrupts : binding interrupts for this device sector,
> +      please follow below orders:
> +      <err_irq bell_outb_irq bell_inb_irq msg1_tx_irq msg1_rx_irq
> +      msg2_tx_irq msg2_rx_irq ... msgN_tx_irq msgN_rx_irq>.
> +
> +  Example:
> +
> +	srio@c0000{
> +		compatible = "fsl,rapidio-delta";
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		reg = <c0000 20000>;
> +		ranges = <0 0 c0000000 20000000>;
> +		interrupt-parent = <&mpic>;
> +		/* err_irq bell_outb_irq bell_inb_irq msg1_tx_irq msg1_rx_irq
> +						      msg2_tx_irq msg2_rx_irq */
> +		interrupts = <30 2 31 2 32 2 35 2 36 2 37 2 38 2>;
> +	};
> +
>     More devices will be defined as this spec matures.
>  
>  VII - Specifying interrupt information for devices

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
