Return-Path: <SRS0=c12Q=ID=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F0E9C433DB
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Mar 2021 02:56:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8A0864FD4
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Mar 2021 02:56:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8A0864FD4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DsC6f5STyz3cm0
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Mar 2021 13:56:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=LVLoAGKO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::732;
 helo=mail-qk1-x732.google.com; envelope-from=shengjiu.wang@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=LVLoAGKO; dkim-atps=neutral
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DsC676v7zz3cXX
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Mar 2021 13:55:41 +1100 (AEDT)
Received: by mail-qk1-x732.google.com with SMTP id t4so701938qkp.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Mar 2021 18:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=B6K7R4Bd/k7pKUFwYYEqKbrQpzoj3M/+hPbpG9mugKo=;
 b=LVLoAGKOykm/jC9af7pN4kyhfFsAcpvm9VLGQ0CXg0Se/SR35Oao/hkwdMYuxntVC7
 J8PVTeW0iWrkuoJKaUfkJjFMyKNvIPNeP4toVjX1ZIFubifotU2p+sArdZJWyEnqPH75
 Y9aUcSuSflX0iOPbsFK769CWeZ7IC98sOu0IPwL3onUjFtgic42u1FpwAONNbuEifkTD
 30fd4+jhh3OvFhY6949/pvO0jes6AfNqJoyTQzov/lvXL4NYk8jkujPxpxY5nyGz3fPT
 LWkSuVWVkzTK+K2qNZOSVrOTr3P/MkvZI7UxiEM/FXLkgD9AHSXBbGIolCXSlxMAhqwi
 OUow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=B6K7R4Bd/k7pKUFwYYEqKbrQpzoj3M/+hPbpG9mugKo=;
 b=BbTQqpgcAMjaFjz+cBqkjffufUJqT9FmyoRs+ArOLfkyodzz3IMst9NG6u9MMcHCW8
 eKteTsEAO8xcTn4i+RTUAJvITo7QqPy3WE/rs1c5pOzEWb/vFE1NgfOWS0WU7esOvjRm
 qNU2cFwRSf4jHyPyqa1zDuQv61TLHzWJqZ6KsRV0f4lUrIzY6VtcDu9hyIaJ4z86CnBu
 zcocC9ezagt7Ok46sH7q3mzo7ajDrzrkbYhf0YYy4M573A/FZ0IkuDLameyfLphbKv4A
 ExUcz30of0uOAUba6gxtuXb6qxnonUg1roVIc3H4E5IbEI/fZqINBNzSgHrFP11fS83p
 LoGg==
X-Gm-Message-State: AOAM530XIha8XXnFwwXuEqyivghh71BeSRd51nFqY6ViS/1pkENhL927
 nYG5RfplyuQP/S++cJQ4/1bdbuiWcgmBeOyALSg=
X-Google-Smtp-Source: ABdhPJxRI1kuyUugmvglxFPMew6mIeAnrVcTj55/x338nxC4x/s5QaheI/U88N1H58YRzxifmLj0W6Tq5BJQQdJ62Go=
X-Received: by 2002:a37:a282:: with SMTP id l124mr7167285qke.37.1614912936574; 
 Thu, 04 Mar 2021 18:55:36 -0800 (PST)
MIME-Version: 1.0
References: <1612693435-31418-1-git-send-email-shengjiu.wang@nxp.com>
 <1612693435-31418-8-git-send-email-shengjiu.wang@nxp.com>
 <20210210221704.GA2894134@robh.at.kernel.org>
 <CAA+D8ANOv91jr4381Acz1B2mZ6=Mx2J_2CMTGXmPKztv7bMjPA@mail.gmail.com>
 <CAL_JsqK1uc82hfdE4yj0ye-D6vygiqWkDVW96NOb-8kEFVqHMg@mail.gmail.com>
In-Reply-To: <CAL_JsqK1uc82hfdE4yj0ye-D6vygiqWkDVW96NOb-8kEFVqHMg@mail.gmail.com>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Fri, 5 Mar 2021 10:55:25 +0800
Message-ID: <CAA+D8AOP9L7eNHFMYrTscz0tPKMqU8Y0H5BtqyURmduhHgvGtw@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] ASoC: dt-bindings: imx-rpmsg: Add binding doc for
 rpmsg machine driver
To: Rob Herring <robh@kernel.org>
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
 <devicetree@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>,
 Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Fabio Estevam <festevam@gmail.com>, Shengjiu Wang <shengjiu.wang@nxp.com>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi

On Fri, Mar 5, 2021 at 4:05 AM Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Feb 18, 2021 at 1:23 AM Shengjiu Wang <shengjiu.wang@gmail.com> wrote:
> >
> > On Thu, Feb 11, 2021 at 6:18 AM Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Sun, Feb 07, 2021 at 06:23:55PM +0800, Shengjiu Wang wrote:
> > > > Imx-rpmsg is a new added machine driver for supporting audio on Cortex-M
> > > > core. The Cortex-M core will control the audio interface, DMA and audio
> > > > codec, setup the pipeline, the audio driver on Cortex-A core side is just
> > > > to communitcate with M core, it is a virtual sound card and don't touch
> > > > the hardware.
> > >
> > > I don't understand why there are 2 nodes for this other than you happen
> > > to want to split this into 2 Linux drivers. It's 1 h/w thing.
> >
> > This one is for the sound card machine driver.  Another one is
> > for the sound card cpu dai driver. so there are 2 nodes.
>
> You are explaining this to me in terms of drivers. Explain it in terms
> of h/w blocks.
>

Yes, there is only 1 h/w block, which is (MU) message unit

As the sound card needs a cpu dai node and sound card node,
so from the driver's perspective, I use two nodes.

Seems It is hard to only use one node for my case.
or do you have any suggestions?

Best regards
Wang shengjiu
