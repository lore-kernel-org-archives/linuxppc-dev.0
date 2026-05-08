Return-Path: <linuxppc-dev+bounces-20586-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02872CD3436
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 May 2026 04:36:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gBbsW1nbLz2xdb;
	Fri, 08 May 2026 14:35:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778214959;
	cv=none; b=Afn1MZ4tw59srSNSzEgfD7aqqNgUC7JBxyAeSWAwbalWffydAH+TRNK7GWNoKlmcAT4cHN8oZX/Og7RVU8VeEvY1zG8l58Mdvq0NLlhIbsaxLdGWi+RJpel+HB1r30IicpVO+dzr3hABwTplV3xTcCkzxabAtPvWX+2iNnCez3MqaYs/cJfCaUSV0ps5/AOVwum7TUkefijiHSOIft2hje1IUku3tb9d+HLQrbuONhTlWIXHCzJwrDkZyoLfgXy1EOH7VE5CHfMvLwZGjDqsNUNkMQrQzYAsdijzcS4f3PmflK9TJpNC2qFcc9YYDrMcT0OV3yGDKG6ghcL70vaiAg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778214959; c=relaxed/relaxed;
	bh=J0zsLA5ryToNAxAxjQD54oSfvFP26rqE2yjtK6eduNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mgqH6MwPB2NLuLCcsy9kZzXREuRE8W0v4i1FJLCW/BRgJEnDYjhEgwSjEDQhmQGk+b8FgwpJOYWS41rn7L8ymMfE5Ahuae7vkDG8OzSwyoVYWdlfACvfnpOKVho+VuJZQg0amilwjf5nHB+JFMnWNJjSL042Tw1NrNheRqKQLjSaQWJVx0lRGxPJs6zkKUPmUxtixRywvJEnRlIIUjIxLZg7KtxpjVPH6vxKRSZ2cupknPWUQI0v4kJZuk/Y3goS2EqE0/NC78CxV/jLne8K4lHJfqhesHW1fT2vhdqq2TfH9u4dGpS+zwXDFZtfcBUhtiqU+R+UsN68Y1GiMawfEA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=MC8img3f; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=MC8img3f;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gBbsV2Vdsz2xPb
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 08 May 2026 14:35:58 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 546EA60252;
	Fri,  8 May 2026 04:35:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9440C2BCB0;
	Fri,  8 May 2026 04:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778214956;
	bh=h+kJQeLZVqnSeeiwM2bc1dXa4IpY6mXgTH7Yn+fO0vY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MC8img3fZcoaufhCUHIjlXV78rrNtXBpZ+N+uy5+7qUzuQbCLewwJwHFiUaftpt5g
	 LQjTggA6Mc1fJr8ckvs748ORbJ0NIw/Bqs6pS3FJ38ubwO6DVE1//XBEXr8bHndFVU
	 pAJ3/4UASkP+vsfyDt2KLDLILYchQWVIvjlrcdoeb3Q98Od69syCOERuu6+bdY8vKZ
	 92sHhJjKfRPyAOJPUWEqEJE5g1VgHjlsYhdXhvoN2LvwHrSmjcMN8uusU94oiaC/eu
	 HHNyYsa/J257vDG1DYYX3gVI0gfb9mR4CE9NURHOBL5QKSRN4T1kpq2nWqah/eh+j4
	 7YWsi91POa/nA==
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
Subject: [PATCH v7 02/24] PCI: Add pci_resource_is_io() and pci_resource_is_mem() helpers
Date: Fri,  8 May 2026 04:35:21 +0000
Message-ID: <20260508043543.217179-3-kwilczynski@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260508043543.217179-1-kwilczynski@kernel.org>
References: <20260508043543.217179-1-kwilczynski@kernel.org>
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

Add helpers to check whether a PCI resource is of I/O port or
memory type.  These replace the open-coded pci_resource_flags()
with IORESOURCE_IO and IORESOURCE_MEM pattern used across the
tree.

Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Tested-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 include/linux/pci.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 2c4454583c11..e93fbe6b57fe 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2300,6 +2300,31 @@ int pci_iobar_pfn(struct pci_dev *pdev, int bar, struct vm_area_struct *vma);
 	CONCATENATE(__pci_dev_for_each_res, COUNT_ARGS(__VA_ARGS__)) 	\
 		    (dev, res, __VA_ARGS__)
 
+/**
+ * pci_resource_is_io - check if a PCI resource is of I/O port type.
+ * @dev: PCI device to check.
+ * @resno: The resource number (BAR index) to check.
+ *
+ * Returns true if the resource type is I/O port.
+ */
+static inline bool pci_resource_is_io(const struct pci_dev *dev, int resno)
+{
+	return resource_type(pci_resource_n(dev, resno)) == IORESOURCE_IO;
+}
+
+/**
+ * pci_resource_is_mem - check if a PCI resource is of memory type.
+ * @dev: PCI device to check.
+ * @resno: The resource number (BAR index) to check.
+ *
+ * Returns true if the resource type is memory, including
+ * prefetchable memory.
+ */
+static inline bool pci_resource_is_mem(const struct pci_dev *dev, int resno)
+{
+	return resource_type(pci_resource_n(dev, resno)) == IORESOURCE_MEM;
+}
+
 /*
  * Similar to the helpers above, these manipulate per-pci_dev
  * driver-specific data.  They are really just a wrapper around
-- 
2.54.0


