Return-Path: <linuxppc-dev+bounces-17392-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D86AFEFB56
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Feb 2026 14:30:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fMrN66PNKz30Sv;
	Sat, 28 Feb 2026 01:30:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:8b0:10b:1236::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772202646;
	cv=none; b=c/JH7m7RiQj4JCK04aqu/IqSJ7NsEDf53KHVJmeY/CGoioopDH0GuFIp5zI69NHfjXffoj24X0sg1QG+CXURjpOd8z5fVs4SnNXv2Vv2zIQnaYxEOcH4wG0VqvCnPGLhaUVL/voo/TfDc8dDeG5OE+VroMWeGbY9AdU88Mlql3okvocPOX+oqGlUAjyAK13Ub03WJ6eQ5LDS4t7cJJSrYbsZSSNpB2RqQhhigVg3H1MEExWxsTtjWeVgZxVAXDqzrEKqn09plJldCUlnXs4iM9uQaIR6WC3DQHGz3wTdvOeowl24if2T+q3nuP1Jy6rb2ZOOuldPtwMGxraVWjJnQg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772202646; c=relaxed/relaxed;
	bh=lOp11MEHkYYwHRuUi0PZxSk1JN5+nTDJOLnSpDaUbDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HB4WH1rL2z767SoHhK+DVkyUWf7xuS4Kk9d87xHF9Xu6NMdxYefZ4xO8LxJZmHKBKD8dIR8NaPnNEBQ54d3vG7gTd9Bn92gbyWe0yXtuTn6kbe6hrrfJlV6O2B1FOFMceULflkuaYlaw+j7+ckZ31ob5kbwG/icSGXGOYUA1L11DFU0QH9DCcktSf+I6TBc8tDxlzglzNdHI0qcti0s3wEdOITkCR+ipdEoJlFZPHahY1bVHhHb9HlDorgEH1nia+S6v+GwiX5yyX+3ma91p/s0mqzBfY+FvtvgavhN5LKAH4mTxVXh3Ic6C7vpKLY8fPz+6QqkBhZOD6Xa3gN8EXg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=Z9TK/udX; dkim-atps=neutral; spf=none (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=peterz@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=Z9TK/udX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=infradead.org (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=peterz@infradead.org; receiver=lists.ozlabs.org)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fMrN60K61z30N8
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Feb 2026 01:30:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lOp11MEHkYYwHRuUi0PZxSk1JN5+nTDJOLnSpDaUbDc=; b=Z9TK/udXiurPXiytUakXbFeev1
	ri7v9BFFO7R7ZiJvpbTW1JFNZRneKl3isIJyG3zHlkz9s2XQmusrQ/zacC5tOadz4Z7qmOWC49end
	3fVssHWiU1uZPXJxiiQFriaeu9YgtBdmdglQ2CtYVshTHvu5aWjnfh1f3CqeCm2LMKGKqofhFMRq5
	2FTQrOlmRLWH57X+/mT4zC19PNT7lNgxKvCQLn4m60NIZInXyfVhYVB3n68h6H+ZGw2r9VS0iGiNq
	QnT1zFqHAqIdiC0LM2DhVATtSnPcGUsNzzjMV7n5w3njjHXBfMs/S6eMK73CqMCrr/PUyh+1FLh1J
	kCLUtTiQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvyrB-00000004hgm-0psV;
	Fri, 27 Feb 2026 14:30:17 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B3685300CDE; Fri, 27 Feb 2026 15:30:16 +0100 (CET)
Date: Fri, 27 Feb 2026 15:30:16 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
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
Subject: Re: [PATCH 18/25] x86: move the XOR code to lib/raid/
Message-ID: <20260227143016.GH1282955@noisy.programming.kicks-ass.net>
References: <20260226151106.144735-1-hch@lst.de>
 <20260226151106.144735-19-hch@lst.de>
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
In-Reply-To: <20260226151106.144735-19-hch@lst.de>

On Thu, Feb 26, 2026 at 07:10:30AM -0800, Christoph Hellwig wrote:
> Move the optimized XOR code out of line into lib/raid.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/x86/include/asm/xor.h                    | 518 ++----------------
>  arch/x86/include/asm/xor_64.h                 |  32 --
>  lib/raid/xor/Makefile                         |   8 +
>  .../xor_avx.h => lib/raid/xor/x86/xor-avx.c   |  14 +-
>  .../xor_32.h => lib/raid/xor/x86/xor-mmx.c    |  60 +-
>  lib/raid/xor/x86/xor-sse.c                    | 476 ++++++++++++++++

I gotta ask, why lib/raid/xor/$arch/ instead of something like
arch/$arch/lib/xor ?


