Return-Path: <linuxppc-dev+bounces-22803-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1B59CD98F8
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Jun 2026 08:53:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ghWZb1gQQz3bpP;
	Fri, 19 Jun 2026 18:52:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781859175;
	cv=none; b=jrHEjvb8LbfJgebXizu5aUQQoLh3q8VYndFZHHpdT1X/rmkx2TVEaRFcNsFDYUlxBr7/DQLQZMvdlYayU2cKvHoYFgEUYZKNCVhERzqNxVxaoicCqcs6UUz1I8AX1ztwSh68aClyBWEv/ZNwZ2GNSZd8Vbi8ZTMvkTHwNUoRMu8W0FH67siuLdh4fg9BqIcYMDuVAiek0GFUfxOcqEdPhruBelizrAGImpq9VnfcVfhJljqbREamsObTSo/pKCz9bJKV5hTgyNyM8lSY3dJ5MaEh+6CjUeTOwwXxJvlAHIwL47pIOl+7QEvUC0Mtae3SxVtPCeFkCFfk//l2el9u/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781859175; c=relaxed/relaxed;
	bh=tdD9Lbn8DnP9ORvNg6BF8yTpuzPfY3PhHqazzEpZ/U4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V97/DckVu7eIHgKk5YECyBECxT2d1v9C1+XOnnnDVyZbkT46zbPVPAI5hMR2wVLFZ06fD2L/LOTkabGr/xA1GhpFQa8nBxO/sLwDQdSqfw1Nzho5Rr8LQxh1ZS5/UkpbRn6ZD/+NKDeW82qlV45F9X/aEXNQnWmv017CcPtHmHFKoqWJq2uqldx4HsGnhv5ErAPfU9Wr9d22bud9r85z9HEliWrKF+hVjyJNrinLve7gaEh7UMbU/saPwzzRQmhFnLlFEsVQAWTf0inOLeS1UhcJn3X4hROqpjQmDb65/T1Zwh7MnBbTelc5WeK+gZHQqsIajD5YyZxi5o03JIgNVQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DKTFVmsq; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DKTFVmsq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ghWZZ2xKwz2xF8
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jun 2026 18:52:54 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 85AD1601E3;
	Fri, 19 Jun 2026 08:52:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F27031F00A3E;
	Fri, 19 Jun 2026 08:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781859172;
	bh=tdD9Lbn8DnP9ORvNg6BF8yTpuzPfY3PhHqazzEpZ/U4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DKTFVmsqqpUQeVsDcQRI2+mHxc40tQQX31wsazJdU7mPSkp4nIZwPsMEvb5yOb3Yd
	 XLJvPT68y0mhSLLXXlH18zB/bPFJIs8hzvB2RcblqPwEPjLeYXwdqNtSxTAGCHcJnG
	 5h1k9CxVtWTvdnRUVHT6oYIw5vq1FK+sirjpLsRzc++UBEaAFgCjplg7dvmyh38FiW
	 s3YV5prWQ1Gelbbg3WOdht+385+3+m5ju74EiQkxCp9HHi+IbRlOowLdp4q2wpRFI9
	 7LV0EQmGrEs0hNxTlkQuVFZK2ucrL62By7Lall3tEnIneRMgX1yc6nB8rN0NOfyMco
	 +KtRsYjSckj0Q==
From: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Alex Williamson <alex@shazbot.org>,
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
Subject: [PATCH v8 13/25] alpha/PCI: Use PCI resource accessor macros
Date: Fri, 19 Jun 2026 08:51:48 +0000
Message-ID: <20260619085200.3729431-14-kwilczynski@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260619085200.3729431-1-kwilczynski@kernel.org>
References: <20260619085200.3729431-1-kwilczynski@kernel.org>
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
and open-coded res->flags type checks with pci_resource_is_mem()
and pci_resource_start() helpers.

While at it, move the pci_resource_n() call directly into
pcibios_resource_to_bus() and drop the local struct
resource pointer.

No functional changes intended.

Tested-by: Magnus Lindholm <linmag7@gmail.com>
Tested-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Acked-by: Magnus Lindholm <linmag7@gmail.com>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 arch/alpha/kernel/pci-sysfs.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/alpha/kernel/pci-sysfs.c b/arch/alpha/kernel/pci-sysfs.c
index 2330ab84d59c..5c29f1d2821c 100644
--- a/arch/alpha/kernel/pci-sysfs.c
+++ b/arch/alpha/kernel/pci-sysfs.c
@@ -70,7 +70,6 @@ static int pci_mmap_resource(struct kobject *kobj,
 {
 	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
 	int barno = (unsigned long)attr->private;
-	struct resource *res = pci_resource_n(pdev, barno);
 	enum pci_mmap_state mmap_type;
 	struct pci_bus_region bar;
 	int ret;
@@ -79,15 +78,16 @@ static int pci_mmap_resource(struct kobject *kobj,
 	if (ret)
 		return ret;
 
-	if (res->flags & IORESOURCE_MEM && iomem_is_exclusive(res->start))
+	if (pci_resource_is_mem(pdev, barno) &&
+	    iomem_is_exclusive(pci_resource_start(pdev, barno)))
 		return -EINVAL;
 
 	if (!__pci_mmap_fits(pdev, barno, vma, sparse))
 		return -EINVAL;
 
-	pcibios_resource_to_bus(pdev->bus, &bar, res);
+	pcibios_resource_to_bus(pdev->bus, &bar, pci_resource_n(pdev, barno));
 	vma->vm_pgoff += bar.start >> (PAGE_SHIFT - (sparse ? 5 : 0));
-	mmap_type = res->flags & IORESOURCE_MEM ? pci_mmap_mem : pci_mmap_io;
+	mmap_type = pci_resource_is_mem(pdev, barno) ? pci_mmap_mem : pci_mmap_io;
 
 	return hose_mmap_page_range(pdev->sysdata, vma, mmap_type, sparse);
 }
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
+	if (pci_resource_is_mem(pdev, num)) {
 		sparse_base = hose->sparse_mem_base;
 		dense_base = hose->dense_mem_base;
 		if (sparse_base && !sparse_mem_mmap_fits(pdev, num)) {
-- 
2.54.0


