Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C4526DDE21
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2007 18:51:06 +1000 (EST)
In-Reply-To: <11854393733580-git-send-email-wei.zhang@freescale.com>
References: <11854393721520-git-send-email-wei.zhang@freescale.com>
	<11854393733580-git-send-email-wei.zhang@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <98CA70A1-9888-4508-A0E9-0EB28C14945F@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/5 v3] Add the explanation and a sample of RapidIO OF
	node to the document of booting-without-of.txt file.
Date: Fri, 27 Jul 2007 03:51:54 -0500
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


On Jul 26, 2007, at 3:42 AM, Zhang Wei wrote:

> Add the explanation and a sample of RapidIO OF node to the document  
> of booting-without-of.txt file.
>
> Signed-off-by: Zhang Wei <wei.zhang@freescale.com>
> ---
>  Documentation/powerpc/booting-without-of.txt |   37 +++++++++++++++ 
> +++++++++++
>  1 files changed, 37 insertions(+), 0 deletions(-)
>
> diff --git a/Documentation/powerpc/booting-without-of.txt b/ 
> Documentation/powerpc/booting-without-of.txt
> index 76733a3..d89b805 100644
> --- a/Documentation/powerpc/booting-without-of.txt
> +++ b/Documentation/powerpc/booting-without-of.txt
> @@ -1824,6 +1824,43 @@ platforms are moved over to use the  
> flattened-device-tree model.
>  		fsl,has-rstcr;
>  	};
>
> +   l) RapidIO
> +
> +   RapidIO is a definition of a system interconnect. This node add
> +   the support for RapidIO processor in kernel. The node name is
> +   suggested to be 'rapidio'.
> +
> +   Required properties:
> +
> +    - compatible : Using "fsl,rapidio-delta" for Freescale PowerPC
> +      RapidIO controller.
> +    - #address-cells : Address representation for "rapidio" devices.
> +      This field represents the number of cells needed to represent
> +      the RapidIO address of the registers.

Can you explain this a little further.  I'm a bit confused by  
'RapidIO address of the registers'.

> +      See 1) above for more details on defining #address-cells.
> +    - reg : Offset and length of the register set for the device
> +    - ranges : Should be defined as specified in 1) to describe the
> +      translation of addresses for memory mapped RapidIO memory
> +      space.
> +    - interrupts : binding interrupts for this device node,
> +      please follow below orders:
> +      <err_irq bell_outb_irq bell_inb_irq msg1_tx_irq msg1_rx_irq
> +      msg2_tx_irq msg2_rx_irq ... msgN_tx_irq msgN_rx_irq>.
> +
> +  Example:
> +
> +	rapidio@c0000 {
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
> -- 
> 1.5.1
