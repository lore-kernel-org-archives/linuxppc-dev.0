Return-Path: <SRS0=RHZ4=QV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F947C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Feb 2019 08:12:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9297C2229F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Feb 2019 08:12:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9297C2229F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 440TdV4VjfzDqBg
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Feb 2019 19:12:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.217.68; helo=mail-vs1-f68.google.com;
 envelope-from=geert.uytterhoeven@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux-m68k.org
Received: from mail-vs1-f68.google.com (mail-vs1-f68.google.com
 [209.85.217.68])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 440TbS6YWVzDqTf
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Feb 2019 19:10:28 +1100 (AEDT)
Received: by mail-vs1-f68.google.com with SMTP id z18so3113838vso.7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Feb 2019 00:10:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=s7mH6uc/WErzysdhYHrwGn+Za9Ii5z+9SMgUHEvVd2c=;
 b=W2SimnFu/g2di8kyH7th4RPXWfWTcq0UH8CUDb8iZJRN3xYo+9OocA6iUz71MCv5d2
 IAKnv/T+jrBNXWBe+VKNSI/q7pJT2a3UgNO9Fdi/gp/7qE32AE3i+6NhHUQEwMIB+ofA
 ruYgyhSWMbOmtm/bflkVNX/70KxPJ60gWQ+pk+uL4w1QxzVoK+VjxhiyjcHNC4HwKWSf
 DFCzfjqkcpTG9xbc2D7n4JGPDNQsRg+S3ahVY342L5Gcvlw2tsCtYKYiS8fNHEP8lI9B
 awH3buISoSbPIzuWSWQ2Q0A2q3zmMVE4Yp4L5olyZfXP6myEOIenxrkKswZ55Bn7rT33
 jX9g==
X-Gm-Message-State: AHQUAuaCMhZMGMZLsfbLQ/D42o0pv5U9xS7qjoNms513pb8yTXQX5h86
 5odDHZICBxJQYm45kQHgaPl5OtdMhZCT/buyQJY=
X-Google-Smtp-Source: AHgI3IainHdtNgPKfyU8YjSDdQ+iRTA5h4usd5PDFEqXOlRT2t4Q7Q4DByDOzAkMWCZQ41k3lVfXLhI1reoT4R3LmvA=
X-Received: by 2002:a67:f43:: with SMTP id 64mr1331176vsp.166.1550131826029;
 Thu, 14 Feb 2019 00:10:26 -0800 (PST)
MIME-Version: 1.0
References: <20190213174005.28785-1-hch@lst.de>
 <20190213174005.28785-4-hch@lst.de>
In-Reply-To: <20190213174005.28785-4-hch@lst.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 14 Feb 2019 09:10:14 +0100
Message-ID: <CAMuHMdWRPm0_u2EX5OXeraZdKL602RJvbO5aKm09Sf-HKMGzjg@mail.gmail.com>
Subject: Re: [PATCH 03/11] kernel/locks: consolidate RWSEM_GENERIC_* options
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

On Thu, Feb 14, 2019 at 12:08 AM Christoph Hellwig <hch@lst.de> wrote:
> Introduce one central definition of RWSEM_XCHGADD_ALGORITHM and
> RWSEM_GENERIC_SPINLOCK in kernel/Kconfig.locks and let architectures
> select RWSEM_XCHGADD_ALGORITHM if they want it, otherwise default to
> the spinlock version.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

>  arch/m68k/Kconfig       | 7 -------

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
