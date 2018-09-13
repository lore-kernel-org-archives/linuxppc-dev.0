Return-Path: <vabhav.sharma@nxp.com>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on0079.outbound.protection.outlook.com [104.47.2.79])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42BTYm5chPzF3Tj
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Sep 2018 18:43:06 +1000 (AEST)
From: Vabhav Sharma <vabhav.sharma@nxp.com>
To: sudeep.holla@arm.com, oss@buserror.net, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 mturquette@baylibre.com, sboyd@kernel.org, rjw@rjwysocki.net,
 viresh.kumar@linaro.org, linux-clk@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-kernel-owner@vger.kernel.org,
 catalin.marinas@arm.com, will.deacon@arm.com, gregkh@linuxfoundation.org,
 arnd@arndb.de, kstewart@linuxfoundation.org, yamada.masahiro@socionext.com
Cc: linux@armlinux.org.uk, V.Sethi@nxp.com, udit.kumar@nxp.com,
 Vabhav Sharma <vabhav.sharma@nxp.com>
Subject: [PATCH v2 0/5] arm64: dts: NXP: add basic dts file for LX2160A SoC
Date: Fri, 14 Sep 2018 02:07:50 +0530
Message-Id: <1536871075-3732-1-git-send-email-vabhav.sharma@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Changes for v2:
- Modified cmux_to_group array to include -1 terminator
- Revert NUM_CMUX to original value 8 from 16
- Remove “As LX2160A is 16 core, so modified value for NUM_CMUX”
  in patch "[PATCH 3/5] drivers: clk-qoriq: Add clockgen support for
  lx2160a" description
- Populated cache properties for L1 and L2 cache in lx2160a device-tree.
- Removed reboot node from lx2160a device-tree as PSCI is implemented.
- Removed incorrect comment for timer node interrupt property in
  lx2160a device-tree.
- Modified pmu node compatible property from "arm,armv8-pmuv3" to
  "arm,cortex-a72-pmu" in lx2160a device-tree
- Non-standard aliases removed in lx2160a rdb board device-tree
- Updated i2c child nodes to generic name in lx2160a rdb device-tree.

Changes for v1:
- Add compatible string for LX2160A clockgen support
- Add compatible string to initialize LX2160A guts driver
- Add compatible string for LX2160A support in dt-bindings
- Add dts file to enable support for LX2160A SoC and LX2160A RDB
  (Reference design board)

Vabhav Sharma (4):
  dt-bindings: arm64: add compatible for LX2160A
  soc/fsl/guts: Add compatible string for LX2160A
  arm64: dts: add QorIQ LX2160A SoC support
  arm64: dts: add LX2160ARDB board support

Yogesh Gaur (1):
  drivers: clk-qoriq: Add clockgen support for lx2160a

 Documentation/devicetree/bindings/arm/fsl.txt     |  12 +
 arch/arm64/boot/dts/freescale/Makefile            |   1 +
 arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts |  88 +++
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi    | 693 ++++++++++++++++++++++
 drivers/clk/clk-qoriq.c                           |  14 +-
 drivers/cpufreq/qoriq-cpufreq.c                   |   1 +
 drivers/soc/fsl/guts.c                            |   1 +
 7 files changed, 809 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi

-- 
2.7.4
