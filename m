Return-Path: <SRS0=X5Ay=AE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C591C433E0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Jun 2020 05:15:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CE6820738
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Jun 2020 05:15:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oR2GDEnS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CE6820738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49rZGh5tvbzDqRq
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Jun 2020 15:15:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::741;
 helo=mail-qk1-x741.google.com; envelope-from=shengjiu.wang@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=oR2GDEnS; dkim-atps=neutral
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49rZF52WH3zDq9H
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2020 15:13:45 +1000 (AEST)
Received: by mail-qk1-x741.google.com with SMTP id f18so17790649qkh.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jun 2020 22:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HzTUjRPxhEgtJpZSkWjXg3y2ucQ0p12YsNY/BwVBYp8=;
 b=oR2GDEnSD0fMlAe6QCKGq9+ZOBwBnkUaO1r3hNEMhjduhOKPmy8xoHwjiyNbSjZmvP
 CMqWcHjO4NrhlMdMkGyJHcpPtEQwTj2BOZI/3X6VAj/ZFIb4QVOQfu2Tpkorn2X5y2xG
 LHjhjwXDXLg4qBt0Wd854NyA4TOykkz66EJM2nxGY2FITG9d0Gtgbd7oy9PNjy8Fm/j5
 YZ7iMfbRd6ZAekr2EfqQwSd3Gss8TPZxQvxk/dEaVQ4zQlh0XwVQTssfD4gFxpNobhHF
 mkc9igDjsksoulDMPZ0H6Nell9/4jqilOR4kZu2WSJvmQKxBHQwRnIZgZgvMIqDttiPg
 /pbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HzTUjRPxhEgtJpZSkWjXg3y2ucQ0p12YsNY/BwVBYp8=;
 b=ATPTA8isKak6vjkm6d/g9QrV4wQpYpeFdx9dWyTwmy9HxrBYhpdppDiDqZzlFwwfUa
 7DYTUWcDArSYvN/f6AK3kf+bTyG09/8U0d39Km243mgYYQKkT1VuRlqqn/XCHgb+aaMv
 Vkg34vk2QMUqTCCHvTXyjNUoUqR6y6rDW2cDDRFjj9KDutVChI5UQr/wiCv5RPYpmD88
 8E29FhON8xqEuHc7grXQ3EazI4yu8UlVxT6d5kBwGNYOw3Gnel8NqmBlljtKDL/PuyfW
 7UpJLm7Jq6pbf3Id10FeS/lql0KoyuO7ixRlPSIXp9DRrrTpWSmcZBujODAXHSUS/pTe
 Wlhg==
X-Gm-Message-State: AOAM530LoURphR0rP9uayLkcXoBuTXof2JtHn4tkZWgM0jE5b6PLPNYX
 S03bp2ucuxTUQdlw7WWdfDqrIr/MAxF6ruODEF4=
X-Google-Smtp-Source: ABdhPJzfa5toLWKvS3pXevR0nV8DyiuB56n4keWG8hRyMYBxy22MfXqDg/6UUlR/H6iUSAMG13i3ttR0pbnoWaYmW+I=
X-Received: by 2002:a37:6190:: with SMTP id
 v138mr16646545qkb.121.1592889221195; 
 Mon, 22 Jun 2020 22:13:41 -0700 (PDT)
MIME-Version: 1.0
References: <3eab889e-75b6-6287-a668-a2eaa509834c@web.de>
In-Reply-To: <3eab889e-75b6-6287-a668-a2eaa509834c@web.de>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Tue, 23 Jun 2020 13:13:30 +0800
Message-ID: <CAA+D8ANyeND269US_e3VZg-pOVJ6Beu54C2SL19h6y+ut03OYg@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl_mqs: Fix unchecked return value for
 clk_prepare_enable
To: Markus Elfring <Markus.Elfring@web.de>
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
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 Shengjiu Wang <shengjiu.wang@nxp.com>, kernel-janitors@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, linux-kernel <linux-kernel@vger.kernel.org>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Jun 23, 2020 at 12:08 AM Markus Elfring <Markus.Elfring@web.de> wrote:
>
> > Fix unchecked return value for clk_prepare_enable.
> >
> > And because clk_prepare_enable and clk_disable_unprepare should
> > check input clock parameter is NULL or not, then we don't need
> > to check it before calling the function.
>
> I propose to split the adjustment of two function implementations
> into separate update steps for a small patch series.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=625d3449788f85569096780592549d0340e9c0c7#n138
>
> I suggest to improve the change descriptions accordingly.

ok, will update the patches in v2.

best regards
wang shengjiu
