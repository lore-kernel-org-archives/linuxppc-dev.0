Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44BB606A33A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2026 09:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BidDW0I+
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQF2M3lqjz2yLY;
	Thu, 12 Nov 2026 20:09:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::529" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794474571;
	cv=pass; b=GLEG0F/C6ZQQXKf4sH91BfiJ8cMqskl3qiGvUG1ao2LWvC5YvZL0fjwMyiq0aC3fn5rwVg0vQYWs4OUhVzjfSPWU/0edki7lec3ug2ozYEKMyPCrLdIpHMGlRCNfJkbbuJ/NxmT9FFzMJHcouVcMz4nOywGrP8HdKl8S4pLs5TryK+To+uTJv1JnkiJLwmFSY7FVTK/uNE5IX+XXrlKpUKTzQ/jyvCqk8VbmLwuTalTK/ZBP45giD7qsvLb9fNYEK1BGplU2cZ6NYS5TJz90huLIq/9rlyPHnWUI3Qpene5rSAhSaaT/u9SQ+6Kqbwkh6Yf/t5XwLltB5CaYdImDsw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794474571; c=relaxed/relaxed;
	bh=UC1VFMCdsJy8HJueFJ4vPvh9lfR0tlzAuULdL6Oym6I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bqWRcBm4rOta7mE8GW12Z7ax6gDUfiT7RxHPk3xbZJbgOwIZHguZplGIyc21RJaxjDDjGSWkwrZk6MxugWJmrLr64mBoV/75EckVKcsJX37Sz3FBJ7u3j4LcXOnj5t4e//6CToRHfZxcxiSJZtFAqJJIAuoU1oXAhGDU0XhLOW3nY0Gk0cIxxlVuLDguxuSibTihs/xGak9Olwuqh2AGJXY4CMK89WyrbG9MMEUaD59cg35o+KBErMgj/WnLkty/P+5YsI3xytO0CqMilHvAlUbfQ+alYEm89N/Azy7MNNl6d7aJC0MqXl3Fimncq5dmWLma3Xpcqr1ESTBp+jrruQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BidDW0I+; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::529; helo=mail-pg1-x529.google.com; envelope-from=shengjiu.wang@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BidDW0I+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::529; helo=mail-pg1-x529.google.com; envelope-from=shengjiu.wang@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQF2L6Yn5z2yKn
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 20:09:30 +1100 (AEDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-cdb2893531bso2350587a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 01:09:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794474569; cv=none;
        d=google.com; s=arc-20260327;
        b=NkVfLJZ2FEzzITbESrkZKM0Mum8Iz7My6WajRIEQ35traOJooE7DIuP3oHdqGkQwSz
         ZmWRX16WsMETXFcx8IwiCtrmtM0wWKt9ex3ZJUae1GRzr7lRNgPe2RLCLWZSToBYchxJ
         kBMSbVp9tELRdDfJkeH88c61n5mRpKlDqB7dgjrW6XQV1znr/yvbiFGKCTH9JrZFjqf7
         HoCrBxu9HvGTRaECak/bSHsbpfv9CjEWPe706PMcBlnSwN7Hr0f6rvl9p7TnUYSu6YjF
         CFJTP9L7CzmdB1yTK7jo+J9hXKhDT2z481xI4soK8lEZNHzfcR0yKGAYpbx8G/DXXQ3R
         ahpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UC1VFMCdsJy8HJueFJ4vPvh9lfR0tlzAuULdL6Oym6I=;
        fh=EIjHf+fvh5fQCw+dDi7fBKK6hYm5hPwKi8ejncWbEs4=;
        b=TiDJLLHQL0n/p2VjDSZd/Qv9hBsv1fLqY/EcU9SC+xEUgcu5BN7CnMpk5uh25c4qm8
         YJiji3LEjoGrrBKHg5M6G5DUGh0bbf0K/ahGMkQJzsNVrxknnZkBLVtYmKrZ2rCZ1SK3
         0Sc5lv9rNYWX6isswy3pYUUAleyF33H1Bg6RJnVYvxRTaon+rNBvvTsQOwBHqalIioZ/
         +qzt/RZ6jSRhWzfv8IXi5mtyIU9g8CBgL7V7PY+rxJYSGPTZdjLH1OarEGy7+Injj0b6
         d1jj6ww5QudpJ1BtsN/YqxbyB/f6GNV3OY8zHqiOOzk8UOvDZMGQ50fnkbK347GpG2wO
         lSVg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794474569; x=1795079369; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UC1VFMCdsJy8HJueFJ4vPvh9lfR0tlzAuULdL6Oym6I=;
        b=BidDW0I+VVrT9D+H6P9sIjtU6Pl9BwRkkP9X/1JSmFCJFjIYEmI40y4YuaLPEQn5/R
         NDTDrY90rtoTsqGnvXGCM/aXdnRCAHxEB934hI1iylraLgPSJ7jj45RkKZ3veNemG1xf
         WcYEon58g2EMziBHgmWFRlPErPRrzRJZNDFwt6UOmLBtbm8M2x/QCSu8vzQxGvIJVx+5
         luhsxeQTKnfXK/fsNiYaaDPrNWRCQgWPcvHRldbGGo51O+NU7ew4dOAZG9Vwi4OJBfCM
         aAOrPrWX5GSlf6zp+8hAJHKUSj2M+JQGsfme2psIHwoj2GWxQUMmMn2wbiRmp+r/WnXG
         aioQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794474569; x=1795079369;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UC1VFMCdsJy8HJueFJ4vPvh9lfR0tlzAuULdL6Oym6I=;
        b=il17KhwHVVhc1KVhvJ5E8zFxztKT1I5AX3Pcv3YAx168EqcIPJD01ajYO71rdLiCoO
         7iFBAk2/R5Ys9chsquMDBXIgG3karBnhrT7DFqo4CdQTzkltuOnxe78+LiYKhWwxfM7j
         gajvYkzyaGYLDUsnKZv0qmwzBm7TcdpXMJFFvn4nZQOons4ZnpCWUhQhJ+YKz7ibsn63
         9xI/fU1kjRMWkEA1C3NKKV2ZvInUOS/pbu5ztCLY340b24trLC2S3VIjSj6MRv04b8q+
         VjgJRTfcTtYuF3Fet1mMTXTF/J+VuKBF7pg+b5FK13HJ5Uwu17Ogy1ffCBtq6NKEau1M
         bubA==
X-Forwarded-Encrypted: i=1; AL+hErFE5bd7TkOOSd1JX1aeXQC4ZZ+XE5aeyhvEhE4MALnb1WzBQyu/own09XC2EmXM7c4YDcCMKmE+FCKLCS0=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8LAm9Yersxr8CY30zp+kGPDph8evW+yPVl4gAO/ROwVGGFgRW2
	lV9zkckJ9dUOTCBYX8MNzhwCd3yLmSuiJpkCDmn2kFfAgC1i8ykRNgsS/SPBY3gGuICWyKIHuHs
	XvkzViMM+2DdGEKq5zD8E2Y/nrscNA78=
X-Gm-Gg: AYBFou2Rf33Gi7jqqJR6ffBr4VHDWitLuAbqv2jZqalz1bYxlV3uFuBEU0YOACCSg+0
	PbxLvyWFiW2J1Gi0vvwULS1Z7xjhA5rKg2Jcmfsc8bd8DL/2DfW0iM7Jp3Nhu/7DERE+Oyk3kaC
	UcGLz89/HRPg/04UQmUjYFqDimwzCKDnEO3yLRqOAtl+48RXAAwtVIrN9jwffxIKiF86YFMhRQl
	XheWfJbcIuXtyLT1/4Rk/vf7YFt/fjj1c9zUTsJGJAGFlRleVZgv/S3nhgiEVwU7UHbqLD/X4FB
	FfglanPrJmEXdzB7zOaCcjrrRfmFdN+PGZXWf+aeVSyZhsJ0mYU5CzdiiXNMADayzPznbSK0TUr
	zUMQa8xgRRkHqOhDT5+aw+i9/KzAF95BLSerMECkdYWEUHMUQwp9ewd6Z/g==
X-Received: by 2002:a17:90b:2d8b:b0:3ab:be66:ddbe with SMTP id
 98e67ed59e1d1-3b182edaee6mr4922233a91.28.1794474568658; Thu, 12 Nov 2026
 01:09:28 -0800 (PST)
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261110120743.6301-1-stefan.ghetu@nxp.com> <20261110120743.6301-5-stefan.ghetu@nxp.com>
In-Reply-To: <20261110120743.6301-5-stefan.ghetu@nxp.com>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Thu, 12 Nov 2026 17:09:13 +0800
X-Gm-Features: AclHuK-JKdWd-ygPOBooCSX9cuJhp4rfiioKNxZzndhr2LBJ_ZnCQJKwcXGP6Go
Message-ID: <CAA+D8APshfNo5Ubooq=DnETHeUsAm35Z=LaHUa2hh-p6S5L3xA@mail.gmail.com>
Subject: Re: [PATCH 4/5] ASoC: fsl_easrc: fix context ownership on repeated
To: Stefan Ghetu <stefan.ghetu@nxp.com>
Cc: Mark Brown <broonie@kernel.org>, linux-sound@vger.kernel.org, daniel.baluta@nxp.com, 
	Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>, 
	Nicolin Chen <nicoleotsuka@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 10, 2026 at 8:08=E2=80=AFPM Stefan Ghetu <stefan.ghetu@nxp.com>=
 wrote:
>
> hw_params() can be called again without hw_free() in between.
> fsl_easrc_hw_params() then requests a second context while the stream
> still owns the first one, which is never released. After close, that
> easrc->pair[] entry points to freed memory and is dereferenced by
> fsl_easrc_runtime_resume() on the next open.
>
> The EASRC slots depend on the number of channels, so release the owned
> context before requesting a new one, and make
> fsl_easrc_release_context() ignore a context it does not own.
>
> Fixes: 955ac624058f ("ASoC: fsl_easrc: Add EASRC ASoC CPU DAI drivers")
> Signed-off-by: Stefan Ghetu <stefan.ghetu@nxp.com>

Reviewed-by: Shengjiu Wang <shengjiu.wang@gmail.com>

best regards
shengjiu Wang
> ---
>  sound/soc/fsl/fsl_easrc.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/sound/soc/fsl/fsl_easrc.c b/sound/soc/fsl/fsl_easrc.c
> index 5d715bc07357..ae0fbf6c316b 100644
> --- a/sound/soc/fsl/fsl_easrc.c
> +++ b/sound/soc/fsl/fsl_easrc.c
> @@ -1347,6 +1347,10 @@ static void fsl_easrc_release_context(struct fsl_a=
src_pair *ctx)
>
>         guard(spinlock_irqsave)(&easrc->lock);
>
> +       /* Nothing to release if the context is not owned by @ctx */
> +       if (easrc->pair[ctx->index] !=3D ctx)
> +               return;
> +
>         fsl_easrc_release_slot(easrc, ctx->index);
>
>         easrc->channel_avail +=3D ctx->channels;
> @@ -1500,6 +1504,12 @@ static int fsl_easrc_hw_params(struct snd_pcm_subs=
tream *substream,
>         snd_pcm_format_t format =3D params_format(params);
>         int ret;
>
> +       /* hw_params() may be called again without hw_free() in between *=
/
> +       if (ctx_priv->ctx_streams & BIT(substream->stream)) {
> +               ctx_priv->ctx_streams &=3D ~BIT(substream->stream);
> +               fsl_easrc_release_context(ctx);
> +       }
> +
>         ret =3D fsl_easrc_request_context(channels, ctx);
>         if (ret) {
>                 dev_err(dev, "failed to request context\n");
> --
> 2.53.0
>

