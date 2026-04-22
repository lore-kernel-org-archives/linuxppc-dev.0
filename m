Return-Path: <linuxppc-dev+bounces-19958-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83164FA1FD0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Apr 2026 16:15:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g147K4qLRz2yrT;
	Thu, 23 Apr 2026 02:14:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776874493;
	cv=none; b=m0wzKcM3arO3soJQdQy9N8efSxMtqYPocI5SVkqTSC3tRfr4JXQ4hsCf6bQYMPS+OIjDveksvcnwcFEyhzdoCBM17uE4hPaWf6msrsp0qmoA/FqTjUJ2BZ13aiPSaJxsU3FyHT8tDM5L0eV45h4y0Ce+s0KMd2rcJsKQTDWWY7yvnIZytG54+mgd8qn3qJqF4ljlAo5JQmmeu8YX/gnFTaqNJm2ooh34vZErh+KgYkvZWisMg/qzg6Y7oDDA51HU9RDXMdr/vNVjK1qKxSYYcbvsBPHb53N9BhnMa5t1L4mwteFB3gN2MEBLLFtXlbVZLqgGg5QWBv11vvSpK2SA3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776874493; c=relaxed/relaxed;
	bh=klSXPMn+7N0vFmOZssBl1venf0RkNLLcp8+Rrj4dNZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fiAQr1A73Dog/a+FFArVZneGM0m2g6k6tWNCqaRuF0fLJGoUxnHu5lKEnrk0G/9pS9z9P30XyBHRLyjVgwqqB47h12gqIKXLFwfH5K4IqMyiojG48/oPaeOu5zZN8dBMxzuQn/tadwoNA8qc0D6GCoPUfXuG52gc8dEw/LKGzsbl6YodDaetwO0ZKYMbruIxTq6h9qka8gZVj7zHm2NBiThuiuj/MIWlxYinejJ+/JEHUOXu0Pgbd5aDB9ZE18Akbn6VPlwzS2+5hePO4zxdAlyO1h3CTJVDEJndt6uWkjLs4KRCrYHW+eCQkpFuzqwqiptoiRsRtguk7h2PsMjOBA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=j94rSVTh; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=j94rSVTh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g147D2btTz30hC
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2026 02:14:48 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id CFFF6403CA;
	Wed, 22 Apr 2026 16:14:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE33FC19425;
	Wed, 22 Apr 2026 16:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776874486;
	bh=dlbGO9fbGQS1YQSRBPJiq4zvxG0cWPtDw+JWina0FxQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j94rSVTh+5UeOUKQaoN1gfEsKWQkRUzjg3zaC0NSfkkCC9+Ck5gfIdV625AgTuZ+i
	 aRRFtO5I6QN5CBdo4J0VNrNQ6i95dC6HCVTbUubsquI93Dom/qFscn82ZHsOD/DRLm
	 7u0O8rv88/vo9vFlHQ8ISz+pUaX0SI29AlZzV9531SDVeZfu4xvIVEgDvJqXjK8mz1
	 HYlHmUF7qcKDXJGcDh6IKvw2/RgiG+ZODTtl/rbYtf2ViKYVXZMQPPIuIXhPR2hY7I
	 ip8GsC+0qyQhyA4I5TotJZSEZuvlagXZt1eqvaOnyanFFbDnV4mhdcdS7aEJGPk7Yb
	 ifKC2Yvtm5L7A==
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
Subject: [PATCH v6 10/24] PCI/sysfs: Limit pci_sysfs_init() late_initcall compile scope
Date: Wed, 22 Apr 2026 16:13:53 +0000
Message-ID: <20260422161407.118748-11-kwilczynski@kernel.org>
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

Currently, pci_sysfs_init() and sysfs_initialized compile
unconditionally, even on platforms where static attribute
groups handle all resource file creation.

Thus, place them behind a new HAVE_PCI_SYSFS_INIT macro,
especially as the late_initcall is only needed when:

  - HAVE_PCI_LEGACY is set, to iterate buses and create legacy
    I/O and memory files.

  - Neither HAVE_PCI_MMAP nor ARCH_GENERIC_PCI_MMAP_RESOURCE is
    set, to iterate devices and create resource files via the
    __weak pci_create_resource_files() stub override (this is
    how the Alpha architecture handles this currently).

On most systems both conditions are false and the entire
late_initcall compiles away.

Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 drivers/pci/pci-sysfs.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 517efb6d71cc..d22bc5c48bc0 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -37,7 +37,14 @@
 #define ARCH_PCI_DEV_GROUPS
 #endif
 
+#if defined(HAVE_PCI_LEGACY) || \
+	!defined(HAVE_PCI_MMAP) && !defined(ARCH_GENERIC_PCI_MMAP_RESOURCE)
+#define HAVE_PCI_SYSFS_INIT
+#endif
+
+#ifdef HAVE_PCI_SYSFS_INIT
 static int sysfs_initialized;	/* = 0 */
+#endif
 
 /* show configuration fields */
 #define pci_config_attr(field, format_string)				\
@@ -1792,6 +1799,7 @@ void pci_remove_sysfs_dev_files(struct pci_dev *pdev)
 }
 #endif
 
+#ifdef HAVE_PCI_SYSFS_INIT
 static int __init pci_sysfs_init(void)
 {
 #if defined(HAVE_PCI_MMAP) || defined(ARCH_GENERIC_PCI_MMAP_RESOURCE)
@@ -1818,6 +1826,7 @@ static int __init pci_sysfs_init(void)
 	return 0;
 }
 late_initcall(pci_sysfs_init);
+#endif
 
 static struct attribute *pci_dev_dev_attrs[] = {
 	&dev_attr_boot_vga.attr,
-- 
2.54.0


