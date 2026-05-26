Return-Path: <linuxppc-dev+bounces-21545-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E487ACD5BD5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 May 2026 22:44:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gQ7976gR2z2ydn;
	Wed, 27 May 2026 08:44:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::349"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779818381;
	cv=none; b=LKPXoIGeCtZA+6XH/KfZkM66hJUNGnrIzR6Ftim2BJ64oqxgbcx0Wj6Dj3Fvq92k4qH7jgueUo4PBLcTBQ+ZhgFnBdyk458GdzaabOz0PgpT7XNySZy+gvZQOX4YnmTGS18AcuLajTjjPkJd62rLqLlh0yRoFDRDHjKH6LFT3WvohKVMBmqsCY4xfScy2UViopg9e3qqai56necL7oWo3EYMuQ1pjJAbp4yMXUl+RTMySXTgu8ATunj5+ppr8pHOoT3e7YoM4w4kR6ZPpuaAGHfbj/WUDFY5rNJG22uPLBSo/3az0/HoZAcU2awX8sX0Vs5gXo8MgEWzHNwDsYAJxw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779818381; c=relaxed/relaxed;
	bh=pjw03D6SHFyZLBNhPne++YEq9ou7VA2sQlGz9HbrowM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bazY0ufHqLTjdYvWgXXXIrJa+qH5u9Ljt6z/Oq83s3kJF3Lb8/ej49bVXEYnkgUXQ1sUUh8kvsmHG1IcIYj7rjYbWuD9jvAq3y5obHpzxJyrufDIOwztKNW7OFMF+eThDfYyjV8aZcOvxfsBIcN1R9e7Jj0p3pqpkt1ZeslGsatP0aaOum7V7K0mbGS24HrOwxXwPvqmAfKtzkpjOW3/ojzxsvmaLGdGA5VkHeA3Wkfu3Ehqpj/LJZW28vlLnSwrCJmNN9cd1VuUqFlHpIMz4yxn9/2tifsBlkkOXyO2oCgDEcFyVD//Ys3Iq02Lj6wNfX6i05rcBitFs5FEexZQ6A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=PWmZD+xK; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::349; helo=mail-wm1-x349.google.com; envelope-from=3id8vaggkdpyypbz+egremmejc.amkjglsvnna-bctjgqrq.mxjyzq.mpe@flex--ardb.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=PWmZD+xK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--ardb.bounces.google.com (client-ip=2a00:1450:4864:20::349; helo=mail-wm1-x349.google.com; envelope-from=3id8vaggkdpyypbz+egremmejc.amkjglsvnna-bctjgqrq.mxjyzq.mpe@flex--ardb.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gQ0rX5z2Wz2xS2
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2026 03:59:40 +1000 (AEST)
Received: by mail-wm1-x349.google.com with SMTP id 5b1f17b1804b1-49049100a40so27731745e9.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2026 10:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779818378; x=1780423178; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pjw03D6SHFyZLBNhPne++YEq9ou7VA2sQlGz9HbrowM=;
        b=PWmZD+xK2fS8cwGuFEQG4jwF+Lr7AHMOCBHCk0hGzupY3znpKG0tcPoAS/xv3PP8xv
         QF+YruM4Zoz+EX1NpYyxTZIfYjfo9PyYkIP0/j9MSY6c6nuc87NMI3Di8IGd7j2ylHw4
         w7YCW6WlmVrX/uyqtgVhvw3NcvxH/XVto4JvJLH0UGvCELt9yRy2LgXo8X5HwTRhHK5B
         OYKValWiCf+zGQB+TKslpK6uebUtLXlcmxFj9Uq6XLnpXAY0qSq+5iwfMbs9GpV+I12X
         Oc65TB+UULChFS2AO0zZo32jskF/kd3f9YaxaAdq623liywn0tici+iH9Sek93hW/gmu
         sdLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779818378; x=1780423178;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pjw03D6SHFyZLBNhPne++YEq9ou7VA2sQlGz9HbrowM=;
        b=b5KB8bEvOJMATddigqztxfHAykGckVkayH8H9RAxtGpuYN8eSWrjQ1n16zdZuyAqZR
         ai4f39ANnhb3KHGbuwd6DnYl0ORmcYoW8unht4+e980Lr+UKuRoRAVIm1d3+aHFTox5V
         /uVsJTuqUdQO8GhBS6PDXnawmAoxz3IxMj4FqKBDwkOOeeOiwBSAuPaJO1qnMaTRJGTh
         XPqEAAolnf+iAZPh8bQyCcyyzlt3RuPtL0UCLWV6SWbi86bmbtLzL6TA5Klrb2ICk2rd
         SnOAXINuMB2DzxfSgEPMHLJ48psfVUAbX8f0zC0FbUwDvgK7V5OunXg2w5wXOXYEOd98
         1BWw==
X-Forwarded-Encrypted: i=1; AFNElJ/ZXL0n9y1yZT/l5nlVnbc7vV+bFD8bwcKNqxLJt590ih1NgW/+opsJ314AAJLw5d4slm2CjpJKX5IikYs=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxtNh3W5mWx+wmvm4MU7vwTQaCWt7xj+G5ZVzApj7bKwh4EsKog
	7m6Dk9dP3zjxzlbZiW8R9x6AndwLIUvorl8XnYPD7pyfJmbEwmWIFe3kqTekkX8v8r44LUZt9w=
	=
X-Received: from wmog11.prod.google.com ([2002:a05:600c:310b:b0:488:7f73:f59f])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:4f88:b0:490:50eb:b777
 with SMTP id 5b1f17b1804b1-49050ebb9e0mr289239055e9.5.1779818377750; Tue, 26
 May 2026 10:59:37 -0700 (PDT)
Date: Tue, 26 May 2026 19:59:00 +0200
In-Reply-To: <20260526175846.2694125-17-ardb+git@google.com>
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
References: <20260526175846.2694125-17-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1330; i=ardb@kernel.org;
 h=from:subject; bh=P6+9rEICJJwtkUC1X6hejRp2Q1Pr3xumYehGC6YytMU=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIUv0fobew29CRUaVxU/ZtLw+1lwTWmzi/Jj1qSv70V6Hy
 z8YV03qKGVhEONikBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABNpOcfI8HBnlRjjxeVTqlfn
 ZXLs3ZJ7bJOj+aZIhVt/dgfO0n5tlsrwz8LsvO1Fp6MbfH7/PnJz9VaPp6kP950W7qm/NTevLfh YHjcA
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260526175846.2694125-30-ardb+git@google.com>
Subject: [PATCH v6 13/15] sh: cast away constness from the zero page when
 flushing it from the cache
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com, 
	mark.rutland@arm.com, Ard Biesheuvel <ardb@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Liz Prucka <lizprucka@google.com>, 
	Seth Jenkins <sethjenkins@google.com>, Kees Cook <kees@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-sh@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

SH performs cache maintenance on the zero page during boot, presumably
to ensure that any clearing of BSS that has occurred at startup is
visible to other CPUs and DMA devices.

The __flush_wback_region() function takes a void* argument, which is
conceptually sound, but given that empty_zero_page[] must never be
modified, it is being repainted as const, making it incompatible with a
void* formal parameter.

Given the above, and the fact that __flush_wback_region() is in fact a
function pointer variable with multiple implementations, take the easy
way out, and cast away the constness in this particular invocation.

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/sh/mm/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
index 4e40d5e96be9..acbb481cdbfe 100644
--- a/arch/sh/mm/init.c
+++ b/arch/sh/mm/init.c
@@ -332,7 +332,7 @@ void __init mem_init(void)
 	cpu_cache_init();
 
 	/* clear the zero-page */
-	__flush_wback_region(empty_zero_page, PAGE_SIZE);
+	__flush_wback_region((void *)empty_zero_page, PAGE_SIZE);
 
 	vsyscall_init();
 
-- 
2.54.0.794.g4f17f83d09-goog


