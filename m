Return-Path: <SRS0=99u2=SG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE9AC4360F
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 12:12:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77DB9206C0
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 12:12:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jFAZy3XY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77DB9206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44ZhfJ26F4zDqJB
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 23:12:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::242; helo=mail-lj1-x242.google.com;
 envelope-from=festevam@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="jFAZy3XY"; 
 dkim-atps=neutral
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com
 [IPv6:2a00:1450:4864:20::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44ZhZl2cD6zDqF7
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Apr 2019 23:09:31 +1100 (AEDT)
Received: by mail-lj1-x242.google.com with SMTP id l7so1853091ljg.6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Apr 2019 05:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GYO7EPqOGrMp9edmk6y6YZ57MeWm04v2p4X6gCHxcfI=;
 b=jFAZy3XYIUaD5PMKk6OmWwxnhtAn4LbS8jnDhZ5+4zi1EYVcWHR+dkQ3gVAyXlwKAo
 XKlGLibgCQzUzUrmN+QU+Q/l7mS0219mkVhyB4w4LBTNYz3pTKWQsKKfu/psM4FQdXoq
 qtYgq/yLfB4Idag0Cq5tk3OEZBSkcnmtToqyfttpLRpb1R1IjDLXnQeF8TQc1TvmhFvB
 DreUA9de5fNze0FaqP8ZgNIj9XZhTy/BRkIhlpqDw4bNROrdDK2kXIdR2Ws7lOtqpZen
 vXKw0Y3aXxz0zZbxDQkWHTu2BXaTLSlQAyJ7euBknM0QaLc6AEMlXN3gEbzfGeNWeQVY
 VIEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GYO7EPqOGrMp9edmk6y6YZ57MeWm04v2p4X6gCHxcfI=;
 b=uL/VT4sZB2VUN+PslRYPzIPdfq/6lvHDLwuZW9ZvPN54ARKkh5xMqSs5InNORpBqMP
 wItWUcnpOx3oHboHqgXNLxG/pdoOqNshV99fiqxV/QpLzwSUIL85FHCfL0iIpqjykdCE
 N8YG9wWzQGL56N6CEuoQ4Zi6a/F0D8yxf6Zj/8ZnANM6U+qWAXQkAC++Gz9Mg729FzXm
 AZ3Kigc/BQ3BRFYzpYmmBj2uJPWJ6XltKoCeWLWItRuVPrRyvpmdHsuM9H4Pq2w+gL0Z
 ArWRmu0Iiivpg7Ne8Wpd4wwphSaSwLEActrOE1WHu4NS7/8dzFxB+I5e6cTGhYcdHG18
 Tk+Q==
X-Gm-Message-State: APjAAAXXyurTTi/cCcS14BVDqEdtA/7kn8TNz9zu6y1a4IBUmMo6swiS
 dFu2ktnSQJvEDliyeX55+Eo4cz58pewgRZINMQQ=
X-Google-Smtp-Source: APXvYqzfpOqi0nj6BABzdoP8u97h7uqVwbsYo1cPe05sB0MMfAEQFpyBjwI5zGiG6n47VBZDG7Ve7E6/LeBh0XN4olI=
X-Received: by 2002:a2e:7215:: with SMTP id n21mr3398436ljc.105.1554379767063; 
 Thu, 04 Apr 2019 05:09:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190404120703.30054-1-andradanciu1997@gmail.com>
In-Reply-To: <20190404120703.30054-1-andradanciu1997@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 4 Apr 2019 09:09:17 -0300
Message-ID: <CAOMZO5Co=+0wwXzfkc8aGAC7d6Dm7PsHBQcLyx2VVZjkcKrsVQ@mail.gmail.com>
Subject: Re: [PATCH] ASoC: imx-pcm: Switch to SPDX identifier
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
Cc: Daniel Baluta <daniel.baluta@nxp.com>,
 Linux-ALSA <alsa-devel@alsa-project.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, timur@kernel.org,
 Xiubo Li <Xiubo.Lee@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Sascha Hauer <s.hauer@pengutronix.de>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>,
 NXP Linux Team <linux-imx@nxp.com>, Sascha Hauer <kernel@pengutronix.de>,
 Shawn Guo <shawnguo@kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Apr 4, 2019 at 9:07 AM Andra Danciu <andradanciu1997@gmail.com> wrote:
>
> Adopt the SPDX license identifier headers to ease license compliance
> management.
>
> Signed-off-by: Andra Danciu <andradanciu1997@gmail.com>
> ---
>  sound/soc/fsl/imx-pcm.h | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/sound/soc/fsl/imx-pcm.h b/sound/soc/fsl/imx-pcm.h
> index 133c4470acad..3ce2f437e645 100644
> --- a/sound/soc/fsl/imx-pcm.h
> +++ b/sound/soc/fsl/imx-pcm.h
> @@ -1,13 +1,9 @@
> +/* SPDX-License-Identifier: GPL-2.0 */

This is not correct...

>  /*
>   * Copyright 2009 Sascha Hauer <s.hauer@pengutronix.de>
>   *
>   * This code is based on code copyrighted by Freescale,
>   * Liam Girdwood, Javier Martin and probably others.
> - *
> - * This program is free software; you can redistribute  it and/or modify it
> - * under  the terms of  the GNU General  Public License as published by the
> - * Free Software Foundation;  either version 2 of the  License, or (at your
> - * option) any later version.

as it does not match with the original license text.

You should use:

/* SPDX-License-Identifier: GPL-2.0+ */
