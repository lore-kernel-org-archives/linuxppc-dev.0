Return-Path: <SRS0=/OnI=RO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E641AC43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Mar 2019 11:24:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 284DF206BA
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Mar 2019 11:24:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=essensium-com.20150623.gappssmtp.com header.i=@essensium-com.20150623.gappssmtp.com header.b="Hww2FaCD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 284DF206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=essensium.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Hwjj012yzDqGB
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Mar 2019 22:24:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=essensium.com
 (client-ip=2607:f8b0:4864:20::c42; helo=mail-yw1-xc42.google.com;
 envelope-from=patrick.havelange@essensium.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=essensium.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=essensium-com.20150623.gappssmtp.com
 header.i=@essensium-com.20150623.gappssmtp.com header.b="Hww2FaCD"; 
 dkim-atps=neutral
Received: from mail-yw1-xc42.google.com (mail-yw1-xc42.google.com
 [IPv6:2607:f8b0:4864:20::c42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44HwgY4S7RzDqDT
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Mar 2019 22:22:30 +1100 (AEDT)
Received: by mail-yw1-xc42.google.com with SMTP id x129so2549884ywc.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Mar 2019 04:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=essensium-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=EJcU2Bab04hznGrdFV1DSsCxIpb4sAD6RZmk3PYCkaE=;
 b=Hww2FaCDAoeODwd+DJyT0zRFkn6zQIp7+8WVBujK5ve1F1142fTV4d7CPSXehnBTYg
 uNK7UT7Qjhfk33FQx5FBvLndQcaFgEfaNr6pHCku8hyLxDGa5xVU9T0ADzUGYyfaSQnf
 DX1LIcv3foHV0eRhLTt1cWKrHwqJvn/b2dSXk96X0btn0qD2oZ6S0lDMX6sXDHQDUMWO
 Ff/ABjfcwdb2uncueHYx7+u676OFNC3Y5hor/cLfhe+10SbNNZaZmFdLt8BGYEj4YgCo
 L0PBNhpiCsuBh8lij3RCOv6hIG2wWlqNT8KeMg2MZzNMZ2Sjlix1c4rDmjqsoex+EmsE
 2n2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EJcU2Bab04hznGrdFV1DSsCxIpb4sAD6RZmk3PYCkaE=;
 b=sFaKtOu3GcA8YoGt3O5v7C+pBLFeMfGaM6CTAkCou6hyjsx07eclagS/UkEQJuRlG/
 eb0SrSMJYbFI+NFbnRHsOJc/OHA75W1pQ9vGmmV8/CVkxshcx3yrm6HwOFlbeQTvipPi
 XLNwg+rpwqnn0Bm3VB7s99Y4PSv/eWsH8fpXr+pE+iwpjKQlHeUhLIS5ArS2qWcJthZ+
 ektD5PXW+tqQq3qXXAuVvHR9/ZQrsG1LPOsb2z81/kpS3+eq1nO81XNAUFACTZUwPN3y
 GQFS7chyx0KfS+F1Xp3eS3qSZBUbzoFY+n4BHBuYEE6GOy6NyR1F6WACJhoVXAlFRmie
 KS1Q==
X-Gm-Message-State: APjAAAW28IImt2ShAYpW7aRVlzZkveM1Qm6F5bDYeIZzwJTQF1fj3B0R
 Gjxe4uwOBTOgH7gCaejPk73bWnZEidSkhv2UYeBlNw==
X-Google-Smtp-Source: APXvYqyQmORXF22uMshydHEj+pYkbrAm/SsQvIzYbzybVjIXKP76ybbG4dPvpUijdPpIkGIu9DP4czn0yPOKo9YBn9s=
X-Received: by 2002:a25:3ca:: with SMTP id 193mr26437201ybd.498.1552303347474; 
 Mon, 11 Mar 2019 04:22:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190306111208.7454-1-patrick.havelange@essensium.com>
 <20190306111208.7454-6-patrick.havelange@essensium.com>
 <20190307113147.GA7851@icarus>
In-Reply-To: <20190307113147.GA7851@icarus>
From: Patrick Havelange <patrick.havelange@essensium.com>
Date: Mon, 11 Mar 2019 12:22:16 +0100
Message-ID: <CAKKE0ZHtFk=XvBLbUzZbdqjh-m5TewnH+P__=d=Yio8TinRFNQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] counter: add FlexTimer Module Quadrature decoder
 counter driver
To: William Breathitt Gray <vilhelm.gray@gmail.com>
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Jonathan Cameron <jic23@kernel.org>, linux-pwm@vger.kernel.org,
 linux-iio@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-kernel@vger.kernel.org,
 Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 linux-arm-kernel@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>,
 Shawn Guo <shawnguo@kernel.org>, Esben Haabendal <esben@haabendal.dk>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Mar 7, 2019 at 12:32 PM William Breathitt Gray
<vilhelm.gray@gmail.com> wrote:
> > +/*
> > + * take mutex
> > + * call ftm_clear_write_protection
> > + * update settings
> > + * call ftm_set_write_protection
> > + * release mutex
> > + */
>
> Jonathan mentioned it before in the previous review, and I think I agree
> too, that this comment block is superfluous: the context of this code is
> simple enough that the function call order is naturally obvious (i.e.
> write protection must be cleared before settings are modified).
>
> The only important thing to mention here is that the mutex must be held
> before the write protection state is modified so a comment along the
> following lines should suffice:
>
> /* hold mutex before modifying write protection state */

I think that keeping the more verbose comments is better. You directly see
what operations are needed, and is a good reminder, especially if you
are not familiar with the driver.
I'll use your comment on the next version if you insist (see below for
why new versoion).

> > +static void ftm_quaddec_disable(struct ftm_quaddec *ftm)
> > +{
> > +     ftm_write(ftm, FTM_MODE, 0);
> > +}
>
> The ftm_quaddec_disable function is only used for cleanup when the
> driver is being removed. Is disabling the FTM counter on removal
> actually something we need to do?

It might provide some power-saving, so I would keep that function.

>
> While it's true that the register will keep updating, since the driver
> is no longer loaded, we don't care about that register value. Once we
> take control of the hardware again (by reloading our driver or via a new
> one), we reinitialize the counter and set the count value back to 0
> anyway -- so whatever value the register had no longer matters.
>
Indeed the previous values at start do not matter. It's there just to
shut down the device properly.
This discussion made me verify again the specs and in its current form
the disable doesn't even work at all :
 - That register should be written with write protection disabled (duh!)
 - It doesn't even stop the FTM from running, the clock must be
disabled for that.

So I'll probably provide a fix for that (in some days/weeks).

> > +
> > +enum ftm_quaddec_count_function {
> > +     FTM_QUADDEC_COUNT_ENCODER_MODE_1,
> > +};
>
> The FlexTimer Module supports more than just a quadrature counter mode
> doesn't it?
>
> We should keep this initial patch simple since we are still introducing
> the Counter subsystem, but it'll be nice to add support in the future
> for the other counter modes such as single-edge capture.

yes it provides more features, those are in a backlog ;). I would
prefer if this simple version(I mean, with the disable/shutdown fixed)
of the driver could be merged already before extending support.

>
> > +
> > +static struct counter_signal ftm_quaddec_signals[] = {
> > +     {
> > +             .id = 0,
> > +             .name = "Channel 1 Quadrature A"
> > +     },
> > +     {
> > +             .id = 1,
> > +             .name = "Channel 1 Quadrature B"
> > +     }
> > +};
>
> If possible, these names should match the FTM datasheet naming
> convention. The reason is to make it easier for users to match the
> input signals described in the datasheet with the Signal data provided
> by the Generic Counter interface.
>
> I think the FTM datasheet describes these signals as "Phase A" and
> "Phase B", so perhaps "Channel 1 Phase A" and "Channel 1 Phase B" may be
> more appropriate names in this case.

I'll verify those,

> > +static int ftm_quaddec_remove(struct platform_device *pdev)
> > +{
> > +     struct ftm_quaddec *ftm = platform_get_drvdata(pdev);
> > +
> > +     counter_unregister(&ftm->counter);
> > +
> > +     ftm_quaddec_disable(ftm);
> > +
> > +     return 0;
> > +}
>
> If the ftm_quaddec_disable is not necessary, then we can eliminate the
> ftm_quaddec_remove function as well by replacing the counter_register
> call with a devm_counter_register call.

yes, but as stated before, I would keep it for potential energy saving.

Thanks for your feedback :)
