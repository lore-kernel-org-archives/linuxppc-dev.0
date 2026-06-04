Return-Path: <linuxppc-dev+bounces-22084-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02E16CD6E6E
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Jun 2026 02:17:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gWlSN5L4Cz2xll;
	Fri, 05 Jun 2026 12:17:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780585325;
	cv=none; b=iDMyrFugQCJLOkjKJCMcGUrsU6+/yYM/evYIw969i6UXRWZZklbvJDUduRx9DeNRWvnzmlUij1h7qVcv5f1XNMllzOleuWIulnA63EVsq5wnQzkFmnGoVJ4jTIh8WLSQ5dfAbN3yjibbrz4Zopyfsn4Iu4KRpW497bROUNIXXWkF0nTyWVcYFXKgYAMUtx8GlzjM3BznDTiQo6D5qY2r6OzsWeQiD7Xsqd1M9UmTro4arTPc0cPxHf8NJBKgJBktG7DD7uYW+61rpWXrkhv7btkaiuE29kgsxQ58BIwwwVwX6BgNM04sI8dmDS0h0lRj4W4Swqh4yU1O5wyphhBYtA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780585325; c=relaxed/relaxed;
	bh=4avmxi/DteAkFA5/0YsT4Z/7bVnyoihvSIvhh9yQxIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PVEkL7PgQ4wuMOO8Dr9EV2b2GL9oiRSJNwYuoY7Iw6XWtmKYztXQKut2hLmX0MDcwtJMIwkhqagtgULDwXmFMSVt2jaxOn1Ba2CN/VqukR/llZSQA4Ai4hb/yCSyFPsXSdIGe1zkbg8rfO4qa6ffBkxMrjUR+v5dnvaY0AB1ZpanWW4WZ9+s447XEP5V/lCHKMCPNQ55MLlJLT49gkbJm/21YvQvMtxFI+GDr/kgTXc2i8i/3STRdY934oRw7uM6AvCrIuvwLxQO0CwmdStrC4S2EJMIkXSnJy4rEBPS4iY1orSSslZ/WTw6PJfmykr3nRXeXz1+OOl7rK8y5espqg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GT1kC5iP; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=dimitri.daskalakis1@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GT1kC5iP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=dimitri.daskalakis1@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gWSTS4HjGz2xk7
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Jun 2026 01:02:04 +1000 (AEST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-2bf2e8ccca1so6546325ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Jun 2026 08:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780585322; x=1781190122; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4avmxi/DteAkFA5/0YsT4Z/7bVnyoihvSIvhh9yQxIo=;
        b=GT1kC5iPXnrkC9CCgNP7f0/U5MlRyGWvHvZ8ze7HsNDPi+xJqaY+fr5Q4gCtMk6FSH
         GO1b6p2YNSB6vGHmUHEpHC6T74kyoPyzCY6Iq4CIXdamrBjATv6Tni65qq+YKRFe83lb
         UD53k11dxXSdK0x9/BVYbU3Lo+yrA3xV+3e7Clqp2GuJGbXo2xr+BJMjxx8TQ3DvuOps
         S9seHUl8Ls5sFc4p5byydFMvIE7GpSnSGW5oCwJHW4lslhoVe62P4RBPMeRgzkuwEFKT
         cvWDVJULiu1nU9X+6FAgEHFYvff7sRhO+UQTJVhbup1EQYiaXay1sn29lFvUYMZdslI0
         PsvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780585322; x=1781190122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4avmxi/DteAkFA5/0YsT4Z/7bVnyoihvSIvhh9yQxIo=;
        b=tFO/ReuupFGE7is/+2ogoiFlBPthecyp8egjQtxt3xrgtqslXbcbyPOLvFFuTM2MCC
         Za5oLjbVFypWjzq5Tzt1qYEVoOQaXjp9vV4RW9BD77cltbvylWHi1roeG9ouK/iaw6tb
         40ulEfvgnzVxFnhtLxwTxWB4rVxxstgXW0Y4ElpfxgICXI81EBklbQh0soriq1RWl/UB
         3ir48KSGopT2A++LxLxnalH7JEeFKQoPTyQfMAbKI2nZM43Iq8+MpnXT3P8gbK2YZxO2
         RmOir/GwPErnKnhZCEDeCIZZFf/HI8BVOeq0/NytvZREEZ75ZCTSwlcH47gwCz3rj/P4
         /DRQ==
X-Forwarded-Encrypted: i=1; AFNElJ/mb6D0BBjZFDD4pz1YanbxtmUnQ/qAJ3xX3Iu1OXcDMAED7nMXhw6BS9gy3c11OgPinOr0l7m2QzUOb/M=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzcZCx5rETRg/13WrkzUDhqvEV4GfvXxBfqwipWbcuu1Bcp5gg1
	DymWacP/8U0qz2jMeBFCoeZBWGx0F9Z2vLma0+jUt7jgmEgpaPJHEOO5
X-Gm-Gg: Acq92OEfgS9Weavfms6KnXbPUW4dLwNMVDZ/9qbBFaWA0eKjmNzoNRS2H8tKV+rbg5C
	oQ0PePLXQL7YSWsvjRm9HrnJvy4Rdu8HpE7Owp32FKeRTVxRXhEuw+zoWhKsFokYfo94ozn1dEL
	zIKI4C7LvBlOBVngnapJccwY2bdgPliAY93QwlK07BuPGKDJj62PsR/ITvFZMVK1ZnUCjkZ+ccM
	gjSZIAZMhVVCusof2LK3Jtbm0vq86/fDKShjxQV28WMmk87LunrpLl1tzyU0tOkRPJl+N6EzkpJ
	Y3jNoVafTzH9Nj5Djmpv49fR8Ues41NTPGf5aseYY78r5q1aXXWOqKCA1NhJFd6Mzfxym2YjlnT
	udBt8QUIRlCsawKt/gl+akzXy9pNkMH23JAbS/FTGnb+x43kK4SwUnGIRbZHkB7+gUPVuJl2o7G
	bjrIkRM+NA+3B8puL2aGpqJDu0kHBKUQoA4Qp04xY=
X-Received: by 2002:a17:903:37c4:b0:2b4:59bf:5728 with SMTP id d9443c01a7336-2c1644ca7bfmr89624145ad.25.1780585321320;
        Thu, 04 Jun 2026 08:02:01 -0700 (PDT)
Received: from localhost ([2a03:2880:7ff:55::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6e2adsm67111415ad.5.2026.06.04.08.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 08:02:00 -0700 (PDT)
From: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Alex Williamson <alex@shazbot.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Ankit Agrawal <ankita@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Keith Busch <kbusch@kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Dimitri Daskalakis <daskald@meta.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	kvm@vger.kernel.org,
	xen-devel@lists.xenproject.org
Subject: [RFC 04/12] PCI: Convert arch/powerpc to pci_is_sriov_* helpers
Date: Thu,  4 Jun 2026 08:01:45 -0700
Message-ID: <20260604150153.3619662-5-dimitri.daskalakis1@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260604150153.3619662-1-dimitri.daskalakis1@gmail.com>
References: <20260604150153.3619662-1-dimitri.daskalakis1@gmail.com>
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
Content-Transfer-Encoding: 8bit

From: Dimitri Daskalakis <daskald@meta.com>

Convert SR-IOV-specific is_physfn / is_virtfn reads in the PowerPC
PCI code to use pci_is_sriov_physfn() / pci_is_sriov_virtfn(). These
call sites are all SR-IOV-specific: they guard SR-IOV state
dereferences, VF PE management, or sit inside #ifdef CONFIG_PCI_IOV
blocks. Converting them keeps SR-IOV semantics intact once is_physfn
and is_virtfn widen to cover any virtualization type.

Files touched:
  arch/powerpc/kernel/pci_dn.c
  arch/powerpc/platforms/powernv/pci-ioda.c
  arch/powerpc/platforms/powernv/pci-sriov.c
  arch/powerpc/platforms/pseries/eeh_pseries.c
  arch/powerpc/platforms/pseries/setup.c

No functional changes.

Assisted-by: Claude:claude-opus-4.7
Signed-off-by: Dimitri Daskalakis <daskald@meta.com>
---
 arch/powerpc/kernel/pci_dn.c                 |  4 ++--
 arch/powerpc/platforms/powernv/pci-ioda.c    |  6 +++---
 arch/powerpc/platforms/powernv/pci-sriov.c   | 10 +++++-----
 arch/powerpc/platforms/pseries/eeh_pseries.c |  8 ++++----
 arch/powerpc/platforms/pseries/setup.c       |  4 ++--
 5 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn.c
index a7b664befed2..cf44ec368a36 100644
--- a/arch/powerpc/kernel/pci_dn.c
+++ b/arch/powerpc/kernel/pci_dn.c
@@ -176,7 +176,7 @@ struct pci_dn *add_sriov_vf_pdns(struct pci_dev *pdev)
 	int i;
 
 	/* Only support IOV for now */
-	if (WARN_ON(!pdev->is_physfn))
+	if (WARN_ON(!pci_is_sriov_physfn(pdev)))
 		return NULL;
 
 	/* Check if VFs have been populated */
@@ -221,7 +221,7 @@ void remove_sriov_vf_pdns(struct pci_dev *pdev)
 	int i;
 
 	/* Only support IOV PF for now */
-	if (WARN_ON(!pdev->is_physfn))
+	if (WARN_ON(!pci_is_sriov_physfn(pdev)))
 		return;
 
 	/* Check if VFs have been populated */
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 32ecbc46e74b..63eacc8001fe 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -987,7 +987,7 @@ static void pnv_pci_ioda_dma_dev_setup(struct pci_dev *pdev)
 	pe = pnv_pci_bdfn_to_pe(phb, pci_dev_id(pdev));
 	if (!pe) {
 		/* VF PEs should be pre-configured in pnv_pci_sriov_enable() */
-		if (WARN_ON(pdev->is_virtfn))
+		if (WARN_ON(pci_is_sriov_virtfn(pdev)))
 			return;
 
 		pnv_pci_configure_bus(pdev->bus);
@@ -2379,7 +2379,7 @@ static void pnv_pci_release_device(struct pci_dev *pdev)
 	struct pnv_ioda_pe *pe;
 
 	/* The VF PE state is torn down when sriov_disable() is called */
-	if (pdev->is_virtfn)
+	if (pci_is_sriov_virtfn(pdev))
 		return;
 
 	if (!pdn || pdn->pe_number == IODA_INVALID_PE)
@@ -2391,7 +2391,7 @@ static void pnv_pci_release_device(struct pci_dev *pdev)
 	 * the iov state at probe time since we need to fiddle with the IOV
 	 * resources.
 	 */
-	if (pdev->is_physfn)
+	if (pci_is_sriov_physfn(pdev))
 		kfree(pdev->dev.archdata.iov_data);
 #endif
 
diff --git a/arch/powerpc/platforms/powernv/pci-sriov.c b/arch/powerpc/platforms/powernv/pci-sriov.c
index 7105a573aec4..1113488f4372 100644
--- a/arch/powerpc/platforms/powernv/pci-sriov.c
+++ b/arch/powerpc/platforms/powernv/pci-sriov.c
@@ -225,7 +225,7 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
 
 void pnv_pci_ioda_fixup_iov(struct pci_dev *pdev)
 {
-	if (pdev->is_virtfn) {
+	if (pci_is_sriov_virtfn(pdev)) {
 		struct pnv_ioda_pe *pe = pnv_ioda_get_pe(pdev);
 
 		/*
@@ -235,7 +235,7 @@ void pnv_pci_ioda_fixup_iov(struct pci_dev *pdev)
 		 */
 		pe->pdev = pdev;
 		WARN_ON(!(pe->flags & PNV_IODA_PE_VF));
-	} else if (pdev->is_physfn) {
+	} else if (pci_is_sriov_physfn(pdev)) {
 		/*
 		 * For PFs adjust their allocated IOV resources to match what
 		 * the PHB can support using its M64 BAR table.
@@ -479,7 +479,7 @@ static void pnv_ioda_release_vf_PE(struct pci_dev *pdev)
 
 	phb = pci_bus_to_pnvhb(pdev->bus);
 
-	if (!pdev->is_physfn)
+	if (!pci_is_sriov_physfn(pdev))
 		return;
 
 	/* FIXME: Use pnv_ioda_release_pe()? */
@@ -508,7 +508,7 @@ static int pnv_pci_vf_resource_shift(struct pci_dev *dev, int offset)
 	u16 num_vfs;
 	int i;
 
-	if (!dev->is_physfn)
+	if (!pci_is_sriov_physfn(dev))
 		return -EINVAL;
 	iov = pnv_iov_get(dev);
 
@@ -620,7 +620,7 @@ static void pnv_ioda_setup_vf_PE(struct pci_dev *pdev, u16 num_vfs)
 	struct pnv_iov_data   *iov;
 	struct pci_dn         *pdn;
 
-	if (!pdev->is_physfn)
+	if (!pci_is_sriov_physfn(pdev))
 		return;
 
 	phb = pci_bus_to_pnvhb(pdev->bus);
diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
index b12ef382fec7..32030ac9be51 100644
--- a/arch/powerpc/platforms/pseries/eeh_pseries.c
+++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
@@ -54,7 +54,7 @@ static void pseries_pcibios_bus_add_device(struct pci_dev *pdev)
 
 	dev_dbg(&pdev->dev, "EEH: Setting up device\n");
 #ifdef CONFIG_PCI_IOV
-	if (pdev->is_virtfn) {
+	if (pci_is_sriov_virtfn(pdev)) {
 		pdn->device_id  =  pdev->device;
 		pdn->vendor_id  =  pdev->vendor;
 		pdn->class_code =  pdev->class;
@@ -68,7 +68,7 @@ static void pseries_pcibios_bus_add_device(struct pci_dev *pdev)
 #endif
 	pseries_eeh_init_edev(pdn);
 #ifdef CONFIG_PCI_IOV
-	if (pdev->is_virtfn) {
+	if (pci_is_sriov_virtfn(pdev)) {
 		/*
 		 * FIXME: This really should be handled by choosing the right
 		 *        parent PE in pseries_eeh_init_edev().
@@ -731,7 +731,7 @@ static int pseries_call_allow_unfreeze(struct eeh_dev *edev)
 	if (!vf_pe_array)
 		return -ENOMEM;
 	if (pci_num_vf(edev->physfn ? edev->physfn : edev->pdev)) {
-		if (edev->pdev->is_physfn) {
+		if (pci_is_sriov_physfn(edev->pdev)) {
 			cur_vfs = pci_num_vf(edev->pdev);
 			pdn = eeh_dev_to_pdn(edev);
 			parent = pdn->parent;
@@ -779,7 +779,7 @@ static int pseries_notify_resume(struct eeh_dev *edev)
 	if (rtas_function_token(RTAS_FN_IBM_OPEN_SRIOV_ALLOW_UNFREEZE) == RTAS_UNKNOWN_SERVICE)
 		return -EINVAL;
 
-	if (edev->pdev->is_physfn || edev->pdev->is_virtfn)
+	if (pci_is_sriov_physfn(edev->pdev) || pci_is_sriov_virtfn(edev->pdev))
 		return pseries_call_allow_unfreeze(edev);
 
 	return 0;
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 50b26ed8432d..8165ae9adbd6 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -778,7 +778,7 @@ static void pseries_pci_fixup_iov_resources(struct pci_dev *pdev)
 	const int *indexes;
 	struct device_node *dn = pci_device_to_OF_node(pdev);
 
-	if (!pdev->is_physfn)
+	if (!pci_is_sriov_physfn(pdev))
 		return;
 	/*Firmware must support open sriov otherwise don't configure*/
 	indexes = of_get_property(dn, "ibm,open-sriov-vf-bar-info", NULL);
@@ -799,7 +799,7 @@ static resource_size_t pseries_pci_iov_resource_alignment(struct pci_dev *pdev,
 	if (!reg)
 		return pci_iov_resource_size(pdev, resno);
 
-	if (!pdev->is_physfn)
+	if (!pci_is_sriov_physfn(pdev))
 		return 0;
 	return pseries_get_iov_fw_value(pdev,
 					resno - PCI_IOV_RESOURCES,
-- 
2.52.0


