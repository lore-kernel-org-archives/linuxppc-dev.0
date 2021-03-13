Return-Path: <SRS0=FWXi=IL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 141F9C433DB
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Mar 2021 20:26:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55CDF64EC4
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Mar 2021 20:26:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55CDF64EC4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DyZ2n35GLz3dC3
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Mar 2021 07:26:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=K0kEop7C;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::22e;
 helo=mail-lj1-x22e.google.com; envelope-from=festevam@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=K0kEop7C; dkim-atps=neutral
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DyZ2K0FjQz2y0J
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Mar 2021 07:26:00 +1100 (AEDT)
Received: by mail-lj1-x22e.google.com with SMTP id 15so11613795ljj.0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Mar 2021 12:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nXwzLOYKpkiq1CLhD7qyOG97MFYVynskpPPG4YAoxy4=;
 b=K0kEop7CHc8u9qijPjvgU2L1W3jO1BD3jpACZXK2KiSoFCiGPk9zchyq5/6YfLjrG+
 ppGZUecH/5ysyVwQVIRK/QEWq3zmDSt5d1P6UDAhCNtLR7no89kZvstWKfs8NqLCOePu
 P/OJimCXQF/TPHY8AeLKs+F5aRJf8d4pJJWVARHv+P0W1r5dAcnQc8YbEv78z7GBAKZH
 DdI8swCdgYvNSkFIY4nlgEcwI/D8n5BsLJDfhK8AT+6Uun3WGhxOARrUDSO58qhuigKC
 W58suNOeVWIWk2hBC0OBl5zJqU1yHrgtfQV6sOKWjooi5UHOcAWpjEpQGVCnL7E/DVt/
 5bag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nXwzLOYKpkiq1CLhD7qyOG97MFYVynskpPPG4YAoxy4=;
 b=m7fMnH6UFlPEfxoXerd7rrJpCJmMi6hIw1Z3OAES/hM1mCYMA/O9STUYBP8IvnjSm3
 uJwBTQOAgLAyd3ykP6xjZrPTQPH0sqb2j6CPi0rq1kej980maKGQMDR3FjcMdo2FmoIi
 8fPT5orAHcg8RWZzc6SRcHpAdCcwWjQLiGdiZvOP7oaoMBni4aa3gfq6LfM6zmwiEtTB
 wyQleH2hB5DAg7UAHNM7XGMi4NuiVKZpxONVeJHUZtk7/TjfRCUgg8cMzpmh3n0eiqtX
 1W4FSc/r8mCZ+KDM6YahR1y3w1N2EsibC6NKATvSuiaoT9+pOicZXWnow81byi0ugmkO
 kTqQ==
X-Gm-Message-State: AOAM532l3NM8bZEvC5IRWM8uFlYLdr3qt7vAS1WuqTOKlMw1GcpNyojW
 xjPD3rsI9qLgOGyhCfwSRPs4ryuPYyLqw/V0v5s=
X-Google-Smtp-Source: ABdhPJw7Ss7EWBxQBvdRZ94nulcY04ujzJ00fZWur8s/HypB+wsz+o6b9J0bYTqO61ZQY6vOrDbXOXoteVmmI7NrjvE=
X-Received: by 2002:a2e:b8c3:: with SMTP id s3mr5944317ljp.264.1615667156726; 
 Sat, 13 Mar 2021 12:25:56 -0800 (PST)
MIME-Version: 1.0
References: <1615623820-16592-1-git-send-email-wangqing@vivo.com>
In-Reply-To: <1615623820-16592-1-git-send-email-wangqing@vivo.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 13 Mar 2021 17:25:44 -0300
Message-ID: <CAOMZO5BSxSo3TRAeZNhFiiF1r5PxecUGJc5p0ekF6709U3x_NQ@mail.gmail.com>
Subject: Re: [PATCH] sound: soc: fsl: Remove unnecessary THIS_MODULE
To: Wang Qing <wangqing@vivo.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel <linux-kernel@vger.kernel.org>, Timur Tabi <timur@kernel.org>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>,
 NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Shengjiu Wang <shengjiu.wang@gmail.com>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Wang,

On Sat, Mar 13, 2021 at 5:25 AM Wang Qing <wangqing@vivo.com> wrote:
>
> As THIS_MODULE has been set in module_platform_driver(), so remove it.
>
> Signed-off-by: Wang Qing <wangqing@vivo.com>

Thanks for the patch, but someone else has already sent the same.
