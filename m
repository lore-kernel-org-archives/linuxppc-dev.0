Return-Path: <linuxppc-dev+bounces-19968-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC363FA1FD0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Apr 2026 16:16:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g14800L0zz3btw;
	Thu, 23 Apr 2026 02:15:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776874527;
	cv=none; b=IRqcPZTHbFkMpfAHuRW7j+dNwfhYdVEYghcY9lJRyP2+HcAH2OJlwjAwe7O/Pl946PZ3K5cAAnHxKW9vlpQWN6gV4gCt7hOxmNTnfMSrtFs4DPkHWfxq0hs+vUHnDC4lLRT+EXtleguJB2icHbtbI/IBCQfkIdS1CYgrqX3swwdFjFHHYpwi/ksYRVY7wO4asjMlnoU3ZdQrC1NxoHTfvM3Vo3cQhSiscVCtKihWQ6GCXCR85Xg2lGgISrNs+K5+Dcd16sTSWSl9UfBSCqX+oz/K6wdTGmDL6x2/wF/+kINlIlf5xdJ62OTuMqEHU1w2dgGrHprNeQuxTdrR65KmZg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776874527; c=relaxed/relaxed;
	bh=sDuuaWbfxb9J021lVyDfW4R+DievX36AhDDoHD9cozY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H8qPol4IPuNcEayUV9Au+1glMgUvYOSidOd0RtYQA3k7topn8VkCIvbLrSA38d/6e/EE1foY1wyTXFFzESl6zvuS6gxesd6ZnDzuuVIuUJpbfkv8SGUTkLUYrhzFBA5vX8mohEhgflUUZ6ssS7w3wuv7aieiPxW8uj12OiqiDOJFXPyfoQ6euzyYS9nu0YFVk4hwSZU2Yu2yXK738cERoLIAsG0iBHx/pktyiywFZx4Diqu7Yez2lsBanM+zeEr6XRRrkKDhv+u8lqQo77q1O4CfY69diSegI8ecof6KLf+nY1QlBH7l+cXtzE8K72DCwzbW59FVmWhJoxpkJeYULw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=SraPM0xw; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=SraPM0xw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g147z1fK4z3cF4
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2026 02:15:27 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id AEE3843396;
	Wed, 22 Apr 2026 16:15:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AE82C2BCAF;
	Wed, 22 Apr 2026 16:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776874525;
	bh=0C9Mo7MLnvBV7/GjuyWIR9bof3XRGtipVgY5mTNM/jY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SraPM0xwovu9P2laAsnVMwSdl2M7mnqOygR0AMTjI/QTFgAyNLG7TPzFsPWBRYm6/
	 6oCULG5H0eWKSXT6Zi0Q3e6kW3boT0gwkdClzm9/2XjJYfz4E5LsgBoa2EC5Ejkqt6
	 OmJGZtMcpSoFSRxQLLhZ9ybyBPRduHxjvrs28vu4M8104bOLDxkfqJseLP8qicfZsX
	 NNUsVcVVZFBlB/0Fdt4qQq491/Mq5szasP+rObzSd1n5w450A///X0Ar5GUqxm24me
	 z7BX+NqaO8LQuZqtA7NQQe9cWDuYRA6Hl4epxJOKHDMUVub4y/ZUySabQ7R5xLI6Vp
	 cEeuWECdtXeOg==
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
Subject: [PATCH v6 21/24] PCI/sysfs: Add __weak pci_legacy_has_sparse() helper
Date: Wed, 22 Apr 2026 16:14:04 +0000
Message-ID: <20260422161407.118748-22-kwilczynski@kernel.org>
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

Currently, Alpha's sparse/dense legacy attribute handling is done via
pci_adjust_legacy_attr(), which updates dynamically allocated attributes
at runtime.  The upcoming conversion to static attributes needs a way
to determine sparse support at visibility check time.

Add a __weak pci_legacy_has_sparse() that returns false by default.
Alpha overrides it to check has_sparse() on the bus host controller.

Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 arch/alpha/include/asm/pci.h  | 2 ++
 arch/alpha/kernel/pci-sysfs.c | 7 +++++++
 drivers/pci/pci-sysfs.c       | 6 ++++++
 drivers/pci/pci.h             | 4 ++++
 4 files changed, 19 insertions(+)

diff --git a/arch/alpha/include/asm/pci.h b/arch/alpha/include/asm/pci.h
index ef19295f2e33..95de7ffd59e8 100644
--- a/arch/alpha/include/asm/pci.h
+++ b/arch/alpha/include/asm/pci.h
@@ -86,6 +86,8 @@ extern int pci_mmap_legacy_page_range(struct pci_bus *bus,
 				      enum pci_mmap_state mmap_state);
 extern void pci_adjust_legacy_attr(struct pci_bus *bus,
 				   enum pci_mmap_state mmap_type);
+extern bool pci_legacy_has_sparse(struct pci_bus *bus,
+				  enum pci_mmap_state type);
 #define HAVE_PCI_LEGACY	1
 
 extern const struct attribute_group pci_dev_resource_attr_group;
diff --git a/arch/alpha/kernel/pci-sysfs.c b/arch/alpha/kernel/pci-sysfs.c
index b986ff1e7a82..98f81bc73660 100644
--- a/arch/alpha/kernel/pci-sysfs.c
+++ b/arch/alpha/kernel/pci-sysfs.c
@@ -191,6 +191,13 @@ int pci_mmap_legacy_page_range(struct pci_bus *bus, struct vm_area_struct *vma,
 	return hose_mmap_page_range(hose, vma, mmap_type, sparse);
 }
 
+bool pci_legacy_has_sparse(struct pci_bus *bus, enum pci_mmap_state type)
+{
+	struct pci_controller *hose = bus->sysdata;
+
+	return has_sparse(hose, type);
+}
+
 /**
  * pci_adjust_legacy_attr - adjustment of legacy file attributes
  * @bus: bus to create files under
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index ad8ee192c94b..8d4ec862c326 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1019,6 +1019,12 @@ static int pci_mmap_legacy_io(struct file *filp, struct kobject *kobj,
 	return pci_mmap_legacy_page_range(bus, vma, pci_mmap_io);
 }
 
+bool __weak pci_legacy_has_sparse(struct pci_bus *bus,
+				  enum pci_mmap_state type)
+{
+	return false;
+}
+
 /**
  * pci_adjust_legacy_attr - adjustment of legacy file attributes
  * @b: bus to create files under
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 1bf165595583..f52caf7e4d13 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -390,6 +390,10 @@ static inline int pci_no_d1d2(struct pci_dev *dev)
 
 }
 
+#ifdef HAVE_PCI_LEGACY
+bool pci_legacy_has_sparse(struct pci_bus *bus, enum pci_mmap_state type);
+#endif
+
 #ifdef CONFIG_SYSFS
 extern const struct attribute_group *pci_dev_groups[];
 extern const struct attribute_group *pci_dev_attr_groups[];
-- 
2.54.0


