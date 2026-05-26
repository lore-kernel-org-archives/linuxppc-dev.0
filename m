Return-Path: <linuxppc-dev+bounces-21542-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EBE0CD5BD5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 May 2026 22:44:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gQ78n2dYRz2xld;
	Wed, 27 May 2026 08:44:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::349"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779818377;
	cv=none; b=SGoPb8BdskCdcMtcxXxFMGjmqNrAJOOpRD0QaqW5qF53C05rlte+QUXRy1XW8d6BMjRZ8rAsT/9N3SfBHAFh0tio+qjWFoatT99nCs8/y3+iGGvFDfUYY4sR3W7/xDSndzwyTFja37ciYCTgLNeEvkJD7ljfglO/wIdbWLE/KDtc1miHhto2KhxNjObNFzA6gJq/Rrt5lyyzY40wVyNZWIqrJu45KbU9z/UOEbmB/bEV8+GrTrN56R/aweE/YMzCgQP91kh5ZgAz8FZfzJVQLfx61tWmrscDCyICf9jJH59qG0jR3Hlfn3bOdsrwT+r5eeiyYP3jG5hbOk4jo15RXg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779818377; c=relaxed/relaxed;
	bh=/YEs+3ha0YZ0GL65qiPfv2bavm0rO2bwvFUt4jkd+Vg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=chq2wMI7T28ToM+XdP14aeGPTnL3Seb5MgXDfdyS1VqJFJOVWjqFilQwl3xxmCw2pxnVoBnatDxnEunLiG0f8lZEPUNaILY8j2NufY0mMqXXrjIxEabtHZAZeNEKm0GZ1sKnZDMbj0nelANzCKB4KDOsw+pgcHURmboYTQxFs5VcctzQvZ9BtvlsKqBXtHAM8ixRIFOKAXC9D9e6npvA2aZXvNm6pE4ZXYxSU1IX8DelyF242Q4ZRJg+e4r9LOCB8nYqH/RMaMeANp+8Kyg1WG0mmJ7Kx2buaj4sqqBUZVwb9HSCL2tDsIHREo8iE3CBDWnlfCBunM1WtuQ2b0NDiQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=boXb38ge; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::349; helo=mail-wm1-x349.google.com; envelope-from=3hd8vaggkdpiulxv+acnaiiafy.wigfchorjjw-xypfcmnm.itfuvm.ila@flex--ardb.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=boXb38ge;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--ardb.bounces.google.com (client-ip=2a00:1450:4864:20::349; helo=mail-wm1-x349.google.com; envelope-from=3hd8vaggkdpiulxv+acnaiiafy.wigfchorjjw-xypfcmnm.itfuvm.ila@flex--ardb.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gQ0rS48cWz2xS2
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2026 03:59:36 +1000 (AEST)
Received: by mail-wm1-x349.google.com with SMTP id 5b1f17b1804b1-4905428aad6so30182115e9.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2026 10:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779818374; x=1780423174; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/YEs+3ha0YZ0GL65qiPfv2bavm0rO2bwvFUt4jkd+Vg=;
        b=boXb38geKekYF0Iskgyd9f2F56iQv810xw2Orqfcb+P5tYvKw2WNkVJhY5z3LOkVkJ
         WGACyjp1/uk7KmgbWswsPK/T1JzuYa4OQz1b1exSbJwxAIksWJcn8PWF4aBJnkRKFoQh
         nbfGjmAP7C72VKm1VOh/wH5HI2SjwwPJpdnvYAJTWcLWxR/FWEMHqLNiWmsraDNtCyhw
         IsjOrhSyH7HFuAG9Lgk5z7r/PUh8A7vsA0Bd0MK83sKc00f7zqM+3qrvxDGEM0CnRb0b
         elK1GA8MQEaL8ZcI26bMr6euxDV6Tu50y6dbPXCdcOTWqVujMck3KdyRBlIYjKxMiRU2
         Czqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779818374; x=1780423174;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/YEs+3ha0YZ0GL65qiPfv2bavm0rO2bwvFUt4jkd+Vg=;
        b=CsxMvqY/gukd8WT0LhPF04McvEOzBSux9FZF5MF2xCRsbi7NHJZl2xcFUBGCLd58UO
         p6icGXRd6lWrtk6D31pWHwWkGKqog83g4AFi2ldRRS8MAiBNQ/Ed34SvTlotfrskPATK
         KzEvBVSXwwy6/spKw45GEhS8Woh1qNncbBrx3qwBzlOFWzwJct84YAdNbeNBmwcyxhzg
         8E1smS6Ipu45xZ4m5A5texqFyUkOlyAosUTsqbhciBF77DjHdL9qBPWSlonnIBkR2yWo
         Cs//rsyCZESMrqdxX00U5s18zA0S1GDjQzOMA9NSRP/7iLwWmrKY1exfwoHJrMVuBu44
         0APA==
X-Forwarded-Encrypted: i=1; AFNElJ9o2Gylap68hhIvhTcFLhBF7W3e+edbPVgOacEipkDIZ/6nuyeKMxNY6q2SXBWHTUh5Z5SY0gukuXiavNI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxWVKmlviBEcUpA+iPM2bjIBCrvADX9HL91a+2uerR/7cWB8JYv
	lMsSw9JfWEzHw0CSCTuk/jVt6H9AhLUk8g/11XxOaLZxFkal4dCWTX7nGEMW+HKmBQNWXf01YQ=
	=
X-Received: from wmri26-n1.prod.google.com ([2002:a05:600c:8a1a:10b0:490:49db:2263])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:5298:b0:48f:e230:1d12
 with SMTP id 5b1f17b1804b1-490428dd63emr346556585e9.31.1779818373602; Tue, 26
 May 2026 10:59:33 -0700 (PDT)
Date: Tue, 26 May 2026 19:58:57 +0200
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2521; i=ardb@kernel.org;
 h=from:subject; bh=IVFHANRX1Y5B7sO2czLQgDyXUEkQiTSy8G1FQDCgg/E=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIUv0fsoLbrWLu7gSw7a4He9yccnfFaz2Zfnzl9euX9kmw
 5F4//u9jlIWBjEuBlkxRRaB2X/f7Tw9UarWeZYszBxWJpAhDFycAjCR2HhGhum3KqfUzpnosfjs
 O4PZz65tu/Cten/afJ4dmhfPiNRN+BDP8D8myOOB5p+Lm9QF963bJLbl3IvwqSc/fj98Oa1ZZH3 U5m2sAA==
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260526175846.2694125-27-ardb+git@google.com>
Subject: [PATCH v6 10/15] arm64: mm: Don't abuse memblock NOMAP to check for overlaps
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com, 
	mark.rutland@arm.com, Ard Biesheuvel <ardb@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Liz Prucka <lizprucka@google.com>, 
	Seth Jenkins <sethjenkins@google.com>, Kees Cook <kees@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-sh@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Now that the linear region mapping routines respect existing table
mappings and contiguous block and page mappings, it is no longer needed
to fiddle with the memblock tables to set and clear the NOMAP attribute
in order to omit text and rodata when creating the linear map.

Instead, map the kernel text and rodata alias first with the desired
initial attributes and granularity, so that the loop iterating over the
memblocks will not remap it in a manner that prevents it from being
remapped with updated attributes later.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/mm/mmu.c | 23 ++++++--------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 04cc579c7a15..b20c76b8381d 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1164,12 +1164,14 @@ static void __init map_mem(void)
 		flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
 
 	/*
-	 * Take care not to create a writable alias for the
-	 * read-only text and rodata sections of the kernel image.
-	 * So temporarily mark them as NOMAP to skip mappings in
-	 * the following for-loop
+	 * Map the linear alias of the [_text, __init_begin) interval
+	 * as non-executable now, and remove the write permission in
+	 * mark_linear_text_alias_ro() above (which will be called after
+	 * alternative patching has completed). This makes the contents
+	 * of the region accessible to subsystems such as hibernate,
+	 * but protects it from inadvertent modification or execution.
 	 */
-	memblock_mark_nomap(kernel_start, kernel_end - kernel_start);
+	__map_memblock(kernel_start, kernel_end, PAGE_KERNEL, flags);
 
 	/* map all the memory banks */
 	for_each_mem_range(i, &start, &end) {
@@ -1181,17 +1183,6 @@ static void __init map_mem(void)
 		__map_memblock(start, end, pgprot_tagged(PAGE_KERNEL),
 			       flags);
 	}
-
-	/*
-	 * Map the linear alias of the [_text, __init_begin) interval
-	 * as non-executable now, and remove the write permission in
-	 * mark_linear_text_alias_ro() below (which will be called after
-	 * alternative patching has completed). This makes the contents
-	 * of the region accessible to subsystems such as hibernate,
-	 * but protects it from inadvertent modification or execution.
-	 */
-	__map_memblock(kernel_start, kernel_end, PAGE_KERNEL, 0);
-	memblock_clear_nomap(kernel_start, kernel_end - kernel_start);
 }
 
 void mark_rodata_ro(void)
-- 
2.54.0.794.g4f17f83d09-goog


