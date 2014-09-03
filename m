Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0239.outbound.protection.outlook.com [207.46.163.239])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9715C1A0024
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Sep 2014 09:01:22 +1000 (EST)
Date: Wed, 3 Sep 2014 18:01:06 -0500
From: Scott Wood <scottwood@freescale.com>
To: Priyanka Jain <Priyanka.Jain@freescale.com>
Subject: Re: [1/2, v3] powerpc/fsl-booke: Add initial T1040/T1042 RDB board
 support
Message-ID: <20140903230106.GA5830@home.buserror.net>
References: <1407741488-2661-1-git-send-email-Priyanka.Jain@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
In-Reply-To: <1407741488-2661-1-git-send-email-Priyanka.Jain@freescale.com>
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Prabhakar Kushwaha <prabhakar@freescale.com>, Poonam
 Aggrwal <poonam.aggrwal@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 11, 2014 at 12:48:08PM +0530, Priyanka Jain wrote:
> T1040/T1042RDB is Freescale Reference Design Board.
> The board can support both T1040/T1042 QorIQ Power Architecture™ processor.
> 
> T1040/T1042RDB board Overview
> -----------------------
> - SERDES Connections, 8 lanes supporting:
> 	- PCI
> 	- SGMII
>     	- QSGMII
>     	- SATA 2.0
> - DDR Controller
>     	- Supports rates of up to 1600 MHz data-rate
>     	- Supports one DDR3LP UDIMM
> -IFC/Local Bus
>     	- NAND flash: 1GB 8-bit NAND flash
>     	- NOR: 128MB 16-bit NOR Flash
> - Ethernet
>     	- Two on-board RGMII 10/100/1G ethernet ports.
>     	- PHY #0 remains powered up during deep-sleep
> - CPLD
> - Clocks
>     	- System and DDR clock (SYSCLK, “DDRCLK”)
>     	- SERDES clocks
> - Power Supplies
> - USB
>     	- Supports two USB 2.0 ports with integrated PHYs
>     	- Two type A ports with 5V@1.5A per port.
> - SDHC
>     	- SDHC/SDXC connector
> - SPI
>     	- On-board 64MB SPI flash
> - I2C
>     	- Devices connected: EEPROM, thermal monitor, VID controller
> - Other IO
>     	- Two Serial ports
>     	- ProfiBus port
> 
> Add support for T1040/T1042 RDB board:
>     -add device tree
>     -add entry in Kconfig to build
>     -Add entry in corenet_generic.c, as it is similar to other corenet platforms
> 
> Signed-off-by: Priyanka Jain <Priyanka.Jain@freescale.com>
> Signed-off-by: Poonam Aggrwal <poonam.aggrwal@freescale.com>
> Signed-off-by: Prabhakar Kushwaha <prabhakar@freescale.com>
> ---
> changes for v3: Incorporated Scott comments on moving cpld compatible
>  field to board specific file as cpld binaries are different
[snip]
> diff --git a/arch/powerpc/boot/dts/t1042rdb.dts b/arch/powerpc/boot/dts/t1042rdb.dts
> new file mode 100644
> index 0000000..228a635
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/t1042rdb.dts
[snip]
> +/include/ "fsl/t104xsi-pre.dtsi"
> +/include/ "t104xrdb.dtsi"
> +
> +/ {
> +	model = "fsl,T1042RDB";
> +	compatible = "fsl,T1042RDB";
> +	ifc: localbus@ffe124000 {
> +		cpld@3,0 {
> +			compatible = "fsl,t1040rdb-cpld";
> +		};
> +	};
> +};

The point of moving the cpld compatible is so that they can match the
exact CPLD binary being used.  The above does not match.

Likewise in patch 2/2

-Scott
