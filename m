Return-Path: <linuxppc-dev+bounces-19544-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C506E99049
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Apr 2026 07:15:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fsSjv6Df5z2yhv;
	Fri, 10 Apr 2026 17:14:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775800290;
	cv=none; b=KtzWHmmHKwdFBusJZtywnH9G/JAu3cYZmvuenlSLMkqkPRano99itanuAgChbm9cRn8wzQW/jbOkSo0am9AG43UR4aHJcvDDK52adp0cYZZEwB6sxi2DlxpMQDhjHjcqP5/U2jEEPazfb1CyntJYmn0tq1ChZro8N0sl8EqOS6iIrGLx4co0q5hSqux0geffiJ2B0P9yJ+zWP3jQTXlPfQuduYjwCoP2VexvZetQAIz5jFEZfhHmF1gMVKAXi1pKfg0NJpqsuAhkUQ/CqJmG6Cw/IF5gVNV71bB/wf1kwgSUbS0M2UiZCSI+oe+uBV6Wj6bLKaOKUZ/bqJrPJta2ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775800290; c=relaxed/relaxed;
	bh=0Jr3sC47ZEtXeXqMveigYdMC50YGTd90hBXS/qc+IbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cK7uZKFFXx3j+pgtjeROqizPvKFf9JyYNrdQisNTR4wzq/qQjGy4tAwUjDHfih9FTQBOrC1Bpi+kGryCoXt+ypRiHhXY6zTsBm1qQZzMSX+vJDI8KIG/M9HSI7o5j6rA0cpCw1DRARNz2osNc7d+6eIjrW652F26R9Fj2g2f4aQIoUcJYYjA69xniqkdgM1N6w5ySLiDRLN5BYIbmTphYuzwfUYK43Oat5CSqxHn/29o5t21VxZYA7WztS+i869jYZJnRbURBu9Etz+mkfjDW+b7TSYD9PEM8vYdkbjIWVv2ICUL8MsRRE5zfl6ZRfd1IZFDLUX9bRtPijOPLcJW5Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=J/gsQVTr; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=J/gsQVTr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fsQsY4WsGz2yRl
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2026 15:51:29 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 21EFE43CA5;
	Fri, 10 Apr 2026 05:51:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6316C19421;
	Fri, 10 Apr 2026 05:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775800288;
	bh=z4FOR4TwG8rLwyIwhKM+ZusYoPCsVz4loWx7w2LvdEc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J/gsQVTrhEK2zXeKolaZg3jed/dcuw60fYtzbyIzIfPS1vSkpNT99H3Y0r2KTKjAG
	 R/5HH7Phn2ADasVdjYLigZjcZBBpiHpd+WMTA3hq6TWQ0VP5KTlb8g4YHbmwFa1qGH
	 DAx6z3IpeLL5yZ7UKxX07lBULizAy/sTZVCIa/YaEyyeGmsDDbExqfZ58GoZpGEBoU
	 oI4A+XugLEclYDmU++lB50ryGK4p/uvchj8nz8Jn75KJUuvxE9vdkB66O9JPdNohGb
	 xOPGDHwUt7wfgJ7Ha/Zqh9Eg0tUIP3PUigsRopVP/H6+ek824PbrWLW7YMLDWxo1Er
	 lqasQoGvadvxg==
From: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Magnus Lindholm <linmag7@gmail.com>,
	Matt Turner <mattst88@gmail.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Christophe Leroy <chleroy@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Dexuan Cui <decui@microsoft.com>,
	=?UTF-8?q?Krzysztof=20Ha=C5=82asa?= <khalasa@piap.pl>,
	Lukas Wunner <lukas@wunner.de>,
	"Oliver O'Halloran" <oohall@gmail.com>,
	Saurabh Singh Sengar <ssengar@microsoft.com>,
	Shuan He <heshuan@bytedance.com>,
	Srivatsa Bhat <srivatsabhat@microsoft.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-pci@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 12/20] alpha/PCI: Use PCI resource accessor macros
Date: Fri, 10 Apr 2026 05:50:32 +0000
Message-ID: <20260410055040.39233-13-kwilczynski@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410055040.39233-1-kwilczynski@kernel.org>
References: <20260410055040.39233-1-kwilczynski@kernel.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Replace direct pdev->resource[] accesses with pci_resource_n(),
and pdev->resource[].flags accesses with pci_resource_flags().

No functional changes intended.

Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 arch/alpha/kernel/pci-sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/alpha/kernel/pci-sysfs.c b/arch/alpha/kernel/pci-sysfs.c
index c84867ce31f5..7aac5e76dcd6 100644
--- a/arch/alpha/kernel/pci-sysfs.c
+++ b/arch/alpha/kernel/pci-sysfs.c
@@ -141,7 +141,7 @@ static int sparse_mem_mmap_fits(struct pci_dev *pdev, int num)
 	long dense_offset;
 	unsigned long sparse_size;
 
-	pcibios_resource_to_bus(pdev->bus, &bar, &pdev->resource[num]);
+	pcibios_resource_to_bus(pdev->bus, &bar, pci_resource_n(pdev, num));
 
 	/* All core logic chips have 4G sparse address space, except
 	   CIA which has 16G (see xxx_SPARSE_MEM and xxx_DENSE_MEM
@@ -181,7 +181,7 @@ static int pci_create_attr(struct pci_dev *pdev, int num)
 	suffix = "";	/* Assume bwx machine, normal resourceN files. */
 	nlen1 = 10;
 
-	if (pdev->resource[num].flags & IORESOURCE_MEM) {
+	if (pci_resource_flags(pdev, num) & IORESOURCE_MEM) {
 		sparse_base = hose->sparse_mem_base;
 		dense_base = hose->dense_mem_base;
 		if (sparse_base && !sparse_mem_mmap_fits(pdev, num)) {
-- 
2.53.0


