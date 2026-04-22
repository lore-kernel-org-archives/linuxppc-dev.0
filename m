Return-Path: <linuxppc-dev+bounces-19962-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16E1FFA1FC7
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Apr 2026 16:16:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g147c0WbKz2yvG;
	Thu, 23 Apr 2026 02:15:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776874508;
	cv=none; b=LPRFpTjNN8VCVMM16vdGewIpAMfkW5P1NSieDQpyGArJW2bDXWygva6nZpXmGhyNQ2LGiYWWb+rKkF/iQR0BEe45lFWM+GsMzmZ5gKM3XGwBaI9fmVvgvadb64WjO4kvHF1gNgg31ZlFKxnnx1VDY2bheiuWpeBi5tlAJpEKlYVUlU7XilUXntHvGm/rpKkv/m7waakAC4OSR0bv9pqRHIe3sX4zpcaT3pW0zR8p5YWmmFT/1sPVUn4FOq0MPeqN+C1s16VOLi6wpkLYPvSrC4Kfg1Jp/uc79mARnNebCBliKIqhgKEeZF7iQm8E9diGv71iRB6HWxDqstKYaqaxgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776874508; c=relaxed/relaxed;
	bh=dDjlkloGmwHD4vgFKTD8OFMqGFNr61u/M+E9P0ufF1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cEBpGNvICKJGQykkp7NyO5p83tDxi8aZAKmq7HYSpiwRtjzZ1tVWD0rjKQageuVtAZ5HqO6mxAaknBE0jeUJqdw+GxBZun5oZjHBcgHRSc0cvHXcKdp/6iQLFk1jIPn78onlCOMpHywLK4jTXJ+TVBbkTPWLwOx7/XfLEygL98k15b8r9b87vq41Aa+TxTs+gO+tpNgDnEeEJs1R3PhGHEND7OvXQVPEyJxKWZ1kRVyBOFnnd4vJ8yH7VZpGzHrvDuaD2HkwHoAXX4H6yvj0hqVadJz0/Z6rm/n9xVm/r6OM8OJ18Ql1qBKNiBDygVk0lUijalsOT9vep77wfc5BDg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=rrE1j7uy; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=rrE1j7uy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g147V6QlWz2ysZ
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2026 02:15:02 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 0A92660581;
	Wed, 22 Apr 2026 16:15:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D06BC2BCB4;
	Wed, 22 Apr 2026 16:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776874500;
	bh=dkenDLAyAT+KiwXEFM4WIJAXbFTQKkHWTcI169/tbfw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rrE1j7uyIswhjn2yhrQSx3VK/tgsSMYjSTaeOjMIf6xQaDlUfI/U2ig03JKGS0G73
	 3z72S4W+GaTnOdwG+Q6AtZKdOt1fowfIdzK0ctGVLkUu6ej1jsNtlvhfYyKSeBN4b1
	 GO0/sXri35yNoYsoLhmqaue3t5lYJeQqukI7z9COrJb3gbzUz0xZIsxu5UwPCGKX3a
	 UJg8HyWTzAUExXlkKb1DGD3EZtVZ+S71QT7V8aB5wxpPgAM4lRdrgGnSCo9eE8+hdG
	 dr3jT9Z90eVH8cCS/aKFoFaIfZi0J8oc95v6zs3ThvvkSSQCPzb6VUxnpm5pj+5/PG
	 DI1b/hxppuyBw==
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
Subject: [PATCH v6 14/24] alpha/PCI: Fix __pci_mmap_fits() overflow for zero-length BARs
Date: Wed, 22 Apr 2026 16:13:57 +0000
Message-ID: <20260422161407.118748-15-kwilczynski@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260422161407.118748-1-kwilczynski@kernel.org>
References: <20260422161407.118748-1-kwilczynski@kernel.org>
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


