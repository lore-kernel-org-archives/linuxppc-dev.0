Return-Path: <SRS0=xrHL=SE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE15C4360F
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 23:03:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 439412084C
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 23:03:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 439412084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44YlBZ733YzDqRC
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 10:03:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.210.65; helo=mail-ot1-f65.google.com;
 envelope-from=pku.leo@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=nxp.com
Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com
 [209.85.210.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Yl8w6MHzzDqLg
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Apr 2019 10:02:24 +1100 (AEDT)
Received: by mail-ot1-f65.google.com with SMTP id 64so13596287otb.8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Apr 2019 16:02:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=J+8NiYOcnZ73+Jugzdmo9TuvkeqkJKvhy+4tC+s8oPg=;
 b=bQjyUOg9d+otoT+i7N4HvQXfrcOS4859Jg+XmujMnXUrywOc8POfWUV5lna8qt1QJ2
 brcFux1PzxKD3ISMY6+4cjeeh7g/4Fe0qVVP+Z7/xew2v95/DFbIZJla7lUrKfsxfBH/
 2z9Vx93inVucOWk+Pg/LwapElltvfoBZIEj93A+rNzcXUTRPdNyFUad7AHwxhjsAS1Dm
 /9b0EeapaSwZstd+348/RxgMiCr3s4RVYiFjO3poRnBuMq/zFJYx8RydvzYpxOHgGCc5
 5TjsYRJKOFf6Y/H3Ef8YbHepN0tEFGV6ydbnEKdtTha1N60ol5Qp2gVeQ+4+d+ATbPAF
 o31w==
X-Gm-Message-State: APjAAAWlwNV+oU7LGwHNDKYjGk7qlDDcx2x5em7pKHogdH7JL22lu7EN
 8nSLs03IKGbrNfVJLCTK8bGlqq6L
X-Google-Smtp-Source: APXvYqyFTxBOfoj2DNAitmS0q/YGRwomddZS1+cSxZsda1go/MyK+BiwxL/DVCnI1koY6K06Lz1mEQ==
X-Received: by 2002:a05:6830:190:: with SMTP id
 q16mr3004061ota.47.1554246140518; 
 Tue, 02 Apr 2019 16:02:20 -0700 (PDT)
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com.
 [209.85.210.53])
 by smtp.gmail.com with ESMTPSA id h3sm6273008otl.32.2019.04.02.16.02.19
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 02 Apr 2019 16:02:19 -0700 (PDT)
Received: by mail-ot1-f53.google.com with SMTP id j10so13747630otq.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Apr 2019 16:02:19 -0700 (PDT)
X-Received: by 2002:a05:6830:15:: with SMTP id
 c21mr6801000otp.182.1554246139608; 
 Tue, 02 Apr 2019 16:02:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190328141841.GN32590@kadam>
In-Reply-To: <20190328141841.GN32590@kadam>
From: Li Yang <leoyang.li@nxp.com>
Date: Tue, 2 Apr 2019 18:02:08 -0500
X-Gmail-Original-Message-ID: <CADRPPNS0XWqbkUwgpUy2Tkc6NvtZc9Yta=V9aw-WjzrY70JZ4Q@mail.gmail.com>
Message-ID: <CADRPPNS0XWqbkUwgpUy2Tkc6NvtZc9Yta=V9aw-WjzrY70JZ4Q@mail.gmail.com>
Subject: Re: [PATCH] soc/fsl/qe: Fix an error code in qe_pin_request()
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
 kernel-janitors@vger.kernel.org, Qiang Zhao <qiang.zhao@nxp.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Mar 28, 2019 at 9:21 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> We forgot to set "err" on this error path.
>
> Fixes: 1a2d397a6eb5 ("gpio/powerpc: Eliminate duplication of of_get_named_gpio_flags()")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Applied to fix branch.  Thanks.

Regards,
Leo
> ---
>  drivers/soc/fsl/qe/gpio.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/soc/fsl/qe/gpio.c b/drivers/soc/fsl/qe/gpio.c
> index 819bed0f5667..51b3a47b5a55 100644
> --- a/drivers/soc/fsl/qe/gpio.c
> +++ b/drivers/soc/fsl/qe/gpio.c
> @@ -179,8 +179,10 @@ struct qe_pin *qe_pin_request(struct device_node *np, int index)
>         if (err < 0)
>                 goto err0;
>         gc = gpio_to_chip(err);
> -       if (WARN_ON(!gc))
> +       if (WARN_ON(!gc)) {
> +               err = -ENODEV;
>                 goto err0;
> +       }
>
>         if (!of_device_is_compatible(gc->of_node, "fsl,mpc8323-qe-pario-bank")) {
>                 pr_debug("%s: tried to get a non-qe pin\n", __func__);
> --
> 2.17.1
>
