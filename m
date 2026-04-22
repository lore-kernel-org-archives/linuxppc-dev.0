Return-Path: <linuxppc-dev+bounces-19951-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A360FA1FC5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Apr 2026 16:14:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g146s1Qc6z3013;
	Thu, 23 Apr 2026 02:14:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776874469;
	cv=none; b=OYK0gpoDqFTo9HNwCNa/3m85bRqdqN8z/wGYTUom1vbqY6t+A0jofA1x5rT2JIkNEw3o26ypKAYTXRbMnpAl2B0zTRlfX89BZR1NKwZi/1irki75p2Q49+pWllkcF5itO0GNSR3JKxPZkr5NWIynTYYbq6vUqgjv7yExi1UJIz2uigXx/ZID9eqkvYRP2m7UI0BAKTZ/bmwqsYnsnOrYfrWODT1cMNrTWbn+8iI9/5d3a78mb/dPHR28Lsk68UbTFhJThC43a5YiIYhYUIQ8cDlBqMAhKb4FyUpyxHyTVCW7KH7+J1/P8sBNaDBLz5jwaOoK9P0t61ImR/M+o0sfeA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776874469; c=relaxed/relaxed;
	bh=iAZpMOWXlOqGIQnEB3i8I0YEnceXF0NTgFu4rtLso+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lewp/8O3DZ2v/4Zlts7aAxClqFLLWBmB7Tr1ghQksQBf16Mu0iXfLBhpagI/49oPCRcIv6TuP3vXublszSO31rP0V4/mhulbRPIswyViX1vIpMIa34VaJ+LpfMBckEM8RCZUpBksy38Uk2fNTdvemL24kBJahd4agPhgK0DhiNXWFguecx1J/7dXjU+4RdqWJ6zbB600dtP8wJhOYnKQjJRX5oaU1GeRdoU6NKrtuaF4a7gIUWBlHqf48DAQ5bg+tPjjVoFzLbkbOSCm3KG14EVwnbQnx7fuBGe1k27McmzqsVNoVa+vtgJ43/tqA6j190sgpWns2TZU0KFgzfosGA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=k9viRKS6; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=k9viRKS6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g146k1FzCz2yr9
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2026 02:14:22 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 4702560128;
	Wed, 22 Apr 2026 16:14:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1E09C2BCB7;
	Wed, 22 Apr 2026 16:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776874459;
	bh=O8CncpOJK/HEBS5SYT1UON/nV1bsCDfLQepqxgK+Uww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k9viRKS6BQTK2BLg0soUC2j+wByHK5EaixTiZUg0Pf15vY5LH7YVo3wMhaxRPz0sa
	 UoZt4y9z/67I7pCDd6LV6JfLgeBc4kMwMsVFOS0wDrTLdpwIDKOUyIvNKQYvmzwvN9
	 HVGck6uprDbL9SUB/Nv8NbQCeQFONGP4SnVrK6st/5Vakhz/miRs7VJgEjxCmi8mX1
	 9Y3P0jhwwWcXhJlBVxBvjQ4jr04kNNX70xO4ckgKTyARp/whyGdLh/ZoXn4Y3SmcB5
	 0pkOWgx/RUa1hAsA2IfXFMEKzDoIHxA0WUotSGR2Ije1bLphywGsrpvgMbZwSmtnIZ
	 hTDVu0RxWsesw==
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
Subject: [PATCH v6 02/24] PCI: Add pci_resource_is_io() and pci_resource_is_mem() helpers
Date: Wed, 22 Apr 2026 16:13:45 +0000
Message-ID: <20260422161407.118748-3-kwilczynski@kernel.org>
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

Add helpers to check whether a PCI resource is of I/O port or
memory type.  These replace the open-coded pci_resource_flags()
with IORESOURCE_IO and IORESOURCE_MEM pattern used across the
tree.

Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 include/linux/pci.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 1c270f1d5123..05aceb7f1f37 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2295,6 +2295,31 @@ int pci_iobar_pfn(struct pci_dev *pdev, int bar, struct vm_area_struct *vma);
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


