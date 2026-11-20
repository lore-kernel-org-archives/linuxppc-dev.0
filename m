Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75319606A32C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Nov 2026 04:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cHfQUWrQ
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jW1tK3W7Dz303B;
	Fri, 20 Nov 2026 15:04:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1330"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795147449;
	cv=none; b=GccONWhOEVcCazUSxpTcXLtBCvHatOygEWejea4k6l//+oV206lX6d7wTAdGYb3uqEw21zYCzus9Hn2mUN0xgUspy8Dsp5wheNhqhDf3RppVpQ3pNQnDpYwLzPsB2QW9xVi3jdrwY205QN/C8S2LA0u0wjtLLRDjAQyhth0JlpN5ENvcUinu0rOG7GixFD4+gPsbEgvSP3I7kIXcPOzuqk0sOp0NpGiA38JW2HzBWql2r52mCmzc0iXKpkFy6k2E9hVAxmKppdKnZ+wSfGgUYfOZBjqP+rJOGwzXfRdHdjbOMgclPjIQgir+E8hOep3rdr64yfvWlUfvCzYuq/qqaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795147449; c=relaxed/relaxed;
	bh=JhDenXpiUHLZ1Ej69EgBT1lJ0mR2rE8poGppaQ4kv/4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l8K+4gMPmeIgyJcDJi/SLCrUkdoA3zYOxhDzOZ7k37L1hnm7oOLgAWKfON2Ng3ZjSyTiUjbnDUw4nuGEzTecixr/rXpIMI8pT+bGFGJEmON2sUNPXdnyKYcBsvLPVWAM5kN1b/Zk+nIpjA4Hr5qQAH/NEzxJx3pW6UujLYrqQqRzr+9U4Ci1/ieAzyxhAoh8lvUsUlyPOCrJmX6KGD0nP5DQa2SRwxieCvssBPdXLU8D2wBjoL4B/J4roMOw0+U17YcMZaNWP4sFYK3aIoTmEKbiupPX78LYR5ouUE61kDIMhy/QIzJylIeVLaZl7jTWufzkwjAgzsYMSG8rysLwJg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cHfQUWrQ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1330; helo=mail-dy1-x1330.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cHfQUWrQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1330; helo=mail-dy1-x1330.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1330.google.com (mail-dy1-x1330.google.com [IPv6:2607:f8b0:4864:20::1330])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jW1tJ60TDz2xHX
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2026 15:04:08 +1100 (AEDT)
Received: by mail-dy1-x1330.google.com with SMTP id 5a478bee46e88-385d8a00598so231158eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 20:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795147447; x=1795752247; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JhDenXpiUHLZ1Ej69EgBT1lJ0mR2rE8poGppaQ4kv/4=;
        b=cHfQUWrQHPRxoo6dzp6af2Iq2eE+odw2/7zUAjr1rgo7ycYAK7t5vO9YOYz/cQO4PH
         RafirnOn6i4i4WAmgjsTRyE3G9+yZsr0BFJImiYQ4g4Ay+irYjmAcsx/VkSerxvgG7Dt
         YJtCtWVV30r/Fg4Vih1nGeXhrDquw3KXlK3YIKhairRie7RP7i2hKYFKv+SexrWWRB22
         SH5sRs5/THmX+ut3OAEecMmP6WsMm3o57nGylQE+cTJ24JQxlui8VrIVApfVmw8h+oyU
         Ou1T0v9JrIhHRTdPTK5W1pXMIvM3PeazNOsDfVpD5MFZvKKhto81G8iL1z4pPOnkwTY8
         LSYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795147447; x=1795752247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JhDenXpiUHLZ1Ej69EgBT1lJ0mR2rE8poGppaQ4kv/4=;
        b=fV/SKNGAdBg0U8AFil1q2Rb7Zs/tc4XyZqybn9mmyIMQn/lZwMYIOiQ3Wk8mnTOEHL
         KNULWVQenc37VDv5kXTw+eW/EQkxeuiRv6w3pmWrCC3Q/YHUcHi1d6g7FOwDyN9Ks+DK
         +4Uur+5tSKTnDBk/1BQIBzjmJhvebcYFN2yXM5ovrLNevbfTYM63Q1SauH6LfjuxAqYv
         tLf/dat+Tvy6Ts9wCFBRA/6O0LoBlWDFbZ6Hyy7E8B+qqmR1euldRW/ZZe0hluJ9DbxF
         v1r1dRLPJSA6i6wq22oqa2s8mxTGC+ixAYO8li6sKNpxlRif/9rNMz/ENW7SYtFBpiez
         /miQ==
X-Gm-Message-State: APuU4Z+/eWBl3f1C7JaH7chSq3TrfPNTThhIh35KXq1pA1IfUSMx0V5j
	E/iAISBLVelStzvvSJHEW6/5HvjMIGw8oGHyvMtph6pWZZ8tGRltDZHjkCnBzw==
X-Gm-Gg: AZFdTZdyRUPXBiZ4mmg04YSwh/tgezaFmmP2ml2VIeIZssEgtTjaJVALxerNksRbjPx
	7i31jliwTuwwk4gvs0J4XamnjUGtbDR/zMXT9wr18AT9/nLRtsV4NsqAx9kCRQfINW/5cNzqujJ
	WE7yDati2dVrl69cYnlSFIXhp+8pM3YLPSTfP4kWHQn6qgQgA65WzDgSxp7/XYgz27Oi7++5oqI
	/WXRtJUIiBbNIYDhetpWgqBzVS0pppUaEyhXumoYE3Qu+bSCq8DNl4g8WSWnOuuf3ter1GFgUn+
	P/xyAORVw6/+kh4iSW4LqvZAanX0caBCxGqp9WinCcgEN6tC8vuYqUTa99Q06jk7sqlhgHfapdC
	QOlGxlbW/j4RxvZ6C9MfRQsc6KzvqWBTAhe7MjYEWM6d4N53XqKyU5bYLJLMerMDGvEc2hDUpG8
	PwacLY5jKtVthSretZU21RP7FKdlmDkMQPvgr1r8tK18kgXZ9Mz58EPaByaGEfVOB10BnFkA+LP
	/zbAC+GjsEYXZO1V7Y8vgqd+46qchY7ZdCeZkmrz6tz9Rw23N/tpJk8sOGIGzksF096vMNOsf9O
	KWYIwEDO9e71UXPhGcs0/KeZltfBU0KHKkA11iEAUo33vFQnPvIzz70=
X-Received: by 2002:a05:7301:182b:b0:36d:9900:bb92 with SMTP id 5a478bee46e88-3856f256533mr1246303eec.10.1795147446708;
        Thu, 19 Nov 2026 20:04:06 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e7f59sm3246104eec.6.2026.11.19.20.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 20:04:06 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	chleroy@kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCHv3 09/19] powerpc/pseries: Rework hugepage invalidate to remove conditional locking
Date: Fri, 20 Nov 2026 09:33:08 +0530
Message-Id: <eb366c26835d6451c6484c7cf20155264a9ad7d3.1795147055.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1795147055.git.ritesh.list@gmail.com>
References: <cover.1795147055.git.ritesh.list@gmail.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Clang's compiler based static context analysis does not work with locks
that are conditionally taken like in __pSeries_lpar_hugepage_invalidate().

lpar.c:1240:6: error: spinlock 'pSeries_lpar_tlbie_lock' is not held on every path through here [-Werror,-Wthread-safety-analysis]

But this also simplifies the function definition in my opinion - so this
is also a win.

No functional change intended.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/platforms/pseries/lpar.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index 94cd30e9f6e1..abd77c45cbf4 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -1224,26 +1224,33 @@ static void hugepage_bulk_invalidate(unsigned long *slot, unsigned long *vpn,
 		BUG_ON(rc != H_SUCCESS);
 	}
 }
-
-static void __pSeries_lpar_hugepage_invalidate(unsigned long *slot,
+static void __pSeries_lpar_hugepage_invalidate_unlocked(unsigned long *slot,
 						      unsigned long *vpn,
 						      int count, int psize,
 						      int ssize)
 {
-	unsigned long flags = 0;
-	int lock_tlbie = !mmu_has_feature(MMU_FTR_LOCKLESS_TLBIE);
-
-	if (lock_tlbie)
-		spin_lock_irqsave(&pSeries_lpar_tlbie_lock, flags);
-
 	/* Assuming THP size is 16M */
 	if (is_supported_hlbkrm(psize, MMU_PAGE_16M))
 		hugepage_block_invalidate(slot, vpn, count, psize, ssize);
 	else
 		hugepage_bulk_invalidate(slot, vpn, count, psize, ssize);
+}
 
-	if (lock_tlbie)
+static void __pSeries_lpar_hugepage_invalidate(unsigned long *slot,
+						      unsigned long *vpn,
+						      int count, int psize,
+						      int ssize)
+{
+	unsigned long flags = 0;
+
+	if (!mmu_has_feature(MMU_FTR_LOCKLESS_TLBIE)) {
+		spin_lock_irqsave(&pSeries_lpar_tlbie_lock, flags);
+		__pSeries_lpar_hugepage_invalidate_unlocked(slot, vpn, count, psize, ssize);
 		spin_unlock_irqrestore(&pSeries_lpar_tlbie_lock, flags);
+		return;
+	}
+
+	__pSeries_lpar_hugepage_invalidate_unlocked(slot, vpn, count, psize, ssize);
 }
 
 static void pSeries_lpar_hugepage_invalidate(unsigned long vsid,
-- 
2.39.5


