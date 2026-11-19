Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C890A606A32F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2026 03:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gUDooSH3
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVPNT3htZz2yVd;
	Thu, 19 Nov 2026 14:39:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1335"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795059577;
	cv=none; b=FwAjaAvpGeBIcAsGqsIit33boALeHOeyefKfwa1mOgCOGCGzcMoiyGpesWnYu+lBOpbEg997+CDcQkClpE/ve0C7/bBbAxyyVAIacpEyk76u9YpgBvNnDzV+WFV/Udski3mIU86P60efhkaOnSVjlSNZWKtM1/6J5eE41B7j5l8H7swN844+59S3xPcioWstSTZFl6Di/K4Tz63ax2QxwX/MZxMmMlXD1Pbjy+QMUP3uILzq1g9Wgcha4a4WuKPydW1BZGa/pT1ZQW5LeZRSv8RC8UMKAwmG++YpEY5hVnCM8Lo7Mk7nRurKlsV1I/QQwRtoCo7Bbnze9ZqnrUfIDg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795059577; c=relaxed/relaxed;
	bh=1fHiW/q9wws193uauriObWBGAQjMBTx9YeqyoW+PZx4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LQxNaXwVn5uVxjvWirKS4uCExmlWLWTjuej9ynSJ/cJ/Do2xPBw8H0eBcLhI1c6kp2bnx/6CL409qhPbP0GEZloUVxFeUkObkCiVQVvXJZc7QdXvd6cY36cb3xEheq7Aq5blj5sEer1fHxhV2IHIQX/17nWB9t9BvZ0pyfI6jh9pcr4UQ9p63Yj89VGwEl07WxOP81hpoSr/RbP3RU3y1M55ZRuDNWKJ3ltqyaHVMtS6aq8mr0DKTlvH4mSewzF3iGOBDJOOwMsn8K2ZU3BLEaUxviSnWBtRGmpfFCn2oFF5BLuaJgN2u87acaChoEhT2ikg/rK12ONWNi6mnWREbQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gUDooSH3; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1335; helo=mail-dy1-x1335.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gUDooSH3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1335; helo=mail-dy1-x1335.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1335.google.com (mail-dy1-x1335.google.com [IPv6:2607:f8b0:4864:20::1335])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVPNS6v8Fz2xlP
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 14:39:36 +1100 (AEDT)
Received: by mail-dy1-x1335.google.com with SMTP id 5a478bee46e88-37198ed3727so608712eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 19:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795059575; x=1795664375; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1fHiW/q9wws193uauriObWBGAQjMBTx9YeqyoW+PZx4=;
        b=gUDooSH36vcIw5si3H7LfEPHhz+D25QtZ7nw44uUZuloxc7ta6+s0OYXuu5XxoHNHJ
         y9xiDxKQesue9Ve8HTjcTJlPTNMwb3aVEToTRM9AbC16PWPJqgDktWI+mn8K50eUVdxS
         hA0/K9HIgC45+v2+6wI8e4Qiq1fB8LsApkuO0AdIvYOL0MdDOvhKRt7veryks7KwB/h9
         627NK2q2kdYfLBl9F8UQ7bw6o8Pq6yFz2SbNpVZmYZWJVefvYpt5En5OQC9rt7r3DBCr
         +ZYz4vqC+4uMLSQutc/H7IKtu9ytVTg/n8u47ZdpOsA/fBGeE9uclFOLtUYbCYK434Mi
         DH6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795059575; x=1795664375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1fHiW/q9wws193uauriObWBGAQjMBTx9YeqyoW+PZx4=;
        b=PiSqpM4HS0nOkNGsPxok8UjOhSXNXTmZLZcfEaVmOlnmPwAzdi6urXyhiyvmxg4Anq
         2/5Fmz1h9ZEZml49SfEm1xoBq+yJlE4BdqV4cykmlBXXBrGPYbbIZWibGuHHDvIb5AJH
         AN7CubCeBSXv5PemasQQFcBUB/SCvrg6+SQIB+KJjV92Tta3bErIqbCrY/3gc3rDqo6C
         ahnyUU/b4zFkOMqy6604jKlMnQZujIWUYW1PAC+IlK+sdcb6NwOFRv44D4X3HGG9bXPQ
         UDmVxdY1DhGf3Iq5FqjzWtq7dVA+V+9rz4pDIMITCDUk6XeKtWc81UvQD/MuZeUO9Q8O
         OrUg==
X-Gm-Message-State: APuU4Z/euKKAvT+vYjzWiGf53clRjx2luQL/hz6fDTlIwh9VCOdbyE7y
	nyy5YyNvDS79qfn17AXYQvhi9PuID/165Hx+Ujpn9TdjmDaRydY2nmB+6lQBMw==
X-Gm-Gg: AZFdTZd0Y2zD4Inhv+IZIGdXoNuLvfvXpBk4CxZEE3bdAU6B1G3t1z0HlNn9T3Ml3xg
	7r8d6YcMPiZG+/pASbTHA8j5oeeDMvm0Zn9dlICxA6g5fNp8faFM9od6QoJ0PrytExRE8bv212i
	vBah2+IZMiHYUSUMxd9fIq9UurTxU1Kiaoirl9EbitG9hYuoT+mVA3wmyix/ogJvPLXDV2DAVSe
	Gvqc5xyKjgQ21y27B/kXLJ9XLxzi/a+ePQ8XQ95F7KYdXyVl/ziICzJiovFmUg+HEVDpoCqXyw8
	0gJ1CLjhuzDWzDN5hZgOQfaqcwACEvXraj04q9NrptcrI/fQh/6I0oj2rVmSwIZmOIXxxxPagwF
	zawpYUf3jpG11lavai6+n+82MlZoQFzwgDaLk0SzhsReP9UhEpeT65ziNgI95tSzEmUi1f+ohlC
	uOgFYs3ByaSpCEsZhGKwmRc1SPO2D6F9OBO4qCdXvECtbgTBsIz5x78n0o7Wml76OUrxxAHWHa8
	RDZx0v4sevE9iC3kG35rFTgH7Ta/940L/yXgWFpVabv4Rh+g79CvhJJCFb+TWlp5zaAk9EoNhcL
	wiQjgQQJaLrNzgiHskcowkcnj6F0Lw7WLQ==
X-Received: by 2002:a05:7300:b197:b0:369:f17d:efb with SMTP id 5a478bee46e88-38445ee9e1bmr652518eec.10.1795059574672;
        Wed, 18 Nov 2026 19:39:34 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a4522829sm12699465eec.1.2026.11.18.19.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 19:39:34 -0800 (PST)
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
Subject: [PATCHv2 02/18] powerpc/mm/book3s64: Rework tlbie() to remove conditional locking
Date: Thu, 19 Nov 2026 09:08:57 +0530
Message-Id: <f6de49ee75ad37cceb9b67bc1d79ea64fee19258.1795058683.git.ritesh.list@gmail.com>
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


