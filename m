Return-Path: <linuxppc-dev+bounces-29487-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E17DECC6B1D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Oct 2026 15:27:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j4ZnW2gbrz2ynZ;
	Thu, 15 Oct 2026 02:27:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791991631;
	cv=none; b=doANBfPzB/LTOughX+bwpA+CU+/lYLG/cPt4Ypg0Rqrw5Sysalg+AXV+Gq1lRJLsIiitefAT3/iCs5L0wdhhGo7tETI2SoMNNv0YqFutBBi5WCePFv7APkXK58Gj9botoqOez9cdYbfOm0QthU7WBuurZmM525Zm0yC/AU6f5kyNkePKucxO5eBdMXmEvwE78oKZQeomAh2Mhr2RElZ7vjfydfdvGl9+USW0I6smj9VeBOpB3ysGYsM3Wn21+z3bkFqscrscaFTPTcNwS6hLS5a8/DNpQOIUVITLjp4prZ0elfthrCLk7TlfSmeTYshJn7FSoh1A5340kRNrtVtrTA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791991631; c=relaxed/relaxed;
	bh=Jhe7eZQZFQgn9dtfO2FFpyi1BEJY38i0MQYvqTHTFpM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TyC3mXdFObAg7SoXVb/7NMIlnEBHdC7kpD9fyQB98ckjiLaOohuBnyfESNwbgettZThaYBr0d37lDqQwWMrJRZyT6rWXhzeUfSaM2kIFASQO53RPO3/24loRutc2jg7R6Hf3JzaviiycbIYs5cK5ar0grM+R7wf0FcXRnghjAqKqO5OP9zHrKvrzfmKFUFQiFqBjW7zap/7SlsJzF/k+MiivCB8ChHJNv3GcTiJmDkvqRGYql+bCgyi9PFfKGWRWGLyudPsVHXjzrSRXVVPKKNt+BCihlh4c6wN4n09iG2zvaTlUvg1RzxuqCfHbfsrTyvcQqwnx6BYKNDmhVHzOow==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XgD0sNsB; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XgD0sNsB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j4ZnV58rJz2yWy
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2026 02:27:10 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D4B5C40872;
	Wed, 14 Oct 2026 15:27:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CC461F000C4;
	Wed, 14 Oct 2026 15:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791991627;
	bh=Jhe7eZQZFQgn9dtfO2FFpyi1BEJY38i0MQYvqTHTFpM=;
	h=From:To:Cc:Subject:Date;
	b=XgD0sNsBZjV98IVJzmM5dernI5JLraTdtY6aqVoS4XjK6yi1Sls31aGGcm8bvbrDJ
	 zhtIuFug7MsdhvlKV5N4frCM6GYy6Iut0R/6HaOgu+MROsbuXihmnjYBOdjcetSjDi
	 0WR/+ssn4lA2G/VgsBIZHOI+lDc1KTXvSrUzu2R1ShvDApL7ZO/8bZaTAfFriu2hBs
	 5/6C/jtucS6dxBVCYjdj+iz97xqYfbzO7a+1khrZgUMCtg+UJfCjNNJM1QT8VPXYuj
	 MgOeyZeog+X4Yyxdz/pd1uSNmqgClKx2aR/e7j1OhxbW+hpkIpgpO6wSGvr/Im6Vsc
	 fx9wyurc92Rbg==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-arm-kernel@lists.infradead.org,
	x86@kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-mips@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Vladimir Kukharenko <vladimir@genproof.com>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 0/2] lib/crypto: Use size_t lengths for Poly1305 and ChaCha
Date: Wed, 14 Oct 2026 17:26:02 +0200
Message-ID: <20261014152604.323310-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.56.0
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
Content-Transfer-Encoding: 8bit

This series upgrades the Poly1305 and ChaCha functions to use size_t
lengths, matching the rest of the crypto library.

It also fixes the (not currently reached) handling of lengths above
S32_MAX bytes, and (not currently known to matter in practice) the
assembly functions depending on unspecified high register bits.

This more comprehensively addresses the issues identified in
https://lore.kernel.org/r/20261012-libcrypto-4gib-lengths-v1-0-ea566c129a2e@genproof.com

This series is targeting libcrypto-next.

Eric Biggers (2):
  lib/crypto: poly1305: Use size_t length
  lib/crypto: chacha: Use size_t length

 include/crypto/chacha.h                |  6 ++--
 include/crypto/internal/poly1305.h     |  4 +--
 include/crypto/poly1305.h              |  4 +--
 lib/crypto/arm/chacha-scalar-core.S    |  2 +-
 lib/crypto/arm/chacha.h                | 14 ++++-----
 lib/crypto/arm/poly1305.h              |  8 +++---
 lib/crypto/arm64/chacha.h              | 10 +++----
 lib/crypto/arm64/poly1305.h            |  6 ++--
 lib/crypto/chacha.c                    |  8 +++---
 lib/crypto/mips/chacha.h               |  5 ++--
 lib/crypto/mips/poly1305.h             |  2 +-
 lib/crypto/poly1305-donna32.c          |  2 +-
 lib/crypto/poly1305-donna64.c          |  2 +-
 lib/crypto/poly1305.c                  | 10 +++----
 lib/crypto/powerpc/chacha-p10le-8x.S   |  2 +-
 lib/crypto/powerpc/chacha.h            | 10 +++----
 lib/crypto/powerpc/poly1305-p10le_64.S | 23 ++++++++-------
 lib/crypto/powerpc/poly1305.h          |  8 ++++--
 lib/crypto/riscv/chacha.h              |  6 ++--
 lib/crypto/riscv/poly1305.h            |  2 +-
 lib/crypto/s390/chacha.h               |  2 +-
 lib/crypto/x86/chacha.h                | 40 +++++++++++++-------------
 lib/crypto/x86/poly1305.h              |  4 +--
 23 files changed, 91 insertions(+), 89 deletions(-)


base-commit: 40f47fa10a1d19c74f48a13d97b2eb19d5fb938d
-- 
2.56.0


