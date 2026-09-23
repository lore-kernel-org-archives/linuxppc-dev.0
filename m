Return-Path: <linuxppc-dev+bounces-28006-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9454C982EA
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Sep 2026 10:13:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hqXqP5Nm9z2yqq;
	Wed, 23 Sep 2026 20:13:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:3b::f" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790158417;
	cv=pass; b=PfIICBjBJoE1RX453mULhcOrhcGfbzboQonp6AoTdPpLELSXFhx5ZgqtZrKqumxgjSkoxeJ4uBVRDcK5xViJI5bTLSeHTrIcB5/eh6Q6nayDxafzVpSM4w52lu2udAwRwWxnMueaHinKmtojRtWz7h6P6VQBIzOEPIdVyupEfHvUUlEmxruznrQ6bh+u21xAT0iyBMRx6sbhdx7ckYhB20KufBa9VRGNe6jgZvYI3TRuSJk8yHbOTHZ+J5wpDPTjoVzQHsDwRgfKXUVhSzVnEClMnScL9h/vbfzvGvouZ9ZYQ+HUqdSXVqpu076q6Z59xzvepsHzXDk6o9EcDyW4Sg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790158417; c=relaxed/relaxed;
	bh=T8UPdY8cxlA6aoPjewzNTQu1SQVA5gFWIlU2oGV5oPs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oSsPpcAP3EraZraobz4+YxnJc10ecfpTisPXm8FjbgeJcNeWPxCB8F7ICHMR5PRYUkKUErbXk6Hfgr95TRMThe8BXF+ROKYcUIYb6TUEJPpfB+WC40UbfAwGubL3g2iQUq8xoxa4D5dcOICIX9CURESUvLkEkpGZDbfNrf93mMY2kXbz6/e5WDROeQfsCi7+5u8+lQrOdUXK9PDScx0mB3v7I5JvzP1AZ0lwWImyKMP1yx/YIjQPveRZMY1nE6RlixuojPQm6kFv33RYghBNtnMJVqUadFSug+WrdJ7NI+Yjjll5M7ipwmrRD9j5Tiq2J2QAUU6+GA3qX2DEDjSBMw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=s3d3ls8x; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:3b::f; helo=mail-pz2-x0f.google.com; envelope-from=shengjiu.wang@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=s3d3ls8x;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:3b::f; helo=mail-pz2-x0f.google.com; envelope-from=shengjiu.wang@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pz2-x0f.google.com (mail-pz2-x0f.google.com [IPv6:2607:f8b0:4864:3b::f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hqXqM4xwXz2xs1
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2026 20:13:34 +1000 (AEST)
Received: by mail-pz2-x0f.google.com with SMTP id d2e1a72fcca58-85f0fc1fd8eso384271b3a.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2026 03:13:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790158411; cv=none;
        d=google.com; s=arc-20260327;
        b=aIxXWyJluEQlFB/wYJ7fLDmVQmW7Mmzr+iecAOx9gyK+j6Ksfu6zesiDcqJ923GYHJ
         4M3JNSYAKJWLeJpQBeOxRaWY4/OSQ1vhDSzlJicjci936EfmpKCWuaGHIt6WWuWBKu3N
         2NnqZcF5I5LC0WjmdP7UJv6H+3vx2Gu3t07XpEcuwWEUtfFktmKjKMNl8ia4qREXFhax
         fCF4ZggSh/GHfPextvblwL3OOLljF6/iud3pM98RvqRVEf7uLExFb/0wpxnikwDCy26K
         DlO3Cf7B1u6/FgLY+B6UAWK8BqzIs3F+1hBpepFmSsToC9GTeXDVCRevvvLG8wsKh/JY
         R/NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=T8UPdY8cxlA6aoPjewzNTQu1SQVA5gFWIlU2oGV5oPs=;
        fh=btPhuXnEQTl+YMB2Q+ZCzCj9UiKqT6TYfNeo2CRl4EU=;
        b=c7ubphjIsxOnEFMnUV+3LA5dAReA8/sAU/obB//7ZFPJddvYcxqtuRibMYZiyRhiw1
         2EgrXYzHYJK/4/B+6RrX4GGaShYrxR2oAHO+w/aK0ciaJJFm5ii/hRjNtPfdw1BB4tSL
         usqPC6Rm6oPZC3rkf3UWYdXlBXE/bnMScmYq9LzS/dgvtgpazJyMBhViATKvt5pXYRX/
         K7S8k1WDgg4MdmwUlggR3LTgfmBVYQ31XF255Eve98SZqsuqAUJc99vDiEAU4GJOQDcx
         DME7JNlwav4vuVZE+R0A56HPjUQ6cIQCB9yEpgO/OGRrYvOd3NJNR6bbrzwqBxfqYLL3
         akMQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790158411; x=1790763211; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=T8UPdY8cxlA6aoPjewzNTQu1SQVA5gFWIlU2oGV5oPs=;
        b=s3d3ls8x7fJf/0TEXF9i4/zNjcINsZIi7GdKeCAU22z1ZLg5QwMI54VWbZOHYcG8aq
         Z2h92SkHWg9V/wLXEa3zIiIaSIXA+7u3G5L6hYT9D7lJ4lkCrggUuFnuQYLQkFXNopKH
         YRBcDxagtKrGpjwGu6AjROXTn7tjpEiHSr0xWeMbT5IWsuveQBryHNSha1+OLN39c3my
         M2WagkZImjl/GSYnIwZivqGghgZ1vI5Qd3fXki7syh3lzwSx8WYo2r3HHfmw0YlvIonl
         EsipaRZdjgtvT9XPKjQP4aa+mWsSJdC7lRi00opl2y88ltK2XUEaPshlK7EaQ9WGVua4
         g4qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790158411; x=1790763211;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T8UPdY8cxlA6aoPjewzNTQu1SQVA5gFWIlU2oGV5oPs=;
        b=L0CahWiSJvrIp82/yf3gSvTj6reWGDDRQqZau22mfW3DJcTQ6v8sltv2/tjsfQJdwK
         E2116Rdive1cL8fCd4r+mmcx1u9wYJvxbCxAi+b7cD1SDkAsKHkItRQRxAVWOJX6MQIg
         2tAI1L3csVrC5fhsIolTmey26OSDYPbjTd/E1utynqbrTdsS4KbRINTahDdbbjuEauf9
         uroitSsOh5ZScjD0S2hxw50Te2zkcTUymAKN8eAIBnUIDxsofULP4+UC4tOTtE4kirUU
         rYUeGEovwzUzk/1lsnQThZV5Wv90Py1Kh7P2gbUi0A6Zt6Urh8CDIFngc4vzdqWmipxc
         dHrQ==
X-Forwarded-Encrypted: i=1; AKwUvBzWj67/eYEBjt78ldxf7NwL5T2STYC9RpZE4zXcz+tkBspfvROJc76jhkOoBr4Qzl4hQameXc2PqHaLKRc=@lists.ozlabs.org
X-Gm-Message-State: AFuF++msFLU9UtTc0RZHR6f1Upb6blxH3RuoHe+U9w8PLh7KLrnKbJS3
	1qIcPLYPWRMIAxpvF1OApC6bVGUS9ExKxJ2w91baDjiEYTCXOnl6O7yb9DpdZA74KIk9Z36gTTY
	SK/M1HvkcIgdJF+SFzMyWfXmQx4I13UM=
X-Gm-Gg: AYBFou11ASw34BOqSsnpB47ELWzdbtqhmuFcKEpxgP1ngp+WEvZ2vB/VnTYLNyf/t0U
	8zI8lGTlC3ZmrLOdb7jpkfj/pAw3x89Gzi0R7rYXrVRRXYb1JoJJLSP+qR0/j14sYzdy0udm2Ou
	Dwawo47lCOCXZRClabpM4SRW9IBSsu7g5JmPdjt0Tdkbeae8g9Ayif/qJ/sbFF7N1nvbVkfWn+p
	Nn6TDaEnvODoVujprfocq8aPBwRLYzVVV7YleaTpflCTBB5zVlyr7ScV/ZJJfdeoRsqBGo/myNN
	XrAVg3kpO9UzOx7wEeewszXZv99APrqz5WQ0uHA+4P9vRQfpTWxWZDjeP03DkvA2Kw==
X-Received: by 2002:a05:6a00:1489:b0:845:ba94:a56 with SMTP id
 d2e1a72fcca58-87d1a7ade4amr1946462b3a.5.1790158411345; Wed, 23 Sep 2026
 03:13:31 -0700 (PDT)
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
References: <20260923054017.93553-1-mhun512@gmail.com>
In-Reply-To: <20260923054017.93553-1-mhun512@gmail.com>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Wed, 23 Sep 2026 18:13:18 +0800
X-Gm-Features: AcwNN1XtFHREsFLdPRUiEqLGtk9NvYoAB2IZLiGY3P6QqpB_FT8nAPCPpRvlyaw
Message-ID: <CAA+D8AMQLkprPdOrT=oYR0dMmy0TqDdy1rZ3nXP6nPoigdsBuQ@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl_xcvr: free IRQ before canceling reset work
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, Xiubo Li <Xiubo.Lee@gmail.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Fabio Estevam <festevam@gmail.com>, 
	Nicolin Chen <nicoleotsuka@gmail.com>, linux-sound@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Ijae Kim <ae878000@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 1:40=E2=80=AFPM Myeonghun Pak <mhun512@gmail.com> w=
rote:
>
> irq0_isr() schedules work_rst on a preamble error, and reset_rx_work()
> touches regmap.  remove() cancels that work while the IRQ is still
> registered, so the handler can queue it again during teardown.  The IRQ
> is also requested before INIT_WORK() and spin_lock_init().  Probe
> failure does not call remove(), so freeing the IRQ leaves queued work
> running, and an earlier interrupt schedules uninitialized work.
>
> Initialize the lock and devm_work_autocancel() before the IRQ.  Failed
> probe then frees the IRQ and cancels the work.  Unbind frees the IRQ
> before cancel_work_sync() and pm_runtime_disable().
>
> Fixes: 1e5d0f106164 ("ASoC: fsl_xcvr: reset RX dpath after wrong preamble=
")
> Cc: stable@vger.kernel.org # 6.13+
> Assisted-by: LLM
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>

Reviewed-by: Shengjiu Wang <shengjiu.wang@gmail.com>

Best regards
Shengjiu Wang
> ---
>  sound/soc/fsl/fsl_xcvr.c | 26 +++++++++++++++++++-------
>  1 file changed, 19 insertions(+), 7 deletions(-)
>
> diff --git a/sound/soc/fsl/fsl_xcvr.c b/sound/soc/fsl/fsl_xcvr.c
> index 9828272..29929df 100644
> --- a/sound/soc/fsl/fsl_xcvr.c
> +++ b/sound/soc/fsl/fsl_xcvr.c
> @@ -3,6 +3,7 @@
>
>  #include <linux/bitrev.h>
>  #include <linux/clk.h>
> +#include <linux/devm-helpers.h>
>  #include <linux/firmware.h>
>  #include <linux/interrupt.h>
>  #include <linux/module.h>
> @@ -57,6 +58,7 @@ struct fsl_xcvr {
>         struct snd_aes_iec958 tx_iec958;
>         u8 cap_ds[FSL_XCVR_CAPDS_SIZE];
>         struct work_struct work_rst;
> +       int irq;
>         spinlock_t lock; /* Protect hw_reset and trigger */
>         struct snd_pcm_hw_constraint_list spdif_constr_rates;
>         u32 spdif_constr_rates_list[SPDIF_NUM_RATES];
> @@ -1617,7 +1619,7 @@ static int fsl_xcvr_probe(struct platform_device *p=
dev)
>         struct fsl_xcvr *xcvr;
>         struct resource *rx_res, *tx_res;
>         void __iomem *regs;
> -       int ret, irq;
> +       int ret;
>
>         xcvr =3D devm_kzalloc(dev, sizeof(*xcvr), GFP_KERNEL);
>         if (!xcvr)
> @@ -1705,12 +1707,22 @@ static int fsl_xcvr_probe(struct platform_device =
*pdev)
>                 return dev_err_probe(dev, PTR_ERR(xcvr->reset),
>                                      "failed to get XCVR reset control\n"=
);
>
> +       /*
> +        * irq0_isr() schedules work_rst. Prepare the work and its lock
> +        * before the IRQ, and register the cancel action first so a fail=
ed
> +        * probe frees the IRQ and then cancels any queued work.
> +        */
> +       spin_lock_init(&xcvr->lock);
> +       ret =3D devm_work_autocancel(dev, &xcvr->work_rst, reset_rx_work)=
;
> +       if (ret)
> +               return ret;
> +
>         /* get IRQs */
> -       irq =3D platform_get_irq(pdev, 0);
> -       if (irq < 0)
> -               return irq;
> +       xcvr->irq =3D platform_get_irq(pdev, 0);
> +       if (xcvr->irq < 0)
> +               return xcvr->irq;
>
> -       ret =3D devm_request_irq(dev, irq, irq0_isr, 0, pdev->name, xcvr)=
;
> +       ret =3D devm_request_irq(dev, xcvr->irq, irq0_isr, 0, pdev->name,=
 xcvr);
>         if (ret)
>                 return dev_err_probe(dev, ret, "failed to claim IRQ0\n");
>
> @@ -1751,8 +1763,6 @@ static int fsl_xcvr_probe(struct platform_device *p=
dev)
>                         fsl_xcvr_comp.name);
>         }
>
> -       INIT_WORK(&xcvr->work_rst, reset_rx_work);
> -       spin_lock_init(&xcvr->lock);
>         return ret;
>  }
>
> @@ -1760,6 +1770,8 @@ static void fsl_xcvr_remove(struct platform_device =
*pdev)
>  {
>         struct fsl_xcvr *xcvr =3D dev_get_drvdata(&pdev->dev);
>
> +       /* Free the IRQ first so irq0_isr() cannot requeue work_rst. */
> +       devm_free_irq(&pdev->dev, xcvr->irq, xcvr);
>         cancel_work_sync(&xcvr->work_rst);
>         pm_runtime_disable(&pdev->dev);
>  }

