Return-Path: <SRS0=5aIK=N3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF6FC43441
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Nov 2018 09:12:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6E6E2087A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Nov 2018 09:12:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6E6E2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42xCD75yfrzF3jk
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Nov 2018 20:12:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.217.68; helo=mail-vs1-f68.google.com;
 envelope-from=geert.uytterhoeven@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux-m68k.org
Received: from mail-vs1-f68.google.com (mail-vs1-f68.google.com
 [209.85.217.68])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42xCB010G6zF3jg
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Nov 2018 20:10:15 +1100 (AEDT)
Received: by mail-vs1-f68.google.com with SMTP id h18so13353608vsj.4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Nov 2018 01:10:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0qIfpn7h25apnxv19ipNRo2saSk++fXxcgVKZddxbd8=;
 b=Hdn5GEgtI2/29lVR3Hb17Bnc5mkuKayiQXfbuVT5q6zZ81/MrAcqhriD8tP7BI1gkt
 p4oyfYrKnW4uv4GsPuffBUNMfFIkU8SQdtDP0S5bAUzZDKRr8iZNiA2X7jdSq4kWv0TO
 jaj8b8w2NdQVrodmCJuYWOU6D2EyI8RFFpv7NPyysVX8TFwKLl58OmH/xCZDYVrdJr6B
 dbMzC/ajNeiTZao7XcYrJtYJy5ur19uTrgX4CH1WC8/FuGyizPmJ7q4zjvMKGWtt9jag
 /LI9k9E3msAvA7W4qTkrTzVh6i8rbOI+l2Xq5nFy42sOF5NRqyTMhWgeuDZaCLYPIUEh
 UuGA==
X-Gm-Message-State: AGRZ1gJR0Rdxmh+JbZKpdbahmbaUG8tTPjOX02ji/2bu60yvVxqIlrMG
 UynlIab6rR+46MmUpbXyZOtg4SvG3emLlFPI2D8=
X-Google-Smtp-Source: AJdET5dlfGYqms4VL8TAsTO4xbguV5f6uh/c85Xjvb5Y+HsSloqPxkMAmjYYAmv6yQBQjwLoHd4Z5CWuXeMdl6pHxzk=
X-Received: by 2002:a67:3885:: with SMTP id n5mr3694101vsi.96.1542359412431;
 Fri, 16 Nov 2018 01:10:12 -0800 (PST)
MIME-Version: 1.0
References: <20181115190538.17016-1-hch@lst.de>
 <20181115190538.17016-5-hch@lst.de>
In-Reply-To: <20181115190538.17016-5-hch@lst.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 16 Nov 2018 10:10:00 +0100
Message-ID: <CAMuHMdUSr6uxXUv8HtWZihFVj9zR8SJoFByLJ=J+_Lj-Mmgagg@mail.gmail.com>
Subject: Re: [PATCH 4/9] PCI: consolidate PCI config entry in drivers/pci
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
Cc: Linux-Arch <linux-arch@vger.kernel.org>,
 Linux MIPS Mailing List <linux-mips@linux-mips.org>,
 linux-kbuild <linux-kbuild@vger.kernel.org>,
 linux-pci <linux-pci@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Dominik Brodowski <linux@dominikbrodowski.net>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Alex Bounine <alex.bou9@gmail.com>, alpha <linux-alpha@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Nov 15, 2018 at 8:06 PM Christoph Hellwig <hch@lst.de> wrote:
> There is no good reason to duplicate the PCI menu in every architecture.
> Instead provide a selectable HAVE_PCI symbol that indicates availability
> of PCI support, and a FORCE_PCI symbol to for PCI on and the handle the
> rest in drivers/pci.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
> Acked-by: Max Filippov <jcmvbkbc@gmail.com>
> Acked-by: Thomas Gleixner <tglx@linutronix.de>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

For m68k:
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
