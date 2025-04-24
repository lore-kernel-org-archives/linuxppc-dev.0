Return-Path: <linuxppc-dev+bounces-7944-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3C12C369CB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Apr 2025 00:23:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZjcBZ2pbKz30DR;
	Thu, 24 Apr 2025 10:23:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=147.75.193.91
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1745454182;
	cv=none; b=Uaq2tykue5wlor5trmzBnAZY4TQt2d4bggrICFvjVT/XLMEZDxNqt38kUbKbAJN71UdesD6ec8bFpWX/+GCNwdTeg8AXgxKshvA5Cvg0hG9s4097pSZPVmWTCw3R+1BAMHXIyo6inkyUpPIKNqiDoN/3NNzBwzvhYXXf3SNVQeIlRfyACIFNUtGJUKh5yhBuHO9DDYcnq6RRsG+7LYSjBILAlLrICGVVx4KvvWFpTdFe85tb9e0SK1Jov8GWne1T3BSHu7zBRGl2RjJ6TMBdV1Q7mdO3AeMHBJGbtLnACCEKv4sp+KPqbr61+EPKwXzppLN9TWQJ5RNoS/KlA9AdEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1745454182; c=relaxed/relaxed;
	bh=c4J2GUF2aL6ECJo0xVejy3pQfVI0BLjamnEzkKHY5js=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IX2oY5ABx36s5+i6qUfoq9YZ0bPeR7d/AWJ8NT/scxCgDisyq4Px3vULlN5Jp1okFzrYcB+FVwom9ATW3vVHJSskPpGxQAd6YIpWQ4YISrzNPXj/MJvVnpJ5WBsPvjzRI2RHvf54hR6HkrrDXF49Uq0BnEh1nQhBikyBmB4wmj4PdngPxx71SrLvzaRrmeyHjEnGeCzbyOWrtcdmWKL4Ehmw/qo4iy7FDqfYeBVF6NtWXHRg1oM5Sd3GKRteFKKWbHGJuCHyvx3d5J8tEfQoIpN5MGxcA4BJsgwSRkwU57kQdSkq3tKTn6aJf0rCYCce1bIOJ/Ug8AesLnILCanKQg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=meb78kAZ; dkim-atps=neutral; spf=pass (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=meb78kAZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZjcBY0pg3z2yVV
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2025 10:23:00 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 8C44BA4BCAE;
	Thu, 24 Apr 2025 00:17:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CF59C4CEE3;
	Thu, 24 Apr 2025 00:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745454178;
	bh=Up5/ryL8wH2Q6sqbHVYBM9bv82MTpfPmfOyPPhXlSTU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=meb78kAZg/xXyofHK642o1nJilPUui1hWwQEiQcEAZp40YHq2X+2iFfOzuUmsuRi9
	 /3ffaGxEzDvJ+4CHOJL+uBQ6odaBfJuVxNhw+2MXAr0Jao1aTTVF7+CDM6Gu3kNc07
	 vdQ9diSFeZab1xfjE/0X2hR44LA7XGtyI1qsuafq+uRffibBIzSfwGVpBw5TVJuua4
	 QgDLXyUF11mB8KnDES3NoRHYmKLy5TeQMZ0GiXqGkPLwGhx+ngG1whg8WzeDDc1h8e
	 f0SpLtEG+ndGMrAYamUBqpo63QNSFe8fTHJQErtouHSb8QV8aPD+YkoTsNTHdQ52uw
	 CRjoZgSmWkOWQ==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
	linux-crypto@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH 3/7] powerpc/crc: drop "glue" from filenames
Date: Wed, 23 Apr 2025 17:20:34 -0700
Message-ID: <20250424002038.179114-4-ebiggers@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250424002038.179114-1-ebiggers@kernel.org>
References: <20250424002038.179114-1-ebiggers@kernel.org>
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

From: Eric Biggers <ebiggers@google.com>

The use of the term "glue" in filenames is a Crypto API-ism that rarely
shows up elsewhere in lib/ or arch/*/lib/.  I think adopting it there
was a mistake.  The library just uses standard functions, so the amount
of code that could be considered "glue" is quite small.  And while often
the C functions just wrap the assembly functions, there are also cases
like crc32c_arch() in arch/x86/lib/crc32-glue.c that blur the line by
in-lining the actual implementation into the C function.  That's not
"glue code", but rather the actual code.

Therefore, let's drop "glue" from the filenames and instead use e.g.
crc32.c instead of crc32-glue.c.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/powerpc/lib/Makefile                            | 4 ++--
 arch/powerpc/lib/{crc-t10dif-glue.c => crc-t10dif.c} | 0
 arch/powerpc/lib/{crc32-glue.c => crc32.c}           | 0
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename arch/powerpc/lib/{crc-t10dif-glue.c => crc-t10dif.c} (100%)
 rename arch/powerpc/lib/{crc32-glue.c => crc32.c} (100%)

diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index dd8a4b52a0ccb..27f8a01438603 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -77,11 +77,11 @@ obj-$(CONFIG_ALTIVEC)	+= xor_vmx.o xor_vmx_glue.o
 CFLAGS_xor_vmx.o += -mhard-float -maltivec $(call cc-option,-mabi=altivec)
 # Enable <altivec.h>
 CFLAGS_xor_vmx.o += -isystem $(shell $(CC) -print-file-name=include)
 
 obj-$(CONFIG_CRC32_ARCH) += crc32-powerpc.o
-crc32-powerpc-y := crc32-glue.o crc32c-vpmsum_asm.o
+crc32-powerpc-y := crc32.o crc32c-vpmsum_asm.o
 
 obj-$(CONFIG_CRC_T10DIF_ARCH) += crc-t10dif-powerpc.o
-crc-t10dif-powerpc-y := crc-t10dif-glue.o crct10dif-vpmsum_asm.o
+crc-t10dif-powerpc-y := crc-t10dif.o crct10dif-vpmsum_asm.o
 
 obj-$(CONFIG_PPC64) += $(obj64-y)
diff --git a/arch/powerpc/lib/crc-t10dif-glue.c b/arch/powerpc/lib/crc-t10dif.c
similarity index 100%
rename from arch/powerpc/lib/crc-t10dif-glue.c
rename to arch/powerpc/lib/crc-t10dif.c
diff --git a/arch/powerpc/lib/crc32-glue.c b/arch/powerpc/lib/crc32.c
similarity index 100%
rename from arch/powerpc/lib/crc32-glue.c
rename to arch/powerpc/lib/crc32.c
-- 
2.49.0


