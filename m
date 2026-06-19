Return-Path: <linuxppc-dev+bounces-22792-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66F9BCD4F26
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Jun 2026 08:52:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ghWYr1wHhz3bsL;
	Fri, 19 Jun 2026 18:52:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781859136;
	cv=none; b=M+SGdqtZJYpsUrPezdz4p/zO23yXxRXc0zODVC9AvIRF8qxyqC3xWbIpu2kueuzi26eyaYKO5DNeBqqlwUKoS/nKWIMH+lShsoEr52MnKD2dWzGdgZoTrJSjbAt0BE7D0eyg4F64uwyL1UUtm0CIQlmOol61OT3TPliqZqTSBF72nt4yVq7gKVYJYy9dsDS4xd0qeDBIZZTSfl678AZrpcgMdh3z97nSAOYsJ7AEYqrXDhQV/0YYu5zaWvT7iV+Q5XUvU81T+12lDorOvK6A4xM/lbZ4XsgtbunwlIXXAfKinHQMtwz+2Ks5zQekQ1vzb0P+dn8/Y9rIbFBIL24vcg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781859136; c=relaxed/relaxed;
	bh=J0zsLA5ryToNAxAxjQD54oSfvFP26rqE2yjtK6eduNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BQRvZe+rijW2o+pAQjwFr20yvDPVkgve3sPCgbhgz2EFdqYvYWYTztoe+QvFaQHDasQDm7f8mMbjFH5wFMdbKDySsrqulItMN2/uzTKO1a/OEfSH/6R7+ppu96kl63NUYT8sh764hwKCZTBrkKV17HOD2VHelqyfb2ZsCI/8D3mCaUh+CCsY/VAF2FJK9AEyW25Er1iiDXDL7MrJTNeGxqBlw50w6bv1LBozFuucuiU6xrDASxgP5t7I9lfCeftPHRuhADDPZQZ8va/cIXWQcIVOilkzJ2G/6mAEq6/I+3W+rWikk9MbX+XeROZIe8GGLdEHfGVm4HRGI87CuIi62g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IxblK0TO; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IxblK0TO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ghWYq2gFkz3bpp
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jun 2026 18:52:15 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id CFEED601E1;
	Fri, 19 Jun 2026 08:52:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 482A41F00A3D;
	Fri, 19 Jun 2026 08:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781859132;
	bh=J0zsLA5ryToNAxAxjQD54oSfvFP26rqE2yjtK6eduNM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IxblK0TOn4bdXlw02y2LSJlKBmz55vqoszPIyo2wScT9SEaCVMALNErCNIHU/x8cW
	 5QDql3kwgR6b5J3c5PGbOKl7izAejKIySikHILgUg8fKsWay4B2ob57K5VqS5IHjmE
	 /5sAAvWBib8AKzAbp7cFItA3AN4tK0n4VIVpo+mFSuHjnFcd84rEZ/eQe1+i4GBCZp
	 TlCIPhhqE6AEhOMb7IKPq8yBVRPr4jVrmomdy2A2bUOkCXUhlgV3EqHWGDXfxx9BgW
	 jOW8ci+SaDl3HCxnSZKrA67oQPWPD71n1gSyDE1w61LXNpoL/yv7xgxSztTT6FwQOF
	 cNIzqHMrBRPEw==
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
Subject: [PATCH v8 02/25] PCI: Add pci_resource_is_io() and pci_resource_is_mem() helpers
Date: Fri, 19 Jun 2026 08:51:37 +0000
Message-ID: <20260619085200.3729431-3-kwilczynski@kernel.org>
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


