Return-Path: <SRS0=spRZ=SR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F43C10F0E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Apr 2019 07:31:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5525206BA
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Apr 2019 07:31:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pxY4w9hV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5525206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44jKty17h5zDqJN
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Apr 2019 17:31:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::541; helo=mail-ed1-x541.google.com;
 envelope-from=daniel.baluta@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="pxY4w9hV"; 
 dkim-atps=neutral
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com
 [IPv6:2a00:1450:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44jKrL3mNtzDqJS
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Apr 2019 17:29:22 +1000 (AEST)
Received: by mail-ed1-x541.google.com with SMTP id j20so3531204edq.10
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Apr 2019 00:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=CZ7qWGoPqWcS4YQFz4saWhW/MfiFjngdMn05tjxAgyo=;
 b=pxY4w9hVemR/TFA30aSbZt7AX3XXLMpRPG7KP1pwTxr6ROfoW/fLNjOg+4BNDIOGAa
 rtmyS4RZgxP1SXpnxU9LechxQ0RXGsS49e7MlMJI5Z+hvW6sK8hcqgwO/JvRwK8+dIrE
 gMFIp9XDFg08+BWoH2li7Sc1ZL8WiPXkuF2NL4hhIwa/PGNZVy1AIR6d5oPCJANso6UI
 3BwoPh9lLXmI1zBa0wPnyHMhhs9iNHlJwR2Pn5VWQROMo3Ajrz7nFwWKXWWtQDLEMlCw
 71OL6zisbrj6uriSnmCLQEFlSg0oQi831X+QUUGA6jeWCBc7HZhT9OE/sb1HYVHvTOKA
 7wOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=CZ7qWGoPqWcS4YQFz4saWhW/MfiFjngdMn05tjxAgyo=;
 b=rSmUJ3OoVYrXOvcfvw+LtsJLajIkuVIHATqNa2vlvunbBNzTi4h1n5M/aSHmL+qTLi
 2MDPCU7h5EwAZUptU4OXxY/kN5XP9SIr6qFEEmhcobdkiTZSjBkm3Ubrh1LD9Rr14bdK
 4X5o3s3/aMicYzqc7dmzLEtRsiwTSN661UXHtf3gvix7qHtfc3N7NKtIWE2Rr9Hsmvp0
 uoSFYWH4V5vbpQ7AgvRmhg7C5ottlcbW0dwy0mpi5Y3FMoJSYh//dFepq+nZX1sCM6Yx
 17N5o70oODdjcknDZViG5GvzJc+uQxT/WxLgwG1h3TRQiEDNNTej20AWeXoXT79ETb/L
 a7kg==
X-Gm-Message-State: APjAAAVFW75KPg6lUUxdgHzbEzXKjTBK7sXjACpnX+kZvNBEUCyB9NJp
 r8NabEjTIQFAsFlCkHO4s0dwC9e3NhrB54XRCH8=
X-Google-Smtp-Source: APXvYqyHD18l5R0sZwnSODvLqhzvz0Gu56qQ+RIn13F2VREKVTwjZg2GDgICzoVehCK9WmHSYQi6S00RLwBgHiWDl+o=
X-Received: by 2002:a17:906:950f:: with SMTP id
 u15mr40804205ejx.118.1555313358469; 
 Mon, 15 Apr 2019 00:29:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190414191450.18377-1-andradanciu1997@gmail.com>
 <20190414191450.18377-2-andradanciu1997@gmail.com>
 <CAOMZO5C_esXni-N-U+hDXNG6Z5rJLC6ZrgKEseCW7mcK=aiyQw@mail.gmail.com>
 <CAEnQRZBD_M8Pp4RWXY4TS5MHAEBnkwUOyR16ttAitX-L+Z88Ew@mail.gmail.com>
In-Reply-To: <CAEnQRZBD_M8Pp4RWXY4TS5MHAEBnkwUOyR16ttAitX-L+Z88Ew@mail.gmail.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Mon, 15 Apr 2019 10:29:07 +0300
Message-ID: <CAEnQRZAP6EWXkwfuR+83trtYrpDaRjA6zp-k5sp33bo5jUEjPg@mail.gmail.com>
Subject: Re: [PATCH 1/2] ASoC: mpc5200_dma: Fix invalid license ID
To: Fabio Estevam <festevam@gmail.com>
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
Cc: Andra Danciu <andradanciu1997@gmail.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, Timur Tabi <timur@kernel.org>,
 Xiubo Li <Xiubo.Lee@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Sascha Hauer <s.hauer@pengutronix.de>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>,
 NXP Linux Team <linux-imx@nxp.com>, Sascha Hauer <kernel@pengutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>, Linux-ALSA <alsa-devel@alsa-project.org>,
 Shawn Guo <shawnguo@kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Apr 15, 2019 at 10:26 AM Daniel Baluta <daniel.baluta@gmail.com> wrote:
>
> On Mon, Apr 15, 2019 at 12:53 AM Fabio Estevam <festevam@gmail.com> wrote:
> >
> > On Sun, Apr 14, 2019 at 4:15 PM Andra Danciu <andradanciu1997@gmail.com> wrote:
> > >
> > > As the file had no other license notice/reference, it falls under the
> > > project license and therefore the proper SPDX id is: GPL-2.0-only
> > >
> > > Cc: Daniel Baluta <daniel.baluta@nxp.com>
> > > Fixes: 1edfc2485d8dc ("ASoC: mpc5200_dma: Switch to SPDX identifier")
> > > Reported-by: Thomas Gleixner <tglx@linutronix.de>
> > > Signed-off-by: Andra Danciu <andradanciu1997@gmail.com>
> > > ---
> > >  sound/soc/fsl/mpc5200_dma.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/sound/soc/fsl/mpc5200_dma.c b/sound/soc/fsl/mpc5200_dma.c
> > > index 4396442c2fdd..ccf9301889fe 100644
> > > --- a/sound/soc/fsl/mpc5200_dma.c
> > > +++ b/sound/soc/fsl/mpc5200_dma.c
> > > @@ -1,4 +1,4 @@
> > > -// SPDX-License-Identifier: GPL
> > > +// SPDX-License-Identifier: GPL-2.0-only
> >
> > According to Documentation/process/license-rules.rst this should be:
> >
> > // SPDX-License-Identifier: GPL-2.0
>

Actually, according to

https://spdx.org/licenses/GPL-2.0-only.html

GPL-2.0 is another name for GPL-2.0-only
