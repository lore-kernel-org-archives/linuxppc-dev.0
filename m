Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0132.outbound.protection.outlook.com [157.56.111.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E2E1C1A0D01
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jan 2015 12:20:05 +1100 (AEDT)
Date: Thu, 29 Jan 2015 19:19:49 -0600
From: Scott Wood <scottwood@freescale.com>
To: Shengzhou Liu <Shengzhou.Liu@freescale.com>
Subject: Re: [1/4] powerpc/fsl-booke: Add device tree support for T1024/T1023
 SoC
Message-ID: <20150130011949.GA19864@home.buserror.net>
References: <1422517947-28722-1-git-send-email-Shengzhou.Liu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1422517947-28722-1-git-send-email-Shengzhou.Liu@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jan 29, 2015 at 03:52:24PM +0800, Shengzhou Liu wrote:
> +	corenet-cf@18000 {
> +		compatible = "fsl,corenet2-cf";

While the damage has already been done by the t1040 device tree, this is
not 100% compatible with what's on t4240.  I'm not sure if it's worth
doing anything about it at this point, given that you can tell the
difference by the version register even though that register is reserved
on t4240 and simliar chips, which is what I do in
http://patchwork.ozlabs.org/patch/419911/

> +		reg = <0x18000 0x1000>;
> +		interrupts = <16 2 1 31>;
> +		fsl,ccf-num-csdids = <32>;
> +		fsl,ccf-num-snoopids = <32>;

The t1040/t1024 CCM does not have CSD/Snoop IDs.

> +	};
> +
> +	iommu@20000 {
> +		compatible = "fsl,pamu-v1.0", "fsl,pamu";
> +		reg = <0x20000 0x1000>;
> +		ranges = <0 0x20000 0x1000>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		interrupts = <
> +			24 2 0 0
> +			16 2 1 30>;
> +		pamu0: pamu@0 {
> +			reg = <0 0x1000>;
> +			fsl,primary-cache-geometry = <128 1>;
> +			fsl,secondary-cache-geometry = <16 2>;
> +		};

The secondary cache has 32 entries, not 16.

Please verify all information when submitting a device tree.  Don't just
copy and paste.

> +	};
> +
> +/include/ "qoriq-mpic.dtsi"
> +
> +	guts: global-utilities@e0000 {
> +		compatible = "fsl,t1024-device-config", "fsl,qoriq-device-config-2.0";

Has anyone checked whether these "-2.0" properties make sense on
t1040/t1024?

> +/include/ "elo3-dma-0.dtsi"
> +/include/ "elo3-dma-1.dtsi"
> +
> +/include/ "qoriq-espi-0.dtsi"
> +	spi@110000 {
> +		fsl,espi-num-chipselects = <4>;
> +	};
> +
> +/include/ "qoriq-esdhc-0.dtsi"
> +	sdhc@114000 {
> +		compatible = "fsl,t1024-esdhc", "fsl,esdhc";
> +		fsl,iommu-parent = <&pamu0>;
> +		fsl,liodn-reg = <&guts 0x530>; /* eSDHCLIODNR */
> +		sdhci,auto-cmd12;
> +		no-1-8-v;
> +		sleep = <&rcpm 0x00000080>;
> +	};
> +/include/ "qoriq-i2c-0.dtsi"
> +/include/ "qoriq-i2c-1.dtsi"
> +/include/ "qoriq-duart-0.dtsi"
> +/include/ "qoriq-duart-1.dtsi"
> +/include/ "qoriq-gpio-0.dtsi"
> +	gpio@130000 {
> +		sleep = <&rcpm 0x00000040>;
> +	};
> +/include/ "qoriq-gpio-1.dtsi"
> +/include/ "qoriq-gpio-2.dtsi"
> +/include/ "qoriq-gpio-3.dtsi"
> +/include/ "qoriq-usb2-mph-0.dtsi"
> +		usb0: usb@210000 {
> +			compatible = "fsl-usb2-mph-v2.5", "fsl-usb2-mph";
> +			fsl,iommu-parent = <&pamu0>;
> +			fsl,liodn-reg = <&guts 0x520>; /* USB1LIODNR */
> +			phy_type = "utmi";
> +			sleep = <&rcpm 0x00000020>;
> +			port0;
> +		};
> +/include/ "qoriq-usb2-dr-0.dtsi"
> +		usb1: usb@211000 {
> +			compatible = "fsl-usb2-dr-v2.5", "fsl-usb2-dr";
> +			fsl,iommu-parent = <&pamu0>;
> +			fsl,liodn-reg = <&guts 0x524>; /* USB2LIODNR */
> +			dr_mode = "host";
> +			phy_type = "utmi";
> +			sleep = <&rcpm 0x00000010>;
> +		};
> +/include/ "qoriq-sata2-0.dtsi"
> +sata@220000 {
> +			fsl,iommu-parent = <&pamu0>;
> +			fsl,liodn-reg = <&guts 0x550>; /* SATA1LIODNR */
> +};
> +
> +/include/ "qoriq-sec5.0-0.dtsi"
> +};

Please fix indentation.

> +/ {
> +	compatible = "fsl,T104x";

Drop this.

-Scott
