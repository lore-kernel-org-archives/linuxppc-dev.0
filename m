Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4CA67DDE43
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 08:30:28 +1100 (EST)
Message-ID: <4796605B.2000807@freescale.com>
Date: Tue, 22 Jan 2008 15:30:03 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] Add docs for Freescale DMA & DMA channel device
	tree nodes
References: <Pine.LNX.4.64.0801221511540.24873@blarg.am.freescale.net>
In-Reply-To: <Pine.LNX.4.64.0801221511540.24873@blarg.am.freescale.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> Signed-off-by: Zhang Wei <wei.zhang@freescale.com>
> Signed-off-by: Ebony Zhu <ebony.zhu@freescale.com>
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
> 
> Guys please review and make sure I got all your previous comments fixed
> up.  I've added cell-index. and the examples should represent real HW.
> 
>  Documentation/powerpc/booting-without-of.txt |  128 ++++++++++++++++++++++++++
>  1 files changed, 128 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
> index da98154..3584c33 100644
> --- a/Documentation/powerpc/booting-without-of.txt
> +++ b/Documentation/powerpc/booting-without-of.txt
> @@ -2615,6 +2615,134 @@ platforms are moved over to use the flattened-device-tree model.
>         - clock-frequency  : The frequency of the input clock, which typically
>                              comes from an on-board dedicated oscillator.
> 
> +    * Freescale 83xx DMA Controller
> +
> +    Freescale PowerPC 83xx have on chip general purpose DMA controllers.
> +
> +    Required properties:
> +
> +    - compatible        : compatible list, contains 2 entries, first is
> +			 "fsl,CHIP-dma", where CHIP is the processor
> +			 (mpc8349, mpc8360, etc.) and the second is
> +			 "fsl,elo-dma"
> +    - reg               : <registers mapping for DMA general status reg>
> +    - ranges 		: Should be defined as specified in 1) to describe the
> +			  DMA controller channels.

What does "Should be defined as specified in 1)" mean?

> +    - cell-index        : controller index.  0 for controller @ 0x8100

This should be more generic.  I believe for each of our SoCs, we designation one 
DMA controller to be "DMA Controller 1", and that one should have a cell-index 
of "0".

> +    - interrupts        : <interrupt mapping for DMA IRQ>
> +    - interrupt-parent  : optional, if needed for interrupt mapping

On 83xx, all DMA channels share the same interrupt?  Couldn't we just specify 
the same IRQ in each channel's node, so that they look the same across 83xx, 
85xx, and 86xx?  My sound driver doesn't use Extended Mode, but it does check 
for "fsl,8610-dma-channel".  I'm thinking that maybe I should change to to look 
for "elo" or "eloplus", but it would be nice if we could make the DMA node for 
an 86xx SoC compatible with a driver that expects "fsl,elo-dma-channel".

-- 
Timur Tabi
Linux kernel developer at Freescale
