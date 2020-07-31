Return-Path: <SRS0=XZtv=BK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0314C433E0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 31 Jul 2020 10:40:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CB3922B40
	for <linuxppc-dev@archiver.kernel.org>; Fri, 31 Jul 2020 10:40:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NP3joG2e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CB3922B40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BJ3hs1y3FzDqf3
	for <linuxppc-dev@archiver.kernel.org>; Fri, 31 Jul 2020 20:40:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::241;
 helo=mail-lj1-x241.google.com; envelope-from=festevam@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=NP3joG2e; dkim-atps=neutral
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com
 [IPv6:2a00:1450:4864:20::241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BJ3fv53XPzDqXJ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2020 20:39:03 +1000 (AEST)
Received: by mail-lj1-x241.google.com with SMTP id v4so22276929ljd.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2020 03:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=z79UlB74SFDGkVx/wf5z/xmQkiHttzepy/SROQkunds=;
 b=NP3joG2eyPBwdPuBC5qMi8kkL6strW9nGbsOxkdGKVfI7BxLID1cEUkgnP+mlCWBxt
 Oi+nhKOnN8wnmJSr3M2SroeZ9Qt4xUC+AT9vZKu6L6+68tugEIhkSESjZv69Xj1qQN8a
 9auoue2YYBt5pDKoWjt7M0NeMZV7aSW696PIHQr9CV4Hc1DxV6ZYT+xu+nc71zXevASU
 KVYQObh7ib1jYD4VBS/DMEGRCtRJ+v86MVx8LN2D2U8gsp6Sv3pAR4dktVdayVwiZu8s
 QefOUUQIIjdbW9tb5HPWFerVWpd0bpdfcg1GsRWhLBRExqnXgLZkRubdIOEvxay8il3Q
 Rc+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=z79UlB74SFDGkVx/wf5z/xmQkiHttzepy/SROQkunds=;
 b=Og/yLcQ56Q1+Z2C9GGppKoUII9ayJzsGEGAYJPaDlDzz8QywuQsFzZKtV2/KF45FCG
 H0pV7u5XwUOrbwvFnmsQGJNOrykqNz9Hc/DHVeNU0pvLHQ6EtJlghQQTOys9Q6rrAgPE
 JoztSJzXJOEfDAz4M38wX+eEO+hBSznxY6qEMF9W01i1Oj2fzI9H5E084UqdSDzFZRCv
 dAqhdjUbPrQyAcTk0077J2VNNduayh9YTPKehFroiNq/BAtWAVbipD3FVrsLVhHdoMDB
 wcr5cnp0gSJeTTqCatp5xeo2xzvZVJ/asissuSA9GxNwG+/auGcyh7ypzXKXIXLofAHw
 FDkw==
X-Gm-Message-State: AOAM5305qUvjG/pc1bP4moLx3eKY3dXL9A7LbrQrdFqibWyH2YUHJJRH
 vVAkXHOrLsgv3QU7Fw9qi8aQKxgkJqTAeOtODzY=
X-Google-Smtp-Source: ABdhPJyTao9Lg7MGHS3w6J9lpe8D0qlnuOVVRbxEmgjJQIelAXZ79/aJ1SXFA2+uNtLKj3VoeR2KEKtfcSTSVW8aM3o=
X-Received: by 2002:a2e:5cc9:: with SMTP id q192mr1646387ljb.452.1596191937433; 
 Fri, 31 Jul 2020 03:38:57 -0700 (PDT)
MIME-Version: 1.0
References: <1596176895-28724-1-git-send-email-shengjiu.wang@nxp.com>
In-Reply-To: <1596176895-28724-1-git-send-email-shengjiu.wang@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 31 Jul 2020 07:38:46 -0300
Message-ID: <CAOMZO5C89emJ91wZsWe-APJ3OpzX=3+jHx6DAEU5kQjNLLSc4Q@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl_sai: Fix value of FSL_SAI_CR1_RFW_MASK
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Timur Tabi <timur@kernel.org>,
 Xiubo Li <Xiubo.Lee@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Mark Brown <broonie@kernel.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Shengjiu,

On Fri, Jul 31, 2020 at 3:32 AM Shengjiu Wang <shengjiu.wang@nxp.com> wrote:
>
> The fifo_depth is 64 on i.MX8QM/i.MX8QXP, 128 on i.MX8MQ, 16 on
> i.MX7ULP.
>
> Original FSL_SAI_CR1_RFW_MASK value 0x1F is not suitable for
> these platform, the FIFO watermark mask should be updated
> according to the fifo_depth.
>
> Fixes: a860fac42097 ("ASoC: fsl_sai: Add support for imx7ulp/imx8mq")
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
