Return-Path: <linuxppc-dev+bounces-22685-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC78BCD8CA8
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Jun 2026 06:06:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gfc283dCLz2yZ6;
	Tue, 16 Jun 2026 16:06:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781590000;
	cv=none; b=XLmcvCDouvGROs4CSzc57F7QZg8mwQwg6wGAMyVbwHdloPc88a1R+LwOsivFIDa1pl7lonXT8NCacvWgh+zZZo9hUpTuaimGBgVsdXA+xfWgh9aJzMozt74/8BfnjYPSPYm3u4qmhuA5PUis2HuG1wnPgJshw1ohKZQmYhv7jMAUlaEsypkeR0+f8hLQboqxoIwWqCMaYnc8vXhDh8Vs4UwlpM4+sEgTe6+3Z+YKuoZ1T3vI9NIQLWCiY0mLIWoPpM8zMIrUFUIIsfdMlzGLFWNiud3cYRbD0xk1HJyyKzLWIGgteG4TstfhBbKgtWFuUpsIYB+zBhpr/itY/ksiug==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781590000; c=relaxed/relaxed;
	bh=ntBMW/EKHKotQfWU3mc/Af454Wd2nF+n9Ek/8NHgJO4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=QDxQ+R54BL+D1ryiwaYJd741cOHhLwmsvrf7dW+LgFKH9p8oahU4rnJW9OaBoWhtall8l0upuBqPSNUmt6+9TAebojX9RE4V+3KKj7QoEqapftZ7TaEBePv+eGOrYWskWdtnwT1VYDIahQR9M1fHKhuNSHqhQulJuGOk3EH6wmvPi0fbs1m2h+mxwL1eVWjGauWkR4sTFdO0CVHS/fhG66XubMK0X3enUiEngW5F8QAuXv+112u9aHAMtVaH17uMcm8qxTgCK354aI2p63x7bsgzVKQeA/6KEWUhoxnRcH9NVBT7zYVq+YJEZVaOpIsa4L0bBBPZmIRFl1miW4F3VQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=oc++HQpm; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=oc++HQpm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gfc272djpz2ySJ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2026 16:06:38 +1000 (AEST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-2bf237e1433so50596285ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jun 2026 23:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781589996; x=1782194796; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ntBMW/EKHKotQfWU3mc/Af454Wd2nF+n9Ek/8NHgJO4=;
        b=oc++HQpm0qHPPub8h3IUg3FfABVMSOG+x6bL7jSKcxCh5XPK1LH0MIQvYueUWCEvce
         dyWaRkPThR/SoVPTTRSC6dBfrbsvgzPCijTUHnr9W9ltuYVeo2K1dHHNdW1nmiMzAWea
         X8Bydcq3BIb2bJHLGNWHj8lQGS9Ngyzb7Y2ZkuuaCHzdRu3kkAjbb70zeHs6STyEsUs1
         /H1NlON8wSDnWVCQlkdfqvs1j+xPfj1ODqggZTWdQK36YHtR0piCCq7NxLNTVHnUifMX
         FocBhFDFNeeFCQmH9zP89URWUgJQvRbz+4TN+68Hd01lCdSAk08NNi9PqqJV5OZcj5w7
         8dDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781589996; x=1782194796;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ntBMW/EKHKotQfWU3mc/Af454Wd2nF+n9Ek/8NHgJO4=;
        b=IPnpzS3GhCL3hpHH+kgQuwAZqZtq1OoxPGv6YWRa+hIgqv8CurtIs66YggLyyv557z
         PCJ8K5LUKTwG4+QrGuG1cDdx7Xkzatzpf3wKQEvKxYgUv0JZgF0OGBgazlnGKC6qtzY1
         yPVyRlv1fxTuQYqjwV3ZnT+5Fk0XEPF3uf6wCbWqEnk9KB8XioJs3m2oZsnXaxK/Ucy1
         Cz8l2az6zsWv48kkfL8lruCmkFrPdZX9TpJe7SLsLy9P8JlF9OAb6pgLrUFhjUdqfLYH
         KvK/3aU2HKep3J9jASL/tqPtpUFvLAF+IBMeBUXjc4TVT/qFDOMNTvLrgdatfzyj3qVh
         iVPA==
X-Forwarded-Encrypted: i=1; AFNElJ83G8kmVwbc+K3F9agHLh1/mpLN7d3fRDm+8AFGhSNh4tdyZuZzMSvJMrY7aLU/4M5UYpPAqOwUzgy4MT4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxdE/FkkVEeiIWkp4rscEwMJH7OkrWVSLLW7mEM+BdXUdSjoJfj
	+wWk9uYwz8fBA6TzbVsfRvfddSiuiiGzTSJSwOC/deaUcS3L6/QVDufo
X-Gm-Gg: Acq92OF0P5sfLxYJxI3oLvKHU7EgdYCW5vdCXKKy08Tm7VfgPpfSvZOMlYJ6uiSNujL
	6vb8eyIptmUeY+KP0U7cMePr3wAmfzgjyBgf1q1wsRQyNK64IYsrUjIh5+r+9bOSrMWXQJZOqBt
	v4PIFWolYZP6gzwepMSXu9oRx/trmTyFiLyxN+I/NoCBbzNJCH/GXsRKo/v4eRd5LhJzDQIQgMo
	jOyHX+xaMO9I42O8RLAXXkQPRKYuJ2pgUUgBHM1tqYAJcbeEBWsDO8r6e/3IDU0FfNBUYdgVYz+
	XH3RExwaHSUC3Er3iMD74NAlJ5hdc2/4vNlTemM6tScW24UjHxO6f0pjZXKFhWIIjv6+x/5FdC4
	STEyaYV9+IFmtL7nVYUMzkSaxt7kyVrDSQjy3P6Q5EDZKgg2h8f+M8WmioEu9HOGCvpC3+lHYzt
	eqKBE+ttBZnvBynFeDw5idNuO9u8EW1VwsmZw4it72EfnZqIXa04twsOHmgPbwp79nAgchLB2Np
	Chc
X-Received: by 2002:a17:903:41ce:b0:2bd:eeb6:ff28 with SMTP id d9443c01a7336-2c4109ed35dmr187105405ad.12.1781589996554;
        Mon, 15 Jun 2026 23:06:36 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com.com ([106.51.160.236])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c42f7c75c3sm115714605ad.27.2026.06.15.23.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 23:06:36 -0700 (PDT)
From: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
To: maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	mkchauras@gmail.com,
	thuth@redhat.com,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: Put PVR values in ascending order
Date: Tue, 16 Jun 2026 11:36:25 +0530
Message-ID: <20260616060625.3617719-1-mkchauras@gmail.com>
X-Mailer: git-send-email 2.54.0
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

Right now few PVR values are not in a sequential order making it
confusing to read and evaluate. Put PVR values in ascending order making
it easier to evaluate.

Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
---
 arch/powerpc/include/asm/reg.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 3449dd2b577d..50683bde9411 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -1340,11 +1340,11 @@
 #define PVR_POWER8E	0x004B
 #define PVR_POWER8NVL	0x004C
 #define PVR_POWER8	0x004D
-#define PVR_HX_C2000	0x0066
 #define PVR_POWER9	0x004E
+#define PVR_HX_C2000	0x0066
+#define PVR_BE		0x0070
 #define PVR_POWER10	0x0080
 #define PVR_POWER11	0x0082
-#define PVR_BE		0x0070
 #define PVR_PA6T	0x0090
 
 /* "Logical" PVR values defined in PAPR, representing architecture levels */
-- 
2.54.0


