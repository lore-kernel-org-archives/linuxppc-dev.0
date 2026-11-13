Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61242606A336
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Nov 2026 07:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Qg0E1z5M
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQpWJ5x2wz2xnn;
	Fri, 13 Nov 2026 18:18:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::632" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794554284;
	cv=pass; b=KImWUea5SUzi4A8m08QesWki2mAUnkKWNldPSwbL5sPw2u4R7jPaGI3TNP/pr+LZnEMBdC7C9bfRS7vQEXN2xA2a8Ookns4I9fauLmYF9kos5O8cTFa/uQy42kT4rnLn5CaEEht0CgHFE353HMLeYRucpfQmdfz0kYqbUdQ5174VlYd4mfcW8F6xjoiYBRQtxfpSaVSEwR/M45sSongDiyLPBy7F6KVuFYojhPKcjqhl0yGMzv9UeRlp/JP8tjQQBrJxlIJZf0liT28ykNWh7KgkcM+rCAWDDSuwDTPkCHLqzSAZqISy36fqbCak7LuVJEMNGa6XIGmgHWV+g2m8Wg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794554284; c=relaxed/relaxed;
	bh=jbKSRLmz7AprKYWxSmdsCwUxL3t+E9S5Fb7xZH5aS6w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ougYTgBkV0XhgxvVIkXMVhY2657SB1Om4HeqcsJlU7jECgD86Zu6wbLI10NpeDYysS3jKK7QpLPiUoIpQ1oIedYSNtY50TuE0rh37bQcVPWWk/PUbs+grK0zTNN2VQiodRZABY8PDNqVPJOx9/VtI3XoWvJycF9aHE+RyRzSv09bFuXGcWrTis0FDXFZ8hp7fIImFta38sCaeufp5byJiuXYUcUBpnhu09po00fA2o/pWtKXvb0ligx9+Ho9IVZnBq34+V2elt0JoMEBCBaSYJudpXsiR8vzp04ZCnbei1R2uPSSNUBsr2XqgqFhI8qIcjmR6Nuamj1riBJWVo8Vkw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Qg0E1z5M; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com; envelope-from=shengjiu.wang@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Qg0E1z5M;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com; envelope-from=shengjiu.wang@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQpWH2fQ8z2xnh
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 18:18:02 +1100 (AEDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-2ed28bac8d7so2748465ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 23:18:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794554279; cv=none;
        d=google.com; s=arc-20260327;
        b=gWPKY2FjL/eM0i2A0Qo3DNyylRsDfSPHylJEBI6H/zcLBSOL3SZ8Vu/BZuVDt9Wsu9
         u6hOn805VWbF44awd+kkdEDe1w3Nj6c2sZQnWhzaB6JsvACiJEjDw1xB+7BX3S8Tq5PE
         4w2qPt5mrmANLLYmud6p0K9YN24XKytm07iM75+aXdO0eLKk06H2z7FASmPzHtHLh1G0
         e9tlBvF7Hi4TY0qpGj6HGUUm/gVF4d5QFyH1YcaEkT0LJeeir5JoMnyvkY2amCdrDMrm
         1w2s280ylhrwCSFQEiLEtCiDWmEbHI5dhKUvANH/Jh6d12w6EzREEBkjlA+YZaRoW2Lj
         mN5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jbKSRLmz7AprKYWxSmdsCwUxL3t+E9S5Fb7xZH5aS6w=;
        fh=gUaiYi/BQUKKu/Y0x37NFO50zCemAfk4vTLDlRpDSeI=;
        b=UxxY3mk6wpCnDYvjzV+23ManavrnndxBGvBHzVicLLc3YbMtp6mUUkWuDgl6JzqidH
         x/IY6ygFKGC3rCJwMTgXycRRl5baB+CiupTT7YvJY8HU3TpVQ8E3SY/gff8gt57eN+Qw
         fgtuUTBDpUU9JcifQpFr9WlqcKa0kQBtArtpwQHdrEDHJZhLpYxTpZIEhW8YRrX+R+cK
         KkCxJNn9ChqflIOhdzp29zRKlRv6rt/eVBGx7wyGGQX2fkrjWYveLg853UF/ee3W/JRt
         fN0gB8Y9zWP25qmLxeZc6mTm5AX8XWxe5IDnpx2UBuLd5psAT4eq95eVD0HPiFMLs4nr
         JU6g==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794554279; x=1795159079; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jbKSRLmz7AprKYWxSmdsCwUxL3t+E9S5Fb7xZH5aS6w=;
        b=Qg0E1z5MBduwZHJWMDIbrMZ0ATMDLOS3lgD+B/oDA2piSWZZeiCOWfjmHHRgqhyVRN
         KFi4yCAA2x3gBP9xx9xdjt4QP6R8ynh8S4rJ83d/ep3gPBMsPmZ6n2/w+GEdpA3PH0HH
         A33ZVNPpdFU9iD4l11SLOl2noQX0rJ2LaC9IXGkgG4wGuXa8ld5rw3hLgJMnY8+QYAp4
         cWlZ2EF0rkfP8UgjktrIXLuy2R12zFFOHFK6Z7Trc2nx9kI5IuG9/2V2Ykx5DtPCYARM
         PT3y3W2TZV6r+O62LYTj5PYCmw2Q4BjIA76r6ViGVZXnez6ON4efJHMSDXJ3HcREGBPs
         RueA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794554279; x=1795159079;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jbKSRLmz7AprKYWxSmdsCwUxL3t+E9S5Fb7xZH5aS6w=;
        b=VJZp/jdwG5upv3eUd5DNIjDFBLH7+sTjWMtStayNWhzyZhpEElALFvPAS3rg/TUoY3
         ADdp5d7ISES4hmEPqJKY2xUuwn21zdlJ1gfXrV+RLR8Wed8oeu5BRFYBU7OW8HSXege9
         kYXxTxKVkm2acdIM1XHcGDRAP/+DMUZr5liwR3c14wMr1GsL7S4k/SeLWzvPXju2OmWj
         k+calFMiQXyyZ6oS3x/52NcYwu63gyHDVgQWWiZHQ2fNKumO9ezhXmWmQu/XP9gQhwmw
         ICn52/dLHqvGyMQw4Y3jWVP1jBURVhxUJIs5N4cInW7IUeVhxIXclaV2Wco8WTYlNqJB
         xoaw==
X-Forwarded-Encrypted: i=1; AL+hErFiB22SGhIDYNey/4rcRxVE2HhU/Yd3AXbEGSCXO3im8MmQO2dwEMwi7N9LZY2ozob3osnV3JscQO7Q2lc=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8eWjpw7FwP6osp02GzeEDE+wyIElhJpMFw5kXBb37uZK437847
	MM1H05YmXmwLxqFd8BOF4XSRFaI+WVPCLpcqVgYBZveihKBiFR4XzsXvH8Qj6/orOk0lkcklqUl
	j+EJzS/JnPAaNA7wghoDvW0M7FW01PwE=
X-Gm-Gg: AYBFou3vEBWCSFqHr0hAvpptcJZS1l0AtRkCK4oPGYGxUTV3BKUQVDb6D4rKPIIz0z5
	0SRGSduFSQ23NttWENYjTMUvDmpUSjQQNxoHvgd+ZaOdIEBen1xZl6wi0umSSWVamxWwXO1WDVf
	9kNFzI9KG1AxDgJlYtgBtJIV89221oxdgXEGNW7TlEzAyQaN40AbSu1SgwVJPx74nTI6Xj3wmHq
	WLKp7R4tqU/Mo+4wHYkLjO7X8aqciBkBOgd0ear+FJ89e0YSym+EjLS5YXSG2YXFZzSvMRNdTEJ
	BskZZQar7ZFnj8YvWKbNuAmCI/fgnIGABIaKjaoGqF/3+RMI3OTHAk4CjzoiuvyRa6+wZNf1/Eh
	y5rRzYanYBvKM82955wzC9Rmy+1kf7UCC2Ots5Q==
X-Received: by 2002:a17:903:3b8d:b0:2ed:fb0:bfd6 with SMTP id
 d9443c01a7336-2edf1e7b485mr31047135ad.11.1794554279295; Thu, 12 Nov 2026
 23:17:59 -0800 (PST)
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
References: <20261110075841.12104-1-phucduc.bui@gmail.com> <20261110075841.12104-2-phucduc.bui@gmail.com>
In-Reply-To: <20261110075841.12104-2-phucduc.bui@gmail.com>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Fri, 13 Nov 2026 15:17:43 +0800
X-Gm-Features: AclHuK8Qa8UhTmu61wA20WzrbFp-wCX63PxUgDbDHkpoSTkKO8stJMNsRt0tw2w
Message-ID: <CAA+D8ANZB6jviDGAdLTc9K1ZGmmfRCSXrkpqLCuy3DVqcB8uNg@mail.gmail.com>
Subject: Re: [PATCH 1/2] ASoC: fsl_sai: Make fsl_sai_reset_hw() return void
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
> fsl_sai_reset_hw() has a single caller, which does not need to
> handle its return value. The function already reports register
> write failures through dev_err().
>
> Change the return type to void and continue clearing RCSR even
> if clearing TCSR fails.
>
> Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>

Reviewed-by: Shengjiu Wang <shengjiu.wang@gmail.com>

best regards
shengjiu Wang
> ---
>  sound/soc/fsl/fsl_sai.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
>
> diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> index 430e896d064e..59c9b8c28133 100644
> --- a/sound/soc/fsl/fsl_sai.c
> +++ b/sound/soc/fsl/fsl_sai.c
> @@ -1410,7 +1410,7 @@ static int fsl_sai_check_version(struct device *dev=
)
>         return 0;
>  }
>
> -static int fsl_sai_reset_hw(struct device *dev)
> +static void fsl_sai_reset_hw(struct device *dev)
>  {
>         struct fsl_sai *sai =3D dev_get_drvdata(dev);
>         unsigned char ofs =3D sai->soc_data->reg_offset;
> @@ -1421,18 +1421,12 @@ static int fsl_sai_reset_hw(struct device *dev)
>          * Bootloader may leave SAI running causing interrupt storm.
>          */
>         ret =3D regmap_write(sai->regmap, FSL_SAI_TCSR(ofs), 0);
> -       if (ret) {
> +       if (ret)
>                 dev_err(dev, "Failed to clear TCSR: %d\n", ret);
> -               return ret;
> -       }
>
>         ret =3D regmap_write(sai->regmap, FSL_SAI_RCSR(ofs), 0);
> -       if (ret) {
> +       if (ret)
>                 dev_err(dev, "Failed to clear RCSR: %d\n", ret);
> -               return ret;
> -       }
> -
> -       return 0;
>  }
>
>  /*
> --
> 2.43.0
>

