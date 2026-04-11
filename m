Return-Path: <linuxppc-dev+bounces-19622-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF897F36BA7
	for <linuxppc-dev@archiver.kernel.org>; Sat, 11 Apr 2026 08:02:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ft5jl390Mz2yrD;
	Sat, 11 Apr 2026 18:02:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775894523;
	cv=none; b=M3Nam5t/SOcqO8eMypLSaXPmEtKOeo7Vckv9PqFfTlFhhAN/NI9l4a2D/ssFNgp46fxlpBXBgL9ynw10/Q1vYgfM7akCan9dJOJPJUZU86d1PGZ4hrRDFA447WU37/BEcvKr3sTNE9DNCI8rcDPVIyTMWLpKJcmqR4esh/BYpJZqP00637LV/8AlWcWFEg3lsHxv5pBrXqUkEMjYrudrywEf5CM8oMCjMviSe6zS/dXpXfzo9szErBZPBZzf2yZMXVRCZzjFHQQ8PtUGgIjKrLcSsp/uO54GkzpessmYEStEctClyU1alG41V2QyQhBajd6V2JxDWk/0x/ij6EQDIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775894523; c=relaxed/relaxed;
	bh=cgjZekK680ubRXcEUWz1rs/sh7I4CW4RvRcwy6FKqMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A9HNZlMK0YOytxTBu11EZuRgB4b2T/526QAgUFrax0bDLrh0lcDtPK09T1u1TkhNdXY/wjLP0zsMhOBAgqTAhNgJhN+/42qiDiVgy35e5aEpiZMZIVKWjMB+Jztc2xyRpE0uxUmoQyxwq/MLjxHCFhNxcXSBaVIxyYS8Xk+YIqmpKTMcvn4CurwqSxnEF54OdPGEAeRMDE+v+YIQkHTsJAH3SjgdZODi7NLmSGLawqpMbWV+HtTZokNpvoAlh8rAnJKE1/ozaZym0cvLUZHtIkC/RqdW9PkD7U+/0vQ4YG4sKK57tMvm0SliFeVMdfBYPpx3QirNsIZCtL8Da8jWjw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=qDyenqYh; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=qDyenqYh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ft5jk5c9Qz2ypW
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Apr 2026 18:02:02 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id D398E60142;
	Sat, 11 Apr 2026 08:02:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62FA0C4CEF7;
	Sat, 11 Apr 2026 08:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775894520;
	bh=M4LBexol3vWd4MZjwunSYPnTSRksW2HSkNMaScnPtII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qDyenqYhmb3sg1Sk7rCtOdP+KJ/KomcwfTCFj0l3eBTWiUDAWAOTOZysGSOcziUmP
	 Vwabmjnksn5WcPK9TAY8dWQd9eAITjKdJUxRzZWOzOZXK6+rXUlWZ4IWi4P7VrWmxF
	 vFSXUm6V4VMdSv4iosNzSZ2dF1zOK3/cnJSBGNgIAuC4mdq8cX8BZx3v0rv6GxuHUu
	 EXbSO7+DTCb2AEFz4Is1ibAjjYm2J8Io+7J+wjHqXsJmBuQcAP4XNLRGwyH9e/4BZi
	 UK+mjsbcp7nkmJUIOPs/i0zNyZRELYN7jGlca5yJjEJ9EYIO+U2XaBI8QS4zKrUsvE
	 RVYB7jxYZ2hYQ==
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
Subject: [PATCH v4 02/24] PCI: Add pci_resource_is_io() and pci_resource_is_mem() helpers
Date: Sat, 11 Apr 2026 08:01:26 +0000
Message-ID: <20260411080148.471335-3-kwilczynski@kernel.org>
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

Add helpers to check whether a PCI resource is of I/O port or
memory type.  These replace the open-coded pci_resource_flags()
with IORESOURCE_IO and IORESOURCE_MEM pattern used across the
tree.

Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
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
2.53.0


