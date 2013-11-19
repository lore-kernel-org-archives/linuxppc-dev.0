Return-Path: <Bharat.Bhushan@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe004.messaging.microsoft.com [216.32.180.187])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4C5EA2C0090
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Nov 2013 16:23:20 +1100 (EST)
From: Bharat Bhushan <r65777@freescale.com>
To: <alex.williamson@redhat.com>, <joro@8bytes.org>, <bhelgaas@google.com>,
 <agraf@suse.de>, <scottwood@freescale.com>, <stuart.yoder@freescale.com>,
 <iommu@lists.linux-foundation.org>, <linux-pci@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/9 v2] vfio-pci: add support for Freescale IOMMU (PAMU)
Date: Tue, 19 Nov 2013 10:47:04 +0530
Message-ID: <1384838233-24847-1-git-send-email-Bharat.Bhushan@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Bharat Bhushan <bharat.bhushan@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Bharat Bhushan <bharat.bhushan@freescale.com>

PAMU (FSL IOMMU) has a concept of primary window and subwindows.
Primary window corresponds to the complete guest iova address space
(including MSI space), with respect to IOMMU_API this is termed as
geometry. IOVA Base of subwindow is determined from the number of
subwindows (configurable using iommu API).
MSI I/O page must be within the geometry and maximum supported
subwindows, so MSI IO-page is setup just after guest memory iova space.

So patch 1/9-4/9(inclusive) are for defining the interface to get:
  - Number of MSI regions (which is number of MSI banks for powerpc)
  - MSI-region address range: Physical page which have the
    address/addresses used for generating MSI interrupt
    and size of the page.

Patch 5/9-7/9(inclusive) is defining the interface of setting up
MSI iova-base for a msi region(bank) for a device. so that when
msi-message will be composed then this configured iova will be used.
Earlier we were using iommu interface for getting the configured iova
which was not currect and Alex Williamson suggeested this type of interface.

patch 8/9 moves some common functions in a separate file so that these
can be used by FSL_PAMU implementation (next patch uses this).
These will be used later for iommu-none implementation. I believe we
can do more of this but will take step by step.

Finally last patch actually adds the support for FSL-PAMU :)

v1->v2
 - Added interface for setting msi iova for a msi region for a device.
   Earlier I added iommu interface for same but as per comment that is
   removed and now created a direct interface between vfio and msi.
 - Incorporated review comments (details is in individual patch)

Bharat Bhushan (9):
  pci:msi: add weak function for returning msi region info
  pci: msi: expose msi region information functions
  powerpc: pci: Add arch specific msi region interface
  powerpc: msi: Extend the msi region interface to get info from
    fsl_msi
  pci/msi: interface to set an iova for a msi region
  powerpc: pci: Extend msi iova page setup to arch specific
  pci: msi: Extend msi iova setting interface to powerpc arch
  vfio: moving some functions in common file
  vfio pci: Add vfio iommu implementation for FSL_PAMU

 arch/powerpc/include/asm/machdep.h |   10 +
 arch/powerpc/kernel/msi.c          |   28 +
 arch/powerpc/sysdev/fsl_msi.c      |  132 +++++-
 arch/powerpc/sysdev/fsl_msi.h      |   25 +-
 drivers/pci/msi.c                  |   35 ++
 drivers/vfio/Kconfig               |    6 +
 drivers/vfio/Makefile              |    5 +-
 drivers/vfio/vfio_iommu_common.c   |  227 ++++++++
 drivers/vfio/vfio_iommu_common.h   |   27 +
 drivers/vfio/vfio_iommu_fsl_pamu.c | 1003 ++++++++++++++++++++++++++++++++++++
 drivers/vfio/vfio_iommu_type1.c    |  206 +--------
 include/linux/msi.h                |   14 +
 include/linux/pci.h                |   21 +
 include/uapi/linux/vfio.h          |  100 ++++
 14 files changed, 1623 insertions(+), 216 deletions(-)
 create mode 100644 drivers/vfio/vfio_iommu_common.c
 create mode 100644 drivers/vfio/vfio_iommu_common.h
 create mode 100644 drivers/vfio/vfio_iommu_fsl_pamu.c
