Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0138.outbound.protection.outlook.com [157.56.111.138])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C77ED1A001E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jul 2015 03:47:28 +1000 (AEST)
Message-ID: <1436982433.2993.81.camel@freescale.com>
Subject: Re: [PATCH][v2] powerpc/fsl-booke: Add T1040D4RDB/T1042D4RDB board
 support
From: Scott Wood <scottwood@freescale.com>
To: Priyanka Jain <Priyanka.Jain@freescale.com>
CC: <linuxppc-dev@lists.ozlabs.org>
Date: Wed, 15 Jul 2015 12:47:13 -0500
In-Reply-To: <1436952655-14910-1-git-send-email-Priyanka.Jain@freescale.com>
References: <1436952655-14910-1-git-send-email-Priyanka.Jain@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-07-15 at 15:00 +0530, Priyanka Jain wrote:
> T1040D4RDB/T1042D4RDB are Freescale Reference Design Board
> which can support T1040/T1042 QorIQ Power
> Architecture™ processor respectively
> 
> T1040D4RDB/T1042D4RDB board Overview
> -------------------------------------
> - SERDES Connections, 8 lanes supporting:
>         - PCI
>         - SGMII
>         - SATA 2.0
>         - QSGMII(only for T1040D4RDB)
>     - DDR Controller
>         - Supports rates of up to 1600 MHz data-rate
>         - Supports one DDR4 UDIMM
>     -IFC/Local Bus
>         - NAND flash: 1GB 8-bit NAND flash
>         - NOR: 128MB 16-bit NOR Flash
>     - Ethernet
>         - Two on-board RGMII 10/100/1G ethernet ports.
>         - PHY #0 remains powered up during deep-sleep
>     - CPLD
>     - Clocks
>         - System and DDR clock (SYSCLK, “DDRCLK”)
>         - SERDES clocks
>     - Power Supplies
>     - USB
>         - Supports two USB 2.0 ports with integrated PHYs
>         - Two type A ports with  5V@1.5Aper port.
>     - SDHC
>         - SDHC/SDXC connector
>     - SPI
>         - On-board 64MB SPI flash
>     - I2C
>         - Devices connected: EEPROM, thermal monitor, VID controller
>     - Other IO
>         - Two Serial ports
>         - ProfiBus port
> 
>     Add support for T1040/T1042D4RDB board:
>     -add device tree
>     -Add entry in corenet_generic.c
> 
> Signed-off-by: Priyanka Jain <Priyanka.Jain@freescale.com>
> ---
>  Changes for v2:
>       Incorporated Scott's comments on device tree

You didn't respond to the comments on the CPLD node.

+                i2c@118100{
> +                      mux@77{
> +                             compatible = "nxp,pca9546";
> +                             reg = <0x77>;
> +                             #address-cells = <1>;
> +                             #size-cells = <0>;
> +                     };
> +             };

A mux with no nodes under it (and yet it has #address-cells/#size-cells)?  
What is it multiplexing?

-Scott
