Return-Path: <R1AAHA@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 870B81007D1
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jun 2010 08:19:07 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o5TMJ4DH024538
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jun 2010 15:19:04 -0700 (MST)
Received: from az33exm22.fsl.freescale.net (az33exm22.am.freescale.net
	[10.64.32.10])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id o5TMTK0i001405
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jun 2010 17:29:20 -0500 (CDT)
Date: Tue, 29 Jun 2010 17:19:04 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] powerpc: introduce basic support for the Freescale
	P1022DS reference board
Message-Id: <20100629171904.d6ae6233.kim.phillips@freescale.com>
In-Reply-To: <1277847274-24648-1-git-send-email-timur@freescale.com>
References: <1277847274-24648-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 29 Jun 2010 16:34:34 -0500
Timur Tabi <timur@freescale.com> wrote:

> Introduce basic support for the Freescale P1022DS reference board, based on the
> Freescale BSP for this board.
> 
> Details: No DIU video or SSI audio support, no MMC/SD card support, 36-bit and
> SWIOTLB support enabled, 36-bit DTS only, and CONFIG_NO_HZ disabled because it
> causes performance problems on this kernel.

what kind of performance problems?

> +		enet0: ethernet@B0000 {
> +			queue-group@0{
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +				reg = <0xB0000 0x1000>;
> +				fsl,rx-err-int-map = <0xAA>;
> +				fsl,tx-int-map = <0xAA>;
> +				interrupts = <29 2 30 2 34 2>;
> +			};
> +			queue-group@1{
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +				reg = <0xB4000 0x1000>;
> +				fsl,rx-err-int-map = <0x55>;
> +				fsl,tx-int-map = <0x55>;
> +				interrupts = <17 2 18 2 24 2>;
> +			};
> +		};
> +
> +		enet1: ethernet@B1000 {

> +			queue-group@0{
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +				reg = <0xB1000 0x1000>;
> +				fsl,rx-err-int-map = <0xAA>;
> +				fsl,tx-int-map = <0xAA>;
> +				interrupts = <35 2 36 2 40 2>;
> +			};
> +			queue-group@1{
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +				reg = <0xB5000 0x1000>;
> +				fsl,rx-err-int-map = <0x55>;
> +				fsl,tx-int-map = <0x55>;
> +				interrupts = <51 2 52 2 67 2>;
> +			};

these queue-group nodes, fsl,{r,t}x-* properties...

> +		crypto@30000 {

> +			fsl,multi-host-mode = "dual";
> +			fsl,channel-remap = <0x3>;

and the above two properties aren't supported by their respective
drivers, nor are they listed in the dts bindings documentation.

Kim
