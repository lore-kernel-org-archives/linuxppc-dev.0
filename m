Return-Path: <linuxppc-dev+bounces-20272-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35B30FF8875
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Apr 2026 11:26:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g5FPf4m2Zz2ySf;
	Wed, 29 Apr 2026 21:26:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777462006;
	cv=none; b=jFGmadnlaOMTnJHN9KJOU/1Zwg9a80dqohbHLKYtKgB4R5Q4RwTLVTzhDIAFIoIIEkadTOa/Dez1aQRcqvfYagSDU/nPIuvjiHw2ybWk+E+pE0CwS8JeG8lo9O5yYodafZKwyEJ20ULctpY3+kMBuJEIE4sFMzRfgKzvVNffu4VzcrtXpJxZfHj5JzUCkAbZaV+iCr42PFmn+oPyvrHTPvQdPy4ds8Iu4MWRfxdPpOUw9D55YPN6EG8jYoNHNzBM1DNY33R/SQWlJ1XKmHQLFsV1phBGQ3PLcLs6PfMKVRR9ZEVCvi29WtOohwFJal2lkJ4XRukVoapZMgw+hNXNKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777462006; c=relaxed/relaxed;
	bh=goNuGKh90jfzrTtcM8AQu4/qcccrIqr5mhqWXnjaDnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N9mOBeCxgsFa7mBnvBFfSjmSgWwqjfCbk702K9QzheU+n7bSYV9RVotPSMzhCSHA6Y0Y5piqUbVCvT98eqYEzQcT6ZsNlBL4QCe8Sj/XYBvSvjDkrumuzmlgVzSwdWXwAqEvszUPuYYQPP1w4JgdfaqR1tBIw8SlileqMNo49t7LRmR7PwoZEjBQH070j2CnONJacTGXPuYRMP83cYX1ilSO7DW7AmNhh4m9UCF9XkdS34InXBge9cGVAAGNH8VqthG7cIlu5o6JPvtIdZh4udvVKvIGD5Dz8fykPcjyEVu7YR3Ysnx35FqRLPyt1aaVAzaij4LPg+AbM+1SXvkhGg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ejvHWE1z; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=will@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ejvHWE1z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=will@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g5FPd2vDYz2ySc;
	Wed, 29 Apr 2026 21:26:45 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id CA92D403EB;
	Wed, 29 Apr 2026 11:26:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 158D1C19425;
	Wed, 29 Apr 2026 11:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777462002;
	bh=HgV0q/+gZ9n2giWTxhUD6P3yQ6wEmY66ZwCWQHhgQ2g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ejvHWE1zJ0tb1KwQu/gVCMj0KcNhlMqCOjLI4kQmWC01EPIO4HFDTFQg5PpNyMx2F
	 7OMWgwbyfp16yd5ZKGLwfDDMuBlWK8CK9qcSIqUHZRxyhnWE4iAN+OK+xmr5WBtr4T
	 BgqmCB7r/rsFvwFu/mT2z67QkDE/mDzOf7GDi68KHsQjYM3r7svy7TXqJDW5kWsfNa
	 xYHmkznhflijvwvOUJkH6AcM42ZHWo8kZp7k26fwbFC82N/jHC8/F/rL8GlM8z6Ksh
	 UMOZ5KVH94exo80oAIrmoHKOK/k/qke5mU8V2uOXUW3Mlxuf7JynBO/Edq8wMcfI5M
	 twwrBSWDcoLLw==
Date: Wed, 29 Apr 2026 12:26:30 +0100
From: Will Deacon <will@kernel.org>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Yury Norov <ynorov@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	David Laight <david.laight.linux@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>, linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
	dmaengine@vger.kernel.org, linux-efi@vger.kernel.org,
	linux-fsi@lists.ozlabs.org, amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
	linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
	xen-devel@lists.xenproject.org, linux-fsdevel@vger.kernel.org,
	ocfs2-devel@lists.linux.dev, bpf@vger.kernel.org,
	kasan-dev@googlegroups.com, linux-mm@kvack.org,
	linux-x25@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-sound@vger.kernel.org, sound-open-firmware@alsa-project.org,
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
	linux-sh@vger.kernel.org, linux-arch@vger.kernel.org,
	catalin.marinas@arm.com
Subject: Re: [RFC PATCH v1 8/9] arm64: Add unsafe_copy_from_user()
Message-ID: <afHq5vyNUJzxVwDV@willie-the-truck>
References: <cover.1777306795.git.chleroy@kernel.org>
 <5b09e58a84c9edcfe5724db5cd57e45d96a96bfa.1777306795.git.chleroy@kernel.org>
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
In-Reply-To: <5b09e58a84c9edcfe5724db5cd57e45d96a96bfa.1777306795.git.chleroy@kernel.org>

[+Catalin]

On Mon, Apr 27, 2026 at 07:13:49PM +0200, Christophe Leroy (CS GROUP) wrote:
> At the time being, x86 and arm64 are missing unsafe_copy_from_user().
> 
> Add it.
> 
> Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
> ---
>  arch/arm64/include/asm/uaccess.h | 29 ++++++++++++++++++++++++-----
>  1 file changed, 24 insertions(+), 5 deletions(-)

Why?

And please cc the arm64 maintainers on arm64 patches next time. You've
managed to cc most of the world apart from us.

Will

