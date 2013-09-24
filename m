Return-Path: <B07421@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe010.messaging.microsoft.com [216.32.180.30])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1D5652C009A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Sep 2013 09:22:35 +1000 (EST)
Received: from mail191-va3 (localhost [127.0.0.1])	by
 mail191-va3-R.bigfish.com (Postfix) with ESMTP id 0E151200209	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Sep 2013 23:22:31 +0000 (UTC)
Received: from VA3EHSMHS040.bigfish.com (unknown [10.7.14.239])	by
 mail191-va3.bigfish.com (Postfix) with ESMTP id 48F6E120051	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Sep 2013 23:22:29 +0000 (UTC)
Message-ID: <1380064944.24959.143.camel@snotra.buserror.net>
Subject: Re: [PATCH V4 3/3] powerpc/85xx: Add TWR-P1025 board support
From: Scott Wood <scottwood@freescale.com>
To: Xie Xiaobo <X.Xie@freescale.com>
Date: Tue, 24 Sep 2013 18:22:24 -0500
In-Reply-To: <1380019739-8196-3-git-send-email-X.Xie@freescale.com>
References: <1380019739-8196-1-git-send-email-X.Xie@freescale.com>
 <1380019739-8196-3-git-send-email-X.Xie@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org,
 Michael Johnston <michael.johnston@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-09-24 at 18:48 +0800, Xie Xiaobo wrote:
> +		partition@80000 {
> +			/* 3.5 MB for Linux Kernel Image */
> +			reg = <0x00080000 0x00380000>;
> +			label = "NOR Linux Kernel Image";
> +		};

Is this enough?

> +		partition@400000 {
> +			/* 58.75MB for JFFS2 based Root file System */
> +			reg = <0x00400000 0x03ac0000>;
> +			label = "NOR Root File System";
> +		};

Don't specify jffs2.

> +	/* CS2 for Display */
> +	ssd1289@2,0 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "ssd1289";
> +		reg = <0x2 0x0000 0x0002
> +		       0x2 0x0002 0x0002>;
> +	};

Node names should be generic.  What does ssd1289 do?  If this is
actually the display device, then it should be called "display@2,0".

How about a vendor prefix on that compatible?  Why
#address-cells/#size-cells despite no child nodes?  Where is a binding
that says what each of those two reg resources mean?

> diff --git a/arch/powerpc/boot/dts/p1025twr_32b.dts b/arch/powerpc/boot/dts/p1025twr_32b.dts
> new file mode 100644
> index 0000000..ccb173f
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/p1025twr_32b.dts
> @@ -0,0 +1,135 @@
> +/*
> + * P1025 TWR Device Tree Source (32-bit address map)
> + *
> + * Copyright 2013 Freescale Semiconductor Inc.
> + *
> + * Redistribution and use in source and binary forms, with or without
> + * modification, are permitted provided that the following conditions are met:
> + *     * Redistributions of source code must retain the above copyright
> + *       notice, this list of conditions and the following disclaimer.
> + *     * Redistributions in binary form must reproduce the above copyright
> + *       notice, this list of conditions and the following disclaimer in the
> + *       documentation and/or other materials provided with the distribution.
> + *     * Neither the name of Freescale Semiconductor nor the
> + *       names of its contributors may be used to endorse or promote products
> + *       derived from this software without specific prior written permission.
> + *
> + *
> + * ALTERNATIVELY, this software may be distributed under the terms of the
> + * GNU General Public License ("GPL") as published by the Free Software
> + * Foundation, either version 2 of that License or (at your option) any
> + * later version.
> + *
> + * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
> + * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
> + * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
> + * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
> + * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
> + * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
> + * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
> + * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
> + * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
> + * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> + */
> +
> +/include/ "fsl/p1021si-pre.dtsi"
> +/ {
> +	model = "fsl,P1025";
> +	compatible = "fsl,TWR-P1025";
> +
> +	memory {
> +		device_type = "memory";
> +	};
> +
> +	lbc: localbus@ffe05000 {
> +		reg = <0 0xffe05000 0 0x1000>;
> +
> +		/* NOR Flash and SSD1289 */
> +		ranges = <0x0 0x0 0x0 0xec000000 0x04000000
> +			  0x2 0x0 0x0 0xe0000000 0x00020000>;
> +	};
> +
> +	soc: soc@ffe00000 {
> +		ranges = <0x0 0x0 0xffe00000 0x100000>;
> +	};
> +
> +	pci0: pcie@ffe09000 {
> +		ranges = <0x2000000 0x0 0xa0000000 0 0xa0000000 0x0 0x20000000
> +			  0x1000000 0x0 0x00000000 0 0xffc10000 0x0 0x10000>;
> +		reg = <0 0xffe09000 0 0x1000>;
> +		pcie@0 {
> +			ranges = <0x2000000 0x0 0xa0000000
> +				  0x2000000 0x0 0xa0000000
> +				  0x0 0x20000000
> +
> +				  0x1000000 0x0 0x0
> +				  0x1000000 0x0 0x0
> +				  0x0 0x100000>;
> +		};
> +	};
> +
> +	pci1: pcie@ffe0a000 {
> +		reg = <0 0xffe0a000 0 0x1000>;
> +		ranges = <0x2000000 0x0 0x80000000 0 0x80000000 0x0 0x20000000
> +			  0x1000000 0x0 0x00000000 0 0xffc00000 0x0 0x10000>;
> +		pcie@0 {
> +			ranges = <0x2000000 0x0 0x80000000
> +				  0x2000000 0x0 0x80000000
> +				  0x0 0x20000000
> +
> +				  0x1000000 0x0 0x0
> +				  0x1000000 0x0 0x0
> +				  0x0 0x100000>;
> +		};
> +	};
> +
> +	qe: qe@ffe80000 {
> +		ranges = <0x0 0x0 0xffe80000 0x40000>;
> +		reg = <0 0xffe80000 0 0x480>;
> +		brg-frequency = <0>;
> +		bus-frequency = <0>;
> +		status = "disabled"; /* no firmware loaded */
> +
> +		enet3: ucc@2000 {
> +			device_type = "network";
> +			compatible = "ucc_geth";
> +			rx-clock-name = "clk12";
> +			tx-clock-name = "clk9";
> +			pio-handle = <&pio1>;
> +			phy-handle = <&qe_phy0>;
> +			phy-connection-type = "mii";
> +		};
> +
> +		mdio@2120 {
> +			qe_phy0: ethernet-phy@18 {
> +				interrupt-parent = <&mpic>;
> +				interrupts = <4 1 0 0>;
> +				reg = <0x18>;
> +				device_type = "ethernet-phy";
> +			};
> +			qe_phy1: ethernet-phy@19 {
> +				interrupt-parent = <&mpic>;
> +				interrupts = <5 1 0 0>;
> +				reg = <0x19>;
> +				device_type = "ethernet-phy";
> +			};
> +			tbi-phy@11 {
> +				reg = <0x11>;
> +				device_type = "tbi-phy";
> +			};
> +		};
> +
> +		enet4: ucc@2400 {
> +			device_type = "network";
> +			compatible = "ucc_geth";
> +			rx-clock-name = "none";
> +			tx-clock-name = "clk13";
> +			pio-handle = <&pio2>;
> +			phy-handle = <&qe_phy1>;
> +			phy-connection-type = "rmii";
> +		};
> +	};
> +};

Don't duplicate all this just for 32/36 bit.  Use a dtsi for (e.g.) the
contents of the QE node.

Is there a strong need to support both 32 and 36 bit in the first place?

> +/* ************************************************************************
> + *
> + * Setup the architecture
> + *
> + */
> +static void __init twr_p1025_setup_arch(void)
> +{
> +#ifdef CONFIG_QUICC_ENGINE
> +	struct device_node *np;
> +#endif
> +
> +	if (ppc_md.progress)
> +		ppc_md.progress("twr_p1025_setup_arch()", 0);
> +
> +	mpc85xx_smp_init();
> +
> +	fsl_pci_assign_primary();
> +
> +#ifdef CONFIG_QUICC_ENGINE
> +	mpc85xx_qe_init();
> +
> +#if defined(CONFIG_UCC_GETH) || defined(CONFIG_SERIAL_QE)
> +	if (machine_is(twr_p1025)) {
> +		struct ccsr_guts __iomem *guts;
> +
> +		np = of_find_node_by_name(NULL, "global-utilities");

Look for it by compatible.

> +		if (np) {
> +			guts = of_iomap(np, 0);
> +			if (!guts)
> +				pr_err("twr_p1025: could not map"
> +					"global utilities register\n");

Don't linewrap printed string constants (this is an exception to the
80-column rule).

> +			else {
> +			/* P1025 has pins muxed for QE and other functions. To
> +			 * enable QE UEC mode, we need to set bit QE0 for UCC1
> +			 * in Eth mode, QE0 and QE3 for UCC5 in Eth mode, QE9
> +			 * and QE12 for QE MII management signals in PMUXCR
> +			 * register.
> +			 */
> +
> +			printk(KERN_INFO "P1025 pinmux configured for QE\n");

Bad indentation, and use pr_info() (or better, just remove it; it's
implied by the absence of the error on the other branch of the if).

> +
> +			/* Set QE mux bits in PMUXCR */
> +			setbits32(&guts->pmuxcr, MPC85xx_PMUXCR_QE(0) |
> +					MPC85xx_PMUXCR_QE(3) |
> +					MPC85xx_PMUXCR_QE(9) |
> +					MPC85xx_PMUXCR_QE(12));
> +			iounmap(guts);
> +
> +#if defined(CONFIG_SERIAL_QE)
> +			/* On P1025TWR board, the UCC7 acted as UART port.
> +			 * However, The UCC7's CTS pin is low level in default,
> +			 * it will impact the transmission in full duplex
> +			 * communication. So disable the Flow control pin PA18.
> +			 * The UCC7 UART just can use RXD and TXD pins.
> +			 */
> +			par_io_config_pin(0, 18, 0, 0, 0, 0);
> +#endif

Any reason not to do this unconditionally?

-Scott
