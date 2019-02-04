Return-Path: <SRS0=Z4Cu=QL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FFF8C282C4
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 21:01:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EC1A20823
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 21:01:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EC1A20823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43tgB16jXMzDqLS
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 08:01:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.210.68; helo=mail-ot1-f68.google.com;
 envelope-from=pku.leo@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=nxp.com
Received: from mail-ot1-f68.google.com (mail-ot1-f68.google.com
 [209.85.210.68])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43tg831z6gzDqL2
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Feb 2019 08:00:02 +1100 (AEDT)
Received: by mail-ot1-f68.google.com with SMTP id e12so2245940otl.5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 Feb 2019 13:00:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8t/eRETEyRCUgiUcijbzoazp4Z0jlyKbgONQXdnpznM=;
 b=OWo5RkS9AzoCV/U99+CA/2gLlRUhmRheCf0yrOEzbenoecvei3aMCKluUcu9rbdboK
 BRS0cCyANeN4hp6GQJgD3HBctuRsIO/cFfDXA8g6P/RVm273mO3Y1GRv3kCQ9IJBuy69
 l18YD4YlUrsrVqflvq9nUJq/pTqUR6FIeRblOawfCG9rD9A5WDz6Qazba93vvbCZ98zY
 c8SvI8SKYjoPy0wYnsBzL0AUU0FwDLPoDsfRukiHUtVv2l8DchDvIQUjxdCLqTanTTsI
 6/TwEvOaU4etJjX4pLfzIkEkAALfJHaEzahsOnteL2zV8ZrX2EVk40BBgxGwIUv/ob+V
 BZWA==
X-Gm-Message-State: AHQUAubp7hfMf6//EKigHJgdsaAh6iZ3ZcFKUcoTjGrALHnUB+J4P7lW
 R5ZVcTiV7hP4Qa8ay+rl0/SkpXnT
X-Google-Smtp-Source: AHgI3IbWAkt05WQOOlq2+02nOs7Q9lIiD5IlUbuzJK4fw/6nxKJ0YDFPDldqwkiG97876C+lDFx6ow==
X-Received: by 2002:a9d:23c2:: with SMTP id t60mr787665otb.48.1549314000752;
 Mon, 04 Feb 2019 13:00:00 -0800 (PST)
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com.
 [209.85.210.48])
 by smtp.gmail.com with ESMTPSA id f79sm3547485oib.28.2019.02.04.12.59.59
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 04 Feb 2019 13:00:00 -0800 (PST)
Received: by mail-ot1-f48.google.com with SMTP id a11so2178361otr.10
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 Feb 2019 12:59:59 -0800 (PST)
X-Received: by 2002:a9d:4549:: with SMTP id p9mr708724oti.51.1549313999678;
 Mon, 04 Feb 2019 12:59:59 -0800 (PST)
MIME-Version: 1.0
References: <20190204141005.GA915@kadam>
In-Reply-To: <20190204141005.GA915@kadam>
From: Li Yang <leoyang.li@nxp.com>
Date: Mon, 4 Feb 2019 14:59:48 -0600
X-Gmail-Original-Message-ID: <CADRPPNTM2_Ds7-BVbKWf87m+vMjkmT6XQQgKgzmWLn3JvUsX+Q@mail.gmail.com>
Message-ID: <CADRPPNTM2_Ds7-BVbKWf87m+vMjkmT6XQQgKgzmWLn3JvUsX+Q@mail.gmail.com>
Subject: Re: [PATCH] soc: fsl: dpio: Use after free in dpaa2_dpio_remove()
To: Dan Carpenter <dan.carpenter@oracle.com>
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
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Roy Pledge <Roy.Pledge@nxp.com>, kernel-janitors@vger.kernel.org,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, Ioana Ciornei <ioana.ciornei@nxp.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Feb 4, 2019 at 8:12 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> The dpaa2_io_down(priv->io) call frees "priv->io" so I've shifted the
> code around a little bit to avoid the use after free.
>
> Fixes: 991e873223e9 ("soc: fsl: dpio: use a cpumask to identify which cpus are unused")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Applied.  Thanks.

> ---
>  drivers/soc/fsl/dpio/dpio-driver.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/soc/fsl/dpio/dpio-driver.c b/drivers/soc/fsl/dpio/dpio-driver.c
> index 2d4af32a0dec..a28799b62d53 100644
> --- a/drivers/soc/fsl/dpio/dpio-driver.c
> +++ b/drivers/soc/fsl/dpio/dpio-driver.c
> @@ -220,12 +220,12 @@ static int dpaa2_dpio_remove(struct fsl_mc_device *dpio_dev)
>
>         dev = &dpio_dev->dev;
>         priv = dev_get_drvdata(dev);
> +       cpu = dpaa2_io_get_cpu(priv->io);
>
>         dpaa2_io_down(priv->io);
>
>         dpio_teardown_irqs(dpio_dev);
>
> -       cpu = dpaa2_io_get_cpu(priv->io);
>         cpumask_set_cpu(cpu, cpus_unused_mask);
>
>         err = dpio_open(dpio_dev->mc_io, 0, dpio_dev->obj_desc.id,
> --
> 2.17.1
>
