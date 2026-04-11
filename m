Return-Path: <linuxppc-dev+bounces-19634-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F04E2F36BA5
	for <linuxppc-dev@archiver.kernel.org>; Sat, 11 Apr 2026 08:03:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ft5kY0zQWz2ynn;
	Sat, 11 Apr 2026 18:02:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775894565;
	cv=none; b=Pz4Es6tqFUQ+wNfXXSJBDgxfzmkyJknyQ3MNPehaMLxYXZNVgXxJllroNakoVmFscXBx18ujOzjEyfad/l6kx5lxdL0jJqxXg14IRhQHQnsSfD/7rTWg7Mj6j+dCGkcN0UlW1eu/1CRPDImZwc+wpV0JpdBaBw30j6Iv6iLduuxYYYzL+9MWCmkTo8KaV/uoMqrJgtKQALxv3mI2S/zhct6taZPq9d01ZivFpk9x6L1ivfP2rQzzlBWTpsmHkAhLIU6+gl3M3skMA9mJ64GjtHZ0xd6npLzN8sCtaZ7NaJXDltFdB7wFYQz4DzhWtb3e67oT39NT/MwL6AuriKJb4A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775894565; c=relaxed/relaxed;
	bh=KPXvKQb8rPUPjaRJYu3yNrvnqKvaclcQ45T4zzuf3a8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TzBS3bdrINBR8gQF/GiySX8QegX0FAODg94b/w8otcH1ObQMe0A5MkA6Jo4Vr2+fVolxliZE08oBys23PRW6xAXYmuEgctoZ23I/qdCEwgbrW69WLGNUZ2h0+cwuBdM6XLVDzuT8nhtTdAUTqA1fDK8Wgf2alzn7HI1ojjndW5yi8FFqDRGycV70m3I7ZdlkjTOOTQS/9cn2nRuSnV2SoEdlGYFEScdUpLQQXRmjeE8tHYcK91++gTJYuTARN6LJtouMfsoha5AcDrbgqtIJldkFv6AQ52CLySyDBfrJ2C7ushfHKW4xXh0rB1jqo1BArvJqfNpaweDRpCBAAemXYg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ZQCKsrLR; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ZQCKsrLR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ft5kX3kH7z2yk6
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Apr 2026 18:02:44 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id AA96B600AE;
	Sat, 11 Apr 2026 08:02:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A5FAC19425;
	Sat, 11 Apr 2026 08:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775894562;
	bh=kjKATkMwwBWbUVCzi5pJZe7y0tUywHculflz6sXXOSE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZQCKsrLRkN12ZbR9aGp2kKcZGxvt4/l5tWCBRwAh2B1eRIMB7FVeK0bf6EmGuhXX0
	 mmik6M6SR717IuW0RdFd2VBrCNbz8+YrSXrJDTSp47zSsONrNPCW7fBUbHhtpigIyI
	 v9zgzAAZYXB6hCeDZ9f9sf75a6khYrB3SD+nW7Oj2XWtZ2kBUj5ZKxhS2y+P4kUkm7
	 p917fcsouobfBSBjIqF/zM0ZXfr/j0rtnXR2KAduqvdnO9E7E2BILFU2kQuL0utfnN
	 vaY2fsDC6QMUctK+k/4PNkXc3ewmn/z1zg7dCYXF/uo4xlv6TdImKVObZGSyJDJzTI
	 rhwsblmw2MaCg==
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
Subject: [PATCH v4 14/24] alpha/PCI: Clean up pci_mmap_resource()
Date: Sat, 11 Apr 2026 08:01:38 +0000
Message-ID: <20260411080148.471335-15-kwilczynski@kernel.org>
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

Replace open-coded res->flags type checks with new pci_resource_is_mem()
and pci_resource_start() helpers.  Move the pci_resource_n() call into
pcibios_resource_to_bus() and drop the local struct resource pointer.

Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 arch/alpha/kernel/pci-sysfs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/alpha/kernel/pci-sysfs.c b/arch/alpha/kernel/pci-sysfs.c
index 7aac5e76dcd6..6c011dab326d 100644
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
 
-	if ((res->flags & IORESOURCE_MEM) && iomem_is_exclusive(res->start))
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
-- 
2.53.0


