Return-Path: <linuxppc-dev+bounces-19969-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9C5BFA1FD0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Apr 2026 16:17:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g14813rMQz3cF4;
	Thu, 23 Apr 2026 02:15:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776874529;
	cv=none; b=aDlBIOLdG9e1tV8+jSJ/blZfcCWmc7grwvZCN7rhSQ3YK56aVSSLfZnXlflQYBNlexsE5PmEdklYp8TOtp3c5c6bNu3+oQ2wk0+Cu5gmWo+V1t3LUORlRSn9teMurcZnlNM0cTJfARyf73WfMATxiWK3B2SIhtOpYZnowdEYlpESpPS1n7wnCLBj0ZZ3WJa2c+V9L+pKFLdbLNOVYD0G9ClSugCqDcmmwgsaQAyqxatAzdHYB6hmVnlb5dyPpsUy6PN3iDrqZymByqPrg7Dyk0hwkZxr0v5Bd6Ll71g5it8/gmvP3szgrQHIBaWIiwPZCOMS7ixFPr2LG0nglfInjA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776874529; c=relaxed/relaxed;
	bh=6iND/4ZL9naPVO79jwDQY5n+5NPdSQnKQ6DjGiGSJ4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZiaSGUrcie+NctUg0fauV8BVKMHuIOXq6o2Oq+gtlFBpRIAHrwD1KtTVvdouLqnYkd/r3EcS8N+51WWXPaQYB05cDws4KdtG6+cc2HPXuUIVt/+2Zp42ocx/Fu2+FJ/rDXmi04D2K0B9WkML4Wxr7RqWg9WjYGg+JnPFws8QaYFbsR2u7XtePz/MP3/mGm+HuRepNh+jkLgKPiwd+0fodueLQtMT3acNqSR7smAFKCfDoEQfHFcqjRqprm6iW6iSOw4ZJhIEDlHWhsDtzw4aEnUnpATCKptK5Ss3KuIISQL4Bmo7bMKQMTwml/ba629rpev8xSh3L74QwQJ5VLyHzw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Z94s0grQ; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Z94s0grQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g147w2wQLz2ysZ
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2026 02:15:24 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 5DDEA61330;
	Wed, 22 Apr 2026 16:15:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03B73C2BCB2;
	Wed, 22 Apr 2026 16:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776874522;
	bh=gdUSl0HwkF6RjcCd08P3k3flcgffKuBfltHWAFZaaqE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z94s0grQvvMJgbwtHG4VcOuvIDkTBAApR9rMabBmLdD85kKctkZ12BL/waTysaABF
	 /X2QHoPwFlflhpc8PS/nOqV58V1TlymmAm2BIc76xYFvIpwvU9luSypA4j8Rx9HVhU
	 5sOkAVMThGvMYB5yHX/Zb8eBhysGTCZTEzqurVXwfOZaBtewb31GjbbJO01mnDqAp2
	 ehCWMI1SXe5FiJTJ1gMG7f1RDchHTv3/B+wxNaE+kGFqphsMCMW/HbhezaElOSryey
	 YB8ox04Srs3NHLDQ+4mEj19YpOTb0euwJu1gKI56GTlgCnec1hXvVnpXHfDIeaofQl
	 ZfrWRMddOSzLQ==
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
Subject: [PATCH v6 20/24] alpha/PCI: Compute legacy size in pci_mmap_legacy_page_range()
Date: Wed, 22 Apr 2026 16:14:03 +0000
Message-ID: <20260422161407.118748-21-kwilczynski@kernel.org>
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
2.54.0


