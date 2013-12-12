Return-Path: <hongbo.zhang@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0185.outbound.messaging.microsoft.com [213.199.154.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2D78E2C00A7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Dec 2013 20:57:33 +1100 (EST)
Received: from mail42-db8 (localhost [127.0.0.1])	by mail42-db8-R.bigfish.com
 (Postfix) with ESMTP id 68307B80135	for
 <linuxppc-dev@lists.ozlabs.org>; Thu,
 12 Dec 2013 09:57:27 +0000 (UTC)
Message-ID: <52A9887D.3060109@freescale.com>
Date: Thu, 12 Dec 2013 17:57:17 +0800
From: Hongbo Zhang <hongbo.zhang@freescale.com>
MIME-Version: 1.0
To: Shengzhou Liu <Shengzhou.Liu@freescale.com>,
 <linuxppc-dev@lists.ozlabs.org>, <scottwood@freescale.com>
Subject: Re: [PATCH 1/5] powerpc/85xx/dts: add third elo3 dma component
References: <1386760774-14743-1-git-send-email-Shengzhou.Liu@freescale.com>
In-Reply-To: <1386760774-14743-1-git-send-email-Shengzhou.Liu@freescale.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Shengzhou,
I canceled my patch http://patchwork.ozlabs.org/patch/295157/ because 
the original wrong elo3-dma-2.dtsi hadn't been merged.
But please pay attention to comments from Scott about my changes of 
adding 208 for some interrupts, and take some actions if needed, or 
further discussions.

Below comments form Scott:
"The FSL MPIC binding should be updated to point out how this works.
Technically it's not a change to the binding itself, since it's defined
in terms of register offset, but the explanatory text says "So interrupt
0 is at offset 0x0, interrupt 1 is at offset 0x20, and so on." which is
not accurate for these new high interrupt numbers."


On 12/11/2013 07:19 PM, Shengzhou Liu wrote:
> Add elo3-dma-2.dtsi to support the third DMA controller.
> This is used on T2080, T4240, etc.
>
> MPIC registers for internal interrupts is non-continous in address, any
> internal interrupt number greater than 159 should be added (16+208) to work,
> adding 16 is due to external interrupts as usual, adding 208 is due to
> non-continous MPIC register space.
>
> Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
> Signed-off-by: Hongbo Zhang <hongbo.zhang@freescale.com>
> ---
>   arch/powerpc/boot/dts/fsl/elo3-dma-2.dtsi | 82 +++++++++++++++++++++++++++++++
>   1 file changed, 82 insertions(+)
>   create mode 100644 arch/powerpc/boot/dts/fsl/elo3-dma-2.dtsi
>
> diff --git a/arch/powerpc/boot/dts/fsl/elo3-dma-2.dtsi b/arch/powerpc/boot/dts/fsl/elo3-dma-2.dtsi
> new file mode 100644
> index 0000000..d3cc8d0
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/fsl/elo3-dma-2.dtsi
> @@ -0,0 +1,82 @@
> +/*
> + * QorIQ Elo3 DMA device tree stub [ controller @ offset 0x102300 ]
> + *
> + * Copyright 2013 Freescale Semiconductor Inc.
> + *
> + * Redistribution and use in source and binary forms, with or without
> + * modification, are permitted provided that the following conditions are met:
> + *     * Redistributions of source code must retain the above copyright
> + *       notice, this list of conditions and the following disclaimer.
> + *     * Redistributions in binary form must reproduce the above copyright
> + *       notice, this list of conditions and the following disclaimer in the
> + *       documentation and/or other materials provided with the distribution.
> + *     * Neither the name of Freescale Semiconductor nor the
> + *       names of its contributors may be used to endorse or promote products
> + *       derived from this software without specific prior written permission.
> + *
> + *
> + * ALTERNATIVELY, this software may be distributed under the terms of the
> + * GNU General Public License ("GPL") as published by the Free Software
> + * Foundation, either version 2 of that License or (at your option) any
> + * later version.
> + *
> + * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
> + * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
> + * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
> + * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
> + * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
> + * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
> + * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
> + * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
> + * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
> + * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> + */
> +
> +dma2: dma@102300 {
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +	compatible = "fsl,elo3-dma";
> +	reg = <0x102300 0x4>,
> +	      <0x102600 0x4>;
> +	ranges = <0x0 0x102100 0x500>;
> +	dma-channel@0 {
> +		compatible = "fsl,eloplus-dma-channel";
> +		reg = <0x0 0x80>;
> +		interrupts = <464 2 0 0>;
> +	};
> +	dma-channel@80 {
> +		compatible = "fsl,eloplus-dma-channel";
> +		reg = <0x80 0x80>;
> +		interrupts = <465 2 0 0>;
> +	};
> +	dma-channel@100 {
> +		compatible = "fsl,eloplus-dma-channel";
> +		reg = <0x100 0x80>;
> +		interrupts = <466 2 0 0>;
> +	};
> +	dma-channel@180 {
> +		compatible = "fsl,eloplus-dma-channel";
> +		reg = <0x180 0x80>;
> +		interrupts = <467 2 0 0>;
> +	};
> +	dma-channel@300 {
> +		compatible = "fsl,eloplus-dma-channel";
> +		reg = <0x300 0x80>;
> +		interrupts = <468 2 0 0>;
> +	};
> +	dma-channel@380 {
> +		compatible = "fsl,eloplus-dma-channel";
> +		reg = <0x380 0x80>;
> +		interrupts = <469 2 0 0>;
> +	};
> +	dma-channel@400 {
> +		compatible = "fsl,eloplus-dma-channel";
> +		reg = <0x400 0x80>;
> +		interrupts = <470 2 0 0>;
> +	};
> +	dma-channel@480 {
> +		compatible = "fsl,eloplus-dma-channel";
> +		reg = <0x480 0x80>;
> +		interrupts = <471 2 0 0>;
> +	};
> +};
