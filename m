Return-Path: <linuxppc-dev+bounces-21547-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0332CD5BD0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 May 2026 22:44:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gQ79P2xRSz2yfy;
	Wed, 27 May 2026 08:44:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::349"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779818383;
	cv=none; b=gdYxEwvFjMkLGCXxpO9HKjCsfscivl7WSoSPia6kAlIaUbc1EfK6rJkAOMPSmFnvHIyppYGbOwhDUL3BzqPMH0gLMofb8olUze7DhTyI2LN0cHYIX/MXdTpWpwQNrkpz8Oci436C2KJVzxVfLPM1VgMQTW+9HzPtYcmf780dyt0Txu39Cp5CX7HcoODy1yD8M+Od7fRpbfhcx4e1BuOhMHwRmJJWPqM5aomOkuDP2W5nMQlYHlnCefdC3K0JaacxXA2fbMKR1aHGgVp4r+3lO7EXqllv4RUBlQ7aP6DuXCNmWfUrCusfXRoRP53flpJcf/NnvoLC8lVhbjteLQgERg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779818383; c=relaxed/relaxed;
	bh=YW83U9WXzmuOgO+qiU2xntn4xO4oQspRqeeRLd3+Ago=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jb4BwunQnrl9udZC4RN6rrUq49sIq//HHm0pbqmsghQcUkydDetLf0/EDu5GKqpMVugWrrU1J+N4X2QsprKBI6/QBukj1PyiBetrzvO8z3GAyD439VMIH7DoIpUawXxmB/gt13qKn3RiMlZ9Pq5j6vAq3ABfPHyQXKXkhiRkO18wCLYGvlZryiVbuE2CZ18xKbs/YpiiVDFYA0O6nPWqmHLNJ9uAzyceiq6qw+wDCdEs5rJPOfXrADA0gDcREQZ4l0X7mGUc/oZorMnPrm/Vr9EqC6JZe5bnw8kVZ0oSf5PkPxj7EFR6VVjDRHvFLT8+RE/Ap6bGtlbXoIU7ZaYK8w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=YUGP+RRQ; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::349; helo=mail-wm1-x349.google.com; envelope-from=3i98vaggkdpgfwig+lnylttlqj.htrqnsz2uuh-ij0qnxyx.t4qfgx.twl@flex--ardb.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=YUGP+RRQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--ardb.bounces.google.com (client-ip=2a00:1450:4864:20::349; helo=mail-wm1-x349.google.com; envelope-from=3i98vaggkdpgfwig+lnylttlqj.htrqnsz2uuh-ij0qnxyx.t4qfgx.twl@flex--ardb.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gQ0rZ5sdbz2yD6
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2026 03:59:42 +1000 (AEST)
Received: by mail-wm1-x349.google.com with SMTP id 5b1f17b1804b1-49043386b3fso40658225e9.3
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2026 10:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779818380; x=1780423180; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YW83U9WXzmuOgO+qiU2xntn4xO4oQspRqeeRLd3+Ago=;
        b=YUGP+RRQoc7BVZ/8ci4Y+w4OFnzCGGW1UqEZn0OSYvCCjQyd0qE04wqooZ79kIzAIn
         4Tf0zMjU+CXQ0Sv+sWWR32VsbGdIb8I2TUqPXkST6T/QNH8AhII3R9EPms5ffK3XlWmW
         eR91z1axnVwhikk4LEPmF1qodiX2exsdjbgNKRlGeoLy/ywRFnexMyf2LosSo83i5Cc9
         ijH4py2SqmX0xNjN5K9Dzs3GBvTmJwUij0Ze91v85Q1RdL2S5CvkFqgd/UayWn1gn3pL
         MDy18oJLv6rJl3r3ffh9mo+u7Ndw5KXoS6gUQR+ySGUFCX+C28XwDE7LJE3OG/ok0NGa
         XiRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779818380; x=1780423180;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YW83U9WXzmuOgO+qiU2xntn4xO4oQspRqeeRLd3+Ago=;
        b=eyrDLnvLbto4R0TuInhIS6PkTfWBB1DKRKseNqWuyrLVTbcfrl942fjKyJLhY2Jml2
         lLnqkkRpL0LX83Y45Si9OZ/ZVq1Xsf+BK2JIb7phWkczV0p0C/+56FwfWfIUhIRQiRKA
         2kdWXhVJuaPznnCqqmc+FU3kDsfh4lkTVagcccWzhnUmG6Nqvu6vOkBrP7AjAO2eOHHe
         4iZGyHlfNkffiYg2KuiF9BpV6SvzeCmtK4Ev2pbSNBremu/YCsEgqbv7x0QW4PYgYN4H
         UBGRHN2VwRel/juqB4oMXc8AEfwvJna3W68Vyt2Rbam0ibu975REAsWzaPWOYKueyEb7
         +b9w==
X-Forwarded-Encrypted: i=1; AFNElJ8K6gNSR+A77DVoSVqyntKvcIPByVWN0TJILHKrTIUOqk6SgGtL9eBL0TxuL2oHfAD9o3OJ0T9XhraaTRA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxbuMYHAC9KeisTFvqziQ9C+pM03HrFa7vqCeDF/W2FcGN8+QhD
	SsUTvBZLgtsuoKULsteiVZvE5bZdcjIjiZV49S7Rue13OOoskrI0u/si0HfDv1Bgpym91kYyzQ=
	=
X-Received: from wmbet15.prod.google.com ([2002:a05:600c:818f:b0:490:3dc3:e5bb])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:c4a1:b0:490:3fd9:e78b
 with SMTP id 5b1f17b1804b1-490426cef8bmr337552265e9.17.1779818379722; Tue, 26
 May 2026 10:59:39 -0700 (PDT)
Date: Tue, 26 May 2026 19:59:02 +0200
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3044; i=ardb@kernel.org;
 h=from:subject; bh=yy+qAKwWsZGAcScio201064FyPP//0qmouvkE8IJvkQ=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIUv0fnaITtnLMqdFLhxOPsKdSl/fzf8vyMu45VaardtDA
 beLD6d2lLIwiHExyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgInYcDP8lc9eXJtj5vLqXm5w
 sP0Cd7YzPcsCnzf0M7wXrV0bcOh0CsN/58OffBc4fZ3FmC48Z1Xn1KPu098u1d/xmnenxq61z05 +ZQEA
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260526175846.2694125-32-ardb+git@google.com>
Subject: [PATCH v6 15/15] arm64: mm: Unmap kernel data/bss entirely from the
 linear map
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

The linear aliases of the kernel text and rodata are mapped read-only in
the linear map as well. Given that the contents of these regions are
mostly identical to the version in the loadable image, mapping them
read-only and leaving their contents visible is a reasonable hardening
measure.

Data and bss, however, are now also mapped read-only but the contents of
these regions are more likely to contain data that we'd rather not leak.
So let's unmap these entirely in the linear map when the kernel is
running normally.

When going into hibernation or waking up from it, these regions need to
be mapped, so map the region initially, and toggle the valid bit so
map/unmap the region as needed. (While the hibernation snapshot logic
seems able to map inaccessible pages as needed, it currently disregards
non-present pages entirely.)

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/mm/mmu.c | 39 +++++++++++++++++---
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index e7ca53d20b87..cb00e42abbe1 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -24,6 +24,7 @@
 #include <linux/mm.h>
 #include <linux/vmalloc.h>
 #include <linux/set_memory.h>
+#include <linux/suspend.h>
 #include <linux/kfence.h>
 #include <linux/pkeys.h>
 #include <linux/mm_inline.h>
@@ -1056,6 +1057,29 @@ static void __init __map_memblock(phys_addr_t start, phys_addr_t end,
 				 end - start, prot, early_pgtable_alloc, flags);
 }
 
+static void remap_linear_data_alias(bool unmap)
+{
+	set_memory_valid((unsigned long)lm_alias(__init_end),
+			 (unsigned long)(__bss_stop - __init_end) / PAGE_SIZE,
+			 !unmap);
+}
+
+static int arm64_hibernate_pm_notify(struct notifier_block *nb,
+				     unsigned long mode, void *unused)
+{
+	switch (mode) {
+	default:
+		break;
+	case PM_POST_HIBERNATION:
+		remap_linear_data_alias(true);
+		break;
+	case PM_HIBERNATION_PREPARE:
+		remap_linear_data_alias(false);
+		break;
+	}
+	return 0;
+}
+
 void __init mark_linear_text_alias_ro(void)
 {
 	/*
@@ -1064,6 +1088,16 @@ void __init mark_linear_text_alias_ro(void)
 	update_mapping_prot(__pa_symbol(_text), (unsigned long)lm_alias(_text),
 			    (unsigned long)__init_begin - (unsigned long)_text,
 			    PAGE_KERNEL_RO);
+
+	remap_linear_data_alias(true);
+
+	if (IS_ENABLED(CONFIG_HIBERNATION)) {
+		static struct notifier_block nb = {
+			.notifier_call = arm64_hibernate_pm_notify
+		};
+
+		register_pm_notifier(&nb);
+	}
 }
 
 #ifdef CONFIG_KFENCE
@@ -1189,11 +1223,6 @@ static void __init map_mem(void)
 		__map_memblock(start, end, pgprot_tagged(PAGE_KERNEL),
 			       flags);
 	}
-
-	/* Map the kernel data/bss read-only in the linear map */
-	__map_memblock(init_end, kernel_end, PAGE_KERNEL_RO, flags);
-	flush_tlb_kernel_range((unsigned long)lm_alias(__init_end),
-			       (unsigned long)lm_alias(__bss_stop));
 }
 
 void mark_rodata_ro(void)
-- 
2.54.0.794.g4f17f83d09-goog


