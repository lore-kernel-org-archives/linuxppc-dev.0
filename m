Return-Path: <SRS0=ildu=RZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE541C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Mar 2019 17:08:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45CC721900
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Mar 2019 17:08:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Xicmuh1N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45CC721900
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Qqr7074jzDqS7
	for <linuxppc-dev@archiver.kernel.org>; Sat, 23 Mar 2019 04:08:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linuxfoundation.org
 (client-ip=2a00:1450:4864:20::144; helo=mail-lf1-x144.google.com;
 envelope-from=torvalds@linuxfoundation.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org
 header.b="Xicmuh1N"; dkim-atps=neutral
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com
 [IPv6:2a00:1450:4864:20::144])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44QqpT4ZJ2zDqDF
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Mar 2019 04:07:26 +1100 (AEDT)
Received: by mail-lf1-x144.google.com with SMTP id 10so1883658lfr.8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Mar 2019 10:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=K5KpCUavpU6jklxItqvKr4mbyrohs/asqf5NX0BYYpc=;
 b=Xicmuh1ND+AZ9lc/udGkNvWbzi2Lu2j3o6M44sYQ0ZH2WsGeVBgW5f2xPJwNTxlY2d
 JaSMsr2SEVdWRDbZBYCXJ0vB1W1wIN3vVWqOMIiqWhD3oBYZFF9I7ROZZs9bJvkPzu9N
 HN8UN8zBc9zkjew06tZVB45+s5iWpvEon1EZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=K5KpCUavpU6jklxItqvKr4mbyrohs/asqf5NX0BYYpc=;
 b=atatk6YtxGDav8jX/XhpSUxUa1xzYvCQ9AksSK+tFqKqjdMIQ4GOmyY+l++VZFkkRt
 JyRS5RhprdHKcs9XbPGanQ2N/W51QVK9rO8g2XUYpyt2KCVBUcc8MCtFq9KR4qAchyXb
 HNTN3Vzc8JsOtNleFVZkH7+YnaKGbpkP2myB69FTvx/mStNg3bBduw6K+BzBVp4qG/gg
 H+AbH5N3GbhOd0qR1knlk65nzbr7ao/wwvXAQe91vl7VHXLGNyXmpiv3OII2+YqdWRxb
 UjDR0DCbnHQcd17A8mw6Q2jucTQOm/0daF46UO6L+PpHYACSd5nws9fUov2tDjVHj/q8
 8QMA==
X-Gm-Message-State: APjAAAWhjvaOTbOaT1opVBZLGYXT0D4N9HSarCNikp9DdjS36NTGLwq6
 jbbOVeauxaHxpre4ztbl9KHvdTc1W68=
X-Google-Smtp-Source: APXvYqwTBd5uTBoGk0qfQd6JvIDrLy/GgNfjsEI7qz62YJgPr6rqOG9ra+mlQkEtk+LG0uoBcXcycA==
X-Received: by 2002:a19:4c41:: with SMTP id z62mr5782846lfa.9.1553274441843;
 Fri, 22 Mar 2019 10:07:21 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com.
 [209.85.208.175])
 by smtp.gmail.com with ESMTPSA id a29sm1841934lfi.19.2019.03.22.10.07.20
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 22 Mar 2019 10:07:20 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id r24so1619042ljg.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Mar 2019 10:07:20 -0700 (PDT)
X-Received: by 2002:a2e:9786:: with SMTP id y6mr5380150lji.79.1553274440270;
 Fri, 22 Mar 2019 10:07:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190322143008.21313-1-longman@redhat.com>
 <20190322143008.21313-3-longman@redhat.com>
In-Reply-To: <20190322143008.21313-3-longman@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 22 Mar 2019 10:07:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjujKK-Ey7DPnMExaEmphicuEDLmVn-9+W9VzFzR-Ts=A@mail.gmail.com>
Message-ID: <CAHk-=wjujKK-Ey7DPnMExaEmphicuEDLmVn-9+W9VzFzR-Ts=A@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] locking/rwsem: Remove rwsem-spinlock.c & use
 rwsem-xadd.c for all archs
To: Waiman Long <longman@redhat.com>
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
Cc: linux-ia64@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Will Deacon <will.deacon@arm.com>,
 linux-mips@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-arch <linux-arch@vger.kernel.org>, linux-s390@vger.kernel.org,
 Davidlohr Bueso <dave@stgolabs.net>, linux-c6x-dev@linux-c6x.org,
 linux-hexagon@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, uclinux-h8-devel@lists.sourceforge.jp,
 linux-xtensa@linux-xtensa.org, Arnd Bergmann <arnd@arndb.de>,
 linux-um@lists.infradead.org, linux-m68k <linux-m68k@lists.linux-m68k.org>,
 openrisc@lists.librecores.org, Borislav Petkov <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 "linux-alpha@vger.kernel.org" <linux-arm-kernel@lists.infradead.org>,
 linux-parisc@vger.kernel.org, Tim Chen <tim.c.chen@linux.intel.com>,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
 nios2-dev@lists.rocketboards.org, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Mar 22, 2019 at 7:30 AM Waiman Long <longman@redhat.com> wrote:
>
> For simplication, we are going to remove rwsem-spinlock.c and make all
> architectures use a single implementation of rwsem - rwsem-xadd.c.

Ack.

               Linus
