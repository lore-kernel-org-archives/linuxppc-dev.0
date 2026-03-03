Return-Path: <linuxppc-dev+bounces-17626-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4277EDEBE5
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Mar 2026 19:56:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fQRPs6qZMz3bsC;
	Wed, 04 Mar 2026 06:56:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772567777;
	cv=none; b=LmsVPT6TDi3XNMHBhYSvgx1crEnozP897+Rf4beZU/cxFCmcNe8SoK2RCaWW7H3QUsNisz37Q2JfpTi0hhsMbYDL8BtuS337Ey6NNt9NgsXVqyFEE9QPkhQ3UdmWDkS/wPcDVVUg2aqZqsvX+j/GR4P7d+4zP9k60jk3XAt4AIfQfzHRkyZSgp2Bf4vUXVqS5SePT3/FYHPqcWRWSXYBEYsM8cU7DK1XCsLPLZYiWslMs2uq1paXROuEK8kHuNW4RUvp369RMub09MTt3C3P+aztboTRnQ9NEbeV3R7Bga9jpvireIJIO12/7GbNZe3/906aSG+ydEOl4Ym8u9b9EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772567777; c=relaxed/relaxed;
	bh=H1cg/0uRdxzNa6fXupnoKN1SuvGIxXIxO5vFL/AQ6K0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k23b4IdBx3StKr0szlgNmLXeVdpJEvit0NuSECnukYMwXdnmDE4W6Se5IlkZyW6uAAM8PeHNq+5c1eH09HFHiis9OXyxwcquEx+sbjV8qJBT9paK/S89xbrDBK19J+HUqn5MzeuCVDAC9q58Ay0Q5a3cSuNrzfe+2+BXobcbj/NYGURb7Fvi8zAaI/9Wc7j7QOiZMsS0ASefvUasQU3/jJw00JblNgEs+qR1DZGXx/gG8yBtkalpv07RUYv3Jvsdq8oJvtLm8VMYF6xIYXauAwMyL0V77ULeirBgYrX5K6sppWszaEPt6kqFnagc9NCtC+RW8LNQuT1ItflB0mBzZQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=mHMra/+s; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=mHMra/+s;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fQRPr5kwHz3bf8
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Mar 2026 06:56:16 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id A583F40684;
	Tue,  3 Mar 2026 19:56:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1644C116C6;
	Tue,  3 Mar 2026 19:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772567774;
	bh=9sr6A1ZQ/OAOM0MyaKuNScWB7UA08hne7lVI9ssYSPg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mHMra/+se8TmXPAvXWkLhgpf0kETRB4dEaJCtUtlUTftYpe0ReqfitRfwD4MGq4+T
	 WuzDe+k5qMfwF8Pvg7plbRdHjZuWKh+IB7lEOogeIHeGkKvwd2/EpZagMr99KeT7V+
	 XN7WYkTp/J6gkuhSVqd3D55QMpvT59XaPLLtFxjhlFBUF5SPdV1HoakLZQKIIo/fdH
	 BGibgd4432V2o3DyL8VfocxjZKarY5SdEW/Gzxyc6CkyylsV/unCa5mrJJyTo1wkxn
	 QMVCX29BeW41faad8f8MgUVR1waChaWC40npYyOs3agb3dJecKXchWeHWLYBSYXFrd
	 nwEHrCxoK1HSw==
Date: Tue, 3 Mar 2026 11:55:17 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <20260303195517.GC2846@sol>
References: <20260226151106.144735-1-hch@lst.de>
 <20260226151106.144735-2-hch@lst.de>
 <20260227142455.GG1282955@noisy.programming.kicks-ass.net>
 <20260303160050.GB7021@lst.de>
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
In-Reply-To: <20260303160050.GB7021@lst.de>

On Tue, Mar 03, 2026 at 05:00:50PM +0100, Christoph Hellwig wrote:
> On Fri, Feb 27, 2026 at 03:24:55PM +0100, Peter Zijlstra wrote:
> > >  	unsigned long *p1, *p2, *p3, *p4;
> > >  
> > > +	WARN_ON_ONCE(in_interrupt());
> > 
> > Your changelog makes it sound like you want:
> > 
> > 	WARN_ON_ONCE(!in_task());
> > 
> > But perhaps something like so:
> > 
> > 	lockdep_assert_preempt_enabled();
> > 
> > Would do? That ensures we are in preemptible context, which is much the
> > same. That also ensures the cost of this assertion is only paid on debug
> > kernels.
> 
> No idea honestly.  The kernel FPU/vector helpers generally don't work
> from irq context, and I want to assert that.  Happy to do whatever
> version works best for that.

may_use_simd() is the "generic" way to check "can the FPU/vector/SIMD
registers be used".  However, what it does varies by architecture, and
it's kind of a questionable abstraction in the first place.  It's used
mostly by architecture-specific code.

If you union together the context restrictions from all the
architectures, I think you get: "For may_use_simd() to be guaranteed not
to return false due to the context, the caller needs to be running in
task context without hardirqs or softirqs disabled."

However, some architectures also incorporate a CPU feature check in
may_use_simd() as well, which makes it return false if some
CPU-dependent SIMD feature is not supported.

Because of that CPU feature check, I don't think
"WARN_ON_ONCE(!may_use_simd())" would actually be correct here.

How about "WARN_ON_ONCE(!preemptible())"?  I think that covers the union
of the context restrictions correctly.  (Compared to in_task(), it
handles the cases where hardirqs or softirqs are disabled.)

Yes, it could be lockdep_assert_preemption_enabled(), but I'm not sure
"ensures the cost of this assertion is only paid on debug kernels" is
worth the cost of hiding this on production kernels.  The consequences
of using FPU/vector/SIMD registers when they can't be are very bad: some
random task's registers get corrupted.

- Eric

