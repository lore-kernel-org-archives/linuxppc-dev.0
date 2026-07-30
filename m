Return-Path: <linuxppc-dev+bounces-25104-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0133C55160
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2026 12:29:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9pRt0nWtz2yhb;
	Thu, 30 Jul 2026 22:29:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785414586;
	cv=none; b=GPkuGT+p6gFklaEaxw8mm+hVWvv5jdhWtHrtEtXgKwKsS9JQyrC4zIqoK+lVksIKBX8/GgUZUvG5pbqcEqbkKgB3nQAMAWBkF7XYFBoxKsD/AqsWmle89BmMJHPEz8DTVA4hnewUbNhINpcjTIrtXafWitoBJID5FObZAvKnX88neUKfaD9IKzh5GpKXMJjJOjSUTOe/2/60UVD9LteLm6R8/HP92gZx5VFq8pocrumv/Ugw6KTb+4R/DgW8VI+whkNXkhV3EfT2y4kA2sSVAD9lO8jJ2ymgv9zmRyP+QXW/HjvrDCWAe23xiu3uJ7Gcwy3e1aOw3prSMvbPJXcHtA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785414586; c=relaxed/relaxed;
	bh=yrGZUILR/Wznyx7GjKoYB3FNEjyAnbdcouYLB2K4DOM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z2C5q2+jDpT2KdreBZnQx6Ne0KAxEHGmVe1PX5vwVYg00e6e/2k3jGkGYWPrNMO0vH71KCOqWj5evsM7SNa2PlaxyM1VKb4vSbbX1W/HCRJ7wNlC84MAnCnvmVo7RmBEcIUMw49hmT8H5g5xgyFXS5YEDxi4odauLhUe4QdWFEz2A4Wcuovtt8t10uyihCeOFnPm672VVQYaSXnFxDZ/jlLLaFcZGw+qqbk41CFrceZJIuGdkDD6N86HmIfEb/PZ0ORpKw68Vy2GJRYYfUJtfUER2/D6jTHBcVsDrl6IeV9+V9c58IU2SPl/PWKBhqHgVMfeoClJVi1HkExOPH8xBA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oZ6omnuY; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oZ6omnuY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9pRs0sfHz2yYd
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 22:29:45 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id DC135600B0;
	Thu, 30 Jul 2026 12:29:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DB331F000E9;
	Thu, 30 Jul 2026 12:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785414582;
	bh=yrGZUILR/Wznyx7GjKoYB3FNEjyAnbdcouYLB2K4DOM=;
	h=From:To:Cc:Subject:Date;
	b=oZ6omnuYaaPVJph/8aNubaZUbqRB9sNViXWI/peGzrmT42iBUgCOgMxZL+XD86Fmk
	 wzxpMP+cnOXs40uO0p2/WXrnkXBmtfps6UkSHV19rZ/dUS4Lcx61qldgB7zZrgZnfA
	 /SifWtwBKqLGvv6Cmdcqkz2Pmvoc+3s8eGF3abRIJiBbfUip9BG26KGLzWE5OH7Zgw
	 IyhLp1ovVGOh/3goBNj4jcEFyr8Yw3oHyCt8vrZH4kJvyDI3e8Pf1oXpvXb+YqRxJa
	 KXEWBxePvzWYp2TIcLeRerbEwBfcr8ek3B0HzHqW5d1UgYQ3lhGOP8Xc1KKutr7zCX
	 jO74PgJVlpeEA==
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: Christophe Leroy <chleroy@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <brgl@kernel.org>,
	Herve Codina <herve.codina@bootlin.com>,
	Paul Louvel <paul.louvel@bootlin.com>,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2] soc: fsl: qe: properly scan GPIO nodes at startup
Date: Thu, 30 Jul 2026 14:29:36 +0200
Message-ID: <a1db12ef75bf881dd5fba893a37db0c8517eca1b.1785414349.git.chleroy@kernel.org>
X-Mailer: git-send-email 2.54.0
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1513; i=chleroy@kernel.org; h=from:subject:message-id; bh=NMDDFmRLn2ji8YodQkBFhcITCr9QFapEu4TNHWLKe2M=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWRlO290uJFhuSzLIzP43g0DtulzRATNLjJ//efy733zP 7d/ldmXOkpZGMS4GGTFFFmO/+feNaPrS2r+1F36MHNYmUCGMHBxCsBEeH4x/Hf6tC403eRHoNN1 7oCdt25YMRbvOmup90WJ+ZLW/wJv0zKGvwISf+4yZG3+oGVhOM8gcv1DKd2DbaeTTBoLTzyfYfY 9nxkA
X-Developer-Key: i=chleroy@kernel.org; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit

Before commit 156460811def ("soc: fsl: qe: Change GPIO driver to a
proper platform driver") qe_add_gpiochips() was walking the device
tree to find all nodes with compatible "fsl,mpc8323-qe-pario-bank".

After that commit the discovery is handled by the platform core,
therefore it is necessary to call of_platform_default_populate() on
the par_io node.

Fixes: 156460811def ("soc: fsl: qe: Change GPIO driver to a proper platform driver")
Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
---
v2: Use of_find_node_by_type() instead of of_find_node_by_name() as the "par_io" type is documented while the "par_io" name is not.
---
 drivers/soc/fsl/qe/qe_io.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/soc/fsl/qe/qe_io.c b/drivers/soc/fsl/qe/qe_io.c
index a5e2d0e5ab51..150913fce981 100644
--- a/drivers/soc/fsl/qe/qe_io.c
+++ b/drivers/soc/fsl/qe/qe_io.c
@@ -15,6 +15,7 @@
 #include <linux/errno.h>
 #include <linux/module.h>
 #include <linux/ioport.h>
+#include <linux/of_platform.h>
 
 #include <asm/io.h>
 #include <soc/fsl/qe/qe.h>
@@ -184,3 +185,17 @@ int par_io_of_config(struct device_node *np)
 	return 0;
 }
 EXPORT_SYMBOL(par_io_of_config);
+
+static int __init par_io_populate(void)
+{
+	struct device_node *np = of_find_node_by_type(NULL, "par_io");
+
+	if (!np)
+		return 0;
+
+	of_platform_default_populate(np, NULL, NULL);
+	of_node_put(np);
+
+	return 0;
+}
+arch_initcall(par_io_populate);
-- 
2.54.0


