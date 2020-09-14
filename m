Return-Path: <SRS0=ST+l=CX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E55A3C433E2
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Sep 2020 20:34:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F07920E65
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Sep 2020 20:34:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fLq43tsj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F07920E65
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BqylY5YsLzDqPM
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2020 06:34:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=chromium.org (client-ip=2607:f8b0:4864:20::1042;
 helo=mail-pj1-x1042.google.com; envelope-from=keescook@chromium.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=fLq43tsj; dkim-atps=neutral
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com
 [IPv6:2607:f8b0:4864:20::1042])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Bqyhb0z3qzDqP3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2020 06:32:14 +1000 (AEST)
Received: by mail-pj1-x1042.google.com with SMTP id kk9so496968pjb.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Sep 2020 13:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=MAegNs4VOwWv9UrQbG/3KsC+fif9tz3H9h+v9DTenlg=;
 b=fLq43tsj0idL5YeRKTDNHNUi+/bcp9W/YMHPxve4qth42qg71hfTUM5Xq3cazIdDrI
 NFB+4SH1S70GAC48b8DplcyZACd4EXVyXgXskD80RFmDCDa/3pUt9RLyrlu1vxpWwB4f
 i2X0eeheLlVij915s5y5BUr4hEXriYpLc1OPM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=MAegNs4VOwWv9UrQbG/3KsC+fif9tz3H9h+v9DTenlg=;
 b=dcEB+YuqQyxf4d/QvrW/pxA4lx0DAe2ZkFu4+DsR401mwLsxPIwbpSm1KAMugeQe8T
 CNCTLu5qofVJduRmJX+qtUm1WEntYykcwd6rqvK8atXsvsBFcJFbDzA/YbyHwUDdQ6bT
 +SXWiRLcpgmtpEq/C3wuWgsgJkrK4jsWSVAAP6bfTJnJfWyVkjB9PS2gtx3Ka2jEBuin
 oO2ALbkXrR7ATvAKKaw0czkeY0xDjH2KgFlFzR0M0QOE16GLgzkJHYY7kETB4W4EW3QI
 5CHbM4D7wV+UjGA467F90UC5lHOVnnnkb63I8R7HLB98jdwGPnyGDPcpIBN53cJhd6Aq
 QMVA==
X-Gm-Message-State: AOAM532kfJqr9U3W4mbS90A9H79XiDTRX38Jmg49BiCJrGG8j2JbLhJa
 Ri5WUWpe1TgsqVImG+rMOMonkg==
X-Google-Smtp-Source: ABdhPJwLrAeD4ZMb7OCOucEtPSfmxZNEDPJonNkzAiZJUR7jlcfwd9QjlJseUiJhoAyO2uqhAGri2A==
X-Received: by 2002:a17:90b:364c:: with SMTP id
 nh12mr972235pjb.182.1600115531070; 
 Mon, 14 Sep 2020 13:32:11 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
 by smtp.gmail.com with ESMTPSA id j19sm11207357pfi.51.2020.09.14.13.32.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2020 13:32:10 -0700 (PDT)
Date: Mon, 14 Sep 2020 13:32:09 -0700
From: Kees Cook <keescook@chromium.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 00/15] selftests/seccomp: Refactor change_syscall()
Message-ID: <202009141321.366935EF52@keescook>
References: <20200912110820.597135-1-keescook@chromium.org>
 <87wo0wpnah.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wo0wpnah.fsf@mpe.ellerman.id.au>
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
Cc: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
 Will Drewry <wad@chromium.org>, linux-xtensa@linux-xtensa.org,
 linux-kernel@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>,
 Max Filippov <jcmvbkbc@gmail.com>, linux-arm-kernel@lists.infradead.org,
 linux-kselftest@vger.kernel.org, linux-mips@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Christian Brauner <christian@brauner.io>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Sep 14, 2020 at 10:15:18PM +1000, Michael Ellerman wrote:
> Kees Cook <keescook@chromium.org> writes:
> > Hi,
> >
> > This refactors the seccomp selftest macros used in change_syscall(),
> > in an effort to remove special cases for mips, arm, arm64, and xtensa,
> > which paves the way for powerpc fixes.
> >
> > I'm not entirely done testing, but all-arch build tests and x86_64
> > selftests pass. I'll be doing arm, arm64, and i386 selftests shortly,
> > but I currently don't have an easy way to check xtensa, mips, nor
> > powerpc. Any help there would be appreciated!
> 
> The series builds fine for me, and all the tests pass (see below).
> 
> Thanks for picking up those changes to deal with powerpc being oddball.
> 
> Tested-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

Awesome; thanks!

However...

> 
> cheers
> 
> 
> ./seccomp_bpf
> TAP version 13
> 1..86
> # Starting 86 tests from 7 test cases.
> #  RUN           global.kcmp ...
> #            OK  global.kcmp
> ok 1 global.kcmp
> [...]
> #  RUN           global.KILL_thread ...
> TAP version 13
> 1..86
> # Starting 86 tests from 7 test cases.

Was this a mis-paste, or has something very very bad happened here in
global.KILL_one_arg_six finishes?

> #  RUN           global.kcmp ...
> #            OK  global.kcmp
> ok 1 global.kcmp
> [...]
> #  RUN           global.user_notification_basic ...
> TAP version 13
> 1..86
> # Starting 86 tests from 7 test cases.
> [...]
> #  RUN           global.user_notification_basic ...
> TAP version 13
> 1..86
> # Starting 86 tests from 7 test cases.
> [...]
> #  RUN           global.user_notification_signal ...
> TAP version 13
> 1..86
> # Starting 86 tests from 7 test cases.
> [...]
> #  RUN           global.user_notification_closed_listener ...
> TAP version 13
> 1..86
> # Starting 86 tests from 7 test cases.
> [...]
> #  RUN           global.user_notification_child_pid_ns ...
> TAP version 13
> 1..86
> # Starting 86 tests from 7 test cases.
> [...]
> #  RUN           global.user_notification_sibling_pid_ns ...
> TAP version 13
> 1..86
> # Starting 86 tests from 7 test cases.
> [...]
> #  RUN           global.user_notification_sibling_pid_ns ...
> TAP version 13
> 1..86
> # Starting 86 tests from 7 test cases.
> [...]
> #  RUN           global.user_notification_sibling_pid_ns ...
> TAP version 13
> 1..86
> # Starting 86 tests from 7 test cases.
> [...]
> #  RUN           global.user_notification_fault_recv ...
> TAP version 13
> 1..86
> # Starting 86 tests from 7 test cases.
> [...]
> #  RUN           global.user_notification_continue ...
> TAP version 13
> 1..86
> # Starting 86 tests from 7 test cases.
> [...]
> #  RUN           global.user_notification_filter_empty ...
> TAP version 13
> 1..86
> # Starting 86 tests from 7 test cases.
> [...]
> #  RUN           global.user_notification_filter_empty_threaded ...
> TAP version 13
> 1..86
> # Starting 86 tests from 7 test cases.
> [...]
> #  RUN           global.user_notification_addfd ...
> TAP version 13
> 1..86
> # Starting 86 tests from 7 test cases.
> [...]
> #  RUN           global.user_notification_addfd_rlimit ...
> TAP version 13
> 1..86
> # Starting 86 tests from 7 test cases.
> [...]
> # PASSED: 86 / 86 tests passed.
> # Totals: pass:86 fail:0 xfail:0 xpass:0 skip:0 error:0

And after every user_notification test? O_O

-- 
Kees Cook
