Return-Path: <linuxppc-dev+bounces-21738-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56B50CD6E50
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 May 2026 15:03:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gRmmr5nDTz3c58;
	Sat, 30 May 2026 01:02:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::549"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780066956;
	cv=none; b=bVgSGgTs506wqdIziand3lrgWF3VhVqye0tzrO/up3O07zXJDdSQ4ow5KuAIj6Uce5JxlTAHuJW3MvVd22qgdEqCAswNOQYpbmmcphEh8pyYA6Dh9rQ4c2GS1QvQI9C8huiZJm3sCOMgnT3jVJ9xvktHqc7UaRe83lULaJnFpgv3qR56hLE/D8k9584IMpuihgdd2RgPPkcfbxP3/cX8eg2S4eX0X+jVY51UNyBtfe9qjB0NRI9KUgA4myDiT0TeCYu2QhdEz6N5BfAgi2/NCuHyY30mAt2X6h6fp47LFTYNLRjOkjF3svmG2DL0maNofE05MZWCnliHPNLLNMOfJg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780066956; c=relaxed/relaxed;
	bh=1EyPAfNS2y6WG0YPoe21sR6PBixrZIgpxdj99NPdSN8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RROcdTDG/K2VKodj+BNBt1z6ziD3p3UhmovzF5ssEnx96nfgzcNqLapnHEwB1mLv/qqHj5HAcFe6F9pBqCzJIZjI9xqbXtSvsDr/uD9Qo7pu4/KsozLu7Of5HfBmR1Tiwqy5UoMGcTSbPbwAtK0i7mWwvu7bCqXfc3vYcslU3BNTgvaPdEETiP81VaAGG6x9DsHIxn0G5nuzVeJRiHghT/J1rQmtx0//7nOcqOBmeRrV/P8Uhfox7Qh04lWWYX1mjUaOq2eTNaYry/lkyWf+G/KlLiPf+pLrq4+UsmHyBDb2rXlDQFPeIVki3v5cg1lGJDXeT5PZbJg2WSMkj+9Yxg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=peqBtg79; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::549; helo=mail-ed1-x549.google.com; envelope-from=3ikozaggkdjs5m86+bdobjjbg9.7jhgdipskk7-89qgdnon.jug56n.jmb@flex--ardb.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=peqBtg79;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--ardb.bounces.google.com (client-ip=2a00:1450:4864:20::549; helo=mail-ed1-x549.google.com; envelope-from=3ikozaggkdjs5m86+bdobjjbg9.7jhgdipskk7-89qgdnon.jug56n.jmb@flex--ardb.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gRmmq5rPpz3c4M
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 May 2026 01:02:35 +1000 (AEST)
Received: by mail-ed1-x549.google.com with SMTP id 4fb4d7f45d1cf-68bd951b4bfso1150364a12.2
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2026 08:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780066953; x=1780671753; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1EyPAfNS2y6WG0YPoe21sR6PBixrZIgpxdj99NPdSN8=;
        b=peqBtg79Mawg6/gFxDLdgI0MnXV4lNsN1JDgdj55/ULAUAjB0aiIOrzClXlwRtBU+P
         XrPvd08sUwsz1/EYnBjR9tnII6eoGoIVVTmhcslASOzQafiPHWe0cKGqyv+MIVuKRYP5
         pLq5Jhr5+Y+rkv5AV+V8XZlm/Q3XAsc8kBoeDBYQEWHm3paKB5cSCH6GgP88I41TShUJ
         Zwm58LSay3/XDhqX8ylG+GIorCPz2BVBx7vGu0g58jgDoPHck4hMkOVfbK1k5hxQQzDY
         rKehCyai+xedArJJb4t/cA4mem/fNNmgzO0lo/uAifBOaVBee3mek4hHL2H+K8X31u+L
         Al4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780066953; x=1780671753;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1EyPAfNS2y6WG0YPoe21sR6PBixrZIgpxdj99NPdSN8=;
        b=Ph7dofh6Om7HCl5q9HE4GA4zsqtBvAQCryEL4Uotbe2F+9D+Vf18udhkQHP+4MYn94
         jZDBZyHoEdfBCgPFAa3dzlzUB7lEGc0Bh0SgOEiWRJRMLXVjlu20yPkf5LNAHBe6RXfr
         77vXAFnBEjoZgrHOpLU4z719hPdGOoJY0K/EvjUvVFK82FCp7jYDwbuDKdBqPGPXlsiw
         Jj0nrdpBZ1GCI7g8d3zrxFHgITRhF5NKGoddaleB66hhXDU/qCVKjcvlD0BChurBTSYa
         /MI+VCK7npo1BX7tI+h/stl+gZPQmsmKOQvc4pPXa8lS1CGLX0yqfGsDpD1TCSYx9OLh
         QpDQ==
X-Forwarded-Encrypted: i=1; AFNElJ+L7xG3oDOFL4Xeh4cNKvFwbNJU3SRNlZlcS6EzC2AEEH5IapaTm6fxKlWmol+xQKmHoRkdpgWujkvoVzc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzlSLDW+W1/6D0B/nzW7CAcijIq11SYz+BXhEt6SAHcdW/lNwy7
	21Tvfud8b9sIYH1qjCOUFWdZ0YC5BDlXhaEwr1TQSf9/vP++ylvqOjfhwKTWd+xTGC2bUn0OoQ=
	=
X-Received: from edpg3.prod.google.com ([2002:aa7:d1c3:0:b0:68b:f715:5345])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:a29b:10b0:683:be46:c20c
 with SMTP id 4fb4d7f45d1cf-68c8a65763dmr15813a12.16.1780066952419; Fri, 29
 May 2026 08:02:32 -0700 (PDT)
Date: Fri, 29 May 2026 17:02:03 +0200
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1322; i=ardb@kernel.org;
 h=from:subject; bh=4saoJOhT3cEc7dpWXJZksxFCf7gWJDz5CDZcsy0RHE0=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIUtyVe4Vpn2a3EuL7z5c9yPshq/FTf8NSmKzXz68s33ZB
 ld1mYh7HaUsDGJcDLJiiiwCs/++23l6olSt8yxZmDmsTCBDGLg4BWAibDIM/2u5Yv7kFfP5v2Ww
 OfqOx3NBpOKey7t5vhR6LI5Y9SY78z3D/5SO1Jh354yPPvIQfsjEWFAfIL3vxawn2VI8ya8XJ21 dxwwA
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529150150.1670604-29-ardb+git@google.com>
Subject: [PATCH v7 12/15] sh: Drop cache flush of the zero page at boot
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com, 
	mark.rutland@arm.com, Ard Biesheuvel <ardb@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, 
	Liz Prucka <lizprucka@google.com>, Seth Jenkins <sethjenkins@google.com>, 
	Kees Cook <kees@kernel.org>, Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-sh@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

SuperH performs cache maintenance on the zero page during boot,
presumably because before commit

  6215d9f4470f ("arch, mm: consolidate empty_zero_page")

the zero page did double duty as a boot params region, and was cleared
separately, as it was not part of BSS. The memset() in question was
dropped by that commit, but the __flush_wback_region() call remained.

As empty_zero_page[] has been moved to BSS, it can be treated as any
other BSS memory, and so the cache flush can be dropped.

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/sh/mm/init.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
index 4e40d5e96be9..110308bdef01 100644
--- a/arch/sh/mm/init.c
+++ b/arch/sh/mm/init.c
@@ -331,9 +331,6 @@ void __init mem_init(void)
 	/* Set this up early, so we can take care of the zero page */
 	cpu_cache_init();
 
-	/* clear the zero-page */
-	__flush_wback_region(empty_zero_page, PAGE_SIZE);
-
 	vsyscall_init();
 
 	pr_info("virtual kernel memory layout:\n"
-- 
2.54.0.823.g6e5bcc1fc9-goog


