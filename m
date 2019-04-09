Return-Path: <SRS0=YLyy=SL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD4FC10F0E
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 10:10:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C08820857
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 10:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dFB5pYUb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C08820857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44djjS4WB7zDqC9
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 20:10:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::543; helo=mail-ed1-x543.google.com;
 envelope-from=daniel.baluta@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="dFB5pYUb"; 
 dkim-atps=neutral
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com
 [IPv6:2a00:1450:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44djgL13RvzDqB4
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Apr 2019 20:09:01 +1000 (AEST)
Received: by mail-ed1-x543.google.com with SMTP id b8so892834edq.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Apr 2019 03:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mr+UjOk5eBPIlJTqvJkBS7d2+nG7TIj/ncHy/1Hc4O0=;
 b=dFB5pYUb8ioF7ELqO8UytNYkqIaVyUnLp8SkgGMDyWEVOjIMLMp8vnSd7myddYLiCQ
 gwGEh5LKkLI6ro8arOSTWhTlOfNjgmgCNP4DOD1noHS8+qTM6W23glBhe2haDjDfa/f/
 Xw6ndu95Xen9ftUWD6BY6WtROG1Po0gXH6Gn7VbgOLP3/SlO0F0vQvGb3gYJ4wcrmt/A
 LnykNV6dWMdQJDjkkyBImD5Hb8SVskbgu7pchdzjBRdO7PXdvHFv6ZiHdp5gvI30v9PC
 jqXV8vahiuSV+19SjxsShTbnHDH8dsJ9jfunM4koOTxeuioNbNSf49kJCRX3sK6Vn+Oa
 u5zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mr+UjOk5eBPIlJTqvJkBS7d2+nG7TIj/ncHy/1Hc4O0=;
 b=Cwi/x3fjiqpfV7O+I8ue+AXAX4EAlan9ydDaaPFP9HgpMjl+BVDXiRqcVLk5kIJDqu
 qtZbHbbq3xU662NOcgYkfeIUi7GW2P+A7mySW7ZVHbb5jn3g86d7ZiSfgyey72b4NQ0N
 VyU8C1XFzM9nZtzn+DucSKFLCNRwfyyZ7asHOLqp95xfhcGKtQq5JLjMiSfEPCGzZZYY
 0aBYsA1/JO5gqneCIeJKIiCoITerX8tFinSqki9wX/S86jIb+FMRLuNSiEHbYFlFwSNM
 y++BJzF4cXyzA3s3ueVSgM6UzD3EwQLI0CwjW7TGf3IJMQZutBbiUIgdYjZjp6EdL1PN
 /xMg==
X-Gm-Message-State: APjAAAX2dY7n0nkXToKw89K00jYFsXd207lK67zSqHbDVUm7gJKmQwNK
 DWvCaXDu+glnjjM9YOfjZgLOsjIOurZAzNG/a4Y=
X-Google-Smtp-Source: APXvYqwX5ZHbTLEAFnXBhWCLHakyFxqmoaR6Kt4to0CnsX/Dsv+RpDTYx5tMLyyNiZKuZt/ISlkpgkp4jeiC7PCb/jM=
X-Received: by 2002:a17:906:8281:: with SMTP id
 h1mr20048731ejx.124.1554804538919; 
 Tue, 09 Apr 2019 03:08:58 -0700 (PDT)
MIME-Version: 1.0
References: <1554798876-20653-1-git-send-email-viorel.suman@nxp.com>
 <1554798876-20653-3-git-send-email-viorel.suman@nxp.com>
In-Reply-To: <1554798876-20653-3-git-send-email-viorel.suman@nxp.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Tue, 9 Apr 2019 13:08:47 +0300
Message-ID: <CAEnQRZDQRTy+D0ntbTh2OCPfBM_N=yFP-k_JXmF7p-5vsku-ig@mail.gmail.com>
Subject: Re: [PATCH 2/2] ASoC: imx-audmix: fix object reference leaks in probe
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
Cc: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, Viorel Suman <viorel.suman@gmail.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Julia Lawall <Julia.Lawall@lip6.fr>, Mark Brown <broonie@kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Apr 9, 2019 at 11:36 AM Viorel Suman <viorel.suman@nxp.com> wrote:
>
> Release the reference to the underlying device taken
> by of_find_device_by_node() call.
>
> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>

Please add here the Reported-by tag pointing to Julia.

> ---
>  sound/soc/fsl/imx-audmix.c | 31 +++++++++++--------------------
>  1 file changed, 11 insertions(+), 20 deletions(-)
>
> diff --git a/sound/soc/fsl/imx-audmix.c b/sound/soc/fsl/imx-audmix.c
> index 7983bd3..7c24095 100644
> --- a/sound/soc/fsl/imx-audmix.c
> +++ b/sound/soc/fsl/imx-audmix.c
> @@ -20,10 +20,7 @@
>  #include "fsl_audmix.h"
>
>  struct imx_audmix {
> -       struct platform_device *pdev;
>         struct snd_soc_card card;
> -       struct platform_device *audmix_pdev;
> -       struct platform_device *out_pdev;

I am not sure why are you removing these members here. It doesn't seem to match
with patch description. If these are needed to simplify the code please do it in
another patch.

This patch should only fix one problem and that is the refleak.

thanks,
Daniel.
