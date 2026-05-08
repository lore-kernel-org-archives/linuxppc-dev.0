Return-Path: <linuxppc-dev+bounces-20599-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABE3ECD3436
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 May 2026 04:37:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gBbtP5qw2z3cCM;
	Fri, 08 May 2026 14:36:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778215005;
	cv=none; b=neOYTLSPxrddBgmLsdz/7hWNSVmM7evjX8LqXI/5iz+j0Y8N1+dMppTsNzAIsawH1c5CVDnnirB+I1bJp+5EdAUJD5ok7YX+PY7Q06IGylJZPKLzfBkI++592Hg2wQ72zlXFq+u1pR5v8IVlKAN1L4XDhJWjJd+80DyukelBVJa+eYHhrcRqBZBPWgsO+9dDA8Zg5sv11/aR+Nr3pi1CgCbDVp1uXtOGR6y05I/7XtK0Ot6gswwqYNqww/v6iSs8HFo92WmNV2HzwAVHtwdwZtmnPl9KmeUZRK1I2uaFt67k645Ixucz9wneshbpGDHF7xCRnVXrwX9U2FZN8CVMUA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778215005; c=relaxed/relaxed;
	bh=ZCzYyhfxvQAj7TpGJaObGl0Ccl4gbdOuJWkciK3dG9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FrLtTJ1mwKOGcr2UK7FkOjlf6pmv8Fbr22Zk95TA4+fkG2Fjin+1nPwJXZiJOCmYcvXtO9cSV+av1xAxKo5++0sNnLHRZVrrRkpdrw9A+AZDM/VzeZGEFwoil/+rJyJXfs+cxtSyQcRmTsVQVE0icXzzwG+zO/OpQs3W4pkUdfQBGweUglhcESIXdYAOiLAbimzsFCBvF/D5fOyKKJuRVrotV8gsQMYOTb6AeDTCcgKsOQfyY/JqZtm2vgbukNS564HfM58WR9FbnvmkWraH5URuIX2bU+jd9WlsaSQ9eucWOmJhaBY7Wk+XtDECopdXFb0RZ2tkMEu31WpHwo7tTg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=R6HBL0pi; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=R6HBL0pi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gBbtP08jzz2xPb
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 08 May 2026 14:36:45 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 7DF6343EB4;
	Fri,  8 May 2026 04:36:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BDF0C2BCB4;
	Fri,  8 May 2026 04:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778215003;
	bh=RvhmeHPggHFvnpvKsNMm4x+OKY6vAIZNY1FNS7XUoxg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R6HBL0pinAWktnoLCLexrXMErdJxfRI3rqc0tRU23vmwpMZG2iZWBFQiawvwdama7
	 invyEx99A5op8QyhD40MMD/JRw1YfS5fMjapZ3HM3cThGZ00Xf9h4l4VV57lK4Vi78
	 IS83/FicH4dpT7UBDUCjWXj2F+ANaJ82RldQ1UUqAzJq25dtHOv7RqTfeABdNoZ+cb
	 0UFEA5Irs8HN0SSZO3odQp/QJ1wtZZCG0QaqnigEJFbnjrs+AhxM7LLVw2av/xWfJu
	 YDIflHsAtCCxTMFzyXtuNCKBsL6scKYhv8VYhRgR4rj/2L50xgbv1v8Tn3jBvOuCzr
	 W4DsRyW/AmuzA==
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
Subject: [PATCH v7 15/24] alpha/PCI: Remove WARN from __pci_mmap_fits() and __legacy_mmap_fits()
Date: Fri,  8 May 2026 04:35:34 +0000
Message-ID: <20260508043543.217179-16-kwilczynski@kernel.org>
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
 arch/alpha/kernel/pci-sysfs.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/arch/alpha/kernel/pci-sysfs.c b/arch/alpha/kernel/pci-sysfs.c
index 8802f955256e..a8dade7d084b 100644
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
@@ -259,7 +253,7 @@ int pci_create_resource_files(struct pci_dev *pdev)
 
 static int __legacy_mmap_fits(struct pci_controller *hose,
 			      struct vm_area_struct *vma,
-			      unsigned long res_size, int sparse)
+			      unsigned long res_size)
 {
 	unsigned long nr, start, size;
 
@@ -267,13 +261,7 @@ static int __legacy_mmap_fits(struct pci_controller *hose,
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
@@ -296,7 +284,7 @@ int pci_mmap_legacy_page_range(struct pci_bus *bus, struct vm_area_struct *vma,
 
 	res_size = (mmap_type == pci_mmap_mem) ? bus->legacy_mem->size :
 						 bus->legacy_io->size;
-	if (!__legacy_mmap_fits(hose, vma, res_size, sparse))
+	if (!__legacy_mmap_fits(hose, vma, res_size))
 		return -EINVAL;
 
 	return hose_mmap_page_range(hose, vma, mmap_type, sparse);
-- 
2.54.0


