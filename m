Return-Path: <linuxppc-dev+bounces-25103-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E45F2C55160
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2026 12:27:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9pPM34MLz2yYd;
	Thu, 30 Jul 2026 22:27:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785414455;
	cv=none; b=JeTPpcPyW2WYP+GCzA4/rZJgXJ1Z8whKldinoLQeOzrP7QxjGUb1VWNry+kUMURd0hkZhB/giH5nLgggS3Ny+Wp605Iko2lFHS3PV4aRBYb1dgmaIcEhe+X6w1fFaokroHXWm9nLOwPkzq4I+rlf/CajlSQao/6mYro4YpUnZZo9n1ARpJJT+EoN52TDvu88GtgTZgZcGmwToIDC7HKJb9vv2ZTr21vWUB0DkpGAE5Rz+Xkpqi8KCR+Kc5qxfaPioRgg4hJ5KoLSY5auZ16jjb0Q+5z7fBeI6+4XF5BqZRWcc8J4I/0+uH4XaFhk5IXIBXcX5756yLkQTYAvdpPxWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785414455; c=relaxed/relaxed;
	bh=2a6dfSsGD/MmTbGKcRMsjqnnX+0xSYoSHnMVeczgVxc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RX6m2hFSSN+fw7BtWmAvrnNAD0QmDlwvjFSNqUpRHFBIAhFI9AVYgjf3+sxIGf8FL7SgIhF9CZimZ/MGx4lZCuATVKJQ3zBBWVVzcWXOovi3MSxbCbjCTFTk3/2YX1DVaBLaXOpPXBKoEO0FFg819dkZe2PwLD9aM78xRf3rlfE8VBpFDbrz2awjcqb5tCsJ9QTKv5G9WYwWVXKYvZBd3gAL0cMO4ye4EBx6EPjo4KJCyMlK0ZrowCVPP8W4F1cK+N/eDEsA6dRNuXbDKf3hmB3SSImNL7jTGqrlOB26n6Xjc7dLY2gt2zF17ASes8dCnX8roSib77wQdGALSMuG8Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AG5RHG4X; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AG5RHG4X;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9pPL5qLvz2xnp
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 22:27:34 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 75D2260120;
	Thu, 30 Jul 2026 12:27:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97AA71F00A3A;
	Thu, 30 Jul 2026 12:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785414452;
	bh=2a6dfSsGD/MmTbGKcRMsjqnnX+0xSYoSHnMVeczgVxc=;
	h=From:To:Cc:Subject:Date;
	b=AG5RHG4XD3dI3+Pzm2tS0JeeffHjlVhHTKycm5LvTenFIz1gz4+Da4jhXD3ivB+Nm
	 s9OkNBgMRI8kC7dmVNwPY7N6IztrqDaHLG2uxgkF61oEYzuSYCqTVgGEXI4k0d5Knc
	 H83X1EzqkQn6n7X7LUFXvjIkfSLXyLRCVhNxnOXf9I7hON1zZO8AhtJnY5VN21hjZj
	 NiYt5SGo6Z3PHQYzVzlmFF8qmtigPvHh9w7l/hIgFbr/4M87TmOkXIoE67Sc/kKQdl
	 q4y+IzvsYkxi0l2IbMMXJa+mXTT+U8UJigg0TZCEw7qedveYondN6oUQIbDPcHUZ2W
	 RjK6q/Ih4e3aQ==
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: Christophe Leroy <chleroy@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <brgl@kernel.org>,
	Herve Codina <herve.codina@bootlin.com>,
	Paul Louvel <paul.louvel@bootlin.com>
Subject: [PATCH] soc: fsl: qe: properly scan GPIO nodes at startup
Date: Thu, 30 Jul 2026 14:27:22 +0200
Message-ID: <04dc047f8958a78a920f0a88ca3bd8bf70c56187.1785333986.git.chleroy@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1375; i=chleroy@kernel.org; h=from:subject:message-id; bh=NgJogTZ8D2TsSvzSmrE4tRc1/6SYj6BMw9ra0XiPBuo=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWRlO+s8WhX5UGzP0pRd70O3cVjna2rfmNCbL/jldnip7 MFtN40vdZSyMIhxMciKKbIc/8+9a0bXl9T8qbv0YeawMoEMYeDiFICJmE9jZHjAee76Sonl1fuk ucP/Rx/3lGF4K/FFwOTQ3/2qigax27YxMrxf1Z8Rsa0nXGa69JllhrUSYsdFFQwuB9v93ny9+ZJ ODB8A
X-Developer-Key: i=chleroy@kernel.org; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit
Message-ID: <20260730122722.5PUA-BhUHISym4PetYjSA8-JctSYeHFUleOit0U77lg@z>

Before commit 156460811def ("soc: fsl: qe: Change GPIO driver to a
proper platform driver") qe_add_gpiochips() was walking the device
tree to find all nodes with compatible "fsl,mpc8323-qe-pario-bank".

After that commit the discovery is handled by the platform core,
therefore it is necessary to call of_platform_default_populate() on
the par_io node.

Fixes: 156460811def ("soc: fsl: qe: Change GPIO driver to a proper platform driver")
Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
---
 drivers/soc/fsl/qe/qe_io.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/soc/fsl/qe/qe_io.c b/drivers/soc/fsl/qe/qe_io.c
index a5e2d0e5ab51..02ca556c8db0 100644
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
+	struct device_node *np = of_find_node_by_name(NULL, "par_io");
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


