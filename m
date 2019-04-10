Return-Path: <SRS0=mr1i=SM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 150BBC10F11
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 06:39:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E6FA2084B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 06:39:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fN+MTAes"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E6FA2084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44fDyk19BLzDqKr
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 16:39:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::641; helo=mail-pl1-x641.google.com;
 envelope-from=nicoleotsuka@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="fN+MTAes"; 
 dkim-atps=neutral
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44fDwj3RjgzDqDy
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2019 16:37:23 +1000 (AEST)
Received: by mail-pl1-x641.google.com with SMTP id w23so782275ply.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Apr 2019 23:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Z15Euzi/7W0xWj7RGm8EBO4XV8u51E2URV+Tg7QcB44=;
 b=fN+MTAesy2a1t5HT9VEilFzdZlCXei702B7CZP5CB6t93Rh4kelOvfhXaH153fOE3s
 x9g6qn9pzt2KwJ/l7k4clHhr9GRq2XyzB7LP2wRSDnGMiuI+aM2b3tH5evkrr6DvkRUj
 MedJjeOydOUof6pnSfEzK+0VmRxl9zmT6q+q1pQjqfSELg+/QcilVWNlceGYMqdZf3il
 Pi7X0HIK6K7K2by7bDscJN0KKzrEI0MNRNq1oNwyaPxiWXVLgRTQW1g6Iz1K+bgxIWT2
 zHSspKyJJHEOciQbocPf2cIUv1JaqJNMGaGB07d/qzOZ/TUSZVZ8SNidCfY8oblJoo+p
 GVcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Z15Euzi/7W0xWj7RGm8EBO4XV8u51E2URV+Tg7QcB44=;
 b=bZKgDjKA+eYaVu/l3Fc4U5GLUKOss6AvDWMT3Ky56ziGPGh2D7F1OaS+k9tXVyfXIc
 /zT1/XCrhCfgF0nYIcHpwmT5oNmHMi821ji99OY6OsK/xJB4qWOk8KK8fqHKs74mshvs
 +q50qRxHxvz6tIT5MKAhF2ZQMaRHeS5YRfqubiZ5AlJX8GnjophgSM9MGh/wmpM3scAc
 ChGJzehPBhOnwCk/UdL2Bn8hDWdd55wj0ynZzNk+5ejpKm0OGQWH6W0x8jFUDJ020NIT
 odViPY0hSVNInHcQ3O91gpfJXFf8DZ7A2XqcYBCjl36LmflSaDpD47pmPD2u81dd2HjR
 k9iA==
X-Gm-Message-State: APjAAAX4CZ8wtozwZAkc3hSvkTRgzk8JbwbM2ChR3bfUuoiWANLgRvNg
 2Uco2GofhUJxD2f79ybaClg=
X-Google-Smtp-Source: APXvYqzOQ+Lu5lRGswb5Z2P63WBfRUX8mHoz+s2loSkaKvwV6H4Mbw7THqFtMSlONX7MfN0SJPM6cg==
X-Received: by 2002:a17:902:3183:: with SMTP id
 x3mr42274620plb.170.1554878240246; 
 Tue, 09 Apr 2019 23:37:20 -0700 (PDT)
Received: from Asurada (c-98-248-47-108.hsd1.ca.comcast.net. [98.248.47.108])
 by smtp.gmail.com with ESMTPSA id
 143sm69811465pge.50.2019.04.09.23.37.19
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 09 Apr 2019 23:37:20 -0700 (PDT)
Date: Tue, 9 Apr 2019 23:37:14 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [alsa-devel] [PATCH v2 1/3] ASoC: fsl_audmix: remove "model"
 attribute
Message-ID: <20190410063714.GA4156@Asurada>
References: <1554809242-27475-1-git-send-email-viorel.suman@nxp.com>
 <1554809242-27475-2-git-send-email-viorel.suman@nxp.com>
 <20190410042906.GC3032@Asurada>
 <CAEnQRZBDSrpje2-ML0zr+oJkwMbbkxV5hUNc_HzZtPZv-et8mA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEnQRZBDSrpje2-ML0zr+oJkwMbbkxV5hUNc_HzZtPZv-et8mA@mail.gmail.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
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

On Wed, Apr 10, 2019 at 09:20:29AM +0300, Daniel Baluta wrote:
> Hi Nicolin,
> 
> On Wed, Apr 10, 2019 at 7:30 AM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
> >
> > On Tue, Apr 09, 2019 at 11:27:39AM +0000, Viorel Suman wrote:
> > > Use "of_device_id.data" to specify the machine driver
> > > instead of "model" DTS attribute.
> > >
> > > Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> >
> > Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
> >
> > > ---
> > >  sound/soc/fsl/fsl_audmix.c | 43 +++++++++++++++++++++++--------------------
> > >  1 file changed, 23 insertions(+), 20 deletions(-)
> >
> > > +     priv->pdev = platform_device_register_data(&pdev->dev, mdrv, 0, NULL,
> > > +                                                0);
> >
> > Would you please send a separate patch to replace "pdev->dev"?
> 
> I am not sure exactly how to explain this change in the commit message. It does
> make code easier to read and avoids dereferencing pdev pointer each time.
> 
> Is it enough for commit description?

You mean this? https://lore.kernel.org/patchwork/patch/862610/
