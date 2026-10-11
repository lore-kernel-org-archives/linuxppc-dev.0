Return-Path: <linuxppc-dev+bounces-29198-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD90ACA9EBD
	for <linuxppc-dev@archiver.kernel.org>; Sun, 11 Oct 2026 19:58:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j2rxH6nGDz3br2;
	Mon, 12 Oct 2026 06:57:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::633"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791748675;
	cv=none; b=mXG0xe95M+h7avGkVlYoaO7uO/fm0P6gqBy5PokgTlHYHblSb0BidqQ+TQ1p4c2m/JUlQ5Tch1dRxOtTm2Z/SgYN2VdCIzqs80hZUj59FO1KRZ+mmSYWXL2ujmUlBJ3uqFRc+5RwGKT8RPX/14CckP8dtqKEGV7aBU3UxI4XAs6dBfWTq1fV4Kz9l3Zc3pfBrQG9W2j/hObXZanb2EmGVovqDwZsscqK3SEdSqiTKz4zBSV0AV1t3vp4zYRMxdSoUk3QXpV+x8nPTaiiol+A2U29aVT4wHSKM7aJcaMXKf4UbPr3YuT2t31rkNs4a6xk7lQ1GYuAqd/nQ48YKYptuA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791748675; c=relaxed/relaxed;
	bh=ey4LJMK8RV+MV7vSZrPUmikamurNbFQxbI2le0bK+bM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b9zqm05a2eJ3kgmGxIUQ/hzBb9VgEv+Ui5ltGdKswH/StRSppyJb3oa5TmTUUpda1zXn5PYLEKJv6G3OpT8t+mJbYweuYe+NWd0t7ZAaxsjMUkBqwV+Btug7YtAzSLl0m8AEVE9hGUG3pnI2uMtzEl07UAhpdGBwWk+15uUIuktv8biC1fujx2lBK3mfLu30UwJLL1xuHFcKP6ThwxngtjtPUhjHOVUD94zOTNgRXSeNhFS9EhD//D4ZgoFWUb4fQx617lGrj3Sdj9+GYdHzpHOJ/Er2k6U4DH20SlETuNblq6oJFPDQ8K2ErNZW3f7uiz48vlFVskBI+HdlRgYqmA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gJRtVTKo; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::633; helo=mail-ej1-x633.google.com; envelope-from=linmag7@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gJRtVTKo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::633; helo=mail-ej1-x633.google.com; envelope-from=linmag7@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j2rxG6dnRz3bsR
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2026 06:57:54 +1100 (AEDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-c2e3846d1caso220300566b.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Oct 2026 12:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791748672; x=1792353472; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ey4LJMK8RV+MV7vSZrPUmikamurNbFQxbI2le0bK+bM=;
        b=gJRtVTKorDJL1t0xJweLuiLAKxOuonX2xC6Aos6Wp3l53Gk5KVYGWsLMOrZsXROshO
         UkR+rkKpTqF0PLcvWV4utBA1lAltSqRrEgZAHsYFHlLFOKYYr7rkXbQp1ILtz78YZX23
         A3h/m1yH2vjiw2TWgR6BQkerQb613WHTs50xfzCjvD1o6X7ewKswUituW5/sNmJcuh1m
         FxL6+fYN9xgm+z743h793bdZZzb0d6EkvQzhUhnEYZHSaNtMcyuX1pyt/GB5ss6ABbSq
         tPxj4RpxbnzlBXv3jV0lf7339rehywC1bLOvcyV8L20DQl9i3lY65uD71V5uNm1DtH/r
         WIdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791748672; x=1792353472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ey4LJMK8RV+MV7vSZrPUmikamurNbFQxbI2le0bK+bM=;
        b=lFKfJVimcon8bhnRjv5A2cTuSkaYrSUy7XcwKcc7+x4MP9v8tvEWXHVetpJdE4b2WF
         hiWnh9F7+9VotkD/P+2SF70WJur3aRqorIOWBY21Ka+IBJIDSZzh5ZqPAORKZ3y0fgGJ
         SnjzX67Q3RnMaHy03BjnwBMslUrWPSeceuTbcx4zR+BFnkRiRAw31ZFR9dk0KWBF3R9G
         eH3F+u9M569Ho7vrKQVlL5yI9QsdU6lYCSEghxu8+Jugb6AG2fMWMhf/VsT93JpXmnZt
         Zy3MJFbkwt/Dr3VhUJrqLoTufJ8wgSauZrWQK0UFmvT6av4Qc64R/NgPre66BMK4R3/x
         VeQQ==
X-Forwarded-Encrypted: i=1; AKwUvBzon/pZQm/a3EMKOcJqQCp5DpBifNfGqS0b6pjTQQlXDtjBdInLTTVqWPEku2qOWS1MV+y4IA4lcZpeqos=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYI7ifuJwQz1HVwlNj+wN9/v2iUWyWQtKef7SODoWZQ79Hml3wUE
	BjR/wjkYyexo+mx761FwHiUhm2FQFN/P1InaTIH83jLX3yKBNPgZxLPL
X-Gm-Gg: AYBFou1WgNxAd2Qy1zPt/y1WVGuLO7qxmzqA9S0TZAXjJfi457lTOVLUfQxyAocff90
	ExyMTeYAWgvgel/gOtHw6j+/y8slo8sI4eGhC2gvimnsXiJo5Hb7x5IBCxzQzDbJHbhKGyyi/vu
	uK89Vx56rE+B4N/5pxB0ut8VlhANbYQjd5eBmxmd58T+F/DS58wohv/wMAhK9llw+l8WJvX5GR6
	b6i4twnsE55DyfjKyLyRsmsmkawCwDdTKkECYQnIBfvwHrJXqHaRKzSPmsNMeYDuClqXa4vT9Tm
	XLnV4eQdMGpxacsvhaezhNy2id2fHnFY5PnvEmlnBFw/trzXqX7SIIwshJm/o1yHL5kg+C4kbSj
	8rIAT3LcRJmqGBgLSkDtsb2FRg5+vk8MwCxEfiWea2/KM+dQdUDxB1/XxAG7AmGU6GHfggYxhfC
	ZG6sdOznvIXc/WRa8wHD0SrO4SPH2XOLylf2ofNC45echV8wsHGvb8A6pDsGUwObDYcw20jAncG
	tSn7iHcjQvY6WjXfSJWLwM8HVBBZ/1uBKyTXPxT
X-Received: by 2002:a17:907:7fab:b0:c26:1691:b368 with SMTP id a640c23a62f3a-c31a9f6b728mr805802966b.33.1791748671740;
        Sun, 11 Oct 2026 12:57:51 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a9a3ae9fsm381315566b.26.2026.10.11.12.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 12:57:50 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com,
	sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	linux-serial@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	krzk@kernel.org,
	oleg@redhat.com,
	linmag7@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v2 3/6] sparc64: avoid huge kernel PUD mappings on sun4u
Date: Sun, 11 Oct 2026 21:55:55 +0200
Message-ID: <20261011195729.981243-4-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261011195729.981243-1-linmag7@gmail.com>
References: <20261011195729.981243-1-linmag7@gmail.com>
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

The kernel PUD refill path merges virtual address bits 32:28 into a
TTE, requiring a hardware page size of at least 256MB. On sun4u,
kern_linear_pte_xor[2] and [3] instead select the 4MB fallback TTE.
Consequently address bits 27:22 are lost when refilling a huge PUD.

Keep the kernel linear mapping at PMD granularity on sun4u. Its refill
path preserves bit 22, as required by the 4MB TTE. Leave the sun4v
mapping selection unchanged.

Fixes: 0dd5b7b09e13 ("sparc64: Fix physical memory management regressions with large max_phys_bits.")
Cc: stable@vger.kernel.org

Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/sparc/mm/init_64.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 103db4683b16..0ae97e616435 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -1696,6 +1696,14 @@ static unsigned long __ref kernel_map_hugepud(unsigned long vstart,
 static bool kernel_can_map_hugepud(unsigned long vstart, unsigned long vend,
 				   bool guard)
 {
+	/*
+	 * The PUD miss path propagates VA bits 32:28, assuming at least
+	 * 256MB hardware pages. Sun4u uses 4MB pages here: retain PMD
+	 * mappings so bits 27:22 are not lost during TLB refill.
+	 */
+	if (tlb_type != hypervisor)
+		return false;
+
 	if (guard && !(vstart & ~PUD_MASK) && (vend - vstart) >= PUD_SIZE)
 		return true;
 
-- 
2.43.0


