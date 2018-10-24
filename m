Return-Path: <SRS0=Hff1=NE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05AE0ECDE44
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Oct 2018 21:43:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CD6920652
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Oct 2018 21:43:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CD6920652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42gP012t7LzDrPh
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Oct 2018 08:43:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.167.195; helo=mail-oi1-f195.google.com;
 envelope-from=pku.leo@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=nxp.com
Received: from mail-oi1-f195.google.com (mail-oi1-f195.google.com
 [209.85.167.195])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42gNxh4ZLQzDrRN
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Oct 2018 08:41:44 +1100 (AEDT)
Received: by mail-oi1-f195.google.com with SMTP id h4-v6so3290535oih.9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Oct 2018 14:41:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+asLhH7avNXtJSDoIT1sM3YWg5U5bqZZWEGl23fiMm0=;
 b=uc9vUot0u+fJN+pVrqtTUT2MbIdqNvDKudA3zzsCHv8vv652+nlrj7+tX8rfL4h9hT
 EQjpSQkQkZbhtT7c/0VogrkSX6iuVikx9FvFCTxnyWng9WjNENDHhZOhPNO8LMQC6DbQ
 l11iG3LVmMd6N00sNqWrm1nWtyoS9n1aEcP9l4vVP4LmXT9eoibcClRzp6/SQADofFkJ
 LU/+H9oNhYc790q2jBDPq1SSOxhbLSUuS72iT1lzj+8o1voVVAAeJEN74fQxJJEXGKFT
 /jR2zDipsajtzDcKr/KokStf1pn5iyEe7DhS9E6N4g4gEgle3tRm6luEGEpAh8tjY7K1
 /NSA==
X-Gm-Message-State: AGRZ1gJjVvKtx9N989DB+h4PzhYl7gvfpc2mBADbBfpqTSTxR8L7jz1l
 3vlbRaVVeC3eHkDhYDR65/Lc8iQgaQI=
X-Google-Smtp-Source: AJdET5e0RmX58WxUfS+VEZ2N/MPfnqRTogzB1oNVeGJBpNjh1PM2VJBiGXAIQzEVdVZ45SALiFwK6g==
X-Received: by 2002:aca:6709:: with SMTP id
 z9-v6mr2211612oix.178.1540417302011; 
 Wed, 24 Oct 2018 14:41:42 -0700 (PDT)
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com.
 [209.85.167.170])
 by smtp.gmail.com with ESMTPSA id g188-v6sm2231306oic.10.2018.10.24.14.41.40
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 24 Oct 2018 14:41:41 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id i10-v6so2561260oik.8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Oct 2018 14:41:40 -0700 (PDT)
X-Received: by 2002:aca:5256:: with SMTP id
 g83-v6mr2456148oib.351.1540417300541; 
 Wed, 24 Oct 2018 14:41:40 -0700 (PDT)
MIME-Version: 1.0
References: <1539536883-1928-1-git-send-email-vabhav.sharma@nxp.com>
 <1539536883-1928-7-git-send-email-vabhav.sharma@nxp.com>
In-Reply-To: <1539536883-1928-7-git-send-email-vabhav.sharma@nxp.com>
From: Li Yang <leoyang.li@nxp.com>
Date: Wed, 24 Oct 2018 16:41:29 -0500
X-Gmail-Original-Message-ID: <CADRPPNSQt=d4HDR9YckZnXvFi4jB2RisraT869BvTGbpS3Etdg@mail.gmail.com>
Message-ID: <CADRPPNSQt=d4HDR9YckZnXvFi4jB2RisraT869BvTGbpS3Etdg@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] arm64: dts: add LX2160ARDB board support
To: Vabhav Sharma <vabhav.sharma@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, linux-kernel-owner@vger.kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>,
 Michael Turquette <mturquette@baylibre.com>, Will Deacon <will.deacon@arm.com>,
 Adrian Hunter <adrian.hunter@intel.com>, yamada.masahiro@socionext.com,
 Sriram Dash <sriram.dash@nxp.com>, linux-clk <linux-clk@vger.kernel.org>,
 Horia Geanta <horia.geanta@nxp.com>, pankaj.bansal@nxp.com, udit.kumar@nxp.com,
 Russell King <linux@armlinux.org.uk>, Priyanka Jain <priyanka.jain@nxp.com>,
 Viresh Kumar <viresh.kumar@linaro.org>, Yinbo Zhu <yinbo.zhu@nxp.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 linux-pm@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Scott Wood <oss@buserror.net>, Rob Herring <robh+dt@kernel.org>,
 V.Sethi@nxp.com, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, sboyd@kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Ying Zhang <ying.zhang22455@nxp.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 lkml <linux-kernel@vger.kernel.org>, Sudeep Holla <sudeep.holla@arm.com>,
 Ran Wang <ran.wang_1@nxp.com>, Shawn Guo <shawnguo@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Oct 15, 2018 at 12:14 AM Vabhav Sharma <vabhav.sharma@nxp.com> wrote:
>
> LX2160A reference design board (RDB) is a high-performance
> computing, evaluation, and development platform with LX2160A
> SoC.
>
> Signed-off-by: Priyanka Jain <priyanka.jain@nxp.com>
> Signed-off-by: Sriram Dash <sriram.dash@nxp.com>
> Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
> Signed-off-by: Horia Geanta <horia.geanta@nxp.com>
> Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> Signed-off-by: Zhang Ying-22455 <ying.zhang22455@nxp.com>
> Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>

Acked-by: Li Yang <leoyang.li@nxp.com>

> ---
>  arch/arm64/boot/dts/freescale/Makefile            |   1 +
>  arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts | 119 ++++++++++++++++++++++
>  2 files changed, 120 insertions(+)
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
> index 0000000..6481e5f
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> @@ -0,0 +1,119 @@
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
> +               serial0 = &uart0;
> +       };
> +
> +       chosen {
> +               stdout-path = "serial0:115200n8";
> +       };
> +
> +       sb_3v3: regulator-sb3v3 {
> +               compatible = "regulator-fixed";
> +               regulator-name = "MC34717-3.3VSB";
> +               regulator-min-microvolt = <3300000>;
> +               regulator-max-microvolt = <3300000>;
> +               regulator-boot-on;
> +               regulator-always-on;
> +       };
> +};
> +
> +&crypto {
> +       status = "okay";
> +};
> +
> +&esdhc0 {
> +       sd-uhs-sdr104;
> +       sd-uhs-sdr50;
> +       sd-uhs-sdr25;
> +       sd-uhs-sdr12;
> +       status = "okay";
> +};
> +
> +&esdhc1 {
> +       mmc-hs200-1_8v;
> +       mmc-hs400-1_8v;
> +       bus-width = <8>;
> +       status = "okay";
> +};
> +
> +&i2c0 {
> +       status = "okay";
> +
> +       i2c-mux@77 {
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
> +                       power-monitor@40 {
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
> +                       temperature-sensor@4c {
> +                               compatible = "nxp,sa56004";
> +                               reg = <0x4c>;
> +                               vcc-supply = <&sb_3v3>;
> +                       };
> +
> +                       temperature-sensor@4d {
> +                               compatible = "nxp,sa56004";
> +                               reg = <0x4d>;
> +                               vcc-supply = <&sb_3v3>;
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
> +&usb0 {
> +       status = "okay";
> +};
> +
> +&usb1 {
> +       status = "okay";
> +};
> --
> 2.7.4
>
