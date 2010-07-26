Return-Path: <glikely@secretlab.ca>
Received: from mail-px0-f170.google.com (mail-px0-f170.google.com
	[209.85.212.170]) by ozlabs.org (Postfix) with ESMTP id DDC71B70A4
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Jul 2010 10:33:46 +1000 (EST)
Received: by pxi6 with SMTP id 6so5194472pxi.15
	for <linuxppc-dev@ozlabs.org>; Sun, 25 Jul 2010 17:33:45 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
Date: Sun, 25 Jul 2010 18:33:43 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Mingkai Hu <Mingkai.hu@freescale.com>
Subject: Re: [PATCH 5/6] powerpc/of: add eSPI controller dts bindings
Message-ID: <20100726003343.GD25419@angua.secretlab.ca>
References: <1279591705-7574-1-git-send-email-Mingkai.hu@freescale.com>
	<1279591705-7574-2-git-send-email-Mingkai.hu@freescale.com>
	<1279591705-7574-3-git-send-email-Mingkai.hu@freescale.com>
	<1279591705-7574-4-git-send-email-Mingkai.hu@freescale.com>
	<1279591705-7574-5-git-send-email-Mingkai.hu@freescale.com>
	<1279591705-7574-6-git-send-email-Mingkai.hu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1279591705-7574-6-git-send-email-Mingkai.hu@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 20, 2010 at 10:08:24AM +0800, Mingkai Hu wrote:
> Signed-off-by: Mingkai Hu <Mingkai.hu@freescale.com>
> ---
>  Documentation/powerpc/dts-bindings/fsl/spi.txt |   20 ++++++++++++++++++++
>  1 files changed, 20 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/powerpc/dts-bindings/fsl/spi.txt b/Documentation/powerpc/dts-bindings/fsl/spi.txt
> index 80510c0..b360bf9 100644
> --- a/Documentation/powerpc/dts-bindings/fsl/spi.txt
> +++ b/Documentation/powerpc/dts-bindings/fsl/spi.txt
> @@ -29,3 +29,23 @@ Example:
>  		gpios = <&gpio 18 1	// device reg=<0>
>  			 &gpio 19 1>;	// device reg=<1>
>  	};
> +
> +
> +* eSPI (Enhanced Serial Peripheral Interface)
> +
> +Required properties:
> +- compatible : should be "fsl,espi".

Good practice is to always fully identify the SoC in the compatible values, followed by an optional list of other specific chips it is compatible with.  Generic compatibles like "fsl,espi" are not a good idea.

+- compatible: should be "fsl,<chip>-espi".

> +- reg : Offset and length of the register set for the device.
> +- interrupts : should contain eSPI interrupt, the device has one interrupt.
> +- fsl,espi-num-chipselects : the number of the chipselect signals.
> +
> +Example:
> +	spi@110000 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "fsl,espi";
> +		reg = <0x110000 0x1000>;
> +		interrupts = <53 0x2>;
> +		interrupt-parent = <&mpic>;
> +		fsl,espi-num-chipselects = <4>;
> +	};
> -- 
> 1.6.4
> 
> 
