Return-Path: <SRS0=3VWP=OF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 922FCC433F5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Sep 2021 01:51:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D571A600AA
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Sep 2021 01:51:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D571A600AA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4H8NVp2GnLz3059
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Sep 2021 11:51:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=DhJ6GOb1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=sstabellini@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=DhJ6GOb1; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4H8NV210Fyz2xMF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Sep 2021 11:51:06 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id CDF8061211;
 Wed, 15 Sep 2021 01:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631670662;
 bh=z0W70Z4JOetSa7g8CfvjNwgRWC4qCwo9bmhv6sh9Bxs=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=DhJ6GOb1z9RF8MoKZiSnxeXdJKNkyxJ7YyiEn0qQubMzT9FZtSjTJUt/KUr+QwVKI
 +frjDgFVeOdxWz9IZc7wervGNYWJ63gSfCERzcvLkSnA46r3ypahZL2U/4IHNXcntT
 /DqRf5MOYuMRlQ77Uv0SNMsaDJzboDdlLxIhocqe0R7UgiEK7ZBy99L8v0w5K3bX72
 sJ48QhBWhdiCuNKFPKWm/Qjfkv8EiwrcYFd4jtxEycZyiFEiLrwMg1PFndT/7dOiPM
 zl0gJLYf7yi4Oohaksg8j8XTXXQSSgFUXRaPI/wIqRfum+bBu2e2ldXr9TpWz6n+3M
 stAUSLvG5uH7w==
Date: Tue, 14 Sep 2021 18:51:01 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To: rm.skakun@gmail.com
Subject: Re: [PATCH] swiotlb: set IO TLB segment size via cmdline
In-Reply-To: <20210914153046.GB815@lst.de>
Message-ID: <alpine.DEB.2.21.2109141838290.21985@sstabellini-ThinkPad-T480s>
References: <20210914151016.3174924-1-Roman_Skakun@epam.com>
 <7c04db79-7de1-93ff-0908-9bad60a287b9@suse.com> <20210914153046.GB815@lst.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
Cc: Roman Skakun <rm.skakun@gmail.com>, linux-doc@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Jan Beulich <jbeulich@suse.com>, Will Deacon <will@kernel.org>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Stefano Stabellini <sstabellini@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 hch@lst.de, xen-devel@lists.xenproject.org,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Muchun Song <songmuchun@bytedance.com>, Thomas Gleixner <tglx@linutronix.de>,
 Juergen Gross <jgross@suse.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Andrii Anisov <andrii_anisov@epam.com>, linuxppc-dev@lists.ozlabs.org,
 Randy Dunlap <rdunlap@infradead.org>, linux-mips@vger.kernel.org,
 iommu@lists.linux-foundation.org, Roman Skakun <roman_skakun@epam.com>,
 Andrew Morton <akpm@linux-foundation.org>, Lu Baolu <baolu.lu@linux.intel.com>,
 Robin Murphy <robin.murphy@arm.com>, Mike Rapoport <rppt@kernel.org>,
 "Maciej W. Rozycki" <macro@orcam.me.uk>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 14 Sep 2021, Christoph Hellwig wrote:
> On Tue, Sep 14, 2021 at 05:29:07PM +0200, Jan Beulich wrote:
> > I'm not convinced the swiotlb use describe there falls under "intended
> > use" - mapping a 1280x720 framebuffer in a single chunk? (As an aside,
> > the bottom of this page is also confusing, as following "Then we can
> > confirm the modified swiotlb size in the boot log:" there is a log
> > fragment showing the same original size of 64Mb.
> 
> It doesn't.  We also do not add hacks to the kernel for whacky out
> of tree modules.

Also, Option 1 listed in the webpage seems to be a lot better. Any
reason you can't do that? Because that option both solves the problem
and increases performance.
