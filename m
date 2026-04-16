Return-Path: <linuxppc-dev+bounces-19805-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF3D0F8D763
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Apr 2026 18:03:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fxQnl66CLz2yxk;
	Fri, 17 Apr 2026 04:02:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776362523;
	cv=none; b=MNa350emoM2xiFo71yuZzStsp4l/lOydEwEUDetlsYs0PNPdBmOVAGZw/8muEvxfRGpKI0fEWOSEwSNmZzyr7ums5zd7JPkOXm4ZMulxtXanY/+1fMW7ZyUT5PyimcYm4aQ1AIBc814cOB3Gao7W8FrVE7F9qJ2SHpA9z9/mSAA4NMhHUq1yYRnsQKgL3U/POIh6SJnz/qTLi2PN6DsOMd0ctqb6uExs6Q4S9pY08aFTaf6cIKm0lW0oc+/eNK/2dM5Js9CHSlz41VX/wU8ml2AOS+VO7q6vf+MwEis0hzG1zN5/M33oGaVJkba+LF092StKc3Q/vnr3BrqE6U7B8A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776362523; c=relaxed/relaxed;
	bh=W6kK5hHkx3GY9W7MhxLKIPX8Y1lTbu4PH+iQevwPV7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lyEpDsXYYPKzQIuhTiMdUy2hIT21JWvJ+jYPZEziDl0EJvertb1f3Z+amVEbZZM6l+vByXN+ymf++e9JgEHx/lLbshUK128SK+waRWlD8k8U4Oge0kwT+byOVutovTmdRireKy7jXQ73xJFRTVL8V2QYva4KY2DA9YS+UKd+V+9V+UGzG5KruC0Aod0nTFsMB/GBTqPxQCQDIyAPFHtTcakgLB8yyIfS6R6KbjJme5ErBgFPd0uImO5qR9zGkaI18gi8aGR43munfkF9OkumLrv4jr9W5+2he98EdJdqnZCWMcBRh+tHOp8Qi3yt0q3PrKYl7k2IfEo89LUP9QcG4Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=UKTJpz1E; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=UKTJpz1E;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fxQnl0BnZz3blk
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Apr 2026 04:02:03 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 6B97F40E3F;
	Thu, 16 Apr 2026 18:02:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2749EC2BCB0;
	Thu, 16 Apr 2026 18:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776362521;
	bh=QOViSCcvUL9uyzox8/RADcIRKqDxy6ADtOAMBKvcXqE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UKTJpz1EAj5v6XqpXjYRWO2k81NaT8TbDwK6s2pv53HM7HaGAgCPS+XiXklModdHg
	 iDJ9/fSyrZZzc+rFVaUmTdsdnSwpjP0ZLRBmtuX15LCWPG0EHIMBMtwLxY1mTMwwBt
	 wDdhfZBJxCbsKeyO+1yi0Lw4EpD9HK7wDLG7mT0v3m787VKgIXpxE60KFFnAR/t+dS
	 iZCJSpAsSzKgSUVKVZJ/SczeD46HhcPlVBjICZUKlAgjU/HW/Qi4IaRNHa8eTJZmRu
	 yvFNhlNnDZoRs9N7euu8XylTXyNx/MmKUdTRJwXu1QAV4lZaZrCqwiXf+R8pyuZHev
	 EtrfC/LJyfLoQ==
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
Subject: [PATCH v5 14/23] alpha/PCI: Fix __pci_mmap_fits() overflow for zero-length BARs
Date: Thu, 16 Apr 2026 18:00:58 +0000
Message-ID: <20260416180107.777065-15-kwilczynski@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416180107.777065-1-kwilczynski@kernel.org>
References: <20260416180107.777065-1-kwilczynski@kernel.org>
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
2.53.0


