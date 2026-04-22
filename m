Return-Path: <linuxppc-dev+bounces-19950-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C440FA1FC5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Apr 2026 16:14:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g146n3Sfpz2yvc;
	Thu, 23 Apr 2026 02:14:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776874465;
	cv=none; b=ELTiU7cJF2LkKIfeeEejjkapJLYy66SqxUpM6SmSrvVYZm0qvBmRsp4BZRc6JSSpYtL5JlVB4dr0VtjTA2Tg7kLjya+ibG7VzuyHZQVYaTtsGkmqfGzh6lE+OV+2TkzdPv/LBaSNV6Fl/20KTqzWXjZuwSZSkrvTEhpk81mHLnuc7CaasLAtgdPsJI335+rB+KZMT3xdbdjDd4/Y2MgYV+2VJHGwvTiS8KJeV0gC9O0b/ZWrUkB68cB5muKFsnZUBbQwu6u1yMjOvet6F09unPM6suIlZvzywvODBZdsX+JshfDE6H7K8NllxWUJ3CZQdDw1a3pKEKcEFGf1vnybWA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776874465; c=relaxed/relaxed;
	bh=oXM7GxfxrRMywhlyIH+yhbFQAfgjANayUJw6kmn2FnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ef5GmiY3EmlyTjbV/jsVOiiK0j0LZYApBjTAEqHr6i/FR8FXAJkP4E2PiRUt2MDNITj6ZlBxGgXWwUQKZjsVBXmdYaNcZMFZAGTyyiRv9tyPg7vzDYcLwsN9BzAjU0oAHIXRITZART4jSafEI7ylDvvGjPaWuXwu49rEEMih1To5sd5obLy8zo2thYIQWwhpGxDy7LBx8VSwEcceH+IJNCyCOp3VXLIPBMIJjA+CjbuERr31cFKK7k631J7/CYtnNWvDxOPdJcacLORUfiQHTFR6atnn0bvpiMVnWWg1ovmORJOYWUXR8vIPzMeso6fpWNuBak/WZloFQLQl0aDgJw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=q4afykfe; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=q4afykfe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g146m4x8Wz2yrM
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2026 02:14:24 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 9311440A8D;
	Wed, 22 Apr 2026 16:14:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 532B9C2BCAF;
	Wed, 22 Apr 2026 16:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776874462;
	bh=HZ5aHhQsiLFl5RPG8uUtLsO5XRsRiFkacQ/7Zktybgo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q4afykfe3MmcSwnaafIlC8sSC8KADiLzDLhZemBm67uz3dQkAihde5mmJdWWPQ3w6
	 tjIBZ9k3YlOZtUn8dzXTaIoC8kOvMGeLL6xQo9SACOgpo8eRbU3ET+T8VLKlnvQKpI
	 gKHaAHCXDiN485XXloqrLxd/P3UAiGh+LjcEmT8YZr0YVMSnbf8hNW6eqbcD5Douxh
	 8pLKKJiwOrf//N2fQdhijqsJFvGHDiS9BxkGrHOSU1w6SJSaZ5FrnAQdaU/vSB2TT2
	 Daw09QSrLCmFMA0WkuCjBNdOP0PGnafeBbHQF/QzeTbj7YFtL6SuNAsjjIHAbjFA/j
	 wQcus2e7AJMjA==
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
Subject: [PATCH v6 03/24] PCI/sysfs: Only allow supported resource types in I/O and MMIO helpers
Date: Wed, 22 Apr 2026 16:13:46 +0000
Message-ID: <20260422161407.118748-4-kwilczynski@kernel.org>
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

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 drivers/pci/pci-sysfs.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index ad3c17f86c7f..6783c6168445 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1108,20 +1108,24 @@ static int pci_mmap_resource(struct kobject *kobj, const struct bin_attribute *a
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
@@ -1149,6 +1153,9 @@ static ssize_t pci_resource_io(struct file *filp, struct kobject *kobj,
 	int bar = (unsigned long)attr->private;
 	unsigned long port = off;
 
+	if (!pci_resource_is_io(pdev, bar))
+		return -EIO;
+
 	port += pci_resource_start(pdev, bar);
 
 	if (port > pci_resource_end(pdev, bar))
-- 
2.54.0


