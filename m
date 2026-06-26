Return-Path: <linuxppc-dev+bounces-22999-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38DA0CD4F26
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Jun 2026 03:29:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gmh4C4jzYz2yYd;
	Fri, 26 Jun 2026 13:29:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1032"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782444571;
	cv=none; b=c9XAZnacHaljKhx4n3dCzeBfspYUjUVhD7YASwOGac9oxCTYdN1t2LGCCD1Ct1qjt5+/vg9HTl3m8NEGWhguNGSArSvNDwBcuJeqtdCh2tK/aob9NcDiNcENq8cBRM4z6nmLuY5/2j5YFkUwVX+u9yCtriAJ3dVijnIlotUlhURtSZSpm/R9YMxLLrXxiX+tVUFr517QWocHMmkA23gM108pIbH86IhrgFuTi8a6lRz3Tyv3TjeejdCWWB9pEtOnYTn7xtBlqsLGArP84ehtCd/iAnEzfkJsrLjbWhArmTkuOIwvzoZ1Xxe+9ZxxRmW/JPFkOPL4QscXQQuj3IBAxg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782444571; c=relaxed/relaxed;
	bh=Y6Sd0rAa7eGUjwB7XccxOpvYcuvKaM7LfQsgz36WxcY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PnHW9LT+dNMbsoFEsE2YVMDHBe7C1iek9j0HDOdkSUnEmTMISIAM6LhN9sLn0I37KYvLCVHLnrMnjewR+ez4UVKQtbEfd07gr7ObhOz4yvTNIdkZrmb7mTt+YyOsgU8QyL/iUoBwaP2dGqDrdAtZ+hLBXqKyWD3ExD+f0CawiMMxcKV9DAbtdmMDy36oWJnadDLXbof36P8JFxfzRrjqzxcm2mUJBOZn+Z9TOnvH/jCfe4qhoQZ1cM0u71zIwRTeXnZEg6LNixsk0L2+jfO0NXsKx7FtZJlUSiGNVLcMfpV3nu13M0ifA2oqnRifsYqoDwWKrbXgt4UzKLmpubp26A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EFRU+Wej; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1032; helo=mail-pj1-x1032.google.com; envelope-from=ekffu200098@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EFRU+Wej;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1032; helo=mail-pj1-x1032.google.com; envelope-from=ekffu200098@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gmh4B0LL2z2yDs
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jun 2026 13:29:28 +1000 (AEST)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-37cbcf49deaso281033a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jun 2026 20:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782444567; x=1783049367; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y6Sd0rAa7eGUjwB7XccxOpvYcuvKaM7LfQsgz36WxcY=;
        b=EFRU+Wej+/g0JXZzxnh+gUMXKsPRRKpM5RfxSUh2jfPdkEymvyVWKHuibeWs5ldlEo
         /0weS10QKhWkq5kjJwBgIj0SfE9msUasESUdo0x5HtASoERzjRZKv42uK6Bdp0lr1qOn
         uXVOZtMyovT4YMsB3uQQub4w15e2WNNfzdzxYcc64SKl1UlosvKsE9rKEJObQMjRArI8
         1VqkPL5QyAuUXP5jZHud6lEAtJ3IpMyqzZBuYPccWUKgzxKBNkEWQqE2XRteYidcbXsE
         xPfKsjM0n50yaIABevom0otIdaQR5VA//6tE4bUoRxb53AW18RowejGaK5BJk4CzpD98
         ydzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782444567; x=1783049367;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y6Sd0rAa7eGUjwB7XccxOpvYcuvKaM7LfQsgz36WxcY=;
        b=nQqeAWok+I3QnaDCfEXIWB+U3qHga+GTIffNBOWkeJccEp1ZKWsaeysIPFbGOkCryX
         Yk4ciCRmEs3xkXSNu/Ns32UjH8+F6S/HZbtKnCch+K4LxW/fqbHYy7Jr1O8bAuR+VxZh
         C86r+3q+FoBYA9lZF8W89hwStxBniI0YFG1N4tVN/fvonvjWZO730WOqUpO4crA3NrMx
         Qij7z0RxEMTKyJJhY8OVS7DbXM64z8lTuJCc99JJgcmrdPrivHOTRd6DhZjITrxOxtI4
         IErr0Bp9EUVgAHlEHaVCMatgnNMEpWx1W+89UGh/CNdBPxrM68Rr/qqeAlR1sldUi76I
         zIbw==
X-Forwarded-Encrypted: i=1; AHgh+RqdUMQFis9eA4QReE8+r5ozjmazuSh33OQz4zFaM6o/JJ8Gs4lw2y/jyYqinJqXmapF96vtRWlteES3MsM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwLXhBnKTZ4cmTE4+VKS/N4Yx0wQ/6QXJEFwEmiw7GamHWXwA9b
	5RYuKCO5O2MU9H848ZEsgr04uOiYkGluKvYI4hqCXY7c6Nn1Vm3g3jRM
X-Gm-Gg: AfdE7ckCxGX5M0czvKlblY5Hr3teJnvm8+1UfnNck6A4a6HzuFjhYrL6tsmRTnKGXx5
	Hg/J6J7gvVWNipHv2wLnYGtg/eiZAxD8dAxl2KaXZv/mt/zCKt5Ku80a4xtouXzb44GKopzBZfu
	5f0Yc+7dYPAZtnHuY1fUxzgsHl89WywhLhB8xJYmMFY071vXk2UDJ+O/1vgmuLx9/U7xCFoNjt6
	qkCvY6bFpwHktZNidv5znHVv/zbQh43rtgIBFgro/PLuX0B1mu2AuzLPu3YTV6uyG9v0pvRxwVr
	eh+i3K7E5PDscu9Kj+GFN/1CCtGpl77OdQym+OgvF9344DrY7hKVtk9QKzlZXi9DhEoGtNWRRho
	9hRtgG84OT62rPB/whjZndBJDbSmyjpo+1+j9wLA98Y4cGKOzMCWPN/+ysHehCJY8v4VuCMkYex
	c828RErmw=
X-Received: by 2002:a17:902:d510:b0:2c7:9b20:37de with SMTP id d9443c01a7336-2c7fc62db17mr48444485ad.4.1782444566979;
        Thu, 25 Jun 2026 20:29:26 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7f63b66e0sm30912745ad.42.2026.06.25.20.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 20:29:26 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Cc: rppt@kernel.org,
	Sang-Heon Jeon <ekffu200098@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH] powerpc64/kasan: Remove unreachable invalid range check in kasan_init_phys_region()
Date: Fri, 26 Jun 2026 12:29:01 +0900
Message-ID: <20260626032902.703944-1-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
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

kasan_init() maps each memblock region with for_each_mem_range() and passes
it to kasan_init_phys_region(), which does nothing when start >= end.
for_each_mem_range() never returns an invalid range, so start < end always.

Therefore the start >= end check is unreachable, so remove it.

No functional change.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
This patch is similar to my earlier series [1] that removed unreachable invalid
range checks in memblock iteration loops. I just missed it at the time.

[1] https://lore.kernel.org/all/20260621145919.1453-1-ekffu200098@gmail.com/
---

 arch/powerpc/mm/kasan/init_book3e_64.c | 3 ---
 arch/powerpc/mm/kasan/init_book3s_64.c | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/arch/powerpc/mm/kasan/init_book3e_64.c b/arch/powerpc/mm/kasan/init_book3e_64.c
index 0d3a73d6d4b0..0ed372fb8b09 100644
--- a/arch/powerpc/mm/kasan/init_book3e_64.c
+++ b/arch/powerpc/mm/kasan/init_book3e_64.c
@@ -68,9 +68,6 @@ static void __init kasan_init_phys_region(void *start, void *end)
 	unsigned long k_start, k_end, k_cur;
 	void *va;
 
-	if (start >= end)
-		return;
-
 	k_start = ALIGN_DOWN((unsigned long)kasan_mem_to_shadow(start), PAGE_SIZE);
 	k_end = ALIGN((unsigned long)kasan_mem_to_shadow(end), PAGE_SIZE);
 
diff --git a/arch/powerpc/mm/kasan/init_book3s_64.c b/arch/powerpc/mm/kasan/init_book3s_64.c
index dcafa641804c..ccfbfb894637 100644
--- a/arch/powerpc/mm/kasan/init_book3s_64.c
+++ b/arch/powerpc/mm/kasan/init_book3s_64.c
@@ -24,9 +24,6 @@ static void __init kasan_init_phys_region(void *start, void *end)
 	unsigned long k_start, k_end, k_cur;
 	void *va;
 
-	if (start >= end)
-		return;
-
 	k_start = ALIGN_DOWN((unsigned long)kasan_mem_to_shadow(start), PAGE_SIZE);
 	k_end = ALIGN((unsigned long)kasan_mem_to_shadow(end), PAGE_SIZE);
 
-- 
2.43.0


