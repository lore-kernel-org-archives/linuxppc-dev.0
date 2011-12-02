Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 1D289B6F6B
 for <linuxppc-dev@ozlabs.org>; Sat,  3 Dec 2011 09:19:40 +1100 (EST)
Received: from mail164-ch1 (localhost [127.0.0.1])	by
 mail164-ch1-R.bigfish.com (Postfix) with ESMTP id 09EF9120510	for
 <linuxppc-dev@ozlabs.org>; Fri,  2 Dec 2011 22:19:37 +0000 (UTC)
Received: from CH1EHSMHS004.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.240])	by mail164-ch1.bigfish.com (Postfix) with ESMTP id
 AA3A1300043	for <linuxppc-dev@ozlabs.org>; Fri,  2 Dec 2011 22:19:36 +0000
 (UTC)
Message-ID: <4ED94EF5.2090406@freescale.com>
Date: Fri, 2 Dec 2011 16:19:33 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 2/2] powerpc/85xx: add a 32-bit P1022DS device tree
References: <1322863714-6818-1-git-send-email-timur@freescale.com>
 <1322863714-6818-2-git-send-email-timur@freescale.com>
In-Reply-To: <1322863714-6818-2-git-send-email-timur@freescale.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@ozlabs.org, kumar.gala@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/02/2011 04:08 PM, Timur Tabi wrote:
> +	lbc: localbus@ffe05000 {
> +		reg = <0x0 0xffe05000 0 0x1000>;
> +		ranges = <0x0 0x0 0x0 0xe8000000 0x08000000
> +			  0x1 0x0 0x0 0xe0000000 0x08000000
> +			  0x2 0x0 0x0 0xff800000 0x00040000
> +			  0x3 0x0 0x0 0xffdf0000 0x00008000>;
> +
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
> +		nor@0,0 {
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			compatible = "cfi-flash";
> +			reg = <0x0 0x0 0x8000000>;
> +			bank-width = <2>;
> +			device-width = <1>;
[snip]
> +		};
> +
> +		nand@2,0 {
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			compatible = "fsl,elbc-fcm-nand";
> +			reg = <0x2 0x0 0x40000>;
[snip]
> +			};
> +		};
> +
> +		board-control@3,0 {
> +			compatible = "fsl,p1022ds-fpga", "fsl,fpga-ngpixis";
> +			reg = <3 0 0x30>;
> +			interrupt-parent = <&mpic>;
> +			/*
> +			 * IRQ8 is generated if the "EVENT" switch is pressed
> +			 * and PX_CTL[EVESEL] is set to 00.
> +			 */
> +			interrupts = <8 8 0 0>;
> +		};
> +	};
[snip]
> +/include/ "fsl/p1022si-post.dtsi"

Please add something after post to strip simple-bus off of the localbus
node's compatible.  Either you have board-control@0,0, or you have the
other stuff (did you ever find out what the situation with NAND is?) --
not both at the same time.  Or do you have U-Boot patching in status
updates now?

I realize this isn't a 32-bit versus 36-bit issue, but this seemed as
good a time as any to repeat this complaint. :-)

-Scott
