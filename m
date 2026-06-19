Return-Path: <linuxppc-dev+bounces-22810-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 674F2CD98F8
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Jun 2026 08:54:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ghWb42Z1zz3bsK;
	Fri, 19 Jun 2026 18:53:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781859200;
	cv=none; b=lnNB+UOkCrCRabwvoCTUAAAF1jqSNjNTshpgP4Tf6gp0h5wabnN9h5qyMx6YAiicg5Nk4If5k7RAMtdrZ6DBVJLRiVipdtKrZEt82IUwtzUXen0Xbl7Z0+imYj98QDJHCbHs0wMrz8KnCO9sh1Pdzp2OtZFgE5LAOMedgQnt43ilIXYoq3qUpCNpkvdaV766Gt7M0DhaAK5xRbZkdkv0F8oUFj0j+YZAhFFsiYJHsMlP1EV8O/qaVBovExRqtMZIbp3VGrMcJruTaPzkiM49vTndn1zHKCpqgVe71B8t5xWt47Ofj6B3WQ9TwhbPhKEFed0LRXvIxAxcoSMuNNy/Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781859200; c=relaxed/relaxed;
	bh=OD/K6TYwB6VdvSorvIdmiNjHyV31bpjL+a9MaOCS49I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nktDWLdhTACgXpyoQ2IuhV2ptZthWlt6iB3FwhBwv/HDdpAs43UCebyNFiCBkPNo/G34SLrS+ZUDFu4GrovojOjPn5Z4SsDvLJuHIWNgu75ZHAkYqmvFePn7aatzzFgDqiu3tTrjdMvcCRP7A6lSCfni7ZHb0O8KPmjknAIZjW7jM2PQuh1oliQ7nxDfZ26BEAo21pzrQLZJcAz02K3deZ07S1fsB/A+sz4btmTb3pfzCy/QbGipgVEomKJFgXDSvyBjqBfppmSBaTSr79N74qeykA7c3MIbfT1bfsiPFVohTyqzddmBHUZx+tBz8zHbAW6wRFoKMDeIrnZMximOPA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WPnZvpxY; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WPnZvpxY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ghWb366Ltz3bs5
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jun 2026 18:53:19 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C576D4395F;
	Fri, 19 Jun 2026 08:53:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AD481F00A3A;
	Fri, 19 Jun 2026 08:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781859197;
	bh=OD/K6TYwB6VdvSorvIdmiNjHyV31bpjL+a9MaOCS49I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WPnZvpxYsWFr3rnk5L32yO8HYtKAsK9nDXcmtPbu+MdHKCtypFslNgrP4uRW778Y6
	 lCj4T1rGsej83Mvin/yJOkpjbiVh+c8rZ9sZ4Z9+e5rxJwLfh1YGmjUiXW4EkhH3UU
	 JFyD0yN8rsWHl/fvRCaay5HFYo+yil6tW/i3BoSHdp4LmeskaizOl753pBp5wb5Wk0
	 7qt/3uTvUbItEolF4wlZvVcEmKOuVEB425pLJPYh+dRdaH5uxnL+UElvrX1Yz8lMbl
	 +L1vEDQCjNmMYzRrGxd9HGhoxIM2bf79ZICu4ZNbV85IdQV0ZJ9ZnBbyQUUDAtcXJ+
	 GCGmYY+W84Vgg==
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
Subject: [PATCH v8 20/25] alpha/PCI: Compute legacy size in pci_mmap_legacy_page_range()
Date: Fri, 19 Jun 2026 08:51:55 +0000
Message-ID: <20260619085200.3729431-21-kwilczynski@kernel.org>
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
index ae448a2e40c5..74c9145e0253 100644
--- a/arch/alpha/kernel/pci-sysfs.c
+++ b/arch/alpha/kernel/pci-sysfs.c
@@ -173,8 +173,11 @@ int pci_mmap_legacy_page_range(struct pci_bus *bus, struct vm_area_struct *vma,
 	int sparse = has_sparse(hose, mmap_type);
 	unsigned long res_size;
 
-	res_size = (mmap_type == pci_mmap_mem) ? bus->legacy_mem->size :
-						 bus->legacy_io->size;
+	res_size = (mmap_type == pci_mmap_mem) ? PCI_LEGACY_MEM_SIZE :
+						 PCI_LEGACY_IO_SIZE;
+	if (sparse)
+		res_size <<= 5;
+
 	if (!__legacy_mmap_fits(vma, res_size))
 		return -EINVAL;
 
-- 
2.54.0


