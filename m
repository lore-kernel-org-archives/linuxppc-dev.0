Return-Path: <SRS0=zyM8=GA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED8EC433DB
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Dec 2020 19:46:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0C7F207B2
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Dec 2020 19:46:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0C7F207B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4D4SjJ5DmhzDqF5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Dec 2020 06:46:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=luto@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=r7Cro1T2; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4D4SgQ2MJ5zDqCG
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Dec 2020 06:44:49 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 00881225AB
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Dec 2020 19:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1609184687;
 bh=AxhsmIbR6fuF0/wfAYB1xeObY1rv+Sgxjjkn0MgbRwg=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=r7Cro1T22YoDTkjsEcATSOT6NFNlfjfAEFGipjpR+w+XZLbNZS4+GSNM3rI2Od0Yj
 oX4WBoMEQckMAxOuX3r66Y0vfPd/DMjTZNWd2NYpo4s80AsH24TT9/obx5WaSir0T7
 1t2lSnVPNfdloVvirqOiSslsTb0eVhYHsdVhSLhMoogfqs5IOPpfH6QQWAwexB0eBx
 9vp3ml9mowJ1HXHP4utgokfqestgQfsuOJ8F3kINezqdk+pkNJqcyCVfAOjc0QQS5w
 TDJaBNvHE65YN7miG4rERGsA8y7JNQGbFn4ev46u9m8VxYEh15HWJdUrgJdILJICbL
 3PfohfX07nGKA==
Received: by mail-wr1-f50.google.com with SMTP id t16so12361658wra.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Dec 2020 11:44:46 -0800 (PST)
X-Gm-Message-State: AOAM5301x+I+x5jfeZqe70hFxSbBpBXMvfw59Kx9oBfAT/72hE9ZfL2E
 SGXsxL7CyMojIosnY3dm4vJiLomNAeb9g4UTiGjw5Q==
X-Google-Smtp-Source: ABdhPJzjhdge7EO34jRsNBFMSG/TIQyan751y+QjzNZ5oVO9OIJTvIGiqcZiVQnIIpAkwgBmDcT9uYsIbtM9knsNNds=
X-Received: by 2002:a5d:43c3:: with SMTP id v3mr51547660wrr.184.1609184685561; 
 Mon, 28 Dec 2020 11:44:45 -0800 (PST)
MIME-Version: 1.0
References: <bf59ecb5487171a852bcc8cdd553ec797aedc485.1609093476.git.luto@kernel.org>
 <1836294649.3345.1609100294833.JavaMail.zimbra@efficios.com>
 <CALCETrVdcn2r2Jvd1=-bM=FQ8KbX4aH-v4ytdojL7r7Nb6k8YQ@mail.gmail.com>
 <20201228102537.GG1551@shell.armlinux.org.uk>
 <CALCETrWQx0qwthBc5pJBxs2PWAQo-roAz-6g=7HOs+dsiokVsg@mail.gmail.com>
 <CAG48ez0YZ_iy6qZpdGUj38wqeg_NzLHHhU-mBCBf5hcopYGVPg@mail.gmail.com>
 <20201228190852.GI1551@shell.armlinux.org.uk>
In-Reply-To: <20201228190852.GI1551@shell.armlinux.org.uk>
From: Andy Lutomirski <luto@kernel.org>
Date: Mon, 28 Dec 2020 11:44:33 -0800
X-Gmail-Original-Message-ID: <CALCETrVpvrBufrJgXNY=ogtZQLo7zgxQmD7k9eVCFjcdcvarmA@mail.gmail.com>
Message-ID: <CALCETrVpvrBufrJgXNY=ogtZQLo7zgxQmD7k9eVCFjcdcvarmA@mail.gmail.com>
Subject: Re: [RFC please help] membarrier: Rewrite sync_core_before_usermode()
To: Russell King - ARM Linux admin <linux@armlinux.org.uk>
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
 Jann Horn <jannh@google.com>, x86 <x86@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 stable <stable@vger.kernel.org>, Andy Lutomirski <luto@kernel.org>,
 Paul Mackerras <paulus@samba.org>, Will Deacon <will@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Dec 28, 2020 at 11:09 AM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Mon, Dec 28, 2020 at 07:29:34PM +0100, Jann Horn wrote:
> > After chatting with rmk about this (but without claiming that any of
> > this is his opinion), based on the manpage, I think membarrier()
> > currently doesn't really claim to be synchronizing caches? It just
> > serializes cores. So arguably if userspace wants to use membarrier()
> > to synchronize code changes, userspace should first do the code
> > change, then flush icache as appropriate for the architecture, and
> > then do the membarrier() to ensure that the old code is unused?
> >
> > For 32-bit arm, rmk pointed out that that would be the cacheflush()
> > syscall. That might cause you to end up with two IPIs instead of one
> > in total, but we probably don't care _that_ much about extra IPIs on
> > 32-bit arm?
> >
> > For arm64, I believe userspace can flush icache across the entire
> > system with some instructions from userspace - "DC CVAU" followed by
> > "DSB ISH", or something like that, I think? (See e.g.
> > compat_arm_syscall(), the arm64 compat code that implements the 32-bit
> > arm cacheflush() syscall.)
>
> Note that the ARM cacheflush syscall calls flush_icache_user_range()
> over the range of addresses that userspace has passed - it's intention
> since day one is to support cases where userspace wants to change
> executable code.
>
> It will issue the appropriate write-backs to the data cache (DCCMVAU),
> the invalidates to the instruction cache (ICIMVAU), invalidate the
> branch target buffer (BPIALLIS or BPIALL as appropriate), and issue
> the appropriate barriers (DSB ISHST, ISB).
>
> Note that neither flush_icache_user_range() nor flush_icache_range()
> result in IPIs; cache operations are broadcast across all CPUs (which
> is one of the minimums we require for SMP systems.)
>
> Now, that all said, I think the question that has to be asked is...
>
>         What is the basic purpose of membarrier?
>
> Is the purpose of it to provide memory barriers, or is it to provide
> memory coherence?
>
> If it's the former and not the latter, then cache flushes are out of
> scope, and expecting memory written to be visible to the instruction
> stream is totally out of scope of the membarrier interface, whether
> or not the writes happen on the same or a different CPU to the one
> executing the rewritten code.
>
> The documentation in the kernel does not seem to describe what it's
> supposed to be doing - the only thing I could find is this:
> Documentation/features/sched/membarrier-sync-core/arch-support.txt
> which describes it as "arch supports core serializing membarrier"
> whatever that means.
>
> Seems to be the standard and usual case of utterly poor to non-existent
> documentation within the kernel tree, or even a pointer to where any
> useful documentation can be found.
>
> Reading the membarrier(2) man page, I find nothing in there that talks
> about any kind of cache coherency for self-modifying code - it only
> seems to be about _barriers_ and nothing more, and barriers alone do
> precisely nothing to save you from non-coherent Harvard caches.
>
> So, either Andy has a misunderstanding, or the man page is wrong, or
> my rudimentary understanding of what membarrier is supposed to be
> doing is wrong...

Look at the latest man page:

https://man7.org/linux/man-pages/man2/membarrier.2.html

for MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE.  The result may not be
all that enlightening.

--Andy
