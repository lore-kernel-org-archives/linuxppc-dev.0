Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D7429DDEDC
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 00:17:21 +1000 (EST)
Date: Tue, 11 Sep 2007 09:17:11 -0500
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] 85xx: Add basic Uniprocessor MPC8572 DS port
Message-ID: <20070911141711.GE1932@ld0162-tx32.am.freescale.net>
References: <Pine.LNX.4.64.0709110128040.27648@blarg.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.64.0709110128040.27648@blarg.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Sep 11, 2007 at 01:29:18AM -0500, Kumar Gala wrote:
> diff --git a/arch/powerpc/boot/dts/mpc8572ds.dts b/arch/powerpc/boot/dts/mpc8572ds.dts
> new file mode 100644
> index 0000000..9d23561
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/mpc8572ds.dts
> @@ -0,0 +1,378 @@
> +/*
> + * MPC8572 DS Device Tree Source
> + *
> + * Copyright 2007 Freescale Semiconductor Inc.
> + *
> + * This program is free software; you can redistribute  it and/or modify it
> + * under  the terms of  the GNU General  Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + */
> +
> +/ {
> +	model = "MPC8572DS";
> +	compatible = "MPC8572DS", "MPC85xxDS";

"fsl," prefix on compatible.

> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +
> +	cpus {
> +		#cpus = <1>;

Where is #cpus defined or used?  I don't see it used in any other trees, either.

> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		PowerPC,8572@0 {
> +			device_type = "cpu";
> +			reg = <0>;
> +			d-cache-line-size = <20>;	// 32 bytes
> +			i-cache-line-size = <20>;	// 32 bytes
> +			d-cache-size = <8000>;		// L1, 32K
> +			i-cache-size = <8000>;		// L1, 32K
> +			timebase-frequency = <0>;
> +			bus-frequency = <0>;
> +			clock-frequency = <0>;
> +			32-bit;

Where is 32-bit; defined or used?

> +	soc8572@ffe00000 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		#interrupt-cells = <2>;
> +		device_type = "soc";
> +		ranges = <00000000 ffe00000 00100000
> +			  80000000 80000000 20000000
> +			  a0000000 a0000000 20000000
> +			  c0000000 c0000000 20000000
> +			  ffc00000 ffc00000 00010000
> +			  ffc10000 ffc10000 00010000
> +			  ffc20000 ffc20000 00010000>;
> +
> +		reg = <ffe00000 00001000>;	// CCSRBAR 1M

Comment doesn't match what's actually in reg.

> +		bus-frequency = <0>;		// Filled out by uboot.
> +
> +		memory-controller@2000 {
> +			compatible = "fsl,8572-memory-controller";

Is it compatible with any other 85xx memory controller?

> +			reg = <2000 1000>;
> +			interrupt-parent = <&mpic>;
> +			interrupts = <12 2>;
> +		};
> +
> +		l2-cache-controller@20000 {
> +			compatible = "fsl,8572-l2-cache-controller";
> +			reg = <20000 1000>;
> +			cache-line-size = <20>;	// 32 bytes
> +			cache-size = <80000>;	// L2, 512K
> +			interrupt-parent = <&mpic>;
> +			interrupts = <10 2>;
> +		};

Should this node be referenced by an l2-cache property in the cpu node?

> +		pcie@8000 {
> +			compatible = "fsl,mpc8641-pcie";

Should probably be "fsl,mpc8572-pcie", "fsl,mpc8641-pcie".

> +			device_type = "pci";
> +			#interrupt-cells = <1>;
> +			#size-cells = <2>;
> +			#address-cells = <3>;
> +			reg = <8000 1000>;
> +			bus-range = <0 ff>;
> +			ranges = <02000000 0 80000000 80000000 0 20000000
> +				  01000000 0 00000000 ffc00000 0 00010000>;

No prefetchable mem space?

> +			clock-frequency = <1fca055>;

Decimal would be nicer.

> +		pcie@9000 {
> +			compatible = "fsl,mpc8548-pcie";

Why is this one 8548-compatible and the previous one 8641-compatible?

> +		mpic: pic@40000 {
> +			clock-frequency = <0>;
> +			interrupt-controller;
> +			#address-cells = <0>;
> +			#interrupt-cells = <2>;
> +			reg = <40000 40000>;
> +			built-in;
> +			compatible = "chrp,open-pic";
> +			device_type = "open-pic";
> +			big-endian;
> +		};

Where is the built-in; property defined or used?

> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 06d23e1..c98b867 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -374,10 +374,9 @@
>  #define PCI_DEVICE_ID_ATI_IXP400_SATA   0x4379
>  #define PCI_DEVICE_ID_ATI_IXP400_SATA2	0x437a
>  #define PCI_DEVICE_ID_ATI_IXP600_SATA	0x4380
> -#define PCI_DEVICE_ID_ATI_IXP600_SMBUS	0x4385
> +#define PCI_DEVICE_ID_ATI_SBX00_SMBUS	0x4385
>  #define PCI_DEVICE_ID_ATI_IXP600_IDE	0x438c
>  #define PCI_DEVICE_ID_ATI_IXP700_SATA	0x4390
> -#define PCI_DEVICE_ID_ATI_IXP700_SMBUS	0x4395
>  #define PCI_DEVICE_ID_ATI_IXP700_IDE	0x439c

What's going on here?

-Scott
