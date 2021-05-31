Return-Path: <SRS0=4WjV=K2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C22C47082
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 May 2021 07:15:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B1CD6100A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 May 2021 07:15:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B1CD6100A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Ftmlj3y8Gz308b
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 May 2021 17:15:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=KsJ+LNsM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::82e;
 helo=mail-qt1-x82e.google.com; envelope-from=shengjiu.wang@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=KsJ+LNsM; dkim-atps=neutral
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Ftml93M8Fz2xZm
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 May 2021 17:15:01 +1000 (AEST)
Received: by mail-qt1-x82e.google.com with SMTP id s12so7357776qta.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 May 2021 00:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cCshEX+xv/4SLU2fpFIKz4mOrOPFgrWQEiDI3gvxWCU=;
 b=KsJ+LNsMU7c4m6OF9/SQ64CxWH3Mtnf0VOMuFU3UOZVpbTxN5pOi+NXIzz2IJBVX8h
 VpuOk1e3s9DXPsVcQVtRLBXvGKSR6sjzvD3aCtH8qI5hg6jgYk/3YfuSroi7tybw9Deo
 IU9xXAxq+hLd7cKb3eRWra77WTIEQwfpix6LS3STrUpyv+cEog5iV06hMuuXZ7FiRDgO
 m5BCLsddtVkB6l+pRSBObY6dQaz85QMfRD3gqCfXCyOtezDOZVVav/SqxEX+LAp3bTX1
 mCEptSvETYOWh626Dxji0xnZbsJn+n2f4/ZcFNkuXvCsj3axiRxVBN6y2yG5FNQfOZWE
 AVIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cCshEX+xv/4SLU2fpFIKz4mOrOPFgrWQEiDI3gvxWCU=;
 b=DYD8EW0ZlOtakNDN1PHWbnEf1Qd3jyVJQFLcnpls5ZBSmekggCA+H13xcNDQO8XCUc
 P4MBBUL638Rixwavw/C/O+MIOdSvBpjxEs3vV3mIEYgudLeCVOU7SbeGOHBa4HrKF5tZ
 Y5TykaNd1gCh1ZqACcn8AG2Mf4iPvP4GmpJUHHU9THI4AE+EcIkjBiGbCkRVXpadKGGp
 DWLOLhqRN1Pqvg5HyVpy6aN4uFFJGpDVa7UBWe6/8qfzfFSoDnrDXPPI7FSEbv8M3r4n
 FD3M0mcCH7f2e4UJV0t5//INCpxiR7WXmb/GWB+XUFUlTCtG48JVaZJi1R+zk9BrnMH1
 VoOA==
X-Gm-Message-State: AOAM533u5CaKVYgtIiVPSTMFJq121wcXxHsgvDvBm780wxEcZ9wyMNjx
 rVsMQt3sGInhJz1sPW6OEvDS8r/9JTn3kN4Ojpw=
X-Google-Smtp-Source: ABdhPJy7JbLQBxo12CX0FUQPlIy48WVrz/mKCLthCxTBWukeUjgX6kfkepSU7NBI7LmBSGpXwXp6RuAgKrZDFg569uA=
X-Received: by 2002:ac8:570a:: with SMTP id 10mr13619650qtw.360.1622445296129; 
 Mon, 31 May 2021 00:14:56 -0700 (PDT)
MIME-Version: 1.0
References: <1622113652-56646-1-git-send-email-zou_wei@huawei.com>
In-Reply-To: <1622113652-56646-1-git-send-email-zou_wei@huawei.com>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Mon, 31 May 2021 15:14:45 +0800
Message-ID: <CAA+D8AOzEUfbCCjhJbEwXav_WWqn_aPX-0krJQ_bOJQiDJu58A@mail.gmail.com>
Subject: Re: [PATCH -next] ASoC: imx-rpmsg: fix platform_no_drv_owner.cocci
 warnings
To: Zou Wei <zou_wei@huawei.com>
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
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, Timur Tabi <timur@kernel.org>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>,
 NXP Linux Team <linux-imx@nxp.com>, Sascha Hauer <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, May 27, 2021 at 6:48 PM Zou Wei <zou_wei@huawei.com> wrote:
>
> ./sound/soc/fsl/imx-rpmsg.c:140:3-8: No need to set .owner here. The core will do it.
>
>  Remove .owner field if calls are used which set it automatically
>
> Generated by: scripts/coccinelle/api/platform_no_drv_owner.cocci
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zou Wei <zou_wei@huawei.com>

Acked-by: Shengjiu Wang <shengjiu.wang@gmail.com>

> ---
>  sound/soc/fsl/imx-rpmsg.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/sound/soc/fsl/imx-rpmsg.c b/sound/soc/fsl/imx-rpmsg.c
> index 5a9a470..f0cae8c 100644
> --- a/sound/soc/fsl/imx-rpmsg.c
> +++ b/sound/soc/fsl/imx-rpmsg.c
> @@ -137,7 +137,6 @@ static int imx_rpmsg_probe(struct platform_device *pdev)
>  static struct platform_driver imx_rpmsg_driver = {
>         .driver = {
>                 .name = "imx-audio-rpmsg",
> -               .owner = THIS_MODULE,
>                 .pm = &snd_soc_pm_ops,
>         },
>         .probe = imx_rpmsg_probe,
> --
> 2.6.2
>
