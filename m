Return-Path: <linuxppc-dev+bounces-20107-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 246FFFF885D
	for <linuxppc-dev@archiver.kernel.org>; Sun, 26 Apr 2026 08:58:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g3LFY4pKxz2yjm;
	Sun, 26 Apr 2026 18:58:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777193889;
	cv=none; b=JCOQ/abkBbrv4pv33NL/HmE6jv6juBFAaosjyBI0XoSoHwhsZYYt9sHAe54qUJ8ec8gxjdvM895r6CX9jilU0EMf7pbV5n/0zehBd7n9zdA/d2Jx6S9maqQdCD3bRjuNpwzdZxP9sR7YjGpuzkGeGZjVmU1TF+kOZp4SrauAeY2CQ9g092A7lCRE36j94bESh21BvoFeizLXppOrMvm50BkQulztdoKrlnpTqRY/uAOutdtwWBqmp6Va54zoKUj8Ya9jsy0Krxi64YnapghmgizESqR2zB/XHrL6SlkGlG71DyEUWEwDjOgoEHl8NDVPjFm39WeMuMwyYId6ICrmbg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777193889; c=relaxed/relaxed;
	bh=3XNHcqPiS87Phn06IpxO8T5jrJVeHx6CGab+nQaKnDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TIzEGZ4VkRtN9rOn727tpUSWKUuYn/k5nGerWeWSH+j5spLEaQiz4n/PTL719vdQVDNgDdsIwbBMfAKcR0p2OrPov6LUJri4xLtFZTZP9+xL2HPAgawETd7zDz8oH1aZgeE9ZlLaNt2lQCNlu3W9lLlcguOE7p8hUz1PZ+kfYClDwK+fUsa/RdVxKeOTtdVfHHl5xKprGeaUYJc4rxYif6gLLC36uXImyoYbIN1HnuLw2rtvczA7m90nMpV5AXAIcNdQkuGbwIDhnKKP+XP2GYx5x8RbmrKdQz5pY1RM4tnP1weR6WUk+bvvuzYz1u+OzxZakuey6IGZ9vmk6MWF0A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ax1JXHpM; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ax1JXHpM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g3LFY0ZXKz2ygY
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Apr 2026 18:58:08 +1000 (AEST)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-35da2d35eccso6259988a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Apr 2026 01:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777193887; x=1777798687; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3XNHcqPiS87Phn06IpxO8T5jrJVeHx6CGab+nQaKnDs=;
        b=Ax1JXHpMZqfle8OD1gTpwYBFauSm37d1rQY6a+JqerKWalJc+8Xw1vTbGxYMNB0GYL
         fSuHWtDFCiR8f4QZK7mK8Wy5JWZSUtnumVjEC2H1KAX11aWpYUcvSNFY5anWccqo4uEC
         Ln3z4TvHtxKICPh3SeSJPRHFKS+BnBlyGNmdGjmLLHow32+xz9iIzfBo0dDIFFsUtzPa
         TxYkJai3Xbzu89RQ9jIdCxct1VXGNDnBqu0is8fbC1/HNM+FF7rHFqIic5S57FmYGjHo
         exCbeMV4c5FR2z7ei2sGQjovWq9dFVes7MlZeDWR/gHc4g3FxStC3cNo6FzAmefas8Jz
         lE4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777193887; x=1777798687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3XNHcqPiS87Phn06IpxO8T5jrJVeHx6CGab+nQaKnDs=;
        b=TfkH3b/iG2ACJxFKqHWukWfiacFTyh8/3bd5oAZiY39rEElvuqJnI75i7+96EYkyRK
         Avm1j3BRn1FZ7Lvex0z3eL3N4BQc+zKFXoL/0eFeE9SqlA+ZLZGkgGL7hwoRkuvj53zk
         h3jAlcJ82MDKAwxZht7tgSLX7Z8NN+PR3OVCDxSH0lroASL2s5kYuM+wvjG3pZ3lfFsX
         dLbqLtmt57+tSXc8fSCxkwgT9f7w38z7kVWGP41e3Qbfn2BBACH4P9ygo8tf/TIvLdre
         3WQhFvnSTHfT3izlH+SGS0FZd1yT72bqqA5U6SkR9w5cOrxhX2/yCatCflb6hYL6Au3G
         2SqA==
X-Forwarded-Encrypted: i=1; AFNElJ8Az8U1XXapPkMkItY90G9YQwg7JT6WUnw5htxBwXepiYxF3xe0Pt2yIxDzSQow+UIJBwZpLhcHnjAG2Vo=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Ywy+qGxSBE5r/cWqs6KxMEKHTvW8xFQFYjZD/ae8ECGZ+PBcpNM
	NrJe7wga23WO4wv8FagfcrRmPi5dD/LMIxjEn7XX8Ugg0yKg1iEt7kvG
X-Gm-Gg: AeBDiet30hShT3LPBw8OgAWG3SpfPokUUMIomfDZMkeu3lT0vi+DSaEV67N/tLUvycf
	31HtLcuMz/UI9D6xEppH4CvP40V/5RTWsUyiJA9w9pEUf9LctWsfJlQzGbnkbI0sf5MNR7gAH2/
	/4Bjt/NoEnNR32SQs/EFotoxRhKzwEWxnBKNudHB3jtMGC53Z8lI6ZtpRl+DSWij9koab1MkixS
	U86IPzD+s3/GpC1Y0YQk9TSw6EnTpKmsDIGB+zE1jlTNDxjdHxT7HeqyofrXY6hUt4yz839aOR7
	hAiZI3JgCCbc+IoCNS8+ShJ5g/DpisZCYvbhc5Zt5WhUJ5uAR4IGkaO+a3DmILDXvP/DnKcoaOX
	+R+R84aSKrKp/pLsPLi582ataxVkdX4p/Oqc375mtAMWJ3mLjJuRsigywY+r+q7Yoou6RbI8W75
	mUCQSFaEMLFQiwaUHLIpEE+4VLIEMvYZNqwqoFd37ma3msO8A+z5svmJ6K6SiQ9YepsKrsA3MgP
	YPrYCssRZDTTEs=
X-Received: by 2002:a17:90b:4ccf:b0:35f:b647:d973 with SMTP id 98e67ed59e1d1-36140229b13mr38654992a91.0.1777193887102;
        Sun, 26 Apr 2026 01:58:07 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com.com ([106.51.164.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36141868906sm27718937a91.3.2026.04.26.01.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 01:58:06 -0700 (PDT)
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
	fujita.tomonori@gmail.com,
	viresh.kumar@linaro.org,
	prafulrai522@gmail.com,
	gregkh@linuxfoundation.org,
	arnd@arndb.de,
	tamird@kernel.org,
	mkchauras@gmail.com,
	lyude@redhat.com,
	airlied@gmail.com,
	j@jannau.net,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	llvm@lists.linux.dev
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH V14 2/7] dma-resv: Fix undefined symbol when CONFIG_DMA_SHARED_BUFFER is disabled
Date: Sun, 26 Apr 2026 14:27:20 +0530
Message-ID: <20260426085725.2090827-3-mkchauras@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260426085725.2090827-1-mkchauras@gmail.com>
References: <20260426085725.2090827-1-mkchauras@gmail.com>
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
2.53.0


