Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F5D606A33E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2026 03:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yHNoJ+9e
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVPNy1mZpz2yLg;
	Thu, 19 Nov 2026 14:40:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1330"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795059602;
	cv=none; b=GbR+/gVAQHVATriGjmedeiqcyTkEetL5HePZsHSRbJuXfQOdyhw2dQPH8RZxJaBDWfgqdBb1ZK4NwDFpsWLhctFTFBVqEViu+wlH4jev8U/wKPVmwK0IQUR6Q48fb2N7eCvX8gyS/ymC4jWRvvtx7KhfeJ+XBgWVw2sRW0LyEpxFevJcdyEHzFTaPNSII2Gi0uSRvch71ModWxNvsyAdoZ+XT5lKkfq53Yp37dtDFKS7FdSZvChCU7ZznU/kk6SC5qOdFaLcfmpbFGaOYWaT7zOFS1bo+QOA70VJgkfbGCFAyaw5UX+6cke+Cy7xt+ly4O2ZBk/CzmkruQbMP7tGMA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795059602; c=relaxed/relaxed;
	bh=JhDenXpiUHLZ1Ej69EgBT1lJ0mR2rE8poGppaQ4kv/4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AOZjQVJ46dAkIWJCkQzkhDaGf12dhx6wjSiSToY+mynlbsyRI18Qz32MroAq0VIuy3Xry/4il55CXba/ZgYKinOz4GgsVmXibOxsRGzHoBr/HpP7KmEVK5fSLlOT+B/YsnltgaMrnzVzMYBMMzgsmJhLGaWA1xutFZue988SHGCSrVfv2+w+opRv7/vt6BYTZUKLULEHm6xDmS68JC0swIzjZi+UmKytvL5yYWU/ximIfCduzIlNCGtX0n3+ytFHHLHQRyLKOi1+sQy6jl7Sf1mFQtISB7KgaIhnpLUV/dttYnZL1QpCeEuW8jw7RdsuEQKoc8bxPfUA9r6izqTgQw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yHNoJ+9e; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1330; helo=mail-dy1-x1330.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yHNoJ+9e;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1330; helo=mail-dy1-x1330.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1330.google.com (mail-dy1-x1330.google.com [IPv6:2607:f8b0:4864:20::1330])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVPNx3lP9z2yDs
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 14:40:01 +1100 (AEDT)
Received: by mail-dy1-x1330.google.com with SMTP id 5a478bee46e88-381f65e4e4bso2813204eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 19:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795059599; x=1795664399; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JhDenXpiUHLZ1Ej69EgBT1lJ0mR2rE8poGppaQ4kv/4=;
        b=yHNoJ+9e8YlMDuo3lqfQo89eyh/AdTn+dscA3LU4X7V7umTy0JGcScOjaiIoyLkBHz
         qLsBsnboaRiBhtntDhwgoB1sR9jPIy7zpoFJmmWmb5qHWsPZsqVr13S3A5kpJNhTJ8st
         uw+ypY9HX4WhThVqc9AGwDqjReKDQ8OTCuBS/ftvH2Lhp34IOsleya94EcvWC9+MU7bP
         gBGpFCmCWeLdGx/CByzPLKpw7vofTpexQmvDJ2ck2wy4nByqLhFNGreVtLAwbk1zWU6V
         IV+YgyNLLA0vwkcY1SWNv8N+iJAov0rlyv691k9UErDM8N8Ae3nucz2t70f1bUaKpJNI
         4NWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795059599; x=1795664399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JhDenXpiUHLZ1Ej69EgBT1lJ0mR2rE8poGppaQ4kv/4=;
        b=kBQWGKANqP9e4/m5K4aqSSCskBxdh/xbg1HGRg35ZPRCvd9DHI0fQFgArRkyS1YE9J
         sYC3GPOcWB5YQTgFOtCCZ6770ChYKmTlKnzwM6ilO7sZyzyQycXF4UetFY/Ur6jO+iDC
         DnVqQpS7uzz7UCjKTGSRzVgaiLLEk7G9xrQd6LF02oDG5b+xfisKbNW2+CJNdgcaoZto
         23QdgqCXw+R2obVjAqImEcTQGvTGT98PzTCsSpwOyDJC3Z2vdY+p7T01xjfLt7yXsM4z
         wx+a7YR08+GBr4r6imLe5OoPx8DTVLYD/6fp+/HSCi8QjziHFlJ8N4AWN/HKNVHX/eBh
         peow==
X-Gm-Message-State: APuU4Z8Q9Udq+pGFg3YHnoQVhri/UZd0PxJOynBDFyk5TRthekODGZNV
	lqL84h5rS6/z1qEBadw6rBzFxtb9GwDb4H1mab2TthSED1Upc62b1L2QIDvhoQ==
X-Gm-Gg: AZFdTZc6ejmi0zhhWxfV6B04efnjJ+dGtgRykY+K5aaWCziTsL7vEh9Zr52SJUw9t7Y
	oqCWZ3zPMrgioCVc8H6viyXHxUBdNZp9AI1cN3KRE8zwaYl3v4AjbtmXzNxkXD43tzsE46zAl4r
	OGaTGObsMSAsLnqPzZkA2LzKPIsVZcV8ZdD7xwhxA4kK3Q+U46af5dxDQsEY5hpb0LtuG0gu5A2
	MiRwEJrIBLPgDtJ0H4tR0/9LCBJYRdt5Wa5zhd2wPuP+vraWDCl7I2zHeAar6cEMDhjn0xxs6iD
	+97gy/BLdUeTqb3KMRmFzaHsJ3yfT4FZS0tnMFk1tOZAW7FLXP0icoJmeeFfyMAdsk9iwklB2f1
	LJGq8g8+X4+xEsCSCcWvdbTlafkeiHRDtIngqOXg3oXW3xT0G7HuzpS/YCR5y0p2sdk1RFHF/Ct
	DnqF9w8u06Bn/nf4cQgMPfs537l7qPSyeezJ4kl7zB8+ixm/EQbSiyDm9mRGW5yGy7N+WmaxAfg
	4XXDJpzn1uTu+5KSWmsLG+pZ0ClEp8wQxfrCZ2HAlb2an7gS0z0XItGY9C+6lAKGoDau/ZTygBE
	S8FBfvMkhF2IO8kLADztk0nfKcvpx+HsMg==
X-Received: by 2002:a05:7301:1502:b0:36e:a321:5353 with SMTP id 5a478bee46e88-3827dd05625mr3947040eec.2.1795059599514;
        Wed, 18 Nov 2026 19:39:59 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a4522829sm12699465eec.1.2026.11.18.19.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 19:39:58 -0800 (PST)
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
Subject: [PATCHv2 08/18] powerpc/pseries: Rework hugepage invalidate to remove conditional locking
Date: Thu, 19 Nov 2026 09:09:03 +0530
Message-Id: <17455e3582d4c5c88b20cdb74ac340794268654f.1795058683.git.ritesh.list@gmail.com>
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


