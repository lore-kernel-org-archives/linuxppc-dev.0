Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3svFmT044LzDsrd
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Oct 2016 00:57:28 +1100 (AEDT)
Subject: [PATCH v2 0/7] PCI: layerscape: Cleanups
To: Minghuan Lian <minghuan.Lian@freescale.com>,
 Mingkai Hu <mingkai.hu@freescale.com>, Roy Zang <tie-fei.zang@freescale.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Wed, 12 Oct 2016 08:57:22 -0500
Message-ID: <20161012135413.29815.75484.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

  - Add local "dev" pointers to reduce repetition of things like
    "&pdev->dev".

  - Remove platform drvdata because it appears unused (we called
    platform_set_drvdata() but not platform_get_drvdata()).

  - Remove redundant struct members.

  - Pass device-specific struct to internal functions for consistency.

  - Move struct pcie_port setup to probe function for consistency.

  - Remove unused ls_add_pcie_port() platform_device argument.

Nothing here should change the behavior of the driver.

Changes from v1:
  I dropped the following patch because it was a lot of churn for
  questionable benefit:
    PCI: layerscape: Name private struct pointer "ls" consistently

---

Bjorn Helgaas (7):
      PCI: layerscape: Add local struct device pointers
      PCI: layerscape: Remove unused platform data
      PCI: layerscape: Remove redundant struct ls_pcie.dbi
      PCI: layerscape: Pass device-specific struct to internal functions
      PCI: layerscape: Move struct pcie_port setup to probe function
      PCI: layerscape: Remove unused ls_add_pcie_port() platform_device arg
      PCI: layerscape: Reorder struct ls_pcie


 drivers/pci/host/pci-layerscape.c |   65 +++++++++++++++++++------------------
 1 file changed, 33 insertions(+), 32 deletions(-)
