Return-Path: <linuxppc-dev+bounces-20657-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94B3BCD3447
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 May 2026 19:56:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gCcFZ3Y4jz2xqv;
	Sun, 10 May 2026 05:56:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::42d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778356610;
	cv=none; b=HDbtlW5cfHycAdFHvNB4gDkw0G79fT/BBGeWY9m8i2e+SsE7hnz55LRvoDiCmGX7AdyANC7fbb4fzHp6B7rqcGO2fBJciKlUr9lDOUY/k7wZDs+IFhxfnJNeiQ9cPwqYtjZG9v6G/ZlW1qPvt0tSlQEZW2qBHK/q9210aOyB5yxQ4eFxO46w8yGlZegKWbeBV5Z6b8vUXTY/J6k+Nxv2BTnM4EVvk3PYiZ+OPC+94Pto+9yZzLKz3dFR8QYgibOs0At01KxA8iDQWxTXKuABMc96jhuaU9bYMEtd5cUI21LewFEOQoJP0kixDLPgWDVYsadpixqa98YZYC1ZmrnYtw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778356610; c=relaxed/relaxed;
	bh=nKiaZuFuBrfeYgzxGRMsLy+An4o+pYh57uREy1jun3c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f8SsziL4JuksUsXs7EXMFdtUjYJKKhfJ12O/rKMrVsYC5+ijfaN2dnceVcLm/PoHeZmFmi38XLLFPkSqGC+G2sE4AhfqbdME+VpRWW2Ea+H0QaU3qYFbX9AswJjhp0picF21EFpUVyDFX6lMs74xsrjUC/UOkw/a0by4v9W6aiLvfBIO2gu6ZZZfbxsumoUo3dMFD5F1u3hai1gh6clDuxYNfwOynf2DsjPyQK6fB2fXQVtqbEDdBZwZClBA2NjDMUKXUCGVCQzJeM3LF71i8D4Pj0qqErOlELQlp9uy5Vz4enQRs+Tk/KhRFtgU9/oP9cQK5eUBK5w5qZDCJWOHKw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=n1hobLdm; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::42d; helo=mail-wr1-x42d.google.com; envelope-from=julianbraha@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=n1hobLdm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::42d; helo=mail-wr1-x42d.google.com; envelope-from=julianbraha@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gCcFX3Rylz2xlV
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 May 2026 05:56:47 +1000 (AEST)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-43fe3e22e33so1790279f8f.0
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 09 May 2026 12:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778356603; x=1778961403; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=nKiaZuFuBrfeYgzxGRMsLy+An4o+pYh57uREy1jun3c=;
        b=n1hobLdm+VRGEbi+TLC6J8RTC0ppZ9KU0ItHdy7/Q4noupa6ok5B2Fr8wqcdUXDTO6
         2GCuY7pSkqDLVG1F4JNp8T59rCv9f3I4Y/05vfMSc/DdZ5bbe5qfzE8DZusmLfacc2cZ
         6H8kd5/EjrdntZJiXHYERqKzWye2EpzugkXxpYXqWsvcxI3aMidVfxfKxiYuwNJ6UNzb
         h62fuO4r5Wa+NSN/ly28nvbEHuEVRGyScnzJEV0RBweizIv72MATDIxe4vy4becn6FTt
         JNQmDBCAtsatFiAJxUX1VtoF1biH9WA9vYNDPPbITpcIu5uO9zC2rjCooDI/693h9syd
         /77A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778356603; x=1778961403;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nKiaZuFuBrfeYgzxGRMsLy+An4o+pYh57uREy1jun3c=;
        b=dnvv8y4ZiEfUdmhlzCFOAyMHpzmBSQpXhFuuc2vHoWPiTrlqRpkhmF6N8y76LU+sqC
         cp9Njg3tW/hKqBsSiVc4pSPAhmdKcz8Tf+4P4tBomxK09AlrnJdrKu/8oK6dvJVqlVjr
         lwc8yNAyr+e1mrogIMjVslJoX9d4qbVhTOlDuKNyKePBnUo4O8RKVzea7dp+tpakVJob
         ZTdleXHEeGguWRXbv5zop3XWq5QkCxLN5wrJjCFeFOwsoOg4dWfukUZMtNjzPawHP6bn
         AZTwfdbVcWhiXfigTks/e0gYi4j9wezVFVwyK4K9Qd7s8DIOF1WCOqR/Ks1aejLDC+5o
         rMPQ==
X-Gm-Message-State: AOJu0YzXi0ckXVBADHcl36BJV1e2Q6wXq7bCfqAvuNc4KZww8uHTJK3R
	kLj53ga5Bo+sOOqxLrY1SCBVKEGp2BQWZQl98uXiKHMAd5cgYlPbS7wa
X-Gm-Gg: Acq92OGpfpkdhnkqoy6S2GzQ7Fn/GOkfV8yT3P7dkovAhCJhvTRQjsF3xrVOCw/c7H7
	tIP60M7Y200erC6GA2s9hMsHAHhnL2WbUc+6B7vdjV4lj9q+dAzDXZQsOPOQn57cwPDIdXxcrTn
	ladVo7TVx2d6okgykyrdMarUm54QKQkAGnF5Sp/J98k7HY3tNRO1yrLYlyOCw5L+ZeBtyixBpBQ
	xVhf94si/1EvTEsnvzbriOlG34m0fN8AF7lKLUj0+Ggld98wN7OW8CUsWRroJzSC7ifHjOekZ6H
	t7a1PAuECS/ZP+wMSxhuQsONz5ZuXSCBgGzzv6rKC9ID30deI8AU1GfokYNuws5By8iOpb0u7vT
	lGSWVcn2lstJH/shQmMTLmU81WuoR5O2HTqEzRa/ikaxPzb7EePUQHqoCzLICZ1nsIHGPNyFzTD
	7tYoW0crenM9pc1thDx2fcG+PYSBR3wbMW2lFZg96BYUhkRFBGAe7AenA=
X-Received: by 2002:a05:6000:26c9:b0:44b:cb31:b767 with SMTP id ffacd0b85a97d-4515d2e6d77mr28428138f8f.36.1778356602489;
        Sat, 09 May 2026 12:56:42 -0700 (PDT)
Received: from nixos-office (195-23-151-163.net.novis.pt. [195.23.151.163])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-454919c13c9sm13904793f8f.27.2026.05.09.12.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 12:56:42 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
From: Julian Braha <julianbraha@gmail.com>
To: maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	jniethe5@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Julian Braha <julianbraha@gmail.com>
Subject: [PATCH v2] powerpc: fix dead default for GUEST_STATE_BUFFER_TEST
Date: Sat,  9 May 2026 20:56:34 +0100
Message-ID: <20260509195634.1134277-1-julianbraha@gmail.com>
X-Mailer: git-send-email 2.53.0
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

The GUEST_STATE_BUFFER_TEST config option should default
to KUNIT_ALL_TESTS so that if all tests are enabled then
it is included, but currently the 'default KUNIT_ALL_TESTS'
statement is shadowed by 'def_tristate n',
meaning that this second default statement is currently dead code.

It looks to me like the commit
6ccbbc33f06a ("KVM: PPC: Add helper library for Guest State Buffers")
intended to set the default to KUNIT_ALL_TESTS, but mistakenly
missed the def_tristate.

This dead code was found by kconfirm, a static analysis tool for Kconfig.

Signed-off-by: Julian Braha <julianbraha@gmail.com>
---
v2: remove Fixes tag
Link to v1: https://lore.kernel.org/all/20260405161545.161006-1-julianbraha@gmail.com/
---
 arch/powerpc/Kconfig.debug | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
index f15e5920080b..e8718bc13eeb 100644
--- a/arch/powerpc/Kconfig.debug
+++ b/arch/powerpc/Kconfig.debug
@@ -83,11 +83,10 @@ config MSI_BITMAP_SELFTEST
 	depends on DEBUG_KERNEL
 
 config GUEST_STATE_BUFFER_TEST
-	def_tristate n
+	def_tristate KUNIT_ALL_TESTS
 	prompt "Enable Guest State Buffer unit tests"
 	depends on KUNIT
 	depends on KVM_BOOK3S_HV_POSSIBLE
-	default KUNIT_ALL_TESTS
 	help
 	  The Guest State Buffer is a data format specified in the PAPR.
 	  It is by hcalls to communicate the state of L2 guests between
-- 
2.53.0


