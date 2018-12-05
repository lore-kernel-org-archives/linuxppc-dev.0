Return-Path: <SRS0=GwW7=OO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F02C04EB9
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 03:51:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19AD82084C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 03:51:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="imbLSuUd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19AD82084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 438lC22D1gzDqkG
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 14:51:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="imbLSuUd";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=chromium.org
 (client-ip=2607:f8b0:4864:20::e43; helo=mail-vs1-xe43.google.com;
 envelope-from=dianders@chromium.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=chromium.org header.i=@chromium.org header.b="imbLSuUd";
 dkim-atps=neutral
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com
 [IPv6:2607:f8b0:4864:20::e43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 438l8H01MSzDqVL
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Dec 2018 14:48:46 +1100 (AEDT)
Received: by mail-vs1-xe43.google.com with SMTP id t17so11237113vsc.8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Dec 2018 19:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=claPucn+XJmQuNDr9GzOxYNtVSSdZHOjhhV3KuIo0kc=;
 b=imbLSuUdrAQA+3eZTMnGhlCCedBfnUq0nH8VeWgXogzdRJPxVpsi6rdlN+L037ryt/
 c3Bg09Qimd0+OuB8LKUrOzPW/Bgv8lKmtZzpVicVGuWesxKatrE6XgbZD2GlbsrjCd4/
 yd0IeRC1t/Tzha8cYdMtMxxdHI5JaICl3xbAM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=claPucn+XJmQuNDr9GzOxYNtVSSdZHOjhhV3KuIo0kc=;
 b=Wk/ZSftpmBStJmGDEzEAxbXoO2SpES4OYwa+25U0cHrmvv8ZvCAgc3467SdiMnakgL
 A+cZd4Benn5V3Lpvp/u2U1tksNAWLDWpHodfjnjnfzshb9mnKfwk7jhuaTr/goOjzMZo
 7BZ5K9OwoX123xuxi3M0bCxJ9ENNdBVVBIFL434z5zO+yrkxRlsVOOG4q+/fni0yKj7o
 Hq70Qzu1Z12ueV98MuhKRcc7X6x+r2LnjnCS2pTTh1tgTjMN4jjps+1n0bX1XbGH1iOG
 oNNA7yQJA1p+6oflTKaH8Ula7qLjWoxpiG776jNMHmfxC5a7NBjQ9LhVo5U21qzdtIRA
 gCLA==
X-Gm-Message-State: AA+aEWYNrCeL9NyfmXMhrlNZA+eM9dHCg9PrMH/d/KtXQVO33THARy+Y
 8+XQsGsNYB5iWWt98KZaYHUZOK/4vuo=
X-Google-Smtp-Source: AFSGD/Xf6V+RgmX2jrz1QvIehrISSZP0sE3MNIS61kb0BmlICpOQeAtxg5vYGMWSLUpWsg1EQM2hFQ==
X-Received: by 2002:a67:1d5:: with SMTP id r82mr9213748vsf.161.1543981723642; 
 Tue, 04 Dec 2018 19:48:43 -0800 (PST)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com.
 [209.85.217.42])
 by smtp.gmail.com with ESMTPSA id f88sm6090094vsa.7.2018.12.04.19.48.43
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 04 Dec 2018 19:48:43 -0800 (PST)
Received: by mail-vs1-f42.google.com with SMTP id v10so11229694vsv.12
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Dec 2018 19:48:43 -0800 (PST)
X-Received: by 2002:a67:1505:: with SMTP id 5mr8920678vsv.20.1543981302613;
 Tue, 04 Dec 2018 19:41:42 -0800 (PST)
MIME-Version: 1.0
References: <20181127173839.34328-1-dianders@chromium.org>
 <20181127173839.34328-3-dianders@chromium.org>
 <20181203155724.7g37vp43e4fd4xqk@holly.lan>
In-Reply-To: <20181203155724.7g37vp43e4fd4xqk@holly.lan>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 4 Dec 2018 19:41:28 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WS+9d6xeCx4xDqSQkPKPuRx6yATh=j_c1=uJpTdMVUqA@mail.gmail.com>
Message-ID: <CAD=FV=WS+9d6xeCx4xDqSQkPKPuRx6yATh=j_c1=uJpTdMVUqA@mail.gmail.com>
Subject: Re: [PATCH v6 2/4] kgdb: Fix kgdb_roundup_cpus() for arches who used
 smp_call_function()
To: Daniel Thompson <daniel.thompson@linaro.org>
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
Cc: linux-mips@linux-mips.org, dalias@libc.org, linux-sh@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 paulus@samba.org, linux-hexagon@vger.kernel.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 kgdb-bugreport@lists.sourceforge.net, jhogan@kernel.org,
 linux-snps-arc@lists.infradead.org,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Vineet Gupta <vgupta@synopsys.com>, LKML <linux-kernel@vger.kernel.org>,
 Ralf Baechle <ralf@linux-mips.org>, rkuo@codeaurora.org, paul.burton@mips.com,
 Jason Wessel <jason.wessel@windriver.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi,

On Mon, Dec 3, 2018 at 7:57 AM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Tue, Nov 27, 2018 at 09:38:37AM -0800, Douglas Anderson wrote:
> > When I had lockdep turned on and dropped into kgdb I got a nice splat
> > on my system.  Specifically it hit:
> >   DEBUG_LOCKS_WARN_ON(current->hardirq_context)
> >
> > Specifically it looked like this:
> >   sysrq: SysRq : DEBUG
> >   ------------[ cut here ]------------
> >   DEBUG_LOCKS_WARN_ON(current->hardirq_context)
> >   WARNING: CPU: 0 PID: 0 at .../kernel/locking/lockdep.c:2875 lockdep_hardirqs_on+0xf0/0x160
> >   CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.19.0 #27
> >   pstate: 604003c9 (nZCv DAIF +PAN -UAO)
> >   pc : lockdep_hardirqs_on+0xf0/0x160
> >   ...
> >   Call trace:
> >    lockdep_hardirqs_on+0xf0/0x160
> >    trace_hardirqs_on+0x188/0x1ac
> >    kgdb_roundup_cpus+0x14/0x3c
> >    kgdb_cpu_enter+0x53c/0x5cc
> >    kgdb_handle_exception+0x180/0x1d4
> >    kgdb_compiled_brk_fn+0x30/0x3c
> >    brk_handler+0x134/0x178
> >    do_debug_exception+0xfc/0x178
> >    el1_dbg+0x18/0x78
> >    kgdb_breakpoint+0x34/0x58
> >    sysrq_handle_dbg+0x54/0x5c
> >    __handle_sysrq+0x114/0x21c
> >    handle_sysrq+0x30/0x3c
> >    qcom_geni_serial_isr+0x2dc/0x30c
> >   ...
> >   ...
> >   irq event stamp: ...45
> >   hardirqs last  enabled at (...44): [...] __do_softirq+0xd8/0x4e4
> >   hardirqs last disabled at (...45): [...] el1_irq+0x74/0x130
> >   softirqs last  enabled at (...42): [...] _local_bh_enable+0x2c/0x34
> >   softirqs last disabled at (...43): [...] irq_exit+0xa8/0x100
> >   ---[ end trace adf21f830c46e638 ]---
> >
> > Looking closely at it, it seems like a really bad idea to be calling
> > local_irq_enable() in kgdb_roundup_cpus().  If nothing else that seems
> > like it could violate spinlock semantics and cause a deadlock.
> >
> > Instead, let's use a private csd alongside
> > smp_call_function_single_async() to round up the other CPUs.  Using
> > smp_call_function_single_async() doesn't require interrupts to be
> > enabled so we can remove the offending bit of code.
> >
> > In order to avoid duplicating this across all the architectures that
> > use the default kgdb_roundup_cpus(), we'll add a "weak" implementation
> > to debug_core.c.
> >
> > Looking at all the people who previously had copies of this code,
> > there were a few variants.  I've attempted to keep the variants
> > working like they used to.  Specifically:
> > * For arch/arc we passed NULL to kgdb_nmicallback() instead of
> >   get_irq_regs().
> > * For arch/mips there was a bit of extra code around
> >   kgdb_nmicallback()
> >
> > NOTE: In this patch we will still get into trouble if we try to round
> > up a CPU that failed to round up before.  We'll try to round it up
> > again and potentially hang when we try to grab the csd lock.  That's
> > not new behavior but we'll still try to do better in a future patch.
> >
> > Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> > Changes in v6:
> > - Moved smp_call_function_single_async() error check to patch 3.
> >
> > Changes in v5:
> > - Add a comment about get_irq_regs().
> > - get_cpu() => raw_smp_processor_id() in kgdb_roundup_cpus().
> > - for_each_cpu() => for_each_online_cpu()
> > - Error check smp_call_function_single_async()
> >
> > Changes in v4: None
> > Changes in v3:
> > - No separate init call.
> > - Don't round up the CPU that is doing the rounding up.
> > - Add "#ifdef CONFIG_SMP" to match the rest of the file.
> > - Updated desc saying we don't solve the "failed to roundup" case.
> > - Document the ignored parameter.
> >
> > Changes in v2:
> > - Removing irq flags separated from fixing lockdep splat.
> > - Don't use smp_call_function (Daniel).
> >
> >  arch/arc/kernel/kgdb.c     | 10 ++--------
> >  arch/arm/kernel/kgdb.c     | 12 -----------
> >  arch/arm64/kernel/kgdb.c   | 12 -----------
> >  arch/hexagon/kernel/kgdb.c | 27 -------------------------
> >  arch/mips/kernel/kgdb.c    |  9 +--------
> >  arch/powerpc/kernel/kgdb.c |  4 ++--
> >  arch/sh/kernel/kgdb.c      | 12 -----------
>
> Please could you re-send with the arch maintainers for these platforms
> included in the Cc: of the patch description rather than just in the
> e-mail header.
>
> I'd like to make sure arch maintainers have a chance to opt out if they
> want to (it's a weak symbol so an arch could chose not to use it).
>
> Otherwise I shall start testing shortly!

OK, I did a repost of v6 with the Cc's and also the Acks I've received
so far.  There are no code changes in the repost.  Please let me know
if you have additional comments and thanks for your help.

-Doug
