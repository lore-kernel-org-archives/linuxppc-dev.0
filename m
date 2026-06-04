Return-Path: <linuxppc-dev+bounces-22080-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AFA3CD6E6E
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Jun 2026 02:15:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gWlQk5s76z2xjN;
	Fri, 05 Jun 2026 12:15:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780585321;
	cv=none; b=fZPI+YTqtXXhRKppQXiGXRsxYS8TIL8240YdXhRbfFmJtMZLlgpHKyQrsbrdgaBhwwfu1yrugybJMCstCOpXVAh0+6fOWGwa8pIxvJbyuyuHjBbcMAIMN4IzQ2WyS1+I5rmHYDAXsbNuBz9gB5zoLOcAqkY9s/xu835pyH+fJH95le4AauQBTkNikp09VRVf/NDJTCYqDhsZE0Uc7vphDRRp6NXpA+IvJWNCg8GxMKdaCn6zeo8GgkGfefF1tIPcJeSB4tuSJi6kedVOnlq99zL8GA0IZ22/ezPu4qq/BJwLJ+WF5C+oWNtRlo+auZYbq9Rk3TapgX1UQHx2TxoYnA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780585321; c=relaxed/relaxed;
	bh=u02hzxNTDDgX0UOR1yiCb+UilA+qxlSoulScblTnv2M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B7R43EaTLmNalzGCkkUP9D90OP2UiyVFBOCchdW72CKZPRlKncI+1vrXRHJYKHh8Kgo7AYzjdQSyBAfSeHbVgpGB3FQWv+5qMZP/jgc2A4kn1My4w9Mf4cDIDsv/vCdsRsDTYmgSDyj2iuiiBaG8uhXOU3RmPyuicpIJGxbdzQLoFDaGkHHWD4CmAebJGz0vUytifOO3YPWqbZsQLHVdL+2jgayvpncdglTIedKKVCrIVmoqh9qgft3CPGDxALWbrZ5wTyBPDANAyJhxUx4/yq3FLWu9FRBPUpCVvfDgAteh4fg+CPXdw16D2PSVr2nW8/g8SpjuQ+KW3ZsOdBON+w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LuY8Qmva; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com; envelope-from=dimitri.daskalakis1@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LuY8Qmva;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com; envelope-from=dimitri.daskalakis1@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gWSTM2rLnz2xk7
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Jun 2026 01:01:58 +1000 (AEST)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-36bd175fdbaso570137a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Jun 2026 08:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780585316; x=1781190116; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u02hzxNTDDgX0UOR1yiCb+UilA+qxlSoulScblTnv2M=;
        b=LuY8Qmvand0a7qCkCGmFgW8RDVecXBI/bJiaZgIqceFQiw7i1+s8gJwYkkfqoa4uDt
         5dyiuqedEry4BIqKxDziF4cuVn0iXJtUIi3hEQX/raQV7ivF2ESYJp+7uteQkgFOGoBw
         o9LmToMSD71tBrDd8KPG3gJ6QQ4KhUX6s0YburLJ9Gvh6tzypbL6Udba7Pcyg3AIcQfd
         NY2j7c5+qdfxsvzEtRFwLLjot86W1XHoYlT6arZhHavdfLAKpiFnRBfUjRZ5mYOJA8FC
         yP3+yewq6rrIhwgnZZO0gMva53K46s+8omi8j2waOkXGJaN2wTm85Ujs/SL98lxnTMtR
         2ECQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780585316; x=1781190116;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u02hzxNTDDgX0UOR1yiCb+UilA+qxlSoulScblTnv2M=;
        b=RvxxoYhxCPzVd7DBZmdr7ngC9Oqps4+3Ry2odwy9Eo9VPQOWWDUyG6a+tc1kFZztcp
         zUkGnA2yqcdZ+c/9OKNaS9bnrhbLp9eNvt9+Mh3b3wXae8SuI0oaphRENRuODDMLNsiM
         PB0Z4mBHAlrh6jtZvT0l+FGGnhOBJWXL1kRsyIcOTMcHgcQufm2rH6Nb9F1C+7r7QIV5
         BRcua2/Q5EKIxIS8hPvFW+jtplEVia2TbiWYi7C/69kzKubmqGSU/6Kn2+JG5LJXWhni
         kgfZfRIcQdLo1MJMghWDZ6VDPpcqfrdl8rs+VAR6fR5Fn2Yfg+gWP01xugfIZbspMkZs
         27ww==
X-Forwarded-Encrypted: i=1; AFNElJ8RCVksyhFlacOCLqgUuQXFJ4N9wA86cPv7wwZpdZ3jT6/g4d5bI3aQ6EQHxP1ZFg3o7ZL3jSPeBUA9log=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxuFsy31mm6GldKbN5lnzt8sZZb30WbIxPXmp34qupgFF7n7tMi
	ukFkAwnAfuFhcMcgwB/OTLxoU5FeGeI2OvGRamv7g8nty0qaPSK5rcpp
X-Gm-Gg: Acq92OG/8PTmItq5Zu7wKNB/Xi24FuwCIXzGkLHjJK0JxWbNr/4MOvQ9biWGCJSWp7+
	IDRlk5z4zB9Vnku8JdLm0qJaDeWSV2yRmvuUwqEKE0K3550Lt0rIUnDqCQojAALDHNJ2k3WitR7
	o9Dg46MfHtA6qJZHGIMMcexySB6ZfZXpOOoqowIGtrDEq6ClyOIiFz+ni8g9a1HKekpRM2D19Nh
	wuILn0eF0A5ehIcoT2cwHm4buffHHMy6Mp6a9H5jGJZXQu0fs6JL8EODMdX/Qs9x3PF+YTGLAja
	32Tgu285WjtBSLzb0Y44D1UFIG6QnG0f+bIFtYxn4QhQf0uLNW19jsKH4eCJNOL63GLUSizpAyV
	eCf1WHUrWmzVq8qbX1ruBnuiPq17Nr0SrZTk2c9mztneUAYqgaeDcLiIXJ3Zg+cjL2BN/19ZDJg
	OKTbsf3FIetAc4K407FG1stmGn1gKcSBUcNnDVGRa1fJ2JjJ6a
X-Received: by 2002:a17:90b:2d8d:b0:36b:e8b9:46a4 with SMTP id 98e67ed59e1d1-36e32285cf3mr8241830a91.14.1780585315438;
        Thu, 04 Jun 2026 08:01:55 -0700 (PDT)
Received: from localhost ([2a03:2880:7ff:4f::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df0be0f0sm5020782a12.30.2026.06.04.08.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 08:01:54 -0700 (PDT)
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
Subject: [RFC 00/12] PCI: Add support for Scalable I/O Virtualization
Date: Thu,  4 Jun 2026 08:01:41 -0700
Message-ID: <20260604150153.3619662-1-dimitri.daskalakis1@gmail.com>
X-Mailer: git-send-email 2.52.0
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

Scalable I/O Virtualization (SIOV) is the next-generation alternative
to SR-IOV. The goal of SIOV is to support more virtual devices than SR-IOV
can currently support, while relaxing many of the HW requirements of SR-IOV.

SIOV VFs are referred to as Scalable Device Interfaces (SDI). An SDI has
a unique PCIe Routing ID (RID), but has no configuration space, BAR,
or MSI-X table.

An overview can be found here:
https://pcisig.com/PCIExpress/ECN/Base/ScalableIOVirtualization

Since SDIs lack HW support, the complexity will fall on software
(hypervisors, vmms, drivers, and/or firmware) to provide the same isolation
guarantees for SIOV that SR-IOV has today.

This patch series is one step in that direction, allowing the PCI subsystem
to discover the SIOV capability during enumeration. This was the minimum set
of changes needed so I could test the SIOV feature of developmental HW in
emulation. I have not tested a device that supports both SR-IOV and SIOV,
but this combination is allowed per the spec.

SIOV has two ways to assign RIDs, strided (like SR-IOV) or software assigned.
To support software RID assignment, you need to compute the RID allowlist
after all PCI devices have been enumerated. I've deferred this complexity
for now and only implemented strided RID assignment.

Patch 1 adds helpers to identify if a PF/VF is a SR-IOV PF/VF. The PF and
VF bits within struct pci_dev should be agnostic of virtualization type.
The helper uses the current logic which assumes any PF/VF is SR-IOV.

Patch 2-7 uses the new helpers throughout core. I didn't convert certain
device drivers (drivers/net, drivers/gpu) because the devices will not
suddenly start advertising the SIOV capability. These can be updated in
the future if desired.

Patch 8 tightens the helpers introduced in patch 1 with a new is_sriov bit.

Patch 9 is a small refactor for computing VF RID which can be shared
between SR-IOV and SIOV.

Patch 10-12 add SIOV definitions, capability detection, and bus reservation.

With this patchset core enumarates the SIOV capability and can identify
SIOV PFs. But there is no central mechanism to allocate/manage SIOV VFs.
To support device pass through, devices will need to add a vfio-mdev
driver with IOMMUFD support (or something similar).

Dimitri Daskalakis (12):
  PCI: Add helpers to identify SR-IOV PFs/VFs.
  PCI: Convert iov.c to pci_is_sriov_* helpers
  PCI: Convert pci.h to pci_is_sriov_* helpers
  PCI: Convert arch/powerpc to pci_is_sriov_* helpers
  PCI: Convert s390/pci/pci.c to pci_is_sriov_* helpers
  PCI: Convert vfio_pci_core.c to pci_is_sriov_* helpers
  PCI: Convert xen-pciback and pci-driver to pci_is_sriov_* helpers
  PCI: Add is_sriov bit to struct pci_dev
  PCI: Add helper to compute VF Routing ID to pci.h
  PCI: Add Scalable I/O Virtualization data structure definitions
  PCI: Initialize and release SIOV capability
  PCI: Reserve bus range for SIOV devices

 arch/powerpc/kernel/pci_dn.c                 |   4 +-
 arch/powerpc/platforms/powernv/pci-ioda.c    |   6 +-
 arch/powerpc/platforms/powernv/pci-sriov.c   |  10 +-
 arch/powerpc/platforms/pseries/eeh_pseries.c |   8 +-
 arch/powerpc/platforms/pseries/setup.c       |   4 +-
 arch/s390/pci/pci.c                          |   2 +-
 arch/s390/pci/pci_iov.c                      |   1 +
 drivers/pci/Kconfig                          |  11 ++
 drivers/pci/Makefile                         |   1 +
 drivers/pci/iov.c                            |  58 ++++----
 drivers/pci/pci-driver.c                     |   4 +-
 drivers/pci/pci.h                            |  43 +++++-
 drivers/pci/probe.c                          |   6 +-
 drivers/pci/siov.c                           | 134 +++++++++++++++++++
 drivers/vfio/pci/vfio_pci_core.c             |  12 +-
 drivers/xen/xen-pciback/pci_stub.c           |   2 +-
 include/linux/pci.h                          |  29 +++-
 include/uapi/linux/pci_regs.h                |  12 +-
 18 files changed, 289 insertions(+), 58 deletions(-)
 create mode 100644 drivers/pci/siov.c

-- 
2.52.0


