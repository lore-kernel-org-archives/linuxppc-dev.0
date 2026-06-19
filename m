Return-Path: <linuxppc-dev+bounces-22804-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FAE6CD4F26
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Jun 2026 08:53:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ghWZf3Qnrz3brT;
	Fri, 19 Jun 2026 18:52:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781859178;
	cv=none; b=LbJLGtmN7k6D53ACLbPPsnex3wDSx6R1+zowA35ZI1zy/cGaKPO3UerB3Rvwf60ft/1He/3u9fjEpk2H+67JQsVxaQfQMH6qPscGBjOYNjKKt8rqv3kA/KyQRK+Y9/ZvXId89SquBiQrdBeTJaX8ra837R+DvTzQ8ESnCJFLkUV9nqa7zR/fXsdkfTVr8IOI8P1VaWD/HtQenLdTY+o0s6GbHx2FrA3Tdew7XZDuC9iY0y8Rh1f9Ya9xheiTv+dlHwitjC5l1tM/bcf127chnD0zLt7BYytMqmuW6U6TpjtsqDzpcg0Ch7AiYUuYNlKWQM+PozoNswpXfJOVGSkcbw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781859178; c=relaxed/relaxed;
	bh=P3BNww0MIQWHgiDqm6I3OydM0AXlT2dwxg9N+aqoSvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o1ZGu6ihH41FizSfZfHd9gwNC/Gf00xu0BwVotdN8aR588y2cO4JPvaAkYJDUoik/5dF0dyCWqDw1GysTbPTb7mPpuV7WqkB/w7PMht9jbOrt/cLgYmjdM0EjZsDQPRUA0ZJlNzfaD7yGCR1swB7ZpgbgWyX/nIKiPJJlhOXTy0ikPAly6c5E2NDv3G4jnv9EtZsRjApLZzPX7ADVf+7z5X6jrxUgNPSk1HnoWOx2oCxKqQF3dO8cRzcfgxw+cwo1p8khfHuvjwx2+XtNYzstUdFRbWOe6+3EIDcSad6uy9jugHwa5s97wBPWbIVM1PfY3Jj/lO1IDyiDH0WKHwcxw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hwc1jwvY; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hwc1jwvY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ghWZf09B2z2xF8
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jun 2026 18:52:58 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 25632601E2;
	Fri, 19 Jun 2026 08:52:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 927341F000E9;
	Fri, 19 Jun 2026 08:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781859175;
	bh=P3BNww0MIQWHgiDqm6I3OydM0AXlT2dwxg9N+aqoSvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Hwc1jwvYHPp6vWYxt56G+85Za1i8S+y17Eh7vdimb4eH2mD0rMV7veUCOqDw4l1sa
	 8orRl2QsApQt9pnuhNCN9G/sjkP1A1YUYCYJLf2NrTKq2yRRcEbDfCXsm+dLq4EIXY
	 bIJ4ui8Aq4GZxxD8dBhHCxJ3ATkjNgwiQHO48YOJVsA3xmYb0RUmRr39/1SpXPgCXO
	 vBXt/JHQ5FE83R3MVp7LTEazID3kiR9omAi2AhN3y5UGmIiNtVEs7WfYX687KfPrP1
	 1gJ2QQ+D6gtYIvm3UAG28kVv0Km6Pk0pJBSyVOsmqSWyw1Up18mnGxioBHiNCFWX2E
	 +IwTUGqUgMtRQ==
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
Subject: [PATCH v8 14/25] alpha/PCI: Fix __pci_mmap_fits() overflow for zero-length BARs
Date: Fri, 19 Jun 2026 08:51:49 +0000
Message-ID: <20260619085200.3729431-15-kwilczynski@kernel.org>
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


