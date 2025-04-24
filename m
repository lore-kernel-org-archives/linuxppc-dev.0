Return-Path: <linuxppc-dev+bounces-7943-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45AC3C369CB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Apr 2025 00:23:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZjcBZ297Zz305n;
	Thu, 24 Apr 2025 10:23:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:4641:c500::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1745454182;
	cv=none; b=E9gcY5KRP7nwQ8mK+WLkj3YNTbj4vala9646gpmemhjxLBvCrsMcZ9N+tSZGXHq3MY+l/azOXg4a4hj0EE3ZSkMPTPOLOM+PNBnLdVSx3LyEnHG/WJVJfOziH756njsFN9lPFdZwRdtN/tuxK8IK/USnr40ygYB6qBWrW0ViN7vcylci5J+NOP761R8xVWn6pRyu+F/AzckUxrmHNtGinMUC87doe4KYbI+eg9cB4cR1UnO+8m/NWwys0FPWiE2+C+6QaCKyeCp5dVETcUeKgWhs7Q3paz66rP7rlULSEBlnZIOtL0vST183X5BfVOhyyclrAiuPNbmBZs/x+liByQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1745454182; c=relaxed/relaxed;
	bh=9Rdm+DMFLjMvv+NguyHjkOhkHmAT248a3xbKGiCO4bU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YD5iT7whTtHv90XdqkXhpKd/LgMHdQ+w0RbP1cB1DaNyFQT/LS8NqtqlwBdqIh6dirFghP37lkPOxK1jIAFTmElhYhk6D7wD/o044UC17fNoTXwErrCqK+NzN+8qYkYcfgxD0BJ3sQg8T3OsuLuuFGESNVu0yOa9uO3fyDPmJyngTPs1TVurnh4TWtm0fg6dqc+SgI5CSorlFD2nGFHB6KjbInO07Lswi9H+m2NgK9ULh9meyAZ8MUzYSd/9WbyKvvv4j5qldrA+1hYExzj6Xoq7YINcSLF7WZvtSvDvrBHj1DdaO/coDbDmtIklduCixDkNAFQQIFlqYIx7OWOdZA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=UO/B6EN6; dkim-atps=neutral; spf=pass (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=UO/B6EN6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZjcBX4kXxz2yFQ
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2025 10:23:00 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 9979C5C062F;
	Thu, 24 Apr 2025 00:20:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E23DCC4CEE2;
	Thu, 24 Apr 2025 00:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745454177;
	bh=zkgW3SiDgnggtuRkQQ2RvOw/6rX9QtoTG8UCIHjtB6s=;
	h=From:To:Cc:Subject:Date:From;
	b=UO/B6EN63Q0MfszXeohxRiovANguNpxtJg/NNqgy8lk+bdQaa6mbu/8S4libCyQRR
	 HSIRMYpy+ZiYfoztydxN34bUyWR6KCKmB0xU7hRk8iYxvJIOIkrRWT8Zmc1uU02NsJ
	 xsBYWT37QGnF9rebc74+R/9OllnOrqij45u+GI7YlOwbQwtqkd0s2GL4hFXQmCr5GG
	 /n8N6mnXAy2GCs2mMHcQJVwFcppJhYXpQ5n4lleosLvV9DlnLFRP9uYCdskDE+QiTN
	 0YTC5KsqgM5kAzcadtPwXpGKAj+oluDbScYL38nyedfMU0m402zA/WhqIEhv3zsxYS
	 1+YvvpI7odh7g==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
	linux-crypto@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH 0/7] lib/crc: drop "glue" from filenames
Date: Wed, 23 Apr 2025 17:20:31 -0700
Message-ID: <20250424002038.179114-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.49.0
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
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes an odd naming convention that was unnecessarily
carried over from the original Crypto API code.

I'm planning to take this via the crc tree.

Eric Biggers (7):
  arm/crc: drop "glue" from filenames
  arm64/crc: drop "glue" from filenames
  powerpc/crc: drop "glue" from filenames
  powerpc/crc: rename crc32-vpmsum_core.S to crc-vpmsum-template.S
  s390/crc: drop "glue" from filenames
  sparc/crc: drop "glue" from filenames
  x86/crc: drop "glue" from filenames

 arch/arm/lib/Makefile                                       | 4 ++--
 arch/arm/lib/{crc-t10dif-glue.c => crc-t10dif.c}            | 0
 arch/arm/lib/{crc32-glue.c => crc32.c}                      | 0
 arch/arm64/lib/Makefile                                     | 4 ++--
 arch/arm64/lib/{crc-t10dif-glue.c => crc-t10dif.c}          | 0
 arch/arm64/lib/{crc32.S => crc32-core.S}                    | 0
 arch/arm64/lib/{crc32-glue.c => crc32.c}                    | 0
 arch/powerpc/lib/Makefile                                   | 4 ++--
 arch/powerpc/lib/{crc-t10dif-glue.c => crc-t10dif.c}        | 0
 .../lib/{crc32-vpmsum_core.S => crc-vpmsum-template.S}      | 0
 arch/powerpc/lib/{crc32-glue.c => crc32.c}                  | 0
 arch/powerpc/lib/crc32c-vpmsum_asm.S                        | 2 +-
 arch/powerpc/lib/crct10dif-vpmsum_asm.S                     | 2 +-
 arch/s390/lib/Makefile                                      | 2 +-
 arch/s390/lib/{crc32-glue.c => crc32.c}                     | 0
 arch/sparc/lib/Makefile                                     | 2 +-
 arch/sparc/lib/{crc32_glue.c => crc32.c}                    | 2 +-
 arch/x86/lib/Makefile                                       | 6 +++---
 arch/x86/lib/{crc-t10dif-glue.c => crc-t10dif.c}            | 0
 arch/x86/lib/{crc32-glue.c => crc32.c}                      | 0
 arch/x86/lib/{crc64-glue.c => crc64.c}                      | 0
 21 files changed, 14 insertions(+), 14 deletions(-)
 rename arch/arm/lib/{crc-t10dif-glue.c => crc-t10dif.c} (100%)
 rename arch/arm/lib/{crc32-glue.c => crc32.c} (100%)
 rename arch/arm64/lib/{crc-t10dif-glue.c => crc-t10dif.c} (100%)
 rename arch/arm64/lib/{crc32.S => crc32-core.S} (100%)
 rename arch/arm64/lib/{crc32-glue.c => crc32.c} (100%)
 rename arch/powerpc/lib/{crc-t10dif-glue.c => crc-t10dif.c} (100%)
 rename arch/powerpc/lib/{crc32-vpmsum_core.S => crc-vpmsum-template.S} (100%)
 rename arch/powerpc/lib/{crc32-glue.c => crc32.c} (100%)
 rename arch/s390/lib/{crc32-glue.c => crc32.c} (100%)
 rename arch/sparc/lib/{crc32_glue.c => crc32.c} (97%)
 rename arch/x86/lib/{crc-t10dif-glue.c => crc-t10dif.c} (100%)
 rename arch/x86/lib/{crc32-glue.c => crc32.c} (100%)
 rename arch/x86/lib/{crc64-glue.c => crc64.c} (100%)

base-commit: 1ec3d4ff5c77422927896c1f7d0ed01267ec1213
-- 
2.49.0


