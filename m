Return-Path: <SRS0=mr1i=SM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E87C10F11
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 06:22:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F132420850
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 06:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q2FUBxvD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F132420850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44fDbK6DqTzDqMk
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 16:22:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::542; helo=mail-ed1-x542.google.com;
 envelope-from=daniel.baluta@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Q2FUBxvD"; 
 dkim-atps=neutral
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com
 [IPv6:2a00:1450:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44fDYV1N0szDq6J
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2019 16:20:45 +1000 (AEST)
Received: by mail-ed1-x542.google.com with SMTP id s39so945397edb.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Apr 2019 23:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pLvFkCAz7qQE0ZWMhNYvz2Jpk6Hrjze8FHnwwaGiTfA=;
 b=Q2FUBxvDI8bwYLAjzeeNN+xpAprDeVeYuxwRdp98MX7H3ifqP9qxwJOxJNsSfChMA1
 8s5qMZYwFRGcwRP8urW9LKdFYqL8KJpMRjitU3P50F5OO0pIsxl0dqdLA9fM5IzRCm9G
 w4ZLhsTlJ0+ryYP25WUiA0O3n9MvqvJAUG3E4VS3UP/FThmPs8swg7lmIr1WVqonK/Ik
 KFILGLockzNvsffHp2+ifQBSZxJDi4qIJBGQQapsJClQXu8XyzmPkYcN8nSuv+CYsDuD
 ti2fRkIi+85YGiLSu31yT/sCNcUu/B5DE+cMV9i2ejiMTwl/VlBd15k6rt9lcRnPHsrg
 lvCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pLvFkCAz7qQE0ZWMhNYvz2Jpk6Hrjze8FHnwwaGiTfA=;
 b=UIJfFwCOEGYdXWi0nULJ59kuSJGw0Gh26aOp9Pz9irq/As+U0jgeiJnkNmZxB+KYSD
 gK53ffOBxE/zWz+mdEFPy+IE0yCO9g35rSb2gpVwiwShVIqbbtnE8pV3230R/TKHhvBG
 gtOB0J4zMlDVvPLXxg8nIkSO/U2nqABQ6neTin11vvViNr7FvItonrM7EuWMOYPtN60h
 yi9XWbpkuhq3BDcq3745oMJbOPrmpOmZ0uUvMIrCaHvUi8vVWXcO0UCAY2PieNXT+6hT
 DqNPJMKK7xrhqek/mvywA9s7MoOA8tZcdXorxr/mgUi2b9PA653mjiOL7U2w85/sjRLA
 OjUg==
X-Gm-Message-State: APjAAAVr4ClgsB3n0t8Sjv0nhxtb6zPLaKA0wgK4QCePKTMBivNj9eQb
 +IgP4pqg9tQb8HV4gp+RDXWEgfZc88cZMADNRv8=
X-Google-Smtp-Source: APXvYqwZJKlunDJyba+wyrA1+73jZ3U/gNy5hwIEbdAezwFLy1ZvjlRHA1wQjEb4LsknaCHKIQbOo++Vdue7/l/wsU0=
X-Received: by 2002:a17:906:905:: with SMTP id
 i5mr22807816ejd.23.1554877240662; 
 Tue, 09 Apr 2019 23:20:40 -0700 (PDT)
MIME-Version: 1.0
References: <1554809242-27475-1-git-send-email-viorel.suman@nxp.com>
 <1554809242-27475-2-git-send-email-viorel.suman@nxp.com>
 <20190410042906.GC3032@Asurada>
In-Reply-To: <20190410042906.GC3032@Asurada>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Wed, 10 Apr 2019 09:20:29 +0300
Message-ID: <CAEnQRZBDSrpje2-ML0zr+oJkwMbbkxV5hUNc_HzZtPZv-et8mA@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH v2 1/3] ASoC: fsl_audmix: remove "model"
 attribute
To: Nicolin Chen <nicoleotsuka@gmail.com>
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 Fabio Estevam <festevam@gmail.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, Timur Tabi <timur@kernel.org>,
 Xiubo Li <Xiubo.Lee@gmail.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Viorel Suman <viorel.suman@gmail.com>, Julia Lawall <Julia.Lawall@lip6.fr>,
 Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
 Viorel Suman <viorel.suman@nxp.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Nicolin,

On Wed, Apr 10, 2019 at 7:30 AM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> On Tue, Apr 09, 2019 at 11:27:39AM +0000, Viorel Suman wrote:
> > Use "of_device_id.data" to specify the machine driver
> > instead of "model" DTS attribute.
> >
> > Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
>
> Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
>
> > ---
> >  sound/soc/fsl/fsl_audmix.c | 43 +++++++++++++++++++++++--------------------
> >  1 file changed, 23 insertions(+), 20 deletions(-)
>
> > +     priv->pdev = platform_device_register_data(&pdev->dev, mdrv, 0, NULL,
> > +                                                0);
>
> Would you please send a separate patch to replace "pdev->dev"?

I am not sure exactly how to explain this change in the commit message. It does
make code easier to read and avoids dereferencing pdev pointer each time.

Is it enough for commit description?

thanks,
Daniel.
