Return-Path: <linuxppc-dev+bounces-20656-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B580CD3447
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 May 2026 18:41:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gCZb95HHtz2xqn;
	Sun, 10 May 2026 04:41:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778352117;
	cv=none; b=I5Zze7OnbLeLUz0CPMhSyifkdiSxH8EruhThH7GPVISMsSiMkQDvQgNwn29nudMPfbkOQrJyh8RdHHMxhOraAFRY9Dh7dRenNaGjqXUGKgfNwLDglj+HvVPlfCA/V1Hn21NYrsPSfEq4d87x2OCIhTb58ilPl6cnJDBKeiqkRyc1cTY8FQiPAQ3UBUjzJDWwL1h4rHpNVFSGSFZEo6rkDYTGjCTHJXAyL7DrKTuUkeAo0ZBvjwZhlAb0d9wbf01voHJUl/lcquS85Q6YMdwgUHjYZaa2Hq3R+Sbi+JZChUsLmUmgJ3ac0A3yHkv7wCFzBmVCshURbNHzA2MsigV73Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778352117; c=relaxed/relaxed;
	bh=WIJ7DfX2k5CGN/qSIl1neCY6LQqrVaz5gRLgzGYqVZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LYYxZKY5H++pw7GIJvlEpgWM4PBIph++XbqAcDxDfM6M+ZH1COrTPCH2X5jJf0sJ4RPcvRGVRNZgkkIl6rQ0mlDrDwE+HefvwoN/8Ws6BTZKICzOEbuTTeumd9KSsILkI3+gxo8yx2mcn4UaHleLjrylXraC4OvD9EEBXHv8h1A2y9UVyKeZug3AUnIzq6f52pLXp6PFCsLYoR1XD8VQBVtBvCL4ZnAnf3QKyyxg/NtUKqkNKiJ0p9KkFnJvn/gUBxu5RHPMFC94+l/wiTrmFiHrYat3cVUZL1UvZE146tI7auDB6qswlDvlD0vojDYuEKLcJEAZeBkuOhvNXIIpnw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=AyJ5rWZI; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=AyJ5rWZI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gCZb833qpz2x9N
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 May 2026 04:41:56 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 2315F6024D;
	Sat,  9 May 2026 18:41:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 626DCC2BCB2;
	Sat,  9 May 2026 18:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778352112;
	bh=5x6vMZJIgP2JV5U0sf4/3UHVPYatudGhzTthPLFbE1o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AyJ5rWZIJlvuab7tohPZ8gd7mvCmDxDNq/R998ABZKL2siI3NOIG5fVudgG+OtgJY
	 hNTUVyvIvpVN/IQQdxRB0+xP/TMJRVoi4EUtUA9zmVEOnLlC+vDDBS5mNaY7+I/dwr
	 hznqQ4FgC5RYcm8MWrDvOtf/Pkv/CkE/xcb+X86Cdtdz9lUKt4BxTT5TVtiwSMORdC
	 ICxc/QlGkB2kaXTTOyXicZiiO/mwafgH6knNICANk6kNsvg+SIaNU+HmB0pF1Ii/hd
	 e1njZm9xgEXduDH3ASCwWoCuo+GNQ7ZjjCl57klRJMYkkNb3TMaHVz2azJGCgvPWl9
	 6IvHRup/FfYXQ==
Date: Sat, 9 May 2026 11:41:44 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linuxppc-dev@lists.ozlabs.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>
Subject: Re: [PATCH v2] lib/crypto: powerpc/md5: Drop powerpc optimized MD5
 code
Message-ID: <20260509184144.GB11883@quark>
References: <20260506030005.9698-1-ebiggers@kernel.org>
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
In-Reply-To: <20260506030005.9698-1-ebiggers@kernel.org>

On Tue, May 05, 2026 at 08:00:05PM -0700, Eric Biggers wrote:
> MD5 is obsolete, is vulnerable to collision attacks, and is being
> replaced by SHA-256 in new systems.  It doesn't make sense to continue
> to maintain architecture-optimized implementations of MD5.  Effort
> should be spent on modern algorithms.
> 
> Indeed, architecture-optimized MD5 code remains only for powerpc.  It
> was already removed from mips and sparc, and it never existed for any
> other architecture (e.g. x86, arm, or arm64) in the first place.
> Earlier the decision was made to keep the powerpc MD5 code for a while
> anyway because of someone using it via AF_ALG via libkcapi-hasher
> (https://lore.kernel.org/r/f0d771d5-ed70-444c-957a-ad4c16f6c115@csgroup.eu/)
> 
> However, with AF_ALG itself now being on its way out due to its
> continuous stream of security vulnerabilities
> (https://lore.kernel.org/r/20260430011544.31823-1-ebiggers@kernel.org/),
> it's also time to be a bit more forceful with nudging people towards
> userspace crypto code.  It's always been the better solution anyway, and
> it's much more efficient if properly optimized code is used.
> 
> Note that the md5-asm.S file contains no privileged instructions and
> could be run in userspace just fine.
> 
> Thus, we now have two factors going against keeping the powerpc MD5
> code.  Different people might weigh these two factors differently, but I
> think the two of them together make the removal the clear choice.
> 
> Let's remove it.
> 
> Acked-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
> Acked-by: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---
> 
> This patch is intended to be taken via libcrypto-next

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git/log/?h=libcrypto-next

- Eric

