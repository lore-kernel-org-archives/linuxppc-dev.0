Return-Path: <linuxppc-dev+bounces-19546-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AD6BE99049
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Apr 2026 07:15:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fsSk96xY2z2yqf;
	Fri, 10 Apr 2026 17:15:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775800297;
	cv=none; b=LeGMoBlcnmy23WvUDWeY8kDuumHMVvsusuynvVQIOdagE06rP/EHcU8GwY29ISFPzjLBws/7fPTGtu631mN+wYANnB2NO1fFZDBqRDtOzLan7C96Vxgc0nhYylUBDoIaf/UUlEP/yQu5kp6pUB0lF3rsrYaX/Zh44/skHMaxrmKhvwrMM8Jpdikh5q9/0l0To7ITahKlr7fhTkF7/B9NCRoBtiGiRwKUu+Po2rf64rkVSu4N4BDh6+eopPDjo0PBj+UL2/Umsma1RDqLRbjN/aj77ofqV1OCSAVQM8W6AaTNBHEN8al8XyPdilcBs9LVMgvgW89UZtbyNumjoxyCwg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775800297; c=relaxed/relaxed;
	bh=liL5JVHil0sc0F1Tvzi0L0nG5olUsDxaE+MFe4jdEy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CWsXJZpuDQhgDEPmxr99/9oARVbxSI3aa7JeQpATDdJe52fjtPMor6CaInEqA6lRN8zqoM7XBzXO4w1pr9Ea7Yj77fEU+RowXYjhWM5mr4yEYU7CAybdv24Lrdm6O1NFieLxBg+wkf30yh70yDfm9u28glepW1HGi88MZ+pNdrgf5beJaBqbJqPcV4MbEFLnQvdWtNcbxwmwyugMvxkDeoh7y9LZ73e1iHDvV9o6NYUsyGbDpivLM2DxdJlRXsP9pMRg/O54lC2Gx7Hfjinh4syNhZzSB9EMuovCoz+i0cZk1JwoFKAipx/gRx10qYqCCjjyc4kW753cHr80FTdNuA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=tBBFlP/A; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=tBBFlP/A;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fsQsj3SYcz2yRl
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2026 15:51:37 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 72EB96014B;
	Fri, 10 Apr 2026 05:51:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDD8FC2BCAF;
	Fri, 10 Apr 2026 05:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775800295;
	bh=M5WivLrx5zMSeSOunSyFVbnHwqD866ZMVHSIPs7ARX4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tBBFlP/AIYXWrEyUV2Ue68uGFxLTG1U/qoHhkhvTFyvBn/16qyVbml2XNylfy6a0y
	 kkalXA5pkYAkCy8zykaSRoDvyPDNoE3+QZtGGLB8GszsES/sf4O+igjAf3a+9l7bgE
	 vivhjk+Dc+YHrsoMTnUfx7m9BzDL/I5St/f5grWP72wm7V98ZYt7b2CX5RxjvJNbvl
	 pE8ZnUm7x+5datNMf+NXQW3DdfC6uXHX1yTi1S5/XijwYakxfrI45HHa89B993dR49
	 aGWzT4JaiWBQzRN1qDva0eC+TITK12ZCX12ivpiS1EEeib4n3YIpQv3ACUDCEgG/qI
	 QyfK8OyXhEtUA==
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
Subject: [PATCH 14/20] alpha/PCI: Add static PCI resource attribute macros
Date: Fri, 10 Apr 2026 05:50:34 +0000
Message-ID: <20260410055040.39233-15-kwilczynski@kernel.org>
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

Add macros for declaring static binary attributes for Alpha's PCI
resource files:

  - pci_dev_resource_attr(),        for dense/BWX systems (mmap dense)
  - pci_dev_resource_sparse_attr(), for sparse systems (mmap sparse)
  - pci_dev_resource_dense_attr(),  for dense companion files (mmap dense)

Each macro creates a const bin_attribute with the BAR index stored in
the .private property and the appropriate .mmap callback.

Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 arch/alpha/kernel/pci-sysfs.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/alpha/kernel/pci-sysfs.c b/arch/alpha/kernel/pci-sysfs.c
index 867199b988de..0e016b597b06 100644
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


