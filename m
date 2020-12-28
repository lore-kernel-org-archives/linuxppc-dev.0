Return-Path: <SRS0=zyM8=GA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02FB2C433DB
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Dec 2020 21:08:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BFFE207C9
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Dec 2020 21:08:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BFFE207C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4D4VXK0C7TzDqGG
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Dec 2020 08:08:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=luto@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=DtQTxCxM; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4D4VVS3GwTzDqCp
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Dec 2020 08:07:11 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id F23F1207C9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Dec 2020 21:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1609189629;
 bh=27KIURwqt1RL2uI90GMMltkVqkqP6J5+DLiEDUmWBQU=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=DtQTxCxMN4G6UUHNKgX6MwbZUqPdjE6JjBxXZPdj0zWdX7gsZSDdo/C8xwp+lQL54
 NBzKb3iMOLLl+ooPPX+uDCXfGSGiAJGCyGuQPPxE89gl/uIHrwh/HV+RGF5/LVTpQ4
 7xR85q4ojktFqvTOuAoTFu5ysSy5NRBPttYeK643j5DLOtPQanqRbL339jIUFnX7Uj
 1TsfvHMwMFcF8emTrLa4I9yh+VeQmGSVkWzMHIJyvLWndSC3wqlRmenlposPQkFlCJ
 HR+88klPTEYBgGF6Bk68JJRI3iceniZzpHlfVMC5fiuZLPwxWw3g3WHtjhCwtsI+b5
 TdxMw2v6zY+xg==
Received: by mail-wr1-f48.google.com with SMTP id r7so12517404wrc.5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Dec 2020 13:07:08 -0800 (PST)
X-Gm-Message-State: AOAM532czUv2hPigLUamYSouFYKF99HVqAzcIewfcF4VTQ1fVeoFGQpB
 xiyhAaYPTYiVniJCQuUdkzhASHQCPIImYrflRgQUyA==
X-Google-Smtp-Source: ABdhPJzLxjROX7Kr2gE7TOhHSUuU+1LZHqFzLu9v1+05RcKic1KF5QVniGH4/+FdCVG2zacKFF1YcGM3iKhXVViXwfc=
X-Received: by 2002:a5d:62c7:: with SMTP id o7mr846007wrv.257.1609189627549;
 Mon, 28 Dec 2020 13:07:07 -0800 (PST)
MIME-Version: 1.0
References: <bf59ecb5487171a852bcc8cdd553ec797aedc485.1609093476.git.luto@kernel.org>
 <1836294649.3345.1609100294833.JavaMail.zimbra@efficios.com>
 <CALCETrVdcn2r2Jvd1=-bM=FQ8KbX4aH-v4ytdojL7r7Nb6k8YQ@mail.gmail.com>
 <20201228102537.GG1551@shell.armlinux.org.uk>
 <CALCETrWQx0qwthBc5pJBxs2PWAQo-roAz-6g=7HOs+dsiokVsg@mail.gmail.com>
 <CAG48ez0YZ_iy6qZpdGUj38wqeg_NzLHHhU-mBCBf5hcopYGVPg@mail.gmail.com>
 <20201228190852.GI1551@shell.armlinux.org.uk>
 <CALCETrVpvrBufrJgXNY=ogtZQLo7zgxQmD7k9eVCFjcdcvarmA@mail.gmail.com>
 <1086654515.3607.1609187556216.JavaMail.zimbra@efficios.com>
In-Reply-To: <1086654515.3607.1609187556216.JavaMail.zimbra@efficios.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Mon, 28 Dec 2020 13:06:55 -0800
X-Gmail-Original-Message-ID: <CALCETrXx3Xe+4Y6WM-mp0cTUU=r3bW6PV2b25yA8bm1Gvak6wQ@mail.gmail.com>
Message-ID: <CALCETrXx3Xe+4Y6WM-mp0cTUU=r3bW6PV2b25yA8bm1Gvak6wQ@mail.gmail.com>
Subject: Re: [RFC please help] membarrier: Rewrite sync_core_before_usermode()
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
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
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Arnd Bergmann <arnd@arndb.de>,
 paulmck <paulmck@kernel.org>, Jann Horn <jannh@google.com>,
 Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>, "Russell King,
 ARM Linux" <linux@armlinux.org.uk>, Nicholas Piggin <npiggin@gmail.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, Paul Mackerras <paulus@samba.org>,
 stable <stable@vger.kernel.org>, Andy Lutomirski <luto@kernel.org>,
 Will Deacon <will@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Dec 28, 2020 at 12:32 PM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> ----- On Dec 28, 2020, at 2:44 PM, Andy Lutomirski luto@kernel.org wrote:
>
> > On Mon, Dec 28, 2020 at 11:09 AM Russell King - ARM Linux admin
> > <linux@armlinux.org.uk> wrote:
> >>
> >> On Mon, Dec 28, 2020 at 07:29:34PM +0100, Jann Horn wrote:
> >> > After chatting with rmk about this (but without claiming that any of
> >> > this is his opinion), based on the manpage, I think membarrier()
> >> > currently doesn't really claim to be synchronizing caches? It just
> >> > serializes cores. So arguably if userspace wants to use membarrier()
> >> > to synchronize code changes, userspace should first do the code
> >> > change, then flush icache as appropriate for the architecture, and
> >> > then do the membarrier() to ensure that the old code is unused?
>
> ^ exactly, yes.
>
> >> >
> >> > For 32-bit arm, rmk pointed out that that would be the cacheflush()
> >> > syscall. That might cause you to end up with two IPIs instead of one
> >> > in total, but we probably don't care _that_ much about extra IPIs on
> >> > 32-bit arm?
>
> This was the original thinking, yes. The cacheflush IPI will flush specific
> regions of code, and the membarrier IPI issues context synchronizing
> instructions.
>
> Architectures with coherent i/d caches don't need the cacheflush step.

There are different levels of coherency -- VIVT architectures may have
differing requirements compared to PIPT, etc.

In any case, I feel like the approach taken by the documentation is
fundamentally confusing.  Architectures don't all speak the same
language  How about something like:

The SYNC_CORE operation causes all threads in the caller's address
space (including the caller) to execute an architecture-defined
barrier operation.  membarrier() will ensure that this barrier is
executed at a time such that all data writes done by the calling
thread before membarrier() are made visible by the barrier.
Additional architecture-dependent cache management operations may be
required to use this for JIT code.

x86: SYNC_CORE executes a barrier that will cause subsequent
instruction fetches to observe prior writes.  Currently this will be a
"serializing" instruction, but, if future improved CPU documentation
becomes available and relaxes this requirement, the barrier may
change.  The kernel guarantees that writing new or modified
instructions to normal memory (and issuing SFENCE if the writes were
non-temporal) then doing a membarrier SYNC_CORE operation is
sufficient to cause all threads in the caller's address space to
execute the new or modified instructions.  This is true regardless of
whether or not those instructions are written at the same virtual
address from which they are subsequently executed.  No additional
cache management is required on x86.

arm: Something about the cache management syscalls.

arm64: Ditto

powerpc: I have no idea.
