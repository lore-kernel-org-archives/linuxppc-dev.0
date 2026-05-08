Return-Path: <linuxppc-dev+bounces-20598-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C81D8CD342F
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 May 2026 04:37:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gBbtL3fQGz30TL;
	Fri, 08 May 2026 14:36:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778215002;
	cv=none; b=AJWTYd5PJYc4MG0epXBiXOlQTDTAhjTltfx8+nb33DDpgq0tspNKo58zPNuqLZP76NMcTBOI2CVWNCF+Hzs8x1uwV2w12Og+iD5eWDwCLRPiQMHykrRdeXZwFyggsNWaHKnpJzCFKsf1ns8nomY9oo8Il7xGxsraYXdV2qcKJNG78DRi07gWgYVvbPrITnGkTvQ6LcGSPPe1G3fQLr3Q7FkNaHaUx4z1tHWKhTCQBnzKcQSyQ88RJNfP9KV1RR+VVI8ZuqDYdrW8TYHV8xuWplRUlk+7HboluzQQV9Tl5KjURL43P3lLykeVc6q/ftdGfiiMnrOTzu/4clCGrTukoA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778215002; c=relaxed/relaxed;
	bh=P3BNww0MIQWHgiDqm6I3OydM0AXlT2dwxg9N+aqoSvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jzHko5p5SHr6zCzkOL36RbOAMI6HZxlPl3wj4ZIFvE17G7tNAUw/nD40rizIGYdqMShe/ckJMXxv4jCjgob0cLT0d/zehBh815Q+lt2fFLeRj9QPfL+03KBdG+zkcnHMrhAwt9fWaEaFgGJRBW4VtHOtXEaDi1DLFxrsdzi1Xcmsf/hJbjKidx0uCxS8emfU5aAWq+SjUlcWeL6qXG+FkXh7wIrN8Xgk9poO3+7KCMesCkyReAtd9g7hHLTPJzp1xAWZy49BjjR5tq7HLaYRF9co3X0xUBzE5b48U/vntUGc6yMpPgyt8MGh0yRdloq68CaGPCvXDSgMqrJjI5qUDQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=T9++uipd; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=T9++uipd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gBbtK6Ggyz2xPb
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 08 May 2026 14:36:41 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id D6ABD43EFE;
	Fri,  8 May 2026 04:36:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73747C2BCB0;
	Fri,  8 May 2026 04:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778214999;
	bh=4JWGb0h1kPyv8PmHZcxIucA20RtT8+EdLkS2uS/1Kn4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T9++uipdD2y8eXSWG2IKzPIr3Loq4cp/Aa/aClw20WqnKOx9xctzHXl4TpXlLtiTV
	 xsePiLbfr1dnQ/bo3m3deBfbxofcC59I2IcgcdnOdZRt3LzH709akuSfqeG++KRJPm
	 AUfyJmG2zuqtXh1bCWx7nasBCjXbCeUskIMMvSVECXFF0WF/nPQnhPsYZtn2ifkvX5
	 ev7YpHhjQnIvqsLLsP4sS96IK9vaO5cgZR5XzfRdcbjUAXBUTCRkY2pejtoEO8dZWg
	 GxaY3SnBg7Mi4O6T7hF+K5Pn7ekiTkTkh2ftuhAIJ1G+YhzMz8WUs9QBAzS1QbebTP
	 a0jYR8+hhbtrQ==
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
Subject: [PATCH v7 14/24] alpha/PCI: Fix __pci_mmap_fits() overflow for zero-length BARs
Date: Fri,  8 May 2026 04:35:33 +0000
Message-ID: <20260508043543.217179-15-kwilczynski@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260508043543.217179-1-kwilczynski@kernel.org>
References: <20260508043543.217179-1-kwilczynski@kernel.org>
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

Currently, __pci_mmap_fits() computes the BAR size using
pci_resource_len() - 1, which wraps to a large value when the
BAR length is zero, causing the bounds check to incorrectly
succeed.

Thus, add an early return for empty resources.

Fixes: 10a0ef39fbd1 ("PCI/alpha: pci sysfs resources")
Tested-by: Magnus Lindholm <linmag7@gmail.com>
Tested-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Acked-by: Magnus Lindholm <linmag7@gmail.com>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 arch/alpha/kernel/pci-sysfs.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/alpha/kernel/pci-sysfs.c b/arch/alpha/kernel/pci-sysfs.c
index 5c29f1d2821c..8802f955256e 100644
--- a/arch/alpha/kernel/pci-sysfs.c
+++ b/arch/alpha/kernel/pci-sysfs.c
@@ -37,12 +37,16 @@ static int hose_mmap_page_range(struct pci_controller *hose,
 static int __pci_mmap_fits(struct pci_dev *pdev, int num,
 			   struct vm_area_struct *vma, int sparse)
 {
+	resource_size_t len = pci_resource_len(pdev, num);
 	unsigned long nr, start, size;
 	int shift = sparse ? 5 : 0;
 
+	if (!len)
+		return 0;
+
 	nr = vma_pages(vma);
 	start = vma->vm_pgoff;
-	size = ((pci_resource_len(pdev, num) - 1) >> (PAGE_SHIFT - shift)) + 1;
+	size = ((len - 1) >> (PAGE_SHIFT - shift)) + 1;
 
 	if (start < size && size - start >= nr)
 		return 1;
-- 
2.54.0


