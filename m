Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tSVYC1ZDmzDw58
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 15:14:05 +1100 (AEDT)
Subject: [PATCH v4 0/7] Disable VF's memory space on updating IOV BARs
From: Bjorn Helgaas <bhelgaas@google.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: clsoto@us.ibm.com, benh@kernel.crashing.org, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
Date: Mon, 28 Nov 2016 22:13:41 -0600
Message-ID: <20161129035218.21453.93986.stgit@bhelgaas-glaptop.roam.corp.google.com>
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

This is a v4 of Gavin's series for handling VF BAR updates.  The
important piece is the first patch ("PCI: Do any VF BAR updates before
enabling the BARs").  That makes sure that if we update VF BARs, we do
it before enabling the VFs, and that is unchanged from v3.

The second patch in Gavin's series ("PCI: Disable VF's memory space on
updating IOV BAR in pci_update_resource()") temporarily disabled VF
memory space during an update.  Since the first patch does the update
before enabling VFs, this case shouldn't happen in practice.

But even if we want to update a VF BAR while VF memory space is
enabled, I think temporarily disabling it is wrong.  So I replaced
the second patch with a few patches that make that such an update
fail.

Please comment.  These are on my pci/virtualization branch.

Changelog
=========
v4:
  * Don't disable VF's memory space when IOV BARs are updated; fail the
    update instead. 
  * Split IOV BAR updates from standard BAR updates so IOV updates can go
    in pci/iov.c.
  * Remove pci_resource_bar() and pci_iov_resource_bar() (the relevant
    code is simpler when inlined into the callers).
  * Cleanup IORESOURCE_ROM_ENABLE usage.
  * Add comments about why ROMs are updated differently.
v3:
  * Disable VF's memory space when IOV BARs are updated in
    pcibios_sriov_enable().
v2:
  * Added one patch calling pcibios_sriov_enable() before the VF
    and VF BARs are enabled.

---

Bjorn Helgaas (6):
      PCI: Ignore BAR updates on virtual functions
      PCI: Separate VF BAR updates from standard BAR updates
      PCI: Don't update VF BARs while VF memory space is enabled
      PCI: Remove pci_resource_bar() and pci_iov_resource_bar()
      PCI: Decouple IORESOURCE_ROM_ENABLE and PCI_ROM_ADDRESS_ENABLE
      PCI: Add comments about ROM BAR updating

Gavin Shan (1):
      PCI: Do any VF BAR updates before enabling the BARs


 drivers/pci/iov.c       |   69 +++++++++++++++++++++++++++++++++++++----------
 drivers/pci/pci.c       |   34 -----------------------
 drivers/pci/pci.h       |    7 +----
 drivers/pci/probe.c     |    3 +-
 drivers/pci/rom.c       |    5 +++
 drivers/pci/setup-res.c |   37 ++++++++++++++++++-------
 6 files changed, 88 insertions(+), 67 deletions(-)
