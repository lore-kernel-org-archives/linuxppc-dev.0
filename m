Return-Path: <linuxppc-dev+bounces-21533-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 249B3CD5BD5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 May 2026 22:42:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gQ77G64dsz2ydq;
	Wed, 27 May 2026 08:42:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::34a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779818368;
	cv=none; b=YRLWjJT3iiKzrk/fc22MKsA26l2iXZ8R9q9LFSDO7pqM4/MGaBR6OgdA9YclAdzPvnFv6MCxNqkcFkiS0Jm6A5rAbKW6rSL/4NRZJSeI+bxce91qJh5bel4nks2BgTc7nkUdgyXhE7Q/aSqG5i/EUQuu6zmc4I6rOYKa+sBYO8dfyEYBbAUs/p9W8QGCRzjsH+XRIyzYCZBnEqOlfWlPcV/LLERgZCy5aHVDLKK/90g4ls6JzZY5BmGBwop3gTpoHEP5YHd806dW852OUS0rHxajXcbfWJhMgCJhLWauNFjEkQCnMV6dkj3rXKxStyLHMb8ihAB92XWxtERNTOLSDg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779818368; c=relaxed/relaxed;
	bh=+RFflol+bsWEcr4KlK98zfj4SqOIgycSAYTOMgzlgw0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HMmN2nA+BgQGP0Go2uzoDMo+4cQe7CvMqpl0qsmP5VnQbcLJdW/evBvZhDZaWpFuRO1uqSkHhouWVy/MLkRhhTXkfhhQ1IIvxhFQP6atpqM+6LgXdqlp/doaEbJdaQ64oNE41ToT4pLxCmfSWtUvjb0tUIaT+ZGSFR+xQFTA4G4/iNzfB61bfvEen9vwwMVGu+4iudFFyW0oXjvDxkBYG2PDbyAJ9luHplBau9vXUHXNdxMyFTk5fGjT2ISySDI+FTuaG1RZPH+8SKNMbqh8ub6L9gkkjwCJJpV3nt1mIUrQ+MVBxhIe8z9OgYYkrgwDjOFzOkvWSPo3OVUBADAAPA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=nO8i9jhb; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::34a; helo=mail-wm1-x34a.google.com; envelope-from=3ed8vaggkdoyizlj+oqbowwotm.kwutqvcfxxk-lmdtqaba.whtija.wzo@flex--ardb.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=nO8i9jhb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--ardb.bounces.google.com (client-ip=2a00:1450:4864:20::34a; helo=mail-wm1-x34a.google.com; envelope-from=3ed8vaggkdoyizlj+oqbowwotm.kwutqvcfxxk-lmdtqaba.whtija.wzo@flex--ardb.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gQ0rG5RPSz2xS2
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2026 03:59:26 +1000 (AEST)
Received: by mail-wm1-x34a.google.com with SMTP id 5b1f17b1804b1-490261c79fcso37463295e9.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2026 10:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779818362; x=1780423162; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+RFflol+bsWEcr4KlK98zfj4SqOIgycSAYTOMgzlgw0=;
        b=nO8i9jhbPEZj2dqgMPr1V/QB83rINNZMtWFi0E3WADQ4yLcN+GHTem2SbQiAHnUa2b
         vqpjBBpGA0P6GUa3nT2DqyiLO4xeXqh36HAF1+AQ0NDhtopUnHlEK911SGtUDDHxxR5d
         J60m65Ft1/ADD3tr3a1AGrEVH105485r8EKvDB5YxxmIF6Fm8IjDN+OqLLikWB/vvGLy
         5Qo0SApkWWIE41sgaldJ5AtRrCyGfdopqzob3zGxoOVkgDjDk7LdtHc4JleHZxK4hvQB
         Cmcjne/GZkwuh7gRz3nNpJgljZg4k6a+PpD8qQmTEdTOkPrGaQxgEjC4uQlVo3ttmCNv
         qqTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779818362; x=1780423162;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+RFflol+bsWEcr4KlK98zfj4SqOIgycSAYTOMgzlgw0=;
        b=BTxmHE1tZLgv9ri5hZ853DQa+nXg559r5pZzxt8qIDh6SH3xVNMrvIbI5gtfXC2Bvf
         3EIEMQGDeU8QPUVdCYAkqISCWvaxQ8w6TtFfMCZON0dh/PyR5NJIEWMHJF00dID4klfX
         OswTubO/QKmPLWnE5PHz4sRqHhK7qPcqunc0LYAGFqrft5pwqOXLtSO+w6pR5NunUMXK
         755rEHkeHTmug4fPs2D4cZV6jmDDRXgEBsaAmvrj5l2Fff+j6v+9WzYnGcG5/bTbOtFc
         JLGw2UrVC9M6rf3SlA5ZaPddilq3StvN4SP+/Stsb2IriEUScCzFJSpzgdKkWqxVSrj0
         Az1Q==
X-Forwarded-Encrypted: i=1; AFNElJ9YqHtGNiWycInC7Mnx34fNI71IUcwPsiRazqrt3H+G2A0fvbluFkSU5+GXYHZ4b4348E/BuGi7dZZAu8c=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzwmU7UT8pTJQry4aWumGbTAe3TNaml4W9DUqfUfalpMrGaYUkF
	N23NmNzTj808OeTmpPZr+zbKGhQby9TDFKTczAz7XKgopkhgWcVYLZRnNpP6hHI9hgu3lsnbKA=
	=
X-Received: from wmgb20.prod.google.com ([2002:a05:600c:1514:b0:48f:de5b:469b])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:8599:b0:48f:e230:29f4
 with SMTP id 5b1f17b1804b1-490426ade02mr205371775e9.15.1779818361151; Tue, 26
 May 2026 10:59:21 -0700 (PDT)
Date: Tue, 26 May 2026 19:58:48 +0200
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1021; i=ardb@kernel.org;
 h=from:subject; bh=Kh7cxWXkNrSTDvznUsNThby14Lf6cpInZSVAIOoSUVU=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIUv0fsQvk8viPq9V2vx6dMWennJ+dkQqIjT+cV/VLZF1b
 R7nhSZ2lLIwiHExyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgImsLWZk2HK0ii1yonQZe7ZV
 +ApXXrWOD0eLlqwV53zN/y7vkpHmYUaGZx8+meyLTM/2WSaWZW95P1zc+UOGxrXah+2Pw7MWVjW xAgA=
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260526175846.2694125-18-ardb+git@google.com>
Subject: [PATCH v6 01/15] arm64: mm: Remove bogus stop condition from
 map_mem() loop
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com, 
	mark.rutland@arm.com, Ard Biesheuvel <ardb@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Liz Prucka <lizprucka@google.com>, 
	Seth Jenkins <sethjenkins@google.com>, Kees Cook <kees@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-sh@vger.kernel.org, Kevin Brodsky <kevin.brodsky@arm.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The memblock API guarantees that start is not greater than or equal to
end, so there is no need to test it. And if it were, it is doubtful that
breaking out of the loop would be a reasonable course of action here
(rather than attempting to map the remaining regions)

So let's drop this check.

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/mm/mmu.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index dd85e093ffdb..112fa4a3b0eb 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1173,8 +1173,6 @@ static void __init map_mem(pgd_t *pgdp)
 
 	/* map all the memory banks */
 	for_each_mem_range(i, &start, &end) {
-		if (start >= end)
-			break;
 		/*
 		 * The linear map must allow allocation tags reading/writing
 		 * if MTE is present. Otherwise, it has the same attributes as
-- 
2.54.0.794.g4f17f83d09-goog


