Return-Path: <SRS0=xaUg=D5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B946C4363A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Oct 2020 07:28:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BFF6223C7
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Oct 2020 07:28:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BFF6223C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CGzVG1SBQzDqc5
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Oct 2020 18:28:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=209.85.210.67; helo=mail-ot1-f67.google.com;
 envelope-from=geert.uytterhoeven@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux-m68k.org
Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com
 [209.85.210.67])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CGzSH1QjbzDqN2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Oct 2020 18:26:19 +1100 (AEDT)
Received: by mail-ot1-f67.google.com with SMTP id f37so629360otf.12
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Oct 2020 00:26:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3Wxh2epYIQKmtNhH8kprT0IWQ1xSVOnzFhZ8V7tLn1Q=;
 b=i8SRGZnLDkmUd2yic6TK+CZxUgzi9czr2Usl9+mYDU6aBEpChd7EepLcoEooinEsQR
 hQooEQjJ0SOQNZAt8B5A6uPv1CCahwrxWpSBBqF8wpXX1/oGa+qyDlPNGGxZf0zuGLVv
 wHZ3xIreh5yHetIPz7Gcstv+W3p+P6tNbET8vCgBljHN8dsvAHIBFBrYv06vcRzUbdbZ
 sTJ6g4GMcFrRLVtsqR1tbWga5rhvwtIGTGifCYT8c7rHOdjEg026sbzNj7R4pDp+2sK0
 1NSJkfP8cCoplnWSq/cHYnd6Ftkbl71W8081ymlnOjd8do3rR9P8m2TbaVzO1k6Xn9qd
 acow==
X-Gm-Message-State: AOAM530YWdg5SH4yhN8aGGqy/eneX1+4pp+qoMI/t4UdjUTpxpHiWXm4
 CPzukeEZ9LW9WbIYn9q2o5+K1L4Xc0ZSkQkqNKM=
X-Google-Smtp-Source: ABdhPJxGwfErK94xEQ3A0uDcFKrh7oRH1svDTCHCvVb/UVtVDzV0FiL4WgSrbdWmiHb1vwP4iHuXwNlKlysGBU3e9MY=
X-Received: by 2002:a9d:3b76:: with SMTP id z109mr1009002otb.250.1603351576916; 
 Thu, 22 Oct 2020 00:26:16 -0700 (PDT)
MIME-Version: 1.0
References: <20201020162303.1730562-1-laurent@vivier.eu>
 <20201020162844.GA865546@kroah.com>
 <468bbbef-4745-3b16-b6f4-30b46ebcdc33@vivier.eu>
 <20201020173745.GA882703@kroah.com>
 <387fd2aa-b181-c41f-0581-0a7e79a44e41@vivier.eu>
 <20201020183246.GA912431@kroah.com>
 <b52e7fde-8874-3c53-ca13-7709656b69fb@vivier.eu>
 <20201020224446.GA15066@allandria.com>
 <alpine.LNX.2.23.453.2010211038390.6@nippy.intranet>
 <311d17ed-75fa-a7fe-6c70-177a6eec4519@vivier.eu>
 <alpine.LNX.2.23.453.2010221347000.6@nippy.intranet>
In-Reply-To: <alpine.LNX.2.23.453.2010221347000.6@nippy.intranet>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 22 Oct 2020 09:26:05 +0200
Message-ID: <CAMuHMdVbo2C1yZ5E_A3L8J1zZigO8i8m5AFUTn9SjbY1sx16kA@mail.gmail.com>
Subject: Re: [PATCH] serial: pmac_zilog: don't init if zilog is not available
To: Finn Thain <fthain@telegraphics.com.au>
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
Cc: Greg KH <gregkh@linuxfoundation.org>, Laurent Vivier <laurent@vivier.eu>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 Paul Mackerras <paulus@samba.org>,
 "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
 Brad Boyer <brad@allandria.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Joshua Thompson <funaho@jurai.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Finn,

On Thu, Oct 22, 2020 at 5:23 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> The patch below seems to fix the problem for me. Does it work on your
> system(s)?

Thanks for your patch!

> --- a/arch/m68k/mac/config.c
> +++ b/arch/m68k/mac/config.c
> @@ -776,16 +776,12 @@ static struct resource scc_b_rsrcs[] = {
>  struct platform_device scc_a_pdev = {
>         .name           = "scc",
>         .id             = 0,
> -       .num_resources  = ARRAY_SIZE(scc_a_rsrcs),
> -       .resource       = scc_a_rsrcs,
>  };
>  EXPORT_SYMBOL(scc_a_pdev);
>
>  struct platform_device scc_b_pdev = {
>         .name           = "scc",
>         .id             = 1,
> -       .num_resources  = ARRAY_SIZE(scc_b_rsrcs),
> -       .resource       = scc_b_rsrcs,
>  };
>  EXPORT_SYMBOL(scc_b_pdev);
>
> @@ -812,10 +808,15 @@ static void __init mac_identify(void)
>
>         /* Set up serial port resources for the console initcall. */
>
> -       scc_a_rsrcs[0].start = (resource_size_t) mac_bi_data.sccbase + 2;
> -       scc_a_rsrcs[0].end   = scc_a_rsrcs[0].start;
> -       scc_b_rsrcs[0].start = (resource_size_t) mac_bi_data.sccbase;
> -       scc_b_rsrcs[0].end   = scc_b_rsrcs[0].start;
> +       scc_a_rsrcs[0].start     = (resource_size_t)mac_bi_data.sccbase + 2;
> +       scc_a_rsrcs[0].end       = scc_a_rsrcs[0].start;
> +       scc_a_pdev.num_resources = ARRAY_SIZE(scc_a_rsrcs);
> +       scc_a_pdev.resource      = scc_a_rsrcs;
> +
> +       scc_b_rsrcs[0].start     = (resource_size_t)mac_bi_data.sccbase;
> +       scc_b_rsrcs[0].end       = scc_b_rsrcs[0].start;
> +       scc_b_pdev.num_resources = ARRAY_SIZE(scc_b_rsrcs);
> +       scc_b_pdev.resource      = scc_b_rsrcs;

I can't say I'm a fan of this...

>
>         switch (macintosh_config->scc_type) {
>         case MAC_SCC_PSC:
> diff --git a/drivers/tty/serial/pmac_zilog.c b/drivers/tty/serial/pmac_zilog.c
> index 96e7aa479961..95abdb305d67 100644
> --- a/drivers/tty/serial/pmac_zilog.c
> +++ b/drivers/tty/serial/pmac_zilog.c
> @@ -1697,18 +1697,17 @@ extern struct platform_device scc_a_pdev, scc_b_pdev;

The real issue is this "extern struct platform_device scc_a_pdev, scc_b_pdev",
circumventing the driver framework.

Can we get rid of that?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
