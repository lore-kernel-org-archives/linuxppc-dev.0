Return-Path: <linuxppc-dev+bounces-21534-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6E1DCD5BD5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 May 2026 22:42:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gQ77Q2rrKz2yYd;
	Wed, 27 May 2026 08:42:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::549"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779818369;
	cv=none; b=glXR1dhOUVUOfO5YkJ+E8+0DXCW/rClhdzDjFv0XG6yyLouNwzX41j4Syt28FHm7/aOCWkTTkh+YO+uxYraLl+ZBPSCwi3I5f2zjJDrWYg+Vq6lLmVA9rEZylM0awyjMGhYTguczReFk2/p1IzuReDgizH3PmygK71uQSF6ZYTCWscSW9Itv0mNs+zkkpx51J7SG/TmrjWjget3OdxjfWDnuKNJm7RcyWQS8pwBXlfbnVYJNJ2vYy2RbEBU6ZbBHQfQvZRWZqHYfijCJt8auC+znNkv5SI0NsApfQj7DQqFEqhOHHsT6+9TEe+QDBXaM1Q0Ytd7SCDC0ntiS1p/fNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779818369; c=relaxed/relaxed;
	bh=LtBeFQlOADPYK4gJNp1okGIhaF4i6t2Ouexf2+2MrWs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kyaAG6aWgoxVSdyy7BezzYP/1/65b/dXlPvX25IOhGsePD4xOEWqE7h1Krht5tE678Mi2xx9A402Jk/98ifIEQJC5JHcvKJcZzgq6zZIhGr337ML3jjCF+W5uaYSSnxxf8EUVxeaSfWvgxBKrRPDsbroGKqmP/B3RnpgY4UUm3xNma4m94tNknpYENPtid7EA0Xj83/a3sBJxUWwJoB8lEk39oJAq6oZssSwRY7DLVGQ+WOwIrqcESvlXyKaMJIj5IWI3dgxqonMCHuNpFiEQMO3HWsLiCilAqFsUeHXMQ1CinS9tFOWN4DYmV7F9qoBD7YKfkJwR4O/C8bVI7tauQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=IWuH8PLX; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::549; helo=mail-ed1-x549.google.com; envelope-from=3e98vaggkdogkbnl+qsdqyyqvo.mywvsxehzzm-nofvscdc.yjvklc.ybq@flex--ardb.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=IWuH8PLX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--ardb.bounces.google.com (client-ip=2a00:1450:4864:20::549; helo=mail-ed1-x549.google.com; envelope-from=3e98vaggkdogkbnl+qsdqyyqvo.mywvsxehzzm-nofvscdc.yjvklc.ybq@flex--ardb.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gQ0rH3rt9z2yD6
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2026 03:59:27 +1000 (AEST)
Received: by mail-ed1-x549.google.com with SMTP id 4fb4d7f45d1cf-6877fc51d4cso5448436a12.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2026 10:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779818364; x=1780423164; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LtBeFQlOADPYK4gJNp1okGIhaF4i6t2Ouexf2+2MrWs=;
        b=IWuH8PLXZi7URPE3xf+nE4wUj+a2HE2jQGCM+0Uuddtae4vkwHQP+vX/RgQQ7BVyBW
         XmKDcDavXK0ASzlAnworFlRC6TxZEru54DNVIcCjv+0SHBHkGG4Lo2ZWO9hL7ilAKQve
         x8ifCpBrGJmw2T2QVw7LgndzPr5sEA8H7aAdwer7xp1ri4DjD+r9SKbBHZHFq6mKJmUG
         hLdrp6bBFMXumNU+teCVjF2vJJP9pXH6JHm5eSd944VMtn6jMEhAFXA/7P7sQTjXVQ4J
         TTYLs2klBgbudtOKEATc15Y1tc6o62crdVNJoD9Q7F07Q6Gu7y4wSOqZlhgseJciu0FA
         zP1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779818364; x=1780423164;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LtBeFQlOADPYK4gJNp1okGIhaF4i6t2Ouexf2+2MrWs=;
        b=iuFJrkGT1SEF2gpYHq9XntWLyrzT7XK/Hfz2jhDTjGY4fakwuvGRm373TG+GqmxuXM
         C6n9fWrBjX5NOA/d6NQFF7Khd/wjmBTMGBVNjTTsmDqgloPjEHyRvMSgtueRFcaI8JCX
         mjOdaMd0pOygpRCZZTcUf6SoG2Ur5nXkfFyYGZbKQTf2cKFry6qj0UcyH9VG8w9wpKuo
         qZoDDJbyGC4o/gCHdCx0HhNbJ6W8jL1VojKknfuqsIlXI8cBytm3X8l036VIJyWv0GPg
         X2MFAuiF+sa7DQxlKqOEkfligw/yanhF/A/9+GjYo29R2ZWn+a3q5oWDKpjgrR4z8j/k
         d2zQ==
X-Forwarded-Encrypted: i=1; AFNElJ/Yi481jPsc1ggphVmOlQ+19X/e4tySQ8e7DzULhfQtSToz+QcaOHDYHzwcJxFNNOCAYJOQBwAHfgOYEvU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz8RXa4fNEo92v+6sGeoamLlRiYlLqDgZHRyPmTDSNiw3xd4gMF
	/pS1iG+2VWRvyegYfSNE1lKMp7e2GgzxRjXzWnax8kv5W9CInn2B+6Ie4PKPKCh9tjI77CIJ8w=
	=
X-Received: from edye18.prod.google.com ([2002:a05:6402:892:b0:67c:573d:d3a0])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:40d4:b0:67b:cd1f:9cc1
 with SMTP id 4fb4d7f45d1cf-6889c445088mr10125279a12.6.1779818363764; Tue, 26
 May 2026 10:59:23 -0700 (PDT)
Date: Tue, 26 May 2026 19:58:50 +0200
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2121; i=ardb@kernel.org;
 h=from:subject; bh=UYuabKAGVqw/38U/k7XQfrNPG5ThRXq/7mqnsjcGnSk=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIUv0fvTm0BsvTTTaUheFf26uWyada7zXR7A5ui2rSTZi1
 o2FJrwdpSwMYlwMsmKKLAKz/77beXqiVK3zLFmYOaxMIEMYuDgFYCKHcxj+Cl+U+L3mz31fZxuh
 tHcrzdsEq/i1War/p2x78yRMa8USUUaGzw8WujlZRJw7v672d9asvI8f57TITLjpqnwn3Gp2wO5 +NgA=
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260526175846.2694125-20-ardb+git@google.com>
Subject: [PATCH v6 03/15] arm64: mm: Check for pud_/pmd_set_huge() failures on
 kernel mappings
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
2.54.0.794.g4f17f83d09-goog


