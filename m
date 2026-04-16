Return-Path: <linuxppc-dev+bounces-19807-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2084BF8D763
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Apr 2026 18:03:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fxQnv63tCz3bjG;
	Fri, 17 Apr 2026 04:02:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776362531;
	cv=none; b=kvqeSpl5NHeRJE9M2xVPtieHSL6R8JWOSq6lYY+KmUEtyWgx6RjmgdP/aFBL+y3hj/WnRe+jZFsZLCawyg4+sGjm8U3J7HRZFKcTN2UYx/lxkvCPdn2g3zPIpv6VcRn5Trw9NXCTB35SqKKa2AV49fo8KWqRLD7641nb1XCVgYdkRE7/UCRrMPsprmCWSte4eInZmuxZPRYlvWJFT+aTxyLSTGQUDnj2bX0OW/xfkmA6j2Zei6MIqA2fn3jmuUoRECIs/kamWjuwY5XgkJiG+wVsNM3OHd8tnNEoNzF2sTAW+0mrMZWX9ffUDJST3CTjFGqBAfidCrji3yTHyWFl1A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776362531; c=relaxed/relaxed;
	bh=msaN5W3C0+r76bz0n+r/6xIc2aDB10OrrUVJCgNu9Ug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vka3vMbiLL99JtQEsPREFw9HaFzzYAJdmvu97xmONY7YRGkCBvkOzaKEksPDlTKEjfj+FKQKSPJRdXWJDtLq+XzCmDwLuKXe5MkNXiN0VkdrpxMiBjedUtYFEw47+u6tfxvnEMeOTodYZkhP+GUeHDIJW1HQdjGjk+Z5r0LUehskpP3yaOqw/w1sKweKUzZ906SlHoRsnu7IuGXnukOrsMp6kRjjuKUAGD5wUK2jsHjaJu8sZC8m4jKq+EUmZfZ5WVF9JPKmj9PNlSFGMz/ruUHb+oidMj6e8tmPqlh1wjtUgVjvFkxf8rCIoWfhWodlFCmSg8ryWq5+IbMZtAXvOw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=dId8wEsY; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=dId8wEsY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fxQnt6sdCz2yYK
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Apr 2026 04:02:10 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id D6BF360127;
	Thu, 16 Apr 2026 18:02:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36BFFC2BCAF;
	Thu, 16 Apr 2026 18:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776362528;
	bh=C7GpgMoA+xWLQy3B4vgURd+aoELSeRsRY0lcMXhxgq8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dId8wEsYVSAfsFXbBlILYLGLa/L23gQCykY253jrHMtJ8gEavj86sOuE4SDtQw8dN
	 u2981zNy4Q6K069PzR/9Zm8Xpylm59aDdZL8IVu6Vp4lNxzLLfkAZeiDF5VSHUooiQ
	 N2woqRDQL4DhW3wdRIcFshDhl0OALsKFt3jHEGkVfPTUc7IzDddriGT2KusD9NugqW
	 DSj4fDsCstcdrf+Mj3aXMJ5i4cXyBgT9fwMkkkC6GFOWUoVeqjWSngmHvkror09Z43
	 rNV3QJjtJhIqEDC+B5ZqR23iCBvpQD+Zguk5FZaiviwq7H04dYsgKeDGO/n3B5I6+Z
	 yARjOO7sdKqtw==
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
Subject: [PATCH v5 16/23] alpha/PCI: Add static PCI resource attribute macros
Date: Thu, 16 Apr 2026 18:01:00 +0000
Message-ID: <20260416180107.777065-17-kwilczynski@kernel.org>
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

Add macros for declaring static binary attributes for Alpha's PCI
resource files:

  - pci_dev_resource_attr(),        for dense/BWX systems (mmap dense)
  - pci_dev_resource_sparse_attr(), for sparse systems (mmap sparse)
  - pci_dev_resource_dense_attr(),  for dense companion files (mmap dense)

Each macro creates a const bin_attribute with the BAR index stored in
the .private property and the appropriate .mmap callback.

Tested-by: Magnus Lindholm <linmag7@gmail.com>
Acked-by: Magnus Lindholm <linmag7@gmail.com>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 arch/alpha/kernel/pci-sysfs.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/alpha/kernel/pci-sysfs.c b/arch/alpha/kernel/pci-sysfs.c
index f2ee737c588c..3108c165b3d8 100644
--- a/arch/alpha/kernel/pci-sysfs.c
+++ b/arch/alpha/kernel/pci-sysfs.c
@@ -104,6 +104,26 @@ static int pci_mmap_resource_dense(struct file *filp, struct kobject *kobj,
 	return pci_mmap_resource(kobj, attr, vma, 0);
 }
 
+#define __pci_dev_resource_attr(_bar, _name, _suffix, _mmap)		\
+static const struct bin_attribute					\
+pci_dev_resource##_bar##_suffix##_attr = {				\
+	.attr = { .name = __stringify(_name), .mode = 0600 },		\
+	.private = (void *)(unsigned long)(_bar),			\
+	.mmap = (_mmap),						\
+}
+
+#define pci_dev_resource_attr(_bar)					\
+	__pci_dev_resource_attr(_bar, resource##_bar,,			\
+			    pci_mmap_resource_dense)
+
+#define pci_dev_resource_sparse_attr(_bar)				\
+	__pci_dev_resource_attr(_bar, resource##_bar##_sparse, _sparse,	\
+			    pci_mmap_resource_sparse)
+
+#define pci_dev_resource_dense_attr(_bar)				\
+	__pci_dev_resource_attr(_bar, resource##_bar##_dense, _dense,	\
+			    pci_mmap_resource_dense)
+
 /**
  * pci_remove_resource_files - cleanup resource files
  * @pdev: pci_dev to cleanup
-- 
2.53.0


