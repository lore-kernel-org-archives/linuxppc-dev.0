Return-Path: <SRS0=ejpM=RS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A3FC43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 09:09:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 870242184C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 09:09:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hNFMk+gL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 870242184C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44LKXQ2NfBzDqRy
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 20:09:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::444; helo=mail-pf1-x444.google.com;
 envelope-from=andy.shevchenko@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="hNFMk+gL"; 
 dkim-atps=neutral
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44LKVm3Xn3zDqRc
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2019 20:08:16 +1100 (AEDT)
Received: by mail-pf1-x444.google.com with SMTP id j5so5906871pfa.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2019 02:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=FQuWJiaahoVGruZwKY+4GHvBiDxUpo5ZETYkLiKhcXY=;
 b=hNFMk+gLWKwV7otyRME333Rh0w4aXpbdIli9zhjpDTnxgPt6aHIoYS8YtLGgvrDHc3
 DYQD7mjl+MRE11GWoHQws0xx4vQhLH6N/pZuRHNnWZWE8yf+E3CQL0PF7XUJ9PHaDW1m
 nijqSt6w4U3rGkqWyVRK+cM2qa/n9Xx9D35w3453EXaEEKRD1rCC6Is/oMkaFcVtYVOd
 RxZGP6hGuzNJAlsCoKgpkr5dtEIQAQ05mZYj96g87+wyHcM2mVCWdvJmoLWPA0Rp5glh
 C0A7O/mVBb8t2sKmekMaAKswAWq492zzoHCzZf8XuE6/M2EwKGABpJPzXgJUOu7vUxU2
 Ex9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FQuWJiaahoVGruZwKY+4GHvBiDxUpo5ZETYkLiKhcXY=;
 b=gWkObnkXderKxqmufgGFJGcfo0uMWq90AuaFkV0K9CyD3VEGYBU+FPkoYGMGmoQIMj
 kd4V4ALWeoJ2m0xkotITjtgpulqmzhlzHFnZqWeRt0iNrmK0UnhNLCS568q1EuPHmlPN
 pzdJxLuoXO69ZIoTOjnBNA6W9kGx+9TZBSnLTnBGPu+FaFOJTBCAA6Ci/ewAqSmKY5Pd
 kwkPwIC3bbmeE3gEOWXPf8Ks+GpDKLuAop7qsmdpu4ZHZf+2GTq+7qzyUIxMoMipCS6q
 6aKbiWLrt6U1NaARqA8dicz5/cgzhcpPOUL5McmJScWrih10rKis491u26//Cm9CpgGE
 kiYg==
X-Gm-Message-State: APjAAAXcztNLboAq/UIkNJ8D6Z4v2YOOpZPRG9uoMsszlAhkGl9gl4vT
 dvGvLDxu5glAPeFD+FkMSe95XfkGF/v5hPHP5iw=
X-Google-Smtp-Source: APXvYqyqmh4mImfByZPHBrLJaiK+jU2dsJ9f8DkNpWlgA9COO6KNpGptzJ78do0+5C9IVfr8HhX+40bnccX+xKcIde0=
X-Received: by 2002:aa7:930b:: with SMTP id 11mr2926855pfj.49.1552640892802;
 Fri, 15 Mar 2019 02:08:12 -0700 (PDT)
MIME-Version: 1.0
References: <1552602855-26086-1-git-send-email-info@metux.net>
 <1552602855-26086-46-git-send-email-info@metux.net>
In-Reply-To: <1552602855-26086-46-git-send-email-info@metux.net>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 15 Mar 2019 11:08:01 +0200
Message-ID: <CAHp75Vf1F_WQxNRiya=aTqFTEGWDVrD9JTr1VB4pOW0RayDmoA@mail.gmail.com>
Subject: Re: [PATCH v2 45/45] drivers: tty: serial: mux: use devm_* functions
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

On Fri, Mar 15, 2019 at 12:37 AM Enrico Weigelt, metux IT consult
<info@metux.net> wrote:
>
> Use the safer devm versions of memory mapping functions.

If you are going to use devm_*_free(), what's the point to have this
change from the beginning?

P.S. Disregard that this is untested series...

> --- a/drivers/tty/serial/mux.c
> +++ b/drivers/tty/serial/mux.c
> @@ -456,8 +456,9 @@ static int __init mux_probe(struct parisc_device *dev)
>         printk(KERN_INFO "Serial mux driver (%d ports) Revision: 0.6\n", port_count);
>
>         dev_set_drvdata(&dev->dev, (void *)(long)port_count);
> -       request_mem_region(dev->hpa.start + MUX_OFFSET,
> -                           port_count * MUX_LINE_OFFSET, "Mux");

> +       devm_request_mem_region(&dev->dev,
> +                               dev->hpa.start + MUX_OFFSET,
> +                               port_count * MUX_LINE_OFFSET, "Mux");

...and on top of this where is error checking?

>
>         if(!port_cnt) {
>                 mux_driver.cons = MUX_CONSOLE;
> @@ -474,7 +475,9 @@ static int __init mux_probe(struct parisc_device *dev)
>                 port->iobase    = 0;
>                 port->mapbase   = dev->hpa.start + MUX_OFFSET +
>                                                 (i * MUX_LINE_OFFSET);
> -               port->membase   = ioremap_nocache(port->mapbase, MUX_LINE_OFFSET);
> +               port->membase   = devm_ioremap_nocache(port->dev,
> +                                                      port->mapbase,
> +                                                      MUX_LINE_OFFSET);
>                 port->iotype    = UPIO_MEM;
>                 port->type      = PORT_MUX;
>                 port->irq       = 0;
> @@ -517,10 +520,12 @@ static int __exit mux_remove(struct parisc_device *dev)
>
>                 uart_remove_one_port(&mux_driver, port);
>                 if(port->membase)
> -                       iounmap(port->membase);
> +                       devm_iounmap(port->dev, port->membase);
>         }
>
> -       release_mem_region(dev->hpa.start + MUX_OFFSET, port_count * MUX_LINE_OFFSET);
> +       devm_release_mem_region(&dev->dev,
> +                               dev->hpa.start + MUX_OFFSET,
> +                               port_count * MUX_LINE_OFFSET);
>         return 0;
>  }


-- 
With Best Regards,
Andy Shevchenko
