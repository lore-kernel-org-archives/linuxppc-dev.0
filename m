Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B0B60A2610
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2026 03:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VyfxyHyn
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVPNY3mkfz2ygK;
	Thu, 19 Nov 2026 14:39:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1336"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795059581;
	cv=none; b=VL7SLT5i0oK0CsnADEh1OPJ4jGjEfdDQhpbLvaoAwS0FLMwKvWsWXG4xL7WQHuzl/LPJntrVCC+o75LUsB79oZcWoZoQpmVg1mXDttLbPK5QAYmQxC+bdP6Q77vPTpg+jPGSRk+F4hASBWkNLFCo8Iz/jgUySuEVFABezVyA31k3m5foMUqQleSvfQYbsNdgFufAXFm30eSrBrITUbkY03PUuOdy8DoKEaKtlzfYkvHhU1RMB2M1ayaFlpSDay5hP/xN+y3ppTqUH7LbZ4d3ToAnVJhU267ntkv6oP/t1Gn53IEsXKcucOJP1QmziHWYBBQw/zUqjrVCSzkD5BBNkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795059581; c=relaxed/relaxed;
	bh=KZ81FuIDGfauj5HCBbvp9ZRfo5q4ugi5e4DfyuSEILU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=foRWBw5yUusED1Vqc6wUhkTBmRgLlcP07oUheySjErOgPbYsDtY26wGNYN/vHnk/3yALxKjUb5L6PKLBTRaECp9CoKPSitZZaLBhNTxVYWEs7KT6yb0SKhumi8Uv1BVXtqV60RLoX2lg/wj6MUN5BhevP59GPLMEL33J4ZLPnu3W3vd0LjIPHb4UpJ9k8vCpJAGGQywl+FQIQGceJeNdRNyRVNwPSUfw8OC7t6Y6re08MYhgpdb8c7o+ibsTU41PUPKeedBR3mCM9jsRZtKOS6b9Y3bljEuP5iwdA2Kz20ZXMftPsvX9pAg9605kfgv13jGmnY4/H9F8JSQJnF47pg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VyfxyHyn; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1336; helo=mail-dy1-x1336.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VyfxyHyn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1336; helo=mail-dy1-x1336.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1336.google.com (mail-dy1-x1336.google.com [IPv6:2607:f8b0:4864:20::1336])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVPNX6q6Fz2xlP
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 14:39:40 +1100 (AEDT)
Received: by mail-dy1-x1336.google.com with SMTP id 5a478bee46e88-36e99cf7bb3so2529079eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 19:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795059579; x=1795664379; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KZ81FuIDGfauj5HCBbvp9ZRfo5q4ugi5e4DfyuSEILU=;
        b=VyfxyHynCQwah68O3oxWx6bnAgtv+KhYrcupUHYv+fpoY3ZU+0KDFrY9+vMbfGUN3o
         Nt5UJTkmLUUr4P5gHwZQC2/DGt+IRwhmK4jNQG0TVRXg++kKVV2+UVO5CugNlbV8Ke+K
         aggXUflzM6k/LLBWQXZjnnkgXAGRIWSHJiK8uJPZKti/jlqo4KU2H7wkQiMw8R0QQOvT
         0jqrrx8pbYSlm7LrGz4OUHbFx4N1FaBjG9r8YbYCGzmgmuWjCLZl0+yEQfKz3TCVFSE4
         1VmM9PRoVuBrXrblZHfuPq3qETrSfzHeODhZ8wfkuaMWn1dmL4WvNo7VXo1tnkbSQgk/
         jVxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795059579; x=1795664379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KZ81FuIDGfauj5HCBbvp9ZRfo5q4ugi5e4DfyuSEILU=;
        b=o7hqmqVLSE13YEvCVzCfPakFM8BlGIJ4hIKLuB36PMuTABItkw5fA3ZYSx5FzbCyUn
         ux6oC9WsXJ2ydVAl4kMhwuSRZjdGm/axPGDS1DivoKkicc5IPTkgQiPJAUFDj0VqmbEa
         vGWVgPpfqO2YCPoa9zTiEXcq8Lahaoko2OvrZhvHn6pfhnISVaMcWqLJTpmtk5VsgbGs
         g5wzfAbSwwMcd1E6nZzidx1ikoJIvncfkgmOjSGrhQ6wH0UlSv3lS19nR1Eh1/FiYUeB
         cGKQF1qn+wHWiIf/zUkLKxLm1g6rmwcFSvjvvsiARwNRDp7GvfC9JBLII3XZN7VFWfov
         I3vQ==
X-Gm-Message-State: APuU4Z/uaZeMyq8NeeSlUc7eYXpKXCSzBrg3VCZIKlhS3eeUEb2BmAHJ
	7NbJAtfgLIfnLfyHHqWLNgzaWnv7u2KxkgBmGWeq1GJKgGVwHp+nf0d7zFkeYA==
X-Gm-Gg: AZFdTZf7so8CTdLPldkAu/H7XYa3AYhmIKVPOuh5F1wDDp+S9aNT04VeUcnB3xJEa4O
	yQW7a07WGu7wnRzHLoHQerWKj4L/P+CLynzcZMIRfvjTpOgphT8/yCDM43N/qYPODlLllOYzOZa
	sv7RhzmzAWi87DCBNy4qEOyPoI3wGNhtpnM8AsxMYDotEoeKawoTT6ayXga4pAwkCWjdEJ0LcWp
	0kHSlPE4VdXEggf/yopirmRGxXR/4co6hjCFxPIX+8zHp7Zbw/xzVJ7NADqRRybTc9Z5kzJOa2I
	l6jpAtDXP7l4v9DJtD34sP0L6QuJE8bHwrftuhh+3gLX9MD/C/nCUaqxDCYAZONdHNOl/oVBNbT
	IheBKAwBIGJ2RPHQT4AnvwyVCskpZKIe+/IzZaaEO9kjdcgqiJp3hTvl33MvHdHHWSmG97Tyk/3
	0kXv5D3nXHVaV9/9YrPxjfZGShqU4WucTrEXn72eAZTpSej98oS6qJXrKlv+kzT3vHQ6oJK0YwP
	m9aEc/exHlqneRLnyWIubqj6Id4TQOvHroZq2b4ZTTaRbF7vdnZKPCqFXLTdrwI92B/ATGWOHkm
	7wBCAgCrzi+/IeH2ZGDzCrARhGkxEyG+kw==
X-Received: by 2002:a05:7301:8613:b0:36f:a651:d649 with SMTP id 5a478bee46e88-3827d821472mr4316901eec.4.1795059578825;
        Wed, 18 Nov 2026 19:39:38 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a4522829sm12699465eec.1.2026.11.18.19.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 19:39:38 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	Marco Elver <elver@google.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCHv2 03/18] powerpc/mm/book3s64: Rework native_flush_hash_range() to remove conditional locking
Date: Thu, 19 Nov 2026 09:08:58 +0530
Message-Id: <0822917ce1c1f58fa3f5d398e3df8d876dcb7c10.1795058683.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1795058683.git.ritesh.list@gmail.com>
References: <cover.1795058683.git.ritesh.list@gmail.com>
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


