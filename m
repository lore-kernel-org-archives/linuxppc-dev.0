Return-Path: <linuxppc-dev+bounces-19641-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DA43F36BA7
	for <linuxppc-dev@archiver.kernel.org>; Sat, 11 Apr 2026 08:04:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ft5l30S2Nz2yr8;
	Sat, 11 Apr 2026 18:03:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775894591;
	cv=none; b=Ogh3S4l/YtpJrH8m3MmBoCh/WQTNJUVuR3iZnD3W6w2CL7JrRmgPe2UI36dfYWHYnkNQLcpQ2xcgPSFY31D7XMK0lbcXhPu1Biv67Q230Ttk+wmRiOIFabwyjiGkwv/IotTZq/nOwqDnd7dTavOOzwgs68g0Rde2beUetouYe6e6aaL7FjXX8+Mbap8Iz0vT8TttR5QJSNo7rsQOI2c6w3i0s7JFZRGwhmJqMuIOLaHpxZiKV/AVnVqlJJa3qE8dhwmwh6XuHrVXfEDlITOw2lh5BRe2i9uFseyg8s+Lpr6Dlrcfag3t6kogpLw7o7uNzAlyo9iFSxqiYVp8y5KIEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775894591; c=relaxed/relaxed;
	bh=roku7nry9hr3kb8D2tlI5HZwGM5sF/zi2mzoneIm+D4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FGvx6hSLwUb3Zr6k6zbNQLqhVSyAxdMt6gD9uuxSid3vU2mNe9wzTWNWfMOiAtbHRuS/GIj4+3ULNV29wtB44udmiqw3I74z4FTN/nakCVwDj5x2ubJqODWVg2xJHRn6XaJSOpwwTaw95NWb6vxoApaFY9S3Y38/DWQLmXlaFHYOe8mmvwKy7fjuYyWyS/CpCZziXhsjeNVChQ1N53FVXPV+ZBPxDyX+fDbFUY0cPsy4VcsICCkpaI/LNWVutV0m+lR32vTwaR3jyp+QwwVh+i8qnj304g+M2bKhLXJWPVIKJVerHDxG/ngc5Tq8Hwr1CQaWHMWQhust8Rrh4R5ErQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=f8NEYhhq; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=f8NEYhhq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ft5l235pZz2yk6
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Apr 2026 18:03:10 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 3090160142;
	Sat, 11 Apr 2026 08:03:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4C61C19425;
	Sat, 11 Apr 2026 08:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775894587;
	bh=zSxumLDhzl/GXuL/vxCq5TbNSO065j7mWpkMfmgLc8Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f8NEYhhq6D8W6aFmYfs/BzPuBeHU9YkT8aICazqPgenLqFEffyJIXEsTcGBwRGffm
	 ZOCGP1llYQkF7hIklBiiS9wz+9Wl4stAdeqDdQ1EPoRT2S8Z2quciSpc3VfYsu37Wa
	 gSuR1wTJ1DmzMUPVTfR7MzVvhoxxHg+JG7zQxHoJBFfWhhDu4O44SzkUqHKyTFo00a
	 AIaVxOLERCJcltbMq67MdL9AYOE8zLzR7EbujGs/KsYD4OmqCd/KNFq9D8xBerMF6H
	 iRUqVmdN1Ic3XqqXtWQ8eymzyF0zG9saApjbGnAvhzqBJFmDy8U6Dh3Amkykvkb6Bs
	 qVDfTdOLUlsSg==
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
Subject: [PATCH v4 21/24] alpha/PCI: Compute legacy size in pci_mmap_legacy_page_range()
Date: Sat, 11 Apr 2026 08:01:45 +0000
Message-ID: <20260411080148.471335-22-kwilczynski@kernel.org>
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

Currently, pci_mmap_legacy_page_range() reads the legacy resource
size from bus->legacy_mem->size or bus->legacy_io->size.  This
couples the mmap bounds check to the struct pci_bus fields that
will be removed when legacy attributes are converted to static
definitions.

Compute the size directly using PCI_LEGACY_MEM_SIZE (0x100000) and
PCI_LEGACY_IO_SIZE (0xffff) macros, and shift by 5 bits for sparse
systems.

Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 arch/alpha/kernel/pci-sysfs.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/alpha/kernel/pci-sysfs.c b/arch/alpha/kernel/pci-sysfs.c
index 2e9693e5abe1..a9dea147528d 100644
--- a/arch/alpha/kernel/pci-sysfs.c
+++ b/arch/alpha/kernel/pci-sysfs.c
@@ -180,8 +180,11 @@ int pci_mmap_legacy_page_range(struct pci_bus *bus, struct vm_area_struct *vma,
 	int sparse = has_sparse(hose, mmap_type);
 	unsigned long res_size;
 
-	res_size = (mmap_type == pci_mmap_mem) ? bus->legacy_mem->size :
-						 bus->legacy_io->size;
+	res_size = (mmap_type == pci_mmap_mem) ? PCI_LEGACY_MEM_SIZE : \
+						 PCI_LEGACY_IO_SIZE;
+	if (sparse)
+		res_size <<= 5;
+
 	if (!__legacy_mmap_fits(hose, vma, res_size, sparse))
 		return -EINVAL;
 
-- 
2.53.0


