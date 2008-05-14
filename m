Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 51E8BDDEDB
	for <linuxppc-dev@ozlabs.org>; Thu, 15 May 2008 09:27:23 +1000 (EST)
Message-ID: <482B7588.1010201@freescale.com>
Date: Wed, 14 May 2008 18:28:08 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: akpm@linux-foundation.org
Subject: Re: [patch 1/1] fsldma: the MPC8377MDS board device tree node for
	fsldma	driver
References: <200805142317.m4ENHNlm026461@imap1.linux-foundation.org>
In-Reply-To: <200805142317.m4ENHNlm026461@imap1.linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: shannon.nelson@intel.com, linuxppc-dev@ozlabs.org, paulus@samba.org,
	galak@gate.crashing.org, dan.j.williams@intel.com, wei.zhang@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

akpm@linux-foundation.org wrote:
> From: Zhang Wei <wei.zhang@freescale.com>
> 
> The fsldma driver is tested on MPC8377MDS board.  The patch adds fsldma driver
> support into MPC8377MDS device tree.
> 
> Signed-off-by: Zhang Wei <wei.zhang@freescale.com>
> Cc: "Nelson, Shannon" <shannon.nelson@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Kumar Gala <galak@gate.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  arch/powerpc/boot/dts/mpc8377_mds.dts |   27 ++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff -puN arch/powerpc/boot/dts/mpc8377_mds.dts~fsldma-the-mpc8377mds-board-device-tree-node-for-fsldma-driver arch/powerpc/boot/dts/mpc8377_mds.dts
> --- a/arch/powerpc/boot/dts/mpc8377_mds.dts~fsldma-the-mpc8377mds-board-device-tree-node-for-fsldma-driver
> +++ a/arch/powerpc/boot/dts/mpc8377_mds.dts
> @@ -295,6 +295,33 @@
>  			};
>  		};
>  
> +		dma@82a8 {
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			compatible = "fsl,mpc8349-dma";
> +			reg = <0x82a8 4>;
> +			ranges = <0 0x8100 0x1a8>;
> +			interrupt-parent = <&ipic>;
> +			interrupts = <0x47 8>;
> +			cell-index = <0>;
> +			dma-channel@0 {
> +				compatible = "fsl,mpc8349-dma-channel";
> +				reg = <0 0x80>;
> +			};
> +			dma-channel@80 {
> +				compatible = "fsl,mpc8349-dma-channel";
> +				reg = <0x80 0x80>;
> +			};
> +			dma-channel@100 {
> +				compatible = "fsl,mpc8349-dma-channel";
> +				reg = <0x100 0x80>;
> +			};
> +			dma-channel@180 {
> +				compatible = "fsl,mpc8349-dma-channel";
> +				reg = <0x180 0x28>;
> +			};

According to booting-without-of.txt, the interrupts property should be 
repeated in each channel.  The driver also needs to be fixed to remember 
whether it registered a DMA-block-level interrupt handler already, and 
not try to register a channel interrupt.

-Scott
