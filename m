Return-Path: <linuxppc-dev+bounces-18787-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10CA5109C057
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Mar 2026 19:40:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fgy102zC2z2yYJ;
	Thu, 26 Mar 2026 06:40:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774467604;
	cv=none; b=jfjZj4JsYsKgw4v42kuhNTqKW0uJmtzCcOx3TCdfLSWleGKhUzdwvyUo9PX8GG3K0cfO7EubSM3hr7kIDLXOVb6z3Ku0jkuZZWYJKkvshX/LDN9KWXek+KFR4Pl2IQe9K8u/nCeggFAtnmGWNAh8BPRT1ZPsvnpQybeokG3ZsD/HZwQl0mFlegAa5n+Qoee/N+ZFMQ0Tuq/2XwKCrqXFgEypuKrMZUjrgmJd5FtFTE5AvyRKsJXsDzFJ3EQDlF21Xhu3NQgViijS3N0Xj5GDZQI4BpvJR/y4Ntd0sQTd1Y3jTALRynp91w033Hn8k98XkBZd0IMonWamsJdVgQGeVA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774467604; c=relaxed/relaxed;
	bh=Z3awqpGH+qDQnmpMIXhzeGdXvp+XuKXejLNw+4PmwpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f9EeOmrY+jZI7Jy9TuuqR71e+qtOPFHB/HbTbai2FHnMtJdw/WEWRk7t/+BzR/1T7gbrWDVt1SJFrY+2029MWJJefc7+DfaYrerwLjXU2DEtAnjAp5gHRfV4JuqdlqtzkyEITmlca5yPx/KQl+Y5XUsbhCKQUNvRz8gQ2X3SI/7//Y1FpNMperdi2ktAtOAAotWpTsmmg8tEiGYG1P9luuuj6BzFSE0qgx2QpgljZPNKNBxUQc7y90hDTwu2J6iobaINg2KxAWTXkdVNOr0rse3YgzneUDvRtMM6FaxYhoyFRGTN7rfocsVIxmYa6ZQNjJTJwXdZfeAZjbNzoAbdpg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=DygY0E8w; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=DygY0E8w;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fgy0x5W3fz2yY0
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2026 06:40:01 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 97FD843B76;
	Wed, 25 Mar 2026 19:39:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86172C4CEF7;
	Wed, 25 Mar 2026 19:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774467599;
	bh=vgzmS++XGgEKBkb/yAjVP8Sp4H+rVjAZlzJWbYtNQ5k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DygY0E8wyP/P9Q9kZFKoknR4RxtR6GMi9PjYKJh3Sbc2gqAytguh48eGOTnsx3c56
	 Q2YVatKuDK+N4nU8v6AxKOfcBzhChhEI3Df1zCL0wcOyAKNQgEB7oAOxflILmausqP
	 WOCeoLY2lmAchg2c7NGHGU4qpdmOxFI+jpbH1K0Ei46HKczGrbgGRBm1sI8nru20Vm
	 WRYSdUfozTetH29mYvuSFOROlG1SXAHZGao0e1tIcm/PcakbXOz5jtLmbmhcaQDLw8
	 UHpO2j30RaryLjmXyqJNpFRWy5VPKjdg008B9pxWETSOv3xeW2U6bVqeyivRW/5e7y
	 efVryfxsae7fQ==
Date: Wed, 25 Mar 2026 12:39:54 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
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
Message-ID: <20260325193954.GC2305@quark>
References: <20260324062211.3216301-1-hch@lst.de>
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
In-Reply-To: <20260324062211.3216301-1-hch@lst.de>

On Tue, Mar 24, 2026 at 07:21:36AM +0100, Christoph Hellwig wrote:
> Hi all,
> 
> the XOR library used for the RAID5 parity is a bit of a mess right now.
> The main file sits in crypto/ despite not being cryptography and not
> using the crypto API, with the generic implementations sitting in
> include/asm-generic and the arch implementations sitting in an asm/
> header in theory.  The latter doesn't work for many cases, so
> architectures often build the code directly into the core kernel, or
> create another module for the architecture code.
> 
> Changes this to a single module in lib/ that also contains the
> architecture optimizations, similar to the library work Eric Biggers
> has done for the CRC and crypto libraries later.  After that it changes
> to better calling conventions that allow for smarter architecture
> implementations (although none is contained here yet), and uses
> static_call to avoid indirection function call overhead.
> 
> A git tree is also available here:
> 
>     git://git.infradead.org/users/hch/misc.git xor-improvements
> 
> Gitweb:
> 
>     https://git.infradead.org/?p=users/hch/misc.git;a=shortlog;h=refs/heads/xor-improvements

This generally looks good, but yes, please check the comments from
https://sashiko.dev/#/patchset/20260324062211.3216301-1-hch@lst.de, as
Andrew mentioned.

The bug where the test generates length 0 is definitely real.  I
verified it causes the test to crash on some platforms.

raid_run_ops() calling xor_gen() (indirectly) with preemption disabled
looks real as well, though I haven't tested it.  If preemption is indeed
not the right thing to check, then I guess (following up from
https://lore.kernel.org/linux-crypto/20260303195517.GC2846@sol/) it
would need to be something like:

    WARN_ON_ONCE(!in_task() || irqs_disabled() || softirq_count() != 0);

Ugly, but we're running out of options.

(This sort of thing is why the functions in lib/crypto/ and lib/crc/ are
just supported in all contexts instead.  If FPU/vector/SIMD registers
cannot be used in the current context, then a scalar fallback is used.)

- Eric

