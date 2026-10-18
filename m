Return-Path: <linuxppc-dev+bounces-29650-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23732CCA490
	for <linuxppc-dev@archiver.kernel.org>; Sun, 18 Oct 2026 13:50:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j70R912kjz2ygd;
	Mon, 19 Oct 2026 00:49:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::62c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792331381;
	cv=none; b=mT4shsyX8LSSPS66kYHZG2jRGHwzt5tX0Y6rfwhWa8y/vVjKbroU8ozJFtvvpAA8f6kMjqkALASYfxExiK1NafEOJZcnrOve+Sfu9ojBeHfrR96cIYr1TnxD7QPrTxEXMi9j4ScLIgeTzL5pptj7KdzrTHL11v7UVI2XZBFYM6XC7ECuIsMuQhVYdYjt5OqWJVO9AjaR4J2d9WDlVG7pBdhLmlPFBJxREvT5Q4t5SZ6krLdIrotzr9wSKPgIs95HAEp2k/3Sv6XjAqqLxvBxkFxkVJMDoprdiReIsSaOTvMfMUm+k2Uu0laSzlou7I8yzY4N7EWMTJV7PH+Oal/qLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792331381; c=relaxed/relaxed;
	bh=XrgtN1CfIC918YQEqPq2f1RcPZ7legyk//5piQ8+dDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HV8HktVXcb7rfwuwF7PUZl4gE2isI0J8Ai+nVfhel8LuZCqjhLY65XXWZ2SiJBZmVZBrZ3YpwQqGt6NH+5kE1rv7fdpS1ystenWutb5vEJa1Wr71xexUEewBgUp6jeib4G56GzFVXQMFqHqI1FidNxj9URHUFN+GV4vTe9aZ8wLkaL1CjPUX/MWKYU6Tfii+on95G0YHMVPCjZIQg/6QA1ISCvAiz030BZyzGDbpU17rsK74ucLd8F+cpkFjlv92QBtAqKSzwwDcFOCrfahr7wNyttplpkUk8+iD2M5HLCXKhYoIgq4mskhg0t8i/xkYoLptYc7igrfRieqxPggFIw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ezbEYqjJ; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::62c; helo=mail-ej1-x62c.google.com; envelope-from=linmag7@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ezbEYqjJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::62c; helo=mail-ej1-x62c.google.com; envelope-from=linmag7@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j70R80wY4z30HB
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Oct 2026 00:49:40 +1100 (AEDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-c2dc63f8d8aso203960966b.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Oct 2026 06:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792331377; x=1792936177; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XrgtN1CfIC918YQEqPq2f1RcPZ7legyk//5piQ8+dDY=;
        b=ezbEYqjJpIXjjm4myPaBNRCKhwpjm/vFfH8aYNMhBKFijOJxCtwm/zJ1eFISO2ulib
         iIM5caRwlDkDDByDY3E9VZB1+d6eCOVMn2ALHqmvYiZwXWdpr/OCP6qJN99GFYIOSyMM
         YOVYOsXUM93f3uymZB4nn/NCjEyOX4JnTtgOCcoFJ62IrPPV9vMdD4DLnXaBGyGB+Tvw
         9VjQrNjn1d4cVfXknmBbDdryw3e3xKCkgESYWkmrRx5xiCKLqIe3ssnZQjLBglk71/Z9
         Mf84RjDD+a9OYmrdROBbefXkSaavcVIX4YR61Ua9up+fYrFO9pk3k+5Gq9xKVyywiufa
         P2pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792331377; x=1792936177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XrgtN1CfIC918YQEqPq2f1RcPZ7legyk//5piQ8+dDY=;
        b=jQ+JGrjRXzI6qmDXuqvHxeuks1IZOvHBZ8MyeKV+XqMUJwtipJFYXLpbmjJ3PMuvba
         /ag23Ox7GmFVcScmn7OsabP+wHQgupcUtVT3VPRcTmeqD5r9SuEts81o26A50xFYZObl
         0RKEF/AnikxIyuGV4DjfwgpAWFjUH5Au0TVN/D4tiZCgmhT5vunY5J/o3fgMOigJx4ab
         3VqockuMTgkCo8jgYC0wTaDiP6hsM7urjDsJd2xjV2cN2dh/8QhCyBU0pDLVCCGU5HIW
         GpkUvp1/zMW4J5R4LvgRmnOKx1z491pPM9uNn7Eq02I1FQYCgjXZqbA345/ny08DvVXe
         eG0w==
X-Forwarded-Encrypted: i=1; AKwUvByXCn1MG4N1l75uqJE51AJlR5/8J0ZkSJ9UAsvSPQjeoBhgZ1NvhYwch9xBfWTPUtdDBkyxCnQB8KsBIqg=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJed3wY/tV1S2T1ZLdZbpDaWzqC9b8qdyTvODKXVXwhWcxLDPeI
	co8hbn7uiENa/8QcENq6Mxl5bNs9oRRqMgLxUtfQ+VeifthToqLVtqIR
X-Gm-Gg: AYBFou1k4Xo53a+KqY5b7J+xvmu0+pGUF67Bto8UZRd6mVKGbFgsZoMnsqLyGn+kFCa
	CSSFicp/DvlqTu5SipRVvs512GiWV341KNJArylFULy6jZuLkevnKozOz9D4BcMUtS5WYXdd2qc
	CXaXiB0xsHzU8zralI88wxmVYrSrnGmjpXcy8rx7RL/N6jZ0Sb1/Jgfqza0gUHC9Eas6Y0fPRs7
	GeErgqk4ieXNqkOTpF/3nXVKaM8LtsPni/juLuZi9Gsr9ji5Jm/f84IpXhXSPNh50sMWzbaKaVy
	iIC2NLZhHf8k6ulXtrkA8SYliBF0k+igF9UbOQMTNpst/P+B8l0o2fcVnjM0E1cvgNF3iBc3Nw5
	DDnPeQ1YTTZFZqKZk3ORcG3V9Snwukk5urSAvTZ+xOrqGF4EKBK2Swur7D/wTZYim3mKM3Pwz9m
	4GMaIkkydGa9+qdtHvNDwi9uMODxfm8rVY0TF2w7/9U6vZxH6gf1wJHiZJ+XPhjOz0InEFL9Zn2
	AehveLBvSrvzzuSeLMpBXvh4Y/AR3c1M2Y5DCeHrLIy3bq+0CE=
X-Received: by 2002:a17:907:c605:10b0:c42:a326:78a9 with SMTP id a640c23a62f3a-c42a3267e26mr126187466b.42.1792331376760;
        Sun, 18 Oct 2026 06:49:36 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c40919c0402sm267678266b.61.2026.10.18.06.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 06:49:35 -0700 (PDT)
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
	linmag7@gmail.com
Subject: [PATCH v4 04/10] sparc64: stop IRQ setup when descriptor allocation fails
Date: Sun, 18 Oct 2026 15:45:06 +0200
Message-ID: <20261018134738.1016106-5-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261018134738.1016106-1-linmag7@gmail.com>
References: <20261018134738.1016106-1-linmag7@gmail.com>
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

irq_alloc() returns zero on failure, but build_irq() then configures
IRQ 0, which is reserved for the timer, as a device interrupt.

Halt before publishing the IRQ or changing its descriptor, matching the
existing fatal handler-data allocation path. Returning zero would let
callers continue treating the timer IRQ as a valid device interrupt.

Fixes: 8047e247c899 ("[SPARC64]: Virtualize IRQ numbers.")
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/sparc/kernel/irq_64.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/sparc/kernel/irq_64.c b/arch/sparc/kernel/irq_64.c
index 3f55c69d5f3b..4cceeba726ab 100644
--- a/arch/sparc/kernel/irq_64.c
+++ b/arch/sparc/kernel/irq_64.c
@@ -619,6 +619,10 @@ unsigned int build_irq(int inofixup, unsigned long iclr, unsigned long imap)
 	irq = bucket_get_irq(__pa(bucket));
 	if (!irq) {
 		irq = irq_alloc(0, ino);
+		if (!irq) {
+			prom_printf("IRQ: cannot allocate interrupt descriptor.\n");
+			prom_halt();
+		}
 		bucket_set_irq(__pa(bucket), irq);
 		irq_set_chip_and_handler_name(irq, &sun4u_irq,
 					      handle_fasteoi_irq, "IVEC");
-- 
2.43.0


