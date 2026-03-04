Return-Path: <linuxppc-dev+bounces-17729-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA31CEF8FFA
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Mar 2026 15:42:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fQxky1tCxz3c1J;
	Thu, 05 Mar 2026 02:42:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772638970;
	cv=none; b=QUdoo9Zhd2luFnXvLRvj9bsh4O48u5zhcsD7Puv+12TtfHxq6Z9N21Vc2K0SqW/7QXa9aB7GuKMLepOnbxFjKftZ0QvgbPtxxruKOK00FVLqaI/l9hpvIQwYTuyJdcI6UX57YIWtk1X6PjJLtsmN6ohRxsMBLfN+Ds4fBuGPYB1V1xG0MdbKM9pK9dRm+VfVaVk8d8R034lilvNTIJnXQ3KvUP0Dn0407DhQtpUofb3rkE8z7PXpQEg16FN8vd5rIncVwHbXLNnLtVSYRmH5G0P3dj5oaqDkdWxyJPbpuk7OXMno9i1ZTLxJHlp6i7Cl3rmZ+35GTl4TeEJHPLMUDg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772638970; c=relaxed/relaxed;
	bh=dozotgLjCkx6YfloJbc2dUGdgLVASeazqMNufNecUOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BJ4iIbMiVRtktVlH3XosOIZSgjW8ZJTUV88UA62tFxApxh2dIdekFKHgLOVrZUiR9WelyofLl2Rv+YPyyrafbFcnl+idbsrB8tyNbkF3L9vhg4Zp5UktP/CRrB+wjykHYPZWVXl+aXjtq9ehtX+WBWu3dYHgnBFxIMbnhY5Zy0o8371Ws6sWXnhyxccD7reVpJ3nfYbBNlCkkKkhOw4wXvuSshnLEgyL+Sh4gMA8eHe5HBTV1JBafBAv9eB/RCeMfjLAfutPMjalKt/TBQVzmfF/Mk3iliQ4kRU/tvh6RM7ZhD/buAZqj+TSUL90IXyyLJCL9B854OUjY6+gIF/HxA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org) smtp.mailfrom=lst.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lst.de (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fQxkx3LMFz3btw
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Mar 2026 02:42:48 +1100 (AEDT)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7375068AFE; Wed,  4 Mar 2026 16:42:41 +0100 (CET)
Date: Wed, 4 Mar 2026 16:42:41 +0100
From: Christoph Hellwig <hch@lst.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>, Eric Biggers <ebiggers@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Magnus Lindholm <linmag7@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
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
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Dan Williams <dan.j.williams@intel.com>, Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>, Arnd Bergmann <arnd@arndb.de>,
	Song Liu <song@kernel.org>, Yu Kuai <yukuai@fnnas.com>,
	Li Nan <linan122@huawei.com>, linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
	linux-crypto@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: [PATCH 01/25] xor: assert that xor_blocks is not called from
 interrupt context
Message-ID: <20260304154241.GA26451@lst.de>
References: <20260226151106.144735-1-hch@lst.de> <20260226151106.144735-2-hch@lst.de> <20260227142455.GG1282955@noisy.programming.kicks-ass.net> <20260303160050.GB7021@lst.de> <20260303195517.GC2846@sol> <20260304145134.GA21983@lst.de> <20260304151548.GN1395266@noisy.programming.kicks-ass.net>
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304151548.GN1395266@noisy.programming.kicks-ass.net>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Mar 04, 2026 at 04:15:48PM +0100, Peter Zijlstra wrote:
> On Wed, Mar 04, 2026 at 03:51:34PM +0100, Christoph Hellwig wrote:
> 
> > > How about "WARN_ON_ONCE(!preemptible())"?  I think that covers the union
> > > of the context restrictions correctly.  (Compared to in_task(), it
> > > handles the cases where hardirqs or softirqs are disabled.)
> > 
> > Good enough I guess.  Peter?
> 
> Sure. The only caveat with that is that for PREEMPT_COUNT=n this might
> not work, it unconditionally returns 0.

That's a pretty good argument for the lockdep version...

