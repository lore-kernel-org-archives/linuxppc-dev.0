Return-Path: <SRS0=d/0/=NJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8091C0044C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Oct 2018 16:45:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0987D20657
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Oct 2018 16:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="shcSve/b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0987D20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42kL716YS3zDsMm
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Oct 2018 03:45:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="shcSve/b";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=google.com
 (client-ip=2607:f8b0:4864:20::241; helo=mail-oi1-x241.google.com;
 envelope-from=jannh@google.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.b="shcSve/b"; 
 dkim-atps=neutral
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com
 [IPv6:2607:f8b0:4864:20::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42kL4T1lDbzDrMm
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Oct 2018 03:42:42 +1100 (AEDT)
Received: by mail-oi1-x241.google.com with SMTP id j202-v6so7243672oih.10
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Oct 2018 09:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6W+wrmM9dIaHnup2t/m5VJPmlQNlQEbv7WHwSBlSu/I=;
 b=shcSve/b+zyHqv9+wGB0DonC+mr4m3KPGjrj1c0n1gKRpBHozeX3a6s0CjEFin620k
 yMTRw7CyEJi5j8ga6SqHOGNI0f3nOBCQfvzt11byN9QbE3VDGz8S6kSosVHqh+tfA1hY
 lx0L2yh4iJpHFew3xBaq7M/kFQuQNxERMLTZrMwACCvXKqSv13Z+567HwLwGk5Lw5AxJ
 hQmzvJD9JFB07gbE6gbt2XSYn/EZJLUlYifMiRsEDvf/W6+pew9jEGqZH9yWfpttn5aL
 Zc1SYqbnRgKW7WKjbwK5XBqOQ0z+JlJyvExkKlPLnfQdjgw1Hdeg6R2VLC4T2t04Y4Qu
 CVxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6W+wrmM9dIaHnup2t/m5VJPmlQNlQEbv7WHwSBlSu/I=;
 b=t/dlMiHAZQuAa2vYGbxx31h/2Q77z6J8dfNBliuoejEGr1b5Wdgb4e+lb997OFzSpI
 kv1IJQx15BQo3GoYgLUJaVb41zA4KewD0+esFiQS/B3wTu/X7KcAx5qPqoSK3PKIXffQ
 3D6cYsNF8F7oVQDFwL000jGXv714+SDHnHXjU2asxpcIT9U3WtFkxRroztkIBcLUr83+
 5rqr775hEQanmPW8IDqa66NG5n939ni6nnQACYbDrq3OiQtwui3/MbAvrE9mTCaBSb+d
 MjXcnXnZOAJ/aiHRDoj+VFc3JTw3y+lH+EMTFg0xru0b+33k2ymqd3bppibBeoTihCA4
 MNTA==
X-Gm-Message-State: AGRZ1gJacBcjevZlIIepjUXw05hAJcWjePqMBLKHPFOCsW0EN3d0xwvk
 KaAbHJi03D34o9OVj04fGEJjn94V5Rk/Ba5Ok7GkhQ==
X-Google-Smtp-Source: AJdET5exLHEfGfOL3vDPiab8HAuUl9W5xnFdibXRxkfbnt7BunGE0jiTtMxgzJiK89C3+j8mV64xImKLjudSUgG6bzo=
X-Received: by 2002:aca:674c:: with SMTP id
 b12-v6mr9354709oiy.157.1540831360051; 
 Mon, 29 Oct 2018 09:42:40 -0700 (PDT)
MIME-Version: 1.0
References: <20181029112343.27454-1-msammler@mpi-sws.org>
 <CAGXu5jJ2fFmEXfUzga3XBXcsHPuPWWf5zLeyn8+Z1oZVa8oTuQ@mail.gmail.com>
In-Reply-To: <CAGXu5jJ2fFmEXfUzga3XBXcsHPuPWWf5zLeyn8+Z1oZVa8oTuQ@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Mon, 29 Oct 2018 17:42:13 +0100
Message-ID: <CAG48ez3ek9E=LU9ASMMfOYgDFqfY-FREpMDjT=Vw8PuX3-BJOA@mail.gmail.com>
Subject: Re: [RFC PATCH] seccomp: Add protection keys into seccomp_data
To: Kees Cook <keescook@chromium.org>
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
Cc: wad@chromium.org, Linux API <linux-api@vger.kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, linuxram@us.ibm.com,
 Andy Lutomirski <luto@amacapital.net>, msammler@mpi-sws.org,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Oct 29, 2018 at 5:25 PM Kees Cook <keescook@chromium.org> wrote:
> On Mon, Oct 29, 2018 at 4:23 AM, Michael Sammler <msammler@mpi-sws.org> wrote:
> > Add the current value of an architecture specific protection keys
> > register (currently PKRU on x86) to data available for seccomp-bpf
> > programs to work on. This allows filters based on the currently
> > enabled protection keys.
> >
> > Support for protection keys on the POWER architecture is not part of
> > this patch since I do not have access to a PowerPC, but adding support
> > for it can be achieved by setting sd->pkeys to the AMR register in
> > populate_seccomp_data.
> >
> > One use case for this patch is disabling unnecessary system calls for a
> > library (e.g. network i/o for a crypto library) while the library runs
> > without disabling the system calls for the whole program (by changing
> > the protection keys before and after the library executes). Using this
> > one could ensure that the library behaves a expected (e.g. the crypto
> > library not sending private keys to a malicious server).
> >
> > This patch also enables lightweight sandboxing of untrusted code using
> > memory protection keys: Protection keys provide memory isolation but
> > for a sandbox system call isolation is needed as well. This patch
> > allows writing a seccomp filter to prevent system calls by the
> > untrusted code while still allowing system calls for the trusted code.
>
> Isn't PKU instruction based? Couldn't a malicious library just change
> the state of the MPK registers? This seems like an easy way to bypass
> any filters that used PKU. I'm not convinced this is a meaningful
> barrier that should be enforced by seccomp.

The idea is that if you know that there are no unwanted WRPKRU
instructions in your code, and all WRPKRU instructions in your code
are directly followed by code that verifies correctness of the
protection key, then you can implement lightweight sandboxes inside a
single process. See https://arxiv.org/pdf/1801.06822.pdf for one
description of this approach.

> This can also be done with a signal handler with SECCOMP_RET_TRAP and
> check instruction pointer vs PKU state.

But then you can't prevent an attacker from just jumping directly to
your syscall instruction. And it's slow.
