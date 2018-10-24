Return-Path: <SRS0=Hff1=NE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0BECECDE46
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Oct 2018 21:41:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27F6320652
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Oct 2018 21:41:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27F6320652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42gNxl3CFWzDrPp
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Oct 2018 08:41:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.167.194; helo=mail-oi1-f194.google.com;
 envelope-from=pku.leo@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=nxp.com
Received: from mail-oi1-f194.google.com (mail-oi1-f194.google.com
 [209.85.167.194])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42gNvW3gklzDrP4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Oct 2018 08:39:51 +1100 (AEDT)
Received: by mail-oi1-f194.google.com with SMTP id u74-v6so5356283oia.11
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Oct 2018 14:39:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SEqOUWzeYMJpqTHsCRJGXGDeUUUUuGFzoEAGmrKeWoM=;
 b=NHlBw+QKnHnzHoJpXt+rN062tcQk4Vow9J7Zau1ib4rMjyNMRDncodlPCMDJDhY7XC
 z7dkQ4GFSGgQUJ9GMRn3dAV+DYrRmKF/EsZxDU3bGzW89EK6JevUx8GsrZxGuRfon8wy
 FGv90bnPfeEzsFwO2w9CionCrVbD2lOih/sWzEsWQrI56/L4rxxDjVzZSGkf1bs33IUC
 pDkVomCySSANmwgwRaIDxmVDfzUH1K4CBX6pqtl5h+zOmc1PksQCEY3dughLXKGZ+Vsz
 58bdPEJRkySh0QnjYpv9RK2rqSEw/Q7NVP5TAEzZIZbC4X0rxzD7JjpIv/I0MlZEKfWK
 ZiKw==
X-Gm-Message-State: AGRZ1gLS3ktlqjhMrYxy4j5VBDcwHaMfNGfDjvLvO665GGXBCtevy8M0
 B0fw0QkbySUcqglUMMpNEImYmsfFzWc=
X-Google-Smtp-Source: AJdET5cpOGFoPdwJSaazAyMEGVUolOUq3j7odTIYgYArU3j6FGcqJejt8pomMikrYmN9iyPtLaDXKA==
X-Received: by 2002:aca:4d51:: with SMTP id
 a78-v6mr2252555oib.205.1540417188699; 
 Wed, 24 Oct 2018 14:39:48 -0700 (PDT)
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com.
 [209.85.167.180])
 by smtp.gmail.com with ESMTPSA id k54sm2561714otb.8.2018.10.24.14.39.46
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 24 Oct 2018 14:39:47 -0700 (PDT)
Received: by mail-oi1-f180.google.com with SMTP id k19-v6so5370107oiw.5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Oct 2018 14:39:46 -0700 (PDT)
X-Received: by 2002:aca:3195:: with SMTP id
 x143-v6mr2279303oix.213.1540417186346; 
 Wed, 24 Oct 2018 14:39:46 -0700 (PDT)
MIME-Version: 1.0
References: <1539536883-1928-1-git-send-email-vabhav.sharma@nxp.com>
 <1539536883-1928-3-git-send-email-vabhav.sharma@nxp.com>
In-Reply-To: <1539536883-1928-3-git-send-email-vabhav.sharma@nxp.com>
From: Li Yang <leoyang.li@nxp.com>
Date: Wed, 24 Oct 2018 16:39:35 -0500
X-Gmail-Original-Message-ID: <CADRPPNTwpQRu9fxt8PTVb6VoNJEFFrMHpCrRa5T7YEddSVnq-w@mail.gmail.com>
Message-ID: <CADRPPNTwpQRu9fxt8PTVb6VoNJEFFrMHpCrRa5T7YEddSVnq-w@mail.gmail.com>
Subject: Re: [PATCH v5 2/6] soc/fsl/guts: Add definition for LX2160A
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
 linux-clk <linux-clk@vger.kernel.org>, pankaj.bansal@nxp.com,
 udit.kumar@nxp.com, Russell King <linux@armlinux.org.uk>,
 Viresh Kumar <viresh.kumar@linaro.org>, Yinbo Zhu <yinbo.zhu@nxp.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 linux-pm@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Scott Wood <oss@buserror.net>, Rob Herring <robh+dt@kernel.org>,
 V.Sethi@nxp.com, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, sboyd@kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, lkml <linux-kernel@vger.kernel.org>,
 Sudeep Holla <sudeep.holla@arm.com>, Shawn Guo <shawnguo@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Oct 15, 2018 at 12:14 AM Vabhav Sharma <vabhav.sharma@nxp.com> wrote:
>
> Adding compatible string "lx2160a-dcfg" to
> initialize guts driver for lx2160 and SoC die
> attribute definition for LX2160A
>
> Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
> Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>

Acked-by: Li Yang <leoyang.li@nxp.com>

> ---
>  drivers/soc/fsl/guts.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/soc/fsl/guts.c b/drivers/soc/fsl/guts.c
> index 302e0c8..bcab1ee 100644
> --- a/drivers/soc/fsl/guts.c
> +++ b/drivers/soc/fsl/guts.c
> @@ -100,6 +100,11 @@ static const struct fsl_soc_die_attr fsl_soc_die[] = {
>           .svr          = 0x87000000,
>           .mask         = 0xfff70000,
>         },
> +       /* Die: LX2160A, SoC: LX2160A/LX2120A/LX2080A */
> +       { .die          = "LX2160A",
> +         .svr          = 0x87360000,
> +         .mask         = 0xff3f0000,
> +       },
>         { },
>  };
>
> @@ -222,6 +227,7 @@ static const struct of_device_id fsl_guts_of_match[] = {
>         { .compatible = "fsl,ls1088a-dcfg", },
>         { .compatible = "fsl,ls1012a-dcfg", },
>         { .compatible = "fsl,ls1046a-dcfg", },
> +       { .compatible = "fsl,lx2160a-dcfg", },
>         {}
>  };
>  MODULE_DEVICE_TABLE(of, fsl_guts_of_match);
> --
> 2.7.4
>
