Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 73CF6679FD
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Aug 2006 05:13:38 +1000 (EST)
Message-ID: <44E611A7.60206@ru.mvista.com>
Date: Fri, 18 Aug 2006 23:14:47 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Andy Fleming <afleming@freescale.com>
Subject: Re: [PATCH] Add 85xx DTS files
References: <Pine.LNX.4.61.0608172024570.420@ld0175-tx32.am.freescale.net>
In-Reply-To: <Pine.LNX.4.61.0608172024570.420@ld0175-tx32.am.freescale.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

Andy Fleming wrote:

> Added the DTS files for the 8540 ADS, and the 8555/41/48 CDS

    MPC8540ADS file doesn't seem completely correct.

> diff --git a/arch/powerpc/boot/dts/mpc8540ads.dts b/arch/powerpc/boot/dts/mpc8540ads.dts
> new file mode 100644
> index 0000000..88b0ea7
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/mpc8540ads.dts
> @@ -0,0 +1,250 @@
[...]
> +	soc8540@e0000000 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		#interrupt-cells = <2>;
> +		device_type = "soc";
> +		ranges = <0 e0000000 00100000>;
> +		reg = <e0000000 00100000>;	// CCSRBAR 1M
> +		bus-frequency = <0>;
> +
> +		i2c@3000 {
> +			device_type = "i2c";
> +			compatible = "fsl-i2c";
> +			reg = <3000 100>;
> +			interrupts = <1b 2>;

    This means active high interrupt, doesn't it? So, 
Documentation/powerpc/booting=without-of.txt should be indeed wrong on the 
OpenPIC IRQ sense encoding... The kernel doesn't seem to put any attention to 
theis field currently though...

> +			interrupt-parent = <40000>;
> +			dfsrr;
> +		};
> +
> +		mdio@24520 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			device_type = "mdio";
> +			compatible = "gianfar";
> +			reg = <24520 20>;
> +			linux,phandle = <24520>;
> +			ethernet-phy@0 {
> +				linux,phandle = <2452000>;
> +				interrupt-parent = <40000>;
> +				interrupts = <35 3>;

    Falling edge?

> +				reg = <0>;
> +				device_type = "ethernet-phy";
> +			};
> +			ethernet-phy@1 {
> +				linux,phandle = <2452001>;
> +				interrupt-parent = <40000>;
> +				interrupts = <35 3>;
> +				reg = <1>;
> +				device_type = "ethernet-phy";
> +			};

    The board has 2 more PHYs using IRQ54 (0x37).

> +		ethernet@26000 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			device_type = "network";
> +			model = "FEC";
> +			compatible = "gianfar";
> +			reg = <26000 1000>;
> +			local-mac-address = [ 00 E0 0C 00 73 02 ];
> +			interrupts = <19 2>;
> +			interrupt-parent = <40000>;
> +			phy-handle = <2452001>;
> +		};

    This doesn't seem correct. FEC is served by PHY #3 (Davicom), not PHY #1 
(Marvell).

[...]
> +		pci@8000 {
> +			linux,phandle = <8000>;
> +			interrupt-map-mask = <f800 0 0 7>;
> +			interrupt-map = <
> +
> +				/* IDSEL 0x02 */
> +				1000 0 0 1 40000 31 1
> +				1000 0 0 2 40000 32 1
> +				1000 0 0 3 40000 33 1
> +				1000 0 0 4 40000 34 1
> +
> +				/* IDSEL 0x03 */
> +				1800 0 0 1 40000 34 1
> +				1800 0 0 2 40000 31 1
> +				1800 0 0 3 40000 32 1
> +				1800 0 0 4 40000 33 1
> +
> +				/* IDSEL 0x04 */
> +				2000 0 0 1 40000 33 1
> +				2000 0 0 2 40000 34 1
> +				2000 0 0 3 40000 31 1
> +				2000 0 0 4 40000 32 1
> +
> +				/* IDSEL 0x05 */
> +				2800 0 0 1 40000 32 1
> +				2800 0 0 2 40000 33 1
> +				2800 0 0 3 40000 34 1
> +				2800 0 0 4 40000 31 1
> +
> +				/* IDSEL 0x0c */
> +				6000 0 0 1 40000 31 1
> +				6000 0 0 2 40000 32 1
> +				6000 0 0 3 40000 33 1
> +				6000 0 0 4 40000 34 1
> +
> +				/* IDSEL 0x0d */
> +				6800 0 0 1 40000 34 1
> +				6800 0 0 2 40000 31 1
> +				6800 0 0 3 40000 32 1
> +				6800 0 0 4 40000 33 1
> +
> +				/* IDSEL 0x0e */
> +				7000 0 0 1 40000 33 1
> +				7000 0 0 2 40000 34 1
> +				7000 0 0 3 40000 31 1
> +				7000 0 0 4 40000 32 1
> +
> +				/* IDSEL 0x0f */
> +				7800 0 0 1 40000 32 1
> +				7800 0 0 2 40000 33 1
> +				7800 0 0 3 40000 34 1
> +				7800 0 0 4 40000 31 1
> +
> +				/* IDSEL 0x12 */
> +				9000 0 0 1 40000 31 1
> +				9000 0 0 2 40000 32 1
> +				9000 0 0 3 40000 33 1
> +				9000 0 0 4 40000 34 1
> +
> +				/* IDSEL 0x13 */
> +				9800 0 0 1 40000 34 1
> +				9800 0 0 2 40000 31 1
> +				9800 0 0 3 40000 32 1
> +				9800 0 0 4 40000 33 1
> +
> +				/* IDSEL 0x14 */
> +				a000 0 0 1 40000 33 1
> +				a000 0 0 2 40000 34 1
> +				a000 0 0 3 40000 31 1
> +				a000 0 0 4 40000 32 1
> +
> +				/* IDSEL 0x15 */
> +				a800 0 0 1 40000 32 1
> +				a800 0 0 2 40000 33 1
> +				a800 0 0 3 40000 34 1
> +				a800 0 0 4 40000 31 1>;
> +			interrupt-parent = <40000>;
> +			interrupts = <08 3>;

    Hm, why it's falling edge (if it is)? Isn't it an internal IRQ which are 
all active high?

> +			bus-range = <0 0>;
> +			ranges = <02000000 0 80000000 80000000 0 20000000
> +				  01000000 0 00000000 e2000000 0 00100000>;

   Well, U-Boot sets up 16 MB I/O window, not 1 MB. Or have this changed?

> +			clock-frequency = <3f940aa>;
> +			#interrupt-cells = <1>;
> +			#size-cells = <2>;
> +			#address-cells = <3>;
> +			reg = <8000 1000>;
> +			compatible = "85xx";
> +			device_type = "pci";
> +		};

    Well, these props should probaby come the first in the node, for clarity...

WBR, Sergei
