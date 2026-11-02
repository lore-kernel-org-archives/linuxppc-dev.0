Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F37606B93A
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Nov 2026 17:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=apVTG27u
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJJxT59FPz2xdX;
	Tue, 03 Nov 2026 04:44:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793641485;
	cv=none; b=BXYiPMDwmjXNKVM8vqTpZuQ+yBwD03tJdR2t+TSZIQGDKw89iM51OCMr9nos2KgV642YDqWLxH9/JkTmjSEjk1X8YbKWlr46pD/1yGq7RFtR1ffIgkM6e+THnKujTO4kxZ+Z/sRhoP7iyVwZcuTPe8G8YjSZeRNZRDVdx5ebS5g9fXw7QN0VZZYsffp6I0PZWiF16X83rINTAMAQJDTZH5X0Oh+rFD3zKLGxb8YsWkq6MQ/gCnBeKtQGSYLIjF5U/KueZysoimgZ4ALGGxWFqaDQMsBexT5aetnn/E/qv8eMn+UI1HAk3HLPWqVy9Pxh1Bl/7etIOS5rsSO6rM3zdg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793641485; c=relaxed/relaxed;
	bh=k7UZvy0vvY5D+HhvfYF+E9EdpF9huO3k00rhqXCPC6I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MZ8m5i/Lm6Oii/UdFFrZMu37DHRWEtqWSlIgQ1feVG/Up/r2aRnN8vtMD2qgMwWlRKNV7UfHx2X7Xp1TsQfP4+crrDSQV0FF2WQUlxbx9bHQN1xSUP70hq8NPN+tooN1DQxYZ0RemsyLs0+krPNofJQhdwo8tqUaKB1fz9oq+L7859hvPUkFM9FaUX/3qs0tpIFaX3Ca54M67diEi8Tg8lmVGKMl2qvd87zKeJvNl+6MFb5eTOrPrMP20oeKuzH0S6ENcC3r6BHj3ExocLjgvf6lxu0wOECdxOrWwQzLZWzNg9mznayWpcbKjEU5i8TPfJkfOjKwIt6pYQyjTET+DQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=apVTG27u; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=apVTG27u;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJJxR6wtDz2xSS
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 04:44:43 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 8721960A66;
	Mon,  2 Nov 2026 17:44:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 051721F00A16;
	Mon,  2 Nov 2026 17:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793641480;
	bh=k7UZvy0vvY5D+HhvfYF+E9EdpF9huO3k00rhqXCPC6I=;
	h=Date:From:To:Cc:Subject;
	b=apVTG27uMskhhbZTrmLmAV9eRr9HrS1HUR5qbi9zfTEALUM2OekHVl6dM07zMhU9I
	 2IDsL3D3Oqs9Yv2+o+lKAP1ZE6sPozEY9TDuJIWdBHoVTH3ZqF8pVhQDU2pq3pBlZy
	 cso0jW6KHw63Itn0ESPx72NSLUQ5ql6Zran0/05c+3YC3O3tmvJ92NdfhlMmhxq+XS
	 rHGaMzx+AOvEqqAFoJnwodS2ALIQnpyNqN2E3u3gtmkKIkOYkg81oTsY71i6CVU176
	 WBSw2QyqukddCaWlN2qrGfIb42MZwr4tef8qcZogYwLm2+uiVsF/JNscjJKHUomu0U
	 +Kdm741227oMQ==
Date: Mon, 2 Nov 2026 09:44:28 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [GIT PULL] Crypto library fixes for v7.4-rc2
Message-ID: <20261102174428.GA1935@sol>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The following changes since commit 5b0764a53235d3c77e1ed674e836e1b3fe1a4b1f:

  Merge tag 'drm-next-2026-10-21' of https://gitlab.freedesktop.org/drm/kernel (2026-10-23 18:29:02 -1000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git tags/libcrypto-for-linus

for you to fetch changes up to 01ad209f122b7c173477bd60c7997564f9c65961:

  lib/crypto: mldsa: Add __must_check to mldsa_verify() (2026-10-29 10:12:11 -0700)

----------------------------------------------------------------

- Disable the MIPS64 Octeon optimized SHA-1, SHA-256, and SHA-512 code
  on little-endian kernels, since it doesn't work correctly on them

- Remove the PowerPC optimized Poly1305 code. It's already been marked
  as BROKEN for over a year due to not working in softirq context, but
  it turns out some of the Poly1305 math is incorrect too

- A few robustness improvements for the ML-DSA code

----------------------------------------------------------------
Eric Biggers (5):
      lib/crypto: mips: Disable Octeon SHA code on little-endian kernels
      lib/crypto: powerpc/poly1305: Remove BROKEN implementation
      lib/crypto: mldsa: Check pk_len before doing pointer arithmetic
      lib/crypto: mldsa: Explicitly check that 'alg' is a valid value
      lib/crypto: mldsa: Add __must_check to mldsa_verify()

 include/crypto/mldsa.h                 |    6 +-
 lib/crypto/Kconfig                     |   12 +-
 lib/crypto/Makefile                    |    2 -
 lib/crypto/mldsa.c                     |   15 +-
 lib/crypto/powerpc/poly1305-p10le_64.S | 1076 --------------------------------
 lib/crypto/powerpc/poly1305.h          |   76 ---
 lib/crypto/tests/mldsa_kunit.c         |    9 +
 7 files changed, 28 insertions(+), 1168 deletions(-)
 delete mode 100644 lib/crypto/powerpc/poly1305-p10le_64.S
 delete mode 100644 lib/crypto/powerpc/poly1305.h

