Return-Path: <linuxppc-dev+bounces-19633-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75E35F36BA7
	for <linuxppc-dev@archiver.kernel.org>; Sat, 11 Apr 2026 08:03:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ft5kT0knCz2ypV;
	Sat, 11 Apr 2026 18:02:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775894561;
	cv=none; b=SRKCD6eF0wcktdSO1ZJRML1PK5Fgd8HfXHE1YEYF3AzHYN2YrgtDhngDW9Wj42xdx0Rc6VxFCaZIYPVZqFxn1mVNt4Wy36JOfE0GTAlk8VgKiSFv0k7BOcjQUEmq+yYDGzf/BdwNKRRgqrMy25PI0Pdzuw2kL7OWOoqVHzPwoAmzQFQ/sai7FsP/8ZM1n8v6wVrb6JnfwxuV6OsHryN8ljxKU02gyU83kj1hBzmrvyjgucyxqJXk8gnmuiUkAkBi/viDGjW/SKYopGeJmYlkBCL+6tGcekamVBk6Z63EV9Cekifv11V4XinHLaaTP8KHdjssnkx+ozznFhGUBKroUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775894561; c=relaxed/relaxed;
	bh=zpasHt6lAJJQkAX9J2ypwzN00VJUtTNKf/0eFKbr0DQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KyVn9K8n5JEtXByFWCmfaeyLs2FzGHsFoc/27vVFhSBxQFTTeTV241vZsAWv5BVxPtnA21WE8QCWZRose4BlaX0iMuoZxtr+qm62FBpy9Q0aB1Kp2pNUjq6+oUcXR161HIP38aZaLuXE6XeH6jKKDnHfVzujooMCQhGpF5hEXYdVOHtOE3Y/Pw/9uCxMGbZulzaUb/bpAYM/ze0jsflBZaAAh9ZTJUTpe74eoch5AFE5pwkMLv1bYpZnj8JShNBjXn0WRbt77gvR5+Ztt3zUuq7JTV3YSeyBU2aDC6mjuhi3kAS98HDNt5HJNSYpZQP9iU+lTMSOThPXlNCYuUqxng==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=L6OIcRmo; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=L6OIcRmo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ft5kS3qMyz2yk6
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Apr 2026 18:02:40 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id EAB64435D0;
	Sat, 11 Apr 2026 08:02:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E828C2BCB0;
	Sat, 11 Apr 2026 08:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775894558;
	bh=Df1aBfnuunD1kkINpPJqSY9nS+M/yRuSpoem5jvpmGY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L6OIcRmokA9ihUuAHXOh6gSaDU7BSbARKEEI8Nj6N3HPK5UN3o4/RZoQbh6NiEzxR
	 veDDOaUEW8sfmwuf9xuFlfKjMs/eInLOGBK+eadSEsh6IfZPCLhDq0PfypnTBlgDSi
	 UqE/2qJDynL5FjpNwTrG1MeUHffg5tHZel3ThsX8axBJwpURwcNsgKgZSbjuD9rLJ1
	 MjMMEXZduzVbvoM7sH3Th/zO/NAq6AA9dvsKeBb5q3CvdLakAi0Foozym6Glr5pDtN
	 +UJAhy/sFruPglch/gIlRac9h8gb3h1tqGUWAGMmmLbBaKW1btnNyf5VMuwKVKFuEb
	 LORCX/crRf4sA==
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
Subject: [PATCH v4 13/24] alpha/PCI: Use PCI resource accessor macros
Date: Sat, 11 Apr 2026 08:01:37 +0000
Message-ID: <20260411080148.471335-14-kwilczynski@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260411080148.471335-1-kwilczynski@kernel.org>
References: <20260411080148.471335-1-kwilczynski@kernel.org>
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

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
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


