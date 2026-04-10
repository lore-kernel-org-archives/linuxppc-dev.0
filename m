Return-Path: <linuxppc-dev+bounces-19545-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2005EE99046
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Apr 2026 07:15:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fsSk35hBsz2yqP;
	Fri, 10 Apr 2026 17:15:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775800294;
	cv=none; b=dyps4s4RHhzBiVfM7FWuHNCA9YdJnqRJdRYmTcMtABBazibNGNucVY82AHc8xs9/0RDO44BjxdCVykDxI95wuVFeTnLbMgKMWypeLgg/MJHGBd3wri/kdewOFkL6mddnDTJmdZKyaEibrtGvKCW1feTafGunwrgZjVJhanojssoIDZ6m8va+lEolmxi5Az90qcwvf1AEBlba/ncISOEpccR474l8ukEudRwV0pbdvQp4dUUa823L2Vjp+TT9oBhA+Jp1RrbWy0lgZ/qTSqpTnO9ixrX6qiSjINQN21y3j9hFplNa0LrXPYvY5VgukuaK4G3Q/7FjIzxvl91JubWNaw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775800294; c=relaxed/relaxed;
	bh=7ihdq0dkuXXlKpfHGFEsrcCKM1l9tINSYpcYKghtRok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iiEp/GODJgioOO2WqBCl7VbW4u5m/WrJgcUppMsnOeW8sOhg2gYQ2HuZlDJfmNpO9gWpEc+2zR4RYV4NX83pTWKFxDz9iT9VygM1UtKgLnn2tfKxo4RozsuwunY6d8XbK+IG/UjFFq1MFy4duzvLKcbv2VseUUOCP6UAXxtcMthCqLtFi+zi+fHZHAGRXIweOTG9tG2B4ArZTVIcgVHyM/mbqB2AJw/XSyBrP1aZQ1dh3SAeLKJKhwN5RCuUK5xEswBaJuBS/Oex0QkigGZbxHEAX2n/SsUgb+KRC/K8UcKgc3qSc9jYn6Yr6DpvdNd+JYZutYjyTl/lDtD7LM+g7Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=XGDauH65; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=XGDauH65;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fsQsd5dpdz2yRl
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2026 15:51:33 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id DF9A660154;
	Fri, 10 Apr 2026 05:51:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A7F7C19421;
	Fri, 10 Apr 2026 05:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775800291;
	bh=Nh7a1ArkRQeNDsZQ4G4s7B27zHMA9oeNqUUdRhEq7Fs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XGDauH65tg4bJ9ruSw7Z6gY2FgZvSRdoiVLxHgO6FHnL6maslO7dpOby3VlujfHY6
	 lp71qjGPI9FnJ+YkDygQZLF5ftlEhT8uDDo3MIf7YZBN6Itnjwxnhzm72KF4k+HFD0
	 GpQmeT9QHiDMxTrn+nKdUqMsIwo+qI9jQVMvVAYuN333KZPyYMJovH9pMhkBeIGf2V
	 5iyGh6zq4JQKEamShug3eT7CotSXt3MqJ+1Tg0qxcotMGh+oKGvTXX7Cs6ugCuVz52
	 aLYqZNvCXjb5KJX1U93HTRBGcVdyqotqEjICJRYp1s9beAn1C1ORBRpyLbEfda9fm/
	 Li3fkgG20rMiw==
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
Subject: [PATCH 13/20] alpha/PCI: Clean up __pci_mmap_fits()
Date: Fri, 10 Apr 2026 05:50:33 +0000
Message-ID: <20260410055040.39233-14-kwilczynski@kernel.org>
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

Currently, __pci_mmap_fits() computes the BAR size using
pci_resource_len() - 1, which wraps to a large value when the
BAR length is zero, causing the bounds check to incorrectly
succeed.

Thus, add an early return for empty resources.

Also, remove the WARN() that fires when userspace attempts to
mmap beyond the BAR bounds.  The check still returns 0 to reject
the mapping, but the warning is excessive for normal operation.

A similar warning was removed from the PCI core in the commit
3b519e4ea618 ("PCI: fix size checks for mmap() on /proc/bus/pci files").

Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 arch/alpha/kernel/pci-sysfs.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/alpha/kernel/pci-sysfs.c b/arch/alpha/kernel/pci-sysfs.c
index 7aac5e76dcd6..867199b988de 100644
--- a/arch/alpha/kernel/pci-sysfs.c
+++ b/arch/alpha/kernel/pci-sysfs.c
@@ -37,20 +37,18 @@ static int hose_mmap_page_range(struct pci_controller *hose,
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
-- 
2.53.0


