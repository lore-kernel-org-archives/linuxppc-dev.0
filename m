Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC32E606A326
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Nov 2026 22:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G2OODaGQ
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJRVr28fsz3c1S;
	Tue, 03 Nov 2026 09:40:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1336"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793630274;
	cv=none; b=DPtV4/axpw0qXZBsns38ec9VaTotVg8N3XQSR3IFVNSVl+kpEwr8rPXu4dCWO4dcSJdkWhUjRiwgvgFvL7gAI2cfEy2G/9W2ZvnOnHEQ1vBeMdBr0ZybHLoka7cSF6Ky60SLTnYVA4z4DVWLcm0kZp9yoKejXR0406fi+BWzwtGOK9JvnqHEhsJsY0Fdp+IRIJaAvl52W+ZZY6cuScTIuXf0ZF+yT1RohoH7FaXzkJ0K2AYcpOMFb/zDFwe1a5RzjXJYRFbOD+/NpwqCgeuVf3iKLoWJRHttJW4mCVt2qlkl7SgKkx2jXfh67J5X1VCOCrAXZaV0KPwy/ruaKsPcoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793630274; c=relaxed/relaxed;
	bh=0+KnKlr9xPjJpW+GH/q0yJUebUnS2gk/U45PnsNsRe8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pj4NiG7jV72+Pb1lTdaNVj2oDW235P6AP+1nBad0uHriOM4kDsesN8ZRWNbusI5wa9wHwO0QG8z+Lzpv31LR62Qya702GAnIJ3m5gvY0ho7HlPSrNBtIn5hljKFb8EbisrwaujHVXCMihcCgTMbc+Sm9q7nfRwtOvBEUlrZ5Dd4US3VcKuLqxOAXTVRnKuXk3FeY2383sVMYEBa1dYILpxQM/1DEgBT7tlVxhisQwlWDBbLSUmh+EZYpzGWhgKfMbOxIHf1VO8R9MSQeQNCKAAz9J5fhKTH4evRjYm3ghLTw4Bia6znS7ihPii1zzuGVjn1Yhhgx0OZ5zHWkx5AIRA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G2OODaGQ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1336; helo=mail-dy1-x1336.google.com; envelope-from=mdshahid03@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G2OODaGQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1336; helo=mail-dy1-x1336.google.com; envelope-from=mdshahid03@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1336.google.com (mail-dy1-x1336.google.com [IPv6:2607:f8b0:4864:20::1336])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJDnr4VCfz2xjQ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 01:37:52 +1100 (AEDT)
Received: by mail-dy1-x1336.google.com with SMTP id 5a478bee46e88-3550c917fd3so4234777eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Nov 2026 06:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793630269; x=1794235069; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0+KnKlr9xPjJpW+GH/q0yJUebUnS2gk/U45PnsNsRe8=;
        b=G2OODaGQYXey/KDUTnOhJvFX7Hrlb2+6l7C2XfkhnY9Vp5LUlxutTfMxjuo67s79VN
         ZyNJY4kcoQQnKIQDazbl1gAs/XN65M1cW6SO4bEsZ+4Ubsr34GQB5/KL93/PgKH2DqqR
         ibjiXIcccTUwGeu71KBK6tE02CwtS/FRbWQeq1xZxQIFFojpFKwPIhwy/fIbT5/NWkF6
         bUpEAP0k3htqM6OjOVkgS4HeXYptOFZtdojQZfTYa+X69H1cMLd3ZgoqccW4TcRynbKf
         8wbKf37YcD+S1D+EzWE5ktvSd3yxTlqX5xmXU3AwRLSMOZi3Qe0CkeNMtrt5nacYahyv
         J6FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793630269; x=1794235069;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0+KnKlr9xPjJpW+GH/q0yJUebUnS2gk/U45PnsNsRe8=;
        b=ohbh5FT7wnVbQ7gbp7A4K5pQtpAW/lVU6KSoKZ4rusc4lXMVH7c7uUwteBvdVAATcm
         JVHZ17x7ieWxUKW2PLXmMQR4l9IznkUKbZARq46MHv9mzzOXug0vS12PElQQrw+EiX5o
         jVkOHhq7eaJDfhedLfzK+WR9CRY7TQ0mNovCvBZuUl+7hj4p8GD5kG0H8RRz+jTz7Ufk
         RTCZXgxis9Qt6t5DD3y5E6sQE1TFIDtikWhFLm4iD42orBy32G3I5pcpocToQiNEPbzt
         4+Ka6flFt3o3f7NSNMAu6SMXh2Ut2X9IhRBIl/SvmAucJfuNTRjkfsaLxodJDOM0THb0
         Ssdw==
X-Forwarded-Encrypted: i=1; AKwUvBz6S76Hwl+a4KKUyWiq72YPvfuhPazAYUGaiCTxXuidH0Ynd2Vf4XcNiDf10+neA0vy+aNp1j3dgC28cz4=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJwsspci27qGI56QRxEsyim4k1I5rwiQSZVhoXZrMY+4O8rEGGV
	PPWHEW0NL9d9cbZEdiGgfs40H33v3346L8Jbff9WMC0VR4GXW+JPC72i
X-Gm-Gg: AYBFou0NHT6lT2DoOtKBSRdYhTO9/eq0BVWeI0kTZ72zV2SquGr+Ft5/1NEnUsRust5
	+EviEhYgsyrR62+LWKqMatgTmaQw3AwtIuFu9wAhHDSwUUjF8mDfIvuDf6WxlRdzDM5ZfIxiACW
	gd7VbWaZuKWsrtDWBr3EcbI+b0BjophVx1DmHzyKRBMSxgDYNVdiiTYdfv2XEv5RsgIbK/agHw3
	f2dTaDO8L9wMC/X+asDw4lrQNJiNjWTf9zpErb6dy6AhzgUyh5E4DjEv9MdkWgr2J/R9VDIdde0
	V8Ij/9GuEpuno3ac7vrEeqp/RiBLuAu/jc1d6/PjUd1tjJR3gWerbUaBdDp/Pt33OZf9DLtbO0G
	6dw/e8KOKTr05e9wm4mNeHNlrf9bh0wgSl/qHrkInCLjtQ4wdo5u1ZOSnKmhPZvSsKGyTQjLIkX
	qWy1jMYLVMWUA20shZ2Y6p81EZ5m+79s2WO4cEHvFIDhFVuBCiLjtVnN9TJegfEYpJri/KR8tYe
	JVMG8G0tE1WnFM99StqQ1YRlvbbFahRwPRAoBqJwOFxGTzz2JDJ7QlTmAucZtx+tiWWfzUoMWAq
	oKXNj9PoK2urn8l4TBJR0AxG7cAW
X-Received: by 2002:a05:7301:6187:10b0:35b:cb8a:8d0e with SMTP id 5a478bee46e88-36a4242f5c3mr16363420eec.16.1793630268636;
        Mon, 02 Nov 2026 06:37:48 -0800 (PST)
Received: from ubuntu.. ([2405:201:8026:213e:82cc:4587:6dbe:2fdf])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428fa380sm35247518eec.12.2026.11.02.06.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 06:37:47 -0800 (PST)
From: mdshahid03@gmail.com
To: maddy@linux.ibm.com
Cc: mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	ritesh.list@gmail.com,
	sshegde@linux.ibm.com,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Mohammad Shahid <mdshahid03@gmail.com>
Subject: [PATCH] powerpc/perf/vpa-dtl: use GFP_ATOMIC for DTL buffer allocation
Date: Mon,  2 Nov 2026 20:07:19 +0530
Message-ID: <20261102143719.165508-1-mdshahid03@gmail.com>
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

From: Mohammad Shahid <mdshahid03@gmail.com>

The DTL buffer is allocated while holding dtl_global_lock, which
is spinlock.

GFP_KERNEL allow direct memory reclaim and may sleep. Combining
GFP_KERNEL with GFP_ATOMIC does not remove the direct reclaim.

Use GFP_ATOMIC alone to ensure the allocation does not sleep
while the spinlock is held.

The issue is reported by script coccinelle call_kern.cocci.

Signed-off-by: Mohammad Shahid <mdshahid03@gmail.com>
---
 arch/powerpc/perf/vpa-dtl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/perf/vpa-dtl.c b/arch/powerpc/perf/vpa-dtl.c
index 3e3d65b6c796..3d34417e6aae 100644
--- a/arch/powerpc/perf/vpa-dtl.c
+++ b/arch/powerpc/perf/vpa-dtl.c
@@ -338,7 +338,7 @@ static int vpa_dtl_mem_alloc(int cpu)
 	if (!dtl_cache)
 		return -ENOMEM;
 
-	buf = kmem_cache_alloc_node(dtl_cache, GFP_KERNEL | GFP_ATOMIC, cpu_to_node(cpu));
+	buf = kmem_cache_alloc_node(dtl_cache, GFP_ATOMIC, cpu_to_node(cpu));
 	if (!buf) {
 		pr_warn("buffer allocation failed for cpu %d\n", cpu);
 		return -ENOMEM;
-- 
2.43.0


