Return-Path: <SRS0=RHZ4=QV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F67C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Feb 2019 08:14:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 816D52229F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Feb 2019 08:14:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 816D52229F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 440TgY4ClLzDqKt
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Feb 2019 19:14:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.217.65; helo=mail-vs1-f65.google.com;
 envelope-from=geert.uytterhoeven@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux-m68k.org
Received: from mail-vs1-f65.google.com (mail-vs1-f65.google.com
 [209.85.217.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 440TcZ399mzDqSj
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Feb 2019 19:11:26 +1100 (AEDT)
Received: by mail-vs1-f65.google.com with SMTP id u13so2148040vsk.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Feb 2019 00:11:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4a3D100K5NwmmTPJJ0s35hte8UB4taiTrnr7PheOHpw=;
 b=AdCLHwE6haGLiCnkdts9alkfR8lf1Bf6foTyhwfjjlUOxT2J13drBffadhtDA86nLh
 gyx6875lFxMvoMq/kdUgXT3IRDxw7DtI5tPTzibROEptWK2UJtwcdiEmQLFvEFo6u2Ra
 ZtkBqF+vJwV4q5ljvA0T4rB563uiA71PIXDE+pERxihGFaO9KtrIfvMSibIJndzbQNKj
 ePUBeGgV+RFy/h+JR56Ou/Va043/IKtAAS0b5LijdfSEzF0FNpzYrY/VxwiemV6ClB2j
 mnizXi1geNVPuEmPSBxFvWF9vlD5nynulRCoVdYFUSUMwgEJM1XO7Vw7fwVy9Gz+c7RW
 radA==
X-Gm-Message-State: AHQUAuYnOBTSqelveJeLVzEnykt04eLkheIdSqZykfLhYs/SqUeejLsx
 CoCi6cmZDoeWYVKGKUrCLpIGaJiiVYqPFT6h0sI=
X-Google-Smtp-Source: AHgI3IbxtQI24QYjPRnNrEhWZ+8rGpNy2/UZnWXN5HqiJOduvEND65+eZoiExYXcsXnh4oeImmJLyQnV8CZhtYrIpSc=
X-Received: by 2002:a67:541:: with SMTP id 62mr1260865vsf.11.1550131883912;
 Thu, 14 Feb 2019 00:11:23 -0800 (PST)
MIME-Version: 1.0
References: <20190213174005.28785-1-hch@lst.de>
 <20190213174005.28785-8-hch@lst.de>
In-Reply-To: <20190213174005.28785-8-hch@lst.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 14 Feb 2019 09:11:12 +0100
Message-ID: <CAMuHMdWDBaz1hLxmeGa7k3mzt-8GAoGVEQVSfeVX2CCpqrY-KA@mail.gmail.com>
Subject: Re: [PATCH 07/11] init: consolidate the GENERIC_CALIBRATE_DELAY symbol
To: Christoph Hellwig <hch@lst.de>
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
Cc: linux-xtensa@linux-xtensa.org, linux-s390 <linux-s390@vger.kernel.org>,
 linux-kbuild <linux-kbuild@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 linux-riscv@lists.infradead.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Feb 14, 2019 at 3:25 AM Christoph Hellwig <hch@lst.de> wrote:
> Add one definition to init/Kconfig and let the architectures select it
> if supported.  The only complication is xtensa, where it is a user
> visible option - we introduce a xtensa-specific symbol instead to work
> around this.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

>  arch/m68k/Kconfig       | 5 +----

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
