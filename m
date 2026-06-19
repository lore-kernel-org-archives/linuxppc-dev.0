Return-Path: <linuxppc-dev+bounces-22812-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8470ECD98F8
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Jun 2026 08:54:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ghWbC0g76z3bsQ;
	Fri, 19 Jun 2026 18:53:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781859207;
	cv=none; b=RxOXAQ4uhwd0FYFFPtTQHcF1zB8z3RPxjJmUxclUEXbi3yhZmrc6uW7TTgK0n9E3iHHcEIiWemNRzLpKzK7Z5MSMtFKzj+8KI1FCmzS/txGuRZfzT4y6WeFBllbM+Oe83OqmnCGjWUYiU7NhmNAzViUB05v2Zf20yxoCd3QOZDL7jQ67kB6lvpuQYWStCkqVHCxHt3fAYdCzGV6ZVeGIv6XPSuuYPTcmJr+OHKmGAsVLoYqDt1LYFLcAy+Gf28ga3VAcp8HpZYu7vH9rYKcKWy+reOLL4TO0VAWn3vfiCQXXyyIleI+aB9a/ubg+1vKdg1CeE3sUEYkfJMBbvQOLLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781859207; c=relaxed/relaxed;
	bh=dbM84zULMT6V9HfsvwMXiKi7ogKVG6V+A2YJ5SSZgLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EkqEKmcJnbN+Kdkf3ULDvI4Gm+HXIivMr4nAnXPm3hFDYXfLOYZhQJueuATPwm96kArZITbbYB1mXs7DJl8+V8NPmN3JcGowGkkihqzbjp5+s0njV1f6wru7J2S8FZPWKKjorI0RG92xYthjpGO1ac42JHu0MEvDKnit/YxfAqrvgxfP3QlA1e6ruLTLd95QNvsrZ6M7DPCaYSpTqmMpzaklzi8dfWmw3VVTFWUXEwOuQymbi5mMWjrav3BtCC8LOLHB+vwbmreN3BtQFMi9LPSm3XaumFubs9R4hyq21dFQbYgWMvr9EX4lBN59gYmzdDlm/HXq3OX4bhNyw/RYOQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VeVHvZif; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VeVHvZif;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ghWbB3k5Pz3bs5
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jun 2026 18:53:26 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 07A514053D;
	Fri, 19 Jun 2026 08:53:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A05721F000E9;
	Fri, 19 Jun 2026 08:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781859204;
	bh=dbM84zULMT6V9HfsvwMXiKi7ogKVG6V+A2YJ5SSZgLk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VeVHvZifatbxVAiajK5ST7eBAaWpvKEy7RWco2qiJbcDFt7S4CdaDZqqMw10hac9I
	 n93h/Uhy81DArat2rMqwHo0hdeZPYgIKY+APBExhNsV8OprLTHMVcmg/AB4lbsDwhO
	 Ii7dAxIt9z4nFsSHm4ayVcP9iIW6EUO/c0HcaF0cdGUuKGe5SDF20gj2L+5Jfxy88I
	 luFSogWk8tOU+WqHjEawg52OKZsMBsAnxvRyawcNx3eFdxicOsHkYXBht5URd8LihD
	 0gjRzNGXrDN174IZm60B91dJQDctAt4aHYqX3cN5TcmRPgc7o0F7m3fLxAsdW6v6Nm
	 sx+g+h4DZbZcg==
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
Subject: [PATCH v8 22/25] PCI/sysfs: Add legacy I/O and memory attribute macros
Date: Fri, 19 Jun 2026 08:51:57 +0000
Message-ID: <20260619085200.3729431-23-kwilczynski@kernel.org>
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

Add two macros for declaring static binary attributes for PCI legacy
I/O port and ISA memory space files:

  - pci_legacy_resource_io_attr(), for legacy I/O port space (read/write)
  - pci_legacy_resource_mem_attr(), for legacy memory space (mmap)

Each macro sets the fixed attribute size.

Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 drivers/pci/pci-sysfs.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index a861484ac0c0..7f1d8e07924f 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -893,6 +893,27 @@ pci_llseek_resource_legacy(struct file *filep,
 }
 
 #ifdef HAVE_PCI_LEGACY
+
+#define pci_legacy_resource_io_attr(_suffix, _size)				\
+static const struct bin_attribute pci_legacy_io##_suffix##_attr = {		\
+	.attr = { .name = "legacy_io" __stringify(_suffix), .mode = 0600 },	\
+	.size = (_size),							\
+	.read = pci_read_legacy_io,						\
+	.write = pci_write_legacy_io,						\
+	.f_mapping = iomem_get_mapping,						\
+	.llseek = pci_llseek_resource_legacy,					\
+	.mmap = pci_mmap_legacy_io,						\
+}
+
+#define pci_legacy_resource_mem_attr(_suffix, _size)				\
+static const struct bin_attribute pci_legacy_mem##_suffix##_attr = {		\
+	.attr = { .name = "legacy_mem" __stringify(_suffix), .mode = 0600 },	\
+	.size = (_size),							\
+	.f_mapping = iomem_get_mapping,						\
+	.llseek = pci_llseek_resource_legacy,					\
+	.mmap = pci_mmap_legacy_mem,						\
+}
+
 /**
  * pci_read_legacy_io - read byte(s) from legacy I/O port space
  * @filp: open sysfs file
-- 
2.54.0


