Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0243.outbound.protection.outlook.com [207.46.163.243])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 23D95140133
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 May 2014 10:23:21 +1000 (EST)
Date: Fri, 2 May 2014 19:23:09 -0500
From: Scott Wood <scottwood@freescale.com>
To: harninder rai <harninder.rai@freescale.com>
Subject: Re: powerpc/mpc85xx: Add BSC9132 QDS Support
Message-ID: <20140503002309.GA20757@home.buserror.net>
References: <1395128102-12983-1-git-send-email-harninder.rai@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1395128102-12983-1-git-send-email-harninder.rai@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org, Ruchika Gupta <ruchika.gupta@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 18, 2014 at 01:05:02PM +0530, harninder rai wrote:
> +&ifc {
> +	nor@0,0 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "cfi-flash";
> +		reg = <0x0 0x0 0x8000000>;
> +		bank-width = <2>;
> +		device-width = <1>;
> +
> +		partition@40000 {
> +			/* 256KB for DTB Image */
> +			reg = <0x00040000 0x00040000>;
> +			label = "NOR DTB Image";
> +		};
> +
> +		partition@80000 {
> +			/* 7MB for Linux Kernel Image */
> +			reg = <0x00080000 0x00700000>;
> +			label = "NAND Linux Kernel Image";
> +		};
> +
> +		partition@800000 {
> +			/* 55MB for Root file system */
> +			reg = <0x00800000 0x03700000>;
> +			label = "NOR RFS Image";
> +		};
> +
> +		partition@3f00000 {
> +			/* This location must not be altered  */
> +			/* 512KB for u-boot Bootloader Image */
> +			/* 512KB for u-boot Environment Variables */
> +			reg = <0x03f00000 0x00100000>;
> +			label = "NOR U-boot Image";
> +			read-only;
> +		};
> +	};
> +
> +	nand@1,0 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "fsl,ifc-nand";
> +		reg = <0x1 0x0 0x4000>;
> +
> +		partition@0 {
> +			/* This location must not be altered  */
> +			/* 3MB for u-boot Bootloader Image */
> +			reg = <0x0 0x00300000>;
> +			label = "NAND U-Boot Image";
> +			read-only;
> +		};
> +
> +		partition@300000 {
> +			/* 1MB for DTB Image */
> +			reg = <0x00300000 0x00100000>;
> +			label = "NAND DTB Image";
> +		};
> +
> +		partition@400000 {
> +			/* 8MB for Linux Kernel Image */
> +			reg = <0x00400000 0x00800000>;
> +			label = "NAND Linux Kernel Image";
> +		};
> +
> +		partition@c00000 {
> +			/* Rest space for Root file System Image */
> +			reg = <0x00c00000 0x07400000>;
> +			label = "NAND RFS Image";
> +		};
> +	};
> +};

Please keep partition definitions out of the dts file, as has been
recently requested of other boards.  You can use U-Boot to create the
partition nodes based on the mtdparts variable, or you can use the Linux
mtdparts command line option.

-Scott
