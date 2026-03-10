Return-Path: <linuxppc-dev+bounces-17965-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FB63FD2D91
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Mar 2026 14:00:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fVbBC5sFfz3cB5;
	Wed, 11 Mar 2026 01:00:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773151235;
	cv=none; b=IDMKOH/5gy9B9Sena5vzXNwXBTUdW0SvESqy71Ga50HG+DXV6DpBDcWb5MROXrALzKpAKloKYdsrY2p2FDYOyqTWf/qrE9ZqWUeEC14rJHmC2792p9YlkNzk8JgCeupCLPGIYIlpgRRB4A+UAOqBujDfpW6DHY+3YlBruShBLS0WIQ+f/XtzsbHx8DUOACAAizU2hUaVTbvNUJao6oqQGu9GuVYsaSxfIgF/bXmmS66rxHhKKpTzc2B3GF0HEgdPJVjLzUiU7BZDVBwWiJEot3YcUAgLkmJMePZiHGSREdOmXbWk7WKlrNa5m4NYtEkhoNfR47otlq0lTEhGESziXw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773151235; c=relaxed/relaxed;
	bh=KBtM6FHB1Hg+j/uC6YjMuSNyq8zYoksAvnYz45W3iLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ly93W9YLYUMJ1r7TJZl0aFM9bk5tIjcT4w8I+sGZ8PxcG6LNrkaDpc8Ce29NWasFwXcP6vSx81+KqHfnMw/hVIXW/3bB8RkoQu+4KOAslc/pycZ7CDy9hXeMRXbrKiH3CX2zAkWNuIwqFv2iim8MBWj05cagd9OmS5U5gBGJPfAo/R0vpsp0FpBYDqtJmI44C+8lTGQsbh1Jm7gh/26dJ7bnAC6cCQBGHCQX6/vPiS3uRqSrtGZVsp/llzYRMjdqwHuTGe7bjkMShxQBRbZHyf7zjDs2GaydTMz5+qqQIo3Q3+vYtDGsojpLq4U8M+ArCsjm0rxlplDGs7ESUm+4SQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org) smtp.mailfrom=lst.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lst.de (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fVbBB6MQGz30Lw
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2026 01:00:34 +1100 (AEDT)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9EFDD68C4E; Tue, 10 Mar 2026 15:00:21 +0100 (CET)
Date: Tue, 10 Mar 2026 15:00:20 +0100
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
Message-ID: <20260310140020.GA8490@lst.de>
References: <20260226151106.144735-1-hch@lst.de> <20260226151106.144735-10-hch@lst.de> <20260228071521.GK65277@quark> <20260303160911.GI7021@lst.de>
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
In-Reply-To: <20260303160911.GI7021@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Mar 03, 2026 at 05:09:11PM +0100, Christoph Hellwig wrote:
> And earlier version did this, but it's a bit ugly.  What I might
> consider is to require architectures that provide optimized version
> to opt into any generic one they want to use.  This would require
> extra kconfig symbols, but be a lot cleaner overall.

I looked into this, but because the static_call requires a default
version I gave up on it for now.  In theory we could build just
a single generic one for that and make the others optional, but
that feels a bit odd.

