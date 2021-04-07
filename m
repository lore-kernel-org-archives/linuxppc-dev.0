Return-Path: <SRS0=l0Nn=JE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C3CC433ED
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Apr 2021 09:49:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07CCF610F9
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Apr 2021 09:49:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07CCF610F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FFfjq2TW4z30hc
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Apr 2021 19:49:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=eC2rQ34n;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org;
 envelope-from=peterz@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=casper.20170209 header.b=eC2rQ34n; 
 dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FFfjH0Trkz2xfm
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Apr 2021 19:48:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=+qSokmLjMhdEnOSkSopblq5MKalEi8UUYD3QbqGxqos=; b=eC2rQ34nM7cRrzDAhzzhEN3wPe
 kTzKVXiPYsQriyTitj8XaOZiOMYSs2CmPna+vSZrzx2X+AyYzDfGkh6XwDeUaP/R2Sdhw0fUQHZoE
 xcIkVZ9BgwAGrHrQdPx1JVxc28uo8a4iZ5LllVP7TnFFfJ9CG+a4lOMAZ0xT4W5AUDITT4PKOzipn
 iYX5eNIGnsNYC8ByBciAnWPp9g9vDQf8R7DSJ/g+l6EF+CP1ntsJaOLY4qb8I0kMJDUqs+viQJKqd
 up6N4jP4nowpqWEIhSTtf6tIwQksMPnvi+P/KtQNQPk3PhCqoIF2gV1qmvrv5jzGvLRrNMJHVDhzZ
 FeCH/O7Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=noisy.programming.kicks-ass.net)
 by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lU4ms-00EGP6-RS; Wed, 07 Apr 2021 09:47:54 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 44BCF300119;
 Wed,  7 Apr 2021 11:47:49 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 27BB724403DB8; Wed,  7 Apr 2021 11:47:49 +0200 (CEST)
Date: Wed, 7 Apr 2021 11:47:49 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Stafford Horne <shorne@gmail.com>
Subject: Re: [OpenRISC] [PATCH v6 1/9] locking/qspinlock: Add
 ARCH_USE_QUEUED_SPINLOCKS_XCHG32
Message-ID: <YG1/xRgWlLHD4j/8@hirez.programming.kicks-ass.net>
References: <1617201040-83905-1-git-send-email-guoren@kernel.org>
 <1617201040-83905-2-git-send-email-guoren@kernel.org>
 <YGyRrBjomDCPOBUd@boqun-archlinux>
 <20210406235208.GG3288043@lianli.shorne-pla.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210406235208.GG3288043@lianli.shorne-pla.net>
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
 Guo Ren <guoren@linux.alibaba.com>, Arnd Bergmann <arnd@arndb.de>,
 Anup Patel <anup@brainfault.org>, Boqun Feng <boqun.feng@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-csky@vger.kernel.org, openrisc@lists.librecores.org, guoren@kernel.org,
 sparclinux@vger.kernel.org, Waiman Long <longman@redhat.com>,
 linux-riscv@lists.infradead.org, Will Deacon <will@kernel.org>,
 Ingo Molnar <mingo@redhat.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Apr 07, 2021 at 08:52:08AM +0900, Stafford Horne wrote:
> Why doesn't RISC-V add the xchg16 emulation code similar to OpenRISC?  For
> OpenRISC we added xchg16 and xchg8 emulation code to enable qspinlocks.  So
> one thought is with CONFIG_ARCH_USE_QUEUED_SPINLOCKS_XCHG32=y, can we remove our
> xchg16/xchg8 emulation code?

CONFIG_ARCH_USE_QUEUED_SPINLOCKS_XCHG32 is guaranteed crap.

All the architectures that have wanted it are RISC style LL/SC archs,
and for them a cmpxchg loop is a daft thing to do, since it reduces the
chance of it behaving sanely.

Why would we provide something that's known to be suboptimal? If an
architecture chooses to not care about determinism and or fwd progress,
then that's their choice. But not one, I feel, we should encourage.

