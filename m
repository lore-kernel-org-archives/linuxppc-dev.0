Return-Path: <linuxppc-dev+bounces-20604-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C7A8CD342F
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 May 2026 04:38:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gBbtl5xJnz3cMb;
	Fri, 08 May 2026 14:37:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778215023;
	cv=none; b=ItYkjcLkIOpDLlz60tlYgERQfq9aacrnlyRK2R6UPSNamv+pdz1twmbapmderYRTL17U+0li6t1GuiWdkG5Mz2G0l0lrJq2FSiyO9RVPswMqFFydNNobkFwIrjDNUKBK7XXBKTsseBA6aQ58xyOT7FjrdsDfTnXpqxpVGcuNMRi4PPuJzR1VJTA0Banc7SMXrutieF2yNDlhD+YOriujhKLu4QoF3bLEsfO/5ywS6leUBNwf/Ht7vQuNHKTafrfCIsca6UHJUZTQmKGHp0UjPNRfARyxuqOrjkrfrClr2fDk9KaSCe4N8qedcMM2BQzm/CN7UpCPoL1NykoBVY4AHw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778215023; c=relaxed/relaxed;
	bh=VLDDduvGEPWCHUo/WiiCZGDIlwQ6z5Hcav+mokdoq3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JJ+RJtS26HZJNAqKFe8rQLNywUNchUaDn+NGtbBGaHqzMYfoj7B9ywv1q8loWrVwCQMcIa2N2V29Z8dLYEUE0VWUUUlywcpJ1T09IEqAsq32adTOj18YmUrYog9LYfw2/2FxLWUv1FJIEtlULyeFo/+4+flTwL5ZRkLYuYn+CZ7uK2GFlGKp4kJiIGdfVtkOBpp3JNi9cWAont5Yx6e2HzJeFXGguV/fk9TygTsC69dQzEnQemENRy0yAb8RovHPZIZrqc6KQ72OKf+aVtgoMl9YXd7Vq2wpRFaqe/jhWNARrXebIG1eFwQbA1ZBq1T3vTW/G1YGQo38hwCnDQGLHw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=fHz1FCRU; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=fHz1FCRU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gBbtl1zF5z2xPb
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 08 May 2026 14:37:03 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id B46F043EB4;
	Fri,  8 May 2026 04:37:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53081C2BCC9;
	Fri,  8 May 2026 04:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778215021;
	bh=79vPpWeuwl76jaz34iY/J6HyO6/6tH4ao0+c7EMnbMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fHz1FCRUoHZFoS13vfeHM9gmE+SRBentgLzxS3Z7PuJ5J/b21bEUW+s9aDPIvU1H/
	 qkAVbRF7MBlhT2f2XwbRrCKDZrTHFrt00aao3Il3HqylLNwI6L1NN+0Ax3iQXJNwE6
	 GtBy3veqo+SN4FzfTXkvHOsrPcPmFPGiNZBw51W+6PUqDFrX0uPNTD7+g1cDLqazvc
	 vrKZeCpRTm4F7B1mh7G4kz+roO80RgtCDtYK9rnGH+nfqIShQIWK+xRbmjOmR2fWMr
	 GlsRMomvV+S0qzx5Iwqotb6pwmeiiSThmqV1tyW3casm/AmIKDHFReBKWwBfPbcAQD
	 bnKLHX5E7j9Pw==
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
Subject: [PATCH v7 20/24] alpha/PCI: Compute legacy size in pci_mmap_legacy_page_range()
Date: Fri,  8 May 2026 04:35:39 +0000
Message-ID: <20260508043543.217179-21-kwilczynski@kernel.org>
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

Currently, pci_mmap_legacy_page_range() reads the legacy resource
size from bus->legacy_mem->size or bus->legacy_io->size.  This
couples the mmap bounds check to the struct pci_bus fields that
will be removed when legacy attributes are converted to static
definitions.

Compute the size directly using PCI_LEGACY_MEM_SIZE (0x100000) and
PCI_LEGACY_IO_SIZE (0xffff) macros, and shift by 5 bits for sparse
systems.

Tested-by: Magnus Lindholm <linmag7@gmail.com>
Tested-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Acked-by: Magnus Lindholm <linmag7@gmail.com>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 arch/alpha/kernel/pci-sysfs.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/alpha/kernel/pci-sysfs.c b/arch/alpha/kernel/pci-sysfs.c
index 20c97c06d755..89329910b890 100644
--- a/arch/alpha/kernel/pci-sysfs.c
+++ b/arch/alpha/kernel/pci-sysfs.c
@@ -174,8 +174,11 @@ int pci_mmap_legacy_page_range(struct pci_bus *bus, struct vm_area_struct *vma,
 	int sparse = has_sparse(hose, mmap_type);
 	unsigned long res_size;
 
-	res_size = (mmap_type == pci_mmap_mem) ? bus->legacy_mem->size :
-						 bus->legacy_io->size;
+	res_size = (mmap_type == pci_mmap_mem) ? PCI_LEGACY_MEM_SIZE :
+						 PCI_LEGACY_IO_SIZE;
+	if (sparse)
+		res_size <<= 5;
+
 	if (!__legacy_mmap_fits(hose, vma, res_size))
 		return -EINVAL;
 
-- 
2.54.0


