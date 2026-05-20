Return-Path: <linuxppc-dev+bounces-21209-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A2BDCD4F5E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 May 2026 06:47:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gL2CS233Sz2yR5;
	Wed, 20 May 2026 16:47:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1031"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779259636;
	cv=none; b=IEfIqn8eTvptWHg8D/JIy8+3Sm/sJ2grtspLwoDlfMECrNVj25AAwbQM/jABReV8vsV0aeEiMjcejNthZvD2UBOm7wAedYetUPs6d/wYGXs+Utq2W4XoQZfuaw1DivPeZGeSVijr8tJilLvMPX6D/Sp8d//kuzwHAmQcHUm1Isd2qKu5LVmTpOXX0u8OH4NTiD5nkdDYCvOqMdvVLpF7duo4fG7QLuW1748CNUF5get/rYlzWTGv4h0lSRNgvq+0odqj/7K7Wxn9J6Y8/aZRHVUIuzISa5WVXaJiz8NR+oLG8ZDKWZ9xy+gG5uNNczpZeSzj/ktgqsuGiJuA+Xk8uw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779259636; c=relaxed/relaxed;
	bh=gwRmNG2JwhRhCrdTLWtC2EcRcfoo02ZJ1Bao6+rpdQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iqcxgsejb/ihSnK+wOFywl9xxmXvTiGlEfe0kUMpoRoZk9nA6/A01PxpfsFJ0chdCs7SUVb0htM77gStkIn1lqYsTxsblYgv4FIJ+MhOG9AjEYvESpIbRiQBYml42oCF01ML8pJVXvTZSPK5GHceAD9dT2/Xflsdi+tGwiNnGoc+v+xqVqnryJeI04oeQuXG9+rXLv+NBPIYxQxuktYiOTDULtv4HGmQpr2R9PhbDaohfSf3Jcgu3dWrr6W15QqYQFdpxb5euLi1a1P1D2NdJewIcKXNm4cX7dOwQH19/KPn+fshYWVvegKa3re8XSNEWVxE3vfD20wX6YWaDhstdA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gVQqIXgp; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gVQqIXgp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gL2CR4qlLz2xPL
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2026 16:47:15 +1000 (AEST)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-3660daea6a5so2364885a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2026 23:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779259634; x=1779864434; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gwRmNG2JwhRhCrdTLWtC2EcRcfoo02ZJ1Bao6+rpdQ0=;
        b=gVQqIXgplHoV4yPalVjujkVgixX4foZw6nbFJQZS0KBkhGvSSQn0GW/T8Q5xO5w8xl
         FUhX+wnpoPuC+krPbOXZSSN+2rvzHOID1ScyDTNUmXikOSDqLJWi8SVRziPIw6LdWIaR
         KXEJIrkHM0V/1YR6+HxLw5jbyKwV4+KN61Eq2QMNkKQtC+AsLcOPPAbifT7HtOpx6oDP
         tSw7Pr+NWZgb5//U5zJhtsxRozon18mTRx91u7uGDXnGPxIltPGoxfw+J+2ng4BWb0SK
         YC25brLJR6lMM+vInASidqqyHLCS1cywYhE6Wfi7HFiduZnEyT+xyvB3jhFO9dEp0S0c
         usOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779259634; x=1779864434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gwRmNG2JwhRhCrdTLWtC2EcRcfoo02ZJ1Bao6+rpdQ0=;
        b=qxsaTQejRREHNpZ1Uey08SngVgqS+1RSBITM+9reS/Rk5SBRAtpci02VniBuG74y96
         WLRq4hUfrkr7GN88DsbYH3drecvC56sTPc6giXSsN20DMUoWdJlMxJln9Fm4Q+F1YCZR
         DPdb119NnUKEnn3cTiwANGJs3IuwGq4YK4+5AqJu8kkygqhIo3QGbumeahaFyMBPIX+Q
         9FwwyQ6MuwxsXF0ZKiB3kveWMkIOXhy+JzEhNU93lz17qWtnN0xj9yHj0ahSYU3MCLEC
         ti46Q3V4Prrn3nWJTY/XtI5pEOyHur1OrsTRWi93AcI+k2VbQrMY01KnETGholJxjt58
         h8OQ==
X-Forwarded-Encrypted: i=1; AFNElJ8KypCFQ3/dia0aFIs9yHc8vlBMF0UvHe37Iqjpsv9XEwut0niylmfHgxghTWlIxJRzIvPdEl1OV0WiXIs=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxNDy2QSoE136xeZQPe9JjyMhxErxOoaz7p6SzVGQZL5hwD4Nw0
	Wh9SoVX6jHpxsEN/4q2+LKD3T3pwQxlyC4JS6rhaKas4uv8U/JtUJeYl
X-Gm-Gg: Acq92OFeWp7GMGyzRZhePYieQPGCuRwCXIKTH5+9NrQPy6Vpz9D3Oaq0cROhM49kmHY
	ICCmLSuMzHGD+LKjYF5DLIIkjTTZq5o7a5+JkOi46JDRPNa3b23hY9LkE7UL6fI1lZtkZ/vPKjb
	xIkoE1zxIkU6DYjlCRBF/tJXJSKkBYPWhNLeW8GwH2xYklyFhRbei5vOd83UnKJVjOtlF3pLc5I
	Im7v4iPevMmOWiWCXqrLIGricEx9GmmN0W/hAyslYsMWtOr8cUQBr04DsTvg+nKHl9NiZCdlzMi
	wn4Bbgj60To0JgjpdBb/VydDLIkSfoY9fLOoPF+SxGJto06hhzRNpB2QfCLVH9RTBsIX3lAm1Ov
	VoGQKDm6bT6+Pg4aP82erS36l6WqIEaIeKU06JtkOpsmnG78Gus+SnrG2xOKc5NBOhsmwoCQeoS
	ip8AkFiX0Fs/fU0deonBhdpUnvvExH94k3xl5vOAQ+fZ7ozYo50j1RqpaGC3RUR5IC9JiVGuL7O
	M5N3YKvpelNX2g=
X-Received: by 2002:a17:90b:4a03:b0:369:7003:4e30 with SMTP id 98e67ed59e1d1-36970035860mr17374050a91.15.1779259633583;
        Tue, 19 May 2026 23:47:13 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com.com ([106.51.160.236])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3695a0e93e0sm6069970a91.10.2026.05.19.23.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 23:47:13 -0700 (PDT)
From: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
To: maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	peterz@infradead.org,
	jpoimboe@kernel.org,
	jbaron@akamai.com,
	aliceryhl@google.com,
	rostedt@goodmis.org,
	ardb@kernel.org,
	ojeda@kernel.org,
	boqun@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	tmgross@umich.edu,
	dakr@kernel.org,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	morbo@google.com,
	justinstitt@google.com,
	daniel.almeida@collabora.com,
	acourbot@nvidia.com,
	fujita.tomonori@gmail.com,
	gregkh@linuxfoundation.org,
	prafulrai522@gmail.com,
	tamird@kernel.org,
	kees@kernel.org,
	mkchauras@gmail.com,
	lyude@redhat.com,
	airlied@gmail.com,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	llvm@lists.linux.dev
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH V16 2/7] dma-resv: Fix undefined symbol when CONFIG_DMA_SHARED_BUFFER is disabled
Date: Wed, 20 May 2026 12:16:24 +0530
Message-ID: <20260520064630.1785283-3-mkchauras@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520064630.1785283-1-mkchauras@gmail.com>
References: <20260520064630.1785283-1-mkchauras@gmail.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When building with LLVM=1 for architectures like powerpc where
CONFIG_DMA_SHARED_BUFFER is not enabled, the build fails with:

  ld.lld: error: undefined symbol: dma_resv_reset_max_fences
  >>> referenced by helpers.c
  >>>               rust/helpers/helpers.o:(rust_helper_dma_resv_unlock)

The issue occurs because:
1. CONFIG_DEBUG_MUTEXES=y is enabled
2. CONFIG_DMA_SHARED_BUFFER is not enabled
3. dma_resv_reset_max_fences() is declared in the header when
   CONFIG_DEBUG_MUTEXES is set
4. But the function is only compiled in drivers/dma-buf/dma-resv.c,
   which is only built when CONFIG_DMA_SHARED_BUFFER is enabled
5. Rust helpers call dma_resv_unlock() which calls
   dma_resv_reset_max_fences(), causing an undefined symbol

Fix this by compiling `dma-resv.c` file only when CONFIG_DMA_SHARED_BUFFER
is enabled.

Fixes: 9b836641d3bf ("rust: helpers: Add bindings/wrappers for dma_resv_lock")
Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
---
 rust/helpers/helpers.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 625921e27dfb..09ee5cac600d 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -57,7 +57,9 @@
 #include "cred.c"
 #include "device.c"
 #include "dma.c"
+#ifdef CONFIG_DMA_SHARED_BUFFER
 #include "dma-resv.c"
+#endif
 #include "drm.c"
 #include "err.c"
 #include "irq.c"
-- 
2.54.0


