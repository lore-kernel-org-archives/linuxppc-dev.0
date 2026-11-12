Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7C5606A32D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2026 09:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yBZfs6mR
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQF1p73Qtz2yLY;
	Thu, 12 Nov 2026 20:09:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::42c" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794474542;
	cv=pass; b=O7aX01Ivm25BBCI0KqKuKKS7AM4axzzW2wwYjJXdfSN1U52GjKR4ABy9xXbclLw/eV2UBuoxXar2a4LHAZ8luYo701fIuq/+eWgAs3ncYpTT7rC9PaXt61E30Rcj+pjm4L57uWtFIxQoBDz71sLZYrzOUgNMxjH56jdjiLeLtR9HK9G9wD9HpQIiq77Le/Z3z66BhyEu5sIh/OpSye8xkb7DNB4MLozake0rrna++5o4sKrjQRphAaMPbD6EahQgDJY/lFWrh8c+16pj/TUVRFbmiidwuZjFhXvPD7JMKTlDHF6s7oqL3r9h7ZSBjMqOw3P2xpsXPL8xdL9KVgnDwQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794474542; c=relaxed/relaxed;
	bh=eRXv+o3xd/LwrjX3vtstrFSK4BcwlWxEyWog/B0Pb2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g3SUikbOfh4+wQf0/iQ5BZG2nyC0Aa8C5C+zeEueqaCOAS6mTKKjb8YNp6CK0DePqt7RtZVrAk9Gcd3Iz/ltZNlte8x5Is9zbozmnGXEex2PiWXVp8hR0G5zVhjHq0V2ZTNkPBPwekraRSWno1S4Qm+MX95BlAkHN72ItvhRXgp0whWLirPZ1/LI+J05zndeKw9d4Kk22/KzlFx0mOlde6iehc3+Z0xt92nU1bS34F2uey4Emyn1ZEfEn/ySpgcz35amoYWwfhyEIN57x5hX3JIxC23930KVbg2vbGUiWmrgxkHaW7MFYZIDJj2dUEUO36jPlmWmqKKLqP/S1MlRZQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yBZfs6mR; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42c; helo=mail-pf1-x42c.google.com; envelope-from=shengjiu.wang@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yBZfs6mR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42c; helo=mail-pf1-x42c.google.com; envelope-from=shengjiu.wang@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQF1p1wfDz2yKn
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 20:09:02 +1100 (AEDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-8a06e79e152so2260180b3a.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 01:09:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794474540; cv=none;
        d=google.com; s=arc-20260327;
        b=DV690eyULqGpbT4Mfmrc6Pm5NXIlgY8w4UQ1L6W8gleHM2MacuOj/JLdtis1UaKSyS
         rh8HMRzRDtvRidgu17LFD1zwrWV49EHii/owVezFMwbFxgc8IIbDly6ZCMk9al7geOaF
         jIT/ve0LoPCYOBnRuvi7Bcrou3zEOoQQbkug0+/ConEUjB9Ppa5IFJdPJ48NATnbY2vy
         SsSsdWiMmI2X1TH07Oej2P/aGKUTeWwkkJSqoiBgZgZ6KdLemyUTWc6eGE0INtggatHb
         RGEZsjcp69bS1Io3QNcY8FD8YsTLxrNGYyA3iQb0VM4h1n/+1AcG+dAGt3y4U6LmB4GH
         BtIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eRXv+o3xd/LwrjX3vtstrFSK4BcwlWxEyWog/B0Pb2A=;
        fh=JlMW8hQ3L+/FqhiSJdL6MLlbSriejx1cccn6ySY22dg=;
        b=AkxD4tm7MPbyAbX9n6lNJ9LDrJY3o/qZmkTRoagHCBfv4ZZ/rWT1Gd4jxmrwAzb6px
         VOY0BLlkKb6euIyLFZDxcUldrSdMZu1rIQW44zTyfk0SZYiB8XXDaPjQg/PzIlZHKMsq
         Q/tieCkvv7YrZxAYihGyVwVfv6awLHR7xL/i8hm7wYpY9TNnR4fnkMJTAJhWJuU4e3Gh
         pHhhxSCWzn6y4ZY2rmkamh63uJg0ZTxrMdLyZEk9lOz7Uo8lDRcn9tvkel8lzsG8iWwT
         ICi476UpwymyNxOztk91gdLIePqwYNEqJV1UgD/o7YRVvwKWBYkKg0RMQpATcjM3uDpH
         sbJA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794474540; x=1795079340; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eRXv+o3xd/LwrjX3vtstrFSK4BcwlWxEyWog/B0Pb2A=;
        b=yBZfs6mRdN4RTLkUAfTAhPNiLek2y3TrjJj03d9Xvr8GQllRAnAymxhjkSbCsQbsUp
         cyMDxRfmh/Izdulka6keqM5o0dQ7AaanLAn/SQSF9eRVWmrlGpKNlYwF8l3bHwUwV3Vq
         cCbUzoDzhA69dFpIfuAP6Y0Nl0Inegn8E53ZwFhgCiNseuXSN0IaguCj6C+GaEFOd7Oy
         nAwSl+LITXhwdMglItHQNtsUp3JyOdZ55cqf4ao19sbqwpS0AJ6l8KSexN1xwd0CsbEc
         5mEQ22Y4hP+W9n8qt3Epn6OsY74tMIduYN6PiwA3VYGOtI4BZh7zQth4nlWAREzLqrGu
         9tLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794474540; x=1795079340;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eRXv+o3xd/LwrjX3vtstrFSK4BcwlWxEyWog/B0Pb2A=;
        b=mn4Eby0298AK3rzhqDEevpIwH0/NN9b0ZzXJtg3O46obP9BZLPs1/v8Ga3itBET5CQ
         /u6Lsply1Wg3v73d0AcblqxcsEv3wcg16xrKJ/scPrFiCjrrXTHCQUB3rA+iel2CtscX
         p/CNJ345noNBgUzkejXEYp82iiPkpRmJ+XHc2+2oTJ9X4s4aZqxjc1oC2X/jlthuPizV
         cyztMQ32bOznTp87wL4CGum6rOoc/Vd2Q7RdhqoTZPkReSw90sazN4JbKHIjS+sigy/D
         BrvM4URDP3iYm7b3bmsl6XP0/QLwxU37t63dcq3i/kgqa5Uv7Fr7+JNKrh8MIJifDcZP
         KFrw==
X-Forwarded-Encrypted: i=1; AL+hErGfL8SEcFOliLcSfz4zVRYRWaj1ezm299vbYKFQ00c637nHe0/HfqEz+WYJ4q/F0yhPgJ9x99PVPx2ylHU=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z/mAIznIAaZkgzAv9hnhv9mcPoPtdcDg5c9jdrH2yR0lP6JOyIN
	9Fr+Fp+NxRn6XxR8eEXu7yr9E4k4B9myzIBMoX/4uWUeResW/OCu86DL9VF+ukE7wCTR8OQ0AGj
	xNWk5VUnD+ydzLmbSSQHxDTGbeemVijc=
X-Gm-Gg: AYBFou2082LwI0pjGBaYUlEKC/RN4NZxHGBby+XKP3za6Cdjlr+xA3MngqRXcoBoMPi
	AStCwLdV4pWmEN4F5jstWH0REnVfvyj1ukYwjmdbCaEWsQYq4LkPaZHz1v58DLs9vqQZbH6OsQF
	Mlg9lpsigfsd1rImEOZ31Ng10I+egepZ6+jYw0v01XF3Iu/lqMPtbuprEEjGeVD4gKELz3nfa/h
	UCl8Z4cF4r4y5LBRqQUzqoxLEZQi+xf587Pd6lDH89T0YTQ45xlotaJ0C5lfzSJAszOi+qYp0LM
	8YgoIqlunhImcJeFkuvSBA1xY8gLm+uMktWJYrGYezP3rOJ36A91C+iIi/wVnO4BvY+1wuUTZFC
	Sn+3CAUsSWfGbbEBAi/f9FfXCFQfd2KgcNv+H
X-Received: by 2002:a17:90b:1c0b:b0:3ac:9599:a689 with SMTP id
 98e67ed59e1d1-3b182f235d9mr3994012a91.34.1794474539722; Thu, 12 Nov 2026
 01:08:59 -0800 (PST)
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
References: <20261110120743.6301-1-stefan.ghetu@nxp.com> <20261110120743.6301-4-stefan.ghetu@nxp.com>
In-Reply-To: <20261110120743.6301-4-stefan.ghetu@nxp.com>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Thu, 12 Nov 2026 17:08:44 +0800
X-Gm-Features: AclHuK-xo5sqQ1bv9bDSXOSJ-L9KATXVxPodrhMZvWrhDua3HJ3hpSCY1aITLMY
Message-ID: <CAA+D8AMqXdSK98qrsecZBk7_=ZVX91PjqejyN-xD0R6b-cqAqQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] ASoC: fsl_asrc_dma: release DMA channels on repeated
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
> fsl_asrc_dma_hw_params() requests new DMA channels on every call and
> overwrites the previous ones, which are leaked when hw_params() is
> called again without hw_free(). Its Back-End error path also releases a
> channel without clearing the pointer, so the following hw_free()
> releases it a second time.
>
> Release the channels of a previous call first, and clear the pointer in
> the error path.
>
> Fixes: 3117bb3109dc ("ASoC: fsl_asrc: Add ASRC ASoC CPU DAI and platform =
drivers")
> Fixes: 36124fb19f1a ("ASoC: fsl_asrc_dma: Fix dma_chan leak when config D=
MA channel failed")
> Signed-off-by: Stefan Ghetu <stefan.ghetu@nxp.com>

Reviewed-by: Shengjiu Wang <shengjiu.wang@gmail.com>

best regards
shengjiu Wang
> ---
>  sound/soc/fsl/fsl_asrc_dma.c | 27 ++++++++++++++++++---------
>  1 file changed, 18 insertions(+), 9 deletions(-)
>
> diff --git a/sound/soc/fsl/fsl_asrc_dma.c b/sound/soc/fsl/fsl_asrc_dma.c
> index b417de6abebe..5ba4bdeff019 100644
> --- a/sound/soc/fsl/fsl_asrc_dma.c
> +++ b/sound/soc/fsl/fsl_asrc_dma.c
> @@ -124,6 +124,19 @@ static int fsl_asrc_dma_trigger(struct snd_soc_compo=
nent *component,
>         return 0;
>  }
>
> +static void fsl_asrc_dma_release_chans(struct fsl_asrc_pair *pair, u8 di=
r)
> +{
> +       if (pair->dma_chan[!dir])
> +               dma_release_channel(pair->dma_chan[!dir]);
> +
> +       /* release dev_to_dev chan if we aren't reusing the Back-End one =
*/
> +       if (pair->dma_chan[dir] && pair->req_dma_chan)
> +               dma_release_channel(pair->dma_chan[dir]);
> +
> +       pair->dma_chan[!dir] =3D NULL;
> +       pair->dma_chan[dir] =3D NULL;
> +}
> +
>  static int fsl_asrc_dma_hw_params(struct snd_soc_component *component,
>                                   struct snd_pcm_substream *substream,
>                                   struct snd_pcm_hw_params *params)
> @@ -190,6 +203,9 @@ static int fsl_asrc_dma_hw_params(struct snd_soc_comp=
onent *component,
>         dma_params_fe->addr =3D asrc->paddr + asrc->get_fifo_addr(!dir, i=
ndex);
>         dma_params_fe->maxburst =3D dma_params_be->maxburst;
>
> +       /* hw_params() may be called again without hw_free() in between *=
/
> +       fsl_asrc_dma_release_chans(pair, dir);
> +
>         tmp_chan =3D asrc->get_dma_channel(pair, !dir);
>         if (IS_ERR(tmp_chan)) {
>                 dev_err(dev, "failed to request DMA channel\n");
> @@ -342,6 +358,7 @@ static int fsl_asrc_dma_hw_params(struct snd_soc_comp=
onent *component,
>                 dev_err(dev, "failed to config DMA channel for Back-End\n=
");
>                 if (pair->req_dma_chan)
>                         dma_release_channel(pair->dma_chan[dir]);
> +               pair->dma_chan[dir] =3D NULL;
>                 return ret;
>         }
>
> @@ -356,15 +373,7 @@ static int fsl_asrc_dma_hw_free(struct snd_soc_compo=
nent *component,
>         struct fsl_asrc_pair *pair =3D runtime->private_data;
>         u8 dir =3D tx ? OUT : IN;
>
> -       if (pair->dma_chan[!dir])
> -               dma_release_channel(pair->dma_chan[!dir]);
> -
> -       /* release dev_to_dev chan if we aren't reusing the Back-End one =
*/
> -       if (pair->dma_chan[dir] && pair->req_dma_chan)
> -               dma_release_channel(pair->dma_chan[dir]);
> -
> -       pair->dma_chan[!dir] =3D NULL;
> -       pair->dma_chan[dir] =3D NULL;
> +       fsl_asrc_dma_release_chans(pair, dir);
>
>         return 0;
>  }
> --
> 2.53.0
>

