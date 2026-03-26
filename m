Return-Path: <linuxppc-dev+bounces-18791-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16AB7109E551
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Mar 2026 05:18:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhBrn2kdKz2xlM;
	Thu, 26 Mar 2026 16:18:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774502329;
	cv=none; b=JsYryCj/DNmE5vU2IJVyAdsfZlgIv+qX9yCRrrWcE1jm+SrWZji7TtG+Ytbo35NxUjkgLTqqGWrC2yP3qQI7f+YV4avuczhFa7X2LYioRxsgT46xZoj/RAJ+5FKUFW1rQhNgtCoEgARpopHw2fPMZXL3/2uhFNjFG9zLqIqRAXPU2tOStEf6eya2UDOxgb2klTdImWIyA0YosyHqW5jyEyqM7ZbP4IOq9aQCMJ3zMCVq7/IYMxyQnPVk7nzu4N4GSSPaQCHKdsTBByOjFbDvPXHx/kj7ovE8Khxoih2OgMG6itTKw77VuclCNvuLqhbmvMpdHFo4frvdhsJFLatXUg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774502329; c=relaxed/relaxed;
	bh=xPd+Xwid+sFQehqOxG5aK9WXqz3DxjadA95L9h7hKac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bMjybe+XKSls7YbjDAHBFyXYV0QyNKjazDAvFYEORi3Za7vOZgHzztUA03EtlGbEHT2YBpbiS2rB8IM06AifWmFwqLnrvbh5Ry4k2d50CWKr/QaBo9Mo8veIIwsQoTY8etn3997jWO8DQtNVjcD5MDG4aB6jFrcKNYs17vTIPx7dx7SqPnEsMh7PatvygAZwnk+D2VhO/ns3MoY6C0cTEmFh8syfjdw6zKVFO+PhhXoBPq2bbG9WizqxvNBS81em9M9wGiZHqw1IFmpg7XzRTM0lg1Fxic95W/HgIhoDtG0Osr3jZlie03VPPmaMSdnF2uCuxMxoLixIA2g6Kt/NjQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org) smtp.mailfrom=lst.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lst.de (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhBrm0Y2Xz2xS5
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2026 16:18:46 +1100 (AEDT)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7351F68B05; Thu, 26 Mar 2026 06:18:37 +0100 (CET)
Date: Thu, 26 Mar 2026 06:18:37 +0100
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Magnus Lindholm <linmag7@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
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
	Li Nan <linan122@huawei.com>, Theodore Ts'o <tytso@mit.edu>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>, linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
	linux-crypto@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: cleanup the RAID5 XOR library v3
Message-ID: <20260326051837.GA22847@lst.de>
References: <20260324062211.3216301-1-hch@lst.de> <20260325193954.GC2305@quark>
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
In-Reply-To: <20260325193954.GC2305@quark>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Mar 25, 2026 at 12:39:54PM -0700, Eric Biggers wrote:
> This generally looks good, but yes, please check the comments from
> https://sashiko.dev/#/patchset/20260324062211.3216301-1-hch@lst.de, as
> Andrew mentioned.

Yes, I've looked into them and fixed the, the current version in the
git branch already has the changes.

> looks real as well, though I haven't tested it.  If preemption is indeed
> not the right thing to check, then I guess (following up from
> https://lore.kernel.org/linux-crypto/20260303195517.GC2846@sol/) it
> would need to be something like:
> 
>     WARN_ON_ONCE(!in_task() || irqs_disabled() || softirq_count() != 0);
> 
> Ugly, but we're running out of options.

So far I've just reverted back to the in_interrupted() check we had
before.  I can switch to the above, though.

> (This sort of thing is why the functions in lib/crypto/ and lib/crc/ are
> just supported in all contexts instead.  If FPU/vector/SIMD registers
> cannot be used in the current context, then a scalar fallback is used.)

We could do this fairly easily, but I'm not sure it is a good idea.
The callers of these routines are extremely limited, so we'd have to
add code for this which will then only be used by the new extensive
test code we'd have to add for it.


