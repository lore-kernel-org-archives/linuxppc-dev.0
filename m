Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D708E606A33E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Nov 2026 04:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SF6GYDNz
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jW1sn3QTVz30NF;
	Fri, 20 Nov 2026 15:03:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1233"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795147421;
	cv=none; b=KVXTet/uu0PRhWHhkgNnoh/xTwHvo7iQXxN3CxSasQAw1KLmTT4rIQ80pKutir2IbYN+jKoMGlGFud9N5bUNfZMzNd/1YdiIZHn3rLXVjStMN7FWFgAyBTskP63OCmOlYwwqytuYXfTsmOc0/6hOsS4Prlo/ckUOXFyIl082EikFKJ6l69JkA6N61dfRvRWkctkkZ+xEhYnOk0tRS9OI8aRp5F9RzyYpqHsUFLnQCD8oBZBnxG+runpkIWcAri+sz4L/1ANGoqXozIJxPUm7H3hlq13J0+uO7p+FK+zr876dS9Is1/vNI6Dk+AwNRvCK12XdXI6eqzWzx0h9+PDuUA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795147421; c=relaxed/relaxed;
	bh=1fHiW/q9wws193uauriObWBGAQjMBTx9YeqyoW+PZx4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FKHWc79kZTm+b0A0gplcNt5phwFneCylqQptaF95ilsMtsZH2Snsvn5IPffeDaMw5eIC2zhF7RdP6ePpltZfZ0L2EU5loDfYeY7PJXte6uEXzYxN+TaufnRKjsVRdajQgHOWwNkSKmFr0KmSyCsNIXQHo3M+SkniImCBZvrYDEvD0zzKmVgzLkpnntvFZDp53WDYpLNrh+kJ6h1tzFJ+tWJFcQYUfy4Z4o7SnNtXdjFQ9HzOPJR3dOGm04cSak9XEUwHc5gm/HFWx8ricwlqVlHZnsuMZEtdf63AhodRfx3aMpQGBAGUN9CFaIes2/PMbWl1jN8BPBaXxuV2ohkMaw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SF6GYDNz; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1233; helo=mail-dl1-x1233.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SF6GYDNz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1233; helo=mail-dl1-x1233.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x1233.google.com (mail-dl1-x1233.google.com [IPv6:2607:f8b0:4864:20::1233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jW1sm5Nvqz2xHX
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2026 15:03:40 +1100 (AEDT)
Received: by mail-dl1-x1233.google.com with SMTP id a92af1059eb24-1b3ada81853so530982c88.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 20:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795147418; x=1795752218; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1fHiW/q9wws193uauriObWBGAQjMBTx9YeqyoW+PZx4=;
        b=SF6GYDNzEqq1XdehNBl/+Okc+kLlGLqcet5HrDXBBNM18YADKekBtGR7ZZeznUn2lQ
         iCavjPQj/80WbE89816O1Zy0wj/VG6guOrNNTlZfjLvUsuFLmLfKxAZKeErxYb80QCAm
         QS6cUZwMehpEDuOH40rFhIP4Di/djDorWDfEt+9GH6VKsr6PVjfFWCVRfuudhaYN6uWJ
         sd847zkBCLinRfXIxuTbvD9UXgIzzK96VVAkBVjAZTv2CqS8z1/jDpsPRrGhzbajBiR9
         kWLYG9ARS1lTq74Z7ukpCRk81AnlioinrrtCKOo8E/uGPK+RNfvOBWuARKAnaeYocfLH
         Gipw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795147418; x=1795752218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1fHiW/q9wws193uauriObWBGAQjMBTx9YeqyoW+PZx4=;
        b=TXeED8r5pJYmGNTLq0Kq2yKdDvdLgxN+0CmmGjnBitiakYNVPqByuqyr6TawitJDOF
         hmfh1Kwva0ecZ12xTFeH+cptnHCtMHluvm4yQPFPeWT2B6oVVAWv5azxeu4XiQX+y4fj
         ZzoA9eMELGtmIt0NpsQEfsUMtWe5iszAXmhhzDOgnT87ikVbTqF/vo1SC1UaAl/K/Dzt
         vmIirZGT+4QyzyYvXCH91tl9RzQJVZgbf+f/sAL36xiBH9VYeegxcYqokANtfRkmSptM
         ZH7o8lwZPBiTJyhyPa1DVU/RTrj4NnqzHhEoeohUOigW52Xtzv5pLRQBdMMWrCDfgBex
         gSmA==
X-Gm-Message-State: APuU4Z/UyddD0ZH4xn+/fJvXGMrnG6IWvmxiU49H2vjsKCVrvW0ugpIh
	fBsjiLUzHKOFHCHflBoliWka1SUISKFUmcSLIphWTm1nNA67YVTSbYMgTo9wpQ==
X-Gm-Gg: AYBFou0fhdhFZVvsa68E4YlkKKkirhAoAFpBa4aynLY+JY3vfqTo00Qu6oc9XzVXGA+
	CG+TX8i2HNBoc2JyzQqT5easImTEzc/LJEDd1yDbws1ctfD8z1ZbBNJVY+D9il2fdXGCtnJF+I3
	HzX8EHZ2A59/1E8+BffyMmW6HiTDrjJqvx9IuA/QqxtbVeXWPeEQLbHfp6rXCXfDrarZjNuuoGT
	vlVocNnzm5GZe6OuQD20oxFHwCP6PYFOsHQVwQ6VDNP7X7pCWJQX7Gtw22b3+GZOfdMP3KgoEyr
	/+VfPqAkUlzFy5miqW07hoAhXqNDVsUj5NWhSZkJQoQp/d3ZfLk8Xi1WkujBxu2/DxgrCB8gOWe
	qQ+O7Tkcy1WCeuZ7ldkpm/GKptf5kcUcvzRsQfD3ZijY/az+vQTtaPiYZqKNeeOUPHuj+1rtGzU
	Drbjei+VNiNl3s3EvjJAyxNNMHphcUmzZDKTo5pAX5oG5EO8vuuiBBrvVqE+1ynU9XxQeu9ay2u
	mz1/6InXmVyEPcgru8U/c+4tQ1TcR/B6iTsKjC0vOR8eEvk8p/NrM/Q5oMTw/iUUgWhU41fZH3R
	Pb+0rvvwb0DiyEBCiABJC5s39qz4OuuKsYY=
X-Received: by 2002:a05:7022:290:b0:191:444:425 with SMTP id a92af1059eb24-1b5567c0fbdmr1640506c88.2.1795147418460;
        Thu, 19 Nov 2026 20:03:38 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e7f59sm3246104eec.6.2026.11.19.20.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 20:03:37 -0800 (PST)
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
Subject: [PATCHv3 02/19] powerpc/mm/book3s64: Rework tlbie() to remove conditional locking
Date: Fri, 20 Nov 2026 09:33:01 +0530
Message-Id: <f6de49ee75ad37cceb9b67bc1d79ea64fee19258.1795147055.git.ritesh.list@gmail.com>
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


