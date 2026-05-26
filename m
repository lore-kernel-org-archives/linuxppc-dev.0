Return-Path: <linuxppc-dev+bounces-21546-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1BD1CD5BD5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 May 2026 22:44:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gQ79H1wkDz2yfH;
	Wed, 27 May 2026 08:44:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::44a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779818382;
	cv=none; b=LmFJD7LFkP0XxcbHNkRxlSjAXzjK9ltZKyxe7cOtHufS7Lz9bo9TuSCJsaB+yWO4e0ev5luIVLOi/TQB5gJlgiLvEW/7R/y/zknsrf9btWXDGRLou0OT+1NIfSFJXmBobRlcZTTlAuGkUidh7RiRLbUzQheTt0hKHuFINQs4X76zSTtlLPEE0H9Mkl/dJmWu0lb59VeVOALCWKn3kz3ayjydjZnLoIAgMyyMVmcoCcF+YylUEJIveKRxY059u9de38ylPgfxVtex2ZQK3UeTxnoZOxJcUwujEriGKD3v7P2JD9qcslcwLXgANhk0BEg6wQ4OgV8em5wCZ64k1h4Ggg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779818382; c=relaxed/relaxed;
	bh=Bg9HdLIrtfTsrLcuMDzN3Kt0yw7TgIGpz80e87aySNQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=H4SFULDBJk1lqAWRCmWZ0uA+YDt0ak7UIVgbort8N+m7LGG8I+CJnA5oBDrC9YwA/+/dW4X4ad2ZG2HxCPbpOIGJ0YmQAfEHWcEooY73ux1DL53KkNWvhLcPj/dmtZNr/gSOUzfnot6GbuvfceZWdg+7h2vJPV5IQKoxb63R8LBLtvxaPNMoJkElgj32QXcgZ13gnJ4oZ0JlE8qPL7qY1/TCeBX3B+eNPN0CYPWJGlsQ2b66oySFocoK6xhFltPxRLrNXUpv33Oh1tcRAb5fOwoUP+w7Cb8vaKqwWiUTyrhMisK+o2bEnouebzu109DK5t8HmpAsvE0ImN/E6qqnYA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=p42eVgqe; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::44a; helo=mail-wr1-x44a.google.com; envelope-from=3it8vaggkdpczqca+fhsfnnfkd.bnlkhmtwoob-cdukhrsr.nykzar.nqf@flex--ardb.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=p42eVgqe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--ardb.bounces.google.com (client-ip=2a00:1450:4864:20::44a; helo=mail-wr1-x44a.google.com; envelope-from=3it8vaggkdpczqca+fhsfnnfkd.bnlkhmtwoob-cdukhrsr.nykzar.nqf@flex--ardb.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gQ0rY5qy8z2xS2
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2026 03:59:41 +1000 (AEST)
Received: by mail-wr1-x44a.google.com with SMTP id ffacd0b85a97d-43d7b7bacddso7450559f8f.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2026 10:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779818379; x=1780423179; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Bg9HdLIrtfTsrLcuMDzN3Kt0yw7TgIGpz80e87aySNQ=;
        b=p42eVgqecu6+L+clB988w7Mb1GnuFL7tukcrY3r9EQWdK71nYJQoznNR/OeXHdJIoa
         0RjpSi63c0M1noeh7n2M9FttUSjRnMegyzBdPO3MroAj/qwV9yqiaN2jWxRjECuwzhSu
         IuZQguv60eYgepSjzsFfpKJL4C99xWXUXslix/0ezLhsUjt7W0BuUGUJCnHRkAQvceLH
         ed30+2TOzv9j65s07175a+v/LirfjdGmJzYNE6LwGS4dPdruwhF1hL46OFzDVmu70vyU
         2C64v9uKQqvBc7cT79tVmlHYL0syGAC/gYAajTqnkTQHYROh4HCUEWsLk3pEtM/N3Cek
         MJBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779818379; x=1780423179;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bg9HdLIrtfTsrLcuMDzN3Kt0yw7TgIGpz80e87aySNQ=;
        b=YmoRi+orSw9KPgNFVXUwlGghg/3jmBPG6VveC7Y2uLdvyrajdPTStOce/bqWkXzzjc
         C+8JTTpIp4vhFkZ+xpHhpJ64GPzPtGRyA3w7/qKwsmn1D4tQyuysnKSGqbl36lQNqNwE
         PlKV+V7xkD73hX57OxKfX2nEi3b5qRDTwu1yfncXW8eihK3dKJJAFm6X/3zsk1yVJ/LL
         X3wFiktrksvLWNKBDB3NMf2hQdLJAqy3RLpxAF50k1JagfJXc6NHDMQLJmlK0RUoWrm2
         FJLs0yuB9qY4vqGAF5F+Dn4F0iuaD6k39JjYhLGVPet9kFQ/VzQOlH1zitcwJNDZ+tBu
         QAog==
X-Forwarded-Encrypted: i=1; AFNElJ+CRPV6zE1VaWl8L5GiwCEl5vNEsww16gwaS3TIbz+C2OGZkBS+ENi3eE2rAoJVOq7LIA2dFAkOkLRJnEk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxqjn47ZXkn0oqelNS9FQNvbv1tFhcbkxUyt1p97kXb2X2+0n1K
	mGltMiQTw82Eve1o46SNGqsDmoutef+xWuJvi8qUF0CY6WylI3cbiS8FJiE6AeDp6MyoO1HFBA=
	=
X-Received: from wmfv6.prod.google.com ([2002:a05:600c:15c6:b0:485:3f38:3dd2])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:35c8:b0:490:45bb:8dd9
 with SMTP id 5b1f17b1804b1-49045bb8efdmr348556125e9.8.1779818378710; Tue, 26
 May 2026 10:59:38 -0700 (PDT)
Date: Tue, 26 May 2026 19:59:01 +0200
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1898; i=ardb@kernel.org;
 h=from:subject; bh=mYtVYiSzRogY9cxOoJbyywYkU254ucBHoAXG9B3cPO8=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIUv0fiZrSsLEz85Vxb/brc+ssGD6r5/EdCw1zi66VivRb
 5JYlGdHKQuDGBeDrJgii8Dsv+92np4oVes8SxZmDisTyBAGLk4BmEhzByPD0ky+XTe7StYuXrtA
 se7PPWVX9mMHpG+dm3iu/EHwtpNeExj+Cv4Q0JnTu+ZI3cG3t5OPxTdavzl3yvBbYsCGnriEHY2 z2AE=
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260526175846.2694125-31-ardb+git@google.com>
Subject: [PATCH v6 14/15] mm: Make empty_zero_page[] const
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com, 
	mark.rutland@arm.com, Ard Biesheuvel <ardb@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Liz Prucka <lizprucka@google.com>, 
	Seth Jenkins <sethjenkins@google.com>, Kees Cook <kees@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-sh@vger.kernel.org, Kevin Brodsky <kevin.brodsky@arm.com>, 
	Feng Tang <feng.tang@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The empty zero page is used to back any kernel or user space mapping
that is supposed to remain cleared, and so the page itself is never
supposed to be modified.

So mark it as const, which moves it into .rodata rather than .bss: on
most architectures, this ensures that both the kernel's mapping of it
and any aliases that are accessible via the kernel direct (linear) map
are mapped read-only, and cannot be used (inadvertently or maliciously)
to corrupt the contents of the zero page.

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Jann Horn <jannh@google.com>
Reviewed-by: Feng Tang <feng.tang@linux.alibaba.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 include/linux/pgtable.h | 2 +-
 mm/mm_init.c            | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index cdd68ed3ae1a..67aa23814010 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1993,7 +1993,7 @@ static inline unsigned long zero_pfn(unsigned long addr)
 	return zero_page_pfn;
 }
 
-extern uint8_t empty_zero_page[PAGE_SIZE];
+extern const uint8_t empty_zero_page[PAGE_SIZE];
 extern struct page *__zero_page;
 
 static inline struct page *_zero_page(unsigned long addr)
diff --git a/mm/mm_init.c b/mm/mm_init.c
index f9f8e1af921c..46cf001238c5 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -57,7 +57,7 @@ unsigned long zero_page_pfn __ro_after_init;
 EXPORT_SYMBOL(zero_page_pfn);
 
 #ifndef __HAVE_COLOR_ZERO_PAGE
-uint8_t empty_zero_page[PAGE_SIZE] __page_aligned_bss;
+const uint8_t empty_zero_page[PAGE_SIZE] __aligned(PAGE_SIZE);
 EXPORT_SYMBOL(empty_zero_page);
 
 struct page *__zero_page __ro_after_init;
-- 
2.54.0.794.g4f17f83d09-goog


