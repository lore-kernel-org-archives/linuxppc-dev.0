Return-Path: <linuxppc-dev+bounces-28312-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4499C9830E
	for <linuxppc-dev@archiver.kernel.org>; Sun, 27 Sep 2026 14:35:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ht6Qz2TzHz3bVW;
	Mon, 28 Sep 2026 00:34:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:36::e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790519691;
	cv=none; b=ON7+fiRwH1IPj4THXG9gjg/kHBJDK2mBfQw6e55avhFkpK3g7Tk/86K9eWA4QMUcQU4A88NPEIVyEAbuQktSlP5WaF8PCP9/Guz5Zp9LxHP2QrgGKPfJ5UPXNC2P2UMyXa8Uo/YrUJGpH7wFRO0PRgq6iPRtusv+HoQCPBC4H1lxEXTDO7iQNPlXZbDI2cCKmA5JbN+5xlgjK7SGX7mfscVTtwSlaq7WRl24nxBpmDG9VXZgWb9pkTcxS6bnUHHsPNtYjpXaB/zMcVrJotHuWbxGU9ZGmohbp4vsSKdyKS61D9ljLMCzTMhW6Ir+WXsxry/RFg9Bq8rlmFQvpZd0CA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790519691; c=relaxed/relaxed;
	bh=YJ0TA9zWzvwNir1lTwHgRV/QvxzoCmjyNRgihgG2rcs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f/hcD+iDbII0TyMEx8miufuOjrTmp7I4wSAA2UWSm2KN+RBFDhuV6ICgq43hFBDiZzjzaeVZaT7txKFpnygM8J8/B9cVsY2zKpIwg+wcqHZRlXQuxdZzpxZySTqLdxQbPW8tT2NYOeo2lqhCmIzQh6IStUTWMGMvqH7kYrQLIptbQOUX2zO28VpEJ9I81ex/NKHyTjj5fNe+b64XjEQUiYVWhYHg6Lr80IxX1YcRQ6nKFbkACqTWq7sn+uJEqWjUMSIs3nvhUNP1VvlpCdiPdRBi81KiltvHMoRCDPeP/XW0nmXSBrvNY/S3SGRGiVgOj5u8UlLzaRzavIKG4pjXgQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hXEIUIlg; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:36::e; helo=mail-dy2-x0e.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hXEIUIlg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:36::e; helo=mail-dy2-x0e.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy2-x0e.google.com (mail-dy2-x0e.google.com [IPv6:2607:f8b0:4864:36::e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ht6Qy3KK7z30WQ
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 00:34:50 +1000 (AEST)
Received: by mail-dy2-x0e.google.com with SMTP id 5a478bee46e88-3413069aa25so1337928eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Sep 2026 07:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790519688; x=1791124488; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YJ0TA9zWzvwNir1lTwHgRV/QvxzoCmjyNRgihgG2rcs=;
        b=hXEIUIlgq6ZwUdNC4Cquu25Xr2qkarMeJtEbW+qIphBqsJ95zSnADZ33QseGxJ1ZWf
         jYGk9mBgULbfP+Wh9OFkdRnu4RkFa7MqM9wrIIEC11IKCLaszKCJsEIOcPBnj/NCz/dl
         Qsq8cDV/qEtuOqdDVG7SQRb6ctg/6bL40H3uAaoAYQTFsMDuJMT8+J46xhXybtruyWsg
         xeSgLIgjRhek2MphrmGzJUeq3r46y5nTUN+EEaoVfFcCycCy52oEF5lWxYST/9c5rdvp
         Ldejtmhe/c601T987UluX7wsbMzfSPmW5y2ZFM99lbQlJIfIg3zK/CtZne0zW74UeFCy
         Mk9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790519688; x=1791124488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YJ0TA9zWzvwNir1lTwHgRV/QvxzoCmjyNRgihgG2rcs=;
        b=JHGv4A3RxxUKh5qJ6bMEJtvkfuFlb0YN9kvbSg+ydKX5z679LYtUe1vUhylAQlk34u
         GT6202wafRB+wYBIV2mNWoQiSJ2lKmlcKdTkhD7839Tb7DBkqKFm9b80on9LF21hMICa
         XMPcwNaYSJKoYU5GItKLF8AXld+/AS2k5yTbN2cjVdQ/nn7jw+kQ+14dHs/gh0E47mv7
         xDCNZeEz+bYCsT5fSFnFPbk8T0g9ykv02VMoEz6E00HkPAIDJra6mltX4Y5F+/LypX/S
         Oez5AQBs3T+TxgB0tdeeS72OFDG98QfD/x/SEG+c6yKoNi0c9WPihqCHRMICdju8/8x8
         HCXQ==
X-Gm-Message-State: AFq9FYJGeCrhX7erO+Hd8qlU80ieZKZqcm+FZ6LWEjapMK3NkUfB2Bh/
	KTKcstgv7/CAlXXYRWU74c8zPnNiCVW+a/8o6xY6eKy+7Exfy9VtXEovaEqeNw==
X-Gm-Gg: AYBFou03xMiH0gFVSksypcK0J7sn71TantslFMbYJWpvm2/CsneJk0rCLW/onx14iUk
	JDKYYBOOHdQCF3E47zUDkY20j7EmKNFc6yAUi78o/vAW7S0jlr8u6mR0umNNkvbD451yGPhDcSD
	Okxf4hoDr2C67QrIb5w5DQtmQRK+IfRR1vil1X9oPoti0Y26HycDl9HJ3MW+PDNbHc9lj1aoEUu
	feZALBu0NbdWePuWwqRTesPZJur0bYLe7j4RAJjv+wUR7kNT5/+i9GajOGknuBAcndhjsTtNZiN
	0S3sasYCnWUJvaYlyWOguUge4efBMwLK/BFj1r3dvvHRwd7acpzAc+nCKqaFKfmpXKY0cb/N8KQ
	YBNdwk7wKMDvy/OVS+SURoWqMkiZ8oIbEX8nIt/9n7AgkM+T2U27KuUZ5eYXqdUP0nDMjV1w4E+
	Qr7bKlnAZUzksAMFFhqhCbgRNDGEA/NINb0ET0eE8OkCdY1t4IP04E0ADBeFxXxbqKfqrd/jz/s
	uPFZ4qNlhjBHQ57KpN9cZwUZVJbBQHLZyZOzxzvyJ3IA2y8d3s0ZOLnE1Lw
X-Received: by 2002:a05:7301:fc0b:b0:341:cada:34d5 with SMTP id 5a478bee46e88-342711ab268mr5858807eec.1.1790519687898;
        Sun, 27 Sep 2026 07:34:47 -0700 (PDT)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34144b4ae50sm21869436eec.17.2026.09.27.07.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 07:34:46 -0700 (PDT)
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
Subject: [RFC 03/12] powerpc/pseries: Rework hash flush to remove conditional locking
Date: Sun, 27 Sep 2026 20:03:44 +0530
Message-Id: <7d9814b4e5dfbec0038bf881f5efe2e062299350.1790517984.git.ritesh.list@gmail.com>
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
that are conditionally taken like in pSeries_lpar_flush_hash_range().

This also simplifies the function definition in my opinion - so this
is also a win.

No functional change intended.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/platforms/pseries/lpar.c | 31 ++++++++++++++++-----------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index abd77c45cbf4..5dbf447d3a83 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -1526,28 +1526,19 @@ void __init pseries_lpar_read_hblkrm_characteristics(void)
 					bpsize, idx, hblkrm_size[bpsize][idx]);
 }
 
-/*
- * Take a spinlock around flushes to avoid bouncing the hypervisor tlbie
- * lock.
- */
-static void pSeries_lpar_flush_hash_range(unsigned long number, int local)
+static void pSeries_lpar_flush_hash_range_unlocked(unsigned long number, int local)
 {
 	unsigned long vpn;
 	unsigned long i, pix, rc;
-	unsigned long flags = 0;
 	struct ppc64_tlb_batch *batch = this_cpu_ptr(&ppc64_tlb_batch);
-	int lock_tlbie = !mmu_has_feature(MMU_FTR_LOCKLESS_TLBIE);
 	unsigned long param[PLPAR_HCALL9_BUFSIZE];
 	unsigned long index, shift, slot;
 	real_pte_t pte;
 	int psize, ssize;
 
-	if (lock_tlbie)
-		spin_lock_irqsave(&pSeries_lpar_tlbie_lock, flags);
-
 	if (is_supported_hlbkrm(batch->psize, batch->psize)) {
 		do_block_remove(number, batch, param);
-		goto out;
+		return;
 	}
 
 	psize = batch->psize;
@@ -1587,10 +1578,24 @@ static void pSeries_lpar_flush_hash_range(unsigned long number, int local)
 				  param[6], param[7]);
 		BUG_ON(rc != H_SUCCESS);
 	}
+}
 
-out:
-	if (lock_tlbie)
+/*
+ * Take a spinlock around flushes to avoid bouncing the hypervisor tlbie
+ * lock. Firmware with MMU_FTR_LOCKLESS_TLBIE does not need it.
+ */
+static void pSeries_lpar_flush_hash_range(unsigned long number, int local)
+{
+	unsigned long flags;
+
+	if (!mmu_has_feature(MMU_FTR_LOCKLESS_TLBIE)) {
+		spin_lock_irqsave(&pSeries_lpar_tlbie_lock, flags);
+		pSeries_lpar_flush_hash_range_unlocked(number, local);
 		spin_unlock_irqrestore(&pSeries_lpar_tlbie_lock, flags);
+		return;
+	}
+
+	pSeries_lpar_flush_hash_range_unlocked(number, local);
 }
 
 static int __init disable_bulk_remove(char *str)
-- 
2.39.5


