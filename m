Return-Path: <SRS0=2H2D=XA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B591C3A5A5
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Sep 2019 04:28:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F9332080C
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Sep 2019 04:28:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anastas.io header.i=@anastas.io header.b="jWXbsz+q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F9332080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=anastas.io
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46P73652ZvzDqGt
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Sep 2019 14:28:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=anastas.io
 (client-ip=104.248.188.109; helo=alpha.anastas.io;
 envelope-from=shawn@anastas.io; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none)
 header.from=anastas.io
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=anastas.io header.i=@anastas.io header.b="jWXbsz+q"; 
 dkim-atps=neutral
Received: from alpha.anastas.io (alpha.anastas.io [104.248.188.109])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46P6xX2ZrvzDr1g
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Sep 2019 14:23:12 +1000 (AEST)
Received: from authenticated-user (alpha.anastas.io [104.248.188.109])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by alpha.anastas.io (Postfix) with ESMTPSA id 7047184B9D;
 Wed,  4 Sep 2019 23:22:38 -0500 (CDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=anastas.io; s=mail;
 t=1567657359; bh=EmICgee2nNUFVTp9r6uhX6GMoMfnTqEaFNlse3ssPuc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=jWXbsz+qQlJDwPgeEAudXQxT2TUqfzpY3dno5FjhVl+ySQe2k4YPNyAJiizFaGOW8
 30eusimYMGDWVV7N5VurXjBJTEyl9yrF8DKNx07OkJqUG2CdXRF3XRiveqkvL/Agu/
 R6S4+HhElHqIKVI/so6TWwk0f1gVazk4YZXazlJ55PF1irrgDOBWGOUXfsQIvvVwHJ
 7j3xsXfcQuaVRbQMPLQRFFCKtF3+qi+oI/7z5Fdxia2KRbzsq1y0cm4CcmwenSb1pV
 4P4WG4fVojFNGuUYaAN1N+DR6BxczBQEEjiY2rmffJyPKAxGrybqVtkVYodtVYRY/i
 SAbsgciFBr2aA==
From: Shawn Anastasio <shawn@anastas.io>
To: linux-pci@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/2] powerpc/pci: Fix IOMMU setup for hotplugged devices on
 pseries
Date: Wed,  4 Sep 2019 23:22:15 -0500
Message-Id: <20190905042215.3974-3-shawn@anastas.io>
In-Reply-To: <20190905042215.3974-1-shawn@anastas.io>
References: <20190905042215.3974-1-shawn@anastas.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: sbobroff@linux.ibm.com, aik@ozlabs.ru, oohall@gmail.com,
 bhelgaas@google.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Move PCI device setup from pcibios_add_device() to pcibios_fixup_dev().
This ensures that platform-specific DMA and IOMMU setup occurs after the
device has been registered in sysfs, which is a requirement for IOMMU group
assignment to work.

This fixes IOMMU group assignment for hotplugged devices on pseries, where
the existing behavior results in IOMMU assignment before registration.

Signed-off-by: Shawn Anastasio <shawn@anastas.io>
---
 arch/powerpc/kernel/pci-common.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index f627e15bb43c..21b4761bb0ed 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -987,15 +987,14 @@ static void pcibios_setup_device(struct pci_dev *dev)
 		ppc_md.pci_irq_fixup(dev);
 }
 
-int pcibios_add_device(struct pci_dev *dev)
+void pcibios_fixup_dev(struct pci_dev *dev)
 {
-	/*
-	 * We can only call pcibios_setup_device() after bus setup is complete,
-	 * since some of the platform specific DMA setup code depends on it.
-	 */
-	if (dev->bus->is_added)
-		pcibios_setup_device(dev);
+	/* Device is registered in sysfs and ready to be set up */
+	pcibios_setup_device(dev);
+}
 
+int pcibios_add_device(struct pci_dev *dev)
+{
 #ifdef CONFIG_PCI_IOV
 	if (ppc_md.pcibios_fixup_sriov)
 		ppc_md.pcibios_fixup_sriov(dev);
-- 
2.20.1

