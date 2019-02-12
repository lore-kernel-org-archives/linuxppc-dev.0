Return-Path: <SRS0=0iBm=QT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD93C282C4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 13:29:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEC22217D9
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 13:29:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mLAa+90a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEC22217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43zNmR0QdQzDqQd
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 00:29:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1231::1; helo=merlin.infradead.org;
 envelope-from=peterz@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="mLAa+90a"; dkim-atps=neutral
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:8b0:10b:1231::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43zNhF5xrbzDqP1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Feb 2019 00:25:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vWyEFKoZa/UBq+vRmN2N8BqiM0rFEYhHj/ZSk9dgI8M=; b=mLAa+90auwABrVT4GKqhuDkv0
 imWEqXm6ymnRIoIFMkPFvKLGUQD17vu09MjNgQnmtc66LOwYo+6wNZnfrNpIOjI4dPaeg3RzYuiN5
 gD5mt0OlPbGDyycBLue5YkcBAptFK2fJUFk/hbvi+suireXhE6iY36yt7vmtatXidVBPDgn8SPIK1
 Q6Z/aAYKsmuABMjkXlPmj/sJavwY4/lez/g/5R6/GDfLDnvqhgj7yllnhC2OPk8wyMiva5plYQX//
 IICDBG/AHwbnYoo58P6bwwqOeLTzehNeXSb90Ws0H/aiG+ZIEtNNFzkWZGDsU0TD57b0quPmdAKCe
 hIMIgqU+Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=hirez.programming.kicks-ass.net)
 by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtY4A-0004nH-Fd; Tue, 12 Feb 2019 13:25:38 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 483E420D0C1D8; Tue, 12 Feb 2019 14:25:37 +0100 (CET)
Date: Tue, 12 Feb 2019 14:25:37 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v2 2/2] locking/rwsem: Optimize down_read_trylock()
Message-ID: <20190212132537.GL32534@hirez.programming.kicks-ass.net>
References: <1549913486-16799-1-git-send-email-longman@redhat.com>
 <1549913486-16799-3-git-send-email-longman@redhat.com>
 <20190212132404.GI32494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212132404.GI32494@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: linux-arch@vger.kernel.org, linux-xtensa@linux-xtensa.org,
 Davidlohr Bueso <dave@stgolabs.net>, linux-ia64@vger.kernel.org,
 Tim Chen <tim.c.chen@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-sh@vger.kernel.org, linux-hexagon@vger.kernel.org, x86@kernel.org,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
 linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Feb 12, 2019 at 02:24:04PM +0100, Peter Zijlstra wrote:
> On Mon, Feb 11, 2019 at 02:31:26PM -0500, Waiman Long wrote:
> > Modify __down_read_trylock() to make it generate slightly better code
> > (smaller and maybe a tiny bit faster).
> > 
> > Before this patch, down_read_trylock:
> > 
> >    0x0000000000000000 <+0>:     callq  0x5 <down_read_trylock+5>
> >    0x0000000000000005 <+5>:     jmp    0x18 <down_read_trylock+24>
> >    0x0000000000000007 <+7>:     lea    0x1(%rdx),%rcx
> >    0x000000000000000b <+11>:    mov    %rdx,%rax
> >    0x000000000000000e <+14>:    lock cmpxchg %rcx,(%rdi)
> >    0x0000000000000013 <+19>:    cmp    %rax,%rdx
> >    0x0000000000000016 <+22>:    je     0x23 <down_read_trylock+35>
> >    0x0000000000000018 <+24>:    mov    (%rdi),%rdx
> >    0x000000000000001b <+27>:    test   %rdx,%rdx
> >    0x000000000000001e <+30>:    jns    0x7 <down_read_trylock+7>
> >    0x0000000000000020 <+32>:    xor    %eax,%eax
> >    0x0000000000000022 <+34>:    retq
> >    0x0000000000000023 <+35>:    mov    %gs:0x0,%rax
> >    0x000000000000002c <+44>:    or     $0x3,%rax
> >    0x0000000000000030 <+48>:    mov    %rax,0x20(%rdi)
> >    0x0000000000000034 <+52>:    mov    $0x1,%eax
> >    0x0000000000000039 <+57>:    retq
> > 
> > After patch, down_read_trylock:
> > 
> >    0x0000000000000000 <+0>:     callq  0x5 <down_read_trylock+5>
> >    0x0000000000000005 <+5>:     mov    (%rdi),%rax
> >    0x0000000000000008 <+8>:     test   %rax,%rax
> >    0x000000000000000b <+11>:    js     0x2f <down_read_trylock+47>
> >    0x000000000000000d <+13>:    lea    0x1(%rax),%rdx
> >    0x0000000000000011 <+17>:    lock cmpxchg %rdx,(%rdi)
> >    0x0000000000000016 <+22>:    jne    0x8 <down_read_trylock+8>
> >    0x0000000000000018 <+24>:    mov    %gs:0x0,%rax
> >    0x0000000000000021 <+33>:    or     $0x3,%rax
> >    0x0000000000000025 <+37>:    mov    %rax,0x20(%rdi)
> >    0x0000000000000029 <+41>:    mov    $0x1,%eax
> >    0x000000000000002e <+46>:    retq
> >    0x000000000000002f <+47>:    xor    %eax,%eax
> >    0x0000000000000031 <+49>:    retq
> > 
> > By using a rwsem microbenchmark, the down_read_trylock() rate on a
> > x86-64 system before and after the patch were:
> > 
> >                  Before Patch    After Patch
> >    # of Threads     rlock           rlock
> >    ------------     -----           -----
> >         1           27,787          28,259
> >         2            8,359           9,234
> 
> From 1/2:
> 
> 1        29,201  30,143  29,458    28,615  30,172  29,201
> 2         6,807  13,299   1,171     7,725  15,025   1,804

Argh, fat fingered and send before I was done typing.

What I wanted to say was; those rlock numbers don't match up. What
gives?

The before _this_ patch number of 27k787 should be the same as the after
first patch number of 30k172.
