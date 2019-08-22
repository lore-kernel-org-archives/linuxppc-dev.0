Return-Path: <SRS0=ljjX=WS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43AD9C3A5A1
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Aug 2019 12:16:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 600A420870
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Aug 2019 12:16:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e+s77JT2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 600A420870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46Dk606sGSzDrQ1
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Aug 2019 22:16:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linaro.org
 (client-ip=2607:f8b0:4864:20::e42; helo=mail-vs1-xe42.google.com;
 envelope-from=ulf.hansson@linaro.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="e+s77JT2"; 
 dkim-atps=neutral
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com
 [IPv6:2607:f8b0:4864:20::e42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46Dk2w6X22zDrNk
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Aug 2019 22:13:43 +1000 (AEST)
Received: by mail-vs1-xe42.google.com with SMTP id q16so3685120vsm.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Aug 2019 05:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4Ly6KX3kvL/W0ycoaNLTVk5Ihkvoe8Wnu3biVwC7K5k=;
 b=e+s77JT2cpzLx6Bok8gRYEyL3sIJy4MY0tlRRujMgKNbw6Z8D3adtcuYtllumK+DjH
 LrHgjsL1mpImPi9hm6KbpBAAchu2bX0CfUzY6uYJjTeSuNqn6Wcgz2KcEnwVw6Pe/JpD
 oKBN8X226wmaOyQuFVPK5p8PY+SwbN9m5mTaOL+YUCPd9ztzxrq/fneELEak3mkQUbRD
 MYNbzBNBfg0IIdZfwMJqM9/zCu0TyPnJ89zkl32BKEuddVAN7XgJLendjEh+3sU1emMB
 Q9iajclIOnQww/YNvGzunL8wkFKWjd3INZO0vdCfiVEOCPZMpO7URRy4oOPu0Mi57523
 ZeVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4Ly6KX3kvL/W0ycoaNLTVk5Ihkvoe8Wnu3biVwC7K5k=;
 b=H4U6sYAVvLzLd5V0416u4EwuTVSDWW6iYa5hUiAumlve7sOwdC5MjCsRYak9DJWjaq
 hCmqMS6RY7bSjuPQchzwJear7t4dt/ePDIXEpFJKqdqG3+GFR5sMvqB1hYxe/dt6hERY
 EPxT7MKQK/1RZmzUTPNug9NINvcLZ9VJxUG2Sx4nOHWZqiotgkn2lLMNl1M15wZppmyU
 Clh49YrbfOhzJe6/+9qfyza9HBvljIy8qLxQiTdYnTJqNGIDNSrIAUtSR4oZJWSrmksz
 OC5Jfc8pGvPrRWc91VIzHO4RBEAeMB3Jp3rpcovGyD/mLGDoLnsdj6qYemHxcIiQXROx
 ZWVA==
X-Gm-Message-State: APjAAAXyGjv5Skcw1/TqWuXzCpPVqPlq4yknNkwk32r8Hy5kG2YD3E+Y
 LrVXkFfIJ50UnBYgpyApPIcQOYuQ2MveCqqrLN7B+A==
X-Google-Smtp-Source: APXvYqytHCOMHR5M9lts8SdpAxk1X76n5u7WLvfmxOXVJUEBRHaXV9qwemPTTdfSZATLeZEry7/4cv0gzsDJKxqcftg=
X-Received: by 2002:a67:61c7:: with SMTP id
 v190mr24652042vsb.165.1566476019397; 
 Thu, 22 Aug 2019 05:13:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190814072649.8237-1-yinbo.zhu@nxp.com>
 <20190814072649.8237-4-yinbo.zhu@nxp.com>
In-Reply-To: <20190814072649.8237-4-yinbo.zhu@nxp.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 22 Aug 2019 14:13:03 +0200
Message-ID: <CAPDyKFpwGGPAShEoXPK8Ksg5FPEVrbD3-HfeTSMACPsDC_V5FA@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] mmc: sdhci-of-esdhc: add erratum A011334 support
 in ls1028a 1.0 SoC
To: Yinbo Zhu <yinbo.zhu@nxp.com>
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
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Catalin Horghidan <catalin.horghidan@nxp.com>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 DTML <devicetree@vger.kernel.org>, Rajesh Bhagat <rajesh.bhagat@nxp.com>,
 Alison Wang <alison.wang@nxp.com>, Ashish Kumar <Ashish.Kumar@nxp.com>,
 Claudiu Manoil <claudiu.manoil@nxp.com>, Rob Herring <robh+dt@kernel.org>,
 Vabhav Sharma <vabhav.sharma@nxp.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Amit Jain <amit.jain_1@nxp.com>, Alex Marginean <alexandru.marginean@nxp.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Li Yang <leoyang.li@nxp.com>, Rajat Srivastava <rajat.srivastava@nxp.com>,
 Yangbo Lu <yangbo.lu@nxp.com>, Jiafei Pan <jiafei.pan@nxp.com>,
 linuxppc-dev@lists.ozlabs.org, Xiaobo Xie <xiaobo.xie@nxp.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 14 Aug 2019 at 09:24, Yinbo Zhu <yinbo.zhu@nxp.com> wrote:
>
> This patch is to add erratum A011334 support in ls1028a 1.0 SoC
>
> Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-of-esdhc.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index b16f7d440f78..eb2b290447fc 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -1006,6 +1006,7 @@ static struct soc_device_attribute soc_incorrect_hostver[] = {
>  static struct soc_device_attribute soc_fixup_sdhc_clkdivs[] = {
>         { .family = "QorIQ LX2160A", .revision = "1.0", },
>         { .family = "QorIQ LX2160A", .revision = "2.0", },
> +       { .family = "QorIQ LS1028A", .revision = "1.0", },
>         { },
>  };
>
> --
> 2.17.1
>
