Return-Path: <linuxppc-dev+bounces-18081-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9F32103E2EB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Mar 2026 22:29:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fWQRK5GmGz3cD1;
	Thu, 12 Mar 2026 09:29:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773268189;
	cv=none; b=lDxW9K2e+Mel8FcGHvdWKPiC5MV5x1OoTZ9yGxGtfA1hWWbiqDu7df7F9FiOar9fH5oZxBx2DRQlL9BncuDFnJRacGSo1SnwWVdGcqxP2V29B0V0y5azqO4fmBmgiXBbmNxrCTiob+0QnOzX3796vJlqcauEkmfreJYahB4jVeXVdETKOH/k4rn4ZcPSzjbtfbiPZKOLZgidI2bJsgMbXYuTFzCSeiT8kb0xFHLKF63JPeCA0TnEwoZNuBWXjFse78TxMTQwUzZuASMnA8e8GLX+LkGY+z7l1+hSQPNAN4hR/8JQ0rTargKVPikp/P+Rnzzep3tc+NxfdPVQG7H53g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773268189; c=relaxed/relaxed;
	bh=RikSZ/qDz/BbXcsdorYocnARDwttAwV1n5wEGZVbyw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KhKOOVZp7B3TnswUrLG/9uf/0rKNVv/yht81w79DdbXElvMWYR/zOtuqgO3QipCxkRjngt6aabCQJUGSfb4eiFgriIqBw/zAz6bZ5NmUgF8SUCx3+j6bUkvtzIPu11lWnHP3wxFXDj1JVg8+ue+AfnknQPzqeRhxHY0BtiR1mkln2R5xoICGYiqo5NYGS9N5Div0FY/SJNB9vESthR84WQPOjt016QV/Wkg7yKVFOTPXlhUlAbEp1mUFbjfAcKYQXzo0pbP4QhWKeOJwGdHj9uQMm+yJWSNBQwikJkV3dDUxURnTsljnHcyW6flT6qRgD7e7Wf61wB70rnwPTG/zMA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=XVPRVNpv; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=XVPRVNpv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fWQRJ5GLtz3cCK
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2026 09:29:48 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 09C1160137;
	Wed, 11 Mar 2026 22:29:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDE76C4CEF7;
	Wed, 11 Mar 2026 22:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773268184;
	bh=FgOgwczmQ2Bn8aQ6V7k6mV2cKfvqhgutLP2bKVPQV1Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XVPRVNpvrEBCZfWDW7blZ/upwHpfW8r44adFDbQ9bqeAbE8tC29oaEaQ8vjeQ+tPU
	 mARZBZJPJk6kFf9lwAhvGI5tLCuVe7+kxaw2+PA6JC27+0GnVdnSnTLyyUBGR4Znih
	 Lefvu2tkgKCMq9MOzDesAIoaw9j5jxb0bMeShkfuCzECCfCa7va+9Rr9WWMzBI4sLU
	 yaVBgR/l4aivWBLEYBYBUfr1ZDHxJqaH8qoXXfscfY8+2H/qsRA/Z+s3gZNwp/2o4c
	 9dpn+BpceXOQVRRjDdqUqLKCA1GjUs5fm7wevN7gzXqGXlu5b/ClrM3m7JL3NeMrNJ
	 XLRZxZaMD4nlg==
Date: Wed, 11 Mar 2026 15:29:35 -0700
From: Eric Biggers <ebiggers@kernel.org>
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
	Li Nan <linan122@huawei.com>, Theodore Ts'o <tytso@mit.edu>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>, linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
	linux-crypto@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: [PATCH 26/27] random: factor out a __limit_random_u32_below
 helper
Message-ID: <20260311222935.GA3161@quark>
References: <20260311070416.972667-1-hch@lst.de>
 <20260311070416.972667-27-hch@lst.de>
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
In-Reply-To: <20260311070416.972667-27-hch@lst.de>

On Wed, Mar 11, 2026 at 08:03:58AM +0100, Christoph Hellwig wrote:
> Factor out the guts of __get_random_u32_below into a new helper,
> so that callers with their own prng state can reuse this code.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

I think I'd prefer that the test just uses the mod operation instead,
like many of the existing tests do:

    prandom_u32_state(&rng) % ceil

Yes, when ceil isn't a power of 2 the result isn't uniformly
distributed.  But that's perfectly fine for these tests, especially with
the values of ceil being used being far smaller than U32_MAX.

There's been an effort to keep the cryptographic random number generator
(drivers/char/random.c and include/linux/random.h) separate from the
non-cryptographic random number generator (lib/random32.c and
include/linux/prandom.h).  This patch feels like it's going in a
slightly wrong direction, where random.c gains a function that's used
with both cryptographic and non-cryptographic random numbers.

And if someone actually needs a fully unform distribution, then they'd
probably want cryptographic random numbers as well.

So I'm not sure the proposed combination of "fully uniform
non-cryptographic random numbers" makes much sense.

Plus the '% ceil' implementation is much easier to understand.

- Eric

