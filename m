Return-Path: <linuxppc-dev+bounces-20587-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16A70CD342F
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 May 2026 04:36:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gBbsZ1fWjz30dn;
	Fri, 08 May 2026 14:36:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778214962;
	cv=none; b=AD+W6QFXrF5NS8ayFDmYMCASHLZeBPWmXilAOayw0jeIAMhXgWSS6oD6lDUrTMohCmJK0WT0yj0DiJai/B76rJQKdR2cRY1ICy0y4uHE2XQ+aHD2dYH+ZRf31iHCkRc6C8eBYKDW9qSHqWJHXNdpX7aZm+LimumRqXXtFucV6D4vdBzFbRowB83AmmMDLRRYMBEqj3Yd4WHdiV8ox6DLfP7lsvagmPQnf1uvM9ISFazBHvdpJywvReQXX2MMJvAFKq2hO7ZF2hXeNs/wC2IfTM68bKHErIhUS11W+GuKjdMl1FNevFYdlQTOmMraPdFFOmDxAcBNZdLdztBgImzNMg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778214962; c=relaxed/relaxed;
	bh=/rWAb2PQyXpe51MYSLcCHAQKEqqJcKtSCl1xrrAhrYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bsrtba2azKgsVa5zKvLscpG1HrC1P/lIgGHCn68p5qXa4gdwy2nWiusb0gylZlWZdWAH/Z/QtmNuPDP/HafhTJTMTJtHGv03o63CGnXRepMYmjFtmb0+CDW/lJVr4qMMvVy4fSUCwrnwcnKHtxdR4S8v+zvdtPmWbDvj01BHS0wKKt2DCJ++WBxpwdz6BsESuiH/EehXYiYp6JDoh5ZOVng1CbzQxegoTulBSfrlA0Jfu060XDSeMNus7uSxrAgu/9TOT6rI3feHxbiDqW88mzdQK69cOMeYZwo7SEGNoA3MnaEH4s/G4WMPCeefAIikudNgGdWktetYolufHAaH1g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=QZhjKYSe; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=QZhjKYSe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gBbsY3VVSz2xPb
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 08 May 2026 14:36:01 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id C3C2A43A99;
	Fri,  8 May 2026 04:35:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61832C2BCC9;
	Fri,  8 May 2026 04:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778214959;
	bh=YDXDaTiZL/jU7S6ZlvEHwWX8F+uGcw5PflPiSNCW/f8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QZhjKYSeueGY0YycWg9jXDotOLQQrRaBu+rKhOqUx1FIoOxL0nPgUCJjEVYHRi3iA
	 GVa9vS/Bb77kvgo78GJrDxvY5kVlfcEutAhqhw3Jyfj8qvAaSFVD90QjjNq92XF/WR
	 FNse+jmJk3xyH+u8Y5OjFV5acUnTgTUd/oo5KYFBJpFusS8Pkwvd8ob8cCEMP5uyBM
	 TnueFwwFHVCqaMBlJvKrYWrOv4ZRyA2k5xaovTGmeWfdq3O8w4h5sVMYGBIBNmO47U
	 qj03i6Uwa6psunVhFFVkONBP+1BMccmWwSBUk1yl1Hju/2ol7ZD3XKSHuctiCA8J3T
	 QNgc45tnaNbvA==
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
Subject: [PATCH v7 03/24] PCI/sysfs: Only allow supported resource types in I/O and MMIO helpers
Date: Fri,  8 May 2026 04:35:22 +0000
Message-ID: <20260508043543.217179-4-kwilczynski@kernel.org>
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

Currently, when the sysfs attributes for PCI resources are added
dynamically, the resource access callbacks are only set when the
underlying BAR type matches, using .read and .write for IORESOURCE_IO,
and .mmap for IORESOURCE_MEM or IORESOURCE_IO with arch_can_pci_mmap_io()
support.  As such, when the callback is not set, the operation inherently
fails.

After the conversion to static attributes, visibility callbacks will
control which resource files appear for each BAR, but the callbacks
themselves will always be set.

Thus, add a type check to pci_resource_io() and pci_mmap_resource()
to return -EIO for an unsupported resource type.

Use the new pci_resource_is_io() and pci_resource_is_mem() helpers
for the type checks, replacing the open-coded bitwise flag tests and
also drop the local struct resource pointer in pci_mmap_resource().

Tested-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 drivers/pci/pci-sysfs.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 1fbc3daf87cc..2e4e226e78d4 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1082,20 +1082,24 @@ static int pci_mmap_resource(struct kobject *kobj, const struct bin_attribute *a
 	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
 	int bar = (unsigned long)attr->private;
 	enum pci_mmap_state mmap_type;
-	struct resource *res = pci_resource_n(pdev, bar);
 	int ret;
 
 	ret = security_locked_down(LOCKDOWN_PCI_ACCESS);
 	if (ret)
 		return ret;
 
-	if (res->flags & IORESOURCE_MEM && iomem_is_exclusive(res->start))
+	if (!pci_resource_is_mem(pdev, bar) &&
+	    !(pci_resource_is_io(pdev, bar) && arch_can_pci_mmap_io()))
+		return -EIO;
+
+	if (pci_resource_is_mem(pdev, bar) &&
+	    iomem_is_exclusive(pci_resource_start(pdev, bar)))
 		return -EINVAL;
 
 	if (!pci_mmap_fits(pdev, bar, vma, PCI_MMAP_SYSFS))
 		return -EINVAL;
 
-	mmap_type = res->flags & IORESOURCE_MEM ? pci_mmap_mem : pci_mmap_io;
+	mmap_type = pci_resource_is_mem(pdev, bar) ? pci_mmap_mem : pci_mmap_io;
 
 	return pci_mmap_resource_range(pdev, bar, vma, mmap_type, write_combine);
 }
@@ -1123,6 +1127,9 @@ static ssize_t pci_resource_io(struct file *filp, struct kobject *kobj,
 	int bar = (unsigned long)attr->private;
 	unsigned long port = off;
 
+	if (!pci_resource_is_io(pdev, bar))
+		return -EIO;
+
 	port += pci_resource_start(pdev, bar);
 
 	if (port > pci_resource_end(pdev, bar))
-- 
2.54.0


