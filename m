Return-Path: <SRS0=tcMx=SQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB42DC10F13
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Apr 2019 21:55:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9CF320848
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Apr 2019 21:55:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qswe4dgQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9CF320848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44j55l1ZqczDqKR
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Apr 2019 07:55:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::143; helo=mail-lf1-x143.google.com;
 envelope-from=festevam@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Qswe4dgQ"; 
 dkim-atps=neutral
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com
 [IPv6:2a00:1450:4864:20::143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44j5492MjkzDqGL
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Apr 2019 07:53:44 +1000 (AEST)
Received: by mail-lf1-x143.google.com with SMTP id u21so11489672lfu.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Apr 2019 14:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lpIeb//6Ka4hpMnT8cTSQA1HkcXYUkXt3zlTY9UdOnw=;
 b=Qswe4dgQ9C3C2lurf3YkYtU/vKm1L/bSN08R4SmBwCpiNkoFwRavtG2s9Z1jvufvGA
 FSiApPWyBVSDo3oZGUd5VgvRC02YsI/b2cbJfnTsZWvpcKt5HoBlzNNUCvcDKi0H1OiM
 iV9mdAsS6K1947MvuyK4kkkNex6lc3SIs9DwdguQpDLgXTpkEMpP279YoHsJJ17mS7UF
 w0Qrhwd8Et5LAu95p2HscgmkEoQy5Yj5p6DRioEoOebiveDOZnxiruTtj6M3S3L6cpT8
 LKXZzJFBOGEWLnv9qrybzc35JZxszczNiwxuSxuX2UgE+tqKbXohLOeeLGIYSJMDdysD
 HrOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lpIeb//6Ka4hpMnT8cTSQA1HkcXYUkXt3zlTY9UdOnw=;
 b=SUURiKaFQqOLCoXo4X6d4r92MKNnq+grd3g9OAZexHzza7p5pMfrM0bt1kXlNTo9gA
 o6QApOyWNJdJIIsxTmp6CVwUGRdx435VSrA1+MmKiz3ixpHAO079NCwESwJD3j5V4MjC
 B7HLJP+ao1ADpGh2aHwgPjh9XO+Hg0yn1kvjBYd6K2GgEfHIvHJ80RT6Eci96WldORIP
 rrm9k92AXLzkdx3OgPSLIaOzaBWNPxx3mBRCCLDWnpZt4JThTUZKM6HMiLXNV3c6K4tK
 y5ntLrBmICs0U8IP/41/ftJ9EZAF67ccenrTKmf71vsscScpt9J5kZ4P6ySruecbPH82
 ZTfQ==
X-Gm-Message-State: APjAAAV79xiU1KYHJNFZrt1svvQxPxxyyXENwxGYS6zn8re5FtbYP927
 Hf8YTVoMQ1RoxaMlkd3WhawFuWitaIfBSTyHlUU=
X-Google-Smtp-Source: APXvYqyQ3fKpGThLNgUNFQM2GJ/9elYwCTp5imoEogWMj5xwYrrFtpvwo1xLuYv6TeidTCFk40fVcepD+ZGjs4/5mJY=
X-Received: by 2002:ac2:5313:: with SMTP id c19mr713689lfh.152.1555278817163; 
 Sun, 14 Apr 2019 14:53:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190414191450.18377-1-andradanciu1997@gmail.com>
 <20190414191450.18377-2-andradanciu1997@gmail.com>
In-Reply-To: <20190414191450.18377-2-andradanciu1997@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 14 Apr 2019 18:53:37 -0300
Message-ID: <CAOMZO5C_esXni-N-U+hDXNG6Z5rJLC6ZrgKEseCW7mcK=aiyQw@mail.gmail.com>
Subject: Re: [PATCH 1/2] ASoC: mpc5200_dma: Fix invalid license ID
To: Andra Danciu <andradanciu1997@gmail.com>
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
Cc: Daniel Baluta <daniel.baluta@gmail.com>,
 Linux-ALSA <alsa-devel@alsa-project.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, Timur Tabi <timur@kernel.org>,
 Xiubo Li <Xiubo.Lee@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Sascha Hauer <s.hauer@pengutronix.de>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>,
 NXP Linux Team <linux-imx@nxp.com>, Sascha Hauer <kernel@pengutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>, Shawn Guo <shawnguo@kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, Apr 14, 2019 at 4:15 PM Andra Danciu <andradanciu1997@gmail.com> wrote:
>
> As the file had no other license notice/reference, it falls under the
> project license and therefore the proper SPDX id is: GPL-2.0-only
>
> Cc: Daniel Baluta <daniel.baluta@nxp.com>
> Fixes: 1edfc2485d8dc ("ASoC: mpc5200_dma: Switch to SPDX identifier")
> Reported-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Andra Danciu <andradanciu1997@gmail.com>
> ---
>  sound/soc/fsl/mpc5200_dma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/soc/fsl/mpc5200_dma.c b/sound/soc/fsl/mpc5200_dma.c
> index 4396442c2fdd..ccf9301889fe 100644
> --- a/sound/soc/fsl/mpc5200_dma.c
> +++ b/sound/soc/fsl/mpc5200_dma.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL
> +// SPDX-License-Identifier: GPL-2.0-only

According to Documentation/process/license-rules.rst this should be:

// SPDX-License-Identifier: GPL-2.0
