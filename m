Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w6M5p48fdzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Apr 2017 07:36:30 +1000 (AEST)
Subject: [PATCH v11 0/7] PCI: Introduce a way to enforce all MMIO BARs not
 to share PAGE_SIZE
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yongji Xie <elohimes@gmail.com>
Cc: zhong@linux.vnet.ibm.com, Alexey Kardashevskiy <aik@ozlabs.ru>,
 linux-pci@vger.kernel.org, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
Date: Mon, 17 Apr 2017 16:36:25 -0500
Message-ID: <20170417212705.21092.90222.stgit@bhelgaas-glaptop.roam.corp.google.com>
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

This is another iteration on Yongji's series to force MMIO BARs not to
share pages, which allows direct passthrough instead of QEMU emulation.

The only things I really changed were to add some comments and factor out
the code that requests resize.  I also pulled in the IOV patch, which
touches the same code but was posted separately.

These are all on my pci/resource branch, and if all goes well, I plan to
merge these for v4.12.

Changelog v11:
- Include patch to ignore IOV alignment
- Add patches to factor out realignment
- Add comment about "resize" usage
---

Bjorn Helgaas (2):
      PCI: Factor pci_reassigndev_resource_alignment()
      PCI: Don't reassign resources that are already aligned

Yongji Xie (5):
      PCI: Ignore requested alignment for IOV BARs
      PCI: A fix for caculating bridge window's size and alignment
      PCI: Add pcibios_default_alignment() for arch-specific alignment control
      powerpc/powernv: Override pcibios_default_alignment() to force PCI devices to be page aligned
      PCI: Don't resize resources when realigning all devices in system


 arch/powerpc/include/asm/machdep.h        |    2 +
 arch/powerpc/kernel/pci-common.c          |    8 ++
 arch/powerpc/platforms/powernv/pci-ioda.c |    7 ++
 drivers/pci/pci.c                         |  106 ++++++++++++++++++++++-------
 drivers/pci/setup-bus.c                   |    4 +
 5 files changed, 100 insertions(+), 27 deletions(-)
