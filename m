Return-Path: <SRS0=6Lu7=PL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FDADC43387
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Jan 2019 18:27:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 693B620815
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Jan 2019 18:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="E6KoCmex"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 693B620815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43VxGX1SzgzDqMC
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Jan 2019 05:27:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=robh+dt@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="E6KoCmex"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43VxDs0d4FzDqDQ
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Jan 2019 05:25:48 +1100 (AEDT)
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com
 [209.85.222.176])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 07160218D3
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Jan 2019 18:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1546539946;
 bh=PoJ0dnKj33jdwURMzFRuZUu1ihZ2k4zHEH0DZSL8UfA=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=E6KoCmexVWS8cPtfyo/RfbdA4iPyy4gL2zDMhY8wQs8EEcpOSjgnq/r/y779BBnzc
 v7ZWsPLbXpro7LVNuzNbAnRImv3GsPZZDvcmOqvU3s3LCw5JQADUbfehTh1sSrz6At
 v2rOHVlBGSIkIpHRygar2e8ZEqSOLz/aIHoBSdJ4=
Received: by mail-qk1-f176.google.com with SMTP id c21so4231170qkl.6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Jan 2019 10:25:45 -0800 (PST)
X-Gm-Message-State: AJcUukeCT1JpLy5bw6yd5y2lyaRGgmeRJFnbkbxY6mDQqfLnfzHbFaK9
 eulKMl9z3s4yQ/motw1FcOEOwgiyrkEer4mI8g==
X-Google-Smtp-Source: ALg8bN6sJb/CC38IT+vKqJe9FwmTeB1yhwj9N6y6KEzQZGFM4rZifmB+Xf9BtX5VltXrDlJmwuS0fBbz9BrIGYx4qQs=
X-Received: by 2002:a37:7682:: with SMTP id r124mr45419366qkc.79.1546539945110; 
 Thu, 03 Jan 2019 10:25:45 -0800 (PST)
MIME-Version: 1.0
References: <1545150569-14897-1-git-send-email-viorel.suman@nxp.com>
 <CAGoOwPQvc5w05NOVsp6Qw-Ee3CJJCcaU2Dtzwbf+7bUe_kFEbA@mail.gmail.com>
 <1546531006.14398.83.camel@nxp.com>
In-Reply-To: <1546531006.14398.83.camel@nxp.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Thu, 3 Jan 2019 12:25:33 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLcBjRBV_zOoMGGB9gFVgk=4LSx80sFam1-9neDVjAYfQ@mail.gmail.com>
Message-ID: <CAL_JsqLcBjRBV_zOoMGGB9gFVgk=4LSx80sFam1-9neDVjAYfQ@mail.gmail.com>
Subject: Re: [RFC PATCH] ASoC: fsl: Add Audio Mixer CPU DAI driver
To: Viorel Suman <viorel.suman@nxp.com>
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "timur@kernel.org" <timur@kernel.org>,
 "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Daniel Baluta <daniel.baluta@nxp.com>, "tiwai@suse.com" <tiwai@suse.com>,
 "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
 "broonie@kernel.org" <broonie@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 Fabio Estevam <fabio.estevam@nxp.com>, "perex@perex.cz" <perex@perex.cz>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Jan 3, 2019 at 9:59 AM Viorel Suman <viorel.suman@nxp.com> wrote:
>
> Hi Nicolin,
>
> Thank you for your feedback, same here - just back from vacation.
>
> On Jo, 2018-12-27 at 01:24 +0800, Nicolin Chen wrote:
> > Hi Viorel,
> >
> > Sorry for the late response, having been on a long vacation.
> >
> > The code looks pretty clean. Just some small concerns/questions
> > below.
> >
> > On Wed, Dec 19, 2018 at 12:30 AM Viorel Suman <viorel.suman@nxp.com>
> > wrote:
> > >
> > >
> > > This patch implements Audio Mixer CPU DAI driver for NXP iMX8 SOCs.
> > > The Audio Mixer is a on-chip functional module that allows mixing
> > > of
> > > two audio streams into a single audio stream.
> > >
> > > Audio Mixer datasheet is available here:
> > > https://www.nxp.com/docs/en/reference-manual/IMX8DQXPRM.pdf
> > >
> > > Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> > > ---
> > >  .../devicetree/bindings/sound/fsl,amix.txt         |  45 ++
> > >  sound/soc/fsl/Kconfig                              |   7 +
> > >  sound/soc/fsl/Makefile                             |   3 +
> > >  sound/soc/fsl/fsl_amix.c                           | 554
> > > +++++++++++++++++++++
> > >  sound/soc/fsl/fsl_amix.h                           | 101 ++++
> > I aimn't against the naming here, but it seems to be AUDMIX in RM?
> >
> > Would it be better to align with that? It's your decision though.
>
> To me "AUDMIX" sounds more like some RTL high level integration module,
> I would prefer to keep it as it is if there is no strong reason to
> rename it.

At least for compatible string names, matching what's in the RM or RTL
is more appropriate. Where does "AMIX" come from?

Rob
