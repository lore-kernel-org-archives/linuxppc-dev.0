Return-Path: <SRS0=R24o=OB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7566C43441
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Nov 2018 00:45:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17F0B20821
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Nov 2018 00:45:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ml+T4EN0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17F0B20821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 430ghS1M3CzDrq9
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Nov 2018 11:45:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ml+T4EN0";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::143; helo=mail-it1-x143.google.com;
 envelope-from=tiny.windzz@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ml+T4EN0"; 
 dkim-atps=neutral
Received: from mail-it1-x143.google.com (mail-it1-x143.google.com
 [IPv6:2607:f8b0:4864:20::143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 430gdq1DnxzF3WZ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Nov 2018 11:42:54 +1100 (AEDT)
Received: by mail-it1-x143.google.com with SMTP id c9so11582917itj.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Nov 2018 16:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=76/Amvklb00NGf7+I4aPGPSZxEYvci+Q3+NpUryRK6w=;
 b=Ml+T4EN0TIhw3aGbo3fQLygEdJDABRTBVfZDXji1+/Ft2fXNOYCu0ug+2R/MdQUGUb
 vwvk3CSvda0YQutMvaYci9f7g7f2gzZbVjDdrM0s79l9Y5/UQy49J9VSIwLvPb8k1w2r
 xirGM0zYzY9iEU9oQ+TE9pJvSDCCSetu/6psjoWv9PF6y7SlYBHBJB5dm9yhr21HEcc/
 fDtpyqhLKlgqseBaYywIuBb1lifRLHwi8t0RXfOEtIemn4rMeeW6EX19C/603BydIJpF
 lZ+o+XOInHu/L5WUGIDhjhdPl8OgtOwNE3YA7ncpIM3KduGAhs8V0UfHpX7Hvei2XKCN
 Y1lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=76/Amvklb00NGf7+I4aPGPSZxEYvci+Q3+NpUryRK6w=;
 b=Z//yn6URYiqcHVXHPwk0G97Tc4TbxeWBwh/1mAQzBpkroW3YeIZJxYeHNCN8kQ83ej
 oH5w6a7WnIj+reYbs95Rum/oaZ+flDTQmfLYIifFACU8I1LZj8+/aYKwQ0aBzKYOay8G
 XYMEyfEhvdD8HVf6D+luQr6+e/LEKryPoHTtLLrZJR2R36DyQixov0rvbGvG0M1yHF2H
 ljCBGwUqDSYyseD2ddx0o/812h5wS+tw0qEEV2S4uH/5O6EWTsBT744K75TwuSQYhBFv
 RuR2/jMw7WZzUQ06MyOXcaD2Zyg+wkdDkVdp5CqEERp6Ord3fJLar5ptm3nHW4pfEa9e
 UXsw==
X-Gm-Message-State: AA+aEWbB77H+tthhnfzsCilv/OQ5gHnth5HHa/sAbkET5OEzjhK7NMuJ
 urqaFvFgsFbdcCjyI9rwDIYxQZYxGxQycXg0kzc=
X-Google-Smtp-Source: AFSGD/XbCrNB9zDSibHW09GUpuSCj7piaQrX1E6Dh1axH7o/YWk8bc/3XrQtAaXkMK+JYNbZ/VEZ9DB1GRHunJCdNIU=
X-Received: by 2002:a02:5184:: with SMTP id s126mr3274908jaa.12.1542847372999; 
 Wed, 21 Nov 2018 16:42:52 -0800 (PST)
MIME-Version: 1.0
References: <20181121123138.21870-1-tiny.windzz@gmail.com>
 <82ef58c4-1d18-9dd6-71ec-42f799370f33@gmail.com>
In-Reply-To: <82ef58c4-1d18-9dd6-71ec-42f799370f33@gmail.com>
From: Frank Lee <tiny.windzz@gmail.com>
Date: Thu, 22 Nov 2018 08:42:05 +0800
Message-ID: <CAEExFWsc8ong3rRi7dhhuB+6C2H3LnH98SWR7v_snMMV2qYViA@mail.gmail.com>
Subject: Re: [PATCH] leds: powernv: add of_node_put()
To: jacek.anaszewski@gmail.com
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
Cc: linux-kernel@vger.kernel.org, paulus@samba.org, pavel@ucw.cz,
 linuxppc-dev@lists.ozlabs.org, linux-leds@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Nov 22, 2018 at 4:45 AM Jacek Anaszewski
<jacek.anaszewski@gmail.com> wrote:
>
> Hi Yangtao,
>
> Thank you for the patch.
>
> On 11/21/2018 01:31 PM, Yangtao Li wrote:
> > of_find_node_by_path() acquires a reference to the node returned by
> > it and that reference needs to be dropped by its caller.bl_idle_init()
> > doesn't do that, so fix it.
>
> s/bl_idle_init/powernv_led_probe/
>
> I suppose that you adopted the commit message from a fix
> for drivers/cpuidle/cpuidle-big_little.c.
>
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > ---
> >  drivers/leds/leds-powernv.c | 12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/leds/leds-powernv.c b/drivers/leds/leds-powernv.c
> > index b1adbd70ce2e..0b1540029034 100644
> > --- a/drivers/leds/leds-powernv.c
> > +++ b/drivers/leds/leds-powernv.c
> > @@ -285,6 +285,7 @@ static int powernv_led_probe(struct platform_device *pdev)
> >       struct device_node *led_node;
> >       struct powernv_led_common *powernv_led_common;
> >       struct device *dev = &pdev->dev;
> > +     int rc;
> >
> >       led_node = of_find_node_by_path("/ibm,opal/leds");
> >       if (!led_node) {
> > @@ -295,15 +296,20 @@ static int powernv_led_probe(struct platform_device *pdev)
> >
> >       powernv_led_common = devm_kzalloc(dev, sizeof(*powernv_led_common),
> >                                         GFP_KERNEL);
> > -     if (!powernv_led_common)
> > -             return -ENOMEM;
> > +     if (!powernv_led_common){
>
> missing space:
>
> s/){/) {/
>
> > +             rc = -ENOMEM;
> > +             goto out;
> > +     }
> >
> >       mutex_init(&powernv_led_common->lock);
> >       powernv_led_common->max_led_type = cpu_to_be64(OPAL_SLOT_LED_TYPE_MAX);
> >
> >       platform_set_drvdata(pdev, powernv_led_common);
> >
> > -     return powernv_led_classdev(pdev, led_node, powernv_led_common);
> > +     rc = powernv_led_classdev(pdev, led_node, powernv_led_common);
> > +out:
> > +     of_node_put(led_node);
> > +     return rc;
> >  }
> >
> >  /* Platform driver remove */
> >
>
> I've fixed those trivial problems and applied the patch
> to the for-next branch of linux-leds.git.
>
> --
> Best regards,
> Jacek Anaszewski
Jacek,

Yeah,I forget to modify the changlog.

Thanks,
    Yangtao
