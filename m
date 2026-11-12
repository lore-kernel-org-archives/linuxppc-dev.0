Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C93606A337
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2026 09:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RUq1zU8M
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQF2q25hVz2yYY;
	Thu, 12 Nov 2026 20:09:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::1031" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794474595;
	cv=pass; b=iDrxq9cottlfmP7IqPTfO+uUldWYV1G4Fp3QQ9XLnlAhKnifBlWyq1SNMdypR35fLtyFBS2OSS5cocSfmcVjcpOHYfja00ybtgSsQOE3Z4C14kxXzyz1Xx4jhmC2rwWL9osdImynK3PpKDNBMRGrvhHNQ3PM2+jkqzNdg8vmguKR2uz3ZBLI0KCrlBDReHprIAwJzwvePe5mcroqZ3LCgVU1zHDPtY61iXT5SkbT4ByYJsua8QaPdrt2bX9C32/80tYrmOTb7Ms3AHryrwdL+RDEkjP36im2InYqm+XS1SqyJYt2OoS6DJUfF9zZ1E67E4ITDYYbYnQoARtCsZP3qQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794474595; c=relaxed/relaxed;
	bh=41TLMfuT+52fzNjjd3TBUzig4DGCNHOs3ZzjuOR8gQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G9m77fZeyPoHfQpXPeEMfe6v3eEPF+f32RihlVPX+JPwO1OgCD8CoTyM6H1KQW5CuY9hLCFwp0aGD8ubUxrMx4WD3jWGN5ympu9JeG9odnNY8qZnbr5LWD10GV4V6fTncy3RPTyvVquV8c2jDZlxvbujIb9rgBKvh5BUIj+CcDM9fHX2XcRuUhR2SZdjdjrvc9e4rOos9CXwu4X6WVlnkUa2YJQhZUaI3D19jpX7Rgrlf8iCOvhbmZ5fbTyPKq64cVYVwMnzz701WKRCkO+kwfQxjDA/fIAQ9g6NkZdZLYrgYa8U0P1/sh1fn0Hvs72eSwczEWfh3MIMT3gwm1sJOQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RUq1zU8M; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=shengjiu.wang@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RUq1zU8M;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=shengjiu.wang@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQF2p4YhVz2yLY
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 20:09:54 +1100 (AEDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-3ae7626d14aso2107898a91.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 01:09:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794474592; cv=none;
        d=google.com; s=arc-20260327;
        b=gh63pEWMQTWOZSlMUNYYIlhhDawAg72a3SZJ2cXlzSEgiDxW8rkc9mzPy7Q1cys3CN
         SgxcMEe8xfvDTbM4OOX1NmZI7UuyNoLdWaitkoUtwRaxxsZ7ABAKgPUmnG8zlRCgju+6
         aZoTeoo0opZQOa7dtpW5a4sDfm+8tsGWZ4GbjZQPL5bSr8oRiud/heW7zGvU4pS8neoh
         swtanpTrcw1p1sThF0yP/YQ9Nt85ZJTuybwMk31ZaFdjObXEXvTdqQl4pMlFznutaqrd
         5KU4t7HUXczxTniCziv5BrMlXZ9fX52jkVl8KWDjeAUcEpYSvesp4mts5vD5XpdZUpVk
         MJXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=41TLMfuT+52fzNjjd3TBUzig4DGCNHOs3ZzjuOR8gQQ=;
        fh=DmocPq3sSeZmBWmKeKgSIS+Od5DlkyEh0g8NyuJ1lsc=;
        b=AvVLc4pm/lXEcrKIkhONzy1odXOd5h41rFcgkDKdizrkgx6uTo0whgorsyJGaArBd7
         RD/4XrY6vBEz40MA89fsDdg0VI7niSmBuH+ZPmB8h6HsWQMS9gYm7r+fqUfY151QsRG1
         tkUVy5AmXV8TXd7a4XOkKznq29Uqancbz2kLGKBSpQSKRK41Yi22hTrJCbMrpU/2twja
         rPYXwtVK2/yWgLFec5rh0gG7sXLW4+jvdJFmZa0q2SEDmesA1/4leHRB+IsMTbrvxYUz
         Rs9h91uM93Fr8oUP9lCKJx4LKfJh99bi2/ydkZI5E92gSGFLsc0gFNNOFKucHMS0jWVr
         NVxQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794474592; x=1795079392; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=41TLMfuT+52fzNjjd3TBUzig4DGCNHOs3ZzjuOR8gQQ=;
        b=RUq1zU8MqeOVwk3kOqf5uFYB/QCrDsROzw83AtQp8Zkiq9fQ8zCPEpDjGY+uQHgtQX
         4fAt2cn+BKCXAwb5oh8UUlbmTW45k+5tz1i/ZqxQI/p+MHHCsjcpflMe5G72yEUMocTc
         cA5Sox5jCYQoDqgeloaKm2E7jVUOZXOp9v096U8yIQ4hL4RLKVnOaOaPMzEXrdnXrjQC
         q+O949ALbvJUqoEO7utrbER2TxXnqf27YeHFEUTrYpI9qWmy2HHmID9bMcMz2XxyfFpQ
         iqYK7E2MZ7sWJV9nX/rLexlTmDF9XqJUEqK05o6UWYgIyEQ5A1IuE/txK6nt1GNwfIoR
         S7kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794474592; x=1795079392;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=41TLMfuT+52fzNjjd3TBUzig4DGCNHOs3ZzjuOR8gQQ=;
        b=r0URMFm4kIL8F6ZnyAj5kREqnuUzCIBk8QhJwhmbdzfelBScpMm3N2lNLdAIxE9gZC
         mLErtUEwqiuqT5SSDH6B1FmcLaBU4uarWdspqAWGAqw4C+inrvMQe3ZFAir4h17wPfn4
         2LT0ck2VGu+m0DiqIw18T9TSuhPry93xNwdYlt/duZXMK99Fi/pNLAtZV09FiVyRlXqQ
         vTXu3XDZKtXdo7wwUO29Zgu/2i1K49io+3eB7Zr8Cg1qVEqR3GqBzaVWdKSH89lBRiPJ
         5qH7PXd00+YXza4UnKevW1gqIm/6jRi6gtf7ha9LKkHVnSG2lNmGfpHaJqn6O+QlnHqt
         P2YA==
X-Forwarded-Encrypted: i=1; AL+hErHANXPQArD4ozuRFO0j2wS+uvu0HfivVNnz6A7Ob+QQ2h5XsiCMpJCBGhekHmMKlOBd3iFYgZ4g388ZOJc=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+la43WkivbmRRO963rQheQsjiA9Ct8OBA9l4+2jp6d1CqGlG/6
	Nfi1xcw7AzrUTEgtTwEzwjJa/+VqrQz+QYnDwx6Z7RhlNAPS46FwpLRjIleiJG2n5Aumk9kJwNE
	dDAG10qXZSbJrpM/6v7LIQjXthS+l1W0=
X-Gm-Gg: AYBFou12TQdDOrxDd6lFkgRnksKkgvHsJdpntOqnvG7FTlpIztF4/HTllRBdIyV8ZxJ
	RmmdfPRk7Zvb9sZEOqnm+ZffH5oJvMmCF7jHR4b4bG9BXrC+1edgR6j7hQ7iQH59FtCliS2gJtI
	Hp2qN9yYMPaYTmNOHgN+qyMAxmbTfvsc3SEkODWbIcXlnk02MUJQtu8T5zvE7UZ1A4/L/+zsY+5
	XJVfpWAvKJ5D628Lf4U6MsoNiInaRu2HiLmmw/Ks4SwDkQJP3hd3WWkkvQn8rDWW6ZhwiofHLwm
	Y7I4BMCSc7CgSJ9Z1Vnpeo3astz1Oyq6JG3TKh01KbEFyJs+iIjQgR+kFeVKvHi68WYh28hHPCa
	uRXs2xAX8KNZ4M39vJLpbWMXtktILK6StbZZO
X-Received: by 2002:a17:90b:55c3:b0:39e:4c80:f67b with SMTP id
 98e67ed59e1d1-3b182eec04dmr4462684a91.26.1794474592451; Thu, 12 Nov 2026
 01:09:52 -0800 (PST)
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
References: <20261110120743.6301-1-stefan.ghetu@nxp.com> <20261110120743.6301-6-stefan.ghetu@nxp.com>
In-Reply-To: <20261110120743.6301-6-stefan.ghetu@nxp.com>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Thu, 12 Nov 2026 17:09:35 +0800
X-Gm-Features: AclHuK-lbSv9CDph6_v29dZj64AdLc5AtI3F8vZxXUgTDki9rgE2Boxczom6dhQ
Message-ID: <CAA+D8AM6JnJL+6LkOEqbgtsMU0iQP6OYam4AWAxDBjuOV3VGrQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] ASoC: fsl_asrc_m2m: allow only one task at a time per
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
> All tasks of a stream share one pair and one set of DMA channels, and
> get_caps() advertises a single fragment, but the compress core allows
> up to 64 tasks. A second task requests the pair again and overwrites the
> DMA channels. Freeing both tasks then releases the same channels twice
> and leaves a stale asrc->pair[] entry after close.
>
> Return -EBUSY from task_create() while a task exists, and clear the DMA
> channel pointers once they are released.
>
> Fixes: 24a01710f627 ("ASoC: fsl_asrc_m2m: Add memory to memory function")
> Signed-off-by: Stefan Ghetu <stefan.ghetu@nxp.com>

Reviewed-by: Shengjiu Wang <shengjiu.wang@gmail.com>

best regards
shengjiu Wang
> ---
>  sound/soc/fsl/fsl_asrc_m2m.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/sound/soc/fsl/fsl_asrc_m2m.c b/sound/soc/fsl/fsl_asrc_m2m.c
> index cadfebb12e7c..2e91073f14f9 100644
> --- a/sound/soc/fsl/fsl_asrc_m2m.c
> +++ b/sound/soc/fsl/fsl_asrc_m2m.c
> @@ -471,6 +471,10 @@ static int fsl_asrc_m2m_comp_task_create(struct snd_=
compr_stream *stream,
>         struct dma_chan *tmp_chan;
>         int ret;
>
> +       /* All tasks share the pair and DMA channels: one task at a time =
*/
> +       if (pair->dma_chan[IN])
> +               return -EBUSY;
> +
>         exp_info_in.ops =3D &fsl_asrc_m2m_dma_buf_ops;
>         exp_info_in.size =3D ASRC_M2M_BUFFER_SIZE;
>         exp_info_in.flags =3D O_RDWR;
> @@ -527,6 +531,7 @@ static int fsl_asrc_m2m_comp_task_create(struct snd_c=
ompr_stream *stream,
>
>  err_dma_channel_out:
>         dma_release_channel(pair->dma_chan[IN]);
> +       pair->dma_chan[IN] =3D NULL;
>  err_dma_channel_in:
>         if (asrc->m2m_unprepare)
>                 asrc->m2m_unprepare(pair);
> @@ -571,6 +576,8 @@ static int fsl_asrc_m2m_comp_task_free(struct snd_com=
pr_stream *stream,
>                 dma_release_channel(pair->dma_chan[IN]);
>         if (pair->dma_chan[OUT])
>                 dma_release_channel(pair->dma_chan[OUT]);
> +       pair->dma_chan[IN] =3D NULL;
> +       pair->dma_chan[OUT] =3D NULL;
>
>         return 0;
>  }
> --
> 2.53.0
>

