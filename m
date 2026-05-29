Return-Path: <linuxppc-dev+bounces-21728-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5F57CD6E53
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 May 2026 15:02:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gRmmd2K2Mz2ytv;
	Sat, 30 May 2026 01:02:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::34a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780066945;
	cv=none; b=EhjfbCYEaTxQYpJVXGGUOzrsa36WW90RPQezFiA0BZD+kiEYJnZXVzAKP4dvvz73jxLkAzIG8cVny4cAojO0oYoC7YeWuWEm+y4Q+A/r3lL11b0DNiyPBAv7galaNz1SlBMRD0iqbK6plA+hKhO+gNfj8cfZhgYuFzg7VxXxbi2na2TKJLtvM1IYcB5u4SqLYgla8473+US7y9CEaWdQTstDAocHGuzqnyffVgF5iVlwPYSiRv0O5rrxxnhi+GpTNSOCqHOq4i6CLe2PxT8wjLjX+WD9F7JQtWQxA0I8Lv6hu9XarWtK9hB6yzYyLioNuOtWltEg8cCFGfub1hBt5w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780066945; c=relaxed/relaxed;
	bh=ADUQ++mlFIW7e7IV4zrfNK16oe25OrryHFNLylPLx9Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=R9bLZ+PjOGBRKTEdboRgt9FZ5P43qyktmBQMBqgvWOLz4qPHgbbRZH9u15AldY19TV8Ic+F6jOY2NNTIr+m8bsEEVon8DpEXWsJzBZ/+YNvWaPHX+5GeXXIuIzrL6mSy9aJrAJOD5U3e/tD5CVffbKFb+bCJBZl2Dwyc0tpywjVvG3bl/RyL/mT3RuZNY96ekZ7rOl2rMhKXehy6wSmSO1fHOAqNX7D38LrEvrHlfzJvU3O4bEXa9gxVOgRQuYeXC7DXLG2hd0ZLKheLyRon1hWUxm+WzJTsyE8IiEgCeNIHobEg41asqo3wk9ECdEu0BhA5Gk3r9j9XC8izS4zVkw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Yxlb7iVu; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::34a; helo=mail-wm1-x34a.google.com; envelope-from=3eqozaggkdi0r8us+xzax55x2v.t532z4be66t-uvc2z9a9.5g2rs9.58x@flex--ardb.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Yxlb7iVu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--ardb.bounces.google.com (client-ip=2a00:1450:4864:20::34a; helo=mail-wm1-x34a.google.com; envelope-from=3eqozaggkdi0r8us+xzax55x2v.t532z4be66t-uvc2z9a9.5g2rs9.58x@flex--ardb.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gRmmZ59Ldz2xRs
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 May 2026 01:02:21 +1000 (AEST)
Received: by mail-wm1-x34a.google.com with SMTP id 5b1f17b1804b1-49047e9ca88so63527455e9.3
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2026 08:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780066938; x=1780671738; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ADUQ++mlFIW7e7IV4zrfNK16oe25OrryHFNLylPLx9Q=;
        b=Yxlb7iVuxdfGcD91HjBZefsvdh8UQGmIVpP9D/39yJ24q/Si7zfQ06f872q+WibC2K
         TZDn2u7cl+umEyAcsEUMUmC15070EedG9ObwH1yRV2GXgYz+JIdEZ5CP95mHbsjbAYuU
         r3dY9I3IBbHQQIGNy0eQxPJz2b4EUFwVcsWkHm4Q+db3GBEWAkJfoyCj7ppfAcwfWviV
         XqZE0ZYC/Z7Ny0CuYFV5vRY5WG1ov6nFfTEQ9oBXgeV4WhA4mt2FMG7ZfzgOJYYKRwmh
         VRMCmkfBA5Ytvayx/Nc1CE0EmzGbnU7BiDiGyZGctZnAIo0ktusg5WZOn6fFSLYHzKUF
         phxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780066938; x=1780671738;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ADUQ++mlFIW7e7IV4zrfNK16oe25OrryHFNLylPLx9Q=;
        b=GkP4USc9vcFp/Ur0otMv0BrljRwm6hUPlluv3Js3mI4vdKhXQW5l+7RxIfPi75hi8n
         5ji8Hj1diCD1SwruzkKfqd2lOhQaIujtmtVsTKOEO1r2F9y3SxsjwiwCwprOc/YPy6oz
         h9EBoWxNKmoZOyoh0f8fzhJl/iotaWHJQj1d61tb7tmtZnw0uxSljF+a3jxTjl7g6Nx6
         mGNwt4U1+5Lei5hNnQ79kgxoEFJ5Ff/pJ6GX9r5mbdWi/KO2Wb7E9k7yBXEZWdZWFvhK
         rsMkeDLgqHpESSEQuyoCI7UV0CInjn+M+C0an9PVzHpwynwIxOrEPrFQL5ErjVIAQwcs
         VMfA==
X-Forwarded-Encrypted: i=1; AFNElJ8DNf16LDDiPWXSeOMrS4XcmBa3ZkvMpu0ch1M4YGsaN0abg57OtTHG+Lsr9ImR4TdusrdOxrMD8GeDiPQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx/sUSPBDxENd2tLSO/mA1lzjmwO7LivPhYwikVi2oSUOLpWy3I
	DhF+G2Lp0BbyuypWc8X29sTx/Uh7aeZmngQgMWnC3Y3S4aTcDia72mcYK0RwvJTdIJuXHhvV5A=
	=
X-Received: from wmco20.prod.google.com ([2002:a05:600c:a314:b0:48e:9137:b54d])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:4616:b0:490:8470:31f7
 with SMTP id 5b1f17b1804b1-4909c0b0175mr35812255e9.20.1780066938306; Fri, 29
 May 2026 08:02:18 -0700 (PDT)
Date: Fri, 29 May 2026 17:01:52 +0200
In-Reply-To: <20260529150150.1670604-17-ardb+git@google.com>
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
Mime-Version: 1.0
References: <20260529150150.1670604-17-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1021; i=ardb@kernel.org;
 h=from:subject; bh=xJBQ0hvsJWcxX3OF+aBCCahIM1cYmsTmsethYm+trqI=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIUtyVcJX97Dz7W+MMlK2LNwkUx18YdWxeHbuRF3RixVzy
 2VZWh91lLIwiHExyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgIncsWH4K15aydfEzd4bZFBo
 IRJ1wOPhL4sFl+slZr0uKIyeuuzbIoZ/xqFpXiaXjdJOHT9lXb/2g8g/3TdHPNLmFe0v7lp74/s mHgA=
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529150150.1670604-18-ardb+git@google.com>
Subject: [PATCH v7 01/15] arm64: mm: Remove bogus stop condition from
 map_mem() loop
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com, 
	mark.rutland@arm.com, Ard Biesheuvel <ardb@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, 
	Liz Prucka <lizprucka@google.com>, Seth Jenkins <sethjenkins@google.com>, 
	Kees Cook <kees@kernel.org>, Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-sh@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The memblock API guarantees that start is not greater than or equal to
end, so there is no need to test it. And if it were, it is doubtful that
breaking out of the loop would be a reasonable course of action here
(rather than attempting to map the remaining regions)

So let's drop this check.

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/mm/mmu.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index dd85e093ffdb..112fa4a3b0eb 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1173,8 +1173,6 @@ static void __init map_mem(pgd_t *pgdp)
 
 	/* map all the memory banks */
 	for_each_mem_range(i, &start, &end) {
-		if (start >= end)
-			break;
 		/*
 		 * The linear map must allow allocation tags reading/writing
 		 * if MTE is present. Otherwise, it has the same attributes as
-- 
2.54.0.823.g6e5bcc1fc9-goog


