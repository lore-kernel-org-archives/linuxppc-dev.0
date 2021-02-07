Return-Path: <SRS0=EWdz=HJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18CF6C433DB
	for <linuxppc-dev@archiver.kernel.org>; Sun,  7 Feb 2021 09:52:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED78664DDD
	for <linuxppc-dev@archiver.kernel.org>; Sun,  7 Feb 2021 09:52:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED78664DDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DYPbM69NNzDr6S
	for <linuxppc-dev@archiver.kernel.org>; Sun,  7 Feb 2021 20:52:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::731;
 helo=mail-qk1-x731.google.com; envelope-from=shengjiu.wang@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=PH/nShvu; dkim-atps=neutral
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DYPX31DFVzDvZT
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  7 Feb 2021 20:49:54 +1100 (AEDT)
Received: by mail-qk1-x731.google.com with SMTP id a19so11605619qka.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 07 Feb 2021 01:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=FYzO838l1olFuso01/LKL9EKMqYrX52CmTrPsMkBDNA=;
 b=PH/nShvusjxGG+pD98o6NOty7igDMLoVCNcNMmmjFvvckGRm0oVqX1c7mx4J+ayJWh
 PCIX7g4Xc+nZmsDqDERSkx7dzoHKAYcxNT61mIYdBwx1hNy5ilCwTdXXMmpzge2a7KDK
 /xi3ULiq5Msm+qvMpLhHXO57vX/3f1spJxrUgaN85rDrp1w1sEvYzsGlrcd6+YucJMIy
 xpjwb12qxSbsE5rw/WD7sQZxYc1mDD1QGoIma/VOnbQFQvTBcXaa5G0spS8BW5vttuJ0
 3jcB9pb5TAKYjnK2JM/uBfQzOfoWGRZxdExX+a70dnbh3NnbAcVXlKL9exdZ+2Bb8IVh
 24EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FYzO838l1olFuso01/LKL9EKMqYrX52CmTrPsMkBDNA=;
 b=l3Zhcs5Pqxg8GAyQA+Z1lAFUlaPy+0J8awRkRr5Kcaz0Z5T4F/9Rtq1QLbzJ+PJ4bN
 wDm8alZvtlJToPTRwWPzmJnbDnsXdZPMf4mV5q6fCwz0Axga1GNPKMCf/B9DWV1LJbfb
 EeJht/uQp1nSI2fR58P52usG0tspGUSImcBx51RIAxGlLGbihMNw6VMdPaKGYJ+2qBF0
 oTqhmo3jYkdAgwZxkDQyVJtfvqCu/sbD7xBgf2IcffeFDvLtLaAzHtIuNlOtpX6feUGj
 8BdBVoj7RIQ+7xW8i9DNre0QEueqMebZp38LGfBXhDhmwtWS4giOF9AmwMY712J02oTi
 EnxA==
X-Gm-Message-State: AOAM5308WcJR8kvh+/ukN1dlpmPSbIDYEPmD1YbqE4qoK/SzNxvqXV+m
 LrC499FX+3WpoFeNQod/gU4y4yZmuXpDA0L+ALM=
X-Google-Smtp-Source: ABdhPJwBFvr9P32/Q0z9GRaRw15XheT3/2z/Vbq8+UOXhCI06iB1wVa/pcAviEiXyvpKDJQ/NID21lMi+PuAC/mGLuk=
X-Received: by 2002:a05:620a:14a6:: with SMTP id
 x6mr11806815qkj.152.1612691392406; 
 Sun, 07 Feb 2021 01:49:52 -0800 (PST)
MIME-Version: 1.0
References: <1612508250-10586-1-git-send-email-shengjiu.wang@nxp.com>
 <1612508250-10586-5-git-send-email-shengjiu.wang@nxp.com>
 <20210205142516.GC4720@sirena.org.uk>
In-Reply-To: <20210205142516.GC4720@sirena.org.uk>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Sun, 7 Feb 2021 17:49:41 +0800
Message-ID: <CAA+D8APye40DiiYtQbsaM0X5vt4-4z+=YAvf-aSHxzvBk=aBfA@mail.gmail.com>
Subject: Re: [PATCH 4/7] ASoC: imx-audio-rpmsg: Add rpmsg_driver for audio
 channel
To: Mark Brown <broonie@kernel.org>
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
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, alsa-devel@alsa-project.org,
 Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Fabio Estevam <festevam@gmail.com>, Shengjiu Wang <shengjiu.wang@nxp.com>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Feb 5, 2021 at 10:27 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Fri, Feb 05, 2021 at 02:57:27PM +0800, Shengjiu Wang wrote:
>
> > +     /* TYPE C is notification from M core */
> > +     if (r_msg->header.type == MSG_TYPE_C) {
> > +             if (r_msg->header.cmd == TX_PERIOD_DONE) {
>
> > +             } else if (r_msg->header.cmd == RX_PERIOD_DONE) {
>
> A switch statement would be clearer and more extensible...
>
> > +     /* TYPE B is response msg */
> > +     if (r_msg->header.type == MSG_TYPE_B) {
> > +             memcpy(&info->r_msg, r_msg, sizeof(struct rpmsg_r_msg));
> > +             complete(&info->cmd_complete);
> > +     }
>
> ...and make this flow clearer for example.  Do we need to warn on
> unknown messages?

Thanks for reviewing. I will update them.

Best regards
wang shengjiu
