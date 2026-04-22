Return-Path: <linuxppc-dev+bounces-19964-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47F24FA1FC7
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Apr 2026 16:16:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g147k5pWZz3bmL;
	Thu, 23 Apr 2026 02:15:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776874514;
	cv=none; b=HtQf+n+dI6KRqBHrGAZK8bgYPN5Ml6p5zxxurdfi1VWiqE9mn0QReSSa+cPJXlTWi3kq+abtUax7BbpDOZz4o3kquY5WDgmgDhUAq5qJuwXdNO49EjJYMwOJ03T2f1RkyqZI0vvjid/9REjZgMpTMBogs+2dtD7DciWwGmbXD2Egf4rPnyDDEwswfbe3fHadSx3XJiE54jA+ktWxN/2TspyE7TFeuC8jowAMrWqoW5RCH/W/A7XGM810UyNa8Fh6H+hEqhbRP95Yc4AkwtL65D2aJXVChxV8JORnPHsmOV0mYEomaTFeLZJws0cjnobGGT7OHLzy6IklBR3GqEC/Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776874514; c=relaxed/relaxed;
	bh=Bx1XhO+COa5mNyw51/s0HmUsd2owom68DbBIeGbCImo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iks647TWPlkVKmU2fpH7iE543Y7BT/WjDAkrBqgxY1Bcs5gV7TABocjr3aMByTKeNb5OTPxMtwEdGqEcOxdjyi9FMRCia1MZ+Ql7TjtHghDZUNJkf3w2qtvOisFeslPEKjj3/BBUAgKrPQBs271gwNrAYosfvGVAJ3FGoVUYshSvdQ4fkp2Gr86b4MiQgfF2rLs4JfIycyHsuYlC0zjXBioFpQixZ3Hix+Z0sLuHircXEUr710BVaNlCcGPXXH0ekeIHkqL6zH396RbzcrY6ewf0SRxYTo6/zaCirrwLbdKtbsGYJ6hS4hUxlQakF85sgrwtpts6VeplphzZWMmCeQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=MxXjwQ1a; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=MxXjwQ1a;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g147d3HX5z2ysZ
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2026 02:15:09 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id B5A1142E3A;
	Wed, 22 Apr 2026 16:15:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74C5DC2BCAF;
	Wed, 22 Apr 2026 16:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776874507;
	bh=6opnfEAHa7djrPNhG4kBV3H+XRWoxL2r3NmQ1bYH8qU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MxXjwQ1a94c3tddnlqwNuim6d4zm7AStOYz7TQU2ZXM7O57yGSCTtIUgI5HezwJNB
	 uYS5z/o5POmmhfD8izHw+2ACWOHqu/DAkCkbODHoWVibnLYQ4EtKrSyISTaUzD0LRG
	 TfsjQ0ou7xx+E21brRquQJ2BgtN5KrgZQ9asf6Ta/mk3fqsknHfmUKaTsVif52AOI8
	 1sU5O1fJ473/Ob6vVMo0GeSH3lW+yGXSVR2vEO8R1zpopdPVRqDa0VYyn2+HSOVSCl
	 ZKtE/Bv7AshoI/ET6ZaZfR8C0v/o1SigO6fHtxbFCKNKzK529JNs5+HOoZCrxTvH6V
	 04M6gzcPi1haA==
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
Subject: [PATCH v6 16/24] alpha/PCI: Add static PCI resource attribute macros
Date: Wed, 22 Apr 2026 16:13:59 +0000
Message-ID: <20260422161407.118748-17-kwilczynski@kernel.org>
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
2.54.0


