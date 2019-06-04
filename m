Return-Path: <SRS0=V6lO=UD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 822B9C282CE
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Jun 2019 08:04:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11FEC2403C
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Jun 2019 08:04:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11FEC2403C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45J4Fb0xYRzDqPB
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Jun 2019 18:04:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.208.193; helo=mail-lj1-f193.google.com;
 envelope-from=geert.uytterhoeven@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux-m68k.org
Received: from mail-lj1-f193.google.com (mail-lj1-f193.google.com
 [209.85.208.193])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45J4CT6FTszDqV6
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Jun 2019 18:02:29 +1000 (AEST)
Received: by mail-lj1-f193.google.com with SMTP id t28so7625073lje.9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Jun 2019 01:02:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YKrWcEE+1+xOTvbjgAfsUzEO5QbPrU8ilMZ5XA3rETw=;
 b=idC8QPRUjSC1khBWok1p8Hz4hB/FhT3dGtRo7lfVJ96xmKnCn2f/W6mRcMg4ZNB7Ja
 nCvpW7bh3fY2o6oItRNNeuDyzYBYcdttdfgG3neebkWsZZZPNhb6512DSPCMewZx40zW
 ldCwYx034VW4SMnlNDeW5cOk0BeyEWAXZTjFifSdMMXKJ+4MEMyC1XfwzO9UQ3GK2mRo
 NY08tOjfFFgxk+c61yuhct05LpC1tkS5BLtDCrbmTX0wNB3kp/ncZxoA8MzTedakgrdz
 zqiJEqoEZI7D6afjsFmtUWrzALMbziOZI2NGbxBt3Fxxgg6nVzylTXn6/8ORutcOTioY
 s22w==
X-Gm-Message-State: APjAAAViXjDko1NC+YU6VtWegUQtsDDVUsf2OUDO/Dhqvd6GdyLOUXce
 Ti17AVh83EHRy8DcSxGqoR/ohrWcaXN3f5MjusM=
X-Google-Smtp-Source: APXvYqzzf13C6wiQMMFGa7+YGno05GQRLA5lbCkTvOdIMMODSSpqRw2+8UyeCEu5iNIWNk+qucMElr3uAFn6IYCf3GU=
X-Received: by 2002:a2e:91c5:: with SMTP id u5mr4699545ljg.65.1559635345302;
 Tue, 04 Jun 2019 01:02:25 -0700 (PDT)
MIME-Version: 1.0
References: <1559635233-21385-1-git-send-email-krzk@kernel.org>
In-Reply-To: <1559635233-21385-1-git-send-email-krzk@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 4 Jun 2019 10:02:13 +0200
Message-ID: <CAMuHMdVn5PtJEHApLQ8-C02Hr+ghhKQb2EAP=Kgr9oQwR6psTg@mail.gmail.com>
Subject: Re: [PATCH] powerpc/configs: Remove useless UEVENT_HELPER_PATH
To: Krzysztof Kozlowski <krzk@kernel.org>
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
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Jun 4, 2019 at 10:01 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> Remove the CONFIG_UEVENT_HELPER_PATH because:
> 1. It is disabled since commit 1be01d4a5714 ("driver: base: Disable
>    CONFIG_UEVENT_HELPER by default") as its dependency (UEVENT_HELPER) was
>    made default to 'n',
> 2. It is not recommended (help message: "This should not be used today
>    [...] creates a high system load") and was kept only for ancient
>    userland,
> 3. Certain userland specifically requests it to be disabled (systemd
>    README: "Legacy hotplug slows down the system and confuses udev").
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
