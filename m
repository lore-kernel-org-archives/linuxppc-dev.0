Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB5C606A336
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Nov 2026 04:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yPkJyPPB
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jW1sx1dVcz2yQl;
	Fri, 20 Nov 2026 15:03:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795147429;
	cv=none; b=nhl4Kc0VFiSXkmNhTQPLtFQXpOKjbiI5GsFbeDc///pEOGJd2RBX4hOe5+zf+AI0LR58Wbt/61hDO2USyBM0KRjTpR4iWpobeMmiJ4tBnXxRxJWLCvjHf1i4wlZBpTWJMHMFXsDvRTJjpFJVVobLjCASpt5eJ1PDp0OGZAKoueIxtYgUxYxuQgV/9c/sL0X5p2w46IZZMPPAFEE/x0ISMmDxK2G3JbsCtPzBFi/tb6sxS9WE7gsYOPVNfKse+zQLEuGjYAHOa0Q4ixGCNg7hi96pgjEC4q9sChD21vUQMSXyIvDy7Tm3NtVElk7O9k53qGQcSdHTfRo3S6zzMmar5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795147429; c=relaxed/relaxed;
	bh=KZ81FuIDGfauj5HCBbvp9ZRfo5q4ugi5e4DfyuSEILU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LWY+kr+mSQ8SIjfxTQh+4zccdLXPAvSudpzYRF3z2dO7u+0FpzFZTTjBDimqN19yhlacFMCsmx3DlNpwWbqEhJSj64Lu5b0h0xDCzzwXfaw8kc0D+PlJeWke0r63Ob00bI0Eir1TdK/prZTcKXR3Uo+5LqgeVWLyezgmMA9qukCi5odursGwR3YPDAUQkshAo/73C4bkhdaqCtKnOUR/1/54lIpNZOrvHJFC4WmpDAB9Iuz5QcbymoJObc6sRUZIyHzugIWzWRb9vNjIcDcsJvtHZsZ3hVVXwjbP/Gt7c5SSE1g3EQLQTXpV862H+qaFszFb6MJ4Ud1vC28rmNAXZQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yPkJyPPB; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132b; helo=mail-dy1-x132b.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yPkJyPPB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132b; helo=mail-dy1-x132b.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132b.google.com (mail-dy1-x132b.google.com [IPv6:2607:f8b0:4864:20::132b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jW1sw3BFvz2xHX
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2026 15:03:48 +1100 (AEDT)
Received: by mail-dy1-x132b.google.com with SMTP id 5a478bee46e88-372bdb942dbso581580eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 20:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795147427; x=1795752227; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KZ81FuIDGfauj5HCBbvp9ZRfo5q4ugi5e4DfyuSEILU=;
        b=yPkJyPPBqC/LiA7yBkeo1V0xrPKUmER6SGRo9PjnVpujsvV9v+deVu2AZ1XGmDr/jq
         S0mEZ7g4/Q6AdYfazf28BR4YERGq/0+KuUIpqO770ohFs7SjECD0+fd7r49UoV15DatC
         RPQoDPkX0DZdNFSg5sWJTvq/2dGaX2OrXmyknQvh950ev1KGN9CoGfvP209nhYK0H6G/
         Vg+Nahwf1r/+FA97xgDgT+JbJ/rkd7Ksk1q+AeFqfrUKzcYGm2NySx6RjmuqkCVeNDw1
         Ww6yZYvKQpmcPo6M/0R55M1wYEX6KFhWQ0zbK+sx4t7x4kncYiFynVBuJNZr9rANT/WA
         m+Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795147427; x=1795752227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KZ81FuIDGfauj5HCBbvp9ZRfo5q4ugi5e4DfyuSEILU=;
        b=wYAbCVxIpLzsatii7laLCKYgPMxIYXyX3SK2vNldWy+nL+YtNLHGXoXozsSmWaDN88
         kPY3XKwOpqd5AYVknN3FkFVdvCYh2NN3XS83DlGuPcQsHI7q3pHzyPzsHdOKR4lVGw9Z
         k+dqLUWZV35k+o1f0w7NXeu1nJPKzmYAwxu/taGVBaQJph/mChkWq2CLBA1Jq8/IHgwN
         2aK4sFRL55rNyg3BA93aICa9Xaf8GJ5e4rxsZN0b0RG3GOOv7sv9SECWLDnaPTV3+Im/
         YLUQDLmSx3K4+za6K078TnSEjwKWDO9jUvLuN/LagiyJBu7LeYWFmOgnNF4VMkRmr3R7
         kmIQ==
X-Gm-Message-State: APuU4Z+Gcv5/gpQUvXYVmSuOvT3NhOXhv0TpJi1Dx8qWeqUYNzXqbrBK
	2AZNvQvqPNYTv03pmws3LzMQsdXrjokaw683rouhWHGTDl+c0GJm8EXboczJVw==
X-Gm-Gg: AZFdTZfAr9+FDlaktSx4cPNyh+NoeINVFeXlPmLWqBJFmcz4XDQBZRiuTcZPFtnBwCa
	+xVJ8O/wSaVVDE5Yaze/oLbZz+LfJfqNsKWoy6Z35wZK9/AQwGrjXrk57HzULgpowgU1IM9/rdA
	mL0gIsz5XAxBLUAZlXgcFtqje1CILjhBuY3i+i++ZiIAspuCxw00atAB8SFEqPm3DFpZoPyD9zB
	MkTGDFwn1buEPPNjJ+O+x98bZ1WeSi8HlrBWLf699/3oOq0r+yJZvsIXLnD+VSU5vh5+me1Zh39
	DIO2DQWziruAs+3jfhFuXkfNuK42ToMd0Bqwnen6Gsz/mZhnRzturRfy5ic+2imJxiT7HFi/9bB
	I7r+8iKUy+7WalM94q2MLDLix7NMrIXR6kU89aDl3NDL7h3Btqb27ceP+T2wiMT4iEuH5akHgfz
	ROVrZY4ncNtTuOGxAmciFurWe0eD4e3Lv69N0+ssQXdLU4z2yTEjabkxMA75VeWaJMSlfCH53Jl
	0IZTVrFty566uHvcUlnx+9jg9gUDdr0yQKu6YMAQJU7Eq/RMecKWIIbpJRer7uVMgou1C6aSGYJ
	J/xkG0vkIrxuyMbOwaRmKF4Ze+fwso5Kaw==
X-Received: by 2002:a05:693c:83ce:20b0:369:f961:ccf8 with SMTP id 5a478bee46e88-3856f65e0a0mr1698374eec.19.1795147426535;
        Thu, 19 Nov 2026 20:03:46 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e7f59sm3246104eec.6.2026.11.19.20.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 20:03:45 -0800 (PST)
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
Subject: [PATCHv3 04/19] powerpc/mm/book3s64: Rework native_flush_hash_range() to remove conditional locking
Date: Fri, 20 Nov 2026 09:33:03 +0530
Message-Id: <d485e7b2a344ea9005f69072086c3c1f214f7695.1795147055.git.ritesh.list@gmail.com>
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

Clang's context analysis reports:
 hash_native.c:851:2: error: raw_spinlock 'native_tlbie_lock' is not held on every path through here [-Werror,-Wthread-safety-analysis]
 hash_native.c:868:3: error: releasing raw_spinlock 'native_tlbie_lock' that was not held [-Werror,-Wthread-safety-analysis]

This patch reworks the native_flush_hash_range() function to remove the
conditional locking. It fixes the clang context analysis reported
errors. However, this also simplifies the code in native_flush_hash_range()
due to various if conditions.

No functional change intended.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/mm/book3s64/hash_native.c | 88 ++++++++++++++++----------
 1 file changed, 54 insertions(+), 34 deletions(-)

diff --git a/arch/powerpc/mm/book3s64/hash_native.c b/arch/powerpc/mm/book3s64/hash_native.c
index 6bad0545b57a..2a852dd5049f 100644
--- a/arch/powerpc/mm/book3s64/hash_native.c
+++ b/arch/powerpc/mm/book3s64/hash_native.c
@@ -792,6 +792,54 @@ static notrace void native_hpte_clear(void)
 	asm volatile("eieio; tlbsync; ptesync":::"memory");
 }
 
+static void native_flush_hash_range_tlbiel(struct ppc64_tlb_batch *batch,
+					   unsigned long number)
+{
+	unsigned long vpn = 0, index, shift;
+	real_pte_t pte;
+	unsigned long psize = batch->psize;
+	int ssize = batch->ssize;
+	int i;
+
+	asm volatile("ptesync":::"memory");
+	for (i = 0; i < number; i++) {
+		vpn = batch->vpn[i];
+		pte = batch->pte[i];
+
+		pte_iterate_hashed_subpages(pte, psize,
+					    vpn, index, shift) {
+			__tlbiel(vpn, psize, psize, ssize);
+		} pte_iterate_hashed_end();
+	}
+	ppc_after_tlbiel_barrier();
+}
+
+static void native_flush_hash_range_tlbie(struct ppc64_tlb_batch *batch,
+					  unsigned long number)
+{
+	unsigned long vpn = 0, index, shift;
+	real_pte_t pte;
+	unsigned long psize = batch->psize;
+	int ssize = batch->ssize;
+	int i;
+
+	asm volatile("ptesync":::"memory");
+	for (i = 0; i < number; i++) {
+		vpn = batch->vpn[i];
+		pte = batch->pte[i];
+
+		pte_iterate_hashed_subpages(pte, psize,
+					    vpn, index, shift) {
+			__tlbie(vpn, psize, psize, ssize);
+		} pte_iterate_hashed_end();
+	}
+	/*
+	 * Just do one more with the last used values.
+	 */
+	fixup_tlbie_vpn(vpn, psize, psize, ssize);
+	asm volatile("eieio; tlbsync; ptesync":::"memory");
+}
+
 /*
  * Batched hash table flush, we batch the tlbie's to avoid taking/releasing
  * the lock all the time
@@ -845,41 +893,13 @@ static void native_flush_hash_range(unsigned long number, int local)
 
 	if (mmu_has_feature(MMU_FTR_TLBIEL) &&
 	    mmu_psize_defs[psize].tlbiel && local) {
-		asm volatile("ptesync":::"memory");
-		for (i = 0; i < number; i++) {
-			vpn = batch->vpn[i];
-			pte = batch->pte[i];
-
-			pte_iterate_hashed_subpages(pte, psize,
-						    vpn, index, shift) {
-				__tlbiel(vpn, psize, psize, ssize);
-			} pte_iterate_hashed_end();
-		}
-		ppc_after_tlbiel_barrier();
+		native_flush_hash_range_tlbiel(batch, number);
+	} else if (!mmu_has_feature(MMU_FTR_LOCKLESS_TLBIE)) {
+		raw_spin_lock(&native_tlbie_lock);
+		native_flush_hash_range_tlbie(batch, number);
+		raw_spin_unlock(&native_tlbie_lock);
 	} else {
-		int lock_tlbie = !mmu_has_feature(MMU_FTR_LOCKLESS_TLBIE);
-
-		if (lock_tlbie)
-			raw_spin_lock(&native_tlbie_lock);
-
-		asm volatile("ptesync":::"memory");
-		for (i = 0; i < number; i++) {
-			vpn = batch->vpn[i];
-			pte = batch->pte[i];
-
-			pte_iterate_hashed_subpages(pte, psize,
-						    vpn, index, shift) {
-				__tlbie(vpn, psize, psize, ssize);
-			} pte_iterate_hashed_end();
-		}
-		/*
-		 * Just do one more with the last used values.
-		 */
-		fixup_tlbie_vpn(vpn, psize, psize, ssize);
-		asm volatile("eieio; tlbsync; ptesync":::"memory");
-
-		if (lock_tlbie)
-			raw_spin_unlock(&native_tlbie_lock);
+		native_flush_hash_range_tlbie(batch, number);
 	}
 
 	local_irq_restore(flags);
-- 
2.39.5


