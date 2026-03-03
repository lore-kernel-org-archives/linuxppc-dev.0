Return-Path: <linuxppc-dev+bounces-17604-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DB69EDA693
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Mar 2026 16:10:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fQLNm5bXCz3c9l;
	Wed, 04 Mar 2026 03:10:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772554200;
	cv=none; b=humI6h5J6VxEs3cqJIsEt2whIOfEaJ2UtL98m0EsgCtnfkDaANZ+yBw9QFLIXFthxdj8Wj/NT6IC5bDC+Wnd8XlKwErKDGm9YmLGtezCKQ9jl4JaHwTc5YrKL15qW3qx6DR6N8XrKA65PmWaLLqhBfy1PipgTBsh6aORKpdt50E7rapKG5xO6ANeqdKnb/1ePQrzXY1rOXtlLn/FBnr95vEIwonQRs0JW6qpUIwEPuQuHr+g4THlVwz/1g+Ox+O92ERFi/lv+see4OAl7G+YAknNodjFuEBYwoEvFKRuib7kHimxyHVJRBAMkzL4toUVuSf/K4dqWtWUKrEHr4BQ9g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772554200; c=relaxed/relaxed;
	bh=HZwhrmuRPeFiAL7U9ekfKCBSdNddOHmeVRgOtJ35nGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C9gDWNjNslo2iIMx53wHUcA+kGy3o3CIOob8a1PPGtCXEHTqdY0qxPI5BZxb3qegP1nboD1RA0gQyreSU/iJ/2N1ef3c1CpZ+k8Q+EmaBKncx3fImtL4iPMWE8dOsrTT7EuzDXAANb+E1JlpBuftsGLY0f5CF9irp9om7Wnae/D3AVLSC1L8rAEkr3mpqGhVGeWAh2r6aOuklJG+ptXHtRj3VzeCdl6mTy4avKre+0gxAJISbsRMuhfEPchKr8826cQdm5uHw30KzBmsNrBt+SsW68smfkiPKeOf8xXrTu6grY+AleTkbBsNCtcLdJvFm36anbQfI4eZrUvK150FjQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org) smtp.mailfrom=lst.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lst.de (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fQLNm0wz5z3bn4
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Mar 2026 03:10:00 +1100 (AEDT)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6BC1768C4E; Tue,  3 Mar 2026 17:09:55 +0100 (CET)
Date: Tue, 3 Mar 2026 17:09:55 +0100
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
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
Subject: Re: [PATCH 24/25] xor: pass the entire operation to the low-level
 ops
Message-ID: <20260303160955.GJ7021@lst.de>
References: <20260226151106.144735-1-hch@lst.de> <20260226151106.144735-25-hch@lst.de> <20260228065810.GJ65277@quark>
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
In-Reply-To: <20260228065810.GJ65277@quark>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Feb 27, 2026 at 10:58:10PM -0800, Eric Biggers wrote:
> On Thu, Feb 26, 2026 at 07:10:36AM -0800, Christoph Hellwig wrote:
> > +#define __DO_XOR_BLOCKS(_name, _handle1, _handle2, _handle3, _handle4)	\
> > +void								\
> > +xor_gen_##_name(void *dest, void **srcs, unsigned int src_cnt,		\
> > +		unsigned int bytes)					\
> > +{									\
> > +	unsigned int src_off = 0;					\
> > +									\
> > +	while (src_cnt > 0) {						\
> > +		unsigned int this_cnt = min(src_cnt, 4);		\
> > +		unsigned long *p1 = (unsigned long *)srcs[src_off];	\
> > +		unsigned long *p2 = (unsigned long *)srcs[src_off + 1];	\
> > +		unsigned long *p3 = (unsigned long *)srcs[src_off + 2];	\
> > +		unsigned long *p4 = (unsigned long *)srcs[src_off + 3];	\
> 
> This reads out of bounds if src_cnt isn't a multiple of 4.

Assuming the compiler doesn't do the obvious optimization and
drop it, but yes, should be easy enough to avoid this.


