Return-Path: <SRS0=HNI+=SN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE03C10F13
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 20:13:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B2202084D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 20:13:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ahey5ESf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B2202084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44gBzz6r9GzDqSl
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Apr 2019 06:13:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::541; helo=mail-pg1-x541.google.com;
 envelope-from=nicoleotsuka@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ahey5ESf"; 
 dkim-atps=neutral
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44gByF31SxzDqSM
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Apr 2019 06:12:04 +1000 (AEST)
Received: by mail-pg1-x541.google.com with SMTP id e6so4033946pgc.4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2019 13:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=lkadqpOzNcf9LB0J7+vgu9aowMST+yhJ4ntbZQm8mK8=;
 b=Ahey5ESf4YTsZMyDj4Z3utUoGjJNU09BAjDZUKQ4heDd8tga8DW6XtxbmwQZSgDwHc
 J9hjI0kmlwcTyPm/5/FvQ89a/vF8GftB0Ti5lip9t1XGRaufWcv/4CBdWYPb/86S//y2
 mbed1DO8XUlcNQraiVKsqIlmInYCXPlzx22bKcgRhATvq0UDceETZbDW66wv8dkjRGgL
 CJq79JBJL4VORZTlKHW336gg+73R8GUkBjB/VJxchr95Cznj0Avnz43Vp23OsNdozTC0
 qfUUFM/7bAuLIBS0gQVR5/8EnoUW06dcoGIrBkhrJqnOcIpki6++OZt72vXsYo4pP0n+
 JomQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=lkadqpOzNcf9LB0J7+vgu9aowMST+yhJ4ntbZQm8mK8=;
 b=CvQx8pLZhtVQlpeVnkRJ8WPh56cSZqI/T3Wj9YKDrPVISKzT19LbcsTGjn89ECqJZk
 9K7YQHSww4MmruAhG3ym8vaoWT+I5kfwMiyg4xG4rxhIJPOC8N3X0loQdHaneyzEwwvL
 n2tXEye3DfOcjEHGTvy1gLg+VZGIHhWRprROP1S7YHGQ7wuOYGDMSZMR7LUH74W9y4Wa
 EqQ43WPLYVJt+UBbbALCaNyGJA93pchiEEynbqTTC3NqjGdxtjJMQSYvc4bm8O/JlKeF
 NEMYUrSorO6+2VE3uNldAOERCOe87zyT77veD9bEHb7O9JR8MatGhzWKZSRyAGL0Q2Ht
 Jb5Q==
X-Gm-Message-State: APjAAAXDKEpeeF6kVof48TjhFZBi7OKN7AiilVV/iQXbXN3hJNbcoLOa
 9DzTuhMzSU1em/6d1sqNr3g=
X-Google-Smtp-Source: APXvYqzIRelUUPwc7KH6u9QK8MLgTolFA8LYMQjvOP8nVu5UXxiS4QAr9AlV4vpSGS4+3ds2Liudpg==
X-Received: by 2002:a63:fd49:: with SMTP id m9mr49394582pgj.16.1555013521607; 
 Thu, 11 Apr 2019 13:12:01 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id r11sm78255231pga.87.2019.04.11.13.12.01
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 11 Apr 2019 13:12:01 -0700 (PDT)
Date: Thu, 11 Apr 2019 13:11:58 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: Re: [PATCH V2 2/2] ASoC: fsl_asrc: Unify the supported input and
 output rate
Message-ID: <20190411201158.GB13170@Asurada-Nvidia.nvidia.com>
References: <cover.1554975348.git.shengjiu.wang@nxp.com>
 <b7f4c8dd00743ddd09c33def00c1759757b8e743.1554975348.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7f4c8dd00743ddd09c33def00c1759757b8e743.1554975348.git.shengjiu.wang@nxp.com>
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
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Apr 11, 2019 at 09:39:09AM +0000, S.j. Wang wrote:
> Unify the supported input and output rate, add the

We previously didn't support 5KHz->5KHz, but now we do? That'd be
great if so.

>  static int fsl_asrc_dai_hw_params(struct snd_pcm_substream *substream,
> @@ -626,14 +629,18 @@ static int fsl_asrc_dai_probe(struct snd_soc_dai *dai)
>  		.stream_name = "ASRC-Playback",
>  		.channels_min = 1,
>  		.channels_max = 10,
> -		.rates = FSL_ASRC_RATES,
> +		.rate_min = 5512,
> +		.rate_max = 192000,
> +		.rates = SNDRV_PCM_RATE_KNOT,
>  		.formats = FSL_ASRC_FORMATS,
>  	},
>  	.capture = {
>  		.stream_name = "ASRC-Capture",
>  		.channels_min = 1,
>  		.channels_max = 10,
> -		.rates = FSL_ASRC_RATES,

Probably could remove FSL_ASRC_RATES define since it's not used.

Thanks
