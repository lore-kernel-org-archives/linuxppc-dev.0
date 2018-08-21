Return-Path: <sudeep.holla@arm.com>
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 41vmnd6crDzF0hg
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Aug 2018 20:17:21 +1000 (AEST)
Date: Tue, 21 Aug 2018 11:17:02 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Vabhav Sharma <vabhav.sharma@nxp.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 robh+dt@kernel.org, mark.rutland@arm.com,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 mturquette@baylibre.com, sboyd@kernel.org, rjw@rjwysocki.net,
 viresh.kumar@linaro.org, linux-clk@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-kernel-owner@vger.kernel.org,
 catalin.marinas@arm.com, will.deacon@arm.com,
 gregkh@linuxfoundation.org, arnd@arndb.de,
 kstewart@linuxfoundation.org, yamada.masahiro@socionext.com,
 linux@armlinux.org.uk, V.Sethi@nxp.com, udit.kumar@nxp.com,
 Ramneek Mehresh <ramneek.mehresh@nxp.com>,
 Zhang Ying-22455 <ying.zhang22455@nxp.com>,
 Nipun Gupta <nipun.gupta@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Yogesh Gaur <yogeshnarayan.gaur@nxp.com>,
 Sriram Dash <sriram.dash@nxp.com>, Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 4/5] arm64: dts: add QorIQ LX2160A SoC support
Message-ID: <20180821101652.GA18139@e107155-lin>
References: <1534747636-20064-1-git-send-email-vabhav.sharma@nxp.com>
 <1534747636-20064-5-git-send-email-vabhav.sharma@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1534747636-20064-5-git-send-email-vabhav.sharma@nxp.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 20, 2018 at 12:17:15PM +0530, Vabhav Sharma wrote:
> LX2160A SoC is based on Layerscape Chassis Generation 3.2 Architecture.
> 
> LX2160A features an advanced 16 64-bit ARM v8 CortexA72 processor cores
> in 8 cluster, CCN508, GICv3,two 64-bit DDR4 memory controller, 8 I2C
> controllers, 3 dspi, 2 esdhc,2 USB 3.0, mmu 500, 3 SATA, 4 PL011 SBSA
> UARTs etc.
> 
> Signed-off-by: Ramneek Mehresh <ramneek.mehresh@nxp.com>
> Signed-off-by: Zhang Ying-22455 <ying.zhang22455@nxp.com>
> Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
> Signed-off-by: Priyanka Jain <priyanka.jain@nxp.com>
> Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> Signed-off-by: Sriram Dash <sriram.dash@nxp.com>
> Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 572 +++++++++++++++++++++++++
>  1 file changed, 572 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> new file mode 100644
> index 0000000..e35e494
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> @@ -0,0 +1,572 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +//
> +// Device Tree Include file for Layerscape-LX2160A family SoC.
> +//
> +// Copyright 2018 NXP
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +/memreserve/ 0x80000000 0x00010000;
> +
> +/ {
> +	compatible = "fsl,lx2160a";
> +	interrupt-parent = <&gic>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		// 8 clusters having 2 Cortex-A72 cores each
> +		cpu@0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72";
> +			reg = <0x0>;
> +			clocks = <&clockgen 1 0>;
> +			next-level-cache = <&cluster0_l2>;

If you expect to get cache properties in sysfs entries, you need to populate
them here and for each L2 cache.

[...]

> +
> +	rstcr: syscon@1e60000 {
> +		compatible = "syscon";
> +		reg = <0x0 0x1e60000 0x0 0x4>;
> +	};
> +
> +	reboot {
> +		compatible ="syscon-reboot";
> +		regmap = <&rstcr>;
> +		offset = <0x0>;
> +		mask = <0x2>;

Is this disabled in bootloader ? With PSCI, it's preferred to use
SYSTEM_RESET/OFF. EL3 f/w may need to do some housekeeping on poweroff.

> +	};
> +
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupts = <1 13 4>, // Physical Secure PPI, active-low

The comment says active low but the value 4 indicates it's HIGH from
"include/dt-bindings/interrupt-controller/irq.h"

> +			     <1 14 4>, // Physical Non-Secure PPI, active-low
> +			     <1 11 4>, // Virtual PPI, active-low
> +			     <1 10 4>; // Hypervisor PPI, active-low
> +	};
> +
> +	pmu {
> +		compatible = "arm,armv8-pmuv3";

More specific compatible preferably "arm,cortex-a72-pmu" ?

--
Regards,
Sudeep
