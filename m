Return-Path: <linuxppc-dev+bounces-28311-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F9B1C9830E
	for <linuxppc-dev@archiver.kernel.org>; Sun, 27 Sep 2026 14:34:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ht6Qt6Rchz30hp;
	Mon, 28 Sep 2026 00:34:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:36::f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790519686;
	cv=none; b=dCmrykmqLCXavHQ+wEwo0coCSwiCZemqKLWOkowWSFVjDJo5Q3EATd8ORe8GscrvLShUCsBExs1m+kdz0Lvpj1sXP7RNGJEX0dmvPKbyJu26szvxKQm+OJe/zugikABKqZ2ojDt0OAVXwr4Ce8izM1O/iyfsiRbhzy3IPihuXPGhX2usOhOJTRdRsroQ2kh4qCFp5ao915uS1spEzWKVrcMULd2Ooe6ACgm/OKQQxYT6Irq167pLtIlJNLDITmotLd5nO0nclZDAHGoZgX5RGUMnXu4Zs76FGWsBOhVZYBFbD+HVmYGDpB28girzOQhkAzOxbEO1PtfAiRjrcAJXCA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790519686; c=relaxed/relaxed;
	bh=JhDenXpiUHLZ1Ej69EgBT1lJ0mR2rE8poGppaQ4kv/4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o2cnkIwWCAX58hE/wlGRlDQNpjdW18wjh0aGQf+mTtXz3zCX8+yUMfS1+vBsB/ZxMO9gP9LMRjQaP9faAMBXnStTPlSg0v9ZiP+skO2ILvUS/l2tQI9XAn3uxBRMeVnZ/EguL/dg/mILlAcabQJHY6fCc+NghFwDIstHOjXMVtZR8rzQa8bmerCwcm2HcgxqTloXoZwaS5M8v+FriQuXNzmeIPMCDenBb6g/MAu5jAGj4UcxtjnOtfvin1gKwnRuC1xszwqzufBSUo/cEeVjaHWpo4y3mXCt4SS8f+AUQgomN2KHvYKBoddYkqNruQdJmIMNxHWevLlMj8JBIZ8bXA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ec9nMYeb; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:36::f; helo=mail-dy2-x0f.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ec9nMYeb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:36::f; helo=mail-dy2-x0f.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy2-x0f.google.com (mail-dy2-x0f.google.com [IPv6:2607:f8b0:4864:36::f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ht6Qt11Tbz30WQ
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 00:34:46 +1000 (AEST)
Received: by mail-dy2-x0f.google.com with SMTP id 5a478bee46e88-33e630052ebso2751552eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Sep 2026 07:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790519683; x=1791124483; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JhDenXpiUHLZ1Ej69EgBT1lJ0mR2rE8poGppaQ4kv/4=;
        b=Ec9nMYebcpY8o6qhc+RWkBemeN4QEbF3q3kvV4TM/TIuVOlsDH43vDDhSE2zocjbQ+
         zzojBNB7URRxjzvV+IRXE8lmpNSqE0zfEAbO2WXkxhcz4n1w51yh/E4oWIbKR8MU49XK
         u+fd4eUKynhscd4NgCyD+xcYkJgdu7+RhuKKSusIWGuEyHAvYmRTX9YIA5A3qFPeAM+F
         o0iNnX9wfgBHXDPDI4TGLXT7jbVgc9KcwM+3iLfvmQbJUJPM5DCn1eup+tR5I2hrL4+K
         FwQUJ+kqet+3NEqe9Zdi7GHxHmKD47LHwDctTBdCnSTHj0FfMmuCPPYwfAuduHCzFdOT
         x/BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790519683; x=1791124483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JhDenXpiUHLZ1Ej69EgBT1lJ0mR2rE8poGppaQ4kv/4=;
        b=lc/F+ZO7M9iWahGZGXaLHBqaO8zUvvvcvrcMKCNfcYbzgw21VYITwegedDza4rQBaA
         jMEVCA254Q/FtP5iNVjnTol0cdSNGqJACOVuMq7eCe0NTLo5XagmBAovfDP0gPfYiQg9
         T4QP9OddVhY0tmQsGvVeq/Wr21gGzWRAnuKT4GnbWWe7Tg6+j+hF4oUInJl8nrN1eFjF
         5K+6z2USOMkjQgGYMiguSxx4xcFLO0KG+ZiScdcsNX3wQN3UkAmznuHCiAcUrmCsI9Hz
         L12ifyJ4lZwL0l4hYpPsCF3exd2umJWZMJfXLBM5uVFxcW7q5xreI8j7EEuhzBgh8arD
         5EFQ==
X-Gm-Message-State: AFuF++nURju4oZhUT6l7ChBhGnU5vm6fa/Q5/nm9N2yfUGfWjEZrjTdz
	ON68hlVdWLq+YKMlmN7dOb/cNyRiVbXO2rDSSslqp2RGfoDAO3IRTCkJrUPlIQ==
X-Gm-Gg: AYBFou2AtRNoioBgYy6ZmvUbt4iKS+Gki7wQxt7kgt053jLlY+msitKBYEIyxmE/xZ2
	zAdDFG2B/RNZFNK3MzLU2AZ+gYTEskOJDTuIE0szFwR4UW0LJzjSI1CVNVzGIaZS93ra1RHiYXK
	GBw0Ukv70mpGEWi4E6O25yvJV12djuoCyOHia0pMwiQghbHmgkV6iOgYItP8wQhhZoDHvUzNx0p
	x6Tjh/okqhGZwXN+qw67p4a77RQigDSEXL1A9qEa660yebVBO+Wm50TpEvHqUGp4VnKKieiSfwx
	UioGDjY520VPcLNWuV86h5r6xCcI+nSDODgZfAO/kQSinACf3FDL/PEnI6k1Nr0ucM2m2+L9sJu
	lGq7vbRins8dmFgyLubheKmfaI5Cy2rd5PgFwkStPPHrjE2qiyybesH0kGLjgJTo3NA2kW5QHDB
	b5aWcXPVhMbVPoNdBZ6GV0VPa20/umsTcmZtkHeIpBx2P6obafMkzFcTN95qjlsDK0RKYY128n8
	eD5p0MoeVZIuD0boaWHnoY+laMnlyGdlU8w1nJYqF5XtOjZojFqe3d/bEZY
X-Received: by 2002:a05:7300:3e95:b0:33c:1fc9:3c17 with SMTP id 5a478bee46e88-34272c4f357mr6534823eec.36.1790519683266;
        Sun, 27 Sep 2026 07:34:43 -0700 (PDT)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34144b4ae50sm21869436eec.17.2026.09.27.07.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 07:34:41 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Marco Elver <elver@google.com>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC 02/12] powerpc/pseries: Rework hugepage invalidate to remove conditional locking
Date: Sun, 27 Sep 2026 20:03:43 +0530
Message-Id: <89d8ff14a479760d1a37cae9f7667a07feaad0a2.1790517984.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1790517984.git.ritesh.list@gmail.com>
References: <cover.1790517984.git.ritesh.list@gmail.com>
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


