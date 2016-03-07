Return-Path: <codrin.ciubotariu@nxp.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0081.outbound.protection.outlook.com [207.46.100.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B33C11A011D
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Mar 2016 02:50:30 +1100 (AEDT)
From: Codrin Ciubotariu <codrin.ciubotariu@nxp.com>
To: <iommu@lists.linux-foundation.org>
CC: <scottwood@freescale.com>, <Varun.Sethi@freescale.com>,
 <linuxppc-dev@lists.ozlabs.org>, Codrin Ciubotariu
 <codrin.ciubotariu@nxp.com>
Subject: [PATCH 0/7] PAMU driver update
Date: Mon, 7 Mar 2016 17:34:16 +0200
Message-ID: <1457364863-18004-1-git-send-email-codrin.ciubotariu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patchset addresses a few issues found on PAMU IOMMU
and small changes to enable power management and to support the
L3 cache controller on some newer boards.

The series starts with a clean-up patch, followed by two
errata fixes: A-007907 and A-005982. It continues with
two fixes for PCIe support. The last two patches add support
for power management and compatible strings for new L3 controller
device-tree nodes.

Codrin Ciubotariu (2):
  iommu/fsl: Fix most checkpatch warnings and typos
  iommu/fsl: Work around erratum A-007907

Varun Sethi (5):
  iommu/fsl: Enable OMT cache, before invalidating PAACT and SPAACT
    cache
  iommu/fsl: Factor out PCI specific code
  iommu/fsl: Enable default DMA window for PCIe devices once detached
    from domain
  iommu/fsl: PAMU power management support
  iommu/fsl: Added cache controller compatible strings for SOCs

 drivers/iommu/fsl_pamu.c        | 322 ++++++++++++++++++++++++++++++++--------
 drivers/iommu/fsl_pamu.h        |  30 ++--
 drivers/iommu/fsl_pamu_domain.c | 160 +++++++++++++-------
 drivers/iommu/fsl_pamu_domain.h |   2 +-
 4 files changed, 381 insertions(+), 133 deletions(-)

-- 
1.9.3
