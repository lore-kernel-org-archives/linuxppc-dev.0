Return-Path: <linuxppc-dev+bounces-22806-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80828CD98F8
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Jun 2026 08:53:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ghWZp1qmnz3brm;
	Fri, 19 Jun 2026 18:53:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781859186;
	cv=none; b=Am8tGCMLQJsjKcgdtlZEyXfkWI7uFELu9JUAVHR/0Ed5m20VQBTUhYJZgJHBdojIQ50cTfTYsFLo0EbFvUi6TmnqX5fYoyekYlCINHf2HyQocHZEt7J3jT15Vr+wiGBLMFspu4kQUJsyeGYOEFoCTIYMY1t86XgDyQCu/BZct2FJcI7pPuTf/VebTwfZ1q2k8ITuwGhCbOvB+ip52G9TfzpEiCWfKg1BV8aMRf1oh8f9udCFrXU5amY7HPCubQJTX0DXzMglIEX0qAT4CecsSNlbUryybmtLYVAFf3qvSTvPkrzg1HMCT9BWQpQ21U08Uf7hlbGyUoS+JepEGr/6kA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781859186; c=relaxed/relaxed;
	bh=9sgcf1DSRPQqZX1hJyBxVhrzLb4eks7N1xlH6ALCiqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b9jR9tl8XYVo9R5ZMDYg5tEZ0vELa6eqIXx/O1N50UvKP3xYrhTC3dqE7JaUaSTY6X9F+c8hSojNdUr8NVU8WSaYGHEJUFahL42gf707oz/uq8Dp5mxeXtnt86IWPZD+MgzyVBUjA8OKaXCE41Shbk8aPa2r5xeCgaGwd+Q5h7IkAIl7DqmZXNGK2rt/BXNFbYKp9dmG4Wd3TJXEAAoQAbRe7L6JYULUi6XlShMe/FwY+vGk3ENUGE6ptIECscKA8L5NwPc0HXRLOa3mPFaYVdaVzTPDNasLOR6s7KzvABU+JOKFkijWJXA7ofqBXPWQNig7Sg1iUJlhoIZs9ENlXA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gSfPZIj7; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gSfPZIj7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ghWZn2z0Kz2xF8
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jun 2026 18:53:05 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 88068601E3;
	Fri, 19 Jun 2026 08:53:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C731F1F000E9;
	Fri, 19 Jun 2026 08:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781859183;
	bh=9sgcf1DSRPQqZX1hJyBxVhrzLb4eks7N1xlH6ALCiqw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gSfPZIj7jLxCLOm6qmN+B3DzLNs1aQeeAUxwAshyVyw4JkscaNuppoIh6fuEs7Vqs
	 twLQ2K0LbwAxWKlJ+/5sdqWG8pwNJoFoaYK1vg380rpGd9brVvxhZUlQenvKltAfGE
	 m/9T9EAklWwXztieI1OACTAQl3b68Ah+Y/m5o2O7bZD72Ygap6yts1R/Ar2qDnA3qO
	 j8KORpRFLa6Y8o9CdzOTbD9cdqClcTo9ICbWjIn9lsIcn9kayEm3NLY2a+9fC8kjhT
	 RPO/eadnwgqPp3L3umeqxQ9+1A0Zb/UzjUefbcAOUG625WQXOJZLcqwuX+4DT44JFz
	 Ew2NsVCJu1I5g==
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
Subject: [PATCH v8 16/25] alpha/PCI: Add static PCI resource attribute macros
Date: Fri, 19 Jun 2026 08:51:51 +0000
Message-ID: <20260619085200.3729431-17-kwilczynski@kernel.org>
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

Add macros for declaring static binary attributes for Alpha's PCI
resource files:

  - pci_dev_resource_attr(),        for dense/BWX systems (mmap dense)
  - pci_dev_resource_sparse_attr(), for sparse systems (mmap sparse)
  - pci_dev_resource_dense_attr(),  for dense companion files (mmap dense)

Each macro creates a const bin_attribute with the BAR index stored in
the .private property and the appropriate .mmap callback.

Tested-by: Magnus Lindholm <linmag7@gmail.com>
Tested-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Acked-by: Magnus Lindholm <linmag7@gmail.com>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 arch/alpha/kernel/pci-sysfs.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/alpha/kernel/pci-sysfs.c b/arch/alpha/kernel/pci-sysfs.c
index 6cf688621ea9..650f7795cc40 100644
--- a/arch/alpha/kernel/pci-sysfs.c
+++ b/arch/alpha/kernel/pci-sysfs.c
@@ -104,6 +104,26 @@ static int pci_mmap_resource_dense(struct file *filp, struct kobject *kobj,
 	return pci_mmap_resource(kobj, attr, vma, 0);
 }
 
+#define __pci_dev_resource_attr(_suffix, _bar, _name, _mmap)	\
+static const struct bin_attribute				\
+pci_dev_resource##_bar##_suffix##_attr = {			\
+	.attr = { .name = __stringify(_name), .mode = 0600 },	\
+	.private = (void *)(unsigned long)(_bar),		\
+	.mmap = (_mmap),					\
+}
+
+#define pci_dev_resource_attr(_bar)			\
+	__pci_dev_resource_attr(, _bar, resource##_bar,	\
+				pci_mmap_resource_dense)
+
+#define pci_dev_resource_sparse_attr(_bar)				\
+	__pci_dev_resource_attr(_sparse, _bar, resource##_bar##_sparse,	\
+				pci_mmap_resource_sparse)
+
+#define pci_dev_resource_dense_attr(_bar)				\
+	__pci_dev_resource_attr(_dense, _bar, resource##_bar##_dense,	\
+				pci_mmap_resource_dense)
+
 /**
  * pci_remove_resource_files - cleanup resource files
  * @pdev: pci_dev to cleanup
-- 
2.54.0


