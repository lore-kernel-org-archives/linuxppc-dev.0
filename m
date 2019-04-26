Return-Path: <SRS0=ImKy=S4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDFD0C43218
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 12:12:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E530206BF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 12:12:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hMHohC68"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E530206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44rCbc46lSzDqfv
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 22:12:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::543; helo=mail-ed1-x543.google.com;
 envelope-from=daniel.baluta@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="hMHohC68"; 
 dkim-atps=neutral
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com
 [IPv6:2a00:1450:4864:20::543])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44rCYb1TjSzDqdk
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2019 22:10:27 +1000 (AEST)
Received: by mail-ed1-x543.google.com with SMTP id j20so2943093edq.10
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2019 05:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=K6cWpzPYdvrM5xOSbjBFlERJHpYkz+I/GXvkEASQsMs=;
 b=hMHohC68D87OBjxb5kVGiaEDeAoO33hy2jyfIt7pG7huHaxqtTGsnSCLrzaBmW1iaJ
 KhgnXKXvaV4mUH5I6L/qfVNpvnIuXE750u9aROBTVb1GJtSNEfrEnuHdIgdH9Lg8pmet
 ZSNA58CwCaJe1D7FR+E7zf6P1AfArKGVrGGrrDLTGegJrvAl3TRuM8m4eImI+pIWlMde
 YuwYI0xt0Hmxmyai3TS4Qa2W4rhIE8r0Fw3pmymFEahSMckei6eOhox7lUXSNL4OYxEs
 mSGphCE46TEzLjhADYgqBzM14VYymylxtA4pBqwFqcxCnFMs4DMll+OGAXEPK60rP1AQ
 tWxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=K6cWpzPYdvrM5xOSbjBFlERJHpYkz+I/GXvkEASQsMs=;
 b=ggf/rOCILNk3Dwpxqglxot5ypjYmFAabiWb66N/2k68jEOF1ReW6zmUah3unoESqmC
 rnWBwBQlNMc7wyB2yAFv2RHoH/3rxdtyG0zWGzUiBQ81ALHwd2asecyVj8HvPAeOphWa
 YMSbK5/6bwYdibY+Kv59hjd3gi3d4ftlDEe3sOnq51yDT5kSyV1Ko2U+vYuuLOEnn5FU
 L7EBFvdOhDPJdFIHdCs5EkjfMDF4JgFCI2gM/ZqJ/ZwZRDAK90RzY2LTMMagIhywVYfY
 OvliT80XKpCbuKH4GC7BdMya8xt5GijlR1CLSd5FAQjMz0yYKnhQykpjauvS0u/ey95d
 TUPQ==
X-Gm-Message-State: APjAAAXRK+7xcuS6Xxo75GN0T5UrLigsCSHmZtyQYywMpwvuuKoxvD67
 8y3URqdKVXrnD/H4SrOlbEJQLFrUHAyEjZ9CX+4=
X-Google-Smtp-Source: APXvYqxfN3bxndoMxgbIuIl4dIOc0y80SLjYhQ0ObqgGATSkuduCdLsf6ZZnhBrVpZK1c8Hms2y4J7Y6UORerCMkYwg=
X-Received: by 2002:a17:906:1249:: with SMTP id
 u9mr18305012eja.58.1556280622287; 
 Fri, 26 Apr 2019 05:10:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190421193853.10188-1-daniel.baluta@nxp.com>
 <20190421193853.10188-3-daniel.baluta@nxp.com>
 <20190426100025.GD14916@sirena.org.uk>
In-Reply-To: <20190426100025.GD14916@sirena.org.uk>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Fri, 26 Apr 2019 15:10:10 +0300
Message-ID: <CAEnQRZCPPr1iHvKEj=fOsE8A2iW=XZd=CaoFqAoUqJftg4pN9Q@mail.gmail.com>
Subject: Re: [PATCH 2/3 v2] ASoC: fsl_sai: Add support for runtime pm
To: Mark Brown <broonie@kernel.org>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "timur@kernel.org" <timur@kernel.org>,
 "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
 "festevam@gmail.com" <festevam@gmail.com>, "S.j. Wang" <shengjiu.wang@nxp.com>,
 "tiwai@suse.com" <tiwai@suse.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
 "perex@perex.cz" <perex@perex.cz>,
 "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
 dl-linux-imx <linux-imx@nxp.com>, Daniel Baluta <daniel.baluta@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Apr 26, 2019 at 1:01 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Sun, Apr 21, 2019 at 07:39:09PM +0000, Daniel Baluta wrote:
> > Basically the same actions as for system PM, so make use
> > of pm_runtime_force_suspend/pm_runtime_force_resume.
>
> This doesn't apply against current code, please check and resend.

Hi Mark,

This patch is already applied:

https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git/commit/?h=for-next&id=812ad463e0894d78e93ab8017e0edbe69038c55c

The only patch left in the series that needs to be applied is this:

https://www.spinics.net/lists/alsa-devel/msg89733.html

I will reply also to that email, to be easier for you to find it.
