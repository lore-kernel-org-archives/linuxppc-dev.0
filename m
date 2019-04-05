Return-Path: <SRS0=OBm5=SH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C510C4360F
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 13:30:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 691502184B
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 13:30:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YRHdnaFW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 691502184B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44bLKJ2mfVzDqSS
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Apr 2019 00:30:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::143; helo=mail-lf1-x143.google.com;
 envelope-from=festevam@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="YRHdnaFW"; 
 dkim-atps=neutral
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com
 [IPv6:2a00:1450:4864:20::143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44bLFk4HcYzDqT7
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Apr 2019 00:27:06 +1100 (AEDT)
Received: by mail-lf1-x143.google.com with SMTP id 10so4380577lfr.8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Apr 2019 06:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/S9ER+mMybWHdrmSHFBHrML8i6W0dz5O78OM+5/knRw=;
 b=YRHdnaFWUodEuWeUARP+rCdwZq8XcbPwq6g3QPYEnW2NWNSY8HvzUBfBZ2EldlbzvE
 atkdXtwm828V1OXDc3dGTHImD4wISmIlN8Tuz5unD4PdcE5m5M+yrzfNT45Cat765zKo
 Poewd9j6gEC1MKEQ7GH2VLsz7AuvVpsPzwKXklWcgR8xnTa5qh17lX9BUvBOPBWtJLJ7
 5+ub6EvUDXe50QS7/gF++BCk2FlTm8TSDZa2v/SfXgN9GikzqIwv+S1R5kN4q4oMm+5+
 p3/SA2sa6rWIpbFVDAvILsyWZRfGemNWREUK6SV6eZrJ6rWUv4hUGL3FXjpoUGNOeHET
 wYfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/S9ER+mMybWHdrmSHFBHrML8i6W0dz5O78OM+5/knRw=;
 b=MUeDR6sX4qElyqGP/ceIQKdI09YRA5TW5VMQ3tSNnx/e26v/yiMi4yj3CQC1RIYcKt
 tPbndmPS8w3MSayo/dSpsjEjqoux9AxqSJWtGVzQDw3jOePU8jfr/2w9Ij+kfsWyrrUl
 tfapifdw3pN2D1fav6a6Abj633JKVSHmbJ0RFzA7Ir6Z+siax1vO3UTtyjMS0ChhXgRo
 p6nL6fRnquus0BmKebmE8MTrl3x9C9HDZHd7m7nvOcOYz6NCTLuuCNitnQADvzlpIxih
 hOSTV9G/T15+rUqp3Ln0R3Qj5ve8jQuIJ6cdTNIt+quV+fN/rAf2AbLx6VRJ+8hnOJ+/
 5fFA==
X-Gm-Message-State: APjAAAUP9L+Svm1cOMcdC4NdN1ieKgKDO/JPuIVJW+eXONvYwElVVw1i
 5tN1E9v+1WENB3Z+QdMqtr5tVRSrob2EK18lHBA=
X-Google-Smtp-Source: APXvYqyQxeNzbKtqpj7/NPLBVJQZrRZSeOLzYPb/XlFGrzcjjerB6SdvwGPfCDCLEBqsNuxHHbJhTuydaUEBqoJP00g=
X-Received: by 2002:a05:6512:c1:: with SMTP id
 c1mr1918814lfp.132.1554470820773; 
 Fri, 05 Apr 2019 06:27:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190405115010.28838-1-andradanciu1997@gmail.com>
 <20190405115010.28838-3-andradanciu1997@gmail.com>
 <8e16e9f5-2c0f-a1e6-df0d-67b982db294a@codeaurora.org>
 <CAOMZO5CZtJq65iUDN2Ao9zt=0_L0iXy-5eRCrHAzQb+3s5rxBA@mail.gmail.com>
 <e3bc6c00-d88d-d30a-28a1-a8c4e520ec5a@codeaurora.org>
In-Reply-To: <e3bc6c00-d88d-d30a-28a1-a8c4e520ec5a@codeaurora.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 5 Apr 2019 10:26:49 -0300
Message-ID: <CAOMZO5Aa_z5V03hYG+=A2zgMNKU5kEPHU=uYH1v_6VD-47s9kg@mail.gmail.com>
Subject: Re: [PATCH 02/20] ASoC: efika-audio-fabric.c: Switch to SPDX
 identifier
To: Mukesh Ojha <mojha@codeaurora.org>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>,
 Andra Danciu <andradanciu1997@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
 timur@kernel.org, Xiubo Li <Xiubo.Lee@gmail.com>,
 Daniel Baluta <daniel.baluta@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 linux-kernel <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>,
 NXP Linux Team <linux-imx@nxp.com>, Sascha Hauer <kernel@pengutronix.de>,
 Shawn Guo <shawnguo@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 linuxppc-dev@lists.ozlabs.org,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Apr 5, 2019 at 10:24 AM Mukesh Ojha <mojha@codeaurora.org> wrote:

> you mean all lines to start with //, does not it look to noisy to eyes ?

Mark Brown's recommendation is to use // in all the initial block
lines instead of only in the SPDX one.
