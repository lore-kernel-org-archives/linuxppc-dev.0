Return-Path: <linuxppc-dev+bounces-21732-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77735CD6E50
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 May 2026 15:03:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gRmmh4KLnz3bsq;
	Sat, 30 May 2026 01:02:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::34a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780066948;
	cv=none; b=gK2iyB2G4WPJKyNCgbSopR74WHwaizPrzqUHrwi5UZwMw/Sa7gPyucjbYgOTdkMPLoRS1H5QAX9GF0i+MrBYVfnLQm7arc8vUcJEF1U1R2c0VB0aa+rd+9emL0OifFMhoVQA21zs4hw3GH2Cscyfa79S8W+mevtxMfV/s687LRnpCWgLDLN5nkd8GJVwgZLsVfWYWaetWWu1nizYFeSmeqoFilc25XbTmLZT0JsVFcZ8IumqsMh4kvoKiSABA4NAD5wF2i2Tr2M+3nrpZOD5NY+e7klznknFjfCTJuLIchj2Qu7XPyunH/qE0GttEwz4BWGXn+qUL9ncBdpHjPRvoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780066948; c=relaxed/relaxed;
	bh=jiyjEGpnno65e28CupjUd9OJcNW9bWS5umqxs4/DfeA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lNQlhMorHga3dsUxCGo7GxX2TJU4uoHSQBUS1zLT305DNE8Ex7jb5TBSbH5EQwU43ve8B+Ut+nOlr3kfNdkfEN9+9FI7TXLTJMvtkjqrg7+ab/BLS1hcufPC7eosf9vHXlt4tepKeBmiydaZeJVGM6JZGAf2SbyC0cm0eiSEzMZRsQaRdPuq+aStqPJQIgNRbh2ME0TR9G3hJtDjBF8Sp/AlmubH3XnhciGKEcSzDXYOZKWJtxJWbsMx/XhtMgc/rZ3CgFhSlMyg8IciRSaFe+toJE0R3pHGI9Ej9v31cJRiAqsrLpBALlhsr8ecfL8gnVGNVFTuquKYJrdxdHOrUQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=GveUTVFX; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::34a; helo=mail-wm1-x34a.google.com; envelope-from=3gkozaggkdjmxe0y+35g3bb381.zb985ahkccz-01i85fgf.bm8xyf.be3@flex--ardb.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=GveUTVFX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--ardb.bounces.google.com (client-ip=2a00:1450:4864:20::34a; helo=mail-wm1-x34a.google.com; envelope-from=3gkozaggkdjmxe0y+35g3bb381.zb985ahkccz-01i85fgf.bm8xyf.be3@flex--ardb.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gRmmg2XlQz3brv
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 May 2026 01:02:27 +1000 (AEST)
Received: by mail-wm1-x34a.google.com with SMTP id 5b1f17b1804b1-48d127eb013so67622185e9.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2026 08:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780066944; x=1780671744; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jiyjEGpnno65e28CupjUd9OJcNW9bWS5umqxs4/DfeA=;
        b=GveUTVFXbjFPuZiry4snj4Zh42pU8O1ImXo8cPE0Kw26C9BOrU6OkSERFNuLrvhJ69
         faaWsmtgvL0x5cWhrujYmKWW20PQuqDEzhU9/f7RFpaWNpRtbKmnewHerjU+OQrUEoW2
         tvNmVJ2kxFfyAIVAJLZenevehU4dJSA4B4f0FteIJ962h7mjP5CNSrowf1DD8xhRsPKs
         G/S9y8F5ZiHwHiUheCUs98G1HJ98wuZoe6LElX/JMe55IzH+ojcvxM26NqVgx9T0NUj2
         I+VXEdg8VHOpZkiN3+OjqISxdK+DcKZG3ajG9hoU9wctjL7/ik1Aq0IR5xJT2F0xAqu4
         9jIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780066944; x=1780671744;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jiyjEGpnno65e28CupjUd9OJcNW9bWS5umqxs4/DfeA=;
        b=XeTqLSPtF0caCxVDXeoN1L/YkhwppCrLFXhZArmTr/Ti9N42BhK4LH0P48bjyHS8sR
         9jCg2ceSXLxfj5L6zBmwtIKKvLFmFiVDyonVWEAhcB+GbHtxYoD789F4efc5bbQvK6DS
         haINWXAJC8lHZ2h5PLN/Qqul14qtCNikGgku0XSSKfz2fLQ61hcwf1CY+I0LWWIiVf9I
         7IUADecBc6ejmL5KVBlSvdLDUFzH18HpWe4J2WBnLB0XE4CjzlUetrfyww6DGOH+5M/T
         B57B3aScoqjmANr3fXhXLmGWZM+9JrPBY1tEecHetHtYovr6CNy+kIamsP+2GsSdUP+o
         70Ww==
X-Forwarded-Encrypted: i=1; AFNElJ/+LKHDJqOmhYR6GGQXNEOfeAeDvXaPBzsApWSN94HOc7VAt48Qbg61i8dYoBhjK3g5/dtHh+RziNRdMho=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwxVCGQ/n3AEy6Oot2ULEr7GDA87cLOXVYM+jBzppZg0IrQ98FY
	SLulk4lFCSdQylux4nkgaHTl8WuRnKhjwJDQAAinCBCF0bCGtBpZr44pg6ro2Vji2lUaLKydTg=
	=
X-Received: from wmbgx19.prod.google.com ([2002:a05:600c:8593:b0:489:1d25:1a63])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:a315:b0:490:53d3:4767
 with SMTP id 5b1f17b1804b1-490a2912114mr284275e9.7.1780066944330; Fri, 29 May
 2026 08:02:24 -0700 (PDT)
Date: Fri, 29 May 2026 17:01:57 +0200
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1543; i=ardb@kernel.org;
 h=from:subject; bh=aFPaV3eZRwZbfRuJcOVglMiqpjLOoyYLSair5CgEE90=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIUtyVZr0Ro45KbG/U3TOPQvc7JNkwC0kaWy1cjWvuuPuw
 kXLLSd0lLIwiHExyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgInMk2T4Z7Hw4UF3Zx6hsg1W
 SuvzdNwYJPwFeT9LdVbN/bJSSk70NCPDCQPV3OWP9bYd/e+4xmP7gWzbOV2yZp1zagvtpm/ydwp nBwA=
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529150150.1670604-23-ardb+git@google.com>
Subject: [PATCH v7 06/15] arm64: mm: Permit contiguous descriptors to be manipulated
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

Currently, pgattr_change_is_safe() is overly pedantic when it comes to
descriptors with the contiguous hint attribute set, as it rejects
assignments even if the old and the new value are the same.

In fact, as per ARM ARM RJQQTC, manipulating descriptors with the
contiguous bit set is safe as long as the bit itself does not change
value, in the sense that no TLB conflict aborts or other exceptions may
be raised as a result. Inconsistent permission attributes within the
contiguous region may result in any of the alternatives to be taken to
apply to the entire region, which might be a programming error, but it
does not constitute an unsafe manipulation in terms of what
pgattr_change_is_safe() is intended to detect.

So drop the special PTE_CONT check, but still omit PTE_CONT from 'mask'
so that modifying the bit is still regarded as unsafe.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/mm/mmu.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 6b42d724bd1b..d7a6991e1844 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -134,10 +134,6 @@ bool pgattr_change_is_safe(pteval_t old, pteval_t new)
 	if (pte_pfn(__pte(old)) != pte_pfn(__pte(new)))
 		return false;
 
-	/* live contiguous mappings may not be manipulated at all */
-	if ((old | new) & PTE_CONT)
-		return false;
-
 	/* Transitioning from Non-Global to Global is unsafe */
 	if (old & ~new & PTE_NG)
 		return false;
-- 
2.54.0.823.g6e5bcc1fc9-goog


