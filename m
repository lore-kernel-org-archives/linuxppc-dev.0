Return-Path: <linuxppc-dev+bounces-17447-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7293DFEE4EA
	for <linuxppc-dev@archiver.kernel.org>; Sat, 28 Feb 2026 10:32:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fNM2966pPz30BR;
	Sat, 28 Feb 2026 21:32:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:8b0:10b:1:d65d:64ff:fe57:4e05"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772274721;
	cv=none; b=Jw3GU90QF7zuBoyjN4rYPt9ljRk33fiFOW/QHSvkGGpMrpPytjVEjW3HI1rjdHunoT30Qxq8XZyyQHfNDEcMFKnloqExlgvI3OCNG4JxVTQDR3AVg2TBovXvQuJo3wiyyjC/Pnps/fc+9b70eNMJAW8PY8oJwwa+aWg4+W0bqeBiwV4oDU5vxyZX8vo8xBKU4HqOwok5iX1O/TroegrdQ9UfMEcagTw5Vnj25OpKUj8xp2sFIUFg0R6NvXg3yl2EYBhsVJX5cK7F8CP7rYWkLFBpf6iCbGRH3W7g1WQoEUvPM6oOtLT/chFdyQawoH7glYqr5rfGtjNtSmnJQ93Wmw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772274721; c=relaxed/relaxed;
	bh=TMfQFraLliTO9OYi4VnvV7gf7AjKPxIluxE2boSfq9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V7VfMz+wJzyYc68JX+AqMW8sR3spwhchZGtqjS2KWkWx7yXV947rUxkUaifAY66/G/WHRwQto/jF4tB7Xe/n+xFKlyozwkZgdTyZauJr3uRpRr+jDLy0aWcqsWE+oyK1FgWG3Inceq4T9a3C2Z87V/4nB2pgr/1131rEsQ0XHb+YYFNbKivcEyoRSJ0EGibOfWddv/8YRChvqYxO5RDYFFBT/DaDy0kH/dPGm+sM6iLbMslE2ts7+lF9eqrKjCaiDicJNXmJ/Fo1ZXi6tj9PaDeWXACnDU0RT7yseKWxZJbjnid5bKYUpf9MTEyuRfC1WqmTbyoh26mc3XCHwU/jyA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=Ihs5Yf5H; dkim-atps=neutral; spf=none (client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05; helo=desiato.infradead.org; envelope-from=peterz@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=Ihs5Yf5H;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=infradead.org (client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05; helo=desiato.infradead.org; envelope-from=peterz@infradead.org; receiver=lists.ozlabs.org)
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fNM2773hHz2xQs
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Feb 2026 21:31:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=TMfQFraLliTO9OYi4VnvV7gf7AjKPxIluxE2boSfq9E=; b=Ihs5Yf5HVrcI20Hvh5VGWrIGtj
	w539I2X4jBa2jKtS495tj7OW6yzhUvsPzuvYxap8QuwZoigJhFPba8v5sdtkPlsa6ID6C16CNvr3D
	fYcDuOEFbymUfK08ZwvafhxK/cQQqT8fuyE87FJ8bLSaBRcRuE1oHdJ8cGt5ahL8RttPyiMxygm7n
	mt+sFX75z3hVeBiEagfvPL++3zVOztglGmkatawM3oQt9uFpQqkNr4WQvFkrT+2czFsf7HwHxTWyD
	ed2+E9lBjpxNLnaogre7bAMexNOCdGPm1iLI1kQQI6WFzJBF95/QpTcsQabK0eral+I71Lj4w+g8Q
	gLUIf0SA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwHbS-0000000EUcv-1pQT;
	Sat, 28 Feb 2026 10:31:18 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2ADC430066A; Sat, 28 Feb 2026 11:31:17 +0100 (CET)
Date: Sat, 28 Feb 2026 11:31:17 +0100
From: Peter Zijlstra <peterz@infradead.org>
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
Subject: Re: [PATCH 18/25] x86: move the XOR code to lib/raid/
Message-ID: <20260228103117.GK1282955@noisy.programming.kicks-ass.net>
References: <20260226151106.144735-1-hch@lst.de>
 <20260226151106.144735-19-hch@lst.de>
 <20260227143016.GH1282955@noisy.programming.kicks-ass.net>
 <20260227235529.GA31321@quark>
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
In-Reply-To: <20260227235529.GA31321@quark>

On Fri, Feb 27, 2026 at 03:55:29PM -0800, Eric Biggers wrote:
> On Fri, Feb 27, 2026 at 03:30:16PM +0100, Peter Zijlstra wrote:
> > On Thu, Feb 26, 2026 at 07:10:30AM -0800, Christoph Hellwig wrote:
> > > Move the optimized XOR code out of line into lib/raid.
> > > 
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > ---
> > >  arch/x86/include/asm/xor.h                    | 518 ++----------------
> > >  arch/x86/include/asm/xor_64.h                 |  32 --
> > >  lib/raid/xor/Makefile                         |   8 +
> > >  .../xor_avx.h => lib/raid/xor/x86/xor-avx.c   |  14 +-
> > >  .../xor_32.h => lib/raid/xor/x86/xor-mmx.c    |  60 +-
> > >  lib/raid/xor/x86/xor-sse.c                    | 476 ++++++++++++++++
> > 
> > I gotta ask, why lib/raid/xor/$arch/ instead of something like
> > arch/$arch/lib/xor ?
> 
> Similar to lib/crypto/ and lib/crc/, it allows the translation units
> (either .c or .S files) containing architecture-optimized XOR code to be
> included directly in the xor.ko module, where they should be.
> 
> Previously, these were always built into the core kernel even if
> XOR_BLOCKS was 'n' or 'm', or they were built into a separate module
> xor-neon.ko which xor.ko depended on.  So either the code was included
> unnecessarily, or there was an extra module.
> 
> Technically we could instead have the lib makefile compile stuff in
> arch/, but that would be unusual.  It's much cleaner to have the
> directory structure match the build system.

Hmm, I suppose. Its just weird that we now have to look in both
arch/$foo and lib/*/$foo/ to find all arch code.

And I don't suppose symlinks would make it better?

