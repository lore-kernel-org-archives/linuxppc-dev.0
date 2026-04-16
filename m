Return-Path: <linuxppc-dev+bounces-19811-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 239B9F8D763
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Apr 2026 18:03:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fxQpB0bDFz3cHS;
	Fri, 17 Apr 2026 04:02:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776362546;
	cv=none; b=Bp8bS3H7U/qhdno231BwVocVsQbj1bkKb5y5Aw1afHLAfvi4iAedDKA+MdfPgVX7RmV7CrmfjpBrbc7+3wA67FrQxRVKnCIG0M2mA5JbB4FGN+JNuFwZA/gLYQhXhrIWBIGjpvUOxEjl1rd7WRX0WABStIxhYRTmknpnGT9mNF8Jbv4VO28nDm/5iarXz9DeGUQ/IQp1QCVhrm89MKYX0LFgA8J1Pe4MzghnRzefNVYcuuuis4XtGszAHId+GtdjxpAWaZlyfhpe3Ej00pUtHdTbabaRIIWBAorSlegM3nNYQzH9tNiORQulNmjuNkZDcf7Pmy4W90FO1kImaVv0Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776362546; c=relaxed/relaxed;
	bh=qSe2jMZYguaP33I5HEBEuUG0xfaEyFrbEUN9iiB96pc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dbzS5jgdC1WK8TCo33asmmIDRKAWpmAdNydSi3EBgIAA2rzNCpUwU9zrG+mTfHC61f/hUPUbWNOuKEeSMf5yKh7MH8mjsPh2NN61/vr13KmZmg/0IYnNVaFhl8UTljTg5BmNhntvTRMwoH9CJtBsqS7RT8JHfp2kZgXE6gyGG3GjvFEuM5I8/+r1wdyMHVDChstKjU3VL5Bcbz6e8gbKVmsGNSJeVSJDha2flBvctlGWxydzufVMIux9PgTBkIHE51vFLT2cpy+Zky5rq7zZnNILuOjQG9FSpI58lbk9oG5/inCjSHTxxjtSphlogWfKmNm4ehst3rgnC5Vol0W5Yg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=JZROWxYM; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=JZROWxYM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fxQp93hc1z2yYK
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Apr 2026 04:02:25 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id E515640350;
	Thu, 16 Apr 2026 18:02:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5E97C2BCB4;
	Thu, 16 Apr 2026 18:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776362543;
	bh=3y3q4SKWG8uBCQVxES1VtyO8TFOC6cRnNz4hWDgP87I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JZROWxYMyZnpkJ0LQfB/oZHknpvcDP9f05j4Zye6NbiSSEieB0+XAtLHztwXaLNQP
	 zUXBh6dafQRhY1r9+qHucHSisgWRn/svKtQzC6xjKzBb6Jsa2kAR1jl3w1z1f3iZ7Z
	 Bk7P0gGLjPJOWm/yFifbnORGr0npbqP7+2sSSgUnOT4EEPKaMOa/7AynmfHVPxLPg5
	 1yrGSEq59p/RT7qDszGEmJEexbKvIRE6sFMZ4Bss8kyrphry6iaYnWRkdnqOEJxq7E
	 i0ZEa4KlWRTFmL8jNDEMLXdwVB20c9lVSn55q2g5W7PFSYQ2RR2SY/m2omgxCctDqH
	 Ru0xO0Y0zcMYQ==
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
Subject: [PATCH v5 20/23] alpha/PCI: Compute legacy size in pci_mmap_legacy_page_range()
Date: Thu, 16 Apr 2026 18:01:04 +0000
Message-ID: <20260416180107.777065-21-kwilczynski@kernel.org>
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

Currently, pci_mmap_legacy_page_range() reads the legacy resource
size from bus->legacy_mem->size or bus->legacy_io->size.  This
couples the mmap bounds check to the struct pci_bus fields that
will be removed when legacy attributes are converted to static
definitions.

Compute the size directly using PCI_LEGACY_MEM_SIZE (0x100000) and
PCI_LEGACY_IO_SIZE (0xffff) macros, and shift by 5 bits for sparse
systems.

Tested-by: Magnus Lindholm <linmag7@gmail.com>
Acked-by: Magnus Lindholm <linmag7@gmail.com>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 arch/alpha/kernel/pci-sysfs.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/alpha/kernel/pci-sysfs.c b/arch/alpha/kernel/pci-sysfs.c
index 2e9693e5abe1..b986ff1e7a82 100644
--- a/arch/alpha/kernel/pci-sysfs.c
+++ b/arch/alpha/kernel/pci-sysfs.c
@@ -180,8 +180,11 @@ int pci_mmap_legacy_page_range(struct pci_bus *bus, struct vm_area_struct *vma,
 	int sparse = has_sparse(hose, mmap_type);
 	unsigned long res_size;
 
-	res_size = (mmap_type == pci_mmap_mem) ? bus->legacy_mem->size :
-						 bus->legacy_io->size;
+	res_size = (mmap_type == pci_mmap_mem) ? PCI_LEGACY_MEM_SIZE :
+						 PCI_LEGACY_IO_SIZE;
+	if (sparse)
+		res_size <<= 5;
+
 	if (!__legacy_mmap_fits(hose, vma, res_size, sparse))
 		return -EINVAL;
 
-- 
2.53.0


