Return-Path: <SRS0=ugyh=4N=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7017C35DF5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 25 Feb 2020 08:05:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 230192084E
	for <linuxppc-dev@archiver.kernel.org>; Tue, 25 Feb 2020 08:05:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kDWNGF9v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 230192084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48RWhd2243zDqVN
	for <linuxppc-dev@archiver.kernel.org>; Tue, 25 Feb 2020 19:05:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::441;
 helo=mail-pf1-x441.google.com; envelope-from=nicoleotsuka@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=kDWNGF9v; dkim-atps=neutral
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48RWfV3s48zDqSm
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Feb 2020 19:04:02 +1100 (AEDT)
Received: by mail-pf1-x441.google.com with SMTP id 2so6733593pfg.12
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Feb 2020 00:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=3UwgyNGegYf+ShQWoRWvT/NL7ARqm4MqRGArNYI3who=;
 b=kDWNGF9vw5evEFnyTn5rudlI/14OO67KtZuSmNARz8zTE4vVP7Hhc6JwfRZjCo85Z2
 tvgyuCBpwge1k7uxAL3cVdZdd0QGzOONoXlY+5TvHTzrZZoIbbnkxtUVyXYv0RR+Vity
 fOXvHDB3esTtnVmpSpmzuRqas5eMJ9vZFO4fAMfsF60iMsVd/vW2Bzs8+2d+xXASD2zh
 SUjAI5xrrtkyJAoK+q4wao8cymtP54e+xRZfxO+DeDmxIwT0qBTqrTWjbSlS9EpolcvA
 HhiiBRfm4FTS4F09uPw+SswFfyUOtYA5VfsHVt5vnwZO3TjYll5qx31WeHyUw/SVquMa
 Xd9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=3UwgyNGegYf+ShQWoRWvT/NL7ARqm4MqRGArNYI3who=;
 b=F8VBFW0fa12egaL83S13xjP4cfU92kTO7UooN1NA2qF92cRZK4sqXqRq4OL+TXaHyV
 L5vqxW9OV5NpsY2HQDoioTUyYsBBUnPGuPwRpYkF577/D5iWx6hngCBKREX1g13KMHOW
 vzKPXLfqxqRW7fnhfQVotI5yRdf929W+8K1Vn830FBFUhcgh6fTyE6fPY7tmoRQjKjh8
 ot9LGdcD+3KCkKAf4lGr50g0jjODZ3N/qKh4XV9orGJDEfR6f2dj0KwOywDrnY9s13V+
 x5IIujHi075bnwjMeQsohJeibr590gF6dJ5ksjs29uWVuSe6xH6JYJUmCG6pfEoL2NUH
 3KUQ==
X-Gm-Message-State: APjAAAVNIMwl1UDt6kumasG1qgBxcgU24qTLwSBl/BZ0LBwTB8uZggQ0
 Cos1ao75vkBMrlULGhLJK0Q=
X-Google-Smtp-Source: APXvYqwMRtQpYwUBTrb0+cvHPd0eiLB/R3rhnLG6W+uGQXS+JAd8tDieKTnw2v05Noa4gwMj4BMhpg==
X-Received: by 2002:a63:d344:: with SMTP id u4mr35777777pgi.153.1582617838655; 
 Tue, 25 Feb 2020 00:03:58 -0800 (PST)
Received: from Asurada (c-73-162-191-63.hsd1.ca.comcast.net. [73.162.191.63])
 by smtp.gmail.com with ESMTPSA id
 b18sm15964609pfd.63.2020.02.25.00.03.57
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 00:03:58 -0800 (PST)
Date: Tue, 25 Feb 2020 00:03:50 -0800
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: Re: [PATCH v2 3/3] ASoC: fsl_easrc: Add EASRC ASoC CPU DAI and
 platform drivers
Message-ID: <20200225080350.GA11332@Asurada>
References: <VE1PR04MB6479BCA376502F6F1251602BE3EC0@VE1PR04MB6479.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VE1PR04MB6479BCA376502F6F1251602BE3EC0@VE1PR04MB6479.eurprd04.prod.outlook.com>
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "timur@kernel.org" <timur@kernel.org>,
 "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "tiwai@suse.com" <tiwai@suse.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, "perex@perex.cz" <perex@perex.cz>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Feb 24, 2020 at 08:53:25AM +0000, S.j. Wang wrote:
> Hi
> 
> > >
> > > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > > ---
> > >  sound/soc/fsl/Kconfig           |   10 +
> > >  sound/soc/fsl/Makefile          |    2 +
> > >  sound/soc/fsl/fsl_asrc_common.h |    1 +
> > >  sound/soc/fsl/fsl_easrc.c       | 2265 +++++++++++++++++++++++++++++++
> > >  sound/soc/fsl/fsl_easrc.h       |  668 +++++++++
> > >  sound/soc/fsl/fsl_easrc_dma.c   |  440 ++++++
> > 
> > I see a 90% similarity between fsl_asrc_dma and fsl_easrc_dma files.
> > Would it be possible reuse the existing code? Could share structures from
> > my point of view, just like it reuses "enum asrc_pair_index", I know
> > differentiating "pair" and "context" is a big point here though.
> > 
> > A possible quick solution for that, off the top of my head, could be:
> > 
> > 1) in fsl_asrc_common.h
> > 
> >         struct fsl_asrc {
> >                 ....
> >         };
> > 
> >         struct fsl_asrc_pair {
> >                 ....
> >         };
> > 
> > 2) in fsl_easrc.h
> > 
> >         /* Renaming shared structures */
> >         #define fsl_easrc fsl_asrc
> >         #define fsl_easrc_context fsl_asrc_pair
> > 
> > May be a good idea to see if others have some opinion too.
> > 
> 
> We need to modify the fsl_asrc and fsl_asrc_pair, let them
> To be used by both driver,  also we need to put the specific
> Definition for each module to same struct, right?

Yea. A merged structure if that doesn't look that bad. I see most
of the fields in struct fsl_asrc are being reused by in fsl_easrc.

> > 
> > > +static const struct regmap_config fsl_easrc_regmap_config = {
> > > +     .readable_reg = fsl_easrc_readable_reg,
> > > +     .volatile_reg = fsl_easrc_volatile_reg,
> > > +     .writeable_reg = fsl_easrc_writeable_reg,
> > 
> > Can we use regmap_range and regmap_access_table?
> > 
> 
> Can the regmap_range support discontinuous registers?  The
> reg_stride = 4.

I think it does. Giving an example here:
https://github.com/torvalds/linux/blob/master/drivers/mfd/da9063-i2c.c
