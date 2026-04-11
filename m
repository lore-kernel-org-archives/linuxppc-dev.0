Return-Path: <linuxppc-dev+bounces-19626-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75A5AF36BA5
	for <linuxppc-dev@archiver.kernel.org>; Sat, 11 Apr 2026 08:02:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ft5k10xwpz2yxN;
	Sat, 11 Apr 2026 18:02:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775894537;
	cv=none; b=KsKRnkwcItI9eXrN8oFckq8vUYJ4BdtuLlwkBJMfKkrk9VKtWPESvnbnh0bc1fP/rVPvBujgieYMN1o9rtKqP9F5t8/7ZsaMpaj7wGtgXLqGdtVymN0O1NXjMbq9u0fNLg7X0Bbq/XJSJX2zR5Ohdgv+IF75QFrlArKgFMnAoC06Ug/iNgpBa0GuMeKDkRF2JPhadFslhpwB5Wz8BiGDP9YFBxeN4p0NAHw29Jd01tEOoARgZMrezRZRFTpU5W5G7pPCvt5cJDv9wPKvb0KFLDwHegs806UdcNlotznhImL7sq3uVKiNKi/ZYWc3qlOKxgxYylTuWOlcTtcwplTGQg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775894537; c=relaxed/relaxed;
	bh=LW4CUtNV7o1IaBKjci2eTJi+FEyqTLWZuxdhVMSrGHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FBrrqGfWeYjLXRNF8biCt0d9DO9/DombeWtQgXC5UpzfmQ3y9e4OyLupkvwn1Y8WWGrvh9X+w84bosgPg2U2vw0+zeiqyjeD0EIK4+1RzBVq4ky3ODvbaV0h6U3oy2nx4Gt86p59POcH9vGU9F8jFeNT3NmNCdWYfMGD/w7H78X6aZxJ0JdJ7oVvj6rFqF+i1g+9LOM/9Eqjwtn46TvnbbFfdJODFLvxI9SojtBsMcH4zqZlp8pKwGnER98e5m1rrR4i6fUrK8BHnfzrUfpGsqkSH0Tf7zdoGl8NmknNzMtgGFaqOXx94zfazAP+AGZJyRdsvWEICZXAND63TDEyYQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=S2e1GHoc; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=S2e1GHoc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ft5k02QDnz2ymg
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Apr 2026 18:02:16 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id BABA340C24;
	Sat, 11 Apr 2026 08:02:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72D09C2BC9E;
	Sat, 11 Apr 2026 08:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775894534;
	bh=SF6NaKKGKml3gXGCmX67t4OHxTO6Wu63qGLXCgaq56I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S2e1GHocFVBu82bQmSDTnd9TJkJZZw86sPm71UzBO41ZJ3MIg25sYmK5shvNcmGDE
	 VM8vw8ubGLCURt3ntRM7Iw3nWG96efYVMgrJzcGj/tqSjrij0ZoVq1Dx0yViJPvQ7v
	 MALWft17Kxw01mYkYQuqAE23FDT61+EEb7105Bgem8xad6aUNurkcafXqIZvmo2zz1
	 KQOOLd13BO6BdZfn9/pJ1YNOlyO1M3ntW7HH53qNp9oa0SJHGMtexWekyA1cqpxeZ2
	 qAmzF6cBAyd3gPUumHr/eLnz7ZQ42ZW/0HiLr3GFKfmNoE7+ROD5vJ4e8BhLkchjXX
	 OGYwFmoYfLbpA==
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
Subject: [PATCH v4 06/24] PCI/sysfs: Add static PCI resource attribute macros
Date: Sat, 11 Apr 2026 08:01:30 +0000
Message-ID: <20260411080148.471335-7-kwilczynski@kernel.org>
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

Add three macros for declaring static binary attributes for PCI
resource files:

  - pci_dev_resource_io_attr(), for I/O BAR resources (read/write)
  - pci_dev_resource_uc_attr(), for memory BAR resources (mmap uncached)
  - pci_dev_resource_wc_attr(), for write-combine resources (mmap WC)

Each macro only sets the callbacks its resource type needs.  The I/O
macro conditionally includes mmap support via __PCI_RESOURCE_IO_MMAP_ATTRS
on architectures where arch_can_pci_mmap_io() is true at compile time
(such as PowerPC, SPARC, and Xtensa).

Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 drivers/pci/pci-sysfs.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 4f95b336cc34..ca0074674acc 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1220,6 +1220,47 @@ static ssize_t pci_write_resource_io(struct file *filp, struct kobject *kobj,
 	return pci_resource_io(filp, kobj, attr, buf, off, count, true);
 }
 
+/*
+ * generic_file_llseek() consults f_mapping->host to determine
+ * the file size. As iomem_inode knows nothing about the
+ * attribute, it's not going to work, so override it as well.
+ */
+#if arch_can_pci_mmap_io()
+# define __PCI_RESOURCE_IO_MMAP_ATTRS		\
+	.f_mapping = iomem_get_mapping,		\
+	.llseek = pci_llseek_resource,		\
+	.mmap = pci_mmap_resource_uc,
+#else
+# define __PCI_RESOURCE_IO_MMAP_ATTRS
+#endif
+
+#define pci_dev_resource_io_attr(_bar)					\
+static const struct bin_attribute dev_resource##_bar##_io_attr = {	\
+	.attr = { .name = "resource" __stringify(_bar), .mode = 0600 },	\
+	.private = (void *)(unsigned long)(_bar),			\
+	.read = pci_read_resource,					\
+	.write = pci_write_resource,					\
+	__PCI_RESOURCE_IO_MMAP_ATTRS					\
+}
+
+#define pci_dev_resource_uc_attr(_bar)					\
+static const struct bin_attribute dev_resource##_bar##_uc_attr = {	\
+	.attr = { .name = "resource" __stringify(_bar), .mode = 0600 },	\
+	.private = (void *)(unsigned long)(_bar),			\
+	.f_mapping = iomem_get_mapping,					\
+	.llseek = pci_llseek_resource,					\
+	.mmap = pci_mmap_resource_uc,					\
+}
+
+#define pci_dev_resource_wc_attr(_bar)						\
+static const struct bin_attribute dev_resource##_bar##_wc_attr = {		\
+	.attr = { .name = "resource" __stringify(_bar) "_wc", .mode = 0600 },	\
+	.private = (void *)(unsigned long)(_bar),				\
+	.f_mapping = iomem_get_mapping,						\
+	.llseek = pci_llseek_resource,						\
+	.mmap = pci_mmap_resource_wc,						\
+}
+
 /**
  * pci_remove_resource_files - cleanup resource files
  * @pdev: dev to cleanup
-- 
2.53.0


