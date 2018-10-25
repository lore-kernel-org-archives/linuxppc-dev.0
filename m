Return-Path: <SRS0=ruO2=NF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D47A4ECDE46
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Oct 2018 19:59:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 190BA20834
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Oct 2018 19:59:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 190BA20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42gydC74GXzDq74
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Oct 2018 06:59:27 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42gyZt4xFtzF3C4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Oct 2018 06:57:26 +1100 (AEDT)
Received: by mail-oi1-f195.google.com with SMTP id k19-v6so1747424oic.11
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Oct 2018 12:57:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bpA3+kQ7D8Sb48Dp5E3BIHq1HHOeBqGuKKjplrCuWVg=;
 b=KUnK15ptTf0FbMLyORxBaVsep49bP2lvCHHiVe1lZ3peTpJXI02WSZQJI8TuRk3Cem
 Uq5rY4XDY2FzHRle5BoA6pdMwBugkfkcU44YDuXs9EqJq0ornsd+mzv+OenfuVjvngVX
 ZpkAc9aJVGx0msG+/0vgAMQ4zUAcLwweZ0N17vOfMBk8oF8HUZOCxlhOgmIeN/4405BY
 gYkQk2rG0X1QZHPIGVcBXmskC2pf5KC2p+ms2q6hDaNkwG9GIiGMsE8iHzMR6PXptwo0
 OsnwzUdu7uRkBQ0YypLBWuR1VANz+TfzNH82rByu5vvzAd5hGLn4LvBu2VHeLngHPFzI
 iMTQ==
X-Gm-Message-State: AGRZ1gKz/PknZw2oSBoZS9Wxdf0DYyV834MGRIYVxF86eQlf+oq+3mhx
 rWpsG0Xfm+VKwnvY2xjduM1n1y3o5QE=
X-Google-Smtp-Source: AJdET5eN8VSwUnqmH4rss2JRnk/kknhL7NZECJp6irAGhw8v9OFnd3EJGJSlecSRnduc+74vBqUSAg==
X-Received: by 2002:aca:d4d2:: with SMTP id
 l201-v6mr375201oig.15.1540497444322; 
 Thu, 25 Oct 2018 12:57:24 -0700 (PDT)
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com.
 [209.85.167.174])
 by smtp.gmail.com with ESMTPSA id w31sm3082040ota.22.2018.10.25.12.57.24
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 25 Oct 2018 12:57:24 -0700 (PDT)
Received: by mail-oi1-f174.google.com with SMTP id c25-v6so2442114oiy.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Oct 2018 12:57:24 -0700 (PDT)
X-Received: by 2002:aca:220c:: with SMTP id
 b12-v6mr349719oic.203.1540496967974; 
 Thu, 25 Oct 2018 12:49:27 -0700 (PDT)
MIME-Version: 1.0
References: <1540407376-24115-1-git-send-email-vabhav.sharma@nxp.com>
 <1540407376-24115-6-git-send-email-vabhav.sharma@nxp.com>
In-Reply-To: <1540407376-24115-6-git-send-email-vabhav.sharma@nxp.com>
From: Li Yang <leoyang.li@nxp.com>
Date: Thu, 25 Oct 2018 14:49:16 -0500
X-Gmail-Original-Message-ID: <CADRPPNS4brR5f3PiAujLQSy3kpniaR+pzKRn0LhBSSsawJ-vag@mail.gmail.com>
Message-ID: <CADRPPNS4brR5f3PiAujLQSy3kpniaR+pzKRn0LhBSSsawJ-vag@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] arm64: dts: add QorIQ LX2160A SoC support
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
 Ulf Hansson <ulf.hansson@linaro.org>, yogeshnarayan.gaur@nxp.com,
 linux-kernel-owner@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
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
 V.Sethi@nxp.com, nipun.gupta@nxp.com,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 Ramneek Mehresh <ramneek.mehresh@nxp.com>, sboyd@kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Ying Zhang <ying.zhang22455@nxp.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 lkml <linux-kernel@vger.kernel.org>, Sudeep Holla <sudeep.holla@arm.com>,
 Ran Wang <ran.wang_1@nxp.com>, Shawn Guo <shawnguo@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Oct 25, 2018 at 2:03 AM Vabhav Sharma <vabhav.sharma@nxp.com> wrote:
>
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
> Signed-off-by: Horia Geanta <horia.geanta@nxp.com>
> Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 766 +++++++++++++++++++++++++
>  1 file changed, 766 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
>
> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> new file mode 100644
> index 0000000..9fcfd48
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> @@ -0,0 +1,766 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +//
> +// Device Tree Include file for Layerscape-LX2160A family SoC.
> +//
> +// Copyright 2018 NXP
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +/memreserve/ 0x80000000 0x00010000;
> +
> +/ {
> +       compatible = "fsl,lx2160a";
> +       interrupt-parent = <&gic>;
> +       #address-cells = <2>;
> +       #size-cells = <2>;
> +
> +       cpus {
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               // 8 clusters having 2 Cortex-A72 cores each
> +               cpu@0 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a72";
> +                       enable-method = "psci";
> +                       reg = <0x0>;
> +                       clocks = <&clockgen 1 0>;
> +                       d-cache-size = <0x8000>;
> +                       d-cache-line-size = <64>;
> +                       d-cache-sets = <128>;
> +                       i-cache-size = <0xC000>;
> +                       i-cache-line-size = <64>;
> +                       i-cache-sets = <192>;
> +                       next-level-cache = <&cluster0_l2>;
> +               };
> +
> +               cpu@1 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a72";
> +                       enable-method = "psci";
> +                       reg = <0x1>;
> +                       clocks = <&clockgen 1 0>;
> +                       d-cache-size = <0x8000>;
> +                       d-cache-line-size = <64>;
> +                       d-cache-sets = <128>;
> +                       i-cache-size = <0xC000>;
> +                       i-cache-line-size = <64>;
> +                       i-cache-sets = <192>;
> +                       next-level-cache = <&cluster0_l2>;
> +               };
> +
> +               cpu@100 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a72";
> +                       enable-method = "psci";
> +                       reg = <0x100>;
> +                       clocks = <&clockgen 1 1>;
> +                       d-cache-size = <0x8000>;
> +                       d-cache-line-size = <64>;
> +                       d-cache-sets = <128>;
> +                       i-cache-size = <0xC000>;
> +                       i-cache-line-size = <64>;
> +                       i-cache-sets = <192>;
> +                       next-level-cache = <&cluster1_l2>;
> +               };
> +
> +               cpu@101 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a72";
> +                       enable-method = "psci";
> +                       reg = <0x101>;
> +                       clocks = <&clockgen 1 1>;
> +                       d-cache-size = <0x8000>;
> +                       d-cache-line-size = <64>;
> +                       d-cache-sets = <128>;
> +                       i-cache-size = <0xC000>;
> +                       i-cache-line-size = <64>;
> +                       i-cache-sets = <192>;
> +                       next-level-cache = <&cluster1_l2>;
> +               };
> +
> +               cpu@200 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a72";
> +                       enable-method = "psci";
> +                       reg = <0x200>;
> +                       clocks = <&clockgen 1 2>;
> +                       d-cache-size = <0x8000>;
> +                       d-cache-line-size = <64>;
> +                       d-cache-sets = <128>;
> +                       i-cache-size = <0xC000>;
> +                       i-cache-line-size = <64>;
> +                       i-cache-sets = <192>;
> +                       next-level-cache = <&cluster2_l2>;
> +               };
> +
> +               cpu@201 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a72";
> +                       enable-method = "psci";
> +                       reg = <0x201>;
> +                       clocks = <&clockgen 1 2>;
> +                       d-cache-size = <0x8000>;
> +                       d-cache-line-size = <64>;
> +                       d-cache-sets = <128>;
> +                       i-cache-size = <0xC000>;
> +                       i-cache-line-size = <64>;
> +                       i-cache-sets = <192>;
> +                       next-level-cache = <&cluster2_l2>;
> +               };
> +
> +               cpu@300 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a72";
> +                       enable-method = "psci";
> +                       reg = <0x300>;
> +                       clocks = <&clockgen 1 3>;
> +                       d-cache-size = <0x8000>;
> +                       d-cache-line-size = <64>;
> +                       d-cache-sets = <128>;
> +                       i-cache-size = <0xC000>;
> +                       i-cache-line-size = <64>;
> +                       i-cache-sets = <192>;
> +                       next-level-cache = <&cluster3_l2>;
> +               };
> +
> +               cpu@301 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a72";
> +                       enable-method = "psci";
> +                       reg = <0x301>;
> +                       clocks = <&clockgen 1 3>;
> +                       d-cache-size = <0x8000>;
> +                       d-cache-line-size = <64>;
> +                       d-cache-sets = <128>;
> +                       i-cache-size = <0xC000>;
> +                       i-cache-line-size = <64>;
> +                       i-cache-sets = <192>;
> +                       next-level-cache = <&cluster3_l2>;
> +               };
> +
> +               cpu@400 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a72";
> +                       enable-method = "psci";
> +                       reg = <0x400>;
> +                       clocks = <&clockgen 1 4>;
> +                       d-cache-size = <0x8000>;
> +                       d-cache-line-size = <64>;
> +                       d-cache-sets = <128>;
> +                       i-cache-size = <0xC000>;
> +                       i-cache-line-size = <64>;
> +                       i-cache-sets = <192>;
> +                       next-level-cache = <&cluster4_l2>;
> +               };
> +
> +               cpu@401 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a72";
> +                       enable-method = "psci";
> +                       reg = <0x401>;
> +                       clocks = <&clockgen 1 4>;
> +                       d-cache-size = <0x8000>;
> +                       d-cache-line-size = <64>;
> +                       d-cache-sets = <128>;
> +                       i-cache-size = <0xC000>;
> +                       i-cache-line-size = <64>;
> +                       i-cache-sets = <192>;
> +                       next-level-cache = <&cluster4_l2>;
> +               };
> +
> +               cpu@500 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a72";
> +                       enable-method = "psci";
> +                       reg = <0x500>;
> +                       clocks = <&clockgen 1 5>;
> +                       d-cache-size = <0x8000>;
> +                       d-cache-line-size = <64>;
> +                       d-cache-sets = <128>;
> +                       i-cache-size = <0xC000>;
> +                       i-cache-line-size = <64>;
> +                       i-cache-sets = <192>;
> +                       next-level-cache = <&cluster5_l2>;
> +               };
> +
> +               cpu@501 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a72";
> +                       enable-method = "psci";
> +                       reg = <0x501>;
> +                       clocks = <&clockgen 1 5>;
> +                       d-cache-size = <0x8000>;
> +                       d-cache-line-size = <64>;
> +                       d-cache-sets = <128>;
> +                       i-cache-size = <0xC000>;
> +                       i-cache-line-size = <64>;
> +                       i-cache-sets = <192>;
> +                       next-level-cache = <&cluster5_l2>;
> +               };
> +
> +               cpu@600 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a72";
> +                       enable-method = "psci";
> +                       reg = <0x600>;
> +                       clocks = <&clockgen 1 6>;
> +                       d-cache-size = <0x8000>;
> +                       d-cache-line-size = <64>;
> +                       d-cache-sets = <128>;
> +                       i-cache-size = <0xC000>;
> +                       i-cache-line-size = <64>;
> +                       i-cache-sets = <192>;
> +                       next-level-cache = <&cluster6_l2>;
> +               };
> +
> +               cpu@601 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a72";
> +                       enable-method = "psci";
> +                       reg = <0x601>;
> +                       clocks = <&clockgen 1 6>;
> +                       d-cache-size = <0x8000>;
> +                       d-cache-line-size = <64>;
> +                       d-cache-sets = <128>;
> +                       i-cache-size = <0xC000>;
> +                       i-cache-line-size = <64>;
> +                       i-cache-sets = <192>;
> +                       next-level-cache = <&cluster6_l2>;
> +               };
> +
> +               cpu@700 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a72";
> +                       enable-method = "psci";
> +                       reg = <0x700>;
> +                       clocks = <&clockgen 1 7>;
> +                       d-cache-size = <0x8000>;
> +                       d-cache-line-size = <64>;
> +                       d-cache-sets = <128>;
> +                       i-cache-size = <0xC000>;
> +                       i-cache-line-size = <64>;
> +                       i-cache-sets = <192>;
> +                       next-level-cache = <&cluster7_l2>;
> +               };
> +
> +               cpu@701 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a72";
> +                       enable-method = "psci";
> +                       reg = <0x701>;
> +                       clocks = <&clockgen 1 7>;
> +                       d-cache-size = <0x8000>;
> +                       d-cache-line-size = <64>;
> +                       d-cache-sets = <128>;
> +                       i-cache-size = <0xC000>;
> +                       i-cache-line-size = <64>;
> +                       i-cache-sets = <192>;
> +                       next-level-cache = <&cluster7_l2>;
> +               };
> +
> +               cluster0_l2: l2-cache0 {
> +                       compatible = "cache";
> +                       cache-size = <0x100000>;
> +                       cache-line-size = <64>;
> +                       cache-sets = <1024>;
> +                       cache-level = <2>;
> +               };
> +
> +               cluster1_l2: l2-cache1 {
> +                       compatible = "cache";
> +                       cache-size = <0x100000>;
> +                       cache-line-size = <64>;
> +                       cache-sets = <1024>;
> +                       cache-level = <2>;
> +               };
> +
> +               cluster2_l2: l2-cache2 {
> +                       compatible = "cache";
> +                       cache-size = <0x100000>;
> +                       cache-line-size = <64>;
> +                       cache-sets = <1024>;
> +                       cache-level = <2>;
> +               };
> +
> +               cluster3_l2: l2-cache3 {
> +                       compatible = "cache";
> +                       cache-size = <0x100000>;
> +                       cache-line-size = <64>;
> +                       cache-sets = <1024>;
> +                       cache-level = <2>;
> +               };
> +
> +               cluster4_l2: l2-cache4 {
> +                       compatible = "cache";
> +                       cache-size = <0x100000>;
> +                       cache-line-size = <64>;
> +                       cache-sets = <1024>;
> +                       cache-level = <2>;
> +               };
> +
> +               cluster5_l2: l2-cache5 {
> +                       compatible = "cache";
> +                       cache-size = <0x100000>;
> +                       cache-line-size = <64>;
> +                       cache-sets = <1024>;
> +                       cache-level = <2>;
> +               };
> +
> +               cluster6_l2: l2-cache6 {
> +                       compatible = "cache";
> +                       cache-size = <0x100000>;
> +                       cache-line-size = <64>;
> +                       cache-sets = <1024>;
> +                       cache-level = <2>;
> +               };
> +
> +               cluster7_l2: l2-cache7 {
> +                       compatible = "cache";
> +                       cache-size = <0x100000>;
> +                       cache-line-size = <64>;
> +                       cache-sets = <1024>;
> +                       cache-level = <2>;
> +               };
> +       };
> +
> +       gic: interrupt-controller@6000000 {
> +               compatible = "arm,gic-v3";
> +               reg = <0x0 0x06000000 0 0x10000>, // GIC Dist
> +                       <0x0 0x06200000 0 0x200000>, // GICR (RD_base +
> +                                                    // SGI_base)
> +                       <0x0 0x0c0c0000 0 0x2000>, // GICC
> +                       <0x0 0x0c0d0000 0 0x1000>, // GICH
> +                       <0x0 0x0c0e0000 0 0x20000>; // GICV
> +               #interrupt-cells = <3>;
> +               #address-cells = <2>;
> +               #size-cells = <2>;
> +               ranges;
> +               interrupt-controller;
> +               interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +
> +               its: gic-its@6020000 {
> +                       compatible = "arm,gic-v3-its";
> +                       msi-controller;
> +                       reg = <0x0 0x6020000 0 0x20000>;
> +               };
> +       };
> +
> +       timer {
> +               compatible = "arm,armv8-timer";
> +               interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH>,
> +                            <GIC_PPI 14 IRQ_TYPE_LEVEL_HIGH>,
> +                            <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH>,
> +                            <GIC_PPI 10 IRQ_TYPE_LEVEL_HIGH>;
> +       };
> +
> +       pmu {
> +               compatible = "arm,cortex-a72-pmu";
> +               interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
> +       };
> +
> +       psci {
> +               compatible = "arm,psci-0.2";
> +               method = "smc";
> +       };
> +
> +       memory@80000000 {
> +               // DRAM space - 1, size : 2 GB DRAM
> +               device_type = "memory";
> +               reg = <0x00000000 0x80000000 0 0x80000000>;
> +       };
> +
> +       ddr1: memory-controller@1080000 {
> +               compatible = "fsl,qoriq-memory-controller";
> +               reg = <0x0 0x1080000 0x0 0x1000>;
> +               interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
> +               little-endian;
> +       };
> +
> +       ddr2: memory-controller@1090000 {
> +               compatible = "fsl,qoriq-memory-controller";
> +               reg = <0x0 0x1090000 0x0 0x1000>;
> +               interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
> +               little-endian;
> +       };
> +
> +       // One clock unit-sysclk node which bootloader require during DT fix-up
> +       sysclk: sysclk {
> +               compatible = "fixed-clock";
> +               #clock-cells = <0>;
> +               clock-frequency = <100000000>;

Would be even better if you can add a comment "fixed up by bootloader"
to the property too.

> +               clock-output-names = "sysclk";
> +       };
> +
> +       soc {
> +               compatible = "simple-bus";
> +               #address-cells = <2>;
> +               #size-cells = <2>;
> +               ranges;
> +
> +               crypto: crypto@8000000 {
> +                       compatible = "fsl,sec-v5.0", "fsl,sec-v4.0";
> +                       fsl,sec-era = <10>;
> +                       #address-cells = <1>;
> +                       #size-cells = <1>;
> +                       ranges = <0x0 0x00 0x8000000 0x100000>;
> +                       reg = <0x00 0x8000000 0x0 0x100000>;
> +                       interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>;
> +                       dma-coherent;
> +                       status = "disabled";
> +
> +                       sec_jr0: jr@10000 {
> +                               compatible = "fsl,sec-v5.0-job-ring",
> +                                            "fsl,sec-v4.0-job-ring";
> +                               reg        = <0x10000 0x10000>;
> +                               interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
> +                       };
> +
> +                       sec_jr1: jr@20000 {
> +                               compatible = "fsl,sec-v5.0-job-ring",
> +                                            "fsl,sec-v4.0-job-ring";
> +                               reg        = <0x20000 0x10000>;
> +                               interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
> +                       };
> +
> +                       sec_jr2: jr@30000 {
> +                               compatible = "fsl,sec-v5.0-job-ring",
> +                                            "fsl,sec-v4.0-job-ring";
> +                               reg        = <0x30000 0x10000>;
> +                               interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>;
> +                       };
> +
> +                       sec_jr3: jr@40000 {
> +                               compatible = "fsl,sec-v5.0-job-ring",
> +                                            "fsl,sec-v4.0-job-ring";
> +                               reg        = <0x40000 0x10000>;
> +                               interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
> +                       };
> +               };
> +
> +               clockgen: clock-controller@1300000 {
> +                       compatible = "fsl,lx2160a-clockgen";
> +                       reg = <0 0x1300000 0 0xa0000>;
> +                       #clock-cells = <2>;
> +                       clocks = <&sysclk>;
> +               };
> +
> +               dcfg: syscon@1e00000 {
> +                       compatible = "fsl,lx2160a-dcfg", "syscon";
> +                       reg = <0x0 0x1e00000 0x0 0x10000>;
> +                       little-endian;
> +               };
> +
> +               i2c0: i2c@2000000 {
> +                       compatible = "fsl,vf610-i2c";
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x0 0x2000000 0x0 0x10000>;
> +                       interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
> +                       clock-names = "i2c";
> +                       clocks = <&clockgen 4 7>;
> +                       scl-gpio = <&gpio2 15 GPIO_ACTIVE_HIGH>;
> +                       status = "disabled";
> +               };
> +
> +               i2c1: i2c@2010000 {
> +                       compatible = "fsl,vf610-i2c";
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x0 0x2010000 0x0 0x10000>;
> +                       interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
> +                       clock-names = "i2c";
> +                       clocks = <&clockgen 4 7>;
> +                       status = "disabled";
> +               };
> +
> +               i2c2: i2c@2020000 {
> +                       compatible = "fsl,vf610-i2c";
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x0 0x2020000 0x0 0x10000>;
> +                       interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
> +                       clock-names = "i2c";
> +                       clocks = <&clockgen 4 7>;
> +                       status = "disabled";
> +               };
> +
> +               i2c3: i2c@2030000 {
> +                       compatible = "fsl,vf610-i2c";
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x0 0x2030000 0x0 0x10000>;
> +                       interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
> +                       clock-names = "i2c";
> +                       clocks = <&clockgen 4 7>;
> +                       status = "disabled";
> +               };
> +
> +               i2c4: i2c@2040000 {
> +                       compatible = "fsl,vf610-i2c";
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x0 0x2040000 0x0 0x10000>;
> +                       interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
> +                       clock-names = "i2c";
> +                       clocks = <&clockgen 4 7>;
> +                       scl-gpio = <&gpio2 16 GPIO_ACTIVE_HIGH>;
> +                       status = "disabled";
> +               };
> +
> +               i2c5: i2c@2050000 {
> +                       compatible = "fsl,vf610-i2c";
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x0 0x2050000 0x0 0x10000>;
> +                       interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
> +                       clock-names = "i2c";
> +                       clocks = <&clockgen 4 7>;
> +                       status = "disabled";
> +               };
> +
> +               i2c6: i2c@2060000 {
> +                       compatible = "fsl,vf610-i2c";
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x0 0x2060000 0x0 0x10000>;
> +                       interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
> +                       clock-names = "i2c";
> +                       clocks = <&clockgen 4 7>;
> +                       status = "disabled";
> +               };
> +
> +               i2c7: i2c@2070000 {
> +                       compatible = "fsl,vf610-i2c";
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x0 0x2070000 0x0 0x10000>;
> +                       interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
> +                       clock-names = "i2c";
> +                       clocks = <&clockgen 4 7>;
> +                       status = "disabled";
> +               };
> +
> +               esdhc0: esdhc@2140000 {
> +                       compatible = "fsl,esdhc";
> +                       reg = <0x0 0x2140000 0x0 0x10000>;
> +                       interrupts = <0 28 0x4>; /* Level high type */
> +                       clocks = <&clockgen 4 1>;
> +                       voltage-ranges = <1800 1800 3300 3300>;
> +                       sdhci,auto-cmd12;
> +                       little-endian;
> +                       bus-width = <4>;
> +                       status = "disabled";
> +               };
> +
> +               esdhc1: esdhc@2150000 {
> +                       compatible = "fsl,esdhc";
> +                       reg = <0x0 0x2150000 0x0 0x10000>;
> +                       interrupts = <0 63 0x4>; /* Level high type */
> +                       clocks = <&clockgen 4 1>;
> +                       voltage-ranges = <1800 1800 3300 3300>;
> +                       sdhci,auto-cmd12;
> +                       broken-cd;
> +                       little-endian;
> +                       bus-width = <4>;
> +                       status = "disabled";
> +               };
> +
> +               uart0: serial@21c0000 {
> +                       compatible = "arm,sbsa-uart","arm,pl011";
> +                       reg = <0x0 0x21c0000 0x0 0x1000>;
> +                       interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
> +                       current-speed = <115200>;
> +                       status = "disabled";
> +               };
> +
> +               uart1: serial@21d0000 {
> +                       compatible = "arm,sbsa-uart","arm,pl011";
> +                       reg = <0x0 0x21d0000 0x0 0x1000>;
> +                       interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
> +                       current-speed = <115200>;
> +                       status = "disabled";
> +               };
> +
> +               uart2: serial@21e0000 {
> +                       compatible = "arm,sbsa-uart","arm,pl011";
> +                       reg = <0x0 0x21e0000 0x0 0x1000>;
> +                       interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
> +                       current-speed = <115200>;
> +                       status = "disabled";
> +               };
> +
> +               uart3: serial@21f0000 {
> +                       compatible = "arm,sbsa-uart","arm,pl011";
> +                       reg = <0x0 0x21f0000 0x0 0x1000>;
> +                       interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
> +                       current-speed = <115200>;
> +                       status = "disabled";
> +               };
> +
> +               gpio0: gpio@2300000 {
> +                       compatible = "fsl,qoriq-gpio";
> +                       reg = <0x0 0x2300000 0x0 0x10000>;
> +                       interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
> +                       gpio-controller;
> +                       little-endian;
> +                       #gpio-cells = <2>;
> +                       interrupt-controller;
> +                       #interrupt-cells = <2>;
> +               };
> +
> +               gpio1: gpio@2310000 {
> +                       compatible = "fsl,qoriq-gpio";
> +                       reg = <0x0 0x2310000 0x0 0x10000>;
> +                       interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
> +                       gpio-controller;
> +                       little-endian;
> +                       #gpio-cells = <2>;
> +                       interrupt-controller;
> +                       #interrupt-cells = <2>;
> +               };
> +
> +               gpio2: gpio@2320000 {
> +                       compatible = "fsl,qoriq-gpio";
> +                       reg = <0x0 0x2320000 0x0 0x10000>;
> +                       interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
> +                       gpio-controller;
> +                       little-endian;
> +                       #gpio-cells = <2>;
> +                       interrupt-controller;
> +                       #interrupt-cells = <2>;
> +               };
> +
> +               gpio3: gpio@2330000 {
> +                       compatible = "fsl,qoriq-gpio";
> +                       reg = <0x0 0x2330000 0x0 0x10000>;
> +                       interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
> +                       gpio-controller;
> +                       little-endian;
> +                       #gpio-cells = <2>;
> +                       interrupt-controller;
> +                       #interrupt-cells = <2>;
> +               };
> +
> +               watchdog@23a0000 {
> +                       compatible = "arm,sbsa-gwdt";
> +                       reg = <0x0 0x23a0000 0 0x1000>,
> +                             <0x0 0x2390000 0 0x1000>;
> +                       interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
> +                       timeout-sec = <30>;
> +               };
> +
> +               usb0: usb@3100000 {
> +                       compatible = "snps,dwc3";
> +                       reg = <0x0 0x3100000 0x0 0x10000>;
> +                       interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
> +                       dr_mode = "host";
> +                       snps,quirk-frame-length-adjustment = <0x20>;
> +                       snps,dis_rxdet_inp3_quirk;
> +                       status = "disabled";
> +               };
> +
> +               usb1: usb@3110000 {
> +                       compatible = "snps,dwc3";
> +                       reg = <0x0 0x3110000 0x0 0x10000>;
> +                       interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
> +                       dr_mode = "host";
> +                       snps,quirk-frame-length-adjustment = <0x20>;
> +                       snps,dis_rxdet_inp3_quirk;
> +                       status = "disabled";
> +               };
> +
> +               smmu: iommu@5000000 {
> +                       compatible = "arm,mmu-500";
> +                       reg = <0 0x5000000 0 0x800000>;
> +                       #iommu-cells = <1>;
> +                       #global-interrupts = <14>;
> +                                    // global secure fault
> +                       interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
> +                                    // combined secure
> +                                    <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>,
> +                                    // global non-secure fault
> +                                    <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>,
> +                                    // combined non-secure
> +                                    <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>,
> +                                    // performance counter interrupts 0-9
> +                                    <GIC_SPI 211 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 212 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 213 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 214 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 216 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 217 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 218 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 219 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 220 IRQ_TYPE_LEVEL_HIGH>,
> +                                    // per context interrupt, 64 interrupts
> +                                    <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 166 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 171 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 172 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 173 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 175 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 178 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 179 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 180 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 182 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 195 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 199 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 201 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 202 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 203 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 204 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 205 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 206 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH>;
> +                       dma-coherent;
> +               };
> +       };
> +};
> --
> 2.7.4
>
