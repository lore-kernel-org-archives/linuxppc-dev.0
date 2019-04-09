Return-Path: <SRS0=YLyy=SL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F0FCC10F0E
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 10:07:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D4BA2083E
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 10:07:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n/04Eq/7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D4BA2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44djdj1CDszDqB4
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 20:07:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::543; helo=mail-ed1-x543.google.com;
 envelope-from=daniel.baluta@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="n/04Eq/7"; 
 dkim-atps=neutral
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com
 [IPv6:2a00:1450:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44djbf6MkhzDqLh
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Apr 2019 20:05:47 +1000 (AEST)
Received: by mail-ed1-x543.google.com with SMTP id h22so14379622edw.7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Apr 2019 03:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nZdxuF7Yo4b5TWKbKMBtG1jI5YiJkeFgii/BbUNDMEo=;
 b=n/04Eq/7sjNaVUFVSweAFYHb2hBJwd2JX+O8YcPYcv++PWVWc+CfXKgOT9z7f59xoK
 dXGmAM6O4zIlwL294nRr+yp+XQCuHbMfeaYheFqYWkexDFK1DkFXRdcVxKH34fL5Qw35
 nllW+NxOrdud8oKWw9Vff+s0BW3Bv+xlfvj3o/LwrdadLNMmy11jAvtj/WwwmtyZKonN
 uTWQoVPM2hpsub1ht1vyLEEjFFpr4RV1XB2qmZ6fmNOHp3AVLJPjacfMXGcAx5tdFiw9
 F4TfxV+yDadQTe+ApCK78urZm8mvFXywayklmIPzUZvII0zZUXgGfubHWPf6Rq5kv1N2
 NtVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nZdxuF7Yo4b5TWKbKMBtG1jI5YiJkeFgii/BbUNDMEo=;
 b=oU09+IQqbvF4dNsHFhgjJLCXKDL0EotkmuCkWQ1QyBS9EWZD4pCzsIwLo3AO291M58
 9Gy3BCk09bsmfdD2hfCVcPsLrrprtWkL8GEuMI6YfhWTE0tn0IgZrGwvgl7GiTx+eT5e
 vJqYfa4cEmLKHcwSvzGcJo7P6qpSnnjnp2FIyV18jHaY7SzFYej8ZBzXlFqhiiUAwjh+
 5dAXY9c4zvAwJRKXeFIGJHj6aJb0KdxxiTwNYJfSzqeCIZvD0qXcN72KPKdSeXW6a9gE
 il29k4rXt17LospejZD6eSvZZvoFI0ue/m1gyPF6sfpCJyQYqBithS241qkmjxyc89SN
 65wQ==
X-Gm-Message-State: APjAAAVhPLBqZ8qZi2THKl60zzXVeHJl3jUASxFhOwhAUCy89rKYi9UO
 32FCqGMzSMHc9rvn1DS07Q2X4B6INu9WIqBD8t0=
X-Google-Smtp-Source: APXvYqzvej5fXE1PGyV2IQBupSDP0/N82QVQTCC4Q1QJEJ6tJB04URbGmmmNIE8coNueavwzh072JWrxvzYfJwh/Olo=
X-Received: by 2002:a17:906:4b10:: with SMTP id
 y16mr20454872eju.19.1554804343290; 
 Tue, 09 Apr 2019 03:05:43 -0700 (PDT)
MIME-Version: 1.0
References: <1554798876-20653-1-git-send-email-viorel.suman@nxp.com>
 <1554798876-20653-2-git-send-email-viorel.suman@nxp.com>
In-Reply-To: <1554798876-20653-2-git-send-email-viorel.suman@nxp.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Tue, 9 Apr 2019 13:05:31 +0300
Message-ID: <CAEnQRZB8ub6tyuputU51Ev9d6USg4idcXW6P6tkfuhHECAuGUA@mail.gmail.com>
Subject: Re: [PATCH 1/2] ASoC: fsl_audmix: remove "model" attribute
To: Viorel Suman <viorel.suman@nxp.com>
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
Cc: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, Viorel Suman <viorel.suman@gmail.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Julia Lawall <Julia.Lawall@lip6.fr>, Mark Brown <broonie@kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Viorel,

Few comments inline.

On Tue, Apr 9, 2019 at 11:36 AM Viorel Suman <viorel.suman@nxp.com> wrote:
>
> Use "of_device_id.data" to specify the machine driver,
> instead of "model" DTS attribute.

<snip>

>  static int fsl_audmix_probe(struct platform_device *pdev)
>  {
> +       struct device *dev = &pdev->dev;

You might want to remove this change from the patch because it touches
a lot of lines
and it makes the review harder.

I don't see any reason to have it at all.

thanks,
Daniel.
