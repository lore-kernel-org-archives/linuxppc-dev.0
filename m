Return-Path: <SRS0=RHZ4=QV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED39DC43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Feb 2019 11:14:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32087222B6
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Feb 2019 11:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aXK6FgEj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32087222B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 440Yh81WkPzDqXM
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Feb 2019 22:14:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=infradead.org
 (client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=peterz@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="aXK6FgEj"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 440YdR019TzDqRS
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Feb 2019 22:12:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RGD/5MGOpZ+sFP4R8UzfseaMWuC+CODQr7wgC7RV1xU=; b=aXK6FgEjxQe4HE+pqXtNxte1s
 e1KXKHwIkueTFj7AL/+JldbMVhvx6dLSMCbckz6qEQUZ2Xj4sNYSt/Xc8mMP4ae/GvMWNheET4lEq
 WpByu3FunDFSksawPP1YKZz06spM0alNJGxCZtwoAcAaCTS1QPF/mH7XwCJpC3IgoyV/ZiJ/JWLLm
 nldVSTsoIlsYCW3voFKdiu5idA2iMfnY6BnYzmHNbqkTqiCiEB9L0C4xt2WS+UrXFNU5M8XgqWkrV
 MBhZ30zYcnlsc9GwO9Yoh3BbSE51bib0igHJ3kupqom97wzlqhnDWWtj5QruePCversvPk04l1mYH
 Qw8efa4qw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=hirez.programming.kicks-ass.net)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guEw9-0001pc-2H; Thu, 14 Feb 2019 11:12:13 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 7B5AD20298565; Thu, 14 Feb 2019 12:12:11 +0100 (CET)
Date: Thu, 14 Feb 2019 12:12:11 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v4 2/3] locking/rwsem: Remove rwsem-spinlock.c & use
 rwsem-xadd.c for all archs
Message-ID: <20190214111211.GL32494@hirez.programming.kicks-ass.net>
References: <1550095217-12047-1-git-send-email-longman@redhat.com>
 <1550095217-12047-3-git-send-email-longman@redhat.com>
 <CAMuHMdVe9J4LmbLz8nHsW2JSVt8EQHTKswtc+-53pD-DBxgwSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVe9J4LmbLz8nHsW2JSVt8EQHTKswtc+-53pD-DBxgwSw@mail.gmail.com>
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
Cc: "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 Linux-sh list <linux-sh@vger.kernel.org>, Will Deacon <will.deacon@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, sparclinux <sparclinux@vger.kernel.org>,
 linux-riscv@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Linux-Arch <linux-arch@vger.kernel.org>,
 linux-s390 <linux-s390@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
 linux-c6x-dev@linux-c6x.org,
 "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
 the arch/x86 maintainers <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Waiman Long <longman@redhat.com>,
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

On Thu, Feb 14, 2019 at 11:54:47AM +0100, Geert Uytterhoeven wrote:
> On Wed, Feb 13, 2019 at 11:01 PM Waiman Long <longman@redhat.com> wrote:
> > Currently, we have two different implementation of rwsem:
> >  1) CONFIG_RWSEM_GENERIC_SPINLOCK (rwsem-spinlock.c)
> >  2) CONFIG_RWSEM_XCHGADD_ALGORITHM (rwsem-xadd.c)
> >
> > As we are going to use a single generic implementation for rwsem-xadd.c
> > and no architecture-specific code will be needed, there is no point
> > in keeping two different implementations of rwsem. In most cases, the
> > performance of rwsem-spinlock.c will be worse. It also doesn't get all
> > the performance tuning and optimizations that had been implemented in
> > rwsem-xadd.c over the years.
> >
> > For simplication, we are going to remove rwsem-spinlock.c and make all
> > architectures use a single implementation of rwsem - rwsem-xadd.c.
> >
> > All references to RWSEM_GENERIC_SPINLOCK and RWSEM_XCHGADD_ALGORITHM
> > in the code are removed.
> >
> > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Waiman Long <longman@redhat.com>
> 
> Note that this conflicts with "[PATCH 03/11] kernel/locks: consolidate
> RWSEM_GENERIC_* options"
> https://lore.kernel.org/lkml/20190213174005.28785-4-hch@lst.de/

*sigh*.. of that never was Cc'ed to locking people :/
