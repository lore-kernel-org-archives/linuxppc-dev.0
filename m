Return-Path: <SRS0=RHZ4=QV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5634C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Feb 2019 18:00:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2229F2080A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Feb 2019 18:00:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PGshS3Ma"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2229F2080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 440kgr1Jx3zDqXG
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 05:00:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linuxfoundation.org
 (client-ip=2a00:1450:4864:20::142; helo=mail-lf1-x142.google.com;
 envelope-from=torvalds@linuxfoundation.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org
 header.b="PGshS3Ma"; dkim-atps=neutral
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com
 [IPv6:2a00:1450:4864:20::142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 440kdk1r0lzDqLx
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Feb 2019 04:58:17 +1100 (AEDT)
Received: by mail-lf1-x142.google.com with SMTP id q11so5217656lfd.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Feb 2019 09:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YOAxNfp/u2AjpSAe9gJ1DkLd8kcSaDRiWtEtJaBSEcs=;
 b=PGshS3MaeGeltwuyVtFmT0V6YZQZmxLLNBrf107mvwKlqUhZwGpD70GnjqQJh+4V2q
 3J6Xvbgr/CiWsk6q6rJVeglsaiLbeVTkiovB8o6FTpvJF+udviHo9Zs+xhaucNb0e3LD
 IXDiqt1MsmZkkBaKR5AXhS5/XMcdP66J22GNk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YOAxNfp/u2AjpSAe9gJ1DkLd8kcSaDRiWtEtJaBSEcs=;
 b=MfD1vF4zKfGnnIP1YsKPAReypCcT8DH5l/0iiDyAWia37ll7P5ZTdV5/nzFXlU/SSt
 f63Ftzcpgsy/JvuJ1DaS1hA4IHB5q9LYwJQdshFHCcV1Ck5maxIjSxsrO+pkdTih0m7L
 bXJWP34K1y+yeWrf/SInYBsgClVlaxV6oWvtjPEAkyoAM5rSOQUPyXsu93ocv26vM9yk
 UH8dS523v20mje7Y4zD8VfaM3Isdl8s0DASX0NMrWFfwIk4yzcJ2eY4pSsjah0GGoPsP
 IyRX0FGQFs/JF66CTGV4/bU/R3iRS39ECjSL18wybapcWoRYInFvYSvT7Di7h+4zuhCc
 CL0g==
X-Gm-Message-State: AHQUAub4zPbBJHdpkDIZ+/99Lf1Hl1LS37pOay5aRM0UakkpltKgVpKb
 x6X/azolnKunYkpQ/nx5kdl4vuvHvZs=
X-Google-Smtp-Source: AHgI3Ia28BJX6JKF3+knsd//BzDQfoeI0zA6QPJy8rfZMELtwFmbWhI4IZGg1KRaCJyudGWCCQBb1Q==
X-Received: by 2002:a19:41ca:: with SMTP id o193mr2811015lfa.121.1550167093420; 
 Thu, 14 Feb 2019 09:58:13 -0800 (PST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com.
 [209.85.167.49])
 by smtp.gmail.com with ESMTPSA id 85-v6sm580482lja.16.2019.02.14.09.58.13
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 14 Feb 2019 09:58:13 -0800 (PST)
Received: by mail-lf1-f49.google.com with SMTP id n15so5215392lfe.5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Feb 2019 09:58:13 -0800 (PST)
X-Received: by 2002:a19:2794:: with SMTP id n142mr3048400lfn.77.1550166697920; 
 Thu, 14 Feb 2019 09:51:37 -0800 (PST)
MIME-Version: 1.0
References: <1550089932-6888-1-git-send-email-longman@redhat.com>
 <1550089932-6888-3-git-send-email-longman@redhat.com>
 <20190214103333.GH32494@hirez.programming.kicks-ass.net>
 <9e01d4ef-56df-7af8-a0f5-b49644e298bf@redhat.com>
In-Reply-To: <9e01d4ef-56df-7af8-a0f5-b49644e298bf@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 14 Feb 2019 09:51:21 -0800
X-Gmail-Original-Message-ID: <CAHk-=whKmuranma_HUOKBbDJHGmdWZr9MYW-+cmGzsOiJ2N1Sg@mail.gmail.com>
Message-ID: <CAHk-=whKmuranma_HUOKBbDJHGmdWZr9MYW-+cmGzsOiJ2N1Sg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] locking/rwsem: Optimize down_read_trylock()
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
Cc: linux-arch <linux-arch@vger.kernel.org>, linux-xtensa@linux-xtensa.org,
 Davidlohr Bueso <dave@stgolabs.net>, linux-ia64@vger.kernel.org,
 Tim Chen <tim.c.chen@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>,
 Linux-sh list <linux-sh@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, linux-hexagon@vger.kernel.org,
 the arch/x86 maintainers <x86@kernel.org>, Will Deacon <will.deacon@arm.com>,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 "H. Peter Anvin" <hpa@zytor.com>,
 "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
 sparclinux@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
 "linux-alpha@vger.kernel.org" <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Feb 14, 2019 at 6:53 AM Waiman Long <longman@redhat.com> wrote:
>
> The ARM64 result is what I would have expected given that the change was
> to optimize for the uncontended case. The x86-64 result is kind of an
> anomaly to me, but I haven't bothered to dig into that.

I would say that the ARM result is what I'd expect from something that
scales badly to begin with.

The x86-64 result is the expected one: yes, the cmpxchg is done one
extra time, but it results in fewer cache transitions (the cacheline
never goes into "shared" state), and cache transitions are what
matter.

The cost of re-doing the instruction should be low. The cacheline
ping-pong and the cache coherency messages is what hurts.

So I actually think both are very easily explained.

The x86-64 number improves, because there is less cache coherency traffic.

The arm64 numbers scaled horribly even before, and that's because
there is too much ping-pong, and it's probably because there is no
"stickiness" to the cacheline to the core, and thus adding the extra
loop can make the ping-pong issue even worse because now there is more
of it.

The cachelines not sticking at all to a core probably is good for
fairness issues (in particular, sticking *too* much can cause horrible
issues), but it's absolutely horrible if it means that you lose the
cacheline even before you get to complete the second cmpxchg.

                  Linus
