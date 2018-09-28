Return-Path: <SRS0=psBJ=MK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 583BEC43143
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Sep 2018 19:39:23 +0000 (UTC)
Received: from lists.ozlabs.org (unknown [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7C49206B7
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Sep 2018 19:39:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7C49206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42MMSS5CKpzF3LK
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Sep 2018 05:39:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.210.65; helo=mail-ot1-f65.google.com;
 envelope-from=pku.leo@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=nxp.com
Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com
 [209.85.210.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42MMQL4wNVzF3J9
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Sep 2018 05:37:30 +1000 (AEST)
Received: by mail-ot1-f65.google.com with SMTP id i12-v6so7152495otl.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Sep 2018 12:37:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=K+qCV9SaBAMefNu93MVLFeCsJFl0wtxQ1dZwtJUyGPk=;
 b=pZ3AqQJzPaN9BGbBnJDMRrew0A/TqeHZgO/aL8F+Cw+40mvMz2nlUxwjoot9ZczKmo
 iSIqiF3oVByqdrkexuKmR2DTx1trb9nlne+r/MsObIgxefpnwQ4gT+RIaUDHQ3xN7jNV
 +ED7/FOA7f8tYWNv/jVgj5aiBLP2tYD6EwBBN5bBY2GD6E3cJbtLqdrinXAtJjolpuFm
 I0+Un2sV8wxE+bKiP9mIogJubSkOOL4pmewqUI4a1NmM2uP1IEquS2saMG3RL0EOHyBC
 ul98hzZw+BFqGQexvms7UQOfInbdwJtDMYbe3BfGsOIIRYlAIa0S2oklCQO0Wtj5JUjX
 kBtw==
X-Gm-Message-State: ABuFfohY9Q0wzts5ddsjsBVsHYB2BqVJ3Vpa9Lzxl7/wViWb3B59Y7Mn
 zqj/8ROWWtqcxCJ4TXNV2MdrbaCcjLM=
X-Google-Smtp-Source: ACcGV60kfWx0VUKNCcaVOpmKWTSHeWhX9gbjSQNeti3GhqRGmlB37D9h3+HRNP4XzztIfe24s3D6ZQ==
X-Received: by 2002:a9d:5285:: with SMTP id f5-v6mr41497oth.247.1538163448148; 
 Fri, 28 Sep 2018 12:37:28 -0700 (PDT)
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com.
 [209.85.210.41])
 by smtp.gmail.com with ESMTPSA id u17-v6sm2025675oia.43.2018.09.28.12.37.26
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 28 Sep 2018 12:37:27 -0700 (PDT)
Received: by mail-ot1-f41.google.com with SMTP id c20-v6so562455otl.6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Sep 2018 12:37:26 -0700 (PDT)
X-Received: by 2002:a9d:1b50:: with SMTP id l74-v6mr81460otl.112.1538163446517; 
 Fri, 28 Sep 2018 12:37:26 -0700 (PDT)
MIME-Version: 1.0
References: <1537747741-6245-1-git-send-email-vabhav.sharma@nxp.com>
 <1537747741-6245-7-git-send-email-vabhav.sharma@nxp.com>
In-Reply-To: <1537747741-6245-7-git-send-email-vabhav.sharma@nxp.com>
From: Li Yang <leoyang.li@nxp.com>
Date: Fri, 28 Sep 2018 14:37:15 -0500
X-Gmail-Original-Message-ID: <CADRPPNS1Zj=47M-yOBAJ=X=sjjxmh0k7tNcj1A8uY=cPM398tQ@mail.gmail.com>
Message-ID: <CADRPPNS1Zj=47M-yOBAJ=X=sjjxmh0k7tNcj1A8uY=cPM398tQ@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] arm64: dts: add LX2160ARDB board support
To: vabhav.sharma@nxp.com
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
 linux-kernel-owner@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Michael Turquette <mturquette@baylibre.com>, Will Deacon <will.deacon@arm.com>,
 yamada.masahiro@socionext.com, Sriram Dash <sriram.dash@nxp.com>,
 linux-clk <linux-clk@vger.kernel.org>, udit.kumar@nxp.com,
 Russell King <linux@armlinux.org.uk>, Priyanka Jain <priyanka.jain@nxp.com>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 linux-pm@vger.kernel.org, Scott Wood <oss@buserror.net>,
 Rob Herring <robh+dt@kernel.org>, V.Sethi@nxp.com,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, sboyd@kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, lkml <linux-kernel@vger.kernel.org>,
 Sudeep Holla <sudeep.holla@arm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Sep 24, 2018 at 7:51 AM Vabhav Sharma <vabhav.sharma@nxp.com> wrote:
>
> LX2160A reference design board (RDB) is a high-performance
> computing, evaluation, and development platform with LX2160A
> SoC.

Please send next version with Shawn Guo and me in the "to" recipient
so that its less likely we will miss it.

>
> Signed-off-by: Priyanka Jain <priyanka.jain@nxp.com>
> Signed-off-by: Sriram Dash <sriram.dash@nxp.com>
> Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/Makefile            |  1 +
>  arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts | 88 +++++++++++++++++++++++
>  2 files changed, 89 insertions(+)
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
> index 0000000..1bbe663
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> @@ -0,0 +1,88 @@
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

Need a vcc-supply property according to the binding.

> +                       };
> +
> +                       temperature-sensor@4d {
> +                               compatible = "nxp,sa56004";
> +                               reg = <0x4d>;

Ditto.

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
