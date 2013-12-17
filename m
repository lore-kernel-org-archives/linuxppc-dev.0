Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0155.outbound.protection.outlook.com [207.46.163.155])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 612E62C00A8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Dec 2013 06:57:22 +1100 (EST)
Message-ID: <1387310222.10013.439.camel@snotra.buserror.net>
Subject: Re: [PATCH 4/5] powerpc/fsl-booke: Add initial T208x QDS board support
From: Scott Wood <scottwood@freescale.com>
To: Shengzhou Liu <Shengzhou.Liu@freescale.com>
Date: Tue, 17 Dec 2013 13:57:02 -0600
In-Reply-To: <1386760774-14743-4-git-send-email-Shengzhou.Liu@freescale.com>
References: <1386760774-14743-1-git-send-email-Shengzhou.Liu@freescale.com>
 <1386760774-14743-4-git-send-email-Shengzhou.Liu@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-12-11 at 19:19 +0800, Shengzhou Liu wrote:
> +		boardctrl: board-control@3,0 {
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			compatible = "fsl,fpga-qixis";
> +			reg = <3 0 0x300>;
> +			ranges = <0 3 0 0x300>;
> +		};

Why do you have ranges and #address-cells/#size-cells here?  When would
there ever be a child node?

> +	};
> +
> +	memory {
> +		device_type = "memory";
> +	};
> +
> +	dcsr: dcsr@f00000000 {
> +		ranges = <0x00000000 0xf 0x00000000 0x01072000>;
> +	};
> +
> +	soc: soc@ffe000000 {
> +		ranges = <0x00000000 0xf 0xfe000000 0x1000000>;
> +		reg = <0xf 0xfe000000 0 0x00001000>;
> +		spi@110000 {
> +			flash@0 {
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +				compatible = "spansion,s25sl12801";
> +				reg = <0>;
> +				spi-max-frequency = <40000000>; /* input clock */
> +				partition@u-boot {
> +					label = "SPI U-Boot";
> +					reg = <0x00000000 0x00100000>;
> +					read-only;
> +				};
> +				partition@kernel {
> +					label = "SPI Kernel";
> +					reg = <0x00100000 0x00500000>;
> +					read-only;
> +				};
> +				partition@dtb {
> +					label = "SPI DTB";
> +					reg = <0x00600000 0x00100000>;
> +					read-only;
> +				};
> +				partition@fs {
> +					label = "SPI File System";
> +					reg = <0x00700000 0x00900000>;
> +				};

These are not valid unit addresses -- and the kernel/dtb should not be
read-only.  Please consider fixing where you copied this from, as well.

Do you really want to dedicate a whole mebibyte to the dtb, given that
the flash is only 16 MiB total?

Actually, let's please just stop putting partitions in the dts.  Either
use mtdparts on the command line, or have U-Boot fill in the partition
info (there is code in U-Boot to do this based on the mtdparts env
variable).

> diff --git a/arch/powerpc/include/asm/mpc85xx.h b/arch/powerpc/include/asm/mpc85xx.h
> index 736d4ac..3bef74a 100644
> --- a/arch/powerpc/include/asm/mpc85xx.h
> +++ b/arch/powerpc/include/asm/mpc85xx.h
> @@ -77,6 +77,8 @@
>  #define SVR_T1020	0x852100
>  #define SVR_T1021	0x852101
>  #define SVR_T1022	0x852102
> +#define SVR_T2080	0x853000
> +#define SVR_T2081	0x853100
>  
>  #define SVR_8610	0x80A000
>  #define SVR_8641	0x809000

Why is this in the board device tree patch?

-Scott
