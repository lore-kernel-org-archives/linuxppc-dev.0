Return-Path: <linuxppc-dev+bounces-28387-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C169C9833F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Sep 2026 10:45:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4htdHK4J3hz3bQl;
	Mon, 28 Sep 2026 20:45:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:3b::2b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790592301;
	cv=none; b=eR/b4f9ZlMmhflQ/EJ1RgMmWTbQLOmvLAB4L0LIe+RLLzKCD7IKTEZxcS2mhmOXhzXFMFGaKgvnWlyA3hSxnyGsKk+sf5SXWr2n8trDExUCRWkSfz2tBXr8tge8m59S5cMGgdwpTJBQxqo57hzZsMsnvgNCsMF3cUL5mfYj8spc1VAYpI2mkBWdan4GqLtPruve4mWr1r/sJBswaXSz2XGIo1hh6yfNfCBJev5oJpW7mzBhOZSAouIht9VpTSWjNoXJDjj45zBpi3ojdoPcLfZTfYUhDb2MFD3XzBnZW3t9MURDiAfyPNszBs2ynEnIVSkCFjLxDWWuZx+4PiLZnIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790592301; c=relaxed/relaxed;
	bh=1fHiW/q9wws193uauriObWBGAQjMBTx9YeqyoW+PZx4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mM66UlqqrUiFQZ8386Oml8r0C/AG6vHDExLcGwSr+tpEA9niwluNcoKOBtP5hKwxKr1Muc7rmMCeWN4AKPVwA4RRf3LxvcOtkbkL459FZvG+z3N2EB9NpiYV2XjJ8RuP2X0QykbAt0yCVyKBsHJEzuB9AaRHU5L5rqS2sTw4w5CtiP3Y+ipJsgIF08EtZUQf9obyXdnrjnLkXxyse4jDfNhJrd7Gz5cd2DDI56cY7tCbrWzsVXNJMXEfSdyBkP7u2aUgWrtXcShUlTm0p8ym8IP0A82xWnHUQDL3VtqbFTGkm1CKf/ROlvAtMHtDjQ3KTkkkyXNfIY0BJFSmQuuBNA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iIpztl2t; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:3b::2b; helo=mail-pz2-x2b.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iIpztl2t;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:3b::2b; helo=mail-pz2-x2b.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pz2-x2b.google.com (mail-pz2-x2b.google.com [IPv6:2607:f8b0:4864:3b::2b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4htdHK0FdYz30W5
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 20:45:01 +1000 (AEST)
Received: by mail-pz2-x2b.google.com with SMTP id 41be03b00d2f7-cc7979d1dadso1280279a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 03:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790592299; x=1791197099; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1fHiW/q9wws193uauriObWBGAQjMBTx9YeqyoW+PZx4=;
        b=iIpztl2tasGnDu+zxBEH/pLJYVPvDhQyjD3k9qbgBziR/xJ92e7GZafY6y6RTkjkC8
         1qb+yf/apyK4WuCHzaBAZVwGjdzmi1x9Kwbk/4vwQdmEK6EWShXz/J99EiEqhQZsnwGq
         Tr4v2BcYwUjIBEjQBVqZzNo0Lq9O/k/JFaXgKRxNhhVkzB7bR4dzwDYoekuIvi1QK8hU
         mSID1ulgaGObV/KM+uEkKY4sivmCd0i/eqTuT4b7XGAdwRPl3pqpsfh3s1qT6163Iqdl
         WGbodIU7LwIERV2+ltfCgRT7plBVA8nZLKgasoI49l24u/hcyNWqjvvluNZOQoVMZKxr
         fC1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790592299; x=1791197099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1fHiW/q9wws193uauriObWBGAQjMBTx9YeqyoW+PZx4=;
        b=bsRK+GAKj6Z9KMxy1Bpb7Z8LsmAUw6JVIR4mt5pyTvc9vuaIVT0CyQ5Hwk1s8spFlM
         A+eE5iov2NISAOu+G646Yr2Js1L3BEqJeKSvzF+mKOMbX6X7aZ+4nMshSVewMw5EHBq3
         YYLeY3qcRwAW4afheTJQwbv4uQ7wE+qhqQhg+762TZeMROZ71gHSdLmtA3ctI0Ucs7nR
         Bhk4N0ILpmEOef7O6ZGMgT9RQRI2Gb1/j0XuhEG6AylfeEJ/3wXhg7qXVySTDH9T6MVS
         PWfy5gSOh5Q18icsXhbRVZjgV9Oe2l2frzL1C54hkJXfGoIOqxi5CqpyMM+1DVKzMtUB
         NdvQ==
X-Gm-Message-State: AFq9FYL07TAaaRz68h9TWu6yZrWbY5FRDYKrEQuzCJMNpe0mjaiI62oz
	VoPyx/36eVfOwxDnVUnkDphdzFuPdbRhJGf8r9Nn2uCq6LwJaavVtMKPkea2WYoC
X-Gm-Gg: AYBFou14ryBbzSFVTFauo/ZsfW3YpO35fyPkXWurMe5nC+v8pmhrWRIhRwFK/Omzgw6
	K2kcVLBXOjPOYWdgxr5FrFFEzg9FpZIS+9suO4qbTygL+F1UzwB8XEibYRz20sNKjK9m9NlJIQP
	3pEqXWOJlQLBl96vwcLZIOLgr6qLFkPnFdB9p2o76daV6rlJy9sDTDljEgzz1zwxKfD0dZUwnvJ
	xpzVsaxwyI1Uu+8ygANPsK2rFCifm0DLDLx2qJlRPKIq2oMaXk2bjwhmPiIxADJw07CzSBmdks0
	7ZHR3lttt7NIyZ7e636+E3LqivYvLeRI0DnWY6UrfpdwKyaiLKQKyOCB5UJpk9nklGI9R8TTQW9
	hvY8T3s0Ug/LcDn+n7UpcU4TK50pRcnt7EvhQ/WWG4hMNgPyGrwdKmwTPEfBcWF+pw3FPtQfAB5
	Zwj/HEBMnbTRtf6kA3+yRAb8yyjpaRbzTMIGyCJnCHI/Ki42UshAT46/VJabIPd/y5yoav8CzgC
	f4OxitVHCTMSCUhzmaiSj4q1XUoRJnBTY5L0wk3t87ozpW8u6BsynJAl1Lh
X-Received: by 2002:a17:90b:17d1:b0:3a2:b4a6:929b with SMTP id 98e67ed59e1d1-3a2b4a694famr2547138a91.17.1790592299289;
        Mon, 28 Sep 2026 03:44:59 -0700 (PDT)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0976c8f8dsm27071975a91.12.2026.09.28.03.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 03:44:58 -0700 (PDT)
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
Subject: [RFC 2/6] powerpc/mm/book3s64: Rework tlbie() to remove conditional locking
Date: Mon, 28 Sep 2026 16:14:32 +0530
Message-Id: <382c79e2386e6a26044d813eea9c47df000d65cf.1790590014.git.ritesh.list@gmail.com>
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
 hash_native.c:235:2: error: raw_spinlock 'native_tlbie_lock' is not held on every path through here [-Werror,-Wthread-safety-analysis]
 hash_native.c:245:3: error: releasing raw_spinlock 'native_tlbie_lock' that was not held [-Werror,-Wthread-safety-analysis]

This patch reworks the tlbie() function to remove the conditional
locking. It fixes the clang context analysis reported errors. However,
this also simplifies the code around tlbie[l] - which is also a win.

No functional change intended.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/mm/book3s64/hash_native.c | 34 ++++++++++++++++++--------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/mm/book3s64/hash_native.c b/arch/powerpc/mm/book3s64/hash_native.c
index ab2a80e59011..6bad0545b57a 100644
--- a/arch/powerpc/mm/book3s64/hash_native.c
+++ b/arch/powerpc/mm/book3s64/hash_native.c
@@ -222,6 +222,23 @@ static inline void __tlbiel(unsigned long vpn, int psize, int apsize, int ssize)
 
 }
 
+static inline void __tlbie_sequence(unsigned long vpn, int psize, int apsize,
+				    int ssize)
+{
+	asm volatile("ptesync": : :"memory");
+	__tlbie(vpn, psize, apsize, ssize);
+	fixup_tlbie_vpn(vpn, psize, apsize, ssize);
+	asm volatile("eieio; tlbsync; ptesync": : :"memory");
+}
+
+static inline void __tlbiel_sequence(unsigned long vpn, int psize, int apsize,
+				     int ssize)
+{
+	asm volatile("ptesync": : :"memory");
+	__tlbiel(vpn, psize, apsize, ssize);
+	ppc_after_tlbiel_barrier();
+}
+
 static inline void tlbie(unsigned long vpn, int psize, int apsize,
 			 int ssize, int local)
 {
@@ -230,19 +247,16 @@ static inline void tlbie(unsigned long vpn, int psize, int apsize,
 
 	if (use_local)
 		use_local = mmu_psize_defs[psize].tlbiel;
-	if (lock_tlbie && !use_local)
-		raw_spin_lock(&native_tlbie_lock);
-	asm volatile("ptesync": : :"memory");
+
 	if (use_local) {
-		__tlbiel(vpn, psize, apsize, ssize);
-		ppc_after_tlbiel_barrier();
+		__tlbiel_sequence(vpn, psize, apsize, ssize);
+	} else if (lock_tlbie) {
+		raw_spin_lock(&native_tlbie_lock);
+		__tlbie_sequence(vpn, psize, apsize, ssize);
+		raw_spin_unlock(&native_tlbie_lock);
 	} else {
-		__tlbie(vpn, psize, apsize, ssize);
-		fixup_tlbie_vpn(vpn, psize, apsize, ssize);
-		asm volatile("eieio; tlbsync; ptesync": : :"memory");
+		__tlbie_sequence(vpn, psize, apsize, ssize);
 	}
-	if (lock_tlbie && !use_local)
-		raw_spin_unlock(&native_tlbie_lock);
 }
 
 static inline void native_lock_hpte(struct hash_pte *hptep)
-- 
2.39.5


