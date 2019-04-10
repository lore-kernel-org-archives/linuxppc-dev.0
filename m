Return-Path: <SRS0=mr1i=SM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A5CC10F11
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 14:29:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D04220854
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 14:29:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qur21Nd3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D04220854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44fRPT614hzDqQG
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 00:29:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::241; helo=mail-lj1-x241.google.com;
 envelope-from=festevam@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="qur21Nd3"; 
 dkim-atps=neutral
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com
 [IPv6:2a00:1450:4864:20::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44fRLS34HMzDqP8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2019 00:26:56 +1000 (AEST)
Received: by mail-lj1-x241.google.com with SMTP id v13so2336122ljk.4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2019 07:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+y2p16iLH2m+HtsDYjG0iV8Z/Xh7rWVUwWRMS6QiGYg=;
 b=qur21Nd3eXlCOCpoEFR24g1NyRtYtiWtwK+5j0rn/tP6R781DwDcKg4l9B1YnInwx6
 1R37Ajvmyh8Cq+ejttt6SXGT6fE7b4Hs08s8GED39xpyH5XskkDVSHAntZV8E3WlM5V+
 nThkoK8M2cbOWDifJnDn1bGmo2Q4EH7bclNsCujLMGK/SCONS+Misg5YRAej1Ah0QnPw
 6IhyH3NEsZYS2hD67M+O6QB8QYS2+BOqozSKOrWj+83WkPyise6Ekln+dx72ncQibzbZ
 Av01zUUGHpzq6mtUcBXoJuKdsWavf148j5N9hvgk4cle+EgJlQBak7aWzROJq5MpndzB
 zL/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+y2p16iLH2m+HtsDYjG0iV8Z/Xh7rWVUwWRMS6QiGYg=;
 b=gYpLhaUKezJjTEdBM/mFOA/HocH4JbIKnODJilhP9BBlRyZK/iAnsufe0YPwHdm7vX
 WjsWLH58M2OEnlQXIo1SGpAG4gF1StTErVFrm7PkEdzTaxXHUd8eUF62MwFGGPxgx9Z4
 CE5c7n64QVn67d94Abr/bvmRYfMPnaY+yXcypWPxkIiT66NGuo1+Ber0bnmstGlLWufa
 YHW5dlwP6vFuw1KyF7ZhZK+7IWGXyQP1XX4iXtLwyELC5hD+S9ISPbXWIK5NKfBM2Jfn
 x5vPFeX5Xr4kbLgRnzx7SBSb46XXbw7CeUZmbknOVmdD8B4k+rHqVysDTBXhFzMdg94C
 EY/Q==
X-Gm-Message-State: APjAAAUY2m8AuRoDLrREaj3Tw4LeEzLM5r72YcBNxgmEAYs8Mdhzp5Mz
 rUxyCuZg+UBw2tkh93h/B+XzWZZsXRd+nRb1D6A=
X-Google-Smtp-Source: APXvYqziHI7r075gt/OuJfM9PFekJuDcOB9t2Jlm/nkuFEzgM9PwxHF6IQTGleEkMqqAnzytrssxspZXshP3JVGaKcY=
X-Received: by 2002:a2e:97d3:: with SMTP id m19mr3223389ljj.63.1554906412051; 
 Wed, 10 Apr 2019 07:26:52 -0700 (PDT)
MIME-Version: 1.0
References: <1554894380-25153-1-git-send-email-viorel.suman@nxp.com>
 <1554894380-25153-4-git-send-email-viorel.suman@nxp.com>
In-Reply-To: <1554894380-25153-4-git-send-email-viorel.suman@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 10 Apr 2019 11:26:46 -0300
Message-ID: <CAOMZO5AM0OOTc0SKFMDGWnDpAWrM0-1cyeQjYb-7ZzX558hK=g@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] ASoC: imx-audmix: fix object reference leaks in
 probe
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
Cc: Mark Rutland <mark.rutland@arm.com>, Viorel Suman <viorel.suman@gmail.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Julia Lawall <Julia.Lawall@lip6.fr>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Mark Brown <broonie@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Shawn Guo <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Apr 10, 2019 at 8:06 AM Viorel Suman <viorel.suman@nxp.com> wrote:
>
> Release the reference to the underlying device taken
> by of_find_device_by_node() call.
>
> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> Reported-by: Julia Lawall <Julia.Lawall@lip6.fr>
> Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Please provide a Fixes tag.
