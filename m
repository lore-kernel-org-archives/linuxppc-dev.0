Return-Path: <SRS0=M5iZ=SX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E09C10F14
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Apr 2019 05:39:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6000D20675
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Apr 2019 05:39:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PAeJXdzt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6000D20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44mz6s4qh4zDqSs
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Apr 2019 15:39:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com;
 envelope-from=nicoleotsuka@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="PAeJXdzt"; 
 dkim-atps=neutral
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44mz591dvBzDq9d
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Apr 2019 15:38:02 +1000 (AEST)
Received: by mail-pf1-x441.google.com with SMTP id y13so4242968pfm.11
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Apr 2019 22:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Z2ZOxKq1NRE/y1pktrwgjjX25p1w7z3FXQMCsOvF6cc=;
 b=PAeJXdztIKcUnPiDJJg7snfPod+xCQiABPwfheAHk3qKamAV6HpaCXe43bkzoChIzT
 4qr/t8Y3acoAdWaDF0ZcmI7Rfomqs8lWgGQUCgTlhWoY4Op17kGtrErG0CcWpjxltNDL
 iWPUqXvSdW317lvwvUQfTw14cJA1Gxt1DazdbVx0CnNhEWfJ0z5xYa/pLUrMgAUTzY2J
 /5zFZvSbBbSQVpDfCXt2mxPdbj0Qf44uLx189yVO3BVe89oLTFJFGBj9k5sYgvYLwjK8
 18DijB4jyq3MJ8Y7VwVI6E0wFggjudk4HbmmtYUKCqXReZXv+srnC8y/oRKPPSookc+Y
 Q5rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Z2ZOxKq1NRE/y1pktrwgjjX25p1w7z3FXQMCsOvF6cc=;
 b=YEbKkBEOUqkOUZRQICQwDz5sFXdGf6oSG1DZAUDWxa8L5T47IemVuM/FVLvCuIfZZr
 a6SmvDqCzuWYPhjFArcLW3vtAYs4OdNY2fbw3DdByJagxb9E7f1jHPGv+vxF2X3kFUJV
 WsVjZMaeTYdvJHLiTmEWaRD3X5wU9KOEx4D9OPLoo80sYC4tAPv6b/l2zx64W79cpwn/
 q/i3e4p+tmwgl840h3esRnDcf7MzgnQ3WfNHAs9N/5P/7rjM+qOEJ1fJHZm27FGX8Oso
 4+NYMmlz5lcRxU52L937uHwKU3zjIBx8CmmdbxHZCWEZ4b8QyAgErva7cSH/l2TlDFM1
 XAIg==
X-Gm-Message-State: APjAAAW0qke5HpT5crahzpV6TmZgkbBVrYR3VDgLMSY/WKBoBBi9ggOy
 zk30K1LBOTxq1qsWFIJz5zY=
X-Google-Smtp-Source: APXvYqxf5aRnlN+xYMVyL2Pt9c3xXNJ1fz9WE1pVQ1Ncq4Z3g0jDbU9jWPJSawL+lNo4WTHhp/0XLA==
X-Received: by 2002:a65:424b:: with SMTP id d11mr12575693pgq.205.1555825079594; 
 Sat, 20 Apr 2019 22:37:59 -0700 (PDT)
Received: from Asurada (searspoint.nvidia.com. [216.228.112.21])
 by smtp.gmail.com with ESMTPSA id b1sm11047245pgq.15.2019.04.20.22.37.57
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 20 Apr 2019 22:37:58 -0700 (PDT)
Date: Sat, 20 Apr 2019 22:37:52 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Daniel Baluta <daniel.baluta@nxp.com>
Subject: Re: [PATCH] ASoC: fsl: sai: Fix clock source for mclk0
Message-ID: <20190421053749.GA5552@Asurada>
References: <20190420154038.14576-1-daniel.baluta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190420154038.14576-1-daniel.baluta@nxp.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "timur@kernel.org" <timur@kernel.org>,
 "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "S.j. Wang" <shengjiu.wang@nxp.com>, "tiwai@suse.com" <tiwai@suse.com>,
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "perex@perex.cz" <perex@perex.cz>,
 "broonie@kernel.org" <broonie@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

By following the pattern of previous Subjects:
ASoC: fsl_sai: Fix clock Source for mclk0

On Sat, Apr 20, 2019 at 03:41:04PM +0000, Daniel Baluta wrote:
> SAI provide multiple master clock source options selectable
> via bit MSEL of TCR2/RCR2.
> 
> All possible master clock sources are stored in sai->mclk_clk
> array. Current implementation assumes that MCLK0 source is always
> busclk, but this is wrong!
> 
> For example, on i.MX8QM we have:
> 
> 00b - Bus Clock selected.
> 01b - Master Clock (MCLK) 1 option selected.
> 10b - Master Clock (MCLK) 2 option selected.
> 11b - Master Clock (MCLK) 3 option selected.
> 
> while on i.MX6SX we have:
> 
> 00b - Master Clock (MCLK) 1 option selected.
> 01b - Master Clock (MCLK) 1 option selected.
> 10b - Master Clock (MCLK) 2 option selected.
> 11b - Master Clock (MCLK) 3 option selected.
> 
> So, this patch will read mclk0 source clock from device tree.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
>  sound/soc/fsl/fsl_sai.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> index d2a4dc744fd7..faa8de87ff83 100644
> --- a/sound/soc/fsl/fsl_sai.c
> +++ b/sound/soc/fsl/fsl_sai.c
> @@ -829,8 +829,7 @@ static int fsl_sai_probe(struct platform_device *pdev)
>  		sai->bus_clk = NULL;
>  	}
>  
> -	sai->mclk_clk[0] = sai->bus_clk;
> -	for (i = 1; i < FSL_SAI_MCLK_MAX; i++) {
> +	for (i = 0; i < FSL_SAI_MCLK_MAX; i++) {
>  		sprintf(tmp, "mclk%d", i);

Firstly, according to your commit message, neither imx8qm nor
imx6sx has an "mclk0" clock in the clock list. Either of them
starts with "mclk1". So, before you change the driver, I don't
think it's even a right thing to define an "mclk0" in the DT.

>  		sai->mclk_clk[i] = devm_clk_get(&pdev->dev, tmp);
>  		if (IS_ERR(sai->mclk_clk[i])) {

Secondly, this would break existing DT bindings of imx6sx and
imx7 platforms as they both have clock-names defined in DTB:
	clock-names = "bus", "mclk1", "mclk2", "mclk3";
Since there's no "mclk0", the entire probe() would error-out.
And mainline has a DT backward-compatible policy, which means
you can't just rename the "bus" in the DTBs but would have to
support them, not to mention "mclk0" is still questionable.

So the right way to fix it is, in my option, to differentiate
the mclk_clk[0] clock source name with the compatible string.
Then you can get the clock name and simply do:
-	sai->mclk_clk[0] = sai->bus_clk;
+	sai->mclk_clk[0] = devm_clk_get(&pdev->dev, tmp);
+	if (IS_ERR(sai->mclk_clk[0)) {
+		/* error-out*/
+	}
