Return-Path: <SRS0=xrHL=SE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7083EC4360F
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 23:07:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E857D207E0
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 23:07:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E857D207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44YlGk0TFyzDqM6
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 10:07:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.210.67; helo=mail-ot1-f67.google.com;
 envelope-from=pku.leo@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=nxp.com
Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com
 [209.85.210.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44YlDb1RDFzDqLg
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Apr 2019 10:05:32 +1100 (AEDT)
Received: by mail-ot1-f67.google.com with SMTP id f10so6048484otb.6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Apr 2019 16:05:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FNGeNmpMXmbmbGQ8XUlYBSMpsJzpAXQAXL/ACI9Obp8=;
 b=bemuiMNqprk277anU9Ir/6F+WP5edfrUZvhA64vM+a8NIfc1TuRo5rlvX+BokAeZca
 lpbZXUevXvaxgQ2wwXB0NB30XqRCUfzelUN/l55h5DZwOz+IFCWYH189LoxsJi8XDZKD
 bbsuswXXF6gTCsRd/gTKb0aGajWay9oZIz4NCiUUvCNK7k4scNtXrNTTiuiFj5EUkbdv
 cdIDPj9wGsZB1m+MRDssy382suPP4aS9fD6kdaTQoTtPOxZxKTiiXIy71Q6pb0/rln+d
 BSwLEtInPqGY9BTOTL/Arr3mAOp9qf+nH/6ZLrHpe702+iy4IOjNnHJ626Q/GxIA3UwT
 sYXQ==
X-Gm-Message-State: APjAAAWks0mFTqi5nMmcHmLmMlerc/JGzoRp7jSODE2x8POVwASAIrbv
 6rZ5ZZurwZJ2Auz2wKQTMutylsQePio=
X-Google-Smtp-Source: APXvYqzZWCuouBLJoDCFNwMfl4WQOXcvAAo8yCI7VaHzLYE+ZWcQyXC3IyppnhmvHWlIvbbiNaRM0A==
X-Received: by 2002:a9d:454b:: with SMTP id p11mr21555386oti.111.1554246330515; 
 Tue, 02 Apr 2019 16:05:30 -0700 (PDT)
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com.
 [209.85.167.174])
 by smtp.gmail.com with ESMTPSA id a131sm6031023oif.23.2019.04.02.16.05.29
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 02 Apr 2019 16:05:30 -0700 (PDT)
Received: by mail-oi1-f174.google.com with SMTP id i21so11957043oib.11
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Apr 2019 16:05:29 -0700 (PDT)
X-Received: by 2002:aca:d984:: with SMTP id
 q126mr12607185oig.108.1554246329538; 
 Tue, 02 Apr 2019 16:05:29 -0700 (PDT)
MIME-Version: 1.0
References: <1551132245-6089-1-git-send-email-vabhav.sharma@nxp.com>
 <1551132245-6089-3-git-send-email-vabhav.sharma@nxp.com>
In-Reply-To: <1551132245-6089-3-git-send-email-vabhav.sharma@nxp.com>
From: Li Yang <leoyang.li@nxp.com>
Date: Tue, 2 Apr 2019 18:05:18 -0500
X-Gmail-Original-Message-ID: <CADRPPNTcY6fMJZDmsWzPzkn1hMzsoJh15-Gchepg_vJLxL=zcw@mail.gmail.com>
Message-ID: <CADRPPNTcY6fMJZDmsWzPzkn1hMzsoJh15-Gchepg_vJLxL=zcw@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] soc/fsl/guts: Add definition for LX2160A
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 "linux-kernel-owner@vger.kernel.org" <linux-kernel-owner@vger.kernel.org>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
 "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
 Yinbo Zhu <yinbo.zhu@nxp.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "arnd@arndb.de" <arnd@arndb.de>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "oss@buserror.net" <oss@buserror.net>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "sboyd@kernel.org" <sboyd@kernel.org>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Feb 26, 2019 at 4:12 AM Vabhav Sharma <vabhav.sharma@nxp.com> wrote:
>
> Adding compatible string "lx2160a-dcfg" to
> initialize guts driver for lx2160 and SoC die
> attribute definition for LX2160A


Applied to branch next.  Thanks.

Regards,
Leo
>
> Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
> Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
> Acked-by: Li Yang <leoyang.li@nxp.com>
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
