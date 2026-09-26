Return-Path: <linuxppc-dev+bounces-28280-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C993EC98332
	for <linuxppc-dev@archiver.kernel.org>; Sat, 26 Sep 2026 13:19:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hsSpy1HXFz2y7p;
	Sat, 26 Sep 2026 23:19:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790428794;
	cv=none; b=Nc96p0bBW+c6QMoRhFO+AwjZNnJENZsrmReYva8YVNZ8fdt+8gyP8uGOLnYNfkXzqQxUwwK1clIa9Uy86uMmI0Od3hLZZkikxfxfwFp/Btd6zwYIzhztTY1iCrGq4o+dfD+RDgGkA/33P+gGufSD7T/qcQqh5Kcl+QFr+unQdeun+CLhk2zDdeaiqw7kMlMfcr+0dHwgZUcDOjLj+MaWLSrUUmDeyTrkHBDNLuLNsV7gvPEwC6a/45yj5Jh8ybwoLIYUxnQU+IryFNW24e04BdOzSr9ati68Gx/8uj+N+2ZniJjznC8w51ax8198EklG5xEyF2Mt4HwyOVYkMMqAHg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790428794; c=relaxed/relaxed;
	bh=KxBdd5YtiikdA2EB3RaEsDlyXLxZtzJpIW7hxYmjpy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dpzXn5nV+RBhlL6w9gEIGNvA1eC06PC2pWpQw1BXiG0hHidooj/Ve58hEcLUfOj5ikm2aMnEKL6rd0hrzr7sY4onNKK2zyUWWFaRoK3fCMEaFIbwQ6+eoCYqHZAXCcMhS1lAJjEDFOhaWwTcYPx2Oxqn6oQkJBw2+72r+c6lNJuY08saKJIHjhF+Va7ZgYEri7AfI58AHEHvuexo49OsUeqMaZldQZWwqeoUwYomZ8yqLkvCCKvXXUKjw6ktRo6QKkKcByvy4QUHNnc3CrbCJQvg/4BoX3pUOrdOoXCni94sRku0Nd19waPMyXqN13FVE1dFGgfGEuYFogFqxl3/AA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OpPofei9; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com; envelope-from=error27@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OpPofei9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com; envelope-from=error27@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com [IPv6:2a00:1450:4864:31::11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hsSpw2YbDz2y2K
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Sep 2026 23:19:51 +1000 (AEST)
Received: by mail-wm2-x11.google.com with SMTP id 5b1f17b1804b1-49e79a408deso9998285e9.2
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Sep 2026 06:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790428783; x=1791033583; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KxBdd5YtiikdA2EB3RaEsDlyXLxZtzJpIW7hxYmjpy0=;
        b=OpPofei99eQlnB/37Wa7WX8ns6nCuah51RZs0PP4hXUvgk/4E7vMQIlgz6JTv8WgDc
         JyVdPHbiJXDVvSE/i+DsvnoltmM4UeJfmT6PVSleM8pBy/1IDZoiE8pXtlk7cGxC1OmG
         SbZfq5qT5fo8v7j5QtpGaoMKasP+2yTGfhSUA5TNUKx+Rwx79toS6szlfkBVKv8t4cRH
         WCHoedeE5EiWdgahNpP9oO59tR9+Nq86FWG+DTm4LX/LZz+3lPgwLksKWmsgtTvTHh0T
         +t/7T9vyLuvF9K8yofOWP3cA5Jc0a5HEi896zPb3onzY4gdYXMkmsRMQt1XbssD2ACI7
         RIlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790428783; x=1791033583;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KxBdd5YtiikdA2EB3RaEsDlyXLxZtzJpIW7hxYmjpy0=;
        b=YxbqYm42sMdj81T4RqLgVb3EPGAblhIkcY/mySv6TbAAj00fz2VLi5Pw9Tcje2ucAn
         p4eXRlNFTW2fGD3XsRFud9HKOTInzbV2YM3AptmQBxdOZD4jPVvsQ8CMimw43uTFMSfG
         EniP1NzMwj5GoiTyEitafvYngF5CPHUdsdQSxMjAYUNinGqkb77rK9r9jhcHZT4B+nOy
         D6upAL+eKinf6dkyI+PkFqBRqEA5zkVXYjlo67gK5RJD8VI7uG/pVH/ulVjxrRlw46u2
         JO4vUM0dpCfUa7OLTC7/LYYuRHKe9liFckJ7balZOxWkBCGbOIAE632g2HpMGYjLfaCC
         xf6A==
X-Forwarded-Encrypted: i=1; AKwUvBy4dIUaSqv18GqUHjMkToLMI34XHUYQSgVZ1lvoBY7dT8MBhCB6y+ArJ6PIYrVB8g4HAhrzLdYnr64yepY=@lists.ozlabs.org
X-Gm-Message-State: AFuF++m+uYpqLb4yCZHp15By38kMk9oNzxoiqFHq0emd4kCAvXTHG+Me
	MKCkjmjZDWV5mTyJ+UZlgXYQ286NdbZnCeVS+OWiIo/h7KZzOMop9uaz
X-Gm-Gg: AYBFou2fYzgYJhZdK/auwCjQ9jj49rCjzOtNq61q38OWoSaV5ussL92ovp3Ud9Q1e0h
	0TizFvXJG9tiBuo6aTfWbr9A3K7Y92qyNPupfi8VU3Lf2CUSQzRk7gw3QGMVvloKjRBmuPca/5m
	ejzMhHaFGtUNWWnwaI6c6k05wHB0d0kRM0ruq2zjjjw2CsmL7pdjmpBVu89kbD1F25EOFyWB1yu
	tL8BvFALDYnoXunMfyDUx/2BOQujWGbhnoe+uLhI5MH8+ixfV8D+i4QRW6LbqXtwgY5w590jE9M
	s7XoxLT6mvSepChWAKepbDaYX47DHUXGdQWiWku25jqCpWeiHYWyrtUEcE8S/OXkw6jt1bzdFUM
	h004ViHdiDLKP3uoDZHvpMiPpsqEWvbo3FbXM8b/LkChXFBENutjrctCB8BSoWzbw4dwFBffms8
	PEiFmMBBQSbJJboGmVhupJOu/Vo/r0+ft4+MW78dyhCtz/2r14BFbv0urSR3Baar+oUsc=
X-Received: by 2002:a05:600c:1391:b0:49f:ce73:5e96 with SMTP id 5b1f17b1804b1-49fe670af91mr159689215e9.34.1790428782920;
        Sat, 26 Sep 2026 06:19:42 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a84205esm13861406f8f.37.2026.09.26.06.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 06:19:42 -0700 (PDT)
Date: Sat, 26 Sep 2026 16:19:38 +0300
From: Dan Carpenter <error27@gmail.com>
To: Slavin Liu <bolin.liu@seu.edu.cn>
Cc: shengjiu.wang@gmail.com, xiubo.lee@gmail.com, lgirdwood@gmail.com,
	broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
	festevam@gmail.com, nicoleotsuka@gmail.com,
	linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: fsl_asrc: check the second front-end DMA channel
Message-ID: <arfGajXmMUeew0fr@stanley.mountain>
References: <20260913125147.109920-1-bolin.liu@seu.edu.cn>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260913125147.109920-1-bolin.liu@seu.edu.cn>

On Sun, Sep 13, 2026 at 08:51:47PM +0800, Slavin Liu wrote:
> The temporary Front-End DMA request can fail independently of the
> persistent channel acquired earlier in fsl_asrc_dma_hw_params(). The
> returned NULL pointer is immediately used to read its private data.
> 
> Check the temporary channel and release the previously acquired
> persistent Front-End channel on failure. Clear its slot so a later
> hw_free cannot release it twice. ASoC marks a component's hw_params
> only after success and skips unmarked components during rollback, so
> returning an error alone would leak the earlier channel.
> 
> Detected by static analysis and reviewed with AI-assisted source auditing.
> 
> Fixes: 3117bb3109dc ("ASoC: fsl_asrc: Add ASRC ASoC CPU DAI and platform drivers")
> Assisted-by: LLM
> Signed-off-by: Slavin Liu <bolin.liu@seu.edu.cn>
> ---
>  sound/soc/fsl/fsl_asrc_dma.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/sound/soc/fsl/fsl_asrc_dma.c b/sound/soc/fsl/fsl_asrc_dma.c
> index 2f662bdf14d0..64f2b0612274 100644
> --- a/sound/soc/fsl/fsl_asrc_dma.c
> +++ b/sound/soc/fsl/fsl_asrc_dma.c
> @@ -248,6 +248,11 @@ static int fsl_asrc_dma_hw_params(struct snd_soc_component *component,
>  
>  		/* Get DMA request of Front-End */
>  		tmp_chan = asrc->get_dma_channel(pair, dir);

The ->get_dma_channel() function pointer returns error pointers not
NULL.

    sound/soc/fsl/fsl_asrc_dma.c:254 fsl_asrc_dma_hw_params()
    warn: 'tmp_chan' is an error pointer or valid

sound/soc/fsl/fsl_easrc.c | (struct fsl_asrc)->get_dma_channel | fsl_easrc_get_dma_channel | 1
sound/soc/fsl/fsl_asrc.c | (struct fsl_asrc)->get_dma_channel | fsl_asrc_get_dma_channel | 1

regards,
dan carpenter

> +		if (!tmp_chan) {
> +			dma_release_channel(pair->dma_chan[!dir]);
> +			pair->dma_chan[!dir] = NULL;
> +			return -EINVAL;
> +		}
>  		tmp_data = tmp_chan->private;
>  		pair->dma_data.dma_request2 = tmp_data->dma_request;
>  		pair->dma_data.peripheral_type = tmp_data->peripheral_type;

