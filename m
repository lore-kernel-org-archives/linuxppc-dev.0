Return-Path: <SRS0=RHZ4=QV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D462C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Feb 2019 10:57:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6ABB222A4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Feb 2019 10:57:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6ABB222A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 440YHb4WsLzDqVF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Feb 2019 21:56:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.222.66; helo=mail-ua1-f66.google.com;
 envelope-from=geert.uytterhoeven@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux-m68k.org
Received: from mail-ua1-f66.google.com (mail-ua1-f66.google.com
 [209.85.222.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 440YFK4t01zDqM2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Feb 2019 21:55:01 +1100 (AEDT)
Received: by mail-ua1-f66.google.com with SMTP id a42so1395227uad.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Feb 2019 02:55:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0FVphaqkdujewH8xkqyrrOZQTGaRwWmRxSe5PedLOc8=;
 b=NDXrIilBh04BAyUv/xgyfDU5v+BEhHviXU7XOgVSNJ8wDzjDeKsQWyqXbdVQY8jdnE
 ywt6XogEKhPM0urwa/kTZZ4z3yLQCx0dqbOCDqsV3GFWJSFXYGG+HeKMwv5CKlkH8CNG
 N4uiMbc7T54AwOycudppauvqqq9mWaZufzDz6T5ZEM2EMWKXmy+kfoPsHpLD+lmogE42
 iH6nTMqj7G9oxj9eCMUOL2OpMv4cO9tJGvNX9X+s3LeZA0e75utJ0OrYBEJgu5cw47QL
 eWvgJsnN94gXwL6amm2BAFah2D2Zi4KWfE1WRFOsn260sac9vAOpKwwLHZdH7O/K6+OL
 Fn9Q==
X-Gm-Message-State: AHQUAuaCSGR54ENWM13FzJkyjAQ8FZZpTh3lDpHczw5RRzKNVAKagBrg
 E11VF65vQNL57xQK7Tc/mS9qNNLpSjpVqxUTPLk=
X-Google-Smtp-Source: AHgI3IbzhzuzEySYHwSbJTqDaXLapQMTOW53oPTxOn4RxgH5lrV4tpWGJZxYzqt5buLzgH3+IW1GydrsaXAApWWXHYU=
X-Received: by 2002:a9f:2726:: with SMTP id a35mr1587802uaa.75.1550141699426; 
 Thu, 14 Feb 2019 02:54:59 -0800 (PST)
MIME-Version: 1.0
References: <1550095217-12047-1-git-send-email-longman@redhat.com>
 <1550095217-12047-3-git-send-email-longman@redhat.com>
In-Reply-To: <1550095217-12047-3-git-send-email-longman@redhat.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 14 Feb 2019 11:54:47 +0100
Message-ID: <CAMuHMdVe9J4LmbLz8nHsW2JSVt8EQHTKswtc+-53pD-DBxgwSw@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] locking/rwsem: Remove rwsem-spinlock.c & use
 rwsem-xadd.c for all archs
To: Waiman Long <longman@redhat.com>, Christoph Hellwig <hch@lst.de>
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
Cc: "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 Linux-sh list <linux-sh@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Will Deacon <will.deacon@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, sparclinux <sparclinux@vger.kernel.org>,
 linux-riscv@lists.infradead.org, Linux-Arch <linux-arch@vger.kernel.org>,
 linux-s390 <linux-s390@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
 linux-c6x-dev@linux-c6x.org,
 "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
 the arch/x86 maintainers <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 "moderated list:H8/300 ARCHITECTURE" <uclinux-h8-devel@lists.sourceforge.jp>,
 linux-xtensa@linux-xtensa.org, Arnd Bergmann <arnd@arndb.de>,
 linux-um@lists.infradead.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 Openrisc <openrisc@lists.librecores.org>, Borislav Petkov <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Parisc List <linux-parisc@vger.kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-mips@vger.kernel.org,
 alpha <linux-alpha@vger.kernel.org>, nios2-dev@lists.rocketboards.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Tim Chen <tim.c.chen@linux.intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Feb 13, 2019 at 11:01 PM Waiman Long <longman@redhat.com> wrote:
> Currently, we have two different implementation of rwsem:
>  1) CONFIG_RWSEM_GENERIC_SPINLOCK (rwsem-spinlock.c)
>  2) CONFIG_RWSEM_XCHGADD_ALGORITHM (rwsem-xadd.c)
>
> As we are going to use a single generic implementation for rwsem-xadd.c
> and no architecture-specific code will be needed, there is no point
> in keeping two different implementations of rwsem. In most cases, the
> performance of rwsem-spinlock.c will be worse. It also doesn't get all
> the performance tuning and optimizations that had been implemented in
> rwsem-xadd.c over the years.
>
> For simplication, we are going to remove rwsem-spinlock.c and make all
> architectures use a single implementation of rwsem - rwsem-xadd.c.
>
> All references to RWSEM_GENERIC_SPINLOCK and RWSEM_XCHGADD_ALGORITHM
> in the code are removed.
>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Waiman Long <longman@redhat.com>

Note that this conflicts with "[PATCH 03/11] kernel/locks: consolidate
RWSEM_GENERIC_* options"
https://lore.kernel.org/lkml/20190213174005.28785-4-hch@lst.de/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
