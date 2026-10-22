Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED104606A31F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Oct 2026 09:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nLJSFPoo
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j9LfC2qYTz2y7W;
	Thu, 22 Oct 2026 20:37:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::429" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792661843;
	cv=pass; b=C4w8N2ep0/ChLrJQgSdJHmU1rU/4P4SyV9IQtXly1SXBIY8YzdLTuRcXrAZw/DBR9cTPV1HeJJJmJLk4+X8lTfLCMOuVNKLqhsNH3CLSEkmw26EOQTjDcgi9f9ObbC5Vt/CDQIEmZwm3NBIRa5HnfOysxPNE/uQQHiB+ABUM/hTnqejnumKK7htIJ1Bx0YeKfpByMCPtoZ1iGaGcV641r4Z22LJuieMbMjYyHBwu13tuI/Nc/icH3PNG4WKhmpBekaSha52Vw7uNEaam9WtIsgfRmsRKJVYW5/6QSsMVyqeeLSeTtJRs1mdnOb2myRWSQAzusdhdxJF2MRYGwk70NA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792661843; c=relaxed/relaxed;
	bh=lFFS1+/t5gGgfabS/98lFLo3mEoArCKzDgJBr3YYbG0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wy9WX2+ipm7ecswBKUePqoacpkdFLmNThwVZb47xigJpCYc7nw9Sj4Po9nNyLfa79ifzA9AwZ5GdKFtenpvW1rKZ6IRVx13+wR9oUDk01I5KNglQsT4HrB7LB6ssuHTZEqoSzUDJoUK3sh/S9ASBg1F1KzBuJDWQRgzYzMIwshn1u/m2fGPNGeYxlcKPOESZNUgYB5WghFuI7qfzqFM8GJ9y5LCxt+5JTFO/Ab5Zh0Ro/Px10D6CDQGbh4GUbea+cuEIutBvxZNG6qtxP2P/oKGHEEZvgN+FmazhzYDIokR23ZpEzhdjzagjguKzo3foqFq9ROkQGm4aSJT8sxozLQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nLJSFPoo; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::429; helo=mail-pf1-x429.google.com; envelope-from=shengjiu.wang@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nLJSFPoo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::429; helo=mail-pf1-x429.google.com; envelope-from=shengjiu.wang@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j9Lf94p1sz2xjQ
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Oct 2026 20:37:21 +1100 (AEDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-8a06c60065fso1123009b3a.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Oct 2026 02:37:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792661839; cv=none;
        d=google.com; s=arc-20260327;
        b=RzClSUagGilQZOJdYWR4MHdXbNnj0k3tGTh/5azPH9beRCQAz6UmIRa4HcQhVsilP1
         mZwWqf9BREhPKaf/wIm+dUADYtZdCISBnWY0+mbUUIuXpP2Nz7HTR+4/ahtiInj/rhol
         lPsdksHIaoIf2SjCEdLqNY3sdMi8oJjj6O6aqAiH9iMBUGRwwQKhAu6Ukz34+07obVs0
         V61wDKez1xw1PaCowrlrPaLXJR1p5j/jt6ou7agpIbhZPembPEsO+CDk0FUTC+va4xD2
         Ialu86Wy7r4gH1IXPqP1G9Eb/tmRn+Zfb4hxIi3uvYeFUvAMpD6Ml1bfVXuLHcGCto/H
         9+qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lFFS1+/t5gGgfabS/98lFLo3mEoArCKzDgJBr3YYbG0=;
        fh=H0im1Gs8fBXjfex8DLc6GOoN8qDrRXAg9CEbsl+yvHM=;
        b=aChce8jyWgk8dh3ZeXTPOAlZkmI1ra1KoG0d46Te2WXffD05LZv9PrqOosYYxa7+R/
         1cO+hczt9PwLlUG7GTvFODtBslOM31UlurQCBygschn8XF0C9bpE1q6Tis159Cs82hZo
         tCpjm4uktjPWRqvg1/ZzJWCVE5LL3CL5XD4e55W+jqONx4/8v4doyAgEOuumEoxa5vAD
         fy4gEeaDibkYyn7TDyCQBrabXlQMbtqQMttnfdVmg/zqY2V1cTWxDbr4DppqoOhEeNeD
         fOb4CUnyhcXjiZ+wLF16uJC3b/ZFSL4y58ILH7KnWMdcwQdnMIxpBkTTdUzGkL1g5eTx
         Y6VA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792661839; x=1793266639; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lFFS1+/t5gGgfabS/98lFLo3mEoArCKzDgJBr3YYbG0=;
        b=nLJSFPooOiPZMLxP1yw7GCLpLoEAMljDfMVTKFg2JcED3h1PCJcqDJKSdY5iOPoPlo
         wUazNuWdWia2VU1nq1RFY3hhwqqc3WRs7HlZQ1QD+mVH32XOsOnHeOhYp3O5WOHE2K1f
         L9Mf7oyLZR9zNTOT5wloIImjag3M140xpFWcxAMdzb3s9dkra9mzT5uEwfDlpPuvzpKK
         Xe5h389eHFyLCnp5gcm/Jcsea+gncAELJ7fexF91eIuIByNeMvdkXjlM6lUpqQhcNQ/O
         kc0rPhnIlXjEB4T7snpJ0RpfuJZEe0gnJe4XuYYaUhumhinKupklXzbFPkyxFeCfbS0A
         vXmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792661839; x=1793266639;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lFFS1+/t5gGgfabS/98lFLo3mEoArCKzDgJBr3YYbG0=;
        b=b4Tmv+B0JjBD5EwGA0gn4POEVg1jX7e/lCMjFc42JG57ywLrefX1rHgKY9lQ4U7mgJ
         HTHmlfAFWqqkR8CKRRogBZElEZfRnegQn3dgxMSCUqZXSoP3G+kWIQEpHgar7tEMGstP
         M3qCQA4tNo0R8ylJHfoWtuvVPrQsREQCg7OHioyODRpwve0GVE2YOVhjjxGW90wASwnT
         ZOv3GutnMDT/khND1wj81JTHWyzyhXo2NeKWfFWY8peYxwK/ncsa1iWt1RbJEf5FpCFF
         xoyp2af23e7Ck2qSjHEuvdll1bWWEhsxGHAOmo06VhjrD8jLgtnetv0ZpowL7uTJ9UG2
         GKRg==
X-Forwarded-Encrypted: i=1; AKwUvByH5sA1KtpxBfrleAaKXweir1DwClWtj9JueX+obeD9GBm8cahSMy5NjO6044kcRiYPWUIDTCL0fQzhsNg=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYI5HjxhzSf8varMf/jjWYKzoUmlBvcplvT0h2AfEiehyUNFc0j9
	LNUlegWCs1T7mWtYWNy67Jsh+AUQ8tOLRceqoMRKVZAFMiOodV8ophVUhbrQLnvZf7G1/7wgMM4
	oXAG6VAEz/b6z1OZOMY8pow4gMxH2dSk=
X-Gm-Gg: AYBFou0XbcxelK0P4rGyT52tFnVHGmOo7Wmx4KGgyUFTlVBiCrXoO+QCSbZlE3SzquB
	ctr5RsSkxsCph7LX/Ko9SxoQuL3asicijS0bu5ecL2ZZaK1z+4vldPOB06GRuLwz5tuv4wzYsEd
	lfOZbhZyOfP1P4AAkmWbolEyj0pp/QLGXq5FqaP3YaaVme27BcceK5huKjJy7imUJy88cVLE9oN
	Z1Ij+6De2RSAjJDrmSfDt387ERzGJ66LuobI9/YADfHEMVnOmt54lW6yQTo5pDjkKSRYCgSdRRa
	vjOZpst8rEVMRDAovBZmMcvXsmjoWK5G2e8N01cZgNNtDevps0RoO4YMzwdGyHXuvjPaXGINWr7
	363d343vb9e6XlUVbBdpknMwQznH5BsYyWAdZxg==
X-Received: by 2002:a05:6a20:c6cd:b0:3e1:3178:8d63 with SMTP id
 adf61e73a8af0-3e287e025e1mr3241635637.44.1792661838857; Thu, 22 Oct 2026
 02:37:18 -0700 (PDT)
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
References: <20261019-b4-imx-pcm-rpmsg-concurrent-v1-1-c1fb8c33f4db@nxp.com>
In-Reply-To: <20261019-b4-imx-pcm-rpmsg-concurrent-v1-1-c1fb8c33f4db@nxp.com>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Thu, 22 Oct 2026 17:36:58 +0800
X-Gm-Features: AclHuK8v2lajakrSJ87vVRxpdMWjcEs90TbK_GuOR8gXyo3LH7ug2o5_RGKU8uI
Message-ID: <CAA+D8AMOW3oUoX7xJpuD=T4QJn0iDPfZqQuT1=1otZ1Dqh6otQ@mail.gmail.com>
Subject: Re: [PATCH] ASoC: imx-pcm-rpmsg: Flush pending work in hw_free
To: Chancel Liu <chancel.liu@oss.nxp.com>
Cc: Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>, 
	Nicolin Chen <nicoleotsuka@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, linux-sound@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Chancel Liu <chancel.liu@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 19, 2026 at 2:58=E2=80=AFPM Chancel Liu <chancel.liu@oss.nxp.co=
m> wrote:
>
> From: Chancel Liu <chancel.liu@nxp.com>
>
> imx_rpmsg_terminate_all() queues the TERMINATE message to the workqueue
> and returns, while the DAI hw_free() synchronously gates the audio
> clock. The two can then run concurrently, and this concurrent access to
> the shared audio clock path can cause a stop failure or even hang the
> system.
>
> Flush the workqueue in a new component hw_free(), which runs before the
> DAI hw_free(), so TERMINATE is fully handled before the clock is gated.
> CLOSE stays the last message.
>
> Signed-off-by: Chancel Liu <chancel.liu@nxp.com>

Reviewed-by: Shengjiu Wang <shengjiu.wang@gmail.com>

best regards
shengjiu Wang
> ---
>  sound/soc/fsl/imx-pcm-rpmsg.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/sound/soc/fsl/imx-pcm-rpmsg.c b/sound/soc/fsl/imx-pcm-rpmsg.=
c
> index 85b7c929a28a..6a0174d6c78d 100644
> --- a/sound/soc/fsl/imx-pcm-rpmsg.c
> +++ b/sound/soc/fsl/imx-pcm-rpmsg.c
> @@ -178,6 +178,16 @@ static int imx_rpmsg_pcm_hw_params(struct snd_soc_co=
mponent *component,
>         return 0;
>  }
>
> +static int imx_rpmsg_pcm_hw_free(struct snd_soc_component *component,
> +                                struct snd_pcm_substream *substream)
> +{
> +       struct rpmsg_info *info =3D dev_get_drvdata(component->dev);
> +
> +       flush_workqueue(info->rpmsg_wq);
> +
> +       return 0;
> +}
> +
>  static snd_pcm_uframes_t imx_rpmsg_pcm_pointer(struct snd_soc_component =
*component,
>                                                struct snd_pcm_substream *=
substream)
>  {
> @@ -285,9 +295,6 @@ static int imx_rpmsg_pcm_close(struct snd_soc_compone=
nt *component,
>         struct rpmsg_info *info =3D dev_get_drvdata(component->dev);
>         struct rpmsg_msg *msg;
>
> -       /* Flush work in workqueue to make TX_CLOSE is the last message *=
/
> -       flush_workqueue(info->rpmsg_wq);
> -
>         if (substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK) {
>                 msg =3D &info->msg[TX_CLOSE];
>                 msg->s_msg.header.cmd =3D TX_CLOSE;
> @@ -624,6 +631,7 @@ static const struct snd_soc_component_driver imx_rpms=
g_soc_component =3D {
>         .open           =3D imx_rpmsg_pcm_open,
>         .close          =3D imx_rpmsg_pcm_close,
>         .hw_params      =3D imx_rpmsg_pcm_hw_params,
> +       .hw_free        =3D imx_rpmsg_pcm_hw_free,
>         .trigger        =3D imx_rpmsg_pcm_trigger,
>         .pointer        =3D imx_rpmsg_pcm_pointer,
>         .ack            =3D imx_rpmsg_pcm_ack,
>
> ---
> base-commit: 8d00cfd77ffa64477129969eec8249c8cdadc9c2
> change-id: 20261019-b4-imx-pcm-rpmsg-concurrent-1522959ba768
>
> Best regards,
> --
> Chancel Liu <chancel.liu@nxp.com>
>

