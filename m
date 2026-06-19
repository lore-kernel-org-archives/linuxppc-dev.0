Return-Path: <linuxppc-dev+bounces-22791-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0590DCDB466
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Jun 2026 08:52:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ghWYm2HBHz3brM;
	Fri, 19 Jun 2026 18:52:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781859132;
	cv=none; b=hO9AhQ+mRKwCC0BxZZna8rQkWZ/oIaLPAErzdaBO+hU5KRgVmbGoCIs2xolwmtfHYaCe3jwz+1hAacViPLUmLh5rRcRfHrVRN6ga6izr3mNL3Uqu96BXpbxAyAzYDJa7E2dg0cNa8mN7fbwtB/m45bGlj3s3QSXMJHG7t/FrmoXGdtGir183G3Nb88BCRayApWTG6DKv+dej8wDmX+TFvhV55Vz4mTwVDz2/YXp6CpciU8tNxklgxkX4cFlE4l4pLv0x11AA1Yljs2Tg35s4KefNiv0QWHp7AAp9DilYvTDjs2eOXmT3GGu+NpI9nF7JZgJI6KBPnEU2fl5lkPt7Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781859132; c=relaxed/relaxed;
	bh=1xP9Elz8G9gYa3ky+C5oo0oSwd4JFSUlfxkzHa8jlKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EZENbFZYB+5dyRhEFP51q+uSLSvQojVTNsGZ/2BVGzopO2X+s55AYBYU1HSL5jbMVkV2HlCceds/0nUKON4ZNXoMFYFg7UEyh7QevJ0k/utH+V5qKE+JDzxuWu+yAxOYiezo78WMR28NeHOqXo1Wff1UHND83MOF811F4+23c3u+gvxSSt8+KLm93KkIcAI37paL2fjL3zUH+EpmMRWUZNIyZpWmyclh7+g6hhxQIENBZH2SCR41NNkcWoXoS106FUmFCr5F7ar0YAgPCIHZYlzOV8sqFBU1PDz/3Dkbw7uBsQWzhPmK5kZES18clI8aKtOhrCEYy7UxcVUtNdEhsA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pm045v6S; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pm045v6S;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ghWYl2NHXz3bpp
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jun 2026 18:52:11 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 0E36B4365E;
	Fri, 19 Jun 2026 08:52:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7B261F000E9;
	Fri, 19 Jun 2026 08:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781859128;
	bh=1xP9Elz8G9gYa3ky+C5oo0oSwd4JFSUlfxkzHa8jlKU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Pm045v6Sk8A3Jcb6IESBn+nq11xekVlXKRBu7DJ/WBhCZsIQ+PrLE1CnwftYEmMeV
	 FcLMjYszoiStPo88QyDe/jjkJDCSd96Ja1z4LsUt4B9Ikz0JWETpuUuuvT0g0mo2vA
	 jYIPbxaymC/jCoBk1okrdPJHqRFh9tXDvnpoZ1O1AwCUv7gyxapuWhgDYmg+l3W0gu
	 MzKe2RQgvW10YTZmLPZPPC62c8CvbHssnzlOCMdxGqRm9o5Oih2Yn6uDRNGwWJq2U1
	 Ejzkf33KD+dmpBPAQv9cvOdpIizVqMJtBA438ciUy6PlXg8BxX9kBTA0CMOTrQLUF5
	 QsiOMGQviwj5w==
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
Subject: [PATCH v8 01/25] PCI/sysfs: Use PCI resource accessor macros
Date: Fri, 19 Jun 2026 08:51:36 +0000
Message-ID: <20260619085200.3729431-2-kwilczynski@kernel.org>
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

Replace direct pdev->resource[] accesses with pci_resource_n(),
and pdev->resource[].flags accesses with pci_resource_flags().

No functional changes intended.

Tested-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 drivers/pci/pci-sysfs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index d37860841260..1fbc3daf87cc 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -177,7 +177,7 @@ static ssize_t resource_show(struct device *dev, struct device_attribute *attr,
 		max = PCI_BRIDGE_RESOURCES;
 
 	for (i = 0; i < max; i++) {
-		struct resource *res =  &pci_dev->resource[i];
+		struct resource *res = pci_resource_n(pci_dev, i);
 		struct resource zerores = {};
 
 		/* For backwards compatibility */
@@ -689,7 +689,7 @@ static ssize_t boot_vga_show(struct device *dev, struct device_attribute *attr,
 		return sysfs_emit(buf, "%u\n", (pdev == vga_dev));
 
 	return sysfs_emit(buf, "%u\n",
-			  !!(pdev->resource[PCI_ROM_RESOURCE].flags &
+			  !!(pci_resource_flags(pdev, PCI_ROM_RESOURCE) &
 			     IORESOURCE_ROM_SHADOW));
 }
 static DEVICE_ATTR_RO(boot_vga);
@@ -1082,7 +1082,7 @@ static int pci_mmap_resource(struct kobject *kobj, const struct bin_attribute *a
 	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
 	int bar = (unsigned long)attr->private;
 	enum pci_mmap_state mmap_type;
-	struct resource *res = &pdev->resource[bar];
+	struct resource *res = pci_resource_n(pdev, bar);
 	int ret;
 
 	ret = security_locked_down(LOCKDOWN_PCI_ACCESS);
@@ -1286,7 +1286,7 @@ static int pci_create_resource_files(struct pci_dev *pdev)
 		retval = pci_create_attr(pdev, i, 0);
 		/* for prefetchable resources, create a WC mappable file */
 		if (!retval && arch_can_pci_mmap_wc() &&
-		    pdev->resource[i].flags & IORESOURCE_PREFETCH)
+		    pci_resource_flags(pdev, i) & IORESOURCE_PREFETCH)
 			retval = pci_create_attr(pdev, i, 1);
 		if (retval) {
 			pci_remove_resource_files(pdev);
-- 
2.54.0


