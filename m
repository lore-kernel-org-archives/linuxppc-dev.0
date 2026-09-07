Return-Path: <linuxppc-dev+bounces-26628-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEB8EC79F9E
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Sep 2026 01:34:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hdV3K0PPSz2yvY;
	Mon, 07 Sep 2026 11:34:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::334"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788744844;
	cv=none; b=j7WbCiWIoimqtFG0bUmw7zUMH8Be3tcF1RA+2pC067oOOwX+mnhLd9bgyhYpoIvq5k2/HDfNSs8qkaz1PgIeJGgTqJSeSgSpoouPfAxkCFlQ83KB24wf03NDhlY+/bYqKbrnUogoiAELAVF+BlXBoJnxw+AC7xtSS6Ekfh+3cRROyereJKrnPvnl4eT/86TCNVwrW4wudAuiRUGP1X1YF3rzo7h7wqhkdZJflPsTSWRO6yEzK+nAUIe8TGdpUASI9V2QwK7LInnVB0Q/y8/xO6we4vMuR81wzpvMMQfJSkout5Uo1c9jCNbUWPeOfv6A/skhpzSvDSHEn4ihRBhzgA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788744844; c=relaxed/relaxed;
	bh=sy4zNx9X38PUXNinh1YibMYXf/iUzDc2WsR8iEENSio=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PHndwAsCllU35yPEqz2hwyt5SgUr+Ij6ozyax9X4cvobA8C5PkIf/WUOVNTLlWDi//ubMsdoSEnJnK/oWYKVium1LDy1PsRzb8E1C8ZB4kXKyhYjZ8x6xp/I1JO4cnYu3dk9dtWebqcBNV2JniUS+KNPycXD76KUhRztifOqXSU7XYASfCzvG3iJmAanegXOqcu2miKWeaGFSLhCYiLLqTUaIK+CKHq1LzHGcB7aJAo5w5jULx7mf0QGv+o9EnrJwS4uAbTKP0PEtaF+yvj/gpoiYTo6G4DXJMVHuXmEAWqvhDqmODtsxPgs5jgI5MziSGACiYoJ8mrrDInOA4B2tg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FGrrO1Lf; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com; envelope-from=kmehltretter@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FGrrO1Lf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com; envelope-from=kmehltretter@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hdV3H3FLgz2yvX
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Sep 2026 11:34:02 +1000 (AEST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-49a97714f5dso27392705e9.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 06 Sep 2026 18:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788744839; x=1789349639; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sy4zNx9X38PUXNinh1YibMYXf/iUzDc2WsR8iEENSio=;
        b=FGrrO1Lfcq6Pd7+d3QUJ1NLZECi3EC6nhpwmB0zweE+79DrwvmfF5yHpB/Y/0kT7TU
         O7r+xO+vjFkO6rnbRyq+wOql+WmagUcVgiKoZv45dUbJAS0nBMMQypGfb4033Gb7opro
         /wccAld4OQxbts5ShdL3weXs/NAJogWsjKkOwaQ0A7SEj0PlHPz7rRQAOPpx2k6WuLAR
         0rpR0IX1aE0ZIEbMqfKx0ko2P6tJZPwCZc7DuX6m79UM+si5JkOB6MNaWXwyNa6FxbIB
         vltLKyRQvlLekWWFKeLEB5IaS6PP2+voZ29nKIDq00ZBvg+QF7cV+37a2pXy0/gYy+lD
         tgfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788744839; x=1789349639;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sy4zNx9X38PUXNinh1YibMYXf/iUzDc2WsR8iEENSio=;
        b=A53GMXbWmVrzYVT4WIWP66N4uxZSc6ywRzQFhw8X67IhiHf3JIkGcUVTp2FlSBpfRd
         b3p+7+ePLxe8B1aJm9DUQj4tB/VJpuS/+GcVYJyFqXw3N6zo21p1pVGCs3mYk9di6Gwl
         m8pZ7mJEMhh5t0Dow4gZNc9kq04KFJb+ClaXwY7n4LiDU4XLkoxzLlLbUMEls1lfJ3f0
         tQErYRTRiEOvVm3m+D6eXdgPzo9kDUZiLGAA5us/Pp8gjUX2YI6B8TLxZtxokxmTGAX3
         v85PwQyJjzZA8u+QHX5sTbBAVBgoxqsozNdmQ+Lw4v5dq6Hnsq/k2BhKgKDiDt8jW7a2
         WAJQ==
X-Forwarded-Encrypted: i=1; AKwUvBwavJ2Gn6Q3s8evjkHPx63yiMEwIxZDGyZztb/QZzUq04gag3XsgwuNjYgTp4OTP0fT1z83nr14AdBhNzQ=@lists.ozlabs.org
X-Gm-Message-State: AFuF++msXj1d+ojsBgoygDP9BfK2yzeHxTcISVNDjLuJH6yoJCwgZww7
	mtgiZ74SnC2DXQAcE1GMGwG3GC7LBtsUW0VPNoIYMBYqbiSeAzbqW4xV
X-Gm-Gg: AYBFou15fhPhy+xPkxwHF4TM52t6uzkLe3kyYJcY9BVa0UF9tQ8a81yuIQ+jLOF5tPj
	3ZBDE0I48EEW01tzLMa4izhOHDzbsdwL/++QVTI3d6m7iedFtV2ki2e66kWf6LNOus9o78BP2Ql
	85Mh+35PRNeCiGCQDFsNU2y40zSVPSO0H3DUh6NwlQtQHl8H8M6+NxA9RhjtDxL4xC7EQHVAjml
	bFVUcm0QhMy6mARhTZipXZY9rRxS3fLtXFeeGdBACaUj33I6AraooDse+1j+/2scAA9soHon2uQ
	MXdyj4+Ek/wnyE7W3bgbIYUlqiDfCBSmEgIRuTAWCRIqxgUqgpz1TQ1jFtpmhBg4SRo0yOFsfqR
	SlPL7NnE4RRJWJ5WRMJT5YsOFRZchZYweK6KNqPxYfhebCZrQyUhqk0dCCYxK2RPom0BmWQ4xjB
	MXBxmIF/kciCSX2hhdL+Fj1k17hA75LLyj7YP7YSTZptMQv0vR4uLRMuuj2nXRwr0jcmm0SYX4U
	0k1QEpCSEq78kaZOay4mS7mF9uegdv2yz1JRNUfUlO3AEJSsuvuj1/uDWIJrpy9IaNp0T6Q5XO3
	vEMcPOQWy5bA1TPZS944n9+YKLIR+kOCaKJshKhBLElOvqxYY6OLP1+W9aCyDXIZInQ=
X-Received: by 2002:a05:600c:a44:b0:49c:dcec:bd27 with SMTP id 5b1f17b1804b1-49cf821e7a5mr185970015e9.8.1788744839484;
        Sun, 06 Sep 2026 18:33:59 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-9d84-5101-9c80-d25b-14b6-410c.310.pool.telefonica.de. [2a02:3100:9d84:5101:9c80:d25b:14b6:410c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cff8195ffsm212455745e9.14.2026.09.06.18.33.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 06 Sep 2026 18:33:59 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	linuxppc-dev@lists.ozlabs.org,
	Rob Herring <robh@kernel.org>
Subject: [PATCH] powerpc/mpic: Point the comment at the surviving binding
Date: Mon,  7 Sep 2026 03:33:57 +0200
Message-Id: <20260907013357.22885-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
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

Commit 326d25198112 ("dt-bindings: powerpc: Drop duplicate fsl/mpic.txt")
folded the fsl,mpic binding into the chrp,open-pic schema, so the file
this comment refers to no longer exists.

Point the comment at the chrp,open-pic schema.

Fixes: 326d25198112 ("dt-bindings: powerpc: Drop duplicate fsl/mpic.txt")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 arch/powerpc/sysdev/mpic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index 257886ec3f70..d34138fdd593 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -1105,7 +1105,7 @@ static int mpic_host_xlate(struct irq_domain *h, struct device_node *ct,
 		 * First two cells are as usual.  Third specifies
 		 * an "interrupt type".  Fourth is type-specific data.
 		 *
-		 * See Documentation/devicetree/bindings/powerpc/fsl/mpic.txt
+		 * See Documentation/devicetree/bindings/interrupt-controller/chrp,open-pic.yaml
 		 */
 		switch (intspec[2]) {
 		case 0:
-- 
2.53.0


