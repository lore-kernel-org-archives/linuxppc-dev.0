Return-Path: <SRS0=Td3a=ZY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28CC2C432C0
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Dec 2019 13:06:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEEB2205ED
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Dec 2019 13:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UlyiU5dp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEEB2205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47RQNk2wVNzDqH2
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Dec 2019 00:06:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::241;
 helo=mail-lj1-x241.google.com; envelope-from=festevam@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="UlyiU5dp"; 
 dkim-atps=neutral
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com
 [IPv6:2a00:1450:4864:20::241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47RQ9p1p2gzDqMd
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Dec 2019 23:57:01 +1100 (AEDT)
Received: by mail-lj1-x241.google.com with SMTP id c19so12970198lji.11
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Dec 2019 04:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Qlt+/dRlgH3WSZzFFBm5SD3CiWvxcdEsgMu4Ka1X8YE=;
 b=UlyiU5dpvNruuaxcXO7dvcG62On/kdUK4obQpYfELq3M040cPWbk92RXty5c7XyxHQ
 JlwoKbkid8aIAN5Tj/Q45F++QZmZ8BDp2fKC3o0KiEOLkPMVj/sP/GA1ijguRSSyroJY
 j071GRkprPF86nKLRiFrKQr1QfIg+WOcCTwil4xkDqnRcrbJgBj574XnFo9nVQx06eqV
 kcfwKnDmvmw0gf1VF5eHPJ4eSqHqCr0YzpPxG11lmnzUjX/43McgbFIBGFt2hl0/+GAb
 ebjqRxaO1ouiLadvFFlXedasMYGwWmhPw3n5mRho5odgoUIv9cuc0UPXktHrNHYG+Tma
 teyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Qlt+/dRlgH3WSZzFFBm5SD3CiWvxcdEsgMu4Ka1X8YE=;
 b=XBCOnd9FjBUbXyppklKhjEcbDPDDX99Muc5p06quf1of3MkOIg2gtX8svR0ShKblmI
 KTCpq0zBbxMoGdk4lG3spffR0+nKFXkPLVcS9aiHW2UeFr7Iwipxtarmd+3erupE3vaT
 ktRxvMyXBUR9sDuMMadSk+tRG3y1MzYaPUnpUE2MoXTEuJ1HzzhVQgZqesjdem7tx214
 7LFNO7hFsB4cW5/lJrXmP20Oom74oIr3q2SJ11x1EVGzpKJYoQVv0JdAlL8D7WdPT5fT
 OawfDnydY6KuL5xZ1z3uS2aBUHb8UHicGdnH1Zj00aLf3N/fYvEJIbX7jHk4FJFl+lMR
 WCRQ==
X-Gm-Message-State: APjAAAX5xwTi+Ci+ryYp0COmcu5Ajj4AabYe8qh6ciocuSsbultzWDfb
 VouUpRmSWJ20NME4pR46CuJwg2E4vWzC+klcazU=
X-Google-Smtp-Source: APXvYqxQdPHL3wwjh1XiiAR4BKUnI9ER2eZEatvhL25goi1fFQraJN0onktSvPLymKxIx9kQLcHq96wvcClwhZw058k=
X-Received: by 2002:a2e:241a:: with SMTP id k26mr2647022ljk.26.1575291417981; 
 Mon, 02 Dec 2019 04:56:57 -0800 (PST)
MIME-Version: 1.0
References: <45ef9ee8c6265743a9c30d8e4d9dcbac1ee3aabe.1575286886.git.shengjiu.wang@nxp.com>
In-Reply-To: <45ef9ee8c6265743a9c30d8e4d9dcbac1ee3aabe.1575286886.git.shengjiu.wang@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 2 Dec 2019 09:57:12 -0300
Message-ID: <CAOMZO5AXnw7QDdfKkZ+FBwuWWvr+t0rRsHQ4muW-T00he2f73Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] ASoC: dt-bindings: fsl_asrc: add compatible string
 for imx8qm & imx8qxp
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>,
 Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Mark Brown <broonie@kernel.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Dec 2, 2019 at 8:56 AM Shengjiu Wang <shengjiu.wang@nxp.com> wrote:

> -  - compatible         : Contains "fsl,imx35-asrc" or "fsl,imx53-asrc".
> +  - compatible         : Contains "fsl,imx35-asrc", "fsl,imx53-asrc",
> +                         "fsl,imx8qm-asrc", "fsl,imx8qxp-asrc"

You missed the word "or" as in the original binding.
