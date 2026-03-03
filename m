Return-Path: <linuxppc-dev+bounces-17603-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CD42EDA693
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Mar 2026 16:09:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fQLMy6qg7z3c5f;
	Wed, 04 Mar 2026 03:09:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772554158;
	cv=none; b=jd/NqB2QML6VVxgdHjq7B865c3IU5yRc7UxKjJ77KKP7e1Ymnk0CxlxlJdAvRrnTbRxSaAdTYCaQTVMTsCW2tjRJrsHVvxCAzTOsdaDNh68eXGx9chVAC4mbPmLwqjayHGAW7AZBTzo3S5qJNQT6Zz/EDzsYSeEfAzOStQyHVjV6BQKaTaq9Qffv6eUWTdY3hXDhIAZseph+NX1xq59uDQsC9PtV0QOvWZf3Psi6eei10ioNXEcz05BH5yzuEwOwv/aSNG2jZp9cwvL6x0T/988VYg3eLMmzu54D1hRa1vq6pnLPpzJHqcQW371dLyuxoqfIKD2I0QPSxmjh+HUn2A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772554158; c=relaxed/relaxed;
	bh=m0eugKb8aGos3h+sBAkFolXk5OApfEJAp9DK80wSVAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TeWrF+a5AywxLL9er1D/2cZD98rnk5LodXrxsCOBvzSTd308ou1Fs3OCE67t0OEHLzcG/XINIeSDDi8cDHhXaerIngd8Gt6DXlczQ4biiQ7WrLQ4yNOy9QLGnytQYTeyi71tL6HHcTyLJwwXxtG2jjjNu8RaHLAPlwaS61zuB+q8vl1e7/6AAUG34FemFwg7axCcjn0fyFzodFyiQRYT/Ob0DITqG2NaX8KJ7C1ppgnf8pKpNkknwsTPc/MddCI9P08vk/xDnBwUI958PibKr2OwtzjTpLsLZyNpYRr4C5Uwk/UCSLkPPj4k3efBfXKLsiQGhJc+Zsu5Q+LBEW+Ucw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org) smtp.mailfrom=lst.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lst.de (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fQLMy1Vzfz3c55
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Mar 2026 03:09:18 +1100 (AEDT)
Received: by verein.lst.de (Postfix, from userid 2407)
	id C608B68BFE; Tue,  3 Mar 2026 17:09:11 +0100 (CET)
Date: Tue, 3 Mar 2026 17:09:11 +0100
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
Subject: Re: [PATCH 09/25] xor: move generic implementations out of
 asm-generic/xor.h
Message-ID: <20260303160911.GI7021@lst.de>
References: <20260226151106.144735-1-hch@lst.de> <20260226151106.144735-10-hch@lst.de> <20260228071521.GK65277@quark>
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
In-Reply-To: <20260228071521.GK65277@quark>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Feb 27, 2026 at 11:15:21PM -0800, Eric Biggers wrote:
> This makes the generic code always be included in xor.ko, even when the
> architecture doesn't need it.  For example, x86_64 doesn't need it,
> since it always selects either the AVX or SSE code.

True.  OTOH it is tiny.

> Have you considered putting the generic code in xor-core.c (or in
> headers included by it) before xor_arch.h is included, and putting
> __maybe_unused on the xor_block_template structs?  Then they'll still be
> available for arch_xor_init() to use, but any of them that aren't used
> in a particular build will be optimized out as dead code by the
> compiler.

And earlier version did this, but it's a bit ugly.  What I might
consider is to require architectures that provide optimized version
to opt into any generic one they want to use.  This would require
extra kconfig symbols, but be a lot cleaner overall.


