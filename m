Return-Path: <B07421@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0186.outbound.messaging.microsoft.com [213.199.154.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A570B2C00B8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Sep 2013 07:28:11 +1000 (EST)
Message-ID: <1379366879.2536.181.camel@snotra.buserror.net>
Subject: Re: [PATCH][v2] powerpc/mpc85xx:Add initial device tree support of
 T104x
From: Scott Wood <scottwood@freescale.com>
To: Prabhakar Kushwaha <prabhakar@freescale.com>
Date: Mon, 16 Sep 2013 16:27:59 -0500
In-Reply-To: <1379253688-11798-1-git-send-email-prabhakar@freescale.com>
References: <1379253688-11798-1-git-send-email-prabhakar@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Varun Sethi <Varun.Sethi@freescale.com>,
 Poonam Aggrwal <poonam.aggrwal@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 Priyanka Jain <Priyanka.Jain@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2013-09-15 at 19:31 +0530, Prabhakar Kushwaha wrote:
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
>  Based upon git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git
>  Branch next
> 
> Changes for v2: Incorporated Scott's comments
> 	- Update t1040si-post.dtsi
>     - update clock device tree node as per
>       http://patchwork.ozlabs.org/patch/274134/
>     - removed DMA node, It will be added later as per
>       http://patchwork.ozlabs.org/patch/271238/
>     - Updated display compatible field
> 
>  arch/powerpc/boot/dts/fsl/t1040si-post.dtsi |   41 +++
>  arch/powerpc/boot/dts/fsl/t1042si-post.dtsi |  418 +++++++++++++++++++++++++++
>  arch/powerpc/boot/dts/fsl/t104xsi-pre.dtsi  |  109 +++++++
>  3 files changed, 568 insertions(+)
>  create mode 100644 arch/powerpc/boot/dts/fsl/t1040si-post.dtsi
>  create mode 100644 arch/powerpc/boot/dts/fsl/t1042si-post.dtsi
>  create mode 100644 arch/powerpc/boot/dts/fsl/t104xsi-pre.dtsi
> 
> diff --git a/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi b/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi
> new file mode 100644
> index 0000000..ca820f6
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi
> @@ -0,0 +1,41 @@
> +/*
> + * T1040 Silicon/SoC Device Tree Source (post include)
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
> +/include/ "t1042si-post.dtsi"
> +
> +&soc {
> +	l2switch@800000 {
> +		reg = <0x800000 0x400000>;
> +	};

No compatible or anything else?

> +};
> diff --git a/arch/powerpc/boot/dts/fsl/t1042si-post.dtsi b/arch/powerpc/boot/dts/fsl/t1042si-post.dtsi
> new file mode 100644
> index 0000000..6bfbcda
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/fsl/t1042si-post.dtsi
> @@ -0,0 +1,418 @@
> +/*
> + * t1042 Silicon/SoC Device Tree Source (post include)
> + *
> + * Copyright 2013 Freescale Semiconductor Inc.
> + *
> + * Redistribution and use in source and binary forms, with or without
> + * modification, are permitted provided that the following conditions are met:
> + *     * Redistributions of source code must retain the above copyright
> + *	 notice, this list of conditions and the following disclaimer.
> + *     * Redistributions in binary form must reproduce the above copyright
> + *	 notice, this list of conditions and the following disclaimer in the
> + *	 documentation and/or other materials provided with the distribution.
> + *     * Neither the name of Freescale Semiconductor nor the
> + *	 names of its contributors may be used to endorse or promote products
> + *	 derived from this software without specific prior written permission.
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
> +&ifc {
> +	#address-cells = <2>;
> +	#size-cells = <1>;
> +	compatible = "fsl,ifc", "simple-bus";
> +	interrupts = <25 2 0 0>;
> +};
> +
> +&pci0 {
> +	compatible = "fsl,t104x-pcie", "fsl,qoriq-pcie-v2.4", "fsl,qoriq-pcie";

No "t104x" as discussed in the other thread (sorry for the delayed
response on that one).

> +		pll0: pll0@800 {
> +			#clock-cells = <1>;
> +			reg = <0x800 4>;
> +			compatible = "fsl,qoriq-chassis2-core-pll";
> +			clocks = <&clockgen>;
> +			clock-output-names = "pll0", "pll0-div2", "pll0-div4";
> +		};
> +		pll1: pll1@820 {
> +			#clock-cells = <1>;
> +			reg = <0x820 4>;
> +			compatible = "fsl,qoriq-chassis2-core-pll";
> +			clocks = <&clockgen>;
> +			clock-output-names = "pll1", "pll1-div2", "pll1-div4";
> +		};

As I mentioned in the clockgen thread, I think "fsl,qoriq-core-pll-2.0"
would be better and more consistent.

-Scott
