Return-Path: <SRS0=ejpM=RS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEAD0C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 09:06:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B6782184C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 09:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dcxtl8g+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B6782184C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44LKSC1n9gzDqSM
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 20:06:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com;
 envelope-from=andy.shevchenko@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="dcxtl8g+"; 
 dkim-atps=neutral
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44LKQQ51RjzDqRc
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2019 20:04:27 +1100 (AEDT)
Received: by mail-pf1-x441.google.com with SMTP id n22so5894158pfa.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2019 02:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bPoiQV0RRGf1/dW+RIXf3iiaL38X7KkyBkK+7RIVa40=;
 b=dcxtl8g+lrfPLERPW4HkAAo8N0vEmh39tLrGJtUhBXWu1yTN/oHiNP/gu1J9l2QRHg
 CeNvzzJxXKSed/ixjcdJVT2jnPLJNRpmGs9g1GS5zHgOU+s10yiOx0XHI1g2lpiBAJv8
 iL5cQ83mjEMIUhL1urLzrkuhmSKWxQPJphy1Zap861LM3J0PKGfYf5oV7eTxP6An22Yq
 EzO7YMnqgUn9x5bu3/0/QjWjl6INn2s9JHXBcRWodNptc6d/8MzJ5vC+aIosk+qIWoif
 Oa4jLQHWPBkVjC0/07IFloUSUv4TgcpZqM4E2+9z3gXIWV6Dm/pLgPnSSdbTo9cCxlnu
 VKUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bPoiQV0RRGf1/dW+RIXf3iiaL38X7KkyBkK+7RIVa40=;
 b=h5cJRMj/WUb/+MCt5ytjHCP3ShTSQoBYeQXdV7dAt2FueR4xsq2FGhyGBT1ahKicp3
 aIkAjFu8bMCFse9j9VNIBTlx498cH/OYnImTafuLRbWynFyWK4iCkF9IRHkLZGUXRF+T
 x/hNdCQllt7Hvdai9tdaQNy8rCZJ7ScKmGvGyjIVhgxbqexkUmrLhSXY1NWe1k8IqK4v
 qoy7DtWv8+tZrm2NvmgFnSxsaapeqpo3TCXtpo8zrVEKZl0Nk7Mwbox+n0YUiHhaGSh0
 KLLTDbnFu1TTEXzgRuEWOJ2Gxj+CTh1syzTMnA3UdJelVqr+tZEyKDcCR2fE5oR2EkMm
 qIHw==
X-Gm-Message-State: APjAAAVqcHfLXnRvD+GAin7Gs7JfOrAR+N50NY75NysS3Jhah5j7TVfv
 E1b33z23Dwq7Hf4TkIZQ12qxq9AQu43+0IuqlZw=
X-Google-Smtp-Source: APXvYqzOwi/B7Zkr+Lw3gDbTdHv03frg8D0ZKIR7kpZxhfs335MCtKi3ngN7V8nVoqfXP8mfpPgACfQGguUGbeJR9IE=
X-Received: by 2002:a17:902:7289:: with SMTP id
 d9mr3048159pll.314.1552640664120; 
 Fri, 15 Mar 2019 02:04:24 -0700 (PDT)
MIME-Version: 1.0
References: <1552602855-26086-1-git-send-email-info@metux.net>
 <1552602855-26086-3-git-send-email-info@metux.net>
In-Reply-To: <1552602855-26086-3-git-send-email-info@metux.net>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 15 Mar 2019 11:04:12 +0200
Message-ID: <CAHp75VegzKNhH1Uza9gwQMOAEOdh57WTzsHUx7vPdVs7XvJROQ@mail.gmail.com>
Subject: Re: [PATCH v2 02/45] drivers: tty: serial: 8250_dw: use
 devm_ioremap_resource()
To: "Enrico Weigelt, metux IT consult" <info@metux.net>
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
Cc: linux-arm-msm@vger.kernel.org,
 Masahiro Yamada <yamada.masahiro@socionext.com>, macro@linux-mips.org,
 Peter Korsgaard <jacmet@sunsite.dk>, Fabio Estevam <festevam@gmail.com>,
 Stefan Wahren <stefan.wahren@i2se.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
 dl-linux-imx <linux-imx@nxp.com>,
 "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
 =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Andy Gross <andy.gross@linaro.org>, Tobias Klauser <tklauser@distanz.ch>,
 David Brown <david.brown@linaro.org>, Ray Jui <rjui@broadcom.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, slemieux.tyco@gmail.com,
 "open list:LINUX FOR POWERPC PA SEMI PWRFICIENT"
 <linuxppc-dev@lists.ozlabs.org>, Vladimir Zapolskiy <vz@mleia.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, baohua@kernel.org,
 Scott Branden <sbranden@broadcom.com>, Eric Anholt <eric@anholt.net>,
 Richard Genoud <richard.genoud@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Mar 15, 2019 at 12:41 AM Enrico Weigelt, metux IT consult
<info@metux.net> wrote:
>
> Instead of fetching out data from a struct resource for passing
> it to devm_ioremap(), directly use devm_ioremap_resource()

I don't see any advantage of this change.
See also below.

> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -526,7 +526,7 @@ static int dw8250_probe(struct platform_device *pdev)
>         p->set_ldisc    = dw8250_set_ldisc;
>         p->set_termios  = dw8250_set_termios;
>
> -       p->membase = devm_ioremap(dev, regs->start, resource_size(regs));
> +       p->membase = devm_ioremap_resource(dev, regs);
>         if (!p->membase)

And how did you test this? devm_ioremap_resource() returns error
pointer in case of error.

>                 return -ENOMEM;

-- 
With Best Regards,
Andy Shevchenko
