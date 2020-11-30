Return-Path: <SRS0=CZBu=FE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8687CC5519F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 30 Nov 2020 09:02:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E23272074A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 30 Nov 2020 09:02:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E23272074A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CkzlN0QLZzDqNw
	for <linuxppc-dev@archiver.kernel.org>; Mon, 30 Nov 2020 20:02:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=209.85.210.68; helo=mail-ot1-f68.google.com;
 envelope-from=geert.uytterhoeven@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux-m68k.org
Received: from mail-ot1-f68.google.com (mail-ot1-f68.google.com
 [209.85.210.68])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Ckzfj4nnPzDr1x
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Nov 2020 19:58:37 +1100 (AEDT)
Received: by mail-ot1-f68.google.com with SMTP id f12so10560863oto.10
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Nov 2020 00:58:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=X8FoExwOHfGwv6em4eg1AHlrFN+EBui3VH6c7kGHW8M=;
 b=e37xd/qfA5t30h1rHnNc/NNeYfDBN4XYMvILHUz/GdnatDV+a/V9bzd01eVmfCkAAK
 QEnvtN3ROVAYGQ+1Mci+8AOyA+lG46xUgpmSyJApk86YXpStAPjRttr0ZS4/wMU6+yN1
 J3/0S8psLn64bbCKGcXjvT9sReG3j/aop2QMiv1tDWo4gXk4vyPJOPu2vNVsno/tbTZ3
 Ca7qqzxcrA5GYK7SB1/EHrG0B/NcdD5Q+Q8YxwsM4nEZl8zi/JsaqB4iR7RqdzfKor9k
 70vP9pW4BMY2UkPRxXpN0D84TXz2YYe5b/YY0Hivlp7pgX887sQqTQ0z2KgUeoo/2zIP
 LJQQ==
X-Gm-Message-State: AOAM532HlLKZUEy8UwIeeoocmszRiEGp4uTohk5kpeCIKBCfIy4ZsDgC
 VZiKPDT7Tx+qydkpPtfcjaU9iJeXM7FUkk96yHw=
X-Google-Smtp-Source: ABdhPJyrxbQKboqBlxNa7SnfyzU9JOt4/0bUzb0T5TziKWmjRC/+Hn6sbqGLcmZKse22Dhoci+I3ZQs7I9ocW0SW4DY=
X-Received: by 2002:a9d:686:: with SMTP id 6mr14830891otx.107.1606726714613;
 Mon, 30 Nov 2020 00:58:34 -0800 (PST)
MIME-Version: 1.0
References: <20201128122819.32187696@canb.auug.org.au>
In-Reply-To: <20201128122819.32187696@canb.auug.org.au>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 30 Nov 2020 09:58:23 +0100
Message-ID: <CAMuHMdVJKarCRRRJq_hmvvv0NcSpREdqDbH8L5NitZmFUEbqmw@mail.gmail.com>
Subject: Re: [PATCH] powerpc: fix the allyesconfig build
To: Stephen Rothwell <sfr@canb.auug.org.au>
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
Cc: Salil Mehta <salil.mehta@huawei.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, Stephen Boyd <sboyd@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Nicholas Piggin <npiggin@gmail.com>, linux-clk <linux-clk@vger.kernel.org>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Yisen Zhuang <yisen.zhuang@huawei.com>, Joel Stanley <joel@jms.id.au>,
 netdev <netdev@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>,
 "David S. Miller" <davem@davemloft.net>, Daniel Axtens <dja@axtens.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Stephen,

On Sat, Nov 28, 2020 at 2:28 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> There are 2 drivers that have arrays of packed structures that contain
> pointers that end up at unaligned offsets.  These produce warnings in
> the PowerPC allyesconfig build like this:
>
> WARNING: 148 bad relocations
> c00000000e56510b R_PPC64_UADDR64   .rodata+0x0000000001c72378
> c00000000e565126 R_PPC64_UADDR64   .rodata+0x0000000001c723c0
>
> They are not drivers that are used on PowerPC (I assume), so mark them
> to not be built on PPC64 when CONFIG_RELOCATABLE is enabled.
>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Yisen Zhuang <yisen.zhuang@huawei.com>
> Cc: Salil Mehta <salil.mehta@huawei.com>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Nicholas Piggin  <npiggin@gmail.com>
> Cc: Daniel Axtens <dja@axtens.net>
> Cc: Joel Stanley <joel@jms.id.au>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Thanks for your patch!

> --- a/drivers/clk/renesas/Kconfig
> +++ b/drivers/clk/renesas/Kconfig
> @@ -151,6 +151,10 @@ config CLK_R8A779A0
>         select CLK_RENESAS_CPG_MSSR
>
>  config CLK_R9A06G032
> +       # PPC64 RELOCATABLE kernels cannot handle relocations to
> +       # unaligned locations that are produced by the array of
> +       # packed structures in this driver.
> +       depends on !(PPC64 && RELOCATABLE)
>         bool "Renesas R9A06G032 clock driver"
>         help
>           This is a driver for R9A06G032 clocks

I prefer to fix this in the driver instead.  The space saving by packing the
structure is minimal.
I've sent a patch
https://lore.kernel.org/r/20201130085743.1656317-1-geert+renesas@glider.be
(when lore is back)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
