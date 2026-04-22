Return-Path: <linuxppc-dev+bounces-19960-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C439FFA1FC7
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Apr 2026 16:15:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g147N5rCTz3bdW;
	Thu, 23 Apr 2026 02:14:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776874496;
	cv=none; b=fZ3Zv1k4+C1F1UcMqrEmQCMqnQB8RGfjXHS29W0Xu3rJSzyr8g5A+HMJ9i/Avln4JZCBLAEy3WXVjzgtujwQv7/zmR9nzg2izMplTzDxhJ0bfi1kkfSaQH9ca8Jxj4UUGPg+hcYUCOL3MTXRL3dmmaMq2J2607cgUlpRbqeTc0AqEoYNZlYBeoYrldyuabZ/69Lqxq3Q2tTOy5ovIhj5cbj5jxBZ18cZqFV/UociLGXvGCNYZGAD7zn6fjgbsxXDDpb65K1WTVj84Liqge7Wpm7pXtZiyYvcn6FYtnBCRui4SIhdhQa12Zoj8wpvQYMeT3dX7umv5es3N4NiX4gVyw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776874496; c=relaxed/relaxed;
	bh=sBntoMni7Ykclfn2Y5eqTK3dKsbiNShkbBh9ciTrjXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mKJ8ylopmJDkpU9ETtXnf+K62Ek5hkpX7QSfwvDx71dxXiglz2ZeduhciVOs4dF5fguxhxyvyTUl6C24XnqARHPJpwdFYN7ROgbTAD775lX8LZTG2oe6jkvq4px2mG+pvZdyzhQE02/S5pFkX8TN69nzqr8Fp84jq3mA5Sra/Bwz2o45xIKhcdRO9Mqbnv3d0SPjk7NABJbP6kccJffr/Ww5CEch9jrqe8h4J8byuC8Y/cS6TuBzy0oGBLrfoNVC0s5XaW8kBgzbo9VZDek7+Gs1mPHdNXTWv6KvC0/vSz9cGz+Qs9fGiaZ0WTdz6yMyGVCrOb05F7XwPlJb0yjftg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=BYmOqinf; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=BYmOqinf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g147M6p38z2yr9
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2026 02:14:55 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 075DD61336;
	Wed, 22 Apr 2026 16:14:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 862E7C19425;
	Wed, 22 Apr 2026 16:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776874493;
	bh=W+7qR0XM35IjlsguUPu/WCGx43xcJ1ZzJ3pRjU9kU/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BYmOqinfVDr+hgBcy/KAx20ewSKraBiPaMCJz55/dXBp9Om3ckl/EdG62taw8LTE0
	 F0S7/n2DoewFg6YHw3tTpVpdEbtNP8lGXJg3hWXwcMN2qFfn2eQ0WA+yw8YCdVHMBM
	 4OCvfiXJmPgEKV0R9aom2vaijI8TNQdhyoHDWJ6Lm9TVgLrSUS/GvRj4zwOwOChjo9
	 b1Om4d4xjfZgHAyXSn1Oc0k9HqHx3+oWhQ55V8nU/1TyDr/q6d2e5eHhoKTvCI1Mga
	 MwkJXhWSTOsZDTBDACUtL7stz2qhW7VEiU1GusqxcwllfMgJBeNkLV3PzNc9hpRhUn
	 TMAwACCNmE5vw==
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
Subject: [PATCH v6 12/24] alpha/PCI: Use BAR index in sysfs attr->private instead of resource pointer
Date: Wed, 22 Apr 2026 16:13:55 +0000
Message-ID: <20260422161407.118748-13-kwilczynski@kernel.org>
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

Currently, Alpha's pci_create_one_attr() stores a resource pointer in
attr->private, and pci_mmap_resource() loops through all BARs to find
the matching index.

Thus, store the BAR index directly in attr->private and retrieve the
resource via pci_resource_n().  This eliminates the loop and aligns
with the convention used by the generic PCI sysfs code.

The PCI core change was first added in the commit dca40b186b75 ("PCI:
Use BAR index in sysfs attr->private instead of resource pointer").

Tested-by: Magnus Lindholm <linmag7@gmail.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Acked-by: Magnus Lindholm <linmag7@gmail.com>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 arch/alpha/kernel/pci-sysfs.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/alpha/kernel/pci-sysfs.c b/arch/alpha/kernel/pci-sysfs.c
index 2324720c3e83..2330ab84d59c 100644
--- a/arch/alpha/kernel/pci-sysfs.c
+++ b/arch/alpha/kernel/pci-sysfs.c
@@ -69,25 +69,20 @@ static int pci_mmap_resource(struct kobject *kobj,
 			     struct vm_area_struct *vma, int sparse)
 {
 	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
-	struct resource *res = attr->private;
+	int barno = (unsigned long)attr->private;
+	struct resource *res = pci_resource_n(pdev, barno);
 	enum pci_mmap_state mmap_type;
 	struct pci_bus_region bar;
-	int i, ret;
+	int ret;
 
 	ret = security_locked_down(LOCKDOWN_PCI_ACCESS);
 	if (ret)
 		return ret;
 
-	for (i = 0; i < PCI_STD_NUM_BARS; i++)
-		if (res == &pdev->resource[i])
-			break;
-	if (i >= PCI_STD_NUM_BARS)
-		return -ENODEV;
-
 	if (res->flags & IORESOURCE_MEM && iomem_is_exclusive(res->start))
 		return -EINVAL;
 
-	if (!__pci_mmap_fits(pdev, i, vma, sparse))
+	if (!__pci_mmap_fits(pdev, barno, vma, sparse))
 		return -EINVAL;
 
 	pcibios_resource_to_bus(pdev->bus, &bar, res);
@@ -170,7 +165,7 @@ static int pci_create_one_attr(struct pci_dev *pdev, int num, char *name,
 	res_attr->attr.name = name;
 	res_attr->attr.mode = S_IRUSR | S_IWUSR;
 	res_attr->size = sparse ? size << 5 : size;
-	res_attr->private = &pdev->resource[num];
+	res_attr->private = (void *)(unsigned long)num;
 	return sysfs_create_bin_file(&pdev->dev.kobj, res_attr);
 }
 
-- 
2.54.0


