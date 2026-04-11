Return-Path: <linuxppc-dev+bounces-19632-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23665F36BA7
	for <linuxppc-dev@archiver.kernel.org>; Sat, 11 Apr 2026 08:03:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ft5kQ3cSGz2yps;
	Sat, 11 Apr 2026 18:02:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775894558;
	cv=none; b=ktBeN8oKmVuZEph7Ccfm50e+q+P32aSIUfMnh7/stQ3hMxgMldLwWwTFYg6eaVTOEwUKzYjQfWFWsumF/QQ7ZKF3f1cQRwHCq88jUHmQkKkuWUA6O3kHcym85GnKs8ncAwCTxxKJVCFZ8s97N58m0GA0IycHOyuH03GcDpnU8pOJntPgX8le4IEIcpuO8/iRL53UGk59kjcwAdX7yV6WDf/i2d3MzLRY4jsunzsnXcUUaTsbuwNXGGvKd1D0FIxpJL/x9cdwZEKyjJVgh/vqi0+V9aOot+lWvRrli39fErOBu6RJIDcX2fHARUDk93Wzzsxw3Btu7k6LZuycEjKI/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775894558; c=relaxed/relaxed;
	bh=w6Pg1tzYCcjCxtB/I/WX6QybAmZXuv8mftDcIyAHmX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LYZtaBP+5h0WKkYQ1UPyQUrncojypa2ETmC9J3Zs0GYMZayn7fnA7jTlvcpHe+MdCU8icvnjXBbD5sxp5EqVRf7usbIV7s58JWfL+ZgajxAM39otcjhLBL8Dupk8f2yhAxxNtnOdJykEl5oJBOkypjgwH3uf/1JhnIIoWXyFU/uTBAbtmgLGiIzcy4uyf/g9xYxb8XQj+FMTu10W/ZeyDkxbRX2vVpFBLd9xH4xTqQI9H1LRYdM0+m8XP7m+x41ZElBU68d7495LyUglItnK1LUvPVaewpGUobIVLD+BLgE4+tM3P12+STsxXFQ6uBstSL1w+qtvAc6ZPJaTun0PKA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=W6ti0xpR; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=W6ti0xpR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ft5kP4MBpz2ypV
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Apr 2026 18:02:37 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 9053E600AE;
	Sat, 11 Apr 2026 08:02:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38CA6C2BC9E;
	Sat, 11 Apr 2026 08:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775894555;
	bh=4+W1kd8ovvTGg2a+x1mXoEZZdmh6JcYJxVFeZ3Yu0xQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W6ti0xpRbuKzeGReO+1yu9MNEg0/ssxI8ndwhH89aUR2pZvrm+Hzf9jXo9RBl8m6+
	 DVLnytiGA+zzwlFrJOOgpEJKodfue9xRonZTTv6wjBJrgNxuV5ssxeMgnhCqaN15W+
	 JtXogcrOmdr1c5Wlg6WCl3C7rSwByygvuAtmxteZZXugIF6bK7rjCivXrrpF5siZ3k
	 tXB0GagfGt/V6nfPBZI5LPVhaPycgvvii9kat0SZNLeUMDYb/u0d4OHlzOyuvVMwx3
	 nXlVzMwqONChr8vyoMMmFwZnBP9NBaueMG197WrTyej0NOcxrRmKs0teomzvSlyTQ9
	 l7gsh7dKK+qIg==
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
Subject: [PATCH v4 12/24] alpha/PCI: Use BAR index in sysfs attr->private instead of resource pointer
Date: Sat, 11 Apr 2026 08:01:36 +0000
Message-ID: <20260411080148.471335-13-kwilczynski@kernel.org>
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

Currently, Alpha's pci_create_one_attr() stores a resource pointer in
attr->private, and pci_mmap_resource() loops through all BARs to find
the matching index.

Thus, store the BAR index directly in attr->private and retrieve the
resource via pci_resource_n().  This eliminates the loop and aligns
with the convention used by the generic PCI sysfs code.

While at it, add parentheses around the bitwise flag test in
pci_mmap_resource() to make the precedence explicit, and to
match the preferred style.

The PCI core change was first added in the commit dca40b186b75 ("PCI:
Use BAR index in sysfs attr->private instead of resource pointer").

Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 arch/alpha/kernel/pci-sysfs.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/arch/alpha/kernel/pci-sysfs.c b/arch/alpha/kernel/pci-sysfs.c
index 2324720c3e83..c84867ce31f5 100644
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
-	if (res->flags & IORESOURCE_MEM && iomem_is_exclusive(res->start))
+	if ((res->flags & IORESOURCE_MEM) && iomem_is_exclusive(res->start))
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
2.53.0


