Return-Path: <R65777@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe001.messaging.microsoft.com [216.32.180.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C985D2C0359
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Oct 2013 22:34:55 +1100 (EST)
From: Bharat Bhushan <r65777@freescale.com>
To: <alex.williamson@redhat.com>, <joro@8bytes.org>,
 <galak@kernel.crashing.org>, <scottwood@freescale.com>,
 <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-pci@vger.kernel.org>, <agraf@suse.de>, <stuart.yoder@freescale.com>
Subject: [PATCH 0/5 RFC] vfio/pci: add interface to for MSI support with FSL
 PAMU
Date: Tue, 29 Oct 2013 16:57:42 +0530
Message-ID: <1383046062-16520-6-git-send-email-Bharat.Bhushan@freescale.com>
In-Reply-To: <1383046062-16520-1-git-send-email-Bharat.Bhushan@freescale.com>
References: <1383046062-16520-1-git-send-email-Bharat.Bhushan@freescale.com>
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

So first four patches are for defining the interface to get:
  - Number of MSI regions (which is number of MSI banks for powerpc)
  - MSI-region address range: Physical page which have the
    address/addresses used for generating MSI interrupt
    and size of the page.

Last Patch is for setting up MSI iova-base for vfio devices assigned
in msi subsystem, so that when msi-message will be composed then this
configured iova will be used. Earlier we were using iommu interface
for getting the configured iova which was not currect and
Alex Williamson suggeested this type of interface.

Bharat Bhushan (5):
  pci:msi: add weak function for returning msi region info
  powerpc: pci: Add arch specific msi region interface
  powerpc: msi: Extend the msi region interface to get info from
    fsl_msi
  pci: msi: expose msi region information functions
  vfio: setup iova-base for msi interrupts for vfio assigned device

 arch/powerpc/include/asm/machdep.h |   10 ++++
 arch/powerpc/kernel/msi.c          |   28 ++++++++++
 arch/powerpc/sysdev/fsl_msi.c      |  106 ++++++++++++++++++++++++++++++++++--
 arch/powerpc/sysdev/fsl_msi.h      |   19 ++++++-
 drivers/pci/msi.c                  |   34 ++++++++++++
 include/linux/msi.h                |   14 +++++
 include/linux/pci.h                |   21 +++++++
 7 files changed, 223 insertions(+), 9 deletions(-)
