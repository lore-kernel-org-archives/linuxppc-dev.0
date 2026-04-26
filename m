Return-Path: <linuxppc-dev+bounces-20123-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 569FDFF885C
	for <linuxppc-dev@archiver.kernel.org>; Sun, 26 Apr 2026 11:00:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g3NyW06jRz2yjm;
	Sun, 26 Apr 2026 21:00:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777201218;
	cv=none; b=JVrgl32H+PPp/o1cGYM49MRfi+RCrAriheb12zKQce8AHGgjEqUEcIVnBQRslUit1z8K1vEPbQXfG0Ui20tlxapNJT6ehuo2qAiVRahWZLkN0EwC4aLFnIzGca3LYasUiRXqMFCgwKh6G85PkU5F16Z8gDEUC+nKUhr3kV6CgAgTjoG0uC29GZhZh36cCxLz1O+Mh8EL0u27bmpgZTvFo49n5o7fiiNqHdBBcVoNntWbzp0MIev0hUaTgfNRXtHpMI5I2wUrBSuw9NNBNGGvZoPwFDhyE8XrVjUctXaIFOrBRAFpCVoeaMdOW33OaPpBfwK1oWLB5HbSsNGhcs7vkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777201218; c=relaxed/relaxed;
	bh=3XNHcqPiS87Phn06IpxO8T5jrJVeHx6CGab+nQaKnDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NQh1RXCEpgKV7VrFXeuLR4MSnAL25j+1kV9Dgd7rklpbQIAEnSRGsu8mWQtIBWfUq+JlPEpEKHqYV9uu4NXV44mSAsEn+i7QDWpGWanmIX06GbaJxbXuRnZqE6sHg5A3UFl3EBZ4mgNmy5AU93wpKdsdQl0mgF/fAKlUDaDebnb8OP+qxOw6dBkl18/gJf43tQJhvvqkAIml0e8XOWBmCLUH9ePRXMYfFgq0jTVe775kbQ4KgD5XD00L/q2nA4Bq/xObv8ebk1fFqCwi2HyXPLdWTAfgqHfeOr0syKnay/RCuYktmo+1FW8ExFNonkYnIy/YBvwglvvneFZkYgdBaA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Zpk5sER5; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52f; helo=mail-pg1-x52f.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Zpk5sER5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52f; helo=mail-pg1-x52f.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g3NyV2Kw9z2ygY
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Apr 2026 21:00:18 +1000 (AEST)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-c797d5ad36bso2977224a12.2
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Apr 2026 04:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777201216; x=1777806016; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3XNHcqPiS87Phn06IpxO8T5jrJVeHx6CGab+nQaKnDs=;
        b=Zpk5sER5WLzL1UXC9TvxIRsmQ1E0/UeRWfx99ha7v0KvBeGZ4QFn8mXTwYPMTDH96L
         PlRLd30l6uTekT7CVll06LQQEhzCMWt1e2j+up+XXHbwyAjcwVRpLVNF/6qWIJvyf786
         o9JX8IWzbnuZtO71/42vfDXTC6c+G1OaR6GbNF36fHXnJGfbjKXHUUFtqvCbPZAjrKyA
         AsIQsIzpJxPlRQr+gc05YutF11eErmIee+FSQWiNxv4DzmaAey52W4Lkmo9HRM+lDveB
         pnNf/mLCr9p9l40wkHhEd8KvjjI62+sKAkt/ElNmX0Z3WGVdqIF6p17KpTKyAUYkZxTU
         ebXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777201216; x=1777806016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3XNHcqPiS87Phn06IpxO8T5jrJVeHx6CGab+nQaKnDs=;
        b=d7CqGHS+iYFvPUECiNnissgzir65GBiOHpzAIWvsCOg8expe9eE+cWQ4VxwkdPsiH6
         Os6/HHqyVqdWWhaHp6vu1hAWFrjYHx3KyjZfpGF7ZNDgWLKtaRI55jWIcScPRQzwMD0N
         +ecuP1ihH0a9EY76Zq7iVUBKRuqaz2Z5SkZ4F+GtCc2lik22FBbxEC1TldIDlfY8jbIN
         lS4IOds7jbYbbbz+GvOdoFqrymk1eem7hvkKxZtOqxxp8Y6U6pzatCLHa10bL6Km6wWI
         L2YDjCGNN4ZCdHQTUgE17F5CkfWfrWAVEaW7+nw8ShVvMqP14twIN6lDHUGRyTTpoXCQ
         Oang==
X-Forwarded-Encrypted: i=1; AFNElJ8ZZWI2TFamATqhAKaXVoeQShWG1AGxUE0/l3cYaq0JuaHQwd07f9NPrq80LosYzvvbEzPBwODMJHHAKUY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzAVZ8ie89xiGvRhCElAv5cV+CWDi/3pHrPo0higIQ73jVpKmA+
	q15lhlQEzCp0/vVfcnbtgo8v7n/8dryeIAa05sw0W6NabVQ4tqFe/SR/
X-Gm-Gg: AeBDievSgNINYnBU90yxsueQ6eAEEtsgxEnzwoSFU13x5v1A3sidL8zJ2jlosaRI/2L
	1Swfku7NvSmliKHf3dHxCPSdhRcs0/xl/oHBBuSY+reHQWPN5IBlRTXxo+9ZO2I1QMBl4i11n6S
	5eIya63L/59CTsc6tykB3QBtM8WmgDrKCMIWHVR9ytHVb2aCI5+5WZ9MhN6m77w8T7LrczvFs+N
	IG7xmEUJrZLNfuKrWJKvf4kdIH+fQ9NmtI0QfPnVj2uoHEQF2z1rxmp09OfPUiOG9MBBb6HEZ9B
	LRoRkEFP9gdJdHwuvQL/Vv50INncq++su57C96vkh0be1PzHciD2oETnfMovRUrONW+Z/7hTGsU
	5tMmacHqgqjeanohf/v6CT61sa5gnBsIgRYe8DcegJGqKjNZnX0JBXkZVwtB4gWXQpQ/n5tQYSK
	Y9AppVPPFAk8m5rKtBTRyX+vT0iPyRzCkZwdEgNqWZPiwnKswZxvx4WKZPqfhlLHdDgMQxYyMoN
	Q2HbTwrUPCIgAY=
X-Received: by 2002:a17:903:2acc:b0:2b2:497e:3f6d with SMTP id d9443c01a7336-2b5f9e8cdb3mr378037025ad.8.1777201214089;
        Sun, 26 Apr 2026 04:00:14 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com.com ([106.51.164.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5faa2f129sm256667235ad.29.2026.04.26.04.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 04:00:13 -0700 (PDT)
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
	mark.rutland@arm.com,
	mkchauras@gmail.com,
	lyude@redhat.com,
	lina+kernel@asahilina.net,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	llvm@lists.linux.dev
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH V15 2/7] dma-resv: Fix undefined symbol when CONFIG_DMA_SHARED_BUFFER is disabled
Date: Sun, 26 Apr 2026 16:29:27 +0530
Message-ID: <20260426105932.2270364-3-mkchauras@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260426105932.2270364-1-mkchauras@gmail.com>
References: <20260426105932.2270364-1-mkchauras@gmail.com>
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


