Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7E9D3DDDD6
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2007 12:29:38 +1100 (EST)
Message-ID: <4758A27F.7030601@freescale.com>
Date: Thu, 06 Dec 2007 19:31:43 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Clemens Koller <clemens.koller@anagramm.de>
Subject: Re: MPC85xx DMA drivers, first testing results.
References: <47586E72.3050106@anagramm.de>
In-Reply-To: <47586E72.3050106@anagramm.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Clemens Koller wrote:
> Hi There!
> 
> I just tried to use the fsldma on the mpc8540. It seems to work fine
> here, but I would be glad if somebody can confirm before I move on:
> 
> I added the following to my mpc8540ads compatible board's .dts
> (see my comments, where the not yet available documentation
> was unclear):
> 
> dma@21000 {
>          #address-cells = <1>;
>          #size-cells = <1>;
>          compatible = "fsl,mpc8540-dma", "fsl,eloplus-dma";
>          device-id = <0>;
>          reg = <21300 4>;        /* DGSR - DMA general status register */
>          /* reg = <21000 4>;*/   /* or use offset of DMA machine ??? */
>          ranges = <0 21100 200>; /* we have 4 DMA channels at 21100, size=80 each */
>          dma-channel@0 {
>                  compatible = "fsl,mpc8540-dma-channel", "fsl,eloplus-dma-channel";
>                  device-id = <0>; /* or cell-index ??? */
>                  reg = <0 80>;
>                  interrupt-parent = <&mpic>;
>                  interrupts = <14 2>;
>          };

Do this:

                 dma@21300 {
                         #address-cells = <1>;
                         #size-cells = <1>;
                         compatible = "fsl,mpc8540-dma", "fsl,eloplus-dma";
                         cell-index = <0>;
                         reg = <21300 4>; /* DMA general status register */
                         ranges = <0 21100 200>;

                         dma-channel@0 {
                                 compatible = "fsl,mpc8540-dma-channel", 
"fsl,eloplus-dma-channel";
                                 cell-index = <0>;
                                 reg = <0 80>;
                                 interrupt-parent = <&mpic>;
                                 interrupts = <14 2>;
                         };


-- 
Timur Tabi
Linux Kernel Developer @ Freescale
