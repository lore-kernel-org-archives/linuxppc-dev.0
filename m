Return-Path: <SRS0=g46S=2F=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 666A2C43603
	for <linuxppc-dev@archiver.kernel.org>; Sun, 15 Dec 2019 12:02:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1888F2253D
	for <linuxppc-dev@archiver.kernel.org>; Sun, 15 Dec 2019 12:02:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OSen5Gcv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1888F2253D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47bNLz1SY7zDqC9
	for <linuxppc-dev@archiver.kernel.org>; Sun, 15 Dec 2019 23:02:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::d44;
 helo=mail-io1-xd44.google.com; envelope-from=tiny.windzz@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="OSen5Gcv"; 
 dkim-atps=neutral
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com
 [IPv6:2607:f8b0:4864:20::d44])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47bNJK1ht9zDq5t
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Dec 2019 23:00:17 +1100 (AEDT)
Received: by mail-io1-xd44.google.com with SMTP id x1so4080263iop.7
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Dec 2019 04:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=U32Ya4ZtyKRe0g31iyaOrg9bNIbVTfXKPEbGivDkS10=;
 b=OSen5Gcvcdj9lEzBZB15Tn6QiRTI9MWlO/rPN49bMq0K83mAgq18VHkzQ7zVlPrjML
 gszdUGt2eF1kyYhDFF+GP7FeP1RPEnPsfH7wY9I095RPAYClYjywGRCaSteDEqN+zK62
 IKehzG864B+NpPZLPI1yH3m0V9J02rnTKvgIZxkccK3VNzHuy++Doo+IV2cQKWeFpyGv
 sOw1S4YJdTl9C8RnFpAVjILHeJMichKHxPUSI98wDRt0UmqQkWCWFLtA7q2g+jukhVzx
 EloylsApJVNnAMvbYem3m+vszDWIyz4reg4yOYbOHfUjbut1/oBMn1uR67AGYca3deCP
 DSrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=U32Ya4ZtyKRe0g31iyaOrg9bNIbVTfXKPEbGivDkS10=;
 b=dRhd9nJQomz+L44+YeCGCqo3msDjGdy/nY661xv+HGCYj6fBiokpBkIrQB2p6reJrj
 2ym1aYdz+ANP6SBxHLnIsjh7l62+lnbp9j8uCnbHZ8/VNzs2RqCf/gcPQTOO9qqt33lj
 jfYt5B3ibDr09a1C2lAGhx1CqDoozuucyNZcppzCcFyFk84XGwo6RWmHEowLWGTlShh9
 wQ8Zvq4I/BghwppPGZPPBH/EUyUoDY1UXj6FCadwdzTG4usMJ09Y/IMQrAoLE6VoqZAF
 xw1RlmlBoooOEpf12FZPVDH2nQmN7rEI9eDNoSpMiRQEmlJm588jULu3dl0rtfQUHrnI
 s9mg==
X-Gm-Message-State: APjAAAUHFK8OCbO9Gp5fHifPXgxQcwzuyjecpxOF/xUU7dEGzFRn8H8K
 WEm/KFqHY293Uu8Auq1pI4Wl30piTnTcLG46qjc=
X-Google-Smtp-Source: APXvYqytWwvnLfUD+171nhXHDbJqlTikV21tQNc2dQdQlOI6X6lJ/eLQFLTNTro7mQyhFx4wzdvzbYn6q+tytdyDIA8=
X-Received: by 2002:a5d:9f05:: with SMTP id q5mr14678305iot.295.1576411213379; 
 Sun, 15 Dec 2019 04:00:13 -0800 (PST)
MIME-Version: 1.0
References: <20191214175447.25482-1-tiny.windzz@gmail.com>
 <20191214175447.25482-10-tiny.windzz@gmail.com>
 <20191215104824.658889d3@why>
In-Reply-To: <20191215104824.658889d3@why>
From: Frank Lee <tiny.windzz@gmail.com>
Date: Sun, 15 Dec 2019 20:00:01 +0800
Message-ID: <CAEExFWtgXt2pGM1fGfmxNdk_7S_53gnhN0-bProWA4-vOaNN3w@mail.gmail.com>
Subject: Re: [PATCH 10/10] soc: qcom: convert to devm_platform_ioremap_resource
To: Marc Zyngier <maz@kernel.org>
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
Cc: john@phrozen.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-samsung-soc@vger.kernel.org, khilman@baylibre.com, krzk@kernel.org,
 Chen-Yu Tsai <wens@csie.org>, agross@kernel.org, linux-arm-msm@vger.kernel.org,
 Maxime Ripard <mripard@kernel.org>, khalasa@piap.pl, ssantosh@kernel.org,
 Matthias Brugger <matthias.bgg@gmail.com>, linux-amlogic@lists.infradead.org,
 bjorn.andersson@linaro.org, Linux ARM <linux-arm-kernel@lists.infradead.org>,
 shawnguo@kernel.org, linux-mips@vger.kernel.org, leoyang.li@nxp.com,
 kgene@kernel.org, linux-mediatek@lists.infradead.org, jun.nie@linaro.org,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, Dec 15, 2019 at 6:48 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On Sat, 14 Dec 2019 17:54:47 +0000
> Yangtao Li <tiny.windzz@gmail.com> wrote:
>
> > Use devm_platform_ioremap_resource() to simplify code.
> >
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > ---
> >  drivers/soc/qcom/llcc-qcom.c    | 7 +------
> >  drivers/soc/qcom/qcom-geni-se.c | 4 +---
> >  drivers/soc/qcom/qcom_aoss.c    | 4 +---
> >  drivers/soc/qcom/qcom_gsbi.c    | 5 +----
> >  drivers/soc/qcom/spm.c          | 4 +---
> >  5 files changed, 5 insertions(+), 19 deletions(-)
> >
> > diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
> > index 429b5a60a1ba..99e19df76889 100644
> > --- a/drivers/soc/qcom/llcc-qcom.c
> > +++ b/drivers/soc/qcom/llcc-qcom.c
> > @@ -387,7 +387,6 @@ static int qcom_llcc_remove(struct platform_device *pdev)
> >  static struct regmap *qcom_llcc_init_mmio(struct platform_device *pdev,
> >               const char *name)
> >  {
> > -     struct resource *res;
> >       void __iomem *base;
> >       struct regmap_config llcc_regmap_config = {
> >               .reg_bits = 32,
> > @@ -396,11 +395,7 @@ static struct regmap *qcom_llcc_init_mmio(struct platform_device *pdev,
> >               .fast_io = true,
> >       };
> >
> > -     res = platform_get_resource_byname(pdev, IORESOURCE_MEM, name);
> > -     if (!res)
> > -             return ERR_PTR(-ENODEV);
> > -
> > -     base = devm_ioremap_resource(&pdev->dev, res);
> > +     base = devm_platform_ioremap_resource(pdev, 0);
>
> What guarantees do you have that entry 0 matches name?

Yeah, this place is wrong. I intruduce another helper.

https://lore.kernel.org/patchwork/patch/1165186/

Thx,
Yangtao


>
> I find these changes pointless: they don't add much to the readability
> or maintainability of the code, and instead introduce creative bugs.
>
>         M.
> --
> Jazz is not dead. It just smells funny...
