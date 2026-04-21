Return-Path: <linuxppc-dev+bounces-19867-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A769F327AB
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Apr 2026 06:28:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g0C9Q5Y2cz2yL8;
	Tue, 21 Apr 2026 16:28:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776752922;
	cv=none; b=Wo9vbwh2YwhHUiTRbN+GWkFUK9UgCt2cV4iHvyMIabcrnV7G3jlWt56lgfZcffehMFwesG7tGEkAEpmfVU7xbZBrW1LzOdLdxmcz6n9bDldBXaSiZ4DZrSbMuE+gwYa19j6CQcQrGGEOkQ5xAtGCHL/kHra+1Zs1z8Ev5j3bDCD1LYvOSUKTmi778Bv7otzNrYjN3Cl9m6yNlmp5WpGzK7o/bQclBhaes3QmxXxVJew+8Vqece8afjkFpPMn7tiCYwAmaLF8E8GDPf+/Q4EmKu/qWtOXVBb4q86caCKrSTTZ1Mv040Ve/40ehwWwZUAlGIaF/xBwgeJmd/31MDgn3g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776752922; c=relaxed/relaxed;
	bh=c0Maqhoq8dLjZM4LdYz0ZlFUgDU62xwhwPlaS3BjoiE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W2+SpOde+TC4VXYCioz0Y6bHCKB9jmwhVIxpO/NFz8Q2iCcJjHbkeppibxWSBjfazfHEPkEK1WyJF4PPALGnl4vWFzzXEn+DTxkBa0MG+M3k7+sV/n0ju3PRpM8f5WQHcFWos19csDdh2nw1o3dwCrXDMe0fGYoeed0PRqIO+NLxA0G0GfCv6g+mU14+CNe03txl1kCZvtRlUkeoDjUuKcla1DXcu7mFiJqPgDx9/rJu0CIlrTmMtg2uP61rPCtbV0SWR2PjMAl85QOXC3B6QurY0w8J/aOVVbHWb5DJStuRBcSJ/oYOsUqnXrJKewbk25TluDhmEjgVb9+Bzr0R6g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=N8sOAJN/; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=N8sOAJN/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g0C9P5lGYz2xc8
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2026 16:28:41 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id B90996011F;
	Tue, 21 Apr 2026 06:28:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 806D7C2BCB0;
	Tue, 21 Apr 2026 06:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776752918;
	bh=dHS0gPZI0H1Mm3DBnxFHJRq1QTSVEk6PBiQCtoOUiRM=;
	h=From:To:Cc:Subject:Date:From;
	b=N8sOAJN/m9DLUmvktUQYI5VhDyt7bWPL6cUKLY0QqBIrL4bf2hm5v2ODzNt7waL+8
	 V9iJniP7ewPdb6UGrS5rRj3t4dk+feOrWRnyu6Gp+bvsNn3zDLHrIQCI5HEldYTOzs
	 cLOotQOJzgRfVMQN8VJlZMEo+VQ1RNtkhbvK4BWkNVWuwqH00L8Cl0WdaH6UTilDK1
	 iI6gvT4YzDpx2PtQiqg+KZaJAuf5ge7geOpNDNY1nQGlvOF5fY53EMaHfbg7KJU2vH
	 Ry50Q+UQLUbA7ACikWMgr/9jFio3B3xn8cG5H+5nQoaHfdAC3C3NFKB6pFMqD3bLQU
	 na9oqY+TaQ0Cg==
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/8xx: Fix interrupt mask in cpm1_gpiochip_add16()
Date: Tue, 21 Apr 2026 08:26:08 +0200
Message-ID: <bb0b6d6c4543238c38d5d29a776d0674a8c0c180.1776752750.git.chleroy@kernel.org>
X-Mailer: git-send-email 2.49.0
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1358; i=chleroy@kernel.org; h=from:subject:message-id; bh=dHS0gPZI0H1Mm3DBnxFHJRq1QTSVEk6PBiQCtoOUiRM=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWQ+l2gUfvrA0u7+nc1sGjaLFmSs0NfeNPmijkf1pIBDL fWXb+Yd6ihlYRDjYpAVU2Q5/p9714yuL6n5U3fpw8xhZQIZwsDFKQATOSTA8L+m9cWqk7qCU41W Z0xf4lZXJ3n909YND3tFjvo8truUvaedkeHMm7+MNQKsT707n3ufyHTfffLmUp63/CkrpzQe1jc tv8QOAA==
X-Developer-Key: i=chleroy@kernel.org; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit

Allthough fsl,cpm1-gpio-irq-mask always contains a 16 bits value,
it is a standard u32 OF property as documented in
Documentation/devicetree/bindings/soc/fsl/cpm_qe/gpio.txt

The driver erroneously uses of_property_read_u16() leading to a
mask which is always 0.

Fix it by using of_property_read_u32() instead.

Fixes: 726bd223105c ("powerpc/8xx: Adding support of IRQ in MPC8xx GPIO")
Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
---
 arch/powerpc/platforms/8xx/cpm1.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/8xx/cpm1.c b/arch/powerpc/platforms/8xx/cpm1.c
index 7433be7d66ee..f00734f0590c 100644
--- a/arch/powerpc/platforms/8xx/cpm1.c
+++ b/arch/powerpc/platforms/8xx/cpm1.c
@@ -477,7 +477,7 @@ int cpm1_gpiochip_add16(struct device *dev)
 	struct device_node *np = dev->of_node;
 	struct cpm1_gpio16_chip *cpm1_gc;
 	struct gpio_chip *gc;
-	u16 mask;
+	u32 mask;
 
 	cpm1_gc = devm_kzalloc(dev, sizeof(*cpm1_gc), GFP_KERNEL);
 	if (!cpm1_gc)
@@ -485,7 +485,7 @@ int cpm1_gpiochip_add16(struct device *dev)
 
 	spin_lock_init(&cpm1_gc->lock);
 
-	if (!of_property_read_u16(np, "fsl,cpm1-gpio-irq-mask", &mask)) {
+	if (!of_property_read_u32(np, "fsl,cpm1-gpio-irq-mask", &mask)) {
 		int i, j;
 
 		for (i = 0, j = 0; i < 16; i++)
-- 
2.49.0


