Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0530DDE447
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 Jun 2008 03:58:36 +1000 (EST)
Message-ID: <48501248.8010104@freescale.com>
Date: Wed, 11 Jun 2008 12:58:32 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: David Jander <david.jander@protonic.nl>
Subject: Re: [PATCH 1/2] Added support for PRTLVT based boards (MPC5121)
References: <200806111143.08905.david.jander@protonic.nl>
In-Reply-To: <200806111143.08905.david.jander@protonic.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

David Jander wrote:
>  arch/powerpc/platforms/512x/mpc5121_ads.c     |  104 ----------
>  arch/powerpc/platforms/512x/mpc5121_generic.c |  105 ++++++++++

Pass -B -M -C to git-format-patch to detect renames, copies, etc.

> +	flash@fe000000 {
> +		device_type = "rom";
> +		compatible = "direct-mapped";
> +		probe-type = "CFI";
> +		reg = <0xfe000000 0x02000000>;
> +		bank-width = <2>;
> +		partitions = <0x00000000 0x01800000   // filesystem
> +		              0x01800000 0x00200000   // config0
> +		              0x01a00000 0x00200000   // config1
> +		              0x01c00000 0x002e0000   // kernel
> +		              0x01ee0000 0x00020000   // one sector for device tree
> +		              0x01f00000 0x00100000>; // u-boot
> +		partition-names = "filesystem", "config0", "config1","kernel", "device-tree", "u-boot";
> +	};

This is an old flash binding.  Please use the one currently described in 
Documentation/booting-without-of.txt.

> +	soc@80000000 {
> +		compatible = "fsl,mpc5121-immr";

Also simple-bus.

> +		//axe@2000 {
> +		//	compatible = "mpc512x-axe";
> +		//	reg = <2000 100>;
> +		//	interrupts = <2a 8>;
> +		//	interrupt-parent = < &ipic >;
> +		//};

Why is this here, but commented out?

> +		mdio@2800 {
> +			device_type = "mdio";

No device_type.

> +		// PSC4 in i2s mode
> +		i2s@11500 {
> +			device_type = "i2s";

No device_type.

> +		// PSC5 in SPI mode for touchscreen
> +		spi@11500 {
> +			device_type = "spi";

No device_type.

> +		dma2@14000 {
> +			compatible = "fsl,mpc5121-dma2";

Is this DMA controller compatible with drivers/dma/fsldma.c?  If so, 
follow the established binding.

> +config MPC5121_GENERIC
> +	bool
> +	default n
> +
>  config MPC5121_ADS
>  	bool "Freescale MPC5121E ADS"
>  	depends on PPC_MULTIPLATFORM && PPC32
>  	select DEFAULT_UIMAGE
>  	select PPC_MPC5121
> +	select MPC5121_GENERIC
>  	help
>  	  This option enables support for the MPC5121E ADS board.
>  	default n
> +
> +config PRTLVT
> +	bool "Protonic LVT family of MPC5121 based boards"
> +	depends on PPC_MULTIPLATFORM && PPC32
> +	select DEFAULT_UIMAGE
> +	select PPC_MPC5121
> +	select MPC5121_GENERIC
> +	help
> +	  This option enables support for the Protonic LVT family (ZANMCU and VICVT2).
> +	default n

Can we leave out the "default n" lines?  They're no-ops.

I don't think these configs should depend on an option 
(PPC_MULTIPLATFORM) that is described as "Generic desktop/server/laptop"...

-Scott
