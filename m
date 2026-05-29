Return-Path: <linuxppc-dev+bounces-21741-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9D7CCD6E4A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 May 2026 15:04:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gRmmw27rTz3c98;
	Sat, 30 May 2026 01:02:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::349"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780066960;
	cv=none; b=c61kxhdzwZiv35j3uubpd9/M4cbJi8FYGECsVsynVjqvi6NwY53aeC+AKehYDMkOKJ6EbnCYrD6TZiDo0NwB6Ig1XP549kFQ10qr7v8SMjGhyGRBkHi/zKbrmByG5gCaP/3EGcA0VvQzr9kk7IlOAdZp9qAnCGf8ooOsA+6g8VX/fTwVeBgQMT0uXZZZy+1k3l0YCkjrDHb6YZQa4fFtdjU/WY5mMkh2pB/oLkaWhG/9pQX8THLkq7vw6YKbC7YsnTh/woh9Z4xai1C8p+IitM7bHp5DpVzvJw0AE+R4XXKxLilxqLczDWMQFMK7eAPiYxN5tm78RTqS/75PLTlRnw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780066960; c=relaxed/relaxed;
	bh=XQKx64xQcW6ZDY2ZWUkqEvIbYSGgY2Fsos5YN6YfoOU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZQaVxLuAr4llql3KvW5v4kpI2yLBRehhuqkvrU/GHCfha3yhLHyrcvWQtK3HrmKrUpH2ttVyKVhSvmldELpV/mFlWD0hQqUAAPwHlD3jeQMEhhZfCYiw8bRDD1gdAtqy52480oC5HsKWMyIUi9gSMjWweSaM77lMTYiEBh/j/bor7zHUN+OXLqVbH5QN212jhWSe7NL+nAZXSZeMF90o4tAH5ItsxFVSUesna2ScCIB/uUI7LnALP9kz9Db9wAUFt8zua3GhGbno9RmTgzx0f+ZyyfMOurGEPJThu+dpt37MDuCWbg9xBaRw97hyuq45yn9zW6no2Jpo6sm/E8WB9g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=h5jXnH0v; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::349; helo=mail-wm1-x349.google.com; envelope-from=3jkozaggkdj89qca+fhsfnnfkd.bnlkhmtwoob-cdukhrsr.nyk9ar.nqf@flex--ardb.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=h5jXnH0v;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--ardb.bounces.google.com (client-ip=2a00:1450:4864:20::349; helo=mail-wm1-x349.google.com; envelope-from=3jkozaggkdj89qca+fhsfnnfkd.bnlkhmtwoob-cdukhrsr.nyk9ar.nqf@flex--ardb.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gRmmv2D2Pz3c88
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 May 2026 01:02:39 +1000 (AEST)
Received: by mail-wm1-x349.google.com with SMTP id 5b1f17b1804b1-4904ee02e72so60809535e9.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2026 08:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780066956; x=1780671756; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XQKx64xQcW6ZDY2ZWUkqEvIbYSGgY2Fsos5YN6YfoOU=;
        b=h5jXnH0vNbffd0ZYOt8S0HIe3ilVmjX585C4PP9UrovWyFoOFai+QI1NQ8UPEVJU+a
         2e3UR+9XjFndUiJ6wCsYpkAiGZauQLp5fPi4EippJMwjrQPVGW4L98gfTu6dYJeYTkTg
         DINzECWnK71wEWGZPUYA7ZPZJ6gRPM1VHrgotSYRRjo8uCz1TNJZGYMjJHPGNfHplSu+
         cIBT+OSl08yDubMO0nWEsXt84WuLvBR1mFcGXjKCqDoDpZxLKg7k2A3psM6oHgM9Onym
         eYVRgC7Oe4XoOcNdujHwGeBsX05wDi4/jlW6xuMqRrpesEzdaa5/Yrp+3e3R8fQ8Fd8R
         iJFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780066956; x=1780671756;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XQKx64xQcW6ZDY2ZWUkqEvIbYSGgY2Fsos5YN6YfoOU=;
        b=VNKveu603N4+oIr5ivNoFhewfVII+Ce9SA//Oo9bWdwSRYz7Tk7t/A3k443xaOBSdc
         vBYUsJmQzVGRsI19h6IB7nUtac4m+i8snwbq/Hx8XUoDoPM97TdD6xy3f54rQ/pzXj5h
         Ts6zsUC3WyiLTx154xSHq24bmfmK2r/PnuThXTeMVv9E0fbstFsJeBRrdJNGZuMBf2/u
         zK4UEdxJG1inGy58d6qXkpjIbO3u88He9oEuSWogPbzDYIkptekrXG/7el6xwh2vOHuE
         NvwGYURgFahGuEbcjpIHySpD4QYqYWpIj7Z28B6/DboY7qE88OrPvcKJLra1ZZ8WEBBm
         2KLg==
X-Forwarded-Encrypted: i=1; AFNElJ8cPwRIIjx4k9UBDAJerOdyfCoTL/LGTtzlTtwG9qKxrW9RtyCLwBBeQtGB9pCPxSsW+x2zlyvwCQe3CKM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx/HlgIcnHWkPaqzIARAejP02M3xxjV1tygxPVTfeymI5gZdYJX
	77jxO6qzAO+NBtCEHHLyEaX1ABcRrwPm29yrYPvR2rlN9xBoqFMfQjFQsVYiUPzyw9K5VOybCQ=
	=
X-Received: from wmbez9.prod.google.com ([2002:a05:600c:83c9:b0:48f:e3fc:d858])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:4fd6:b0:490:5655:8d3f
 with SMTP id 5b1f17b1804b1-4909c0ed167mr56446625e9.28.1780066956218; Fri, 29
 May 2026 08:02:36 -0700 (PDT)
Date: Fri, 29 May 2026 17:02:06 +0200
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3406; i=ardb@kernel.org;
 h=from:subject; bh=XSavLFKj4RYiFTOsx9dpbIASgaMnJejevEPNl4lZqhM=;
 b=kA0DAAoWMG4JVi59LVwByyZiAGoZqnCghcJA5fPW2Z72X9X37eu+fqYYMOTvKUc5VemCkE+q7
 oh1BAAWCgAdFiEEEJv97rnLkRp9Q5odMG4JVi59LVwFAmoZqnAACgkQMG4JVi59LVy8pQEA6HlB
 3WUW3N8HA9+DidOWBYQI1frKFGwVYEQ7O27c8DUBAJEH2JVQ9ldiz63/YvZsdSlPfdvNDLvL7Jf SNW10NGsD
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529150150.1670604-32-ardb+git@google.com>
Subject: [PATCH v7 15/15] arm64: mm: Unmap kernel data/bss entirely from the
 linear map
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

The linear aliases of the kernel text and rodata are also mapped
read-only in the linear map. Given that the contents of these regions
are mostly identical to the version in the loadable image, mapping them
read-only and leaving their contents visible is a reasonable hardening
measure.

Data and bss, however, are now also mapped read-only but the contents of
these regions are more likely to contain data that we'd rather not leak.
So let's unmap these entirely in the linear map when the kernel is
running normally.

When going into hibernation or waking up from it, these regions need to
be mapped, so map the region initially, and toggle the valid bit so
map/unmap the region as needed.

Doing so is required because pages covering the kernel image are marked
as PageReserved, and therefore disregarded for snapshotting by the
hibernate logic unless they are mapped.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/mm/mmu.c | 45 ++++++++++++++++++--
 1 file changed, 41 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 7b18dc2f1721..07a6fa210171 100644
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
 
+static void mark_linear_data_alias_valid(bool valid)
+{
+	set_memory_valid((unsigned long)lm_alias(__init_end),
+			 (unsigned long)(__bss_stop - __init_end) / PAGE_SIZE,
+			 valid);
+}
+
+static int arm64_hibernate_pm_notify(struct notifier_block *nb,
+				     unsigned long mode, void *unused)
+{
+	switch (mode) {
+	default:
+		break;
+	case PM_POST_HIBERNATION:
+		mark_linear_data_alias_valid(false);
+		break;
+	case PM_HIBERNATION_PREPARE:
+		mark_linear_data_alias_valid(true);
+		break;
+	}
+	return 0;
+}
+
 void __init mark_linear_text_alias_ro(void)
 {
 	/*
@@ -1064,6 +1088,21 @@ void __init mark_linear_text_alias_ro(void)
 	update_mapping_prot(__pa_symbol(_text), (unsigned long)lm_alias(_text),
 			    (unsigned long)__init_begin - (unsigned long)_text,
 			    PAGE_KERNEL_RO);
+
+	/*
+	 * Register a PM notifier to remap the linear alias of data/bss as
+	 * valid read-only before hibernation. This is needed because the
+	 * snapshot logic disregards PageReserved pages (such as the ones
+	 * covering the kernel image) unless they are mapped in the linear
+	 * map.
+	 */
+	if (IS_ENABLED(CONFIG_HIBERNATION)) {
+		static struct notifier_block nb = {
+			.notifier_call = arm64_hibernate_pm_notify
+		};
+
+		register_pm_notifier(&nb);
+	}
 }
 
 #ifdef CONFIG_KFENCE
@@ -1193,10 +1232,8 @@ static void __init map_mem(void)
 			       flags);
 	}
 
-	/* Map the kernel data/bss read-only in the linear map */
-	__map_memblock(init_end, kernel_end, PAGE_KERNEL_RO, flags);
-	flush_tlb_kernel_range((unsigned long)lm_alias(__init_end),
-			       (unsigned long)lm_alias(__bss_stop));
+	/* Map the kernel data/bss as invalid in the linear map */
+	mark_linear_data_alias_valid(false);
 }
 
 void mark_rodata_ro(void)
-- 
2.54.0.823.g6e5bcc1fc9-goog


