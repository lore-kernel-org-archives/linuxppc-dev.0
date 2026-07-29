Return-Path: <linuxppc-dev+bounces-25015-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63C71C54F51
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Jul 2026 14:10:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9Dl037p1z2yDr;
	Thu, 30 Jul 2026 00:10:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785334252;
	cv=none; b=GCVO2+6iZa8c/IapoKXZHOILQ2NNazLWhUQBBqcwLvekPFRXQbE8AG0yJ5ZN4B3L9UFLW20kbwDrSLWVQ32PG1AAk2hbGadtZSR6KbAJZ27+dtysYn0h/GLZBNpfEX4JqcRaMQue9L/ACSpUt2pcKpKj5LXkpOhRaE8tTOiWI5F0m5mr4zcD1W0CnCgnk8PHqRtdl3KIU6WoHawBATX27L9p60JDf8zTaEhfn4URPIB8Jt1qCe/0u7OtiP+bbCxMyaptDhahRfgCK2USLWlEHpMx5hvmcveAdK6wihOXSY85astNrrQwD7AEKHi9Y7gI6v+oN4D2y+xG0zC+WsL3VA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785334252; c=relaxed/relaxed;
	bh=2a6dfSsGD/MmTbGKcRMsjqnnX+0xSYoSHnMVeczgVxc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d7iaGQhYh2QyD7zboflTLS8/VKfIbkTm+uHhBqx39J95wJTmzHwFHnl7S9nSoxA+10+Ekk3wGNij63jPlnTuE/spX2x9ePK1jDoCkU1Od4c8slO62FRPGVf0kMG0asCPNB9NUwFY2zRuSuELpLe3XQWTLZ6ttBWk/t5t6lYa4Ak8Fzc/IP3lJgc1mXsBaPZs9AGbes9JC71lzB60SYpuBzXIIId03vVlyq+ISSRcCrPx+LpZCZ4768Yl2eQkgAeDuf99a9TSGJOohpnDWqkHEZ7FkbUaYGWtNDYPtvkYHxTgrc6SmAJ4fLYQMJjU9GbMWHDNm0r3CKq07S6QqyMP2Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jlVSKsPJ; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jlVSKsPJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9Dkz5skrz2xwP
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 00:10:51 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 71D0B43997;
	Wed, 29 Jul 2026 14:10:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D80AA1F000E9;
	Wed, 29 Jul 2026 14:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785334248;
	bh=2a6dfSsGD/MmTbGKcRMsjqnnX+0xSYoSHnMVeczgVxc=;
	h=From:To:Cc:Subject:Date;
	b=jlVSKsPJxbWJgIMuaR/OiV6tuadN3sbcjFfTRBoZHuAH4K33MPi4BC2LzF6qDAAvb
	 vgXLyeSrD1e3yGit/7bvxzpQW3jQL8hJwowvFJlN+roD9qosyPDgBpbGaWtRsY4fH3
	 6h72h4NSptCiqrJhWoYEtId+MQNPn4DpfFCfOsj2vGjSCAg4h+RqE+Y85WSFg+ALw3
	 aCMRkEKa0e8FQtjBXBRDfmOsNjSLeggVX886wA/7Z2LdsT7ByWOOSogJIBiMjXq1qa
	 2kzptPAvfdbfXZq47h1o2p9kHYlaSyfzMdkIG/xhuyGJr0dM5059maReEgwJO/SF7W
	 UcmlI0zPTD5pQ==
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: Christophe Leroy <chleroy@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <brgl@kernel.org>,
	Herve Codina <herve.codina@bootlin.com>,
	Paul Louvel <paul.louvel@bootlin.com>
Subject: [PATCH] soc: fsl: qe: properly scan GPIO nodes at startup
Date: Wed, 29 Jul 2026 16:10:36 +0200
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1375; i=chleroy@kernel.org; h=from:subject:message-id; bh=NgJogTZ8D2TsSvzSmrE4tRc1/6SYj6BMw9ra0XiPBuo=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWRlcd57tCryodiepSm73odu47DO19S+MaE3X/DL7fBS2 YPbbhpf6ihlYRDjYpAVU2Q5/p9714yuL6n5U3fpw8xhZQIZwsDFKQATeVPOyLDGuqCbZRrPJqvK pS4iD46+Nt5ct5J3YfpXNQk1nqaLRY4M/52aF1vF2E02fJq5fv+pibo6k+5GTy76bpFX1rZimli JAhMA
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


