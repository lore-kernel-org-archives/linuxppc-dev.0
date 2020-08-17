Return-Path: <SRS0=WC9B=B3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F82C433E1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Aug 2020 12:34:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D870204EA
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Aug 2020 12:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NAHfXp4U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D870204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BVYQL39BFzDqTN
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Aug 2020 22:34:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::441;
 helo=mail-wr1-x441.google.com; envelope-from=allen.cryptic@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=NAHfXp4U; dkim-atps=neutral
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BVT4t3pKczDqRK
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2020 19:19:10 +1000 (AEST)
Received: by mail-wr1-x441.google.com with SMTP id r2so14218532wrs.8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2020 02:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qX871vE+FuBcMCwIyoO/B6faScex0KuAjvcf8gzD10o=;
 b=NAHfXp4UBf6Jibtr2eCLhEO9YoL8Wt0anDkAAE2K5TZU53xG1vkvMB2EgNCPhxmGx5
 5T32Kbcf1FdbzuearoAM/32+vKjxF0vhz64kmxZbU9ko7qcmNfkyTlqyF/GFcyxSVLrJ
 4AipYvBmctHdf5NScgCdQmoDe6GBXy6cl050KRWSjF4d85M4QevyefgyHJWjxGkWqVTS
 bbVXr1TUoX220i171lSN7bFYORPx8K6513VEN6ttGYOEkm+naSJ8p2UZxdk0z7fJNMaf
 FjjpeZuHmTS3NmdyQULQ9ufpXW+PaUMUhtPwUwlVvQxYUkLL8MOw27x70MEt5E9DxpzO
 VQNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qX871vE+FuBcMCwIyoO/B6faScex0KuAjvcf8gzD10o=;
 b=UBfjVrwVeqp9+U6Cdny+p7qOPvRNr+L/OLXswHSQMgzTMOi63LJ5Tl7sWmRoY09qIg
 l2a9FTr2HCNqdQAzfQjvVxl7XJHo3ul9BOxUYySHljznsRVxPTvP8NoPaG+iuCjxQbCr
 waNyqBh/kCqF8iLZ3EUx0Xqn5zzCt27VhmBisZvhUKLPXLEYtopdacpf2k5opaNGqCsW
 bXRrbujd/6qjmJXD+tRsB3rMdo5Af4G4frTVKTh8mZwl07ZATTPYWhcGGYl1aQt4hbh9
 zhSDnLIEG0VN3J0mhxmcht61Eyu3pBrKK3Y+Maythy1Dc2S/ttRd4wgKMVIABQYJ8oGH
 hlXg==
X-Gm-Message-State: AOAM5301KQLO/U/Gjh2Kim4qhZtSYLxgAgMmjwu2tIIUfWbCkGGabJup
 jFUadCOCFRCcxhwoKczwCm6DSzsUxN0n2km0Da8=
X-Google-Smtp-Source: ABdhPJyqCR0rK5Dp5nj1dXQBMsH1a4xuJvfOer49VOTuXmGUa+ctG1GwTxQ2v/dZNgABIn1M51tgRR3MnRWB5D7Osl8=
X-Received: by 2002:adf:b1dc:: with SMTP id r28mr14132586wra.242.1597655944611; 
 Mon, 17 Aug 2020 02:19:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200817085703.25732-1-allen.cryptic@gmail.com>
 <s5hpn7pprl1.wl-tiwai@suse.de>
In-Reply-To: <s5hpn7pprl1.wl-tiwai@suse.de>
From: Allen Pais <allen.cryptic@gmail.com>
Date: Mon, 17 Aug 2020 14:48:53 +0530
Message-ID: <CAEogwTAGHOfBe4ztkx9To0gQGwHwFWzCBxn8nzWJP=wRJUJ56A@mail.gmail.com>
Subject: Re: [PATCH 00/10] sound: convert tasklets to use new tasklet_setup()
To: Takashi Iwai <tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 17 Aug 2020 21:23:58 +1000
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
Cc: alsa-devel@alsa-project.org, keescook@chromium.org, timur@kernel.org,
 Xiubo.Lee@gmail.com, linux-kernel@vger.kernel.org, clemens@ladisch.de,
 tiwai@suse.com, o-takashi@sakamocchi.jp, nicoleotsuka@gmail.com,
 Allen Pais <allen.lkml@gmail.com>, perex@perex.cz,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

>
> Is this targeted for 5.9 or 5.10?

This is targeted for 5.9.

> I have a patch set to drop the whole tasklet usage in sound/*
> (destined for 5.10, to be submitted soon), so if that's for 5.10,
> it'll be likely superfluous.

 I have picked patches from your tree to adapt to this new API.
Those can be picked in 5.10 I suppose.

Thanks.
