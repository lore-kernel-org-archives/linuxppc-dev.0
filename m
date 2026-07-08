Return-Path: <linuxppc-dev+bounces-23784-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10A4EC43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2026 08:25:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwB4L5Hwlz307v;
	Wed, 08 Jul 2026 18:25:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783499138;
	cv=none; b=UjGwKaqky8qVG4gQl5Fiso+JlEblMYK7Ttw/AIkZcDWS94iUoDLddzc+mTwn+hCHY3NdFvuqjLEUKUilf3STbCOcs+o6cvDqVy39rCG1A8KOEitSRJf+o//2qQB2XgqqhOK/OiIlyU/UQ7TMmudO39gcWMVF9VfXMJM0+7n+95DZZr6cSRTQeB7SAsMsnOHlPXvAyZQU34feAPkXnkWBNs6dWsLbH/MpzHKOMLIVtOZbMDdc3w9iw5yQUgezjZuLqr8d42bwL0wVq+oIuDGd6KJH3BMwUHZEy3lkqweW6Y9JrzLxquGKPQc5ow3/ctxxKnIOXgwB4RWP+rQOiei1cA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783499138; c=relaxed/relaxed;
	bh=9e/NFLIY5ko2z4Ua5YIOk54c8MAKLBSvbGyu1AtkwQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dc5BfoMHUbbzq/FdgQoB+jxjB3NVsA+2xSl+YDaLi/Odd6CMbM+BticIRIxU6jsszkgj3Zh6ZP7TPF22ZlVFysf1Vm3fHgzi/H+vFQ8j4Yllbacqvq4aZ1cYzx6z0yFjoA/V//NnX23DAEsMlnX0jXvmCMJV0ubN/LbFKNFIBG+wMqRFvrmoPvtROdye/+YCBUM0VWC+48JCX3HK9s6EbUlB4nHjKokCa7K6+22k1ybd219YazTGpBccba1aSF2bObhN2jFiPoIMMoVloBxrRJlnXSihWcQNIgG0BDg260VSaaxpxxt8Dt0qGD58U9L4r9uBt2PkvQZdY8D5+FCEhQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=b15njCHM; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52d; helo=mail-pg1-x52d.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=b15njCHM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52d; helo=mail-pg1-x52d.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwB4L0t5Bz306S
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 18:25:38 +1000 (AEST)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-c88a4d79ba5so226210a12.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 01:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783499136; x=1784103936; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9e/NFLIY5ko2z4Ua5YIOk54c8MAKLBSvbGyu1AtkwQs=;
        b=b15njCHMS5pvOyCZDrvHuLRmL140g48ZOYbpFdRrC/XXfUwifSgudYc5WxjalWL7VS
         IuzwPduAdNXRZHgZ7IzRpxg8M1BWdpU8UmhB3S65v7HOcs0QOL/kHlKHrMp+gNNrtv6c
         gDiLAeskmPMSz9Tncq0mG1GobTgz50ZGPUMfjm7wKmDOEE+uxXxhY/jsAJIVJIj42f/P
         qmszgNT3G91a7pdMr9AtRDN1arOCC+JIwRZcg0fLtLKcs1Ifs49xDUiUEo3+Gj9o0db7
         +6mp7edRncmS/CYhFlD1/NWIejUGkhF7fLgi+5i6+3AbfiAWZTfuTNje2KDY5d0yie5g
         ujSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783499136; x=1784103936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9e/NFLIY5ko2z4Ua5YIOk54c8MAKLBSvbGyu1AtkwQs=;
        b=WCATypEO9+yHC1Vdf7Pv++mlcorNnIfaf6hbA2dGyg+mQNP1zmO+91w4Dr7nWUoAmu
         W4+sLtPzJJZwUBCRPy0X5XUkDiSkvAN3H8O9CMRtV9upjcQ99PxEcicK3ESky40k6jDC
         UdxT81D3DCWEZGv8ugYBk2sHV5NHMEXzBFHOrDJcTm4v/6QqpnJ+3OyN6lZhB59Gasl8
         CvLTgrpWlkgro329ScRDp0WYxjH6nA2I4HDymXXTovDIBRxbN690nZ3sSXY7VIycwAxb
         /AndzoPyGk8KM6ERFGG+LUfIthadb3wfYYCrggNca8bc2ohVEyhFVRcaO2/4NeTkm+Qz
         ezqA==
X-Forwarded-Encrypted: i=1; AHgh+RqPC+rq0LBDAoeCMskYKfhJqYCi4Z+w4qFrnyPNQVW9Awa1YXq/9bV6MAOHv1QgOtX7ICE4grES6zOn730=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxo1kNprf/334cYDVTGQuzUB4zBLlNloI+KkswVURsbq4LGtQL9
	AaJJ6OoH5QIN25iEOVND7McHSJl3z6BzIeLGpFrS+qMWcO0DgmIXtMJ0
X-Gm-Gg: AfdE7cmwCnsz2pgyDwkBbuhsR6YOf/bNoGKLN6tViAFUqaXkKrlz8KOFayPtSPrdALt
	5qQARr2USdUQyPS1N65FcXXqaFy0C54NyT1EtTjri9okJjRdcRsRm9qMiv6LJqijxBhVfB6WUde
	zjqZnGsE9HZMSbkdSNpY8naJvS65zkWETGxWMxF7SMK2ppUQjt7doQIepP2L9WkcAPsvtZU8ZKB
	A3O5ra+1Wlj591aCwpEXX4Ackae57X99rYx28vmebYFDtG3uPHiC8doEfkVYBlY+//7pGFAAF/G
	GVQgnree83LvtSQd9iwTC65UGDExcaU16KD6rUUK5CxWh2n9cceCN2kIsGXtvUiQMMHKnNLhP1s
	M2A+KrR1q4TJZTsCKVx7K5cVr6o0Ou8ce5pZ8HTekmvqerUGflRHtqGoUWpaEL/NFk+3RXclGHz
	WoqaHwuQrlTRgRfwv92DtWDyBNoKve8dGAqSLJ+s0P1lI+EWMEuhfwbDyrd1Jl/OwwhQ==
X-Received: by 2002:a05:6a21:6e8f:b0:3b4:931c:3c7c with SMTP id adf61e73a8af0-3c0bcea2f17mr1778731637.44.1783499135994;
        Wed, 08 Jul 2026 01:25:35 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com.com ([106.51.160.236])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3117462f5c7sm19975117eec.0.2026.07.08.01.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 01:25:35 -0700 (PDT)
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
	daniel.almeida@collabora.com,
	tamird@kernel.org,
	acourbot@nvidia.com,
	work@onurozkan.dev,
	nathan@kernel.org,
	ndesaulniers@google.com,
	morbo@google.com,
	justinstitt@google.com,
	fujita.tomonori@gmail.com,
	joelagnelf@nvidia.com,
	gregkh@linuxfoundation.org,
	prafulrai522@gmail.com,
	nsc@kernel.org,
	japo@linux.ibm.com,
	mkchauras@gmail.com,
	lina+kernel@asahilina.net,
	j@jannau.net,
	airlied@gmail.com,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	llvm@lists.linux.dev
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH V17 2/7] dma-resv: Fix undefined symbol when CONFIG_DMA_SHARED_BUFFER is disabled
Date: Wed,  8 Jul 2026 13:54:49 +0530
Message-ID: <20260708082454.1254320-3-mkchauras@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260708082454.1254320-1-mkchauras@gmail.com>
References: <20260708082454.1254320-1-mkchauras@gmail.com>
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
index 998e31052e66..4b90a1390ad5 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -58,7 +58,9 @@
 #include "cred.c"
 #include "device.c"
 #include "dma.c"
+#ifdef CONFIG_DMA_SHARED_BUFFER
 #include "dma-resv.c"
+#endif
 #include "drm.c"
 #include "drm_gpuvm.c"
 #include "err.c"
-- 
2.55.0


