Return-Path: <linuxppc-dev+bounces-21538-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB7CBCD5BD5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 May 2026 22:43:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gQ78D4rMtz2y8W;
	Wed, 27 May 2026 08:43:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::349"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779818371;
	cv=none; b=BAgnxgRglEck2SSHicQn5gJFdqpp/AuX3FdxreNt2psa1QtIZSTiM95tZCR0CPu72mG+3xmCadd1CeYgD0t+tNOxWntyVTQdW0sqO7gE5DtHVt2MpvJi9aoN1YXk31U9/zTnXclzYFzPH30BvMWkz2RNVQpkLUHltSdw7diw+h/mnu0QgSLvdB56A0ahyUQ5NVvIqg8Itt6RUTT+WQ8XWXR0PsipiTjdqAoG51gm7K5T/tcuyP/TNshGoYVV/bNhR/r8WHhZx0o7hcrpT1V4usVwZEUZaLhfSmQED0IiANcGevd7QFVCc/5+M23BcdJF1SkU1vy48v8Awd4IqSJLwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779818371; c=relaxed/relaxed;
	bh=cNZ6xElfqK3A4SE3F9P829uWscll1GihYVBHckeq6A0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mt1lobXnBo47lKGMmWxG7BL6h7ya0EtHHzCU0ZcdD0tSqXVKLoM0T4zjkK22veeIUYoG4WAkf1s2Ao7S8p5hXl6NJhJl1HsbXj3sI5wPeJv23q7zl6oUI2vAlwtZdE+kjOBDPd+CiXyk/nhqEZe53VSUDlB6sw3Nkd15rBTCvsT+Ca3RdbVzyvX5LsdylEs9J2vzyHdqSZeqLLU3UmuOWc1uM0KHJ74H5cgAiAKSoi3MfUP+scm94iTwuQnxywgLTzJxCW1Ro2SWqlXxdOtO4E48ia4pV63XN5HWwKa/FoAN6d8RohSx+DiTp5wTgI8W7iiuJi2w5UlsHRjbElR9mQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=qE/8/NgQ; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::349; helo=mail-wm1-x349.google.com; envelope-from=3f98vaggkdowofrp+uwhuccuzs.qcazwbilddq-rsjzwghg.cnzopg.cfu@flex--ardb.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=qE/8/NgQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--ardb.bounces.google.com (client-ip=2a00:1450:4864:20::349; helo=mail-wm1-x349.google.com; envelope-from=3f98vaggkdowofrp+uwhuccuzs.qcazwbilddq-rsjzwghg.cnzopg.cfu@flex--ardb.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gQ0rM13Npz2xS2
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2026 03:59:31 +1000 (AEST)
Received: by mail-wm1-x349.google.com with SMTP id 5b1f17b1804b1-48e79219704so75297345e9.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2026 10:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779818368; x=1780423168; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cNZ6xElfqK3A4SE3F9P829uWscll1GihYVBHckeq6A0=;
        b=qE/8/NgQUT3qhnlmbp6452SfziXaxwRt/tyBx8Q/h/FL/ByFHyNSTRg2U/EUrLsKBN
         Jb1Yf4BFa9w433kPjg9y/QG/J2KucD7Pt3hl9o6C/WTBiYAxHWauJZonSo5cUeO6w/M1
         z8vcKysyW1T+qL/hERGKmpQvu9TBCON5kbvC4Y3vlUWaM50YzzZW7owNa5EyU4te2uZA
         dJutyYu3JpZTch6T/mVc3gH6SZ4gkoLJDUiBYhIQ0V7++EGU1E/ODt6krofQTn7R/8qi
         Y/z3mmYEHfpsAUqODirM0OeLilJQtyCzx8Gh6pyKsJ5DNl9foPkgw24ECeT2CXI7swdb
         jCxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779818368; x=1780423168;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cNZ6xElfqK3A4SE3F9P829uWscll1GihYVBHckeq6A0=;
        b=GWiHDhTA/ckVQFKfzNe7Eulj4a9ve4P/4sM+BUB5GGpSGMv6J1VsWF0DyOFIg5nhX0
         OVAO+v3pN8sMRe4mGtry31/Mt/jKthLQnjip4SPTtM4peTtsyN4GBbMwQIpTOQNSMCAE
         ljOmNU2c3T4QharbJSOD1o4nqOUdtBGprZvddqA535zSt7XKWgmzEYx6FBeKtOXcMybK
         KFE3+ow5ta5d0Ul+JADLs58S93l43m21ZahyWlZFS0VjzQDeYwKoWtudA7xAn6ltWpHu
         n5byqfSnmccK813S1ARaDC5uS2ombEoY8Q9TPaiupjj7pWhK9fhJkA8B+oAaIBIGN2Ts
         RKKQ==
X-Forwarded-Encrypted: i=1; AFNElJ+C5jtc/YiO9ZvPROflBVJEBHdakVT6/8y8d1wMnjyloqoFu7MBCJHQp3w0Dzc+nPk/7u1t2SA96LeVDPU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yyv7zm0QT9Uertr1k4AbIxgReWsFWggWbVEmviuqUDHkIauuLiV
	r73Pnf2Fxk77t5ytl8aX0GGceH5cZEJ0wArdxXTm8TRB4rqVlj9JGfssQRb1ZXcIPT1CcNSHDQ=
	=
X-Received: from wmbje7.prod.google.com ([2002:a05:600c:1f87:b0:48a:5970:2007])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:3b97:b0:490:52fb:12dd
 with SMTP id 5b1f17b1804b1-49052fb14fdmr292012705e9.10.1779818367951; Tue, 26
 May 2026 10:59:27 -0700 (PDT)
Date: Tue, 26 May 2026 19:58:53 +0200
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1543; i=ardb@kernel.org;
 h=from:subject; bh=0Wnsvtw0Z2vu8jTM+plTHkuWXyq+RnVgc0hID3nHEQ0=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIUv0fnxSZsWx12f761qXqC0qS65U2ZVyr3Slf87jmSwTV
 KRvvbncUcrCIMbFICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACbSLsjIsFvkWXjX0hVFJxZW
 Ldt97vPXdU3PRc8XH9GZ8UZlg9pB7T+MDA9i+Q/xn5Hz+Zl1U29m5LMYieUfPCfvSXROOpI/3bA ngBUA
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260526175846.2694125-23-ardb+git@google.com>
Subject: [PATCH v6 06/15] arm64: mm: Permit contiguous descriptors to be manipulated
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
2.54.0.794.g4f17f83d09-goog


