Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0153.outbound.protection.outlook.com [207.46.163.153])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7823A2C00A5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Dec 2013 11:50:17 +1100 (EST)
Date: Wed, 18 Dec 2013 18:50:02 -0600
From: Scott Wood <scottwood@freescale.com>
To: Prabhakar Kushwaha <prabhakar@freescale.com>
Subject: Re: [2/2,v8] powerpc/fsl-booke: Add initial T104x_QDS board support
Message-ID: <20131219005002.GA7370@home.buserror.net>
References: <1380771889-2626-1-git-send-email-prabhakar@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1380771889-2626-1-git-send-email-prabhakar@freescale.com>
Cc: Poonam Aggrwal <poonam.aggrwal@freescale.com>,
 linuxppc-dev@lists.ozlabs.org, Priyanka Jain <Priyanka.Jain@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 03, 2013 at 09:14:49AM +0530, Prabhakar Kushwaha wrote:
> diff --git a/arch/powerpc/boot/dts/t104xqds.dtsi b/arch/powerpc/boot/dts/t104xqds.dtsi
> new file mode 100644
> index 0000000..5a518b3
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/t104xqds.dtsi
[snip]
> +/ {
> +	model = "fsl,T1040QDS";
> +	compatible = "fsl,T1040QDS";

Remove model/compatible; they're supplied by the includer of this file.

> +		nand@2,0 {
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			compatible = "fsl,ifc-nand";
> +			reg = <0x2 0x0 0x10000>;
> +
> +			partition@0 {
> +				/* This location must not be altered  */
> +				/* 1MB for u-boot Bootloader Image */
> +				reg = <0x0 0x00100000>;
> +				label = "NAND U-Boot Image";
> +				read-only;
> +			};
> +
> +			partition@100000 {
> +				/* 1MB for DTB Image */
> +				reg = <0x00100000 0x00100000>;
> +				label = "NAND DTB Image";
> +			};
> +
> +			partition@200000 {
> +				/* 10MB for Linux Kernel Image */
> +				reg = <0x00200000 0x00A00000>;
> +				label = "NAND Linux Kernel Image";
> +			};
> +
> +			partition@C00000 {
> +				/* 500MB for Root file System Image */
> +				reg = <0x00c00000 0x1F400000>;
> +				label = "NAND RFS Image";
> +			};
> +		};

I'd really like to see us stop putting partition info in the dts files. 
Alternatives are using the mtdparts command line option, or having U-Boot
use the mtdparts environment variable to add partition info to the dtb
(there's already code for this).

> +		board-control@3,0 {
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			compatible = "fsl,tetra-fpga", "fsl,fpga-qixis";
> +			reg = <3 0 0x300>;
> +		};

Could you explain the relationship between "tetra" and "qixis"?

-Scott
