Return-Path: <linuxppc-dev+bounces-28388-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65C43C9833F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Sep 2026 10:45:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4htdHQ4xTjz2yb9;
	Mon, 28 Sep 2026 20:45:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:39::f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790592306;
	cv=none; b=IZ9v4/AO04q64xo3GqyXTMlqo1bMoIZNkDs07/A3AFjm/J9T2tPH1GVEhyizSbMYVTUR21nqU0ciAZeW3KbkEbsQRZ2/KMLb/1KhO0fONc4nRuQjFVr5bXGh2RDVgTVwIj8zE468oZkVeq71gCrs6FpVW4IAcTZ6Q3Bo3v7NFxjqcqX1LJQjEKoxR45Brhqnf17X0x/e7EjGmyUz7Q4Wck+oUyI3+g/85E8tfeYAkx/R5ovHNJjYB8tMe4Fk5SiDEn/lVdBXNpDZ4up0yKgHadRR169uzR4Vio3CkKrXkBkeXvd3wRQY57nAhr0kd2P/aIjjdyF8NX3MM8av959Pzw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790592306; c=relaxed/relaxed;
	bh=6nhZd7N235luHnJfPOH6Xak26dN5Lj4klTBss1fGrjg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XTr3DmwaqdZplz4RRqm26YHYjVTIl7pKl+WuQaokuu6jK1z+UNJ+gIrJeQaOKX1+u7Zif2xc0ge6ITg2bNbx0AZrznxUmXklLM7HS67k2TL/I/s01kOtYb5qYBW7QiqSxk26651BKrY1Jng65Dvac1npjB/ifAkr+bcIh0uZpwMwbK5b1kmML9duBPyYFCuyQKOzdNPicno94eqlfM5AhUG/f3QWdYn56eMD4Dv0M38h35TmZjDwaYQ1uBEqeTXAl/XbdHuhP8SqQxfumf83ngGSuLHmPEKYUhj7NrOewHE+NDovMMjRrdXncGupDeKZQxSOXfKrLY9doV9zZRybOA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jvoxdO3O; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:39::f; helo=mail-pj2-x0f.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jvoxdO3O;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:39::f; helo=mail-pj2-x0f.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-x0f.google.com (mail-pj2-x0f.google.com [IPv6:2607:f8b0:4864:39::f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4htdHP6smjz2yMK
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 20:45:05 +1000 (AEST)
Received: by mail-pj2-x0f.google.com with SMTP id 98e67ed59e1d1-396ccd4f99dso1852649a91.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 03:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790592303; x=1791197103; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6nhZd7N235luHnJfPOH6Xak26dN5Lj4klTBss1fGrjg=;
        b=jvoxdO3OTfeOjIJD3dWuFtFF4dnzEdhGT9ZEN1KomNmlpL1Kpc3HF3hhW3FZycv8XM
         BCcmAG+LAva/hMDFWhX3Zz/wLVPRPC0cCdfEze3VL5LCotzd/ecAxBvjgEXAYyEpTNCL
         9K9czlG8KeHkxieKHxZPNyScibbSesPt7dDpnXsGQupfbAzSdMHIsJH91MsmKGSNxl2H
         zP9e3ItVxfVuLi/yAh1qIuXUDrzLedWpvYut8oBilMeJv0AdZ81XKab+xD2Y7X+oR7Qx
         qgYu934r5NOnSrhdxo4qAbn5M5hDqaC73Gu/8cYQCbVVgFjMyVVPU/cReKvuv0LXAPYe
         EDKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790592303; x=1791197103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6nhZd7N235luHnJfPOH6Xak26dN5Lj4klTBss1fGrjg=;
        b=S7JTNsuH1Yted0ILVVZDr8/EcRb5emTwbH5BrWdyV7gARCNRXrX5cu64OGOfUY4dyF
         Mh+nYUbwysBV7OUq0NHorxRxhg/VIH7V3tGsgdVhVA65PELSktDRnEwLAhj2mIsQ/k1t
         WWmnYM/W90BJd7S/0zloF1JTzRJSocc13Hm1Werl86uH3lBzgt3n6j3HmGZoYgmL3bbT
         A23tDDdl/z8Zi+5Zli5tYfeEXUU+D06Ix+6CAzL0AudOFs9Os6TW2UTJpa8+9SBrErau
         kYgzYY7iNVj4POq/NQhqThLS9Xn6yeVEkeB9AY5rlUn9yXNOHLui6SpxCtdiirpgQgZK
         4gqw==
X-Gm-Message-State: AFq9FYLdRw4kh74x5KbFzit+26IsuhRJiTw72ZMCHXiy3IU4ex1dtBDH
	N5vy03dIvnUZcI2poAvj3ulSDuGpO/pTdnQVBZG1pvOxrnSPBk14CAePjr73xYeX
X-Gm-Gg: AYBFou1P/R+vWmXIwAcgWrqkEN99aZF3R7WPnB4peeOsgJR1pIIxmOdnrGtnBVfG5SB
	GcYIOdiQKvgni5iWXyMwSzDxq7DF4Exi2AkgSYuMXmogQ9WNk8+DTwy+q9rb3Vz/gfSBYBZFc1M
	o6QPYO6taFQeraWAxJaW1TA3G/PNmI0wQMJz1TPqw0M3dvC3jbNZF/hFJQ+IwGrv6IKUpydL1R9
	16VzMFPDwWoK0EWgQbRjq6mcn2VejbhHfJCZBuINoKVrHJuS4+a2XuDhZVO+leuHFJFrjoT9vBN
	hN7qkaO6FmLsuhvzatrGwpYBc6wYrF20x69SfJRvUXmtBp0AqBYnLgJgLP1KR9PwimTZBWuPe35
	/nZACBiY7LED12OFbPuqm14v+g84b6wWNTQJpRsNm6xglj9Ms2T9PX5NvvyjLOcUy5dOELbZ8gQ
	IB3NpVIlp+NarnHTx7B3p6EqTpwurkrY9NFLdLQ2u+VwvF0KVNCYH054Pzrskkam2CDeMgEpRfQ
	p/bJFwCPFFF0h90MdwbwWQdPL3nv+68p9UlEZX1WtnlLYPaXi7bDUrdcI8J
X-Received: by 2002:a17:90a:e7c6:b0:39e:2f57:67c7 with SMTP id 98e67ed59e1d1-3a098d45c0dmr11577243a91.3.1790592303327;
        Mon, 28 Sep 2026 03:45:03 -0700 (PDT)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0976c8f8dsm27071975a91.12.2026.09.28.03.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 03:45:02 -0700 (PDT)
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
Subject: [RFC 3/6] powerpc/mm/book3s64: Rework native_flush_hash_range() to remove conditional locking
Date: Mon, 28 Sep 2026 16:14:33 +0530
Message-Id: <6e1255f9927b2714a5f18c15971a70791b26b068.1790590014.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1790590014.git.ritesh.list@gmail.com>
References: <cover.1790590014.git.ritesh.list@gmail.com>
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
index 6bad0545b57a..9b4eea35b540 100644
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
+	unsigned long i;
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
+	unsigned long i;
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


