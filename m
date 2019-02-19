Return-Path: <SRS0=lgwO=Q2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADDD2C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Feb 2019 19:03:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27A3B2147C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Feb 2019 19:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OpCPBdYp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27A3B2147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 443qrF0gQkzDqK3
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 06:03:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::541; helo=mail-pg1-x541.google.com;
 envelope-from=nicoleotsuka@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="OpCPBdYp"; 
 dkim-atps=neutral
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 443qpJ02wXzDqFm
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Feb 2019 06:01:27 +1100 (AEDT)
Received: by mail-pg1-x541.google.com with SMTP id r124so10561910pgr.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Feb 2019 11:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=9dqjN7Y98iax4DhXzFYlyCN9SeqrXCABc0VZJksvSrg=;
 b=OpCPBdYpV/MVzsOY/FJDzxu9itQFe/UOGjHD0ybqauWRJ1hDHVwxDvYU5l8xnRmvrr
 wunWiqX/3I0WN7fmLSbQHw8awF74Xhoq6kEJUh4dGQ6kKPe1kjZcw6wTtCE9oJtAFS0/
 GzMX0H5Omog4gvlMzHpydKSRMSu9KXt8CtbG9xdEB9uSSL8G7mTda/RHoxCNH4/jiUQL
 gAshgwbpcZG3qWfxPFtz79hCV6EzVKNDBEe2DA+OkExRFGPzGYn0wfZc9HD/6PcBWXP2
 A9aSRX20CFArm15E++f8Ovr0U3m2KJll4f8WfmlL5bk+VgTpxwCifTmhptUJr6M16YL3
 y9Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=9dqjN7Y98iax4DhXzFYlyCN9SeqrXCABc0VZJksvSrg=;
 b=Z4XAZcFEMElxmZtDX8lfp/ommtYOTNa/KXeFhI7vBhLhjEjgyPCDrGpjj3r79JeAEy
 mbEElS9lVBCtnRADfelyfloLX8miNvE6vFbIEV+bSrSfzDrB2YXcQKVeIknvrVxoC1+m
 ThOfc9x+72/XHxdn4VMWDdW0dQZ9Bzuoo5O/hnsOi4r7Qe08BFTCDtfSIcNLUAWdfXHs
 D3vHECkheP+ZF/rQimphArwl4rCb8Lsi+ErBj/XFd7mgqtiuaS1PXAYe5MDdvwm62t3j
 68PQMeuDKVuoryeuUXQ3JkhagIY7Awc2bFs69/KQsI8fBho7kXY/pYAacGstPzcEXkWg
 8lzg==
X-Gm-Message-State: AHQUAuajMqRpv1n1Vt+EWbVMLoefwpfuSVf2npGINe1tZj4Wk9ZZvbnf
 3Co+8UA2Y+a2Ga7Wqk70V18=
X-Google-Smtp-Source: AHgI3IYqYw9XQFEL1T9dxKHLkN7bHPB12de5CGE6uR/8W+tHvImJqcLEcShlhwebSAROw/U/X1Qszg==
X-Received: by 2002:aa7:92da:: with SMTP id k26mr16119756pfa.216.1550602885893; 
 Tue, 19 Feb 2019 11:01:25 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id h3sm2004611pgv.38.2019.02.19.11.01.24
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 19 Feb 2019 11:01:25 -0800 (PST)
Date: Tue, 19 Feb 2019 11:01:22 -0800
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Viorel Suman <viorel.suman@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_spdif: fix sysclk_df type
Message-ID: <20190219190121.GB13373@Asurada-Nvidia.nvidia.com>
References: <1550503474-18865-1-git-send-email-viorel.suman@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550503474-18865-1-git-send-email-viorel.suman@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
 Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, Viorel Suman <viorel.suman@gmail.com>,
 Mark Brown <broonie@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Feb 18, 2019 at 03:25:00PM +0000, Viorel Suman wrote:
> According to RM SPDIF STC SYSCLK_DF field is 9-bit wide, values
> being in 0..511 range. Use a proper type to handle sysclk_df.
> 
> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

> ---
>  sound/soc/fsl/fsl_spdif.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
> index a26686e..4842e6d 100644
> --- a/sound/soc/fsl/fsl_spdif.c
> +++ b/sound/soc/fsl/fsl_spdif.c
> @@ -96,7 +96,7 @@ struct fsl_spdif_priv {
>  	bool dpll_locked;
>  	u32 txrate[SPDIF_TXRATE_MAX];
>  	u8 txclk_df[SPDIF_TXRATE_MAX];
> -	u8 sysclk_df[SPDIF_TXRATE_MAX];
> +	u16 sysclk_df[SPDIF_TXRATE_MAX];
>  	u8 txclk_src[SPDIF_TXRATE_MAX];
>  	u8 rxclk_src;
>  	struct clk *txclk[SPDIF_TXRATE_MAX];
> @@ -376,7 +376,8 @@ static int spdif_set_sample_rate(struct snd_pcm_substream *substream,
>  	struct platform_device *pdev = spdif_priv->pdev;
>  	unsigned long csfs = 0;
>  	u32 stc, mask, rate;
> -	u8 clk, txclk_df, sysclk_df;
> +	u16 sysclk_df;
> +	u8 clk, txclk_df;
>  	int ret;
>  
>  	switch (sample_rate) {
> @@ -1109,8 +1110,9 @@ static u32 fsl_spdif_txclk_caldiv(struct fsl_spdif_priv *spdif_priv,
>  	static const u32 rate[] = { 32000, 44100, 48000, 96000, 192000 };
>  	bool is_sysclk = clk_is_match(clk, spdif_priv->sysclk);
>  	u64 rate_ideal, rate_actual, sub;
> -	u32 sysclk_dfmin, sysclk_dfmax;
> -	u32 txclk_df, sysclk_df, arate;
> +	u32 arate;
> +	u16 sysclk_dfmin, sysclk_dfmax, sysclk_df;
> +	u8 txclk_df;
>  
>  	/* The sysclk has an extra divisor [2, 512] */
>  	sysclk_dfmin = is_sysclk ? 2 : 1;
> -- 
> 2.7.4
> 
