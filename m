Return-Path: <SRS0=Efpx=BA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 255F0C433E2
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Jul 2020 09:21:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83E7920657
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Jul 2020 09:21:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fossix-org.20150623.gappssmtp.com header.i=@fossix-org.20150623.gappssmtp.com header.b="jyPv0mOd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83E7920657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fossix.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4B9tQR6kgmzDqdb
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Jul 2020 19:21:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=fossix.org
 (client-ip=2607:f8b0:4864:20::542; helo=mail-pg1-x542.google.com;
 envelope-from=santosh@fossix.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=fossix.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=fossix-org.20150623.gappssmtp.com
 header.i=@fossix-org.20150623.gappssmtp.com header.a=rsa-sha256
 header.s=20150623 header.b=jyPv0mOd; dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B9tN100sNzDqMT
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2020 19:19:43 +1000 (AEST)
Received: by mail-pg1-x542.google.com with SMTP id n5so11663013pgf.7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2020 02:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fossix-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Wi0ihrXnLYicvMUsiDhUzWSM5Q0BG4C58c7awirMg3I=;
 b=jyPv0mOd2KZN4kXW4kFHyFvvgCz35lmSHAWkZMAeVCJREbqAOSe+JhKt1ZTpmtZSnw
 /rGOPfsjLq1ACWVUdxTJTm6jkyp9b1Fi4jx941zHVdM1rbqt0rGfprM1ycd0K8L0s+pM
 /r2gf1MUdYp0zmPpbBe4r1u3tQG2pw2aAlJAiUBgLL++/WYoCdCeQEQe3/zxuvDMeobj
 Vx9PifzBNl4zC4nsWDE7TkFJBxFJhvkiOnLH59zvFLr6Dm0d2hrgb2wOdvELpDszfe2d
 vWrF9BTluWYDL0AZLLmc4pavHbpZlWkENmdZVai2wfAg1nLAa9KlABJd4K6RQsYLw3YJ
 BC8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Wi0ihrXnLYicvMUsiDhUzWSM5Q0BG4C58c7awirMg3I=;
 b=srrENgj5dLyHQLHyKLBGSz3LZ9Lov1d7XErpKBo1SJrzkhnl5rGLfCUJ2LsqHSXowQ
 RTcuYS2yi3Nvd8gasIZR0aqoNMmXoft+Q3/ZlYGz7TNUT6q5n6w5YVnf7ttnIEs9QNyJ
 +Mb1oJl/fpVVFIWzsK+CNnI1Pd5173tJEfakq6A5Zd1SXHqjgRIGgVulPQa7B6lb1Mzm
 wAgd9hmB4nP4+DWCWfQ3e3gPF2aBNvazd6TWIUJrrs9LJEEKjV3AlfunW5LDjtcXb3qe
 KVWGFxa7wmsrtFjQW4rH0tSIRU7R0yWDrbEapnLq744JXxwfGOBkGt1gSwsXFsqwkEwv
 K5dg==
X-Gm-Message-State: AOAM532+njb06+CdG5zFIj2Mg++B7SQVsVS/H8T7BQh5wm12d4N+AHdo
 ED3rSbIrxk+SLpgFR5BAAH860aJkA/U=
X-Google-Smtp-Source: ABdhPJxFjQqU7aws3JwhS8jRQgiRoqxC28y8G2tV6DlkNI+rW0GLb3ftoljSnQvXw02Xv+G1v67V3Q==
X-Received: by 2002:aa7:8597:: with SMTP id w23mr22480268pfn.219.1595323179417; 
 Tue, 21 Jul 2020 02:19:39 -0700 (PDT)
Received: from santosiv.in.ibm.com.com ([203.223.190.240])
 by smtp.gmail.com with ESMTPSA id 198sm19822057pfb.27.2020.07.21.02.19.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2020 02:19:38 -0700 (PDT)
From: Santosh Sivaraj <santosh@fossix.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH trivial] ppc64/mm: remove comment that is no longer valid
Date: Tue, 21 Jul 2020 14:49:15 +0530
Message-Id: <20200721091915.205006-1-santosh@fossix.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Santosh Sivaraj <santosh@fossix.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

hash_low_64.S was removed in [1] and since flush_hash_page is not called
from any assembly routine.

[1]: commit a43c0eb8364c0 ("powerpc/mm: Convert 4k insert from asm to C")

Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
---
 arch/powerpc/mm/book3s64/hash_utils.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/powerpc/mm/book3s64/hash_utils.c b/arch/powerpc/mm/book3s64/hash_utils.c
index 468169e33c86f..90ee0be3281a9 100644
--- a/arch/powerpc/mm/book3s64/hash_utils.c
+++ b/arch/powerpc/mm/book3s64/hash_utils.c
@@ -1706,10 +1706,6 @@ unsigned long pte_get_hash_gslot(unsigned long vpn, unsigned long shift,
 	return gslot;
 }
 
-/*
- * WARNING: This is called from hash_low_64.S, if you change this prototype,
- *          do not forget to update the assembly call site !
- */
 void flush_hash_page(unsigned long vpn, real_pte_t pte, int psize, int ssize,
 		     unsigned long flags)
 {
-- 
2.26.2

