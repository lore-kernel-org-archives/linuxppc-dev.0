Return-Path: <linuxppc-dev+bounces-22086-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83241CD6E75
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Jun 2026 02:17:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gWlSd1FLwz3bpP;
	Fri, 05 Jun 2026 12:17:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1030"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780585330;
	cv=none; b=OJPeBbXKcYnxQ4G+BwITwBVqAT3cXEanjyLEHirld7ynSZ8tGTRpkDenG8vObLhR24LNMvkZNSJShFF2q15t6f0nvfMb8592BjhjJmxsbfkj+5hStneeosn+rNvTk4dBCJkr35CXJz8A6o3tVJ9ml8UMrehd2fD1Ox2N4wzojCyfoIYlZdC4cUkJEAcyacWWuZ5oMgaBxxHG6GAaiZ16r8u1+VaO99NNJHzKQkgQEWzU6pb3qAHmryi/7b7xrJFiYLa37IolKYUg38HjjXQUEr+dIHX/+i3oH6YmKUHyJVQpgKYgQogSxMLPPXqq3ocw1+cSC9/RqByiR/f2hhkDjw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780585330; c=relaxed/relaxed;
	bh=xaX3iBh5aQ6ieP4wRDACjZGRgQdbq9tB2uoE6aInkl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iUrJlRKx81IpVnemLlpxV1+1h4Qajq6p50SgA1PkdD5XlRo2QoYUC+qP2QOqgsLXEaYVPlX04f9I71B5tQsFEMQzYv+GPdwYe8XQy/DYPm6S6Es1w5Yf6K+gUu/jHA2ia9PHrcJryfAGOX8yqd9wVEOvF/WH8y1V0cKOmlxOkhbViII4xbNkMqGjR6CDpwhKP9gMq7qVzWSUCVWOYTUSX3ZLB/a1Bh9W7gGCqtxwm9A47BxWONky8PfdPIs6DFBh7Au8KT5M/YSvCQ8FKEUTUHnQVrv2ibLyp2S985Gr82aRqhZ5zNrx6DEPF5dqu29sIaGLvTsPo6FmM/ZXBF/v3A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iIfj5R9A; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1030; helo=mail-pj1-x1030.google.com; envelope-from=dimitri.daskalakis1@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iIfj5R9A;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1030; helo=mail-pj1-x1030.google.com; envelope-from=dimitri.daskalakis1@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gWSTW3YTWz2yT0
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Jun 2026 01:02:06 +1000 (AEST)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-36bcf3d2565so605215a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Jun 2026 08:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780585325; x=1781190125; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xaX3iBh5aQ6ieP4wRDACjZGRgQdbq9tB2uoE6aInkl8=;
        b=iIfj5R9AxbWslPBZC7BGE0UVAmZchpWq1/PJK6otaw90zBaZOzKS9yZy35B1Ex1zRc
         UYkfstqIMgB2BpkQFykqGOs4nMnWOjooIi2+AG0bY2O4un/qJ9RpT5F5L0lViTDDYCYU
         xuzy0iyJwxju4mkUc9GloXHs0E+vWB8NPXCX7fFYwEcYITvJVCK9TNn99xbF9NH8ms1y
         BkkmMxfnjJtTyoinS+vcvHoZWqzsKLKOI5W4e2IK6yXlnI+tP/V345wktcKSpracpHZw
         Wziy0tr/284VdNwc3bsphEFIZwjr+EuHaPIL0rZC0bB+I4Ig278Eb8cuVh8CL+IOzFL7
         CGKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780585325; x=1781190125;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xaX3iBh5aQ6ieP4wRDACjZGRgQdbq9tB2uoE6aInkl8=;
        b=cCrLCQTeTQwRI917lMWCXleSicwCWY9wVe//gnvsPM3ANFm3hycvgSl41jW3tnGzZ9
         hMiTNEX3d28bKkUSzj0UdgyJALmmUcSdhSTZbwh0ICVy5/RloRmckogXWsBSEdYtUVUI
         f64HUjoOUZq7f3TSq0pa/OvK20sGsykQv7EAMz8VAurm52ejt4X5e5Q2el09BaD1Zs6c
         uXHUH7TZyfzSvEjxvk+RswpTa/TSFdaVYd/u97T3awCXqOT3DxTL82YOh8NytzZSJeu2
         Ek8iTErngFPJTk6OfB+kRW3Ut7whye17tLPiASDD4iXfPjAy9x8KshMYrnVfuhqK5P+r
         GXTA==
X-Forwarded-Encrypted: i=1; AFNElJ+L35b3221heuYck/Fe0w4V4Ln5HhxXN83jMvKOTkSEIcjeisP4xuqxVPVBuNvvVH3hcnV/czAapmtd6O8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzJ0jN1Ubwae5eh4VN0ITISImXCo5qzZpNZhvE6Yp7tk30h3mX0
	QFQSt/gZfy0pkmXOzksxOw3+I0v0T8HSMWBpWWkxEny7KSoLOqeoY7Jp
X-Gm-Gg: Acq92OF3yuE3a7BVcFd2qRGuCOx+ePCJgI7qsxkLOan6t/PbbB80faYlFdd0g2ltip5
	kOtqc2bAd39P2JDUwsKJntiLaHdapcFWcE9dhSP1i/2GKUn4Cl3vIu61hE3KdAk7yAqrS6n/YWC
	DaB1WyhgZMIq6PBmd8z6SR/hBdW+I0KW/bPiLOkgc9S/JzfbHcj9W7j0h/QkCCG+Hf3Kdeiot91
	SjYb5/P7/ov7ZbmGCzvtar8o8ieTAJqiKfKLDZO3JcXjKWlklMMy5d/5fKPfmV/UAGDzzMV3CX1
	bYXnZh1gJkJlOqYy9AY0cn8kXeJEF86pOpR8GcSmxQ0zJXSekIzndoZseBeN/YNK2D66GGDWFoC
	VL/BLhyscxMqPJosVX6Pcyra9qC5vlQtL3KTFUspKbFQG654H13hgI+z9Wd/g0s5WZnifN5Qf3L
	M7EWo5zI/+K74O5ru+DaE5uzJS8zMpMOA2BdSGu1c=
X-Received: by 2002:a17:90b:3bc4:b0:36a:1ed8:6fe6 with SMTP id 98e67ed59e1d1-36e332f7e45mr8166646a91.24.1780585324132;
        Thu, 04 Jun 2026 08:02:04 -0700 (PDT)
Received: from localhost ([2a03:2880:7ff:41::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f6d109dcdsm4398717a91.9.2026.06.04.08.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 08:02:03 -0700 (PDT)
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
Subject: [RFC 06/12] PCI: Convert vfio_pci_core.c to pci_is_sriov_* helpers
Date: Thu,  4 Jun 2026 08:01:47 -0700
Message-ID: <20260604150153.3619662-7-dimitri.daskalakis1@gmail.com>
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

No functional changes.

Assisted-by: Claude:claude-opus-4.7
Signed-off-by: Dimitri Daskalakis <daskald@meta.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 3f8d093aacf8..ad8069612cb2 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1856,7 +1856,7 @@ int vfio_pci_core_match_token_uuid(struct vfio_device *core_vdev,
 	 *
 	 * If the VF token is provided but unused, an error is generated.
 	 */
-	if (vdev->pdev->is_virtfn) {
+	if (pci_is_sriov_virtfn(vdev->pdev)) {
 		struct vfio_pci_core_device *pf_vdev = vdev->sriov_pf_core_dev;
 		bool match;
 
@@ -1979,13 +1979,13 @@ static int vfio_pci_bus_notifier(struct notifier_block *nb,
 	struct pci_dev *physfn = pci_physfn(pdev);
 
 	if (action == BUS_NOTIFY_ADD_DEVICE &&
-	    pdev->is_virtfn && physfn == vdev->pdev) {
+	    pci_is_sriov_virtfn(pdev) && physfn == vdev->pdev) {
 		pci_info(vdev->pdev, "Captured SR-IOV VF %s driver_override\n",
 			 pci_name(pdev));
 		WARN_ON(device_set_driver_override(&pdev->dev,
 						   vdev->vdev.ops->name));
 	} else if (action == BUS_NOTIFY_BOUND_DRIVER &&
-		   pdev->is_virtfn && physfn == vdev->pdev) {
+		   pci_is_sriov_virtfn(pdev) && physfn == vdev->pdev) {
 		struct pci_driver *drv = pci_dev_driver(pdev);
 
 		if (drv && drv != pci_dev_driver(vdev->pdev))
@@ -2005,7 +2005,7 @@ static int vfio_pci_vf_init(struct vfio_pci_core_device *vdev)
 	struct pci_dev *physfn;
 	int ret;
 
-	if (pdev->is_virtfn) {
+	if (pci_is_sriov_virtfn(pdev)) {
 		/*
 		 * If this VF was created by our vfio_pci_core_sriov_configure()
 		 * then we can find the PF vfio_pci_core_device now, and due to
@@ -2025,7 +2025,7 @@ static int vfio_pci_vf_init(struct vfio_pci_core_device *vdev)
 	}
 
 	/* Not a SRIOV PF */
-	if (!pdev->is_physfn)
+	if (!pci_is_sriov_physfn(pdev))
 		return 0;
 
 	vdev->vf_token = kzalloc_obj(*vdev->vf_token);
@@ -2166,7 +2166,7 @@ int vfio_pci_core_register_device(struct vfio_pci_core_device *vdev)
 		return -EBUSY;
 	}
 
-	if (pci_is_root_bus(pdev->bus) || pdev->is_virtfn) {
+	if (pci_is_root_bus(pdev->bus) || pci_is_sriov_virtfn(pdev)) {
 		ret = vfio_assign_device_set(&vdev->vdev, vdev);
 	} else if (!pci_probe_reset_slot(pdev->slot)) {
 		ret = vfio_assign_device_set(&vdev->vdev, pdev->slot);
-- 
2.52.0


