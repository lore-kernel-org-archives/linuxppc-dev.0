Return-Path: <linuxppc-dev+bounces-26606-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69EA0C624DB
	for <linuxppc-dev@archiver.kernel.org>; Sat,  5 Sep 2026 10:31:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hcV3L4FW5z2ywh;
	Sat, 05 Sep 2026 20:30:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788604238;
	cv=none; b=AU+SCFnlYbr83B+o5adojgq48Tif3MVXfBofMRKr8r3N9gUPRcrpEDkBsSriN8w55bF+ewZRoocAyPPSusXVBejVr5kDTrKBDpvWdiyYNspyuSsObqxivTZJEV26WcH2UoyysDAP92v6ff01iqxegAq11cxbq1y/2WCRdXucUkD+l74DnIRsLZ7jFLw7FCi/9ZJAQzBbnInLdDODEnlsuC1oqkg9MgxSn8Z5zqWVWk8/fmpMUWhPG8PjuWtIm4noJu5iT63KLgCM2wNyQhvI1SX5Wl9HzfQdaDla8SjQB/TFnop7J8ZW+iaGIrYbhsYE4zPb/EUu237aOvO2oS3SeA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788604238; c=relaxed/relaxed;
	bh=SDGEFS6dmNz/auClgpOub+iqE39gaMfjW5ny2d52V9Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZIxsdvqbJIDkcHFwOdHsvpsbSXQiG7tl4lTZSGm8mt2sIy/uu1uYZn43cVhw3WDJ8zBSXP0bfxhnSX7QYit27txHceq2rg7mEOVpiJuKeKE2Crap0Nk1Az6Fu9cwclZcPGMXItscPxCA3SFnl/Aw98/boaiGf6awY+sgh1HfLpxTSYPYJz2uRE04jWy/3o4oB4K1VM3J1t8NFEI28pR8vgFs0FG67/q6E7jgCBAiTOicxn05Jvz+BlAMT5D5F+dZlBUwtRhhg/kWPM/RWPOaoKbgDXyYAHAnyAs6qw4c7xUvfS3LodfJz0wJYoZy66XsbNavq4EjApMX2R3UL54JeQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DOm4wJ/f; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com; envelope-from=kmehltretter@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DOm4wJ/f;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com; envelope-from=kmehltretter@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hcV3J502Hz2ywS
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 05 Sep 2026 20:30:36 +1000 (AEST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-49b8687630fso16482975e9.3
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 05 Sep 2026 03:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788604232; x=1789209032; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SDGEFS6dmNz/auClgpOub+iqE39gaMfjW5ny2d52V9Y=;
        b=DOm4wJ/fFbL45zIyi6mF7Udc/JIfOqAECkwvQGOVQCxb9D2HZiPOsQ+D8KZbhLVk9W
         OhkmRj421F94zWlq4IO/zDMQSFpoqd8Yvi44zwGrgukZU6QtQh2MwbLI7IAe4flhMQfi
         Hvx4j7pcVtllQ10OjR5hTyrnnCNxyi1DT+zv7Kcy8NlY16Jv007YRt5ddKHpgzhVirwo
         JqF3JjW2qhNbVB4kZNXzYb0Pd23gR2nFIN4QT+/aqFXXBwJXvLM8ipUUyCTZunNi4KnL
         Kl6WZcWs+PmtptQu90uXaVjKDpAleIw72tAbpbriq14TW/TdDCa5d6jzWL+eOQzbMHCO
         g2dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788604232; x=1789209032;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SDGEFS6dmNz/auClgpOub+iqE39gaMfjW5ny2d52V9Y=;
        b=fTIOa7yhCMqFH5CoW3PurJ3O0nLkTOSUF/7o5oqyOJcofhxUACQiqiFfOWCxG9fZXF
         lYy9wQ4GWijZjNz8xT+wyU/NxuVkXowZ5eLz1HBQQJK5ZSbcSUb9huDKIb9rtAuCqSiw
         0grljLkpzyKNg5AFc2zZeHP5NLFz9X58spfybApJ18p+fSWoR193IQjaAbQdsQbA+nnB
         hD33UEGWL+JAJdmjGEYykBXmKma+Io+ehpMqG+P2eVr+Mkp+6RKg4yKlLhjImFftRhiT
         cjh7YbpviV+GueyGSm+eACaq0ZwXdSrdtl57qWE51AwHqDkDGUfAvEggQfp0INJtOzE2
         8hqA==
X-Forwarded-Encrypted: i=1; AKwUvBxjLZC7q3mkIhTKVwFI125qsD5BBbl62p4kVPYE8pFWI5rJX6H1zR3PtmUasIHIHhEMa75hr+5wD8FsZEo=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mTj41JXKCM6A0M9rWX/8yHqntePKutb/qggIdW8jKfI5yFZMms
	IHx2if4+k1bo/AiNU4N0jnC0M2TPzbWHzNT/bm4erqgqSEB+y1dBCzt4
X-Gm-Gg: AYBFou3JGqim/2S+I4Tm3yOfr338Czh9k+2nDLAj6pKFLghD16igaslBAg9pslEEkdM
	CVdwjxONDgv2TD84nzd6WcgJT83I4wW4A+db1KeJCOq14gm++U9wt4CgkP8cwLuztcvPhma1M09
	T1TMA+6ivaSvRaUubc8FwhOe/2Lw1iBXNbQ2MuMJ1gDU/A+ZIJWk8KcVxmbnwygHB0o2JGqbhJp
	sV9cLU7yVzYlIq0+BuNx8hu0EKO2C3ghWDduk68di+qd6ZGzAbMorIoU7V0RBVOwNuoji/1/tdR
	5UXjSNk0FV+ggPzbWG6Q47YekNq0JlTKbRtnR08I7Q7ebqijGpLVI0yTd8iE1SaNrtw9INj3hqy
	hA+dQ9xsJ4W2KzW5G2YR5zjc0uf7XJU0afyhMPpe51sw1sEgdsgD1Q6UJMnMHt3m9n6zDNr39Fd
	CQ1gX7TidX5VUNhopZUYszBJKPl+4BZtwVCxjASV/AvCrQEN4SjnDbf+7s1fsadF5XKLLstMAMV
	l4kHPpqx3RpDmM0TuKrG/PGudr0dIcSKCzabdK05Q0t9+E3OLapII3EgrFeO404visCy+SNQnDB
	qz39ZXQQII2SUKLQIY9tlYrAddOL090IWpOMpCTSMHTtSZBrfqw9lLyPoFmd9ZkLkgpdPIdxH69
	XL08=
X-Received: by 2002:a05:600c:138e:b0:49c:d818:8771 with SMTP id 5b1f17b1804b1-49cf8240ba5mr110383085e9.7.1788604232162;
        Sat, 05 Sep 2026 03:30:32 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a4eb-3001-c06d-af27-9fa2-ea53.310.pool.telefonica.de. [2a02:3100:a4eb:3001:c06d:af27:9fa2:ea53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d08144037sm8125535e9.7.2026.09.05.03.30.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 05 Sep 2026 03:30:31 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] Documentation/ABI: hv_24x7: Fix the catalog_len attribute name
Date: Sat,  5 Sep 2026 12:30:27 +0200
Message-Id: <20260905103027.43239-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
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

arch/powerpc/perf/hv-24x7.c creates the attribute as catalog_len
(PAGE_0_ATTR(catalog_len, ...)); the ABI file has documented it as
catalog_length since it was written.

Use catalog_len.

Fixes: ad0a02b83477 ("powerpc/perf/hv_{gpci, 24x7}: Add documentation of device attributes")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 .../ABI/testing/sysfs-bus-event_source-devices-hv_24x7          | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-event_source-devices-hv_24x7 b/Documentation/ABI/testing/sysfs-bus-event_source-devices-hv_24x7
index de390a010af8..9b231c80ea66 100644
--- a/Documentation/ABI/testing/sysfs-bus-event_source-devices-hv_24x7
+++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices-hv_24x7
@@ -33,7 +33,7 @@ Description:
 		documented here:
 		https://raw.githubusercontent.com/jmesmon/catalog-24x7/master/hv-24x7-catalog.h
 
-What:		/sys/bus/event_source/devices/hv_24x7/interface/catalog_length
+What:		/sys/bus/event_source/devices/hv_24x7/interface/catalog_len
 Date:		February 2014
 Contact:	Linux on PowerPC Developer List <linuxppc-dev@lists.ozlabs.org>
 Description:
-- 
2.53.0


