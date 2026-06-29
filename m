Return-Path: <linuxppc-dev+bounces-23120-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBE44C43458
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Jun 2026 16:38:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gpsR26zgFz2yH4;
	Tue, 30 Jun 2026 02:38:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::432"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782751102;
	cv=none; b=FGwQ15Hsv57kPG6QXCWuBGnHs8PkfkQipLB0m6rOnz1f4MZwd5UP9S9T6T1DP+myv5FZgGwyxZSUH96eGQYHZnAHbQdtBSjE8xTRUImrSfVjTph8X3CjIv2Rn6u4qHzfeCMFl3wluoAj3HsaouWGcU0RbQ17oZKKAoFII9arEiQGBUyy1ICEJGIh6wggkLsRZERNkBcBXqHwRNvdFRXlgbkHZsthPlOpAfp1TKa0tE5EIsUvzSmpha54wCzHdd2p/ZVwFcbqOHdHv/EWZMRilIsWIRFCFBKlx9AB1hxD6dKw2Aq66YfkYgQeQh8modx7wLZfxC8ET9x6tTlukF2jrg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782751102; c=relaxed/relaxed;
	bh=PPX10qsMY++ER8afXSJu3F27jyGSgCeFMlyZg3pCc1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wyl3l5X5b+XkDDG7qLogQdpaFdr7kjOqoIJGP/pURfvVwnejlubQckARmo7bpQDkbdkEwnt4ocknULm9HXJeuSe7frFtCl2bVMlWBjQVWtuIkR6/oGqTaOulfdazxwe06L/ImveAW62SNNxtOxU11KXAyy0/9+xjPJ1USy3slS7oBY6mu2yui8ydnwKeHw5j9guHaVmXBSW3W5rItrRd9PQDraCK9zNqV5hlFThyUzmwI5fLqEWHfHr+JcCpuaJ4nUGrQa8yJ9ZcpYDLEn0t15q1GKEtHsACWs98+91Gi6sh8YNQbtybbMdcb2Wt3eG7MJ6cobUj7wTwbXJzXj7xqA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NkMnpVEm; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::432; helo=mail-pf1-x432.google.com; envelope-from=ekffu200098@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NkMnpVEm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::432; helo=mail-pf1-x432.google.com; envelope-from=ekffu200098@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gpsR20rbwz2xYh
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jun 2026 02:38:22 +1000 (AEST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-845b965c1c4so1763308b3a.3
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2026 09:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782751100; x=1783355900; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PPX10qsMY++ER8afXSJu3F27jyGSgCeFMlyZg3pCc1s=;
        b=NkMnpVEmrPadDslWTLneWQMYEEDLTdLtYW7Kb5R5UKzPkNGH4tH3QUh58OKd9oGXQN
         egYH8sMIh4nr0EnV1eFn5PK5iAqywUBE1nipZvFnwbsJw+rtjFSWLldwWMPNWtZiJqCY
         69uu4WFuJvdcJZUNKB1rnWH3VXFfTcaUXWb/v6vighfbxkGjKlH0Y9/4kbyx4vWNV8e4
         b4QKEg76ulmGOGnpvTJ7gENStPKsBPESLdc+caA4iO4ZB19LciqBnYLuLDKRp1PVenWh
         AC2nB6QZAapsGykJRDaP+dFtkTqHHL+IW3u07RbU13LcdODUesXU8Vn38RI2wjYCCsuh
         MnHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782751100; x=1783355900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PPX10qsMY++ER8afXSJu3F27jyGSgCeFMlyZg3pCc1s=;
        b=H8fNDRrR3nvm4r52t7vjekn4c6aJv7kMnZumn7MI3w77J11NjHbqZ/XFSM7kwmCLwr
         2zsZS0JHS2MePp+ev7qs8FD/UpdzB+9cEZaOAoiz/Z5z3P17yLsWmdr3r+1HZAqM/xpG
         mqwkFPFY/KgscqirCeVWAkt6yF+XbgfIYvAl8Brb2k6j3eu67tqqZNW3ze3sUzUfsw//
         J9CPEQ8M/aqKsbo8waZ/U+L1HAFWc9mtc9yzO5n42hXEBEnilTWCxbvvH0eWBEr2dolP
         hNfxSLmyDgIm7+UkMeZSQAw7HWKIoORYTRERw5G9lhP8c8EbEL961isDHNVKoGxntzv4
         wIcA==
X-Forwarded-Encrypted: i=1; AHgh+Rp4Tf4GrLlqZ7ZoCVE8ZeiMr/v2DhxLv0qvkWf3wLdb5ZoCiEnJRXttiuEfdYJDR5XaeZzDWh/oixrX4cw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy5EFm8AzAVZpk+K2lkyq6oPrzciJr8rzWJHNUJNQyVG/cdW0bM
	WdA6Cl2e5/976KPxBfX2vljdivuTUgc9PZ8sRAFv4z2RERh3DLVNj4Bj
X-Gm-Gg: AfdE7cnQSvfymB5Ib4MGd7zTdQjqIez0efhx2uXHnVLqafBxTYUB5+UslNYlaQ2rUyv
	3iCiRpjcORzAqH4SLLrqaxXllVrhaMaNV5mtaeseqyZDUdzuuKWhnnVRcxU5NBXiPFDdn/zQWIz
	SHT7/h1X7NtBfUhgMCssisMQXJUM7wPWPIKa+/YiylDcEim/e8ma9sdwjxj6GAxdX4csDQ/ScEl
	G+5IYnMaSgbF7vvXXzx7vFC9TSosMATMPYF6XJ2od5PxmyK4TuqfJIv6j/ZihC4mZFOzKUvWOcW
	7R3B49B3xu71Xc0t7+3yhtFHQyGvz6abcfYCML6GFsUD054Plq9NsyOnQS5bZ21jDkxOoqQWnIh
	eAnIS7XhzRZY2/cgF6srobcaQydRQuAr4a3HceWY8AynHvozpWc2kS9slZbdUQw7LlBvXRI3cV3
	RTw5phpAQ=
X-Received: by 2002:a05:6a00:190c:b0:842:4b88:20ee with SMTP id d2e1a72fcca58-8479f26c18dmr215091b3a.44.1782751100331;
        Mon, 29 Jun 2026 09:38:20 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847a02d41c0sm18474b3a.33.2026.06.29.09.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 09:38:19 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: rppt@kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-mm@kvack.org,
	Sang-Heon Jeon <ekffu200098@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v2 6/8] powerpc64/kasan: Remove unreachable invalid range check in kasan_init_phys_region()
Date: Tue, 30 Jun 2026 01:37:34 +0900
Message-ID: <20260629163736.1606688-7-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629163736.1606688-1-ekffu200098@gmail.com>
References: <20260629163736.1606688-1-ekffu200098@gmail.com>
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
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kasan_init() maps each memblock region with for_each_mem_range() and passes
it to kasan_init_phys_region(), which does nothing when start >= end.
for_each_mem_range() never returns an invalid range, so start < end always.

Therefore the start >= end check is unreachable, so remove it.

No functional change.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 arch/powerpc/mm/kasan/init_book3e_64.c | 3 ---
 arch/powerpc/mm/kasan/init_book3s_64.c | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/arch/powerpc/mm/kasan/init_book3e_64.c b/arch/powerpc/mm/kasan/init_book3e_64.c
index 0d3a73d6d4b0..0ed372fb8b09 100644
--- a/arch/powerpc/mm/kasan/init_book3e_64.c
+++ b/arch/powerpc/mm/kasan/init_book3e_64.c
@@ -68,9 +68,6 @@ static void __init kasan_init_phys_region(void *start, void *end)
 	unsigned long k_start, k_end, k_cur;
 	void *va;
 
-	if (start >= end)
-		return;
-
 	k_start = ALIGN_DOWN((unsigned long)kasan_mem_to_shadow(start), PAGE_SIZE);
 	k_end = ALIGN((unsigned long)kasan_mem_to_shadow(end), PAGE_SIZE);
 
diff --git a/arch/powerpc/mm/kasan/init_book3s_64.c b/arch/powerpc/mm/kasan/init_book3s_64.c
index dcafa641804c..ccfbfb894637 100644
--- a/arch/powerpc/mm/kasan/init_book3s_64.c
+++ b/arch/powerpc/mm/kasan/init_book3s_64.c
@@ -24,9 +24,6 @@ static void __init kasan_init_phys_region(void *start, void *end)
 	unsigned long k_start, k_end, k_cur;
 	void *va;
 
-	if (start >= end)
-		return;
-
 	k_start = ALIGN_DOWN((unsigned long)kasan_mem_to_shadow(start), PAGE_SIZE);
 	k_end = ALIGN((unsigned long)kasan_mem_to_shadow(end), PAGE_SIZE);
 
-- 
2.43.0


