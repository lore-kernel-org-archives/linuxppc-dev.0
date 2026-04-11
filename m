Return-Path: <linuxppc-dev+bounces-19621-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D68CF36BA5
	for <linuxppc-dev@archiver.kernel.org>; Sat, 11 Apr 2026 08:02:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ft5jh1zv8z2yk6;
	Sat, 11 Apr 2026 18:02:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775894520;
	cv=none; b=BLz/Wk5UV8O+GU4TDNoJmQ17ltNq8VIcqPW8Mx7J5VA5HfuMU2m+qpm7h+MwtEjRG1g7nOEv3l4+3KqWU49OlxQM3TnE0RwAnz1MAJURBJJv6J4EaAPMsGsshv6vM+CHtAp4gTtBiwSvU95aOJbwzdHEBnf2echg7Pbc399833nx6AMLjhYf68+l/HWXQHI0HKhugwpPjjyr6IrOu94HluuxtuHuPksXVl5gt3r/QSB/EEYBkeS3iL+29oC82XVTKLcipelr9p3JPtbrYSktagmmBoROXUtgDdCT/bRB8VSGLXX9q1L9wIW43T5CiPm/87+ABfzfoxjgfcgFEVlVDA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775894520; c=relaxed/relaxed;
	bh=LCRdgslrAssbAfR6+/R1EA5irROHLBrDOk/2Upy2nsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KQdpoxS4FmayTFozyhwav48Cjf8ihg3tYZhRzkR4bqw/WrKNnqEiK/yF6AnVzashRV+aKxErCmSeBckQ1CUnWkQuHC45FR+l8cd67JuUZpYdvIF+gIVu+iPZ6Vl7K0gqi8ZbNY346E2MhFVZUZZnZEc49ZSm/KTK2nbOm0fpzAGpM2vrMsi7zxeuK9OrBJWCCGt0LSkCkJpOHkq16WiaoIe6Kg0I5kF/1TOHqPVvuKyKmgQFVMRpNImJ8yCBCBW62DBAEkQAB8M4qWk2oyoRL1GP9TR7RjTk2q8HxjwphimgEpCTecMejW7Adk/tNO5iVupU28WNRK//xhNMKNKEtQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=hLLnRsUt; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=hLLnRsUt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ft5jg3GWcz2ypW
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Apr 2026 18:01:59 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 5686960141;
	Sat, 11 Apr 2026 08:01:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7E34C2BCAF;
	Sat, 11 Apr 2026 08:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775894517;
	bh=+MngKbk4Fu+hXvrF1jLsdL88/ySXVmeG1h0/A7xlETY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hLLnRsUtQdKBkr1E2YTD83+aGN/yU3sxh89srqSUF183NKPL7XfwGw+IVBr4nUBUX
	 +Dcef6LNrtVh1IPdd3gFxoHsg/uJleINXHd2XYrzl/FmnTsbCqLmAznhXMtQHRkZ1I
	 vWtGvGBedKLo3hvRGKyC8ftroH/60ibIDAn6LGpQgWxLCwDKRra18hs5vZiydO+pFP
	 J+1ciusoXTGgsA7gCl2lzCPcTFn19DTxVEOInmTkKR01D93GQBGhGNtvOPwdehn5Xv
	 j/n2z8rJ0715aFfbqpruhJIfhBvfkglWcs9lMsF9R+26HbLAkIFR7o6P6YpkpDHFLh
	 8R6PHqxG6Bh3A==
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
Subject: [PATCH v4 01/24] PCI/sysfs: Use PCI resource accessor macros
Date: Sat, 11 Apr 2026 08:01:25 +0000
Message-ID: <20260411080148.471335-2-kwilczynski@kernel.org>
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

Replace direct pdev->resource[] accesses with pci_resource_n(),
and pdev->resource[].flags accesses with pci_resource_flags().

No functional changes intended.

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 drivers/pci/pci-sysfs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 16eaaf749ba9..ad3c17f86c7f 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -177,7 +177,7 @@ static ssize_t resource_show(struct device *dev, struct device_attribute *attr,
 		max = PCI_BRIDGE_RESOURCES;
 
 	for (i = 0; i < max; i++) {
-		struct resource *res =  &pci_dev->resource[i];
+		struct resource *res = pci_resource_n(pci_dev, i);
 		struct resource zerores = {};
 
 		/* For backwards compatibility */
@@ -715,7 +715,7 @@ static ssize_t boot_vga_show(struct device *dev, struct device_attribute *attr,
 		return sysfs_emit(buf, "%u\n", (pdev == vga_dev));
 
 	return sysfs_emit(buf, "%u\n",
-			  !!(pdev->resource[PCI_ROM_RESOURCE].flags &
+			  !!(pci_resource_flags(pdev, PCI_ROM_RESOURCE) &
 			     IORESOURCE_ROM_SHADOW));
 }
 static DEVICE_ATTR_RO(boot_vga);
@@ -1108,7 +1108,7 @@ static int pci_mmap_resource(struct kobject *kobj, const struct bin_attribute *a
 	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
 	int bar = (unsigned long)attr->private;
 	enum pci_mmap_state mmap_type;
-	struct resource *res = &pdev->resource[bar];
+	struct resource *res = pci_resource_n(pdev, bar);
 	int ret;
 
 	ret = security_locked_down(LOCKDOWN_PCI_ACCESS);
@@ -1312,7 +1312,7 @@ static int pci_create_resource_files(struct pci_dev *pdev)
 		retval = pci_create_attr(pdev, i, 0);
 		/* for prefetchable resources, create a WC mappable file */
 		if (!retval && arch_can_pci_mmap_wc() &&
-		    pdev->resource[i].flags & IORESOURCE_PREFETCH)
+		    pci_resource_flags(pdev, i) & IORESOURCE_PREFETCH)
 			retval = pci_create_attr(pdev, i, 1);
 		if (retval) {
 			pci_remove_resource_files(pdev);
-- 
2.53.0


