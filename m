Return-Path: <linuxppc-dev+bounces-24984-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD804C53200
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Jul 2026 09:57:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h976Y53XZz2yl0;
	Wed, 29 Jul 2026 19:57:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785319045;
	cv=none; b=D1rPNlBG3JoECrPH3C8QD8mNiF1lsJU/InYpUwu8NYKu/bWq4mMZcZk+HP0Z4SiJPW4JP0qUYJgzAbZOsn2Po+SHFXWawa7tBJw6CfW3d/vhL5beP+3gh6sl5eS1lX9fYFlxPVUJWVzWhPT3ZBNU5vSq7xYsyhPtIwDpKFZtm4JOq8ctK+QCsPb+yIrP1Ri1Q36uEmn2OQptSR1CMnDZaJtfbanYZrNN7cWQCOyyBtRrdCX9FI306mqhXraj6RkNdG5fXLRb06cYstHb6ALB8rNnSI79ChwBEtrlxaCRNX55KZxhTQXNHT2R9MGrjKEbnId5oorFJkMTZmzD106qmg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785319045; c=relaxed/relaxed;
	bh=HanI/DWtQpNgLfV8hByH/e7wrqTodTjtljygv7QRK7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hmFiv9+eQQ/TtbfYim7ThYfldmA0VBtTFzkavBHYJ5e2LRb43G1RCK+aeY9L1au0ZbBDNAqc3+5+xHl8k/52NGEOZRl3x0X862QtVyoPBl/Plv9fr5QKi+b6hObp59ws7A3EFTTnCUAxN1noj9FpKVAiQIpx1MifL1IDn/L8/0EbxKn88X1qyXcxW4RhRPsN4O/FHq75V25Bhr++PvoIIc8pEA3vbwm3HDXS5/+sl7dzZ97G+Z9JFbXHQUOgSJRyAacroHQtMJVY1GMlq6V5IPEIe3QIub2+ZgBRJ+VvVUeb4PKR64wXTlx6r180kzcicB1coVUfaekSZcjr/vu92w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P/+i7juE; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P/+i7juE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h976X5zkGz2xFc
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2026 19:57:24 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B4ECC44046;
	Wed, 29 Jul 2026 09:57:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CC9C1F000E9;
	Wed, 29 Jul 2026 09:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785319040;
	bh=HanI/DWtQpNgLfV8hByH/e7wrqTodTjtljygv7QRK7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P/+i7juESYpRQLRufFWbqDLy8QWOSFmrYw3JIy+sKoo322P2huyXUafB9WbcKl1Dq
	 9DMWQ8K82tO0+EyXf9rNEOIPVTRcZ3n32C3VoVBdWOoLfZaExTf2LGXXRUi8kShQoj
	 72Z1hI7Q6Y8VIjIvbgufYgTt4fDXs6qdUdWkrElx9DOiJx2jReXP14CcPsS4//3PMe
	 zn5xk5zseoWpHhlyJqEWf4QANClKLtIH1weDhF5KusJo2zTMzz+AuqK/rO3c1qRwgP
	 M3iApD2LCpI07YVwKSBm+hGjz7F0rqt0PHMzfb3wSPKJx2w6h13fD4ZZ5GIFxzm7g3
	 TXvDpKHnwJ+hA==
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: RAGUENES Jean Noel <jean-noel.raguenes2@cs-soprasteria.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-gpio@vger.kernel.org
Subject: [PATCH] powerpc: implement get_direction() in cpm2
Date: Wed, 29 Jul 2026 11:56:48 +0200
Message-ID: <c6eb70aa0e1ba6e15f947c827006aa79edace05c.1785318836.git.chleroy@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <2565e33e629d16d9e33086570834146bb1c962db.1785318831.git.chleroy@kernel.org>
References: <2565e33e629d16d9e33086570834146bb1c962db.1785318831.git.chleroy@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1438; i=chleroy@kernel.org; h=from:subject:message-id; bh=2xxfhtweuFRgyASHDi1y+3GCLGKO3sXEa1JdDURDEqM=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWRlnity+b1Eb9l3kZZTR4567XXaLvXK9twfz2v20U7e0 emW2xNlO0pZGMS4GGTFFFmO/+feNaPrS2r+1F36MHNYmUCGMHBxCsBEbNsY/ruH3NH1vBLF7vba 1d/djDnsqe/T4jC+62cZ/YIUz6+Z+Yrhf2HaVc9jfz6ETroiorBbj0Gqb708v/Ht20xHNOtPMxz M5wAA
X-Developer-Key: i=chleroy@kernel.org; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit

The lack of get_direction() callback in this driver causes GPIOLIB to
emit a warning. Implement it.

Fixes: e623c4303ed1 ("gpiolib: sanitize the return value of gpio_chip::get_direction()")
Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
---
 arch/powerpc/sysdev/cpm_common.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/powerpc/sysdev/cpm_common.c b/arch/powerpc/sysdev/cpm_common.c
index 07ea605ab0e6..b5d200e3ad68 100644
--- a/arch/powerpc/sysdev/cpm_common.c
+++ b/arch/powerpc/sysdev/cpm_common.c
@@ -181,6 +181,18 @@ static int cpm2_gpio32_dir_in(struct gpio_chip *gc, unsigned int gpio)
 	return 0;
 }
 
+static int cpm2_gpio32_get_direction(struct gpio_chip *gc, unsigned int gpio)
+{
+	struct cpm2_gpio32_chip *cpm2_gc = gpiochip_get_data(gc);
+	struct cpm2_ioports __iomem *iop = cpm2_gc->regs;
+	u32 pin_mask = 1 << (31 - gpio);
+
+	if (in_be32(&iop->dir) & pin_mask)
+		return GPIO_LINE_DIRECTION_OUT;
+
+	return GPIO_LINE_DIRECTION_IN;
+}
+
 int cpm2_gpiochip_add32(struct device *dev)
 {
 	struct device_node *np = dev->of_node;
@@ -199,6 +211,7 @@ int cpm2_gpiochip_add32(struct device *dev)
 	gc->ngpio = 32;
 	gc->direction_input = cpm2_gpio32_dir_in;
 	gc->direction_output = cpm2_gpio32_dir_out;
+	gc->get_direction = cpm2_gpio32_get_direction;
 	gc->get = cpm2_gpio32_get;
 	gc->set = cpm2_gpio32_set;
 	gc->parent = dev;
-- 
2.54.0


