Return-Path: <linuxppc-dev+bounces-21729-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D473CD6E50
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 May 2026 15:02:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gRmmf09VYz3bpp;
	Sat, 30 May 2026 01:02:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::34a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780066945;
	cv=none; b=FUkWUtoSRxHmyJEi6iNLgMa8+e1g6I8sLbHqBYi0rWwYvkjBtoqshvX8FyHYaMLnhsyX5YoTU68qIoB/FPQ7XAskp21MtidEbii06QN9jnXcCsWV32Q+QltlWD5gP3yikZKQL4HAF6kWmPG4wHpoDLGGilhNWjqMyNNt3rgeNL10Qk4c9LK7LuqWhNPaEnQ1WEu3lqQqbk+296CpRSckjZUNZdbgRDLqbPNW6hTUZU6NlgCiXgvHkqQvsncIJVPVf/uJG9Vh7degSH22FzkHgFojEtTvwHPTMcf6xo+gk55r0n0we6Mk7tSSlcAX0J3QkwoMFcpGdC8sYipiC7fY/w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780066945; c=relaxed/relaxed;
	bh=U/mwSEvShIHWF2QZpE0iwPRub+uC5Pg2lSQX62+z6MM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YsKfMwhxCH4Zbk4V+LoJ7v8NZ7kGMTWplytdTrtOsVcKYHL923LT4b9MVebNyDtBFg4ZCNjFHQFs01ifUEkE/+ptj4GfYWG7uV5nF55o9jjge23gv3t97MJXIO0NqVV94wXo+heZfCY80ERoeKLKotVIvmGJEQson8f0blm8WmpavrWtjZ2hkKkXNZbiaT9WgmhvapFrF4FOF4QCdU6LjShaBiGbObdjE6FhPen3AJHt8yS57PBFr4+yJpkd6cK2LKA8dg60dciRJ20smmTLJ4sS7kLyfPbmrf5BaKRK3vCZzLAJec/9Ibb1rQfGRscK/PuIrIbUhorpMrAtS+33/A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=kQ0iSF26; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::34a; helo=mail-wm1-x34a.google.com; envelope-from=3fkozaggkdi8tawu+z1cz77z4x.v75416dg88v-wxe41bcb.7i4tub.7az@flex--ardb.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=kQ0iSF26;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--ardb.bounces.google.com (client-ip=2a00:1450:4864:20::34a; helo=mail-wm1-x34a.google.com; envelope-from=3fkozaggkdi8tawu+z1cz77z4x.v75416dg88v-wxe41bcb.7i4tub.7az@flex--ardb.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gRmmc21bZz2ybR
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 May 2026 01:02:24 +1000 (AEST)
Received: by mail-wm1-x34a.google.com with SMTP id 5b1f17b1804b1-48fed2519daso66262625e9.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2026 08:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780066941; x=1780671741; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=U/mwSEvShIHWF2QZpE0iwPRub+uC5Pg2lSQX62+z6MM=;
        b=kQ0iSF2659c/3/E1Zl6fNxnIjx/12KbWd7nvWKFfPi18WMEasNuYimVPVureu19Of4
         nyBNfcbIM885ZV5zwU1Zr09q5njTZmOrk15mTJIBm8sB61oYxuJf+AoowwREcS0G/a2v
         aVeJ4nii4x9Qwrv+EBj/wdCcmVJ3Ez+No9z5JszeDfxAzrNvaRj1zu72Tt4HfrtBi7Nw
         l3MQaaRj9avdm2+yhyNQnvt6HdOl6HbYcAvIPFpJVjrI33lPZyX8zHzvhlhbUVwEPDVs
         ZTK/AD4ivLA+MAxFREhZVxH6tnmhvhoLxJqf1U7A0p5e3GNjnbc0FXEDKR343waUZ3W8
         ScBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780066941; x=1780671741;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U/mwSEvShIHWF2QZpE0iwPRub+uC5Pg2lSQX62+z6MM=;
        b=msy6wjmMaYpuHf2ThjBA68FItM8D1qa8kiHSEh/iXiodxzHNbkoqCXJmHcWz7f2TJY
         PdsTFhgRd9zDLG8P922lpJuxTE4UJBCPHh6hS2KingRUqxb/nDhDMnZYqetXXqhzeAld
         KTkXrPBOunFBKdioVu3DY+JB8kEsQy5sEcYmc9uCh/SiuDPkmNv68fTBB+OolL4RbZ75
         2KkKjQppyFTbvLi/WKUIHUo0Gr1KB3ElSruebjgMRjuYoFF21m/g6zhLU47mDhoFPp7b
         sd5w7BnzJyLbUIeCTxfamnW8+iapDs+g7QHH7/XMamThF7a27bUTjDGdCpqg3a7lZu0D
         0SDQ==
X-Forwarded-Encrypted: i=1; AFNElJ9erbscqnsOcA8RAJEFm8B3fV4RgqgiJ/CokQv+eSZUeKbGajaLc9OSZ9N73FKHMRuqGumY/k+RWXXvKmc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyBdSP+8A6pNgFS003OpwN+zLZ2rvGsgNrLzFuluFDCvNyMH8M2
	mhJlKoCcoEohsqOiwFD/uCtU1wzFzGFNLaHJHVYExrJegKLw3gUGMQHFITljeffDNXgtBySayQ=
	=
X-Received: from wmos19.prod.google.com ([2002:a05:600c:45d3:b0:48a:6a1b:6c3b])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:e489:20b0:490:6869:46c6
 with SMTP id 5b1f17b1804b1-4909c0c3aa4mr45310045e9.31.1780066940967; Fri, 29
 May 2026 08:02:20 -0700 (PDT)
Date: Fri, 29 May 2026 17:01:54 +0200
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2121; i=ardb@kernel.org;
 h=from:subject; bh=bTKeTgp6cCkzZ1W18Sd9Cjl54RAT9moCkecsCk8B5PI=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIUtyVRLb9epvd/g6Z6nXCMU1XxDqFp7StynL770hk8KPC
 3fVkv52lLIwiHExyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgIm42DP8T+QPDuZ5kJNY4Fq0
 fndHhtCalPXbZGdn3574zC/PNP3pckaG3SKqFZWbT0T+XSk3T86mOHw7v2nxfgWXR9PW1P5ftia AFQA=
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529150150.1670604-20-ardb+git@google.com>
Subject: [PATCH v7 03/15] arm64: mm: Check for pud_/pmd_set_huge() failures on
 kernel mappings
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

Sashiko reports:

| If pmd_set_huge() rejects an unsafe page table transition (such as
| mapping a different physical address over an existing block mapping),
| it returns 0 and leaves the page table entry unmodified.
|
| Because *pmdp remains unmodified, READ_ONCE(pmd_val(*pmdp)) will equal
| pmd_val(old_pmd). The transition from old_pmd to old_pmd is evaluated
| as safe by pgattr_change_is_safe(), so the BUG_ON never triggers.
|
| This allows invalid and unsafe mapping updates to be silently dropped
| instead of panicking, leaving stale memory mappings active while the
| caller assumes the update was successful.

The same applies to pud_set_huge() in alloc_init_pud().

Given how it is generally preferred to limp on rather than blow up the
system if an unexpected condition such as this one occurs, and the fact
that there are no known cases where this disparity results in real
problems, let's WARN on these failures rather than BUG, allowing the
system to survive to the point where it can actually report them.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/mm/mmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index aa0e2c6435f7..b2ba5b35c35f 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -257,7 +257,7 @@ static int init_pmd(pmd_t *pmdp, unsigned long addr, unsigned long end,
 		/* try section mapping first */
 		if (((addr | next | phys) & ~PMD_MASK) == 0 &&
 		    (flags & NO_BLOCK_MAPPINGS) == 0) {
-			pmd_set_huge(pmdp, phys, prot);
+			WARN_ON(!pmd_set_huge(pmdp, phys, prot));
 
 			/*
 			 * After the PMD entry has been populated once, we
@@ -380,7 +380,7 @@ static int alloc_init_pud(p4d_t *p4dp, unsigned long addr, unsigned long end,
 		if (pud_sect_supported() &&
 		   ((addr | next | phys) & ~PUD_MASK) == 0 &&
 		    (flags & NO_BLOCK_MAPPINGS) == 0) {
-			pud_set_huge(pudp, phys, prot);
+			WARN_ON(!pud_set_huge(pudp, phys, prot));
 
 			/*
 			 * After the PUD entry has been populated once, we
-- 
2.54.0.823.g6e5bcc1fc9-goog


