Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6141606A89F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Nov 2026 07:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NJGZaBzG
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQpWw4YTFz2y2f;
	Fri, 13 Nov 2026 18:18:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::52d" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794554316;
	cv=pass; b=JeZNC5Yi9VEVcS5HeL8ozAR006bnw1vD24LB23G9GQ6TTcxdTQNh4JlaBRFQU+Ltst3lmQIzv13xq56Crn2HsfwT3LFgfoc/K9Y/H14q5+magov3l8OBhbA5UT7WptHj5adc1u7EleqdPZ6RiiL5thKdzXcbI6fGJTtLDEkAiJD+Ds8FShbFomjMSL+lndOZ9LHuiZHlybuTfaimIYF03fp43KKJbhrGrWYpMmQIi+EszfQU5Rf0kL0ggne5xqi4zAvFr7jo3aZrf/CEJM7ydYuPksILrVfWqCi74ppi2Iq8eRUurG+0kvdNsTyGolseVkFEFu6fq3oe1Yhd/V5cGg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794554316; c=relaxed/relaxed;
	bh=Z0+5b90eI0XV3LtvO+5dJ8DLir8th8z4fv/7Ku1cttA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NLeiHjE7wDY8bV2Qz0mZXLDMlkX4TxxwXbziIxKdjTe9OevseHZz9NVUhzObqOGthmVWN7S8RpDuPfYn1eaOMusZoE6rVugSJOCr7DiUK9v7uccbctLPmFNTyOZJ8jZ856nMtMneNk0pD/E/SE421nX6odVAfcIGIOTPuN8p6iZykZ7WvqroAhe5lb77XKIiq+VdfYa+q3/mT6VnAx74pIKUK5mMdJ6LHeUbSQB2a9/y6sot/WY4S9GircEba6IRzIncid0a2pi1bsujHz/EpntPQtucMBInEhevpY8SmXruov6iYX8x+qIhKN3l/nWJ6mcWbxZy2WJCk7WGs5lA7A==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NJGZaBzG; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52d; helo=mail-pg1-x52d.google.com; envelope-from=shengjiu.wang@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NJGZaBzG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52d; helo=mail-pg1-x52d.google.com; envelope-from=shengjiu.wang@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQpWv6sbCz2xnh
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 18:18:35 +1100 (AEDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-cdb9d5c1c8eso654271a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 23:18:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794554313; cv=none;
        d=google.com; s=arc-20260327;
        b=bBKRiS9/la8lJnUYWvHkEVihCzrZCRbwyPVWQdnHibLubVfQpfCq40qjEeeXr2NOmR
         0dK4p8HxZt32HAkY+OnjJSf6bOnK3nuZ6hb00kJZk0PnW828MZG0Xq7ZdQwcWE+DjraC
         JSr879WqHY1537ZuCMw2uDhFJqPbWwqmKHKJL4FIMswiisB6FwPWqWOv04BEmUClalHd
         XdN9405YbNH/GDsR6wqIcMvIlVTXKoPLE8ChrNp++tZ+3ArB1GgjlLMmxUvvnJXnTq7w
         DQh4kwH5mAGMs1tgEchfJ0KmTFpdnROWUAP3ZPegpTEpNj3ZurWYZjkgtcIGFqOC6UaB
         83eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Z0+5b90eI0XV3LtvO+5dJ8DLir8th8z4fv/7Ku1cttA=;
        fh=BaHGVdYkGEX7qVfV0sUTQ3Gk0fvR1l8p/7wSSp4BgmE=;
        b=VMdfKbBDFk5gIyuj+7P/4nfXEIXS58Q9rv0mz7Pcivjwhg5bBm2DpguY6l4icmF3YW
         LIdVABp36bbrN0DZgKtPkPN5bLH4v+DRUegIo85kCoTCjQQWkCStLnWllW7eGwjogspt
         6tLvyNJZ7tocjbfIN3vYwe0dPpJTBQeFUNMwEgpFIqo2yXphCLMnL2JbbOXhcj2d8ijB
         87Pv/CjALjLPU6X/zK4LdVwV90hzZPhlyR+MF+EOjHo0tKGVhCgCEZCN4NIzagHtjf8x
         d+7snY3ftexvbtv0MTVBxsukofOnWCfka6qlIIw3+sj8gUetBVcC6J0I9X7TuNcL8Mgb
         QHzg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794554313; x=1795159113; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Z0+5b90eI0XV3LtvO+5dJ8DLir8th8z4fv/7Ku1cttA=;
        b=NJGZaBzGIGDeikqTJGikK4rRmgB9UUHxRR3B6Fk2mO0vdsKNNybuTA6YiAm4dDe2Bt
         Y6r+V6dz7w+rtgB8Oxn5vB2YguCiYW7T2SBa3i983OEreKdWfsvBDhtmoij0YZ0ZtWWR
         czMH0wrLI4CSNy4Sfwup3bQCKsr4dbC2dVAgoYVSvcpNl7GGjKTZBd37Gppvkb519xk4
         BwesIWGXFSI72iNUA2x+rBAd5yPNGXq60CzAse+U6Hbvdm0Y25zkNQ1ljYSBojTBIyFr
         rcwPswakUIafj75L+GwNlL0MmvFROHhIlZhZHwPkRzqxsnrMNOb3TdAcN4kTq+qzKBCu
         X9rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794554313; x=1795159113;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z0+5b90eI0XV3LtvO+5dJ8DLir8th8z4fv/7Ku1cttA=;
        b=g6iONNh/pJqrDsnAPs1+izLmeaXnCOCNP84xzu+RVY25b4EKXgwusovv5ENk2nbi5E
         vZSOi7wJSmjH39yLxpdpjkp9XCzj2p8L7YWtlsttobv7+pyWhrrkt5Y6GJuROt4RZ8Sb
         9yNbldbyqDlOMEdTLSjgZ3hrx4qZTPu2sLI8sMesZxODSnzJ5vHlqrFsPUw7TSMpcUjL
         kLi3PJR4x4ekRdPwQLUE29/DjuqSNtIE394tx3uwbswaUSCbkLVBSGueso+K43tMZoQr
         PVCtJs2RsBySChmcmgSKrr5wUDOTqQY/YUre4KHO7wbnMlJLKkrYOBEiyE3SUoLaGFdn
         ZrLg==
X-Forwarded-Encrypted: i=1; AL+hErGWvkhuwALp7ejYXxGIt9JREqeAX/VVvuwRkmWsb//2ASXFl2I9hNi5ykyG4kjvhNSdleGBmtut6iTKBsg=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z85EN3ysJvMS4LkwosY9c9UUtaE1RGa+m3ugUMJTCEYePD57cr3
	ehFJoNLnK2dzDZj8Ph2lQX7jooPRybJ38gJo3VVDyhg8InLB5ucsGYaRZVz3cVcZ1QQPL4ROedI
	rXaezfqBeqXNbKMwt/+8TmygirzcpTy0=
X-Gm-Gg: AYBFou3DKJKdlkPId7s5EpPtBEG7mrlSXi5281nOZxu0A85goxlLZxKS9JnAYt5KwMb
	SF6XdLVE5e2R5KUig+myVOeSOQxXAvfAB4qQyk78aR5/SII9bpSAfuDtLOBsh4JptDotwR9MmdR
	sP7urftKAFpm1zrTaITpNCAl1T5ydm0aEq7svWwBcW3b/qywQMPUNa+UeoSEB2rrKQxEiwHEq+/
	RCc33LI/PvQjbzOrn9jeBhikmyrD/Y213lIm1hK9k4OvX5gxg19BU+BBGlk/jp5ilb0yAfU8Wzn
	zd4hLCSwzGilADHyxacwmtL0x+HpqxM6fxC4xJUdEMa5rrGFTNnEoc8B6uLULyaurWNviOavxKI
	RxStvbcAC8h8jneqRHc+WJ2BBtTUyEILE3ADE
X-Received: by 2002:a05:6a20:430c:b0:3e0:f8f3:ac70 with SMTP id
 adf61e73a8af0-3f7a7fc6dc2mr1584952637.61.1794554313512; Thu, 12 Nov 2026
 23:18:33 -0800 (PST)
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
References: <20261110075841.12104-1-phucduc.bui@gmail.com> <20261110075841.12104-3-phucduc.bui@gmail.com>
In-Reply-To: <20261110075841.12104-3-phucduc.bui@gmail.com>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Fri, 13 Nov 2026 15:18:16 +0800
X-Gm-Features: AclHuK_pBW-2Dpv2BcGIOJH5pev5KvmpGX7HHdiyRgy9dTc9bXL9f134N_0U2VU
Message-ID: <CAA+D8AMP=4jc-_Nwog5vqw6nsxjpniy_Rt0xy6ca8d7ko8MQtA@mail.gmail.com>
Subject: Re: [PATCH 2/2] ASoC: fsl_sai: Report dataline configuration read errors
To: phucduc.bui@gmail.com
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, Xiubo Li <Xiubo.Lee@gmail.com>, 
	Fabio Estevam <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linuxppc-dev@lists.ozlabs.org, 
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 10, 2026 at 3:59=E2=80=AFPM <phucduc.bui@gmail.com> wrote:
>
> From: bui duc phuc <phucduc.bui@gmail.com>
>
> fsl_sai_read_dlcfg() returns errors from of_property_read_u32_index()
> without reporting them.
>
> Add a dev_err() call in fsl_sai_probe() to report failures returned
> by fsl_sai_read_dlcfg().
>
> Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>

Reviewed-by: Shengjiu Wang <shengjiu.wang@gmail.com>

Best regards
Shengjiu Wang
> ---
>  sound/soc/fsl/fsl_sai.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> index 59c9b8c28133..16197f9ac2d8 100644
> --- a/sound/soc/fsl/fsl_sai.c
> +++ b/sound/soc/fsl/fsl_sai.c
> @@ -1621,8 +1621,10 @@ static int fsl_sai_probe(struct platform_device *p=
dev)
>
>         /* read dataline mask for rx and tx*/
>         ret =3D fsl_sai_read_dlcfg(sai);
> -       if (ret < 0)
> +       if (ret < 0) {
> +               dev_err(dev, "failed to read dlcfg %d\n", ret);
>                 return ret;
> +       }
>
>         irq =3D platform_get_irq(pdev, 0);
>         if (irq < 0)
> --
> 2.43.0
>

