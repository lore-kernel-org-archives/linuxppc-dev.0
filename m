Return-Path: <linuxppc-dev+bounces-23764-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 810FFC43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2026 06:09:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gw73k4fybz2yft;
	Wed, 08 Jul 2026 16:09:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::42d" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783490994;
	cv=pass; b=PyJglb260rmLgWqLwGKGUp9xrYn7AQLuf1LHbEEWEXL6rkpOkUe8/ZQte7sJKudxm/k9SpXsBkG6bfySdYOsT3i1glG6SolGMMACgzpgqwSqo6Mh1YMst6i0fCT/H6pdyUo78lEe4GWLn4xNkuqiIp9FzJjFJmfA4vP7p8yuBFyA9RAn5F84NdOS2LwB99/Dt16DepUOtixq+1L7ciTpVmtkF4w9FP3l15sQnP1cIR2e987nmGZDQyiBgeQfXQWvAyDGIfPYi5wNBXlfwrsIYP++E+9ShwD1IHoGWd+wy0auFqGz+8jVZeixrLT7AUu68KK5QuUP3vliinF/VU8unw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783490994; c=relaxed/relaxed;
	bh=x6WiABXxQHApvBVwKO6vN53M1XsHwehs6tIssYxEtas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UMH/qoKbUi+opq8NBeBQfB74Rc4/mNopMZc/seW1KWLFDQCiv18ZLFo3OXaf8A3XLV8uE8DWnPuZ20OpRClgwFMEXZpa/D/xomPREmFZufjYqiBPrkFh6a4hm5VmZ+mJ+avJpz4lHEYlvARlQ4R8zie5SgrPbpOJvq9pfKsGrNDyXxTWwXmFUVvWHnPn8pIFd+2ThwKdYTr+Af0BP67KRTEZzEV//R7mb6s2w5mUNzRgpinqlbJDr1fpzoC68ArOWxKjKgAQHMTOanQEPcXYdM/cyOyXgeUBo6S3SdU1ohUUivq1opCLBxBjSnHMTnsYnulveESO6ivqA0+hPqteYA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YMAxaCIo; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42d; helo=mail-pf1-x42d.google.com; envelope-from=shengjiu.wang@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YMAxaCIo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42d; helo=mail-pf1-x42d.google.com; envelope-from=shengjiu.wang@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gw73j5S9Wz2xll
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 16:09:53 +1000 (AEST)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-847a69ba83dso254122b3a.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Jul 2026 23:09:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783490991; cv=none;
        d=google.com; s=arc-20260327;
        b=rKxD44cQSfflo2Qv4Wgm4RxLeT+sE/nB2W5BRL/vzTcwWMbU5CPK9hp2NY3aatyRua
         1aToGpoL9LbC3OqFxauc+T6jM22z9n+bPruXdSNjOiQNU9CNVMJKmgA8Lnfp37YruWOD
         Xb9PEKpFpBfJ1ma1Yl5d1Evoq9kw4/ZEp2Y9KaciHPugXkaLo2SoX+v5eWwA2P6BW7Wh
         nOdupN2joCLj+b+5+ZrfO48kzKsSWSDKT/LmI6GiDKnh0rfgX9Be8VnISjPNvWY5w/Nm
         oVzMFf6y4eHoILBGVNfkV7ARLiISLiB4WwRcFq+Fl2+Y1+pu+AHJtFqBCG0f/1M/RoYP
         5hFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=x6WiABXxQHApvBVwKO6vN53M1XsHwehs6tIssYxEtas=;
        fh=uZEggqBSjgwB/D5nTNPaqjCz2YgqfR9csTv7apVazw4=;
        b=dD24nThUyjwZhhMo9Zwj+TmenJTVmLuQnycpuszkIiE75hwnyxwn6dbUyh83HwgvRK
         ETgoGVl5CWAYmHJ8F9XFaviWsulOt3XCr7fZrxWNeENgk76YZ4B5iaWN76W8M6zsFav4
         zfRpbI1+gewJC+8JipNPz8jHF6Z5Haee3g2QKOI1jgj4apCfUEbf2+AL7eL98dfqTfa+
         E9XJe8TyhSfSU3PVUNJAcRHh+5xp3g6kLTZJ7835U2BSapbrew+/XIiWh2jWEyZIxpyA
         DlS5pr0kxurUdjMoJsGZX4r5UvSv4QwZpVx/b8wlMz7r89QSyCgS5QJSZ5MYDUTP6E2/
         T1kQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783490991; x=1784095791; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=x6WiABXxQHApvBVwKO6vN53M1XsHwehs6tIssYxEtas=;
        b=YMAxaCIo9YeeAu06KsvWBoPZjM6XW5G7Ef0Pd9yyw+8MPofvxkl6dGo2mqdZ5fc0KG
         ZofilUSntTNg/7lOhh3Sxb76+iLfg+/6qUy5cXoJOE9dXRshF53chs/3F7TpU9tOkJAQ
         8Dc1uNi2vKam498x+QGiAQM4ZR8b+qIGyEUbJ/9QkE0EsraB0RPS3siPiv8gQuZ4cSNv
         wgMN2IZzQYv644QWock6b56+ZjGfon6p1nQabrhYDwUmM4ig03ldFGnVsnpHjYoTmL9f
         zDxC74mGFkdmSyKF+4webL3Z2rfU1s0lnRKpO7kX2GDQt6J/++272SOmj5z9qnZ7k6CO
         U6tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783490991; x=1784095791;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x6WiABXxQHApvBVwKO6vN53M1XsHwehs6tIssYxEtas=;
        b=hpO8vEWCnQq7EnJVUJXLuXgLIdbxUSCHXy8fM4PlAO6uGJh11nev4MR+Y4hdAmcYZb
         mWbgT2p6exuo8nwOfMUAc//qlt0Ti+2bpM2Wrk+Rc4jXcq4YxitMZ4C5rkExoTjXvG84
         BlSc24OUJ7YhU/WHRulNXKyiJwRIBPDyxQob0zNNWCD8JA/MjhjjIfVOjRVBhJyedLyk
         8T2+Sz6GQIf/wvXv10bjQML52KMYXw4sFOtRpb7WYRC1NjnYFC5u/GBxNqLm3iOKk5WQ
         rso71LDUditYX/X+Zu9b4oHo4DSiTzoj31iFFdvMenxHwiXDrlYoz/LDyYnZGB3DnnMi
         j5XA==
X-Forwarded-Encrypted: i=1; AHgh+Rptq901snv0MpVkJ8gdABlDnjLBy/zpZqxLVdU0z4xws8TIWlP1/fCeZbeU49Begaddyx06HX7QSTc3KgI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwYkmahSSVWQnmghU4XxM3g2iFC/J/qezVRaO6+bHLbdKUW29xE
	V+iYjBvBvEeKMnHlOYEFNc209dTvsF7mx24P35i0tBkasvbzSZy5NuBC9cGUukppIEw7B+W8D6d
	qcILoPPwSXlg0eAst1CFtXswl5gygKckIvcht9Qs=
X-Gm-Gg: AfdE7ck44XhWSQL6qxSnlRPxJAQg6IW7tFi+CDS5RHjfdic6JlMHlDbdyHAFRwjUNVV
	nr/PIYtf2DR/IdMh8wHyl4TbVEkC4hBO76JQYXYpMx+kQi2nN70FjPcySgUgM6qlqj4Pk+7VaoL
	x7XFFYR3O5JI1cJt9kkUL7Gcu84ieJ3YjpaTPUH864q4RdFz8wwQIBoXKQEBRyKQribHJB5Xbk/
	x3hU2ByXYwOt+UTrcn/fK2NOCnvmZ7nkdbtac5Oy3jdqQGqX1KybkU9/CqVpQM+DjrchTmT
X-Received: by 2002:a05:6a00:3d06:b0:82f:776f:a78d with SMTP id
 d2e1a72fcca58-84842ef95c5mr1196100b3a.19.1783490991269; Tue, 07 Jul 2026
 23:09:51 -0700 (PDT)
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
References: <20260707084648.475743-1-chancel.liu@oss.nxp.com>
In-Reply-To: <20260707084648.475743-1-chancel.liu@oss.nxp.com>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Wed, 8 Jul 2026 14:09:37 +0800
X-Gm-Features: AVVi8CfkA1sm1EIEJzmk8wb4_nU-sP-VL7lj_LgjGmnoTrYF3OkVV26pmapXYaA
Message-ID: <CAA+D8AOoO98Zi2+GP4He2zhSLaM=aKZC5F0PBu70QTFGJnp2Pw@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl_sai: Fix spurious BCLK on resume by clearing BYP
To: Chancel Liu <chancel.liu@oss.nxp.com>
Cc: Xiubo.Lee@gmail.com, festevam@gmail.com, nicoleotsuka@gmail.com, 
	lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 7, 2026 at 4:47=E2=80=AFPM Chancel Liu <chancel.liu@oss.nxp.com=
> wrote:
>
> From: Chancel Liu <chancel.liu@nxp.com>
>
> When the BCLK divider ratio is 1:1, fsl_sai_set_bclk() enables bypass
> mode by setting BYP, but never clears the bit. The BYP=3D1 value remains
> in the regcache, and is restored by regcache_sync() on the next runtime
> resume.
>
> Since BYP=3D1 combined with BCD=3D1 immediately outputs the ungated MCLK
> as BCLK without waiting for BCE/TE/RE to be enabled, the clock is
> driven prematurely before the stream is fully configured, causing
> noise on some codecs.
>
> Fix this by clearing BYP and BCI together in fsl_sai_config_disable().
> Also clear BCI, which is programmed together with the bypass case in
> synchronous mode, so the cached CR2 state is clean and regcache_sync()
> will not restore bypass mode prematurely on the next resume.
>
> Fixes: a50b7926d015 ("ASoC: fsl_sai: implement 1:1 bclk:mclk ratio suppor=
t")
> Signed-off-by: Chancel Liu <chancel.liu@nxp.com>

Reviewed-by: Shengjiu Wang <shengjiu.wang@gmail.com>

Best regards
Shengjiu Wang
> ---
>  sound/soc/fsl/fsl_sai.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> index 9661602b53c5..4c0626d572a5 100644
> --- a/sound/soc/fsl/fsl_sai.c
> +++ b/sound/soc/fsl/fsl_sai.c
> @@ -847,6 +847,9 @@ static void fsl_sai_config_disable(struct fsl_sai *sa=
i, int dir)
>         regmap_update_bits(sai->regmap, FSL_SAI_xCSR(tx, ofs),
>                            FSL_SAI_CSR_FR, FSL_SAI_CSR_FR);
>
> +       regmap_update_bits(sai->regmap, FSL_SAI_xCR2(tx, ofs),
> +                          FSL_SAI_CR2_BCI | FSL_SAI_CR2_BYP, 0);
> +
>         /*
>          * For sai master mode, after several open/close sai,
>          * there will be no frame clock, and can't recover
> --
> 2.50.1
>

