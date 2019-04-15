Return-Path: <SRS0=spRZ=SR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3DF2C10F0E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Apr 2019 07:28:41 +0000 (UTC)
Received: from lists.ozlabs.org (unknown [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A199206B7
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Apr 2019 07:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UjDRWsx2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A199206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44jKqV73rHzDqGY
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Apr 2019 17:28:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::542; helo=mail-ed1-x542.google.com;
 envelope-from=daniel.baluta@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="UjDRWsx2"; 
 dkim-atps=neutral
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com
 [IPv6:2a00:1450:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44jKnn4V21zDqG9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Apr 2019 17:27:09 +1000 (AEST)
Received: by mail-ed1-x542.google.com with SMTP id i13so3030608edf.11
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Apr 2019 00:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=oZs1t7dzptvM8+UvWwUnA1FIOgorbXKUPYsdSd5YMlg=;
 b=UjDRWsx2/8KT65imliIICFTyn9za7WkCkdX4dNbGXlsi8Y4TXF084nZjB1w+D5Zv+v
 e6b78n8hgX25KmF5G+ZY2nLBtLIg4bsFrXmnRQUbV6KJyRNX54pKHBSV0/gsZDFN3fC4
 5AuKQQzPgxj9IExk+84rBPLZsirzoLfpOFs3Gp7WJpWn2+PuulQsqjEHZIUygz0uYnvR
 oAPKjN+nGX2ItZ/yc2UWbxfFtxKeP9sBhd1TOM8FDTp9CLpHRT5l3tf/RDtTrfsLPWFB
 asSOzuhTjfJnMahs3w81X0gmmtU4H6V1tyY4RUYEtwAuJlXniSKRtsRyEhCi+QiP+YLw
 fLZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oZs1t7dzptvM8+UvWwUnA1FIOgorbXKUPYsdSd5YMlg=;
 b=A5d6r9bT6shm4ym8lVFuMpk8uscUFPPTJGFFQCCMeChdgtQxNYl01Kbg9qwS5IVj+Y
 KPFOcFn+hFpFIlb5IQ+sh84wgaew/QViZGpDOz2dm5yObCLKJMRd2DllNY4KNVP7nguy
 52AbHjuT6WNULV7Ngt1m/KuBcGYNKhfcHp1bxyd+s+PwH3vXPdBhNAx+xXnsReeeEvDu
 x4fMKH03nTQcpk4wzp43kar24iaCOe3sqJZFUVaqhWkm8AE9NDAH3nZxvz7pYLnC696r
 bcz9zH+E4FxnadP0/ODU4c+dj0tA+MGBG6QYRHOEkD18MqEH006qQ+PD5UlI33wZyG8t
 500g==
X-Gm-Message-State: APjAAAX7k0PHDTrIpFZxpaonKMlHWcrao9aRvWv0DmWauYX2y7wLKY7y
 z2eoHu49EJpHu+JvF2h4hrh6VOu2UbsaX6W6dTw=
X-Google-Smtp-Source: APXvYqxHfMUzdZo3n/YAwd+9RzuAEF6B3wFCmP8V7JFd6g7AiuXXisPrtTrT/2yO4R7m1dWvx3Ppu89kUROufhXRRxI=
X-Received: by 2002:a50:ad58:: with SMTP id z24mr7201898edc.75.1555313225459; 
 Mon, 15 Apr 2019 00:27:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190414191450.18377-1-andradanciu1997@gmail.com>
 <20190414191450.18377-2-andradanciu1997@gmail.com>
 <CAOMZO5C_esXni-N-U+hDXNG6Z5rJLC6ZrgKEseCW7mcK=aiyQw@mail.gmail.com>
In-Reply-To: <CAOMZO5C_esXni-N-U+hDXNG6Z5rJLC6ZrgKEseCW7mcK=aiyQw@mail.gmail.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Mon, 15 Apr 2019 10:26:54 +0300
Message-ID: <CAEnQRZBD_M8Pp4RWXY4TS5MHAEBnkwUOyR16ttAitX-L+Z88Ew@mail.gmail.com>
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

On Mon, Apr 15, 2019 at 12:53 AM Fabio Estevam <festevam@gmail.com> wrote:
>
> On Sun, Apr 14, 2019 at 4:15 PM Andra Danciu <andradanciu1997@gmail.com> wrote:
> >
> > As the file had no other license notice/reference, it falls under the
> > project license and therefore the proper SPDX id is: GPL-2.0-only
> >
> > Cc: Daniel Baluta <daniel.baluta@nxp.com>
> > Fixes: 1edfc2485d8dc ("ASoC: mpc5200_dma: Switch to SPDX identifier")
> > Reported-by: Thomas Gleixner <tglx@linutronix.de>
> > Signed-off-by: Andra Danciu <andradanciu1997@gmail.com>
> > ---
> >  sound/soc/fsl/mpc5200_dma.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/sound/soc/fsl/mpc5200_dma.c b/sound/soc/fsl/mpc5200_dma.c
> > index 4396442c2fdd..ccf9301889fe 100644
> > --- a/sound/soc/fsl/mpc5200_dma.c
> > +++ b/sound/soc/fsl/mpc5200_dma.c
> > @@ -1,4 +1,4 @@
> > -// SPDX-License-Identifier: GPL
> > +// SPDX-License-Identifier: GPL-2.0-only
>
> According to Documentation/process/license-rules.rst this should be:
>
> // SPDX-License-Identifier: GPL-2.0

Actually
