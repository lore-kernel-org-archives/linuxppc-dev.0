Return-Path: <linuxppc-dev+bounces-19549-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8381E99046
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Apr 2026 07:15:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fsSkf3zcrz2yr6;
	Fri, 10 Apr 2026 17:15:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775800309;
	cv=none; b=eWhiroUpHujz7U8Qp930EhzWWsRP8MKwayxfGrAT1VcSQGCENFgs4i5pHPWe0z6yxjnqphygLF84WBRRBtFUW0IqfrN3ONzaxaym7WIGUlTs370UcDr7Usskjbkr1+XdSL5oGB++q6m5RHLKqOWRWoD1euZZwu3TY7STzvFWEjuXDYlFrl8KMY4S8xi1vYB/olZqm7JyewSTojgT+p+kCqGYHiYx7AKDsMCuj/JcbTNrl/htRkuSSKuyYKgIZevdq2px/V68KmqTW+DJ4a2Yrl2gstAcl6tu9AO8UryAki+hEuwtrXPqE7G7wB9I1dSsv1HedywEONXhtrxNOzZ6Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775800309; c=relaxed/relaxed;
	bh=FJVHBFY/MHU37My++Wq1lkK0NiXJFf//GnhUi1eqhcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YqdQP4cToYMrmAaefBJHBdzXNdpRvd9NU9Z+1JhVh1TOFVOnobFft1FZ8mWvpjK5d1kesr7saII1gpgqKCR9Z+iItlHosKnkImGgrBguXYrxyfho1kqkWi6eGY9hPWR0vEwLiQJgAcRPNHIg/eauEpFgwvu61qR4E0XqsQl+qkFvnmgscXeLsaAeMHe+GHBDrSjnPF0/omLY/g0eljzpjR5nRkNykbyHFZDVVEyXloQUXyx/QfaTDU/E6a7kdFQl99YVWvg/xEfUg3j+xugTC5zqvlaozoELMhqKL+pND5rSaQw8aqs+wMaPNaQdOLUD+PvlkDX4sYtSzcovLpBpTw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=L9KhOCvw; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=L9KhOCvw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fsQsw6zHkz2yRl
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2026 15:51:48 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id ED37860181;
	Fri, 10 Apr 2026 05:51:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79227C19421;
	Fri, 10 Apr 2026 05:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775800306;
	bh=RaLaicXdVd13BfmiGv2VaH4swf8eCOhEtaGCnbo0iIg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L9KhOCvwhQBtoVpNr6HLSFDBoXOpjGQuwTz5mSKRMKHFJpTYUVqBAQbaySh5U/2c6
	 SN44v4MFI2F7H8mEXNOvh7jTGhAh50/IkSeVwCDEPIPKv20uDiusCSdfc/BSpG9QHP
	 YBGH0h4FMkgUZxvnpLFjQSMJHnYmJyVLRfptvRgl1MvTA0xUpcLDWOQffjysbKv2uF
	 w+8TwLGglwIBY8Us/Km9F1tr4EGd0DKquEmHy9UcAzhCSt66wVtWFKYS/0/3m59ISp
	 AfIgqbwJDk9Wo0Aiv4q36+2MA0J24+dk5j22Lj+MFY2PXNYq/fVP/AoUdu/hVm1lCu
	 8bWvlMrIwMmpQ==
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
Subject: [PATCH 17/20] alpha/PCI: Compute legacy size in pci_mmap_legacy_page_range()
Date: Fri, 10 Apr 2026 05:50:37 +0000
Message-ID: <20260410055040.39233-18-kwilczynski@kernel.org>
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

Currently, pci_mmap_legacy_page_range() reads the legacy resource
size from bus->legacy_mem->size or bus->legacy_io->size.  This
couples the mmap bounds check to the struct pci_bus fields that
will be removed when legacy attributes are converted to static
definitions.

Compute the size directly from the known constants (0x100000 for
memory, 0xffff for I/O) and shift by 5 bits for sparse systems.

Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 arch/alpha/kernel/pci-sysfs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/alpha/kernel/pci-sysfs.c b/arch/alpha/kernel/pci-sysfs.c
index 27adfe6dbd5e..2da95d965e9c 100644
--- a/arch/alpha/kernel/pci-sysfs.c
+++ b/arch/alpha/kernel/pci-sysfs.c
@@ -180,8 +180,10 @@ int pci_mmap_legacy_page_range(struct pci_bus *bus, struct vm_area_struct *vma,
 	int sparse = has_sparse(hose, mmap_type);
 	unsigned long res_size;
 
-	res_size = (mmap_type == pci_mmap_mem) ? bus->legacy_mem->size :
-						 bus->legacy_io->size;
+	res_size = (mmap_type == pci_mmap_mem) ? 0x100000 : 0xffff;
+	if (sparse)
+		res_size <<= 5;
+
 	if (!__legacy_mmap_fits(hose, vma, res_size, sparse))
 		return -EINVAL;
 
-- 
2.53.0


