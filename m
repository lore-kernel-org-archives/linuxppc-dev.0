Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0133.outbound.protection.outlook.com [207.46.100.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F3DF81A0332
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Mar 2015 09:10:53 +1100 (AEDT)
Message-ID: <1427407839.22867.130.camel@freescale.com>
Subject: Re: [PATCH 1/3] powerpc/dts: Add TDM device tree nodes for P1021RDB
From: Scott Wood <scottwood@freescale.com>
To: <ying.zhang@freescale.com>
Date: Thu, 26 Mar 2015 17:10:39 -0500
In-Reply-To: <1427361254-4639-1-git-send-email-ying.zhang@freescale.com>
References: <1427361254-4639-1-git-send-email-ying.zhang@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Xie
 Xiaobo <X.Xie@freescale.com>, Ying Zhang <b40530@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-03-26 at 17:14 +0800, ying.zhang@freescale.com wrote:
> From: Ying Zhang <b40530@freescale.com>
> 
> The dts file support QE-TDM function and PQ-MDS-T1 card for P1021RDB.
> PQ-MDS-T1 is connected to the board by PMC, there is a zarlink le88266
> on the card, we configure it by QE-SPI. Because PMC has a shared CS pin
> with L2switch, so we do the device tree fixup in uboot.
> 
> Change-Id: I7ecee0d93a105ef158455238fb003a2ad2ca32e7
> Signed-off-by: Ying Zhang <b40530@freescale.com>
> Signed-off-by: Xie Xiaobo <X.Xie@freescale.com>
> Reviewed-on: http://git.am.freescale.net:8181/900
> Reviewed-by: Fleming Andrew-AFLEMING <AFLEMING@freescale.com>
> Tested-by: Fleming Andrew-AFLEMING <AFLEMING@freescale.com>
> ---
>  arch/powerpc/boot/dts/p1021rdb-pc_32b.dts | 191 +++++++++++++++++++++++++++++-
>  1 file changed, 187 insertions(+), 4 deletions(-)

Where is the device tree binding?


> +		pq_mds_t1: tdmphy@2,0 {
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			reg = <2 0 0x10000>;
> +			ranges = <0 2 0 0x10000>;
> +			compatible = "fsl,pq-mds-t1";

MDS?

> +		spi@4c0 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			compatible = "fsl,mpc8569-qe-spi", "fsl,spi";

mpc8569?

> +			reg = <0x4c0 0x40>;
> +			cell-index = <0>;
> +			interrupts = <2>;
> +			interrupt-parent = <&qeic>;
> +			pio-handle = <&pio_qe_spi>;
> +			gpios = <&qe_pio_b 29 0>;
> +			mode = "cpu-qe";
> +
> +			legerity@0 {
> +				compatible = "zarlink,le88266";
> +				reg = <0>;
> +				spi-max-frequency = <8000000>;
> +			};

What does "legerity" mean in this context?  Node names are supposed to
be generic, not product names, and certainly not (former) company names.

-Scott
