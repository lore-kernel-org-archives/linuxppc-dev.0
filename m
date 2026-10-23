Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D64606A31A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Oct 2026 16:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=UnEe6EVt
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jB8Jg1Z9jz2yDc;
	Sat, 24 Oct 2026 03:54:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:8b0:10b:1236::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792774499;
	cv=none; b=SH7sTWmZwxe6vfO5aa9vIDjE2tpwtvKB7nnhIxyO5sBNnNo5Q+UeJYYHjrRWd4aZlING2IKOpoKKccQj7NRyTQhnZFTzKjSNmRa92fpDwh32C9GNuXEqq80D9XBvD/1MQ6eXD+dpyhD6T5yvzOo9eLHqrpuAZBT5BUVfHlDgrGBpc5UaSqPaVTkIgl5Wc1iZ3XyzH8EGdQ2+X8OPrUy1ibIcviCIFvElH+gixkM/p9nHpAoZHQ6br0yltC1yLIA0E0DE538fDGekyyJSm7WRMoMWDqDaScfZ1AL57C3tX9aV+FjTnM9uTQbZjWrTA+htWvFELudwC+C0cuiV84LBEA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792774499; c=relaxed/relaxed;
	bh=pcT1nqswGvhjhJ6QI4zO5XNTRfIOEZo9dTuCxwHmQEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E7xyNh2J4SP/JFcL5unMa5KLfs/B6RBVC48qtLdJKLiWYIz9k/1KPJpo//PQL8TSXW9R84/nBcNuq6dkVp8GgGUIi/JS6kwplgMpKOWeuEDy4g1ptuW2noaMZZSMEGf7QnRHvxoka78nlP7FLgDap+hgE57CZKqK7wphwP/DhpaIX3yP5peAvTBXXhtAFBgtYe6o7yTa83bzT+tNGFN9LH+xulZKkZy7kze+YMhuszEC7LLHjTK3PXMJ1DiY4uL53TtgDLvvwc+3v8qJ1kxmTRmEzbydE1caaW950JUg/+BW5SSmuk5oUTYRoScSb1sxDUXld0KtWKW/oMGVAo4LnQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=UnEe6EVt; dkim-atps=neutral; spf=pass (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=peterz@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=UnEe6EVt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=infradead.org (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=peterz@infradead.org; receiver=lists.ozlabs.org)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jB8JW6yWCz2xH9
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Oct 2026 03:54:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=pcT1nqswGvhjhJ6QI4zO5XNTRfIOEZo9dTuCxwHmQEQ=; b=UnEe6EVtKxffwjLF3eLQvD/QRC
	OYHwnUhoA9RikyKoyBO5MwHg3XpiNroyzCQJdB/spBGBilu3N+Adl6S/hZPWU6J3PfKjOhBk2bct0
	s01jfhZ66XungAM18MXMRSM9WQZf6LF2a5pvPTL2iQ490BqfCfH7WORfLWLc/8YTuMvdBgDKSrRvK
	d7ILi4kGsfbYrXIuZ2E8t1XAAGex7QEE9yXuVJ3P3CWFPrC71nqhqyv73WwzT1Y87Ca9oNsst114q
	tLdpzcwZnREAABLBGjx8ed1rOygIB2WJaL6MRiZ0URMwTtZHSD6kUAXIWYjLVirLrAo631SAM75VA
	LAXRk/dQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKIXL-0000000Cz7M-3hud;
	Fri, 23 Oct 2026 16:54:35 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E4C55300720; Fri, 23 Oct 2026 18:54:34 +0200 (CEST)
Date: Fri, 23 Oct 2026 18:54:34 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Srikar Dronamraju <srikar@linux.ibm.com>,
	Ingo Molnar <mingo@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>, Scott Wood <oss@buserror.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Kees Cook <kees@kernel.org>, Jinjie Ruan <ruanjinjie@huawei.com>,
	mrigendrachaubey <mrigendra.chaubey@gmail.com>,
	Marc Zyngier <maz@kernel.org>,
	Pengjie Zhang <zhangpengjie2@huawei.com>,
	Thierry Reding <treding@nvidia.com>, Xi Ruoyao <xry111@xry111.site>,
	"Rafael J. Wysocki (Intel)" <rafael@kernel.org>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Rong Bao <rong.bao@csmantle.top>, Hui Wang <hui.wang@canonical.com>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH] sched/hotplug: Remove unused idle_task_exit
Message-ID: <20261023165434.GX2823843@noisy.programming.kicks-ass.net>
References: <20261016095711.1364609-1-srikar@linux.ibm.com>
 <attjv8zOftf9Hlqe@localhost.localdomain>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <attjv8zOftf9Hlqe@localhost.localdomain>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 23, 2026 at 03:40:15PM +0200, Frederic Weisbecker wrote:
> Le Fri, Oct 16, 2026 at 03:26:40PM +0530, Srikar Dronamraju a écrit :
> > Commit 21641bd9a7a7 ("lazy tlb: fix hotplug exit race with
> > MMU_LAZY_TLB_SHOOTDOWN") moved the handling previously performed by
> > idle_task_exit() into the scheduler CPU hotplug path using
> > sched_force_init_mm().
> > 
> > As a result, idle_task_exit() is now an empty stub and the remaining
> > architecture call sites have no effect.
> > 
> > Remove the calls to idle_task_exit() and the now unused stub.
> > 
> > Signed-off-by: Srikar Dronamraju <srikar@linux.ibm.com>
> 
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

Excellent; less is more and all that. Shall I take this through the
scheduler tree?

