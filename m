Return-Path: <SRS0=P3hO=RE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E99C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 02:55:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B7B020854
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 02:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="orEOylP/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B7B020854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 449YvK0gRkzDqQm
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 13:55:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::542; helo=mail-pg1-x542.google.com;
 envelope-from=nicoleotsuka@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="orEOylP/"; 
 dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 449YsV22GZzDqPw
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Mar 2019 13:54:05 +1100 (AEDT)
Received: by mail-pg1-x542.google.com with SMTP id h11so10708181pgl.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Feb 2019 18:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=pX9ThmO4ImLRx5dst6KRZhtGWI+YTUhmtUVchoIoroI=;
 b=orEOylP/4SBNxNjZ1oZq0uRIGFNSD5qQX+jj4H5Wp1SFCS4ORiRiJCeAn+RXUXhXVz
 XjGk7TvZ2+4wD4e+e4KLFpFfpr3vPZMoHtU8IQuZjRxq0iue38kRh3vhUsj4urVp5bnS
 MMiZfSFRzcrbYViOHM4s85PvAlcA+WHZ47THsxWeLeJrKktYSIyKXObx0ck7En7lgWn5
 Qaf5ETEj3Xurbr5t9pjKHCDQ4ggXvLRoVmBC7Np3fAr7JjUDuB6XeqfDYNUbncXn+SvM
 m7h7X1+TyQ/PjvXzOGNVAqA6aSkzjRRAaFUSHBBd8bJ6+d0QCAV7nMkhSRern+x0zYXb
 R6uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=pX9ThmO4ImLRx5dst6KRZhtGWI+YTUhmtUVchoIoroI=;
 b=OJtPeqxk3rb4DkYGnvHNtCpIcrHGjyaVTfkuXccNyTkP4brq8I7qtehwTdJPOYMnEP
 kV4HtEwhJC2ODNKAIzfVWE9LVrdF4p0of1q6z3Pf+nAugIo2u2TEjmV5R1QKnia2mGpC
 stZRc0rWnQXbhjzC8sBNXB61nO71bGXkTTo8jdg2uwEbe5Mx6lrBQXQCvU98WP1Zv0pe
 QErb2vxJcLaDn5jt/+dXektpPizG0u9TXAiuf74wYPEQwvTocOn6/Ou4l7uoNB7x/WqR
 0fJ8tte9gN1/PYIkqM4gmWzyv1POIMudYt9kY6yKsdd4RNlpjZFSqS1qYGfEaXkM/K1D
 ZrCw==
X-Gm-Message-State: AHQUAuZcN2thVK2/CyqU6jK1kyVaVRti5zPvr9aq+rFjTLTSi7pLG3o7
 X6yv7X3p6m0lBnQK4c1NXUg=
X-Google-Smtp-Source: AHgI3IZXXeye/I4zfLUOc02f/u9JmZDDTVFx8KzOwc7g7uiiqUKjrhgk2YmMjJmMaEiZ2iCyI6kaOA==
X-Received: by 2002:a62:1c94:: with SMTP id c142mr3262588pfc.54.1551408842041; 
 Thu, 28 Feb 2019 18:54:02 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id b26sm26255516pfo.33.2019.02.28.18.54.01
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 28 Feb 2019 18:54:01 -0800 (PST)
Date: Thu, 28 Feb 2019 18:53:57 -0800
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_asrc: add protection for the asrc of older
 version
Message-ID: <20190301025356.GA1371@Asurada-Nvidia.nvidia.com>
References: <1551407560-29950-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551407560-29950-1-git-send-email-shengjiu.wang@nxp.com>
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
 "timur@kernel.org" <timur@kernel.org>,
 "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Shengjiu,

On Fri, Mar 01, 2019 at 02:32:38AM +0000, S.j. Wang wrote:
> There is a constraint for the channel number setting on the
> asrc of older version (e.g. imx35), the channel number should
> be even, odd number isn't valid.
> 
> So add protection when the asrc of older version is used.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  sound/soc/fsl/fsl_asrc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
> index 528e8b108422..b3b3c5e15ef1 100644
> --- a/sound/soc/fsl/fsl_asrc.c
> +++ b/sound/soc/fsl/fsl_asrc.c
> @@ -109,7 +109,8 @@ static int fsl_asrc_request_pair(int channels, struct fsl_asrc_pair *pair)
>  	if (index == ASRC_INVALID_PAIR) {
>  		dev_err(dev, "all pairs are busy now\n");
>  		ret = -EBUSY;
> -	} else if (asrc_priv->channel_avail < channels) {
> +	} else if (asrc_priv->channel_avail < channels ||
> +		(asrc_priv->channel_bits < 4 && channels % 2 != 0)) {
>  		dev_err(dev, "can't afford required channels: %d\n", channels);

I feel it'd be better to have another else-if, since the existing
error message is against something else.

+	} else if (asrc_priv->channel_bits < 4 && channels & 1) {
+		/* old version of ASRC has channel_bits = 3 */
+  		dev_err(dev, "does not support odd channel number\n");
+  		ret = -EINVAL;

Alternatively, I feel instead of error-out at here, should we add
a HW constraint or at least fence it off at the beginning of the
hw_params()? This is actually nothing specific to the pair-request
function but a hardware constraint.
