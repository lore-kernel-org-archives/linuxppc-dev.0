Return-Path: <B07421@freescale.com>
Received: from AM1EHSOBE005.bigfish.com (am1ehsobe005.messaging.microsoft.com
 [213.199.154.208])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 3130EB7252
 for <linuxppc-dev@ozlabs.org>; Fri, 18 Nov 2011 08:50:11 +1100 (EST)
Received: from mail46-am1 (localhost [127.0.0.1])	by mail46-am1-R.bigfish.com
 (Postfix) with ESMTP id B006240013F	for <linuxppc-dev@ozlabs.org>;
 Thu, 17 Nov 2011 21:48:54 +0000 (UTC)
Received: from AM1EHSMHS009.bigfish.com (unknown [10.3.201.252])	by
 mail46-am1.bigfish.com (Postfix) with ESMTP id 6AD4C40048	for
 <linuxppc-dev@ozlabs.org>; Thu, 17 Nov 2011 21:48:54 +0000 (UTC)
Date: Thu, 17 Nov 2011 15:50:02 -0600
From: Scott Wood <scottwood@freescale.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 1/2] powerpc/85xx: add pixis indirect mode device tree node
Message-ID: <20111117215002.GD14736@schlenkerla.am.freescale.net>
References: <1321556259-4459-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1321556259-4459-1-git-send-email-timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org, kumar.gala@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 17, 2011 at 12:57:38PM -0600, Timur Tabi wrote:
> The Freescale P1022 has a unique pin muxing "feature" where the DIU video
> controller's video signals are muxed with 24 of the local bus address signals.
> When the DIU is enabled, the bulk of the local bus is disabled, preventing
> access to memory-mapped devices like NOR flash and the pixis FPGA.
> 
> In this situation, the pixis supports "indirect mode", which allows access
> to the pixis itself by reading/writing addresses on specific local bus
> chip selects.  CS0 is used to select which pixis register to access, and
> CS1 is used to read/write the value.
> 
> To support this, we introduce another board-control child node of the
> localbus node that contains a 'reg' property for CS0 and CS1.  This will
> produce the correct physical addresses for CS0 and CS1.
> 
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
>  arch/powerpc/boot/dts/p1022ds.dts |   14 ++++++++++++++
>  1 files changed, 14 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/boot/dts/p1022ds.dts b/arch/powerpc/boot/dts/p1022ds.dts
> index 24a73e9..3e85d8c 100644
> --- a/arch/powerpc/boot/dts/p1022ds.dts
> +++ b/arch/powerpc/boot/dts/p1022ds.dts
> @@ -24,6 +24,20 @@
>  			  0x2 0x0 0xf 0xffa00000 0x00040000
>  			  0x3 0x0 0xf 0xffdf0000 0x00008000>;
>  
> +		/*
> +		 * This node is used to access the pixis via "indirect" mode,
> +		 * which is done by writing the pixis register index to chip
> +		 * select 0 and the value to/from chip select 1.  Indirect
> +		 * mode is the only way to access the pixis when DIU video
> +		 * is enabled.  Note that this assumes that the first column
> +		 * of the 'ranges' property above is the chip select number.
> +		 */
> +		board-control@0,0 {
> +			compatible = "fsl,p1022ds-indirect-pixis";
> +			reg = <0x0 0x0 1	/* CS0 */
> +			       0x1 0x0 1>;	/* CS1 */
> +		};
> +
>  		nor@0,0 {
>  			#address-cells = <1>;
>  			#size-cells = <1>;

U-Boot should mark some of these devices as disabled, based on whether
indirect mode is enabled on boot.  If you're not going to do that, at
least remove simple-bus from the compatible list.

Something like this is probably the best way to describe it:

localbus {
	compatible = "...", "fsl,elbc", "simple-bus";
	ranges = <...>;
	#address-cells = <2>;
	#size-cells = <2>;

	mux {
		compatible = "fsl,p1022ds-localbus-mux"; // no simple-bus
		fsl,localbus-mux-mode = "indirect"; // inital state on boot
		ranges;
		#address-cells = <2>;
		#size-cells = <2>;

		board-control@0,0 {
			compatible = "fsl,p1022ds-indirect-pixis";
			reg = <0 0 1
			       1 0 1>;
			fsl,localbus-mux-avail = "indirect";
		};

		flash@0,0 {
			...
			fsl,localbus-mux-avail = "direct";
		};

		...
	};
};

Or encode the mode as part of reg, as I suggested for someone else here:
http://lists.ozlabs.org/pipermail/devicetree-discuss/2011-November/009378.html

-Scott
