Return-Path: <linuxppc-dev+bounces-22805-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2112BCD98F8
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Jun 2026 08:53:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ghWZj6399z3brZ;
	Fri, 19 Jun 2026 18:53:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781859181;
	cv=none; b=L4FJHaRkDzJjMsN7OTWEU54CBEZdLWTIjUaSz22Hgn7ju33TIU1nL9axe0g6z8OCZA//Kymm5/ca7UjMu+fa9wziKeZybm38NqXm7Zrp47noduc+khxjl81EcFJlBof5bGdsZI3iCbfsXUF/n9umpY2kLyTPdzU7RuYHqLAGKeRwIdIcTACtblg+cpHUAXkVWFnVzkY6rKNy1oQhRm+upHWCzc+lOaH6zFM4JiuMW8XYfLmWtsyaz/buZJ2LGPVWr20CBdhdoML97U1Me0H6Co8QtMqvHbrTBXFnitbtQebfSQ5vAmN/HZs1k02XBBI8g7ZqSiWkZExvMlgVgcHOzg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781859181; c=relaxed/relaxed;
	bh=MeaEEnmBG3oFKgCGg6n5aGYQQrjBqtYm3M3kvW7MyfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J4jYZaIrNhiTNtsx0DrL1dR3QTep/xiWBvZ34PtZzJlBaHrUdQB+i1YU+fJ5ZkhuFz3+lb2FmkVsrDcZA0scy7wbiMS9gatmrLH4s6OIWh8jxGN2QVkL33AWDH9TtAvMtv15+kBeF0vaRzhJh5DxGdDVUjpxHngc3uTmz3kMFVelLlVkkMmCaVe2K8gd88HWAq8692ON54eFT9GYIH6fnJFe4MTKHvR3vRCjayWPlDqoztlwm6haUM8BClYjn2DEg2PDcKzKaBC69izEixkFuAY+RueCO8sOdCEjkV7coOSg7ZiM+pQYHRij+qpd6qL3/uehgR2ASBBXhPkSl8s5fA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ay+xccoW; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ay+xccoW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ghWZj0Xfkz2xF8
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jun 2026 18:53:01 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 8D060423CA;
	Fri, 19 Jun 2026 08:52:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 321D81F00A3D;
	Fri, 19 Jun 2026 08:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781859179;
	bh=MeaEEnmBG3oFKgCGg6n5aGYQQrjBqtYm3M3kvW7MyfI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ay+xccoWO5XnpgZk1oKZFJZZeGhQSJMAzeBZw+eAH5wtWwFtcm04l52kNpAlovzhk
	 h7RrSXfuwshrgk9JMSOa5gswG8TeTnxcou7rigMbDDeB0SW/Fnf+XQ7bMdoRUO7AzC
	 kH2oGAAgqooZoxxPQfdLaAyfJiBS8h0viAjuYG7lQF5/jboYz4oAG4UvIQ2OUt3ANw
	 AkF9pmG+SZqPyW7W7GSm24iHM2bIzzq5VWixm1DWtcPvzBT3U4Lup5r3WJSwvTI52R
	 cssdI3PSpGYUYYQ2UMqMyXxQ7Jye4oYOLxLPF17yTko7m+T8E2II4VjOZff1QPPDFw
	 d6houki/oEC5g==
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
Subject: [PATCH v8 15/25] alpha/PCI: Remove WARN from __pci_mmap_fits() and __legacy_mmap_fits()
Date: Fri, 19 Jun 2026 08:51:50 +0000
Message-ID: <20260619085200.3729431-16-kwilczynski@kernel.org>
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

Remove the WARN() that fires when userspace attempts to mmap beyond
the BAR bounds.  The check still returns 0 to reject the mapping,
but the warning is excessive for normal operation.

A similar warning was removed from the PCI core in the commit
3b519e4ea618 ("PCI: fix size checks for mmap() on /proc/bus/pci files").

Tested-by: Magnus Lindholm <linmag7@gmail.com>
Tested-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Acked-by: Magnus Lindholm <linmag7@gmail.com>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 arch/alpha/kernel/pci-sysfs.c | 23 +++++------------------
 1 file changed, 5 insertions(+), 18 deletions(-)

diff --git a/arch/alpha/kernel/pci-sysfs.c b/arch/alpha/kernel/pci-sysfs.c
index 8802f955256e..6cf688621ea9 100644
--- a/arch/alpha/kernel/pci-sysfs.c
+++ b/arch/alpha/kernel/pci-sysfs.c
@@ -48,13 +48,7 @@ static int __pci_mmap_fits(struct pci_dev *pdev, int num,
 	start = vma->vm_pgoff;
 	size = ((len - 1) >> (PAGE_SHIFT - shift)) + 1;
 
-	if (start < size && size - start >= nr)
-		return 1;
-	WARN(1, "process \"%s\" tried to map%s 0x%08lx-0x%08lx on %s BAR %d "
-		"(size 0x%08lx)\n",
-		current->comm, sparse ? " sparse" : "", start, start + nr,
-		pci_name(pdev), num, size);
-	return 0;
+	return start < size && size - start >= nr;
 }
 
 /**
@@ -257,9 +251,8 @@ int pci_create_resource_files(struct pci_dev *pdev)
 
 /* Legacy I/O bus mapping stuff. */
 
-static int __legacy_mmap_fits(struct pci_controller *hose,
-			      struct vm_area_struct *vma,
-			      unsigned long res_size, int sparse)
+static int __legacy_mmap_fits(struct vm_area_struct *vma,
+			      unsigned long res_size)
 {
 	unsigned long nr, start, size;
 
@@ -267,13 +260,7 @@ static int __legacy_mmap_fits(struct pci_controller *hose,
 	start = vma->vm_pgoff;
 	size = ((res_size - 1) >> PAGE_SHIFT) + 1;
 
-	if (start < size && size - start >= nr)
-		return 1;
-	WARN(1, "process \"%s\" tried to map%s 0x%08lx-0x%08lx on hose %d "
-		"(size 0x%08lx)\n",
-		current->comm, sparse ? " sparse" : "", start, start + nr,
-		hose->index, size);
-	return 0;
+	return start < size && size - start >= nr;
 }
 
 static inline int has_sparse(struct pci_controller *hose,
@@ -296,7 +283,7 @@ int pci_mmap_legacy_page_range(struct pci_bus *bus, struct vm_area_struct *vma,
 
 	res_size = (mmap_type == pci_mmap_mem) ? bus->legacy_mem->size :
 						 bus->legacy_io->size;
-	if (!__legacy_mmap_fits(hose, vma, res_size, sparse))
+	if (!__legacy_mmap_fits(vma, res_size))
 		return -EINVAL;
 
 	return hose_mmap_page_range(hose, vma, mmap_type, sparse);
-- 
2.54.0


