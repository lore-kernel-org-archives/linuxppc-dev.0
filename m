Return-Path: <SRS0=o5MI=RC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 086DAC43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Feb 2019 09:27:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78AB72133F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Feb 2019 09:27:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="Vh46G7QO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78AB72133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 448Vhc3d2czDqLr
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Feb 2019 20:27:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=google.com
 (client-ip=2607:f8b0:4864:20::d44; helo=mail-io1-xd44.google.com;
 envelope-from=dvyukov@google.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.b="Vh46G7QO"; 
 dkim-atps=neutral
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com
 [IPv6:2607:f8b0:4864:20::d44])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 448Vfp3ccWzDqL8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Feb 2019 20:26:08 +1100 (AEDT)
Received: by mail-io1-xd44.google.com with SMTP id x9so12930783iog.12
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Feb 2019 01:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vstIwG6RGSnFTCdlWq8XlRTKnk2DsAOEgppdnknGPvs=;
 b=Vh46G7QO6H7EXlWkJhKTMtownvl9a1V7KKNdJDBgDZk02XlTWlJxxhVKDg0z5uxRiP
 N1wFOppgtnTZXbAR/2oTV3N2cwau/gmV/+qylFxNig36ygJ3F3gY323BltjgIi1xksmN
 ygxHb9r7RciVIJedUy60aQSoiStCpa5YhPGSJIdlIAi1TQkzrxKbbdnVpKO5kMT9wBuH
 DmqdbW1unCNNT5NoGrvqFR2U+bLh0KoXfzJfqxKfeGRqQ/Hcx/x8fvmpFA/Conh+qQo0
 +IOwOAFkmMp1SO9lDj6cnUHBTV/l/tUEUk3yx8SFflwQ6qZCM1RVVr5IctsKZJuTg8/A
 iBvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vstIwG6RGSnFTCdlWq8XlRTKnk2DsAOEgppdnknGPvs=;
 b=W3TQmOHnUCYuh8NmfgfukuJfe2D2HkN3X+75ocMdF1xaoo/ZvItjeCuaJLRwr5SZC2
 gvvsk+d2QLRrOobB9N03LVQ8sUNaxcDiSf3S07rSI2NlPJAMld6rtAvZjkjkWfwyNdjv
 KqeSHC52zJq6sllL6rkI5CLsW2mV389mJTW4fVv+E2JB32JNeeTRvNrhah/803QgGPBg
 i4cyPDykyUDFP6BKbl0/kK49ocXjf5mBmcE7PkwQzT6kuWDgOlK+MT3pBoF7jpd9V0wd
 xgy2BRSJ8arkKbETgh2EuELDn6QXkuFcZ9Ad/2ksMzOgqU9WQ6YyrwLwlA0mFtbWDSfG
 us8w==
X-Gm-Message-State: APjAAAUTX904dNkTlxzFipBzlLCfAxgcf1q+SDoRjbbSDZY0FZ6nj8KB
 t9aX482/JCn04aAGly+EfWQgK0UwZz/luF3zPV8ELQ==
X-Google-Smtp-Source: APXvYqz8Ud+yQay/ozIws7gBzBnivarDRgoEFhbeiVox0MBaF1zqZZ20aEerwyjMiQn7Y3x15Db/8X4R0sL7i5irt2E=
X-Received: by 2002:a5d:834a:: with SMTP id q10mr1306903ior.271.1551259566125; 
 Wed, 27 Feb 2019 01:26:06 -0800 (PST)
MIME-Version: 1.0
References: <c6d80735-0cfe-b4ab-0349-673fc65b2e15@c-s.fr>
 <5f0203bd-77ea-d94c-11b7-1befba439cd4@virtuozzo.com>
In-Reply-To: <5f0203bd-77ea-d94c-11b7-1befba439cd4@virtuozzo.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Wed, 27 Feb 2019 10:25:54 +0100
Message-ID: <CACT4Y+Ze0Ezi4uKVZR1nk_EOjNcHd=JLhYq8ahqbfOL_8Jq9iw@mail.gmail.com>
Subject: Re: BUG: KASAN: stack-out-of-bounds
To: Andrey Ryabinin <aryabinin@virtuozzo.com>
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
Cc: kasan-dev <kasan-dev@googlegroups.com>, Linux-MM <linux-mm@kvack.org>,
 Alexander Potapenko <glider@google.com>, linuxppc-dev@lists.ozlabs.org,
 Daniel Axtens <dja@axtens.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Feb 27, 2019 at 10:18 AM Andrey Ryabinin
<aryabinin@virtuozzo.com> wrote:
> On 2/27/19 11:25 AM, Christophe Leroy wrote:
> > With version v8 of the series implementing KASAN on 32 bits powerpc (https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=94309), I'm now able to activate KASAN on a mac99 is QEMU.
> >
> > Then I get the following reports at startup. Which of the two reports I get seems to depend on the option used to build the kernel, but for a given kernel I always get the same report.
> >
> > Is that a real bug, in which case how could I spot it ? Or is it something wrong in my implementation of KASAN ?
> >
> > I checked that after kasan_init(), the entire shadow memory is full of 0 only.
> >
> > I also made a try with the strong STACK_PROTECTOR compiled in, but no difference and nothing detected by the stack protector.
> >
> > ==================================================================
> > BUG: KASAN: stack-out-of-bounds in memchr+0x24/0x74
> > Read of size 1 at addr c0ecdd40 by task swapper/0
> >
> > CPU: 0 PID: 0 Comm: swapper Not tainted 5.0.0-rc7+ #1133
> > Call Trace:
> > [c0e9dca0] [c01c42a0] print_address_description+0x64/0x2bc (unreliable)
> > [c0e9dcd0] [c01c4684] kasan_report+0xfc/0x180
> > [c0e9dd10] [c089579c] memchr+0x24/0x74
> > [c0e9dd30] [c00a9e38] msg_print_text+0x124/0x574
> > [c0e9dde0] [c00ab710] console_unlock+0x114/0x4f8
> > [c0e9de40] [c00adc60] vprintk_emit+0x188/0x1c4
> > --- interrupt: c0e9df00 at 0x400f330
> >     LR = init_stack+0x1f00/0x2000
> > [c0e9de80] [c00ae3c4] printk+0xa8/0xcc (unreliable)
> > [c0e9df20] [c0c28e44] early_irq_init+0x38/0x108
> > [c0e9df50] [c0c16434] start_kernel+0x310/0x488
> > [c0e9dff0] [00003484] 0x3484
> >
> > The buggy address belongs to the variable:
> >  __log_buf+0xec0/0x4020
> > The buggy address belongs to the page:
> > page:c6eac9a0 count:1 mapcount:0 mapping:00000000 index:0x0
> > flags: 0x1000(reserved)
> > raw: 00001000 c6eac9a4 c6eac9a4 00000000 00000000 00000000 ffffffff 00000001
> > page dumped because: kasan: bad access detected
> >
> > Memory state around the buggy address:
> >  c0ecdc00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >  c0ecdc80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >>c0ecdd00: 00 00 00 00 00 00 00 00 f1 f1 f1 f1 00 00 00 00
> >                                    ^
> >  c0ecdd80: f3 f3 f3 f3 00 00 00 00 00 00 00 00 00 00 00 00
> >  c0ecde00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > ==================================================================
> >
>
> This one doesn't look good. Notice that it says stack-out-of-bounds, but at the same time there is
>         "The buggy address belongs to the variable:  __log_buf+0xec0/0x4020"
>  which is printed by following code:
>         if (kernel_or_module_addr(addr) && !init_task_stack_addr(addr)) {
>                 pr_err("The buggy address belongs to the variable:\n");
>                 pr_err(" %pS\n", addr);
>         }
>
> So the stack unrelated address got stack-related poisoning. This could be a stack overflow, did you increase THREAD_SHIFT?
> KASAN with stack instrumentation significantly increases stack usage.

A straightforward explanation would be that this happens before real
shadow is mapped and we don't turn off KASAN reports. Should be easy
to check so worth eliminating this possibility before any other
debugging.
