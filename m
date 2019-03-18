Return-Path: <SRS0=3pJc=RV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D76C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Mar 2019 07:47:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE01120828
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Mar 2019 07:47:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="2/dCYSvN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE01120828
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44N7Yp3JLzzDqKt
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Mar 2019 18:47:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=socionext.com
 (client-ip=210.131.2.82; helo=conssluserg-03.nifty.com;
 envelope-from=yamada.masahiro@socionext.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nifty.com header.i=@nifty.com header.b="2/dCYSvN"; 
 dkim-atps=neutral
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com
 [210.131.2.82])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44N7X10R3vzDqDG
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Mar 2019 18:45:35 +1100 (AEDT)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com
 [209.85.217.43]) (authenticated)
 by conssluserg-03.nifty.com with ESMTP id x2I7j37r001761
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Mar 2019 16:45:03 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com x2I7j37r001761
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1552895104;
 bh=3ix53cwSg7wpTPsOZzwByaZewljMUWKcbgwMN//A5Q4=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=2/dCYSvNbG8BcJy5jWvlnRIDp3UI6fkUf+TZGQWfUSB0hxFfy6qAwdbVQQQk9tU7j
 fc/h19uzr/tLU/+0AypOqvvAvAyS1qCUMnA+gqXczR3z2M2bpxTHMRAujbkUtjbRcN
 5cDunN2XFJuSchtjq9BADODw0CbUleroYuZuGL/+YI5NCX8TbKxZG8+FB0OaQ0QBKw
 LOVTiwBswPREHMsU6HyAE5H87EFgW8FXfRdn5GRUlU/w3mRuu9WUgzZJ5PONaoGn2c
 W5xyi99VyO5IfhzRiipRULjnNQNdNEVVw0of/hzU39JB0TsIk+SdLV9k/Vn+Iu8FJs
 8N3xLn5TXpkVw==
X-Nifty-SrcIP: [209.85.217.43]
Received: by mail-vs1-f43.google.com with SMTP id z25so7562980vsk.8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Mar 2019 00:45:03 -0700 (PDT)
X-Gm-Message-State: APjAAAVSFwFcwsmoXPcvb6VNhfkKJzFH/BkI4NjHZPtUY+yKEvgmk0Gz
 yZbDmtU5GLlRc/JMx3Gw9LvVHJuvWXGOTmRBsqE=
X-Google-Smtp-Source: APXvYqyNijpqNVoW+bWF9eEp2LsjyfAuO7SHhsoKO0R2rUk+XQQSybYzte9XvRxtwUk8OvStMi0b8nTnqgwbUoIR9Oo=
X-Received: by 2002:a67:7a43:: with SMTP id v64mr4107181vsc.54.1552895102473; 
 Mon, 18 Mar 2019 00:45:02 -0700 (PDT)
MIME-Version: 1.0
References: <1552602855-26086-1-git-send-email-info@metux.net>
 <1552602855-26086-8-git-send-email-info@metux.net>
In-Reply-To: <1552602855-26086-8-git-send-email-info@metux.net>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Mon, 18 Mar 2019 16:44:25 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT6p41J+voYdrOtPkiq92sRDNv6nbrBdVKsWZYGENxsWw@mail.gmail.com>
Message-ID: <CAK7LNAT6p41J+voYdrOtPkiq92sRDNv6nbrBdVKsWZYGENxsWw@mail.gmail.com>
Subject: Re: [PATCH v2 07/45] drivers: tty: serial: 8250_uniphier: use
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
Cc: linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 David Brown <david.brown@linaro.org>,
 "Maciej W. Rozycki" <macro@linux-mips.org>, jacmet@sunsite.dk,
 Fabio Estevam <festevam@gmail.com>, Stefan Wahren <stefan.wahren@i2se.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Broadcom Kernel Feedback List <bcm-kernel-feedback-list@broadcom.com>,
 linux-imx@nxp.com, linux-serial@vger.kernel.org,
 =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Andy Gross <andy.gross@linaro.org>, Tobias Klauser <tklauser@distanz.ch>,
 Ray Jui <rjui@broadcom.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Sylvain Lemieux <slemieux.tyco@gmail.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Vladimir Zapolskiy <vz@mleia.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Barry Song <baohua@kernel.org>, Scott Branden <sbranden@broadcom.com>,
 Eric Anholt <eric@anholt.net>, Richard Genoud <richard.genoud@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Mar 15, 2019 at 7:35 AM Enrico Weigelt, metux IT consult
<info@metux.net> wrote:
>
> Instead of fetching out data from a struct resource for passing
> it to devm_ioremap(), directly use devm_ioremap_resource()
>
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
> ---


NACK.


This patch would break my driver.

Probably, all the 8250* drivers would be broken in the same way.


For 8250 drivers, request_mem_region() is called
from 8250_port.c


Let's not touch around the code you do not
understand how it works.


Thanks.

Masahiro Yamada



>  drivers/tty/serial/8250/8250_uniphier.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/8250/8250_uniphier.c b/drivers/tty/serial/8250/8250_uniphier.c
> index 164ba13..9c1244e 100644
> --- a/drivers/tty/serial/8250/8250_uniphier.c
> +++ b/drivers/tty/serial/8250/8250_uniphier.c
> @@ -171,7 +171,7 @@ static int uniphier_uart_probe(struct platform_device *pdev)
>                 return -EINVAL;
>         }
>
> -       membase = devm_ioremap(dev, regs->start, resource_size(regs));
> +       membase = devm_ioremap_resource(dev, regs);
>         if (!membase)
>                 return -ENOMEM;
>
> --
> 1.9.1
>
