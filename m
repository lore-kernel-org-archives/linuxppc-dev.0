Return-Path: <prvs=0968fdd40c=valentin.longchamp@keymile.com>
Received: from mail-de.keymile.com (mail-de.keymile.com [195.8.104.250])
 (using TLSv1.1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 09E8C2C0182
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Sep 2013 19:22:03 +1000 (EST)
Message-ID: <5232D778.20007@keymile.com>
Date: Fri, 13 Sep 2013 11:14:32 +0200
From: Valentin Longchamp <valentin.longchamp@keymile.com>
MIME-Version: 1.0
To: Prabhakar Kushwaha <prabhakar@freescale.com>,
 linuxppc-dev@lists.ozlabs.org, scottwood@freescale.com
Subject: Re: [PATCH] powerpc/mpc85xx:Add initial device tree support of T104x
References: <1378882686-19454-1-git-send-email-prabhakar@freescale.com>
In-Reply-To: <1378882686-19454-1-git-send-email-prabhakar@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Priyanka Jain <Priyanka.Jain@freescale.com>,
 Poonam Aggrwal <poonam.aggrwal@freescale.com>,
 Varun Sethi <Varun.Sethi@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/11/2013 08:58 AM, Prabhakar Kushwaha wrote:
> The QorIQ T1040/T1042 processor support four integrated 64-bit e5500 PA
> processor cores with high-performance data path acceleration architecture
> and network peripheral interfaces required for networking & telecommunications.
> 
> T1042 personality is a reduced personality of T1040 without Integrated 8-port
> Gigabit Ethernet switch.
> 
> The T1040/T1042 SoC includes the following function and features:
> 
>  - Four e5500 cores, each with a private 256 KB L2 cache
>  - 256 KB shared L3 CoreNet platform cache (CPC)
>  - Interconnect CoreNet platform
>  - 32-/64-bit DDR3L/DDR4 SDRAM memory controller with ECC and interleaving
>    support
>  - Data Path Acceleration Architecture (DPAA) incorporating acceleration
>  for the following functions:
>     -  Packet parsing, classification, and distribution
>     -  Queue management for scheduling, packet sequencing, and congestion
>     	management
>     -  Cryptography Acceleration (SEC 5.0)
>     - RegEx Pattern Matching Acceleration (PME 2.2)
>     - IEEE Std 1588 support
>     - Hardware buffer management for buffer allocation and deallocation
>  - Ethernet interfaces
>     - Integrated 8-port Gigabit Ethernet switch (T1040 only)
>     - Four 1 Gbps Ethernet controllers
>  - Two RGMII interfaces or one RGMII and one MII interfaces
>  - High speed peripheral interfaces
>    - Four PCI Express 2.0 controllers running at up to 5 GHz
>    - Two SATA controllers supporting 1.5 and 3.0 Gb/s operation
>    - Upto two QSGMII interface
>    - Upto six SGMII interface supporting 1000 Mbps
>    - One SGMII interface supporting upto 2500 Mbps
>  - Additional peripheral interfaces
>    - Two USB 2.0 controllers with integrated PHY
>    - SD/eSDHC/eMMC
>    -  eSPI controller
>    - Four I2C controllers
>    - Four UARTs
>    - Four GPIO controllers
>    - Integrated flash controller (IFC)
>    - Change this to  LCD/ HDMI interface (DIU) with 12 bit dual data rate
>    - TDM interface
>  - Multicore programmable interrupt controller (PIC)
>  - Two 8-channel DMA engines
>  - Single source clocking implementation
>  - Deep Sleep power implementaion (wakeup from GPIO/Timer/Ethernet/USB)
> 
> Signed-off-by: Poonam Aggrwal <poonam.aggrwal@freescale.com>
> Signed-off-by: Priyanka Jain <Priyanka.Jain@freescale.com>
> Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
> Signed-off-by: Prabhakar Kushwaha <prabhakar@freescale.com>
> ---
> Based upon git://git.kernel.org/pub/scm/linux/kernel/git/scottwood/linux.git
> 
> TODO: Add noded for ethernet
> 
>  arch/powerpc/boot/dts/fsl/t1040si-post.dtsi |  116 ++++++++
>  arch/powerpc/boot/dts/fsl/t1042si-post.dtsi |  430 +++++++++++++++++++++++++++
>  arch/powerpc/boot/dts/fsl/t104xsi-pre.dtsi  |  111 +++++++
>  3 files changed, 657 insertions(+)
>  create mode 100644 arch/powerpc/boot/dts/fsl/t1040si-post.dtsi
>  create mode 100644 arch/powerpc/boot/dts/fsl/t1042si-post.dtsi
>  create mode 100644 arch/powerpc/boot/dts/fsl/t104xsi-pre.dtsi
> 

I am currently working on a design bases on the p2041 but my issue seems to be
generic to all the QorIQ dtsi files since the structure is exactly the same, so
I pick the opportunity that such a file is submitted to the mailing-list to
raise it.

DISCLAIMER: I am no DTS expert, so there may be a way to achieve what I want to
I have not seen.

My understanding is that the SOC-NAMEsi-post.dtsi and SOC-NAMEsi-pre.dtsi are
files that describe the SoC internals. They will be maintained when new drivers
are merged or changed and therefore they should be used by all boards using the
SoCs. Can someone confirm this or am I already wrong (since there are on
Freescale boards that use them in mainline) ?

[snip]

> +
> +&pci0 {
> +	compatible = "fsl,t1042-pcie", "fsl,qoriq-pcie-v2.4", "fsl,qoriq-pcie";
> +	device_type = "pci";
> +	#size-cells = <2>;
> +	#address-cells = <3>;
> +	bus-range = <0x0 0xff>;
> +	interrupts = <20 2 0 0>;
> +	fsl,iommu-parent = <&pamu0>;
> +	pcie@0 {
> +		reg = <0 0 0 0 0>;
> +		#interrupt-cells = <1>;
> +		#size-cells = <2>;
> +		#address-cells = <3>;
> +		device_type = "pci";
> +		interrupts = <20 2 0 0>;
> +		interrupt-map-mask = <0xf800 0 0 7>;
> +		interrupt-map = <
> +			/* IDSEL 0x0 */
> +			0000 0 0 1 &mpic 40 1 0 0
> +			0000 0 0 2 &mpic 1 1 0 0
> +			0000 0 0 3 &mpic 2 1 0 0
> +			0000 0 0 4 &mpic 3 1 0 0
> +			>;
> +	};
> +};
> +
> +&pci1 {
> +	compatible = "fsl,t1042-pcie", "fsl,qoriq-pcie-v2.4", "fsl,qoriq-pcie";
> +	device_type = "pci";
> +	#size-cells = <2>;
> +	#address-cells = <3>;
> +	bus-range = <0 0xff>;
> +	interrupts = <21 2 0 0>;
> +	fsl,iommu-parent = <&pamu0>;
> +	pcie@0 {
> +		reg = <0 0 0 0 0>;
> +		#interrupt-cells = <1>;
> +		#size-cells = <2>;
> +		#address-cells = <3>;
> +		device_type = "pci";
> +		interrupts = <21 2 0 0>;
> +		interrupt-map-mask = <0xf800 0 0 7>;
> +		interrupt-map = <
> +			/* IDSEL 0x0 */
> +			0000 0 0 1 &mpic 41 1 0 0
> +			0000 0 0 2 &mpic 5 1 0 0
> +			0000 0 0 3 &mpic 6 1 0 0
> +			0000 0 0 4 &mpic 7 1 0 0
> +			>;
> +	};
> +};
> +
> +&pci2 {
> +	compatible = "fsl,t1042-pcie", "fsl,qoriq-pcie-v2.4", "fsl,qoriq-pcie";
> +	device_type = "pci";
> +	#size-cells = <2>;
> +	#address-cells = <3>;
> +	bus-range = <0x0 0xff>;
> +	interrupts = <22 2 0 0>;
> +	fsl,iommu-parent = <&pamu0>;
> +	pcie@0 {
> +		reg = <0 0 0 0 0>;
> +		#interrupt-cells = <1>;
> +		#size-cells = <2>;
> +		#address-cells = <3>;
> +		device_type = "pci";
> +		interrupts = <22 2 0 0>;
> +		interrupt-map-mask = <0xf800 0 0 7>;
> +		interrupt-map = <
> +			/* IDSEL 0x0 */
> +			0000 0 0 1 &mpic 42 1 0 0
> +			0000 0 0 2 &mpic 9 1 0 0
> +			0000 0 0 3 &mpic 10 1 0 0
> +			0000 0 0 4 &mpic 11 1 0 0
> +			>;
> +	};
> +};
> +
> +&pci3 {
> +	compatible = "fsl,t1042-pcie", "fsl,qoriq-pcie-v2.4", "fsl,qoriq-pcie";
> +	device_type = "pci";
> +	#size-cells = <2>;
> +	#address-cells = <3>;
> +	bus-range = <0x0 0xff>;
> +	interrupts = <23 2 0 0>;
> +	fsl,iommu-parent = <&pamu0>;
> +	pcie@0 {
> +		reg = <0 0 0 0 0>;
> +		#interrupt-cells = <1>;
> +		#size-cells = <2>;
> +		#address-cells = <3>;
> +		device_type = "pci";
> +		interrupts = <23 2 0 0>;
> +		interrupt-map-mask = <0xf800 0 0 7>;
> +		interrupt-map = <
> +			/* IDSEL 0x0 */
> +			0000 0 0 1 &mpic 43 1 0 0
> +			0000 0 0 2 &mpic 0 1 0 0
> +			0000 0 0 3 &mpic 4 1 0 0
> +			0000 0 0 4 &mpic 8 1 0 0
> +			>;
> +	};
> +};
> +

The above 4 nodes have the consequence that it will then be mandatory that a
board support .dts file that would like to inlcude the SOC-NAMEsi-post.dtsi
defines the pci0, pci1, pci2, pci3 aliases.

Now it is possible that a board does not implement pci1 for instance. So its
.dts file would ideally not define a node for it, and thus not define the
respective alias. However, this triggers this dtc compile error (which is correct):

> [chlongv1@chber1-10533x linux-km]$ make kmp204x.dtb
>   DTC     arch/powerpc/boot/kmp204x.dtb
> Error: arch/powerpc/boot/dts/fsl/p2041si-post.dtsi:98.2-3 label or path, 'pci1', not found
> FATAL ERROR: Syntax error parsing input tree
> make[1]: *** [arch/powerpc/boot/kmp204x.dtb] Error 1
> make: *** [kmp204x.dtb] Error 2

The solution I have found is to define a "dummy" disabled node so that I can
define the alias, but I am not really happy about this:

> 	pci1: pcie@ffe201000 {
> 		status = "disabled";
> 	};

I am here missing something obvious or shouldn't it be possible that such .dtsi
files allow not to define unused/unnecessary nodes ?

Valentin
