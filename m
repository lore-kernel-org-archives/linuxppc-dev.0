Return-Path: <robh+dt@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41w2kR6DzrzF0pD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Aug 2018 06:45:35 +1000 (AEST)
Received: from mail-qt0-f171.google.com (mail-qt0-f171.google.com
 [209.85.216.171])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D62AF21854
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Aug 2018 20:45:32 +0000 (UTC)
Received: by mail-qt0-f171.google.com with SMTP id r13-v6so3195740qtr.11
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Aug 2018 13:45:32 -0700 (PDT)
MIME-Version: 1.0
References: <1534747636-20064-1-git-send-email-vabhav.sharma@nxp.com>
 <1534747636-20064-6-git-send-email-vabhav.sharma@nxp.com>
In-Reply-To: <1534747636-20064-6-git-send-email-vabhav.sharma@nxp.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Tue, 21 Aug 2018 15:45:20 -0500
Message-ID: <CAL_JsqKH4haGy2F2_2EP=evC8ip7DmGR8J4wzrO0wWnOLsaZqA@mail.gmail.com>
Subject: Re: [PATCH 5/5] arm64: dts: add LX2160ARDB board support
To: vabhav.sharma@nxp.com
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>,
 linux-clk <linux-clk@vger.kernel.org>,
 "open list:THERMAL" <linux-pm@vger.kernel.org>,
 linux-kernel-owner@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Arnd Bergmann <arnd@arndb.de>, Kate Stewart <kstewart@linuxfoundation.org>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Russell King <linux@armlinux.org.uk>, V.Sethi@nxp.com,
 Udit Kumar <udit.kumar@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Sriram Dash <sriram.dash@nxp.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 20, 2018 at 1:52 PM Vabhav Sharma <vabhav.sharma@nxp.com> wrote:
>
> LX2160A reference design board (RDB) is a high-performance
> computing, evaluation, and development platform with LX2160A
> SoC.
>
> Signed-off-by: Priyanka Jain <priyanka.jain@nxp.com>
> Signed-off-by: Sriram Dash <sriram.dash@nxp.com>
> Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/Makefile            |  1 +
>  arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts | 95 +++++++++++++++++++++++
>  2 files changed, 96 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
>
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index 86e18ad..445b72b 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -13,3 +13,4 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2080a-rdb.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2080a-simu.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2088a-qds.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2088a-rdb.dtb
> +dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-rdb.dtb
> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> new file mode 100644
> index 0000000..70fad20
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> @@ -0,0 +1,95 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +//
> +// Device Tree file for LX2160ARDB
> +//
> +// Copyright 2018 NXP
> +
> +/dts-v1/;
> +
> +#include "fsl-lx2160a.dtsi"
> +
> +/ {
> +       model = "NXP Layerscape LX2160ARDB";
> +       compatible = "fsl,lx2160a-rdb", "fsl,lx2160a";
> +
> +       aliases {
> +               crypto = &crypto;

Drop this. Aliases should be numbered, and this is not a standard
alias name either.

> +               serial0 = &uart0;
> +               serial1 = &uart1;
> +               serial2 = &uart2;
> +               serial3 = &uart3;
> +       };
> +       chosen {
> +               stdout-path = "serial0:115200n8";
> +       };
> +};
> +
> +&uart0 {
> +       status = "okay";
> +};
> +
> +&uart1 {
> +       status = "okay";
> +};
> +
> +&i2c0 {
> +       status = "okay";
> +       pca9547@77 {

i2c-mux@77

> +               compatible = "nxp,pca9547";
> +               reg = <0x77>;
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               i2c@2 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x2>;
> +
> +                       ina220@40 {
> +                               compatible = "ti,ina220";
> +                               reg = <0x40>;
> +                               shunt-resistor = <1000>;
> +                       };
> +               };
> +
> +               i2c@3 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x3>;
> +
> +                       sa56004@4c {

temperature-sensor@4c

> +                               compatible = "nxp,sa56004";
> +                               reg = <0x4c>;
> +                       };
> +
> +                       sa56004@4d {
> +                               compatible = "nxp,sa56004";
> +                               reg = <0x4d>;
> +                       };
> +               };
> +       };
> +};
> +
> +&i2c4 {
> +       status = "okay";
> +
> +       rtc@51 {
> +               compatible = "nxp,pcf2129";
> +               reg = <0x51>;
> +               // IRQ10_B
> +               interrupts = <0 150 0x4>;
> +               };
> +
> +};
> +
> +&usb0 {
> +       status = "okay";
> +};
> +
> +&usb1 {
> +       status = "okay";
> +};
> +
> +&crypto {
> +       status = "okay";
> +};
> --
> 2.7.4
>
